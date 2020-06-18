local Keys = {
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

local first = true
ESX = nil
local tphim = false

PlayerData = {}

local jailTime = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData() == nil do
		
		Citizen.Wait(10)
	end
	
	if first then
		ESX.SetPlayerData('jailed',0)
		ESX.SetPlayerData('bjail',0)
		TriggerServerEvent("esx-qalle-jail:changeJailStatusServerSided", false)
		first = false
	end
	PlayerData = ESX.GetPlayerData()

	LoadTeleporters()
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(newData)
	PlayerData = newData

	Citizen.Wait(10000)

	ESX.TriggerServerCallback("esx-qalle-jail:retrieveJailTime", function(inJail, newJailTime, solitary, cell)
		if inJail then

			ESX.SetPlayerData('jailed',1)
			TriggerServerEvent("esx-qalle-jail:changeJailStatusServerSided", true)

			if solitary == true and cell ~= "nil" then

				jailTime = newJailTime
				local jail = tostring(cell)

				changeClothes()
				JailLogin(jail)
				TriggerServerEvent("esx-qalle-jail:updateSolitaryStatus", true)
				ESX.SetPlayerData('bjail',0)
			
			elseif solitary == false and cell ~= "nil" then

				jailTime = newJailTime
				local jail = tostring(cell)

				changeClothes()
				JailLogin(jail)
				TriggerServerEvent("esx-qalle-jail:updateBjailStatus", true)
				ESX.SetPlayerData('bjail',1)
			
			elseif solitary == false and cell == "nil" then

				jailTime = newJailTime

				changeClothes()
				JailLogin()
				ESX.SetPlayerData('bjail',0)

			else

				print('Exception! please contact to admin!')

			end

		else

			TriggerServerEvent("esx-qalle-jail:changeJailStatusServerSided", false)
			
		end
	end)
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(response)
	PlayerData["job"] = response
end)

RegisterNetEvent("esx-qalle-jail:openJailMenu")
AddEventHandler("esx-qalle-jail:openJailMenu", function()
	OpenJailMenu()
end)

RegisterNetEvent("esx-qalle-jail:jailPlayer")
AddEventHandler("esx-qalle-jail:jailPlayer", function(newJailTime, type, cell)
	TriggerEvent("esx_policejob:removeHandcuffFull")
	ESX.SetPlayerData('jailed',1)
	TriggerServerEvent("esx-qalle-jail:changeJailStatusServerSided", true)
	if type == 1 then

		jailTime = newJailTime
		ESX.SetPlayerData('bjail',1)
		InJail(cell, true)


	elseif type == 2 then

		jailTime = newJailTime
		Cutscene()

	end

end)

RegisterNetEvent("esx-qalle-jail:unJailPlayer")
AddEventHandler("esx-qalle-jail:unJailPlayer", function()
	jailTime = 0

	UnJail()
end)

RegisterNetEvent("esx-qalle-jail:solitaryEffects")
AddEventHandler("esx-qalle-jail:solitaryEffects", function(SolitaryTime, Jail)

	jailTime = jailTime + SolitaryTime
	TriggerServerEvent("esx-qalle-jail:updateJailTime", jailTime)
	InJail(Jail, false)

end)



function removeweapons()
	
	local ped =  GetPlayerPed(-1)

	SetPedArmour(ped, 0)
	ClearPedBloodDamage(ped)
	ResetPedVisibleDamage(ped)
	ClearPedLastWeaponDamage(ped)
	RemoveAllPedWeapons(ped, true)

end

function JailLogin(jail)

	local ped = GetPlayerPed(-1)

	if ped ~= nil then
		removeweapons()
	else
		local jasem = true

		while jasem do

			local ped GetPlayerPed(-1)
			if ped ~= nil then
				jasem = false
				removeweapons()
			end

			Citizen.Wait(0)
		end

	end

				TriggerServerEvent("esx-qalle-jail:jobSet", source)

				ESX.ShowNotification("Akharin bar ke DC kardid too zendan boodid, bara hamin be zendan bazgashtid!")
				InJail(jail, true)

end

function UnJail()
	if ESX.GetPlayerData()['bjail'] == 1 then

		ESX.Game.Teleport(PlayerPedId(), Config.Teleport["PD"])
		TriggerServerEvent("esx-qalle-jail:updateBjailStatus", false)

	else

		ESX.Game.Teleport(PlayerPedId(), Config.Teleports["Boiling Broke"])

	end
	
	TriggerServerEvent("esx-qalle-jail:changeJailStatusServerSided", false)
	ESX.SetPlayerData('jailed',0)
	ESX.SetPlayerData('bjail',0)
	TriggerServerEvent('esx-qalle-jail:updateSolitary', false, nil)
	TriggerServerEvent("esx-qalle-jail:updateSolitaryStatus", false)

	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)

	ESX.ShowNotification("~g~~h~Shoma Azad Shodid!")
