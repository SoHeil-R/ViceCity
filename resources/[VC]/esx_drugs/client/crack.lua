local spawnedCoca = 1
local cocaPlants = {}
local isPickingUp, isProcessing = false, false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.FieldZones.CocaineField.coords, true) < 30 then
			TriggerEvent('esx:showNotification', _U('cocaine_field_close'))
			SpawnCocaPlants()
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

		if GetDistanceBetweenCoords(coords, Config.ProcessZones.CocaineProcessing.coords, true) < 15 and GetDistanceBetweenCoords(coords, Config.ProcessZones.CocaineProcessing.coords, true) > 10 then
			ESX.ShowNotification(_U('cocaine_process_close'))
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #cocaPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(cocaPlants[i]), false) < 1 then
				nearbyObject, nearbyID = cocaPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) and not IsPedUsingAnyScenario(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('cocaine_pickupprompt'))
			end

			if IsControlJustReleased(0, 38) and not isPickingUp then
				

				ESX.TriggerServerCallback('esx_jk_drugs:canPickUp', function(canPickUp)

					if canPickUp then

						isPickingUp = true
						TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
						TriggerEvent("mythic_progbar:client:progress", {
							name = "harvest_crack",
							duration = 12000,
							label = "Bardasht Coca leaf",
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
		
								table.remove(cocaPlants, nearbyID)
								spawnedCoca = spawnedCoca - 1
		
								ClearPedTasks(playerPed)			
								ESX.Game.DeleteObject(nearbyObject)
		
								TriggerServerEvent('esx_jk_drugs:pickedUpCocaPlant')
		
								isPickingUp = false
					
							elseif status then

								ClearPedTasksImmediately(playerPed)
								isPickingUp = false

							end
						end)  

					else
						ESX.ShowNotification(_U('cocaine_inventoryfull'))
					end
				end, 'cocaine')

			end
		else
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(cocaPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnCocaPlants()
	while spawnedCoca < 10 do
		Citizen.Wait(0)
		local cocaCoords = GenerateCocaCoords()

		ESX.Game.SpawnLocalObject('prop_weed_02', cocaCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(cocaPlants, obj)
			spawnedCoca = spawnedCoca + 1
		end)
	end
end

function ValidateCocaCoord(plantCoord)
	if spawnedCoca > 0 then
		local validate = true

		for k, v in pairs(cocaPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.FieldZones.CocaineField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateCocaCoords()
	while true do
		Citizen.Wait(1)

		local cocaCoordX, cocaCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-90, 90)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-90, 90)

		cocaCoordX = Config.FieldZones.CocaineField.coords.x + modX
		cocaCoordY = Config.FieldZones.CocaineField.coords.y + modY

		local coordZ = GetCoordZ(cocaCoordX, cocaCoordY)
		local coord = vector3(cocaCoordX, cocaCoordY, coordZ)

		if ValidateCocaCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end
	return 43.0
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.ProcessZones.CrackProcessing.coords, true) < 15 and GetDistanceBetweenCoords(coords, Config.ProcessZones.CrackProcessing.coords, true) > 10 then
			ESX.ShowNotification(_U('crack_process_close'))
		end
	end
end)