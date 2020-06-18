Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118

}

local FirstSpawn, PlayerLoaded, inCapture = true, false, false
IsDead, InJure, beingRevived = false, false , false
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx_ambulancejob:ReviveIfDead')
AddEventHandler('esx_ambulancejob:ReviveIfDead', function()
	if IsDead or InJure then
		IsDead, InJure = false, false
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		TriggerServerEvent('esx_ambulancejob:setDeathStatus',"Dead", false)
		Citizen.CreateThread(function()
			DoScreenFadeOut(800)
			while not IsScreenFadedOut() do
				Citizen.Wait(50)
			end
			local formattedCoords = {
				x = ESX.Math.Round(coords.x, 1),
				y = ESX.Math.Round(coords.y, 1),
				z = ESX.Math.Round(coords.z, 1)
			}
			ESX.SetPlayerData('lastPosition', formattedCoords)
			TriggerServerEvent('esx:updateLastPosition', formattedCoords)
			RespawnPed(playerPed, formattedCoords, 0.0)
			StopScreenEffect('DeathFailOut')
			DoScreenFadeIn(800)
		end)
	end
end)

AddEventHandler('playerSpawned', function()
    while FirstSpawn do 
	   Citizen.Wait(1000)
		if FirstSpawn and not IsPlayerSwitchInProgress() then
			FirstSpawn = false
			IsDead = false
			exports.spawnmanager:setAutoSpawn(false) -- disable respawn
		ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(Dead)
			if Dead[1].InJure or Dead[1].IsDead and Config.AntiCombatLog then
				while not PlayerLoaded do
					Citizen.Wait(1000)
				end
				ESX.ShowNotification(_U('combatlog_message'))
				RemoveItemsAfterRPDeath()
			end
		 end)
	   end
    end
end)
-- Create blips
Citizen.CreateThread(function()
	print(ESX.GetPlayerData().IsDead)
	for k,v in pairs(Config.Hospitals) do
		local blip = AddBlipForCoord(v.Blip.coords)
		SetBlipSprite(blip, v.Blip.sprite)
		SetBlipScale(blip, v.Blip.scale)
		SetBlipColour(blip, v.Blip.color)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('hospital'))
		EndTextCommandSetBlipName(blip)
	end
end)

function StartDeathAnim(ped, coords, heading)
	local animDict = 'missfbi5ig_0'
	local animName = 'lyinginpain_loop_steve'
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	SetPlayerHealthRechargeMultiplier(PlayerId(-1), 0.0)
	SetEntityHealth(ped, 150)
	ESX.Streaming.RequestAnimDict(animDict, function()
		TaskPlayAnim(ped, animDict, animName, 8.0, 0, -1, 1, 1.0, 0, 0, 0)
	end)
	ESX.UI.Menu.CloseAll()
end

