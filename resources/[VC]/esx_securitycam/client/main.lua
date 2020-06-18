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
local PlayerData = {}
local isInMarker = false
local CurrentAction = nil
local CurrentActionMsg = ''
local HasAlreadyEnteredMarker = false
local LastZone = nil
local menuopen = false
local bankcamera = false
local policecamera = false
local mechaniccamera = false
local towncamera = false
local blockbuttons = false
local bankHacked = false
local policeHacked  = false
local currentCameraIndex = 0
local currentCameraIndexIndex = 0
local createdCamera = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerData = ESX.GetPlayerData()
end)
 
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

AddEventHandler('esx_securitycam:hasEnteredMarker', function (zone)
	if zone == 'Cameras' and not menuopen then
		CurrentAction     = 'cameras'
		CurrentActionMsg  = _U('marker_hint')
	elseif zone == 'HackingPolice' and not menuopen then
		CurrentAction     = 'hackingPolice'
		CurrentActionMsg  = _U('marker_hint_hacking_policestation')
	elseif zone == 'HackingBank' and not menuopen then
		CurrentAction     = 'hackingBank'
		CurrentActionMsg  = _U('marker_hint_hacking_bank')
	elseif zone == 'UnHackPolice' and not menuopen then
		CurrentAction     = 'UnHackPolice'
		CurrentActionMsg  = _U('unhack_policestation')
	elseif zone == 'UnHackBank' and not menuopen then
		CurrentAction     = 'UnHackBank'
		CurrentActionMsg  = _U('unhack_bank')
	end
end)