end

function JailTimer()

	Citizen.CreateThread(function()

		Citizen.Wait(60000)
		while jailTime > 0 do
			
			jailTime = jailTime - 1

			ESX.ShowNotification("Shoma ~r~" .. jailTime .. "~w~ Daghighe digar azad mishavid!")

			TriggerServerEvent("esx-qalle-jail:updateJailTime", jailTime)

			if jailTime == 0 then

					UnJail()
					TriggerServerEvent("esx-qalle-jail:updateJailTime", 0)
				
			end

			Citizen.Wait(60000)
		end

	end)

end


function InJail(jail, first)
		
		TriggerServerEvent("esx-qalle-jail:jobSet", source)
		if ESX.GetPlayerData()['aduty'] == 1 then
			TriggerEvent("OffDutyHandlerForJail", source)
		end
		if ESX.GetPlayerData()['cfix'] == 1 then
			TriggerEvent("miladify:resetcharForce", source, true)
		end
		Citizen.Wait(1500)
		changeClothes()
		local ped =  GetPlayerPed(-1)

		SetPedArmour(PlayerPedId(), 0)
		ClearPedBloodDamage(PlayerPedId())
		ResetPedVisibleDamage(PlayerPedId())
		ClearPedLastWeaponDamage(PlayerPedId())
		RemoveAllPedWeapons(PlayerPedId(), true)

	--Jail Timer--
	if first then
		JailTimer()
	end
	--Jail Timer--
	--Check if player is dead--
	Citizen.CreateThread(function()
		while jailTime > 0 do

			-- Check if player is dead then revive --
				if ESX.GetPlayerData()['IsDead'] == 1 then

					local health = GetEntityHealth(GetPlayerPed(-1))
					if health < 110 then
						TriggerEvent('esx_ambulancejob:revive', -1)
						tphim = true
					end

				end

			Citizen.Wait(500)
		end

	end)
	--Check if player is dead--

		local distance = 0
		local JailPosition = nil
		local canRun = false

		if jail == "jailone" then

			JailPosition = Config.JailPositions["Solitary"]
			distance = 5
			SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"] - 1)
			canRun = true

		elseif jail == "jailtwo" then

			JailPosition = Config.JailPositions["Solitarytwo"]
			distance = 5
			SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"] - 1)
			canRun = true

		elseif jail == "jailthree" then

			JailPosition = Config.JailPositions["Solitarythree"]
			distance = 5
			SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"] - 1)
			canRun = true
		
		elseif jail == "jailfour" then

			JailPosition = Config.JailPositions["Solitaryfour"]
			distance = 5
			SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"] - 1)
			canRun = true
		
		elseif jail == "bjailone" then

			JailPosition = Config.JailPositions["bjailone"]
			distance = 3
			SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"] - 1)
			canRun = true

		elseif jail == "bjailtwo" then

			JailPosition = Config.JailPositions["bjailtwo"]
			distance = 3
			SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"] - 1)
			canRun = true

		elseif jail == "bjailthree" then

			JailPosition = Config.JailPositions["bjailthree"]
			distance = 3
			SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"] - 1)
			canRun = true
		
		elseif jail == "bjailfour" then

			JailPosition = Config.JailPositions["bjailfour"]
			distance = 3
			SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"] - 1)
			canRun = true
		
		elseif jail == "bjailfive" then

			JailPosition = Config.JailPositions["bjailfive"]
			distance = 3
			SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"] - 1)
			canRun = true


		else

			JailPosition = Config.JailPositions["Cell"]
			distance = 100
			SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"] - 1)
			ESX.SetPlayerData('bjail',0)
			canRun = true

		end

	--Check Coordinates and disbale hot keys--
    Citizen.CreateThread(function()

		while jailTime > 0 do
			
			if canRun then

				DisableControlAction(0, Keys['F1'],true)
				DisableControlAction(0, Keys['F3'],true)
				DisableControlAction(0, Keys['F5'],true)
				DisableControlAction(0, Keys['R'], true)
				DisableControlAction(0, Keys[','], true)
				DisableControlAction(0, 24, true) -- Attack
				DisableControlAction(0, 257, true) -- Attack 2
				DisableControlAction(0, 25, true) -- Right click
				DisableControlAction(0, 47, true)  -- Disable weapon
				DisableControlAction(0, 264, true) -- Disable melee
				DisableControlAction(0, 257, true) -- Disable melee
				DisableControlAction(0, 140, true) -- Disable melee
				DisableControlAction(0, 141, true) -- Disable melee
				DisableControlAction(0, 142, true) -- Disable melee
				DisableControlAction(0, 143, true) -- Disable melee
				DisableControlAction(0, 263, true) -- Melee Attack 1
				DisableControlAction(0, 27, true) -- Arrow up

				-- end of that fucking shit --
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), JailPosition.x, JailPosition.y, JailPosition.z) > distance then
					ESX.Game.Teleport(PlayerPedId(), JailPosition)
					ESX.ShowNotification("~r~~h~Shoma nemitavanid az zendan farar konid.")
				end

				if tphim then
				
					tphim = false
					Citizen.Wait(1000)
					ESX.Game.Teleport(PlayerPedId(), JailPosition)

				end

			end

			Citizen.Wait(0)
		end

	end)
	--Check Coordinates and disbale hot keys--

	--Prison Work--

	Citizen.CreateThread(function()
		while jailTime > 0 do
			
			local sleepThread = 500

			local Packages = Config.PrisonWork["Packages"]

			local Ped = PlayerPedId()
			local PedCoords = GetEntityCoords(Ped)

			for posId, v in pairs(Packages) do

				local DistanceCheck = GetDistanceBetweenCoords(PedCoords, v["x"], v["y"], v["z"], true)

				if DistanceCheck <= 10.0 then

					sleepThread = 5

					local PackageText = "Pack"

					if not v["state"] then
						PackageText = "Already Taken"
					end

					ESX.Game.Utils.DrawText3D(v, "[E] " .. PackageText, 0.4)

					if DistanceCheck <= 1.5 then

						if IsControlJustPressed(0, 38) then

							if v["state"] then
								PackPackage(posId)
							else
								ESX.ShowNotification("Shoma ghablan in package ro borde boodid")
							end

						end

					end

				end

			end

			Citizen.Wait(sleepThread)

		end 
	end)

	--Prison Work--

