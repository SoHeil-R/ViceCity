ESX = nil
CurrentAction = nil
CurrentActionMsg = nil
CurrentActionData = nil
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

AddEventHandler('esx_ambulancejob:hasEnteredMarker2', function(zone)

	if zone == "deletevehicle" then

		CurrentAction     = 'delete_vehicle'
		CurrentActionMsg  = "Dokme ~INPUT_CONTEXT~ ro feshar bedid ta vasile naghlie ro park konid"
		CurrentActionData = {zone = zone}

	end

end)

AddEventHandler('esx_ambulancejob:hasExitedMarker2', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == "ambulance" then
            local coords = GetEntityCoords(PlayerPedId())

            for k,v in pairs(Config.Zones) do
                for i = 1, #v.Pos, 1 do
                    if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < Config.DrawDistance) then
                        DrawMarker(Config.Type, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
                    end
                end
            end
        end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == "ambulance" then
            local coords      = GetEntityCoords(PlayerPedId())
            local isInMarker  = false
            local currentZone = nil

            for k,v in pairs(Config.Zones) do
                for i = 1, #v.Pos, 1 do
                    if(GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < Config.Size.x) then
                        isInMarker  = true
                        currentZone = k
                        LastZone    = k
                    end
                end
            end
            if isInMarker and not HasAlreadyEnteredMarker then
                HasAlreadyEnteredMarker = true
                
                    TriggerEvent('esx_ambulancejob:hasEnteredMarker2', currentZone)

            end
            if not isInMarker and HasAlreadyEnteredMarker then
                HasAlreadyEnteredMarker = false
                TriggerEvent('esx_ambulancejob:hasExitedMarker2', LastZone)
            end
        end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) then
				if CurrentAction == 'delete_vehicle' then

					local ped = GetPlayerPed(-1)

					if IsPedSittingInAnyVehicle(ped) then

						local vehicle = GetVehiclePedIsIn(ped, false)
						ESX.Game.DeleteVehicle(vehicle)
						ESX.ShowNotification("Vasile naghlie shoma ba movafaghiat park shod")

					else

						ESX.ShowNotification("Shoma vasile naghlie nadarid")

					end

				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)