ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function SetVehicleMaxMods(vehicle, turbo)

	local props = {}

		if turbo then

			props = {
				modEngine       =   3,
				modBrakes       =   2,
				windowTint      =   1,
				modArmor        =   4,
				modTransmission =   2,
				modSuspension   =   -1,
				modTurbo        =   true,
			}

		else

			props = {
				modEngine       =   3,
				modBrakes       =   2,
				windowTint      =   1,
				modArmor        =   4,
				modTransmission =   2,
				modSuspension   =   -1,
				modTurbo        =   false,
			}
			
		end
		ESX.Game.SetVehicleProperties(vehicle, props)

end


RegisterNetEvent('sf:spawnVehicle')
AddEventHandler('sf:spawnVehicle', function(model, turbo)

	if turbo then

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		ESX.Game.SpawnVehicle(model, coords, 90.0, function(vehicle)
			TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
			SetVehicleMaxMods(vehicle, true)
		
				TriggerEvent('chat:addMessage', {
					color = { 255, 0, 0},
					multiline = true,
					args = {"[SYSTEM]", "^2 " .. model .. "^0 ba ^3turbo ^0spawn shod!"}
				})

		end)

	else

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		ESX.Game.SpawnVehicle(model, coords, 90.0, function(vehicle)
			TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
			SetVehicleMaxMods(vehicle, false)
				local carModel = GetEntityModel(vehicle)
				local carName = GetDisplayNameFromVehicleModel(vehicle)
		
				TriggerEvent('chat:addMessage', {
					color = { 255, 0, 0},
					multiline = true,
					args = {"[SYSTEM]", "^2 " .. model .. "^0 spawn shod!"}
				})

		end)

	end

end)