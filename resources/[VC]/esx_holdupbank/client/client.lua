local holdingup = false
local bank = ""
--local secondsRemaining = 0
local blipRobbery = nil
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-- function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
--     SetTextFont(0)
--     SetTextProportional(0)
--     SetTextScale(scale, scale)
--     SetTextColour(r, g, b, a)
--     SetTextDropShadow(0, 0, 0, 0,255)
--     SetTextEdge(1, 0, 0, 0, 255)
--     SetTextDropShadow()
--     if(outline)then
-- 	    SetTextOutline()
-- 	end
--     SetTextEntry("STRING")
--     AddTextComponentString(text)
--     DrawText(x - width/2, y - height/2 + 0.005)
-- end

RegisterNetEvent('esx_holdupbank:currentlyrobbing')
AddEventHandler('esx_holdupbank:currentlyrobbing', function(robb)
	holdingup = true
	bank = robb
	--secondsRemaining = 360
end)

RegisterNetEvent('esx_holdupbank:killblip')
AddEventHandler('esx_holdupbank:killblip', function()
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('esx_holdupbank:setblip')
AddEventHandler('esx_holdupbank:setblip', function(position)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 2.0)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
end)

RegisterNetEvent('esx_holdupbank:toofarlocal')
AddEventHandler('esx_holdupbank:toofarlocal', function(robb)
	holdingup = false
	ESX.ShowNotification(_U('robbery_cancelled'))
	robbingName = ""
	--secondsRemaining = 0
	incircle = false
end)

RegisterNetEvent('esx_holdupbank:doTheRobbery')
AddEventHandler('esx_holdupbank:doTheRobbery', function(robb)

	TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_CONST_DRILL", 0, true)
	TriggerEvent("mythic_progbar:client:progress", {
		name = "process_bankrobbery",
		duration = 900000,
		label = "Dar hale drill zadan",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}
	}, function(status)
		if not status then

			ClearPedTasksImmediately(GetPlayerPed(-1))
			TriggerServerEvent('esx_holdupbank:robberycomplete', robb)
			TriggerServerEvent('esx_holdupbank:giveReward', robb)
			incircle = false
			holdingup = false

		elseif status then

			ClearPedTasksImmediately(GetPlayerPed(-1))
			TriggerServerEvent('esx_holdupbank:toofar', robb)
			TriggerServerEvent('esx_holdupbank:toofarlocal', robb)
			ESX.ShowNotification("Shoma robbery ra ~r~cancel ~w~kardid!")
			incircle = false
			holdingup = false

		end
	end)

end)

RegisterNetEvent('esx_holdupbank:robberycomplete')
AddEventHandler('esx_holdupbank:robberycomplete', function(robb)
	holdingup = false
	ESX.ShowNotification(_U('robbery_complete') .. Banks[bank].reward)
	TriggerServerEvent('esx_holdupbank:toofar', robb)
	bank = ""
	--secondsRemaining = 0
	incircle = false
	ClearPedTasks(GetPlayerPed(-1))
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)
-- 		if holdingup then
-- 			Citizen.Wait(1000)
-- 			if(secondsRemaining > 0)then
-- 				secondsRemaining = secondsRemaining - 1
-- 			end
-- 		end
-- 	end
-- end)

Citizen.CreateThread(function()
	for k,v in pairs(Banks)do
		local ve = v.position

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 108)--156
		SetBlipScale(blip, 1.0)
		SetBlipColour(blip, 52)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('bank_robbery'))
		EndTextCommandSetBlipName(blip)
	end
end)
incircle = false

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(Banks)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if not holdingup then
					DrawMarker(1, v.position.x, v.position.y, v.position.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)

					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						if (incircle == false) then
							DisplayHelpText(_U('press_to_rob') .. v.nameofbank)
						end
						incircle = true
						if IsControlJustReleased(1, 51) then
							TriggerServerEvent('esx_holdupbank:rob', k)
						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end
				end
			end
		end

		if holdingup then

			-- drawTxt(0.96, 1.44, 1.0,1.0,0.4, _U('robbery_of') .. secondsRemaining .. _U('seconds_remaining'), 255, 255, 255, 255)

			local pos2 = Banks[bank].position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 7.5)then
				TriggerServerEvent('esx_holdupbank:toofar', bank)
			end
		end

		Citizen.Wait(0)
	end
end)
