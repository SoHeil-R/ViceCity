ESX = nil
local rack = false
local plate = nil
local weapon = nil
Citizen.CreateThread(function ()
	while ESX == nil do
	  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	  Citizen.Wait(0)
	   PlayerData = ESX.GetPlayerData()
	end
  end)
  
  RegisterNetEvent('esx:playerLoaded')
  AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
  end)
  
  RegisterNetEvent('esx:setJob')
  AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
  end)


  RegisterNetEvent('esx:rack:changeStatus')
  AddEventHandler('esx:rack:changeStatus', function(status, lp, weaponh)
	 rack = status
	 plate = lp
	 weapon = weaponh
  end)

RegisterCommand("unrack", function(source, args)

	if PlayerData.job.name == "police" and PlayerData.job.grade ~= 0 and PlayerData.job.grade ~= 1 then

		if rack then
			local vehicle = ESX.Game.GetVehicleInDirection(4)
			if DoesEntityExist(vehicle) then
				
				local ped = GetPlayerPed(-1)
				local class = GetVehicleClass(vehicle)

				if class == 18 then

					if not IsPedSittingInVehicle(ped, false) then

						if GetVehicleNumberPlateText(vehicle) == plate then

							if GetHashKey("WEAPON_SMG") == weapon then

								SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
								TriggerEvent("mythic_progbar:client:progress", {
									name = "action_rifle_unrack",
									duration = 4000,
									label = "Dar hale bardashtan SMG",
									useWhileDead = false,
									canCancel = true,
									controlDisables = {
										disableMovement = false,
										disableCarMovement = true,
										disableMouse = false,
										disableCombat = true,
									},
									animation = {
										animDict = "missheistdockssetup1clipboard@idle_a",
										anim = "idle_a",
									}
								}, function(status)
									if not status then
										GiveWeaponToPed(ped, weapon, 250, false, true)
										TriggerServerEvent('esx_rack:table', 'remove', weapon)
										rack = false
									elseif status then
										rack = true
									end
								end)

							elseif GetHashKey("WEAPON_CARBINERIFLE") == weapon then

								SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
								TriggerEvent("mythic_progbar:client:progress", {
									name = "action_rifle_cunrack",
									duration = 4000,
									label = "Dar hale bardashtan CarbileRifle",
									useWhileDead = false,
									canCancel = true,
									controlDisables = {
										disableMovement = false,
										disableCarMovement = true,
										disableMouse = false,
										disableCombat = true,
									},
									animation = {
										animDict = "missheistdockssetup1clipboard@idle_a",
										anim = "idle_a",
									}
								}, function(status)
									if not status then
										GiveWeaponToPed(ped, weapon, 250, false, true)
										TriggerServerEvent('esx_rack:table', 'remove', weapon)
										rack = false
									elseif status then
										rack = true
									end
								end)

							end

						else
							TriggerEvent('chat:addMessage', {
								color = { 255, 0, 0},
								multiline = true,
								args = {"[SYSTEM]", "^0Shoma aslahe rack shodeyi dakhel in mashin nadarid!"}
							})
						end

					else
						TriggerEvent('chat:addMessage', {
							color = { 255, 0, 0},
							multiline = true,
							args = {"[SYSTEM]", "^0Shoma nemitavanid az dakhel mashin SMG ra unrack konid!"}
						})
					end

				else

					TriggerEvent('chat:addMessage', {
						color = { 255, 0, 0},
						multiline = true,
						args = {"[SYSTEM]", "^0in yek mashin police nist!"}
					})


				end

			end

		else
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = true,
				args = {"[SYSTEM]", "^0Shoma hich gun rack shodeyi nadarid!"}
			})
		end

	else

		if PlayerData.job.name ~= "police" then

			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = true,
				args = {"[SYSTEM]", "^0Shoma police nistid!"}
			})

		else

			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = true,
				args = {"[SYSTEM]", "^0Shoma dastresi kafi baraye estefade az SMG ra nadarid!"}
			})

		end

	end

end, false)

RegisterCommand("rack", function(source, args)

	if PlayerData.job.name == "police" and PlayerData.job.grade ~= 0 and PlayerData.job.grade ~= 1 then

		
		if rack == false then
			local vehicle = ESX.Game.GetVehicleInDirection(4)
			if DoesEntityExist(vehicle) then
				
				local ped = GetPlayerPed(-1)
				
				if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG") then

					local class = GetVehicleClass(vehicle)
					if class == 18 then

						if not IsPedSittingInVehicle(ped, false) then

							plate = GetVehicleNumberPlateText(vehicle)
							weapon = GetHashKey("WEAPON_SMG")

							SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
							TriggerEvent("mythic_progbar:client:progress", {
								name = "action_rifle_rack",
								duration = 4000,
								label = "Dar hale gozashtan SMG",
								useWhileDead = false,
								canCancel = true,
								controlDisables = {
									disableMovement = false,
									disableCarMovement = true,
									disableMouse = false,
									disableCombat = true,
								},
								animation = {
									animDict = "missheistdockssetup1clipboard@idle_a",
									anim = "idle_a",
								}
							}, function(status)
								if not status then
									RemoveWeaponFromPed(ped, weapon)
									rack = true
									TriggerServerEvent('esx_rack:table', 'add', weapon, plate)
								elseif status then
									rack = false
								end
							end)
						end
					else

						TriggerEvent('chat:addMessage', {	
							color = { 255, 0, 0},
							multiline = true,
							args = {"[SYSTEM]", "^0in yek mashin police nist!"}
						})

					end

				elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE") then

					local class = GetVehicleClass(vehicle)
					if class == 18 then

						if not IsPedSittingInVehicle(ped, false) then

							plate = GetVehicleNumberPlateText(vehicle)
							weapon = GetHashKey("WEAPON_CARBINERIFLE")

							SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
							TriggerEvent("mythic_progbar:client:progress", {
								name = "action_crifle_rack",
								duration = 4000,
								label = "Dar hale gozashtan Carbine",
								useWhileDead = false,
								canCancel = true,
								controlDisables = {
									disableMovement = false,
									disableCarMovement = true,
									disableMouse = false,
									disableCombat = true,
								},
								animation = {
									animDict = "missheistdockssetup1clipboard@idle_a",
									anim = "idle_a",
								}
							}, function(status)
								if not status then
									RemoveWeaponFromPed(ped, weapon)
									rack = true
									TriggerServerEvent('esx_rack:table', 'add', weapon, plate)
								elseif status then
									rack = false
								end
							end)
						end
					else
						TriggerEvent('chat:addMessage', {	
							color = { 255, 0, 0},
							multiline = true,
							args = {"[SYSTEM]", "^0in yek mashin police nist!"}
						})
					end

				else

				TriggerEvent('chat:addMessage', {
					color = { 255, 0, 0},
					multiline = true,
					args = {"[SYSTEM]", "^0Shoma faghat ghader be rack kardan rifle ha hastid!"}
				})

				end

			end

		else
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = true,
				args = {"[SYSTEM]", "^0Shoma nemitavanid bishtar az yek aslahe rack konid!"}
			})
		end

	else

		if PlayerData.job.name ~= "police" then

			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = true,
				args = {"[SYSTEM]", "^0Shoma police nistid!"}
			})

		else

			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = true,
				args = {"[SYSTEM]", "^0Shoma dastresi kafi baraye estefade az SMG ra nadarid!"}
			})

		end

	end

end, false)