function OnPlayerDeath(deathCause)
	if not ESX.GetPlayerData().IsDead then
		InJure = true
		ESX.SetPlayerData('IsDead', true)
		local playerPed = PlayerPedId()
		local ped = GetPlayerPed(-1)
		local coords = GetEntityCoords(ped)
		local heading = GetEntityHeading(ped)
		local formattedCoords = {
			x = ESX.Math.Round(coords.x, 1),
			y = ESX.Math.Round(coords.y, 1),
			z = ESX.Math.Round(coords.z, 1) - 1
		}
		Wait(2000)
		StartDeathAnim(playerPed, formattedCoords, heading)
		TriggerServerEvent('esx_ambulancejob:setDeathStatus',"Injure", true)
		StartDistressSignal()
		StartBleading()
		StartScreenEffect('DeathFailOut', 0, true)
		ESX.UI.Menu.CloseAll()

		Citizen.CreateThread(function()
			while InJure do
				Wait(0)
				DisableControlAction(0, Keys['F1'],true)
				DisableControlAction(0, Keys['F2'],true)
				DisableControlAction(0, Keys['F3'],true)
				DisableControlAction(0, Keys['F5'],true)
				DisableControlAction(0, Keys['F6'],true)
				DisableControlAction(0, Keys['R'], true)
				DisableControlAction(0, Keys['W'],true)
				DisableControlAction(0, Keys['S'],true)
				DisableControlAction(0, Keys['A'],true)
				DisableControlAction(0, Keys['D'], true)
				DisableControlAction(0, Keys['SPACE'], true)
				DisableControlAction(0, Keys['TAB'], true)
				DisableControlAction(0, Keys['X'], true)
				DisableControlAction(0, Keys['M'], true)
				DisableControlAction(0, 24, true) -- Attack
				DisableControlAction(0, 257, true) -- Attack 2
				DisableControlAction(0, 25, true) -- Right click
				DisableControlAction(0, 264, true) -- Disable melee
				DisableControlAction(0, 257, true) -- Disable melee
				DisableControlAction(0, 140, true) -- Disable melee
				DisableControlAction(0, 141, true) -- Disable melee
				DisableControlAction(0, 142, true) -- Disable melee
				DisableControlAction(0, 143, true) -- Disable melee
				DisableControlAction(0, 263, true) -- Melee Attack 1
				DisableControlAction(0, 27, true) -- Arrow up

			end
		end)

		Citizen.CreateThread(function()
			local active_timeout = false
			while InJure do
				local stopped = IsPedStopped(GetPlayerPed(-1))
				if stopped == false then
					if beingRevived then
						if not active_timeout then
							active_timeout = true
							SetTimeout(15 * 1000 * 60, function()
								beingRevived = false
								active_timeout = false
							end)
						end
					else
						StartDeathAnim(playerPed, formattedCoords, heading)
					end
				end
				Citizen.Wait(100)
			end
			return
		end)
	else
		InJure = false
		IsDead = true
		TriggerServerEvent('esx_ambulancejob:setDeathStatus',"Dead", true)
		ESX.SetPlayerData('IsDead', -1)
		StartDeathTimer()
		Citizen.CreateThread(function()
			while IsDead do
				Wait(0)
				DisableAllControlActions(0)
				EnableControlAction(0, Keys['G'], true)
				EnableControlAction(0, Keys['T'], true)
				EnableControlAction(0, Keys['E'], true)
			end
		end)
	end
end

RegisterNetEvent('esx_ambulancejob:useItem')
AddEventHandler('esx_ambulancejob:useItem', function(itemName)
	ESX.UI.Menu.CloseAll()
	if itemName == 'medikit' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()
		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end
			TriggerEvent('esx_ambulancejob:heal', 'big', true)
			ESX.ShowNotification(_U('used_medikit'))
		end)
		
	elseif itemName == 'bandage' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()
		
		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end
			TriggerEvent('esx_ambulancejob:heal', 'small', true)
			ESX.ShowNotification(_U('used_bandage'))
		end)
	end
end)

function StartDistressSignal()
	Citizen.CreateThread(function()
		local timer = Config.BleedoutTimer
		while timer > 0 and InJure do
			Citizen.Wait(2)
			timer = timer - 30
			SetTextFont(4)
			SetTextScale(0.45, 0.45)
			SetTextColour(185, 185, 185, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			BeginTextCommandDisplayText('STRING')
			AddTextComponentSubstringPlayerName(_U('distress_send'))
			EndTextCommandDisplayText(0.175, 0.805)
			if IsControlPressed(0, Keys['G']) then
				SendDistressSignal()
				Citizen.CreateThread(function()
					Citizen.Wait(1000 * 60 * 5)
					if InJure then
						StartDistressSignal()
					end
				end)
				break
			end
		end
	end)
end

function SendDistressSignal()
	local playerPed = PlayerPedId()
	PedPosition		= GetEntityCoords(playerPed)
	local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
	ESX.ShowNotification(_U('distress_sent'))
    TriggerServerEvent('esx_addons_gcphone:startCall', 'ambulance', _U('distress_message'), PlayerCoords, {
		PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
	})
end

function DrawGenericTextThisFrame()
	SetTextFont(4)
	SetTextScale(0.0, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
end

function secondsToClock(seconds)
	local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

	if seconds <= 0 then
		return 0, 0
	else
		local hours = string.format("%02.f", math.floor(seconds / 3600))
		local mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
		local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))

		return mins, secs
	end
end

