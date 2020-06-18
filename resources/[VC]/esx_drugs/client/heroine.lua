local spawnedPoppy = 1
local poppyPlants = {}
local isPickingUp, isProcessing = false, false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.FieldZones.PoppyField.coords, true) < 45 then
			TriggerEvent('esx:showNotification', _U('opium_field_close'))
			SpawnPoppyPlants()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.ProcessZones.PoppyProcessing.coords, true) < 15 and GetDistanceBetweenCoords(coords, Config.ProcessZones.PoppyProcessing.coords, true) > 10 then
			ESX.ShowNotification(_U('opium_process_close'))
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #poppyPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(poppyPlants[i]), false) < 1 then
				nearbyObject, nearbyID = poppyPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) and not IsPedUsingAnyScenario(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('opium_pickupprompt'))
			end

			if IsControlJustReleased(0, 38) and not isPickingUp then

				ESX.TriggerServerCallback('esx_jk_drugs:canPickUp', function(canPickUp)

					if canPickUp then

						isPickingUp = true
						TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
						TriggerEvent("mythic_progbar:client:progress", {
							name = "harvest_poppy",
							duration = 20000,
							label = "Bardasht KhashKhaash",
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

							table.remove(poppyPlants, nearbyID)
							spawnedPoppy = spawnedPoppy - 1
	
							ClearPedTasks(playerPed)
							ESX.Game.DeleteObject(nearbyObject)
	
							TriggerServerEvent('esx_jk_drugs:pickedUpPoppy')
							isPickingUp = false
					
							elseif status then

								ClearPedTasksImmediately(playerPed)
								isPickingUp = false

							end
						end)

					else
						ESX.ShowNotification(_U('opium_inventoryfull'))
					end
				end, 'opium')
				isPickingUp = false
			end
		else
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(poppyPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnPoppyPlants()
	while spawnedPoppy < 10 do
		Citizen.Wait(0)
		local poppyCoords = GeneratePoppyCoords()

		ESX.Game.SpawnLocalObject('prop_plant_group_03', poppyCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(poppyPlants, obj)
			spawnedPoppy = spawnedPoppy + 1
		end)
	end
end

function ValidatePoppyCoord(plantCoord)
	if spawnedPoppy > 0 then
		local validate = true

		for k, v in pairs(poppyPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.FieldZones.PoppyField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GeneratePoppyCoords()
	while true do
		Citizen.Wait(1)

		local poppyCoordX, poppyCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-90, 90)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-90, 90)

		poppyCoordX = Config.FieldZones.PoppyField.coords.x + modX
		poppyCoordY = Config.FieldZones.PoppyField.coords.y + modY

		local coordZ = GetCoordZ(poppyCoordX, poppyCoordY)
		local coord = vector3(poppyCoordX, poppyCoordY, coordZ)

		if ValidatePoppyCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 115.0, 116.0, 117.0, 118.0, 119.0, 120.0, 121.0, 122.0, 123.0, 124.0, 125.0, 126., 127.0, 128.0, 129.0, 130.0, 131.0, 132.0, 133.0, 134.0, 135.0, 136.0, 137.0, 138.0, 139.0, 140.0, 141.0, 142.0, 143.0, 144.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end
	return 128.0
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.ProcessZones.HeroineProcessing.coords, true) < 15 and GetDistanceBetweenCoords(coords, Config.ProcessZones.HeroineProcessing.coords, true) > 10 then
			ESX.ShowNotification(_U('heroine_process_close'))
		end
	end
end)