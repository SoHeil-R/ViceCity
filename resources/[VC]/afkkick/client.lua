-- CONFIG --

-- AFK Kick Time Limit (in seconds)
secondsUntilKick = 300
jailkick = 150

-- Warn players if 3/4 of the Time Limit ran up
kickWarning = true
hasbeenwarned = false
-- CODE --
ESX = nil

Citizen.CreateThread(function()

	while ESX == nil do
		TriggerEvent("esx:getSharedObject",function(obj)
				ESX = obj
			end)
			
		Citizen.Wait(0)
		PlayerData = ESX.GetPlayerData()
		
	end
	
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded",function(xPlayer)

	PlayerData = xPlayer
	
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob",function(job)

	PlayerData.job = job
	
end)

Citizen.CreateThread(function()
	while true do
		Wait(2000)
		
		playerPed = GetPlayerPed(-1)
		if playerPed then

			if ESX.GetPlayerData()['aduty'] ~= 1 then
				
				if ESX.GetPlayerData()['jailed'] ~= 1 then

				currentPos = GetEntityCoords(playerPed, true)
					if (currentPos == prevPos) and ESX.GetPlayerData()['IsDead'] == 0 then
						if time > 0 then
							if kickWarning and time == math.ceil(secondsUntilKick / 4) then
								TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Shoma ^2" .. time .. " ^0saniye digar be elaat ^1AFK ^0bodan kick mishavid")
								hasbeenwarned = true
							end

							time = time - 1
						else
							TriggerServerEvent("kickForBeingAnAFKDouchebag")
						end
					else

						time = secondsUntilKick
						if hasbeenwarned then

							TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Shoma digar be onvan karbar ^1AFK ^0hesab ^2nemishavid!")
							hasbeenwarned = false

						end

					end

					prevPos = currentPos
				
				elseif ESX.GetPlayerData()['jailed'] == 1 then 
				
					currentPos = GetEntityCoords(playerPed, true)
					if (currentPos == prevPos) and ESX.GetPlayerData()['IsDead'] == 0 then
						if time > 0 then
							if kickWarning and time == math.ceil(jailkick / 4) then
								TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Shoma ^2" .. time .. " ^0saniye digar be elaat ^1AFK ^0bodan kick mishavid")
								hasbeenwarned = true
							end

							time = time - 1
						else
							TriggerServerEvent("kickForBeingAnAFKDouchebag")
						end
					else

						time = jailkick
						if hasbeenwarned then

							TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Shoma digar be onvan karbar ^1AFK ^0hesab ^2nemishavid!")
							hasbeenwarned = false

						end

					end

					prevPos = currentPos

				end
			end

		end
	end
end)