function StartBleading()
	local bleedingTimer = ESX.Math.Round(Config.EarlyRespawnTimer / 1000)

	Citizen.CreateThread(function()
		-- bleedout timer
		while bleedingTimer > 0 and InJure do
			Citizen.Wait(1000)
			bleedingTimer = bleedingTimer - 1
		end
		if bleedingTimer < 1 then
			OnPlayerDeath(-1)
		end
	end)

	Citizen.CreateThread(function()
		local text
		while bleedingTimer > 0 and InJure do
			Citizen.Wait(0)
			text = _U('respawn_available_in', secondsToClock(bleedingTimer))
			DrawGenericTextThisFrame()
			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
		end
	end)
end

function StartDeathTimer()
	local DeathTimer = ESX.Math.Round(Config.BleedoutTimer / 1000)
	local DeathIsReal = false
	Citizen.CreateThread(function()
		while DeathTimer > 0 and IsDead do
			Citizen.Wait(1000)
			DeathTimer = DeathTimer - 1
			DeathIsReal = true
		end
		if DeathTimer <= 0 and DeathIsReal then
		    RemoveItemsAfterRPDeath()
		end
	end)

	Citizen.CreateThread(function()
		local text
		while DeathTimer > 0 and IsDead do
			Citizen.Wait(0)
			text = _U('respawn_bleedout_in', secondsToClock(DeathTimer))
			DrawGenericTextThisFrame()
			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
		end
	end)
end



function RemoveItemsAfterRPDeath()
	IsDead = false
	ESX.SetPlayerData('IsDead', false)
	TriggerServerEvent('esx_ambulancejob:setDeathStatus',"Dead", false)
	Citizen.CreateThread(function()
		DoScreenFadeOut(800)
		while not IsScreenFadedOut() do
			Citizen.Wait(80)
		end
		ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()
			local formattedCoords = {
				x = Config.RespawnPoint.coords.x,
				y = Config.RespawnPoint.coords.y,
				z = Config.RespawnPoint.coords.z
			}
			ESX.SetPlayerData('lastPosition', formattedCoords)
			ESX.SetPlayerData('loadout', {})
			TriggerServerEvent('esx:updateLastPosition', formattedCoords)
			RespawnPed(PlayerPedId(), formattedCoords, Config.RespawnPoint.heading)
			StopScreenEffect('DeathFailOut')
			DoScreenFadeIn(800)
		end)
	end)
end



function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(ped)
    SetEntityHealth(ped, 200)
	ESX.UI.Menu.CloseAll()
end

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = 'Ambulance',
		number     = 'ambulance',
		base64Icon = 'data:image/png;base64,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'

	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

AddEventHandler('capture:inCapture', function(bool)

	inCapture = bool
	
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	if inCapture then
		local formattedCoords = {
			x = Config.RespawnPoint.coords.x,
			y = Config.RespawnPoint.coords.y,
			z = Config.RespawnPoint.coords.z
		}
		ESX.SetPlayerData('lastPosition', formattedCoords)
		TriggerServerEvent('esx:updateLastPosition', formattedCoords)
		RespawnPed(PlayerPedId(), formattedCoords, 206.36)
		TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(source))
		StopScreenEffect('DeathFailOut')
		DoScreenFadeIn(800)
	else
		OnPlayerDeath()
	end
end)

RegisterNetEvent('esx_ambulancejob:VreviveC')
AddEventHandler('esx_ambulancejob:VreviveC', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	IsDead = false
	InJure = false
	TriggerServerEvent('esx_ambulancejob:setDeathStatus',"Dead", false)
	ESX.SetPlayerData('IsDead', false)
	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(50)
		end

		local formattedCoords = {
			x = ESX.Math.Round(coords.x, 1),
			y = ESX.Math.Round(coords.y, 1),
			z = ESX.Math.Round(coords.z, 1)
		}

		ESX.SetPlayerData('lastPosition', formattedCoords)

		TriggerServerEvent('esx:updateLastPosition', formattedCoords)

		RespawnPed(playerPed, formattedCoords, 0.0)

		StopScreenEffect('DeathFailOut')
		
		DoScreenFadeIn(800)
	end)
end)

-- Load unloaded IPLs

if Config.LoadIpl then
	Citizen.CreateThread(function()
		RequestIpl('Coroner_Int_on') -- Morgue
	end)
end