end

Citizen.CreateThread(function()
	
	while true do
		
		if jailTime > 0 then
			DisableControlAction(2, Keys['F1'], true)
			Citizen.Wait(0)
		else
			Citizen.Wait(1000)
		end
	
	end

end)

function LoadTeleporters()
	Citizen.CreateThread(function()
		while true do
			
			local sleepThread = 500

			local Ped = PlayerPedId()
			local PedCoords = GetEntityCoords(Ped)

			for p, v in pairs(Config.Teleports) do

				local DistanceCheck = GetDistanceBetweenCoords(PedCoords, v["x"], v["y"], v["z"], true)

				if DistanceCheck <= 7.5 then

					sleepThread = 5

					ESX.Game.Utils.DrawText3D(v, "[E] baraye baz kardan e dar", 0.4)

					if DistanceCheck <= 1.0 then
						if IsControlJustPressed(0, 38) then
							TeleportPlayer(v)
						end
					end
				end
			end

			Citizen.Wait(sleepThread)

		end
	end)
end

function PackPackage(packageId)
	local Package = Config.PrisonWork["Packages"][packageId]

	LoadModel("prop_cs_cardbox_01")

	local PackageObject = CreateObject(GetHashKey("prop_cs_cardbox_01"), Package["x"], Package["y"], Package["z"], true)

	PlaceObjectOnGroundProperly(PackageObject)

	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, false)

	local Packaging = true
	local StartTime = GetGameTimer()

	while Packaging do
		
		Citizen.Wait(1)

		local TimeToTake = 60000 * 1.20 -- Minutes
		local PackPercent = (GetGameTimer() - StartTime) / TimeToTake * 100

		if not IsPedUsingScenario(PlayerPedId(), "PROP_HUMAN_BUM_BIN") then
			DeleteEntity(PackageObject)

			ESX.ShowNotification("Canceled!")

			Packaging = false
		end

		if PackPercent >= 100 then

			Packaging = false

			DeliverPackage(PackageObject)

			Package["state"] = false
		else
			ESX.Game.Utils.DrawText3D(Package, "Packaging... " .. math.ceil(tonumber(PackPercent)) .. "%", 0.4)
		end
		
	end
end

