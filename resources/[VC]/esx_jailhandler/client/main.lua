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

ESX = nil

local PlayerData              = {}
local BlipList                = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local canchange = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)	

AddEventHandler('esx_jailhandler:hasEnteredMarker', function(zone)
	CurrentAction     = 'jail_action'
	CurrentActionMsg  = _U('press_access')
	CurrentActionData = {}
end)

AddEventHandler('esx_jailhandler:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

RegisterNetEvent('esx_jailhandler:statusHandler')
AddEventHandler('esx_jailhandler:statusHandler', function(status)
	canchange = status
end)

-- Draw Markers
Citizen.CreateThread(function()
	while true do
		 Citizen.Wait(0)
		 if canchange then

				local coords = GetEntityCoords(PlayerPedId())
				local canSleep = true

				for k,v in pairs(Config.Zones) do
					if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
						canSleep = false
						DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
					end
				end
				
				if canSleep then
					Citizen.Wait(500)
				end
		
			end
	end
end)

-- Activate Menu when in Markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(200)
		if canchange then

				local coords      = GetEntityCoords(PlayerPedId())
				local isInMarker  = false
				local currentZone = nil

				for k,v in pairs(Config.Zones) do
					if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x then
						isInMarker  = true
						currentZone = k
					end
				end

				if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
					HasAlreadyEnteredMarker = true
					LastZone                = currentZone
					TriggerEvent('esx_jailhandler:hasEnteredMarker', currentZone)
				end

				if not isInMarker and HasAlreadyEnteredMarker then
					HasAlreadyEnteredMarker = false
					TriggerEvent('esx_jailhandler:hasExitedMarker', LastZone)
				end
				
				if not isInMarker then
					Citizen.Wait(500)
				end
		end
	end	
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) then
				if CurrentAction == 'jail_action' then
					TriggerEvent('skinchanger:getSkin', function(skin)
						--  male
							   if skin.sex == 0 then
								 local clothesSkin = {
								 ['tshirt_1'] = 15, ['tshirt_2'] = 0,
								 ['bproof_1'] = 0,  ['bproof_2'] = 0,
								 ['mask_1'] = 0,   ['mask_2'] = 0,
								 ['helmet_1'] = -1,  ['helmet_2'] = 0,
								 ['bags_1'] = -1,  ['bags_2'] = 0,
								 ['decals_1'] = 0,   ['decals_2'] = 0,
								 ['chain_1'] = 0,    ['chain_2'] = 0,
								 ['torso_1'] = 5, ['torso_2'] = 0,
								 ['arms'] = 5,
								 ['pants_1'] = 9, ['pants_2'] = 4,
								 ['shoes_1'] = 42, ['shoes_2'] = 2,
								 }
								 TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
						--  female
							   elseif skin.sex == 1 then
								 local clothesSkin = {
								 ['tshirt_1'] = 15, ['tshirt_2'] = 0,
								 ['bproof_1'] = 0,  ['bproof_2'] = 0,
								 ['mask_1'] = 0,   ['mask_2'] = 0,
								 ['helmet_1'] = -1,  ['helmet_2'] = 0,
								 ['bags_1'] = -1,  ['bags_2'] = 0,
								 ['decals_1'] = 0,   ['decals_2'] = 0,
								 ['chain_1'] = 0,    ['chain_2'] = 0,
								 ['torso_1'] = 4, ['torso_2'] = 12,
								 ['arms'] = 4,
								 ['pants_1'] = 5, ['pants_2'] = 15,
								 ['shoes_1'] = 81, ['shoes_2'] = 23,
								 }
								 TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
							 end
						end)
						canchange = false
						ESX.ShowNotification("~g~Lebas shoma ba movafaghiat avaz shod!")
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)


RegisterNetEvent('esx_jailhandler:domugshot')
AddEventHandler('esx_jailhandler:domugshot', function()
	
	local PlayerPed = GetPlayerPed(-1)
		
		TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_PAPARAZZI", 0, true)
		
				TriggerEvent("mythic_progbar:client:progress", {
					name = "take_picture",
					duration = 15000,
					label = "Dar hale gereftan aks",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					},
				}, function(status)
					if not status then

					ClearPedTasksImmediately(playerPed)
					
			
					ESX.ShowNotification("~g~Mugshot gerefte shod")
			
					elseif status then

					ClearPedTasksImmediately(playerPed)

					end
				end)


end)

TriggerEvent('chat:removeSuggestion', '/mug')
TriggerEvent('chat:addSuggestion', '/mug', 'Jahat aks gereftan', {
})

TriggerEvent('chat:removeSuggestion', '/pj')
TriggerEvent('chat:addSuggestion', '/pj', 'Avaz kardan vaizat poshidan lebas', {
  { name="ID", help="ID player mored nazar" },
  { name="Status", help="true/false" }
})