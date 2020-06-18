local ind = {l = false, r = false}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local Sleep = true
		local Ped = GetPlayerPed(-1)
		if(IsPedInAnyVehicle(Ped)) and (not IsPauseMenuActive()) then
			local PedCar = GetVehiclePedIsIn(Ped, false)
			if PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped then
				Sleep = false

				-- Speed
				carSpeed = math.ceil(GetEntitySpeed(PedCar) * 3.6)
				SendNUIMessage({
					showhud = true,
					speed = carSpeed
				})

				if PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped then
					fuel = GetVehicleFuelLevel(PedCar)
					SendNUIMessage({
						showfuel = true,
						fuel = fuel
					})
				end

				-- Lights
				_,feuPosition,feuRoute = GetVehicleLightsState(PedCar)
				if(feuPosition == 1 and feuRoute == 0) then
					SendNUIMessage({
						feuPosition = true
					})
				else
					SendNUIMessage({
						feuPosition = false
					})
				end

				if(feuPosition == 1 and feuRoute == 1) then
					SendNUIMessage({
						feuRoute = true
					})
				else
					SendNUIMessage({
						feuRoute = false
					})
				end

				-- Turn signal
				-- SetVehicleIndicatorLights (1 left -- 0 right)
				local VehIndicatorLight = GetVehicleIndicatorLights(GetVehiclePedIsUsing(PlayerPedId()))
				if IsControlJustPressed(1, 190) then -- F9 is pressed
					ind.l = not ind.l
					SetVehicleIndicatorLights(GetVehiclePedIsUsing(GetPlayerPed(-1)), 0, ind.l)
				end
				if IsControlJustPressed(1, 189) then -- F10 is pressed
					ind.r = not ind.r
					SetVehicleIndicatorLights(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1, ind.r)
				end

				if(VehIndicatorLight == 0) then
					SendNUIMessage({
						clignotantGauche = false,
						clignotantDroite = false,
					})
				elseif(VehIndicatorLight == 1) then
					SendNUIMessage({
						clignotantGauche = true,
						clignotantDroite = false,
					})
				elseif(VehIndicatorLight == 2) then
					SendNUIMessage({
						clignotantGauche = false,
						clignotantDroite = true,
					})
				elseif(VehIndicatorLight == 3) then
					SendNUIMessage({
						clignotantGauche = true,
						clignotantDroite = true,
					})
				end

			else
				SendNUIMessage({
					showhud = false
				})
			end
		else
			SendNUIMessage({
				showhud = false
			})
		end
		if Sleep then
			Citizen.Wait(500)
		end
	end
end)