function DeliverPackage(packageId)
	if DoesEntityExist(packageId) then
		AttachEntityToEntity(packageId, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)

		ClearPedTasks(PlayerPedId())
	else
		return
	end

	local Packaging = true

	LoadAnim("anim@heists@box_carry@")

	while Packaging do

		Citizen.Wait(5)

		if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
			TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
		end

		if not IsEntityAttachedToEntity(packageId, PlayerPedId()) then
			Packaging = false
			DeleteEntity(packageId)
		else
			local DeliverPosition = Config.PrisonWork["DeliverPackage"]
			local PedPosition = GetEntityCoords(PlayerPedId())
			local DistanceCheck = GetDistanceBetweenCoords(PedPosition, DeliverPosition["x"], DeliverPosition["y"], DeliverPosition["z"], true)

			ESX.Game.Utils.DrawText3D(DeliverPosition, "[E] Leave Package", 0.4)

			if DistanceCheck <= 2.0 then
				if IsControlJustPressed(0, 38) then
					DeleteEntity(packageId)
					ClearPedTasksImmediately(PlayerPedId())
					Packaging = false

					TriggerServerEvent("esx-qalle-jail:prisonWorkReward")
				end
			end
		end

	end

end

function OpenJailMenu()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'jail_prison_menu',
		{
			title    = "Menu ye zendan",
			align    = 'center',
			elements = {
				{ label = "Jail Closest Person", value = "jail_closest_player" },
				{ label = "Unjail Person", value = "unjail_player" }
			}
		}, 
	function(data, menu)

		local action = data.current.value

		if action == "jail_closest_player" then

			menu.close()

			ESX.UI.Menu.Open(
          		'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
          		{
            		title = "Zaman e zendan(be daghighe)"
          		},
          	function(data2, menu2)

            	local jailTime = tonumber(data2.value)

            	if jailTime == nil then
              		ESX.ShowNotification("The time needs to be in minutes!")
				else
					if jailTime <= 60 then
              		menu2.close()

              		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

              		if closestPlayer == -1 or closestDistance > 3.0 then
                		ESX.ShowNotification("Hich kas nazdik nist!")
					else
						ESX.UI.Menu.Open(
							'dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',
							{
							  title = "Dalil zendan"
							},
						function(data3, menu3)
		  
						  	local reason = data3.value
		  
						  	if reason == nil then
								ESX.ShowNotification("Bayad dalil bezarid")
						  	else
								menu3.close()
		  
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		  
								if closestPlayer == -1 or closestDistance > 3.0 then
								  	ESX.ShowNotification("Kasi nazdik nist!")
								else

									ESX.UI.Menu.Open(
										'dialog', GetCurrentResourceName(), 'jail_choose_place_menu',
										{
										  title = "Entekhab Makan Zendan"
										},
									function(data4, menu4)
					  
										  local place = data4.value
					  
										  if place == nil then
											ESX.ShowNotification("Bayad dalil bezarid")
										  else
											menu3.close()
					  
											local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					  
											if closestPlayer == -1 or closestDistance > 3.0 then
												  ESX.ShowNotification("Kasi nazdik nist!")
											else

												if place == "jail" or place == "prison" then

													if place == "jail" then
														local type = 1
														  TriggerServerEvent("esx-qalle-jail:jailPlayer", GetPlayerServerId(closestPlayer), jailTime, type, reason, true)
														  menu4.close()
													elseif place == "prison" then
														local type = 2
														  TriggerServerEvent("esx-qalle-jail:jailPlayer", GetPlayerServerId(closestPlayer), jailTime, type, reason, true)
														  menu4.close()
													end

												else
													ESX.ShowNotification("Makan mored nazar namaloom ast!")
												end
											end
					  
										  end
					  
									end, function(data4, menu4)
										menu4.close()
									end)

								end
		  
						  	end
		  
						end, function(data3, menu3)
							menu3.close()
						end)
					  end
					else
						ESX.ShowNotification("Zaman zendan nemitavand bishtar az 60 daghighe bashad")
					end

				end

          	end, function(data2, menu2)
				menu2.close()
			end)
		elseif action == "unjail_player" then

			local elements = {}

			ESX.TriggerServerCallback("esx-qalle-jail:retrieveJailedPlayers", function(playerArray)

				if #playerArray == 0 then
					ESX.ShowNotification("Zendan e shoma khalist")
					return
				end

				for i = 1, #playerArray, 1 do
					table.insert(elements, {label = "Zendani: " .. playerArray[i].name .. " | Zaman e zendan: " .. playerArray[i].jailTime .. " daghighe", value = playerArray[i].identifier })
				end

				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'jail_unjail_menu',
					{
						title = "Azad kardan az zendan",
						align = "center",
						elements = elements
					},
				function(data2, menu2)

					local action = data2.current.value

					TriggerServerEvent("esx-qalle-jail:unJailPlayer", action, true)

					menu2.close()

				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		end

	end, function(data, menu)
		menu.close()
	end)

end