AddEventHandler('esx_securitycam:hasExitedMarker', function(zone)
	CurrentAction = nil
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker = false
		local currentZone = nil

		for k, v in pairs(Config.Zones) do
			if PlayerData.job ~= nil and PlayerData.job.name ~= 'unemployed' and PlayerData.job.name == "police" then
				if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)

					if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 0 then
						DrawText3D(v.Pos.x, v.Pos.y, v.Pos.z+0.9, "~w~[~g~E~w~] Didan Dorbin ha.", 0.80)
					end
				end
			end
		end

		for k, v in pairs(Config.HackingPolice) do
			if Config.Hacking then
				if PlayerData.job ~= nil and PlayerData.job.name ~= 'unemployed' and PlayerData.job.name == "police" then
					-- nothing
				else
					if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
						DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)

						if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.5 then
							DrawText3D(v.Pos.x, v.Pos.y, v.Pos.z+0.9, "~w~[~g~E~w~] Börja hacka kamerorna.", 0.80)
						end
					end
				end
			end
		end

		for k, v in pairs(Config.HackingBank) do
			if Config.Hacking then
				if PlayerData.job ~= nil and PlayerData.job.name ~= 'unemployed' and PlayerData.job.name == "police" then
					-- nothing
				else
					if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
						DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)

						if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.5 then
							DrawText3D(v.Pos.x, v.Pos.y, v.Pos.z+0.9, "~w~[~g~E~w~] Börja hacka kamerorna.", 0.80)
						end
					end
				end
			end
		end

		for k, v in pairs(Config.UnHackPolice) do
			if Config.Hacking then
				if PlayerData.job ~= nil and PlayerData.job.name ~= 'unemployed' and PlayerData.job.name == "police" then
					if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
						DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)

						if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.5 then
							DrawText3D(v.Pos.x, v.Pos.y, v.Pos.z+0.9, "~w~[~g~E~w~] Ta bort virus.", 0.80)
						end
					end
				end
			end
		end

		for k, v in pairs(Config.UnHackBank) do
			if Config.Hacking then
				if PlayerData.job ~= nil and PlayerData.job.name ~= 'unemployed' and PlayerData.job.name == "police" then
					if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
						DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)

						if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.5 then
							DrawText3D(v.Pos.x, v.Pos.y, v.Pos.z+0.9, "~w~[~g~E~w~] Ta bort virus.", 0.80)
						end
					end
				end
			end
		end

		for k,v in pairs(Config.Zones) do
			if PlayerData.job ~= nil and PlayerData.job.name ~= 'unemployed' and PlayerData.job.name == "police" then
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.5) then
					isInMarker  = true
					currentZone = k
				end
			end
		end

		for k,v in pairs(Config.HackingPolice) do
			if Config.Hacking then
				if PlayerData.job ~= nil and PlayerData.job.name ~= 'unemployed' and PlayerData.job.name == "police" then
					-- nothing
				else
					if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.5) then
						isInMarker  = true
						currentZone = k
					end
				end
			end
		end

		for k,v in pairs(Config.HackingBank) do
			if Config.Hacking then
				if PlayerData.job ~= nil and PlayerData.job.name ~= 'unemployed' and PlayerData.job.name == "police" then
					-- nothing
				else
					if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.5) then
						isInMarker  = true
						currentZone = k
					end
				end
			end
		end

		for k,v in pairs(Config.UnHackPolice) do
			if Config.Hacking then
				if PlayerData.job ~= nil and PlayerData.job.name ~= 'unemployed' and PlayerData.job.name == "police" then
					if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.5) then
						isInMarker  = true
						currentZone = k
					end
				end
			end
		end

		for k,v in pairs(Config.UnHackBank) do
			if Config.Hacking then
				if PlayerData.job ~= nil and PlayerData.job.name ~= 'unemployed' and PlayerData.job.name == "police" then
					if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.5) then
						isInMarker  = true
						currentZone = k
					end
				end
			end
		end
			
		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone = currentZone
			TriggerEvent('esx_securitycam:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_securitycam:hasExitedMarker', LastZone)
			CurrentAction = nil
			ESX.UI.Menu.CloseAll()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if IsControlJustReleased(0, Keys['E']) and CurrentAction == 'cameras' then

			if not menuopen then
				CurrentAction, menuopen = nil, true

				local elements = {
					{label = _U('bank_menu_selection'),   value = 'bankmenu'},
					{label = _U('mechanic_menu_selection'), value = 'mechanicmenu'},
					{label = _U('police_menu_selection'), value = 'policemenu'},
					{label = _U('town_menu_selection'), value = 'townmenu'},
				}

				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
				{
					title    = _U('securitycams_menu'),
					align    = 'top-left',
					elements = elements
				}, function(data, menu)

					if data.current.value == 'bankmenu' then

						if bankHacked then
							if Config.pNotify then
								TriggerEvent("pNotify:SendNotification",{
									text = _U('broken_cameras'),
									type = "warning",
									timeout = (10000),
									layout = "bottomCenter",
									queue = "global"
								})
							else
								ESX.ShowNotification(_U('broken_cameras'))
							end
						else
							menu.close()
							bankcamera = true
							blockbuttons = true
							local firstCamx = Config.Locations[1].bankCameras[1].x
							local firstCamy = Config.Locations[1].bankCameras[1].y
							local firstCamz = Config.Locations[1].bankCameras[1].z
							local firstCamr = Config.Locations[1].bankCameras[1].r
							SetFocusArea(firstCamx, firstCamy, firstCamz, firstCamx, firstCamy, firstCamz)
							ChangeSecurityCamera(firstCamx, firstCamy, firstCamz, firstCamr)

							if Config.HideRadar then
								StartHideHUD()
							end

							SendNUIMessage({
								type = "enablecam",
								label = Config.Locations[1].bankCameras[1].label,
								box = Config.Locations[1].bankCamLabel.label
							})

							currentCameraIndex = 1
							currentCameraIndexIndex = 1
							menuopen = false
							TriggerEvent('esx_securitycam:freeze', true)
						end

					elseif data.current.value == 'policemenu' then

						if policeHacked then
							if Config.pNotify then
								TriggerEvent("pNotify:SendNotification",{
									text = _U('broken_cameras'),
									type = "warning",
									timeout = (10000),
									layout = "bottomCenter",
									queue = "global"
								})
							else
								ESX.ShowNotification(_U('broken_cameras'))
							end
						else
							menu.close()
							policecamera = true
							blockbuttons = true
							local firstCamx = Config.Locations[1].policeCameras[1].x
							local firstCamy = Config.Locations[1].policeCameras[1].y
							local firstCamz = Config.Locations[1].policeCameras[1].z
							local firstCamr = Config.Locations[1].policeCameras[1].r

							SetFocusArea(firstCamx, firstCamy, firstCamz, firstCamx, firstCamy, firstCamz)
							ChangeSecurityCamera(firstCamx, firstCamy, firstCamz, firstCamr)

							if Config.HideRadar then
								StartHideHUD()
							end

							SendNUIMessage({
								type  = "enablecam",
								label = Config.Locations[1].policeCameras[1].label,
								box   = Config.Locations[1].policeCamLabel.label
							})

							currentCameraIndex = 1
							currentCameraIndexIndex = 1
							menuopen = false
							TriggerEvent('esx_securitycam:freeze', true)
						end

					    elseif data.current.value == 'mechanicmenu' then

							if policeHacked then
								if Config.pNotify then
									TriggerEvent("pNotify:SendNotification",{
										text = _U('broken_cameras'),
										type = "warning",
										timeout = (10000),
										layout = "bottomCenter",
										queue = "global"
									})
								else
									ESX.ShowNotification(_U('broken_cameras'))
								end
							else
								menu.close()
								mechaniccamera = true
								blockbuttons = true
								local firstCamx = Config.Locations[1].mechanicCameras[1].x
								local firstCamy = Config.Locations[1].mechanicCameras[1].y
								local firstCamz = Config.Locations[1].mechanicCameras[1].z
								local firstCamr = Config.Locations[1].mechanicCameras[1].r
								SetFocusArea(firstCamx, firstCamy, firstCamz, firstCamx, firstCamy, firstCamz)
								ChangeSecurityCamera(firstCamx, firstCamy, firstCamz, firstCamr)
	
								if Config.HideRadar then
									StartHideHUD()
								end
	
								SendNUIMessage({
									type = "enablecam",
									label = Config.Locations[1].mechanicCameras[1].label,
									box = Config.Locations[1].mechanicCameras.label
								})
	
								currentCameraIndex = 1
								currentCameraIndexIndex = 1
								menuopen = false
								TriggerEvent('esx_securitycam:freeze', true)
							end

						elseif data.current.value == 'townmenu' then

							if policeHacked then
								if Config.pNotify then
									TriggerEvent("pNotify:SendNotification",{
										text = _U('broken_cameras'),
										type = "warning",
										timeout = (10000),
										layout = "bottomCenter",
										queue = "global"
									})
								else
									ESX.ShowNotification(_U('broken_cameras'))
								end
							else
								menu.close()
								towncamera = true
								blockbuttons = true
								local firstCamx = Config.Locations[1].townCameras[1].x
								local firstCamy = Config.Locations[1].townCameras[1].y
								local firstCamz = Config.Locations[1].townCameras[1].z
								local firstCamr = Config.Locations[1].townCameras[1].r
								SetFocusArea(firstCamx, firstCamy, firstCamz, firstCamx, firstCamy, firstCamz)
								ChangeSecurityCamera(firstCamx, firstCamy, firstCamz, firstCamr)
	
								if Config.HideRadar then
									StartHideHUD()
								end
	
								SendNUIMessage({
									type = "enablecam",
									label = Config.Locations[1].townCameras[1].label,
									box = Config.Locations[1].townCameras.label
								})
	
								currentCameraIndex = 1
								currentCameraIndexIndex = 1
								menuopen = false
								TriggerEvent('esx_securitycam:freeze', true)
							end

					end

				end, function(data, menu)
					menu.close()
					menuopen = false
				end)

			end
		end

		if createdCamera ~= 0 then
			local instructions = CreateInstuctionScaleform("instructional_buttons")

			DrawScaleformMovieFullscreen(instructions, 255, 255, 255, 255, 0)
			SetTimecycleModifier("scanline_cam_cheap")
			SetTimecycleModifierStrength(2.0)

			-- CLOSE CAMERAS
			if IsControlJustPressed(0, Keys["BACKSPACE"]) then
				CloseSecurityCamera()
				SendNUIMessage({
					type = "disablecam",
				})

				CurrentAction = nil
				bankcamera = false
				policecamera = false
				mechaniccamera = false
				towncamera = false
				blockbuttons = false
				if Config.HideRadar then
					StopHideHUD()
				end
				TriggerEvent('esx_securitycam:freeze', false)
			end

			-- GO BACK CAMERA
			if IsControlJustPressed(0, Keys["LEFT"]) then
				if bankcamera then
					local newCamIndex

					if currentCameraIndexIndex == 1 then
						newCamIndex = #Config.Locations[currentCameraIndex].bankCameras
					else
						newCamIndex = currentCameraIndexIndex - 1
					end

					local newCamx = Config.Locations[currentCameraIndex].bankCameras[newCamIndex].x
					local newCamy = Config.Locations[currentCameraIndex].bankCameras[newCamIndex].y
					local newCamz = Config.Locations[currentCameraIndex].bankCameras[newCamIndex].z
					local newCamr = Config.Locations[currentCameraIndex].bankCameras[newCamIndex].r

					SetFocusArea(newCamx, newCamy, newCamz, newCamx, newCamy, newCamz)
					SendNUIMessage({
						type = "updatecam",
						label = Config.Locations[currentCameraIndex].bankCameras[newCamIndex].label
					})

					ChangeSecurityCamera(newCamx, newCamy, newCamz, newCamr)
					currentCameraIndexIndex = newCamIndex
				elseif policecamera then
					local newCamIndex

					if currentCameraIndexIndex == 1 then
						newCamIndex = #Config.Locations[currentCameraIndex].policeCameras
					else
						newCamIndex = currentCameraIndexIndex - 1
					end

					local newCamx = Config.Locations[currentCameraIndex].policeCameras[newCamIndex].x
					local newCamy = Config.Locations[currentCameraIndex].policeCameras[newCamIndex].y
					local newCamz = Config.Locations[currentCameraIndex].policeCameras[newCamIndex].z
					local newCamr = Config.Locations[currentCameraIndex].policeCameras[newCamIndex].r

					SetFocusArea(newCamx, newCamy, newCamz, newCamx, newCamy, newCamz)
					SendNUIMessage({
						type = "updatecam",
						label = Config.Locations[currentCameraIndex].policeCameras[newCamIndex].label
					})

					ChangeSecurityCamera(newCamx, newCamy, newCamz, newCamr)
					currentCameraIndexIndex = newCamIndex
				
				elseif mechaniccamera then
					local newCamIndex

					if currentCameraIndexIndex == 1 then
						newCamIndex = #Config.Locations[currentCameraIndex].mechanicCameras
					else
						newCamIndex = currentCameraIndexIndex - 1
					end

					local newCamx = Config.Locations[currentCameraIndex].mechanicCameras[newCamIndex].x
					local newCamy = Config.Locations[currentCameraIndex].mechanicCameras[newCamIndex].y
					local newCamz = Config.Locations[currentCameraIndex].mechanicCameras[newCamIndex].z
					local newCamr = Config.Locations[currentCameraIndex].mechanicCameras[newCamIndex].r

					SetFocusArea(newCamx, newCamy, newCamz, newCamx, newCamy, newCamz)
					SendNUIMessage({
						type = "updatecam",
						label = Config.Locations[currentCameraIndex].mechanicCameras[newCamIndex].label
					})

					ChangeSecurityCamera(newCamx, newCamy, newCamz, newCamr)
					currentCameraIndexIndex = newCamIndex
				
				elseif towncamera then
					local newCamIndex

					if currentCameraIndexIndex == 1 then
						newCamIndex = #Config.Locations[currentCameraIndex].townCameras
					else
						newCamIndex = currentCameraIndexIndex - 1
					end

					local newCamx = Config.Locations[currentCameraIndex].townCameras[newCamIndex].x
					local newCamy = Config.Locations[currentCameraIndex].townCameras[newCamIndex].y
					local newCamz = Config.Locations[currentCameraIndex].townCameras[newCamIndex].z
					local newCamr = Config.Locations[currentCameraIndex].townCameras[newCamIndex].r

					SetFocusArea(newCamx, newCamy, newCamz, newCamx, newCamy, newCamz)
					SendNUIMessage({
						type = "updatecam",
						label = Config.Locations[currentCameraIndex].townCameras[newCamIndex].label
					})

					ChangeSecurityCamera(newCamx, newCamy, newCamz, newCamr)
					currentCameraIndexIndex = newCamIndex
				end
			end

			-- GO FORWARD CAMERA
			if IsControlJustPressed(0, Keys["RIGHT"]) then
				if bankcamera then
					local newCamIndex

					if currentCameraIndexIndex == #Config.Locations[currentCameraIndex].bankCameras then
						newCamIndex = 1
					else
						newCamIndex = currentCameraIndexIndex + 1
					end

					local newCamx = Config.Locations[currentCameraIndex].bankCameras[newCamIndex].x
					local newCamy = Config.Locations[currentCameraIndex].bankCameras[newCamIndex].y
					local newCamz = Config.Locations[currentCameraIndex].bankCameras[newCamIndex].z
					local newCamr = Config.Locations[currentCameraIndex].bankCameras[newCamIndex].r

					SendNUIMessage({
						type = "updatecam",
						label = Config.Locations[currentCameraIndex].bankCameras[newCamIndex].label
					})

					ChangeSecurityCamera(newCamx, newCamy, newCamz, newCamr)
					currentCameraIndexIndex = newCamIndex

				elseif policecamera then
					local newCamIndex

					if currentCameraIndexIndex == #Config.Locations[currentCameraIndex].policeCameras then
						newCamIndex = 1
					else
						newCamIndex = currentCameraIndexIndex + 1
					end

					local newCamx = Config.Locations[currentCameraIndex].policeCameras[newCamIndex].x
					local newCamy = Config.Locations[currentCameraIndex].policeCameras[newCamIndex].y
					local newCamz = Config.Locations[currentCameraIndex].policeCameras[newCamIndex].z
					local newCamr = Config.Locations[currentCameraIndex].policeCameras[newCamIndex].r

					SendNUIMessage({
						type = "updatecam",
						label = Config.Locations[currentCameraIndex].policeCameras[newCamIndex].label
					})

					ChangeSecurityCamera(newCamx, newCamy, newCamz, newCamr)
					currentCameraIndexIndex = newCamIndex

				elseif mechaniccamera then
					local newCamIndex

					if currentCameraIndexIndex == #Config.Locations[currentCameraIndex].mechanicCameras then
						newCamIndex = 1
					else
						newCamIndex = currentCameraIndexIndex + 1
					end

					local newCamx = Config.Locations[currentCameraIndex].mechanicCameras[newCamIndex].x
					local newCamy = Config.Locations[currentCameraIndex].mechanicCameras[newCamIndex].y
					local newCamz = Config.Locations[currentCameraIndex].mechanicCameras[newCamIndex].z
					local newCamr = Config.Locations[currentCameraIndex].mechanicCameras[newCamIndex].r

					SendNUIMessage({
						type = "updatecam",
						label = Config.Locations[currentCameraIndex].mechanicCameras[newCamIndex].label
					})

					ChangeSecurityCamera(newCamx, newCamy, newCamz, newCamr)
					currentCameraIndexIndex = newCamIndex
				
				elseif towncamera then
					local newCamIndex

					if currentCameraIndexIndex == #Config.Locations[currentCameraIndex].townCameras then
						newCamIndex = 1
					else
						newCamIndex = currentCameraIndexIndex + 1
					end

					local newCamx = Config.Locations[currentCameraIndex].townCameras[newCamIndex].x
					local newCamy = Config.Locations[currentCameraIndex].townCameras[newCamIndex].y
					local newCamz = Config.Locations[currentCameraIndex].townCameras[newCamIndex].z
					local newCamr = Config.Locations[currentCameraIndex].townCameras[newCamIndex].r

					SendNUIMessage({
						type = "updatecam",
						label = Config.Locations[currentCameraIndex].townCameras[newCamIndex].label
					})

					ChangeSecurityCamera(newCamx, newCamy, newCamz, newCamr)
					currentCameraIndexIndex = newCamIndex
				end
			end

			if Config.Locations[currentCameraIndex].bankCameras[currentCameraIndexIndex].canRotate then
				local getCameraRot = GetCamRot(createdCamera, 2)

				-- ROTATE LEFT
				if IsControlPressed(1, Keys['N4']) then
					SetCamRot(createdCamera, getCameraRot.x, 0.0, getCameraRot.z + 0.7, 2)
				end

				-- ROTATE RIGHT
				if IsControlPressed(1, Keys['N6']) then
					SetCamRot(createdCamera, getCameraRot.x, 0.0, getCameraRot.z - 0.7, 2)
				end

			elseif Config.Locations[currentCameraIndex].policeCameras[currentCameraIndexIndex].canRotate then
				local getCameraRot = GetCamRot(createdCamera, 2)

				-- ROTATE LEFT
				if IsControlPressed(1, Keys['N4']) then
					SetCamRot(createdCamera, getCameraRot.x, 0.0, getCameraRot.z + 0.7, 2)
				end

				-- ROTATE RIGHT
				if IsControlPressed(1, Keys['N6']) then
					SetCamRot(createdCamera, getCameraRot.x, 0.0, getCameraRot.z - 0.7, 2)
				end

			elseif Config.Locations[currentCameraIndex].mechanicCameras[currentCameraIndexIndex].canRotate then
				local getCameraRot = GetCamRot(createdCamera, 2)

				-- ROTATE LEFT
				if IsControlPressed(1, Keys['N4']) then
					SetCamRot(createdCamera, getCameraRot.x, 0.0, getCameraRot.z + 0.7, 2)
				end

				-- ROTATE RIGHT
				if IsControlPressed(1, Keys['N6']) then
					SetCamRot(createdCamera, getCameraRot.x, 0.0, getCameraRot.z - 0.7, 2)
				end

			elseif Config.Locations[currentCameraIndex].townCameras[currentCameraIndexIndex].canRotate then
				local getCameraRot = GetCamRot(createdCamera, 2)

				-- ROTATE LEFT
				if IsControlPressed(1, Keys['N4']) then
					SetCamRot(createdCamera, getCameraRot.x, 0.0, getCameraRot.z + 0.7, 2)
				end

				-- ROTATE RIGHT
				if IsControlPressed(1, Keys['N6']) then
					SetCamRot(createdCamera, getCameraRot.x, 0.0, getCameraRot.z - 0.7, 2)
				end

			end

		end
	end
end)

function StartHideHUD()
	Citizen.CreateThread(function()
		while blockbuttons do
			Citizen.Wait(100)
			ESX.UI.HUD.SetDisplay(0.0)
			TriggerEvent('es:setMoneyDisplay', 0.0)
		end
	end)
end

function StopHideHUD()
	Citizen.CreateThread(function()
		while not blockbuttons do
			Citizen.Wait(100)
			ESX.UI.HUD.SetDisplay(1.0)
			TriggerEvent('es:setMoneyDisplay', 1.0)
		end
	end)
end

function mycbpolice(success, timeRemaining)
	if success then
		TriggerEvent('mhacking:hide')
		TriggerServerEvent('esx_securitycam:setPoliceHackedState', true)

		if Config.pNotify then
			TriggerEvent("pNotify:SendNotification", {
				text = _U('hacking_succeed'),
				type = "success",
				timeout = (7000),
				layout = "bottomCenter",
				queue = "global"
			})
		else
			ESX.ShowNotification(_U('hacking_succeed'))
		end
	else
		TriggerEvent('mhacking:hide')
		if Config.pNotify then
			TriggerEvent("pNotify:SendNotification",{
				text = _U('hacking_failed'),
				type = "warning",
				timeout = (7000),
				layout = "bottomCenter",
				queue = "global"
			})
		else
			ESX.ShowNotification(_U('hacking_failed'))
		end

		PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
		ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
		Citizen.Wait(500)
		PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)
		TriggerServerEvent('esx_phone:send', 'police', 'POLICE ALARM: SOMEONE TRIED TO HACK OUR COMPUTERS. COME TO THE STATION FAST.', false, false)
	end
end

function mycbbank(success, timeRemaining)
	if success then
		TriggerEvent('mhacking:hide')
		TriggerServerEvent('esx_securitycam:setBankHackedState', true)
		if Config.pNotify then
			TriggerEvent("pNotify:SendNotification", {
				text = _U('hacking_succeed'),
				type = "success",
				timeout = (7000),
				layout = "bottomCenter",
				queue = "global"
			})
		else
			ESX.ShowNotification(_U('hacking_succeed'))
		end
	else
		TriggerEvent('mhacking:hide')
		if Config.pNotify then
			TriggerEvent("pNotify:SendNotification", {
				text = _U('hacking_failed'),
				type = "warning",
				timeout = (7000),
				layout = "bottomCenter",
				queue = "global"
			})
		else
			ESX.ShowNotification(_U('hacking_failed'))
		end

		PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
		ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
		Citizen.Wait(500)
		PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)
		TriggerServerEvent('esx_phone:send', 'police', 'BANK: HELP! SOMEONE TRIED TO HACK MY COMPUTER! COME HERE RIGHT AWAY OR LOOK IN THE CAMERAS FAST.', false, false)
	end
end

-- HACKING POLICE STATION
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if IsControlJustReleased(0, Keys['E']) and CurrentAction == 'hackingPolice' then
			if policeHacked then
				if Config.pNotify then
					TriggerEvent("pNotify:SendNotification", {
						text = _U('infected_cameras'),
						type = "success",
						timeout = (7000),
						layout = "bottomCenter",
						queue = "global"
					})
				else
					ESX.ShowNotification(_U('infected_cameras'))
				end
			elseif not policeHacked then
				TriggerEvent("mhacking:show")
				TriggerEvent("mhacking:start", 2, 13, mycbpolice)
				CurrentAction = nil
			end
		end
	end
end)

-- HACKING BANK
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if IsControlJustReleased(0, Keys['E']) and CurrentAction == 'hackingBank' then
			if bankHacked then
				if Config.pNotify then
					TriggerEvent("pNotify:SendNotification", {
						text = _U('infected_cameras'),
						type = "success",
						timeout = (7000),
						layout = "bottomCenter",
						queue = "global"
					})
				else
					ESX.ShowNotification(_U('infected_cameras'))
				end
			elseif not bankHacked then
				TriggerEvent("mhacking:show")
				TriggerEvent("mhacking:start", 2, 13, mycbbank)
				CurrentAction = nil
			end
		end
	end
end)

-- UNHACK BANK
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(0, Keys['E']) and CurrentAction == 'UnHackBank' then

			if bankHacked then
				TriggerServerEvent('esx_securitycam:unhackanimserver')
				TriggerServerEvent('esx_securitycam:setBankHackedState', false)

				if Config.pNotify then
					TriggerEvent("pNotify:SendNotification", {
						text = _U('removing_viruses'),
						type = "success",
						timeout = (7000),
						layout = "bottomCenter",
						queue = "global"
					})
				else
					ESX.ShowNotification(_U('removing_viruses'))
				end

			elseif not bankHacked then

				if Config.pNotify then
					TriggerEvent("pNotify:SendNotification",{
						text = _U('nothing_wrong'),
						type = "success",
						timeout = (7000),
						layout = "bottomCenter",
						queue = "global"
					})
				else
					ESX.ShowNotification(_U('nothing_wrong'))
				end

			end

			CurrentAction = nil
		end
	end
end)

-- UNHACK POLICE
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if IsControlJustReleased(0, Keys['E']) and CurrentAction == 'UnHackPolice' then
			if policeHacked then
				TriggerServerEvent('esx_securitycam:unhackanimserver')
				TriggerServerEvent('esx_securitycam:setPoliceHackedState', false)

				if Config.pNotify then
					TriggerEvent("pNotify:SendNotification", {
						text = _U('removing_viruses'),
						type = "success",
						timeout = (7000),
						layout = "bottomCenter",
						queue = "global"
					})
				else
					ESX.ShowNotification(_U('removing_viruses'))
				end
			elseif not policeHacked then
				if Config.pNotify then
					TriggerEvent("pNotify:SendNotification", {
						text = _U('nothing_wrong'),
						type = "success",
						timeout = (7000),
						layout = "bottomCenter",
						queue = "global"
					})
				else
					ESX.ShowNotification(_U('nothing_wrong'))
				end
			end

			CurrentAction = nil
		end
	end
end)

function ChangeSecurityCamera(x, y, z, r)
	if createdCamera ~= 0 then
		DestroyCam(createdCamera, 0)
		createdCamera = 0
	end

	local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	SetCamCoord(cam, x, y, z)
	SetCamRot(cam, r.x, r.y, r.z, 2)
	RenderScriptCams(1, 0, 0, 1, 1)

	createdCamera = cam
end

function CloseSecurityCamera()
	DestroyCam(createdCamera, 0)
	RenderScriptCams(0, 0, 1, 1, 1)
	createdCamera = 0
	ClearTimecycleModifier("scanline_cam_cheap")
	SetFocusEntity(GetPlayerPed(PlayerId()))
end

function CreateInstuctionScaleform(scaleform)
	local scaleform = RequestScaleformMovie(scaleform)

	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(10)
	end

	PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
	PushScaleformMovieFunctionParameterInt(200)
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(0, Keys["RIGHT"], true))
	InstructionButtonMessage(_U('next'))
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(1)
	PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(0, Keys["LEFT"], true))
	InstructionButtonMessage(_U('previous'))
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(2)
	PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(0, Keys["BACKSPACE"], true))
	InstructionButtonMessage(_U('close'))
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(80)
	PopScaleformMovieFunctionVoid()

	return scaleform
end

function InstructionButtonMessage(text)
	BeginTextCommandScaleformString("STRING")
	AddTextComponentScaleform(text)
	EndTextCommandScaleformString()
end

RegisterNetEvent('esx_securitycam:freeze')
AddEventHandler('esx_securitycam:freeze', function(freeze)
	FreezeEntityPosition(PlayerPedId(), freeze)
end)

-- UNHACK ANIMATION, IT'S NOT THE BEST ONE SO CHANGE IT IF YOU WANT AND SEND ME THE CODE AND I WILL CHANGE IT!
RegisterNetEvent('esx_securitycam:unhackanim')
AddEventHandler('esx_securitycam:unhackanim', function()
	local pid = PlayerPedId()
	RequestAnimDict("anim@heists@humane_labs@emp@hack_door")
	while (not HasAnimDictLoaded("anim@heists@humane_labs@emp@hack_door")) do Citizen.Wait(0) end

	TaskPlayAnim(pid,"anim@heists@humane_labs@emp@hack_door","hack_loop",100.0, 200.0, 0.3, 9, 0.2, 0, 0, 0)
	Citizen.Wait(1000 * Config.AnimTime)
	StopAnimTask(pid, "anim@heists@humane_labs@emp@hack_door","hack_loop", 1.0)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if blockbuttons then
			DisableControlAction(2, 24, true)
			DisableControlAction(2, 257, true)
			DisableControlAction(2, 25, true)
			DisableControlAction(2, 263, true)
			DisableControlAction(2, Keys['R'], true)
			DisableControlAction(2, Keys['SPACE'], true)
			DisableControlAction(2, Keys['Q'], true)
			DisableControlAction(2, Keys['TAB'], true)
			DisableControlAction(2, Keys['F'], true)
			DisableControlAction(2, Keys['F1'], true)
			DisableControlAction(2, Keys['F2'], true)
			DisableControlAction(2, Keys['F3'], true)
			DisableControlAction(2, Keys['F6'], true)
			DisableControlAction(2, Keys['F7'], true)
			DisableControlAction(2, Keys['F10'], true)
		else
			Citizen.Wait(1000)
		end
	end
end)

function DrawText3D(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)

	AddTextComponentString(text)
	DrawText(_x, _y)

	local factor = (string.len(text)) / 230
	DrawRect(_x, _y + 0.0250, 0.095 + factor, 0.06, 41, 11, 41, 100)
end

RegisterNetEvent('esx_securitycam:setBankHackedState')
AddEventHandler('esx_securitycam:setBankHackedState', function(state)
	bankHacked = state
end)

RegisterNetEvent('esx_securitycam:setPoliceHackedState')
AddEventHandler('esx_securitycam:setPoliceHackedState', function(state)
	policeHacked = state
end)
