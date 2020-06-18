local blips 		= {}
local PlayerData    = {}
local GUI           = {}
local sData 		= false
local tData 		= false
local mData 		= false
local playerCanSee  = false
local PlayerData    = {}
ESX                 = nil

Citizen.CreateThread(function()
	while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer

	while ESX.GetPlayerData() == nil do
		Citizen.Wait(10)
	end

	PlayerData = xPlayer

	if PlayerData.job.name == "police" then

		TriggerServerEvent('esx_tracker:changejob', 'police')

	elseif PlayerData.job.name == "taxi" then
		TriggerServerEvent('esx_tracker:changejob', 'taxi')
		TriggerServerEvent('esx_tracker:addTaxiToTable')
		tData = true
		
	elseif PlayerData.job.name == "mecano" then
		TriggerServerEvent('esx_tracker:changejob', 'mecano')
		TriggerServerEvent('esx_tracker:addMechanicToTable')
		mData = true

	elseif PlayerData.job.name == "ambulance" then
		TriggerServerEvent('esx_tracker:changejob', 'ambulance')
		TriggerServerEvent('esx_tracker:addAmbulanceToTable')
		sData = true
	
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)




Citizen.CreateThread(function()
	while true  do
		
		if (PlayerData.job ~= nil and PlayerData.job.name == 'ambulance') and (sData == false ) then
		
			TriggerServerEvent('esx_tracker:addAmbulanceToTable')
			sData = true
		end

		if (PlayerData.job ~= nil and PlayerData.job.name ~= 'ambulance') and sData then
			TriggerServerEvent('esx_tracker:removeAmbulanceFromTable')
			sData = false
		end
		
		if (PlayerData.job ~= nil and PlayerData.job.name == 'taxi') and (tData == false ) then
		
			TriggerServerEvent('esx_tracker:addTaxiToTable')
			tData = true
		end

		if (PlayerData.job ~= nil and PlayerData.job.name ~= 'taxi') and tData then
		
			TriggerServerEvent('esx_tracker:removeTaxiFromTable')
			tData = false
		end

		if (PlayerData.job ~= nil and PlayerData.job.name == 'mechanic') and (mData == false ) then
		
			TriggerServerEvent('esx_tracker:addMechanicToTable')
			mData = true
		end

		if (PlayerData.job ~= nil and PlayerData.job.name ~= 'mechanic') and mData then
		
			TriggerServerEvent('esx_tracker:removeMechanicFromTable')
			mData = false
		end

		Citizen.Wait(1)
	end
end)

--//Ambulance//---
RegisterNetEvent('esx_tracker:updateAmbulance')
AddEventHandler('esx_tracker:updateAmbulance',function(ambulancetable,name,showblips)
	
	if name == GetPlayerName(PlayerId()) and (showblips == true) then
		playerCanSee = true
	elseif name ==  GetPlayerName(PlayerId()) and (showblips == false) then
		playerCanSee = false
	end

	
	if (PlayerData.job ~= nil and PlayerData.job.name == 'offambulance') or (playerCanSee == false) then
		for i = 0,255 do
			RemoveBlip(blips[i])
		end
	end
	

	if (PlayerData.job ~= nil and PlayerData.job.name == 'ambulance') and playerCanSee then
	
		for i = 0,255 do
			RemoveBlip(blips[i])
		end
			
		for i=0,255 do
			for k,v in pairs(ambulancetable) do
				local playerPed = GetPlayerPed(i)
				local playerName = GetPlayerName(i)
		
				if playerName == ambulancetable[k].i then
					if playerPed ~= nil then
						local new_blip = AddBlipForEntity(playerPed)
						BeginTextCommandSetBlipName("STRING");
						AddTextComponentString(ambulancetable[k].name);
						EndTextCommandSetBlipName(new_blip);
						SetBlipColour(new_blip, 1)
						SetBlipCategory(new_blip, 2)
						SetBlipScale(new_blip, 1.0)
						blips[k] = new_blip
					else
						local jasem = true
						while jasem do
							playerPed = GetPlayerPed(-1)
							if playerPed ~= nil then
								jasem = false
								
								local playerName = GetPlayerName(i)
						
								if playerName == taxitable[k].i then
							
									local new_blip = AddBlipForEntity(playerPed)
									BeginTextCommandSetBlipName("STRING");
									AddTextComponentString(taxitable[k].name);
									EndTextCommandSetBlipName(new_blip);
									SetBlipColour(new_blip, 46)
									SetBlipCategory(new_blip, 2)
									SetBlipScale(new_blip, 1.1)
									blips[k] = new_blip
								end

							end
							Citizen.Wait(0)
						end

					end
				end
			end
		end
	end
end)
------------------------------------------------

--//taxi//---
RegisterNetEvent('esx_tracker:updateTaxi')
AddEventHandler('esx_tracker:updateTaxi',function(taxitable,name,showblips)
	
	if name == GetPlayerName(PlayerId()) and (showblips == true) then
		playerCanSee = true
	elseif name ==  GetPlayerName(PlayerId()) and (showblips == false) then
		playerCanSee = false
	end

	
	if (PlayerData.job ~= nil and PlayerData.job.name == 'offtaxi') or (playerCanSee == false) then
		for i = 0,255 do
			RemoveBlip(blips[i])
		end
	end
	

	if (PlayerData.job ~= nil and PlayerData.job.name == 'taxi') and playerCanSee then
	
		for i = 0,255 do
			RemoveBlip(blips[i])
		end
			
		for i=0,255 do
			for k,v in pairs(taxitable) do
				local playerPed = GetPlayerPed(i)
				if PlayerData ~= nil then

					local playerName = GetPlayerName(i)
					
					if playerName == taxitable[k].i then

						if playerPed ~= nil then
							local new_blip = AddBlipForEntity(playerPed)
							BeginTextCommandSetBlipName("STRING");
							AddTextComponentString(taxitable[k].name);
							EndTextCommandSetBlipName(new_blip);
							SetBlipColour(new_blip, 46)
							SetBlipCategory(new_blip, 2)
							SetBlipScale(new_blip, 1.1)
							blips[k] = new_blip
						else
							local jasem = true
							while jasem do
								playerPed = GetPlayerPed(-1)
								if playerPed ~= nil then
									jasem = false				
									local playerName = GetPlayerName(i)
									if playerName == taxitable[k].i then
										local new_blip = AddBlipForEntity(playerPed)
										BeginTextCommandSetBlipName("STRING");
										AddTextComponentString(taxitable[k].name);
										EndTextCommandSetBlipName(new_blip);
										SetBlipColour(new_blip, 46)
										SetBlipCategory(new_blip, 2)
										SetBlipScale(new_blip, 1.1)
										blips[k] = new_blip
									end
								end
								Citizen.Wait(0)
							end
						end
					end
				end
			end
		end
	end
end)
------------------------------------------------


--//mechanic/---
RegisterNetEvent('esx_tracker:updateMechanic')
AddEventHandler('esx_tracker:updateMechanic',function(mechanictable,name,showblips)

	if name == GetPlayerName(PlayerId()) and (showblips == true) then
		playerCanSee = true
	elseif name ==  GetPlayerName(PlayerId()) and (showblips == false) then
		playerCanSee = false
	end

	if (PlayerData.job ~= nil and PlayerData.job.name == 'offmechanic') or (playerCanSee == false) then
		for i = 0,255 do
			RemoveBlip(blips[i])
		end
	end

	if (PlayerData.job ~= nil and PlayerData.job.name == 'mechanic') and playerCanSee then
		for i = 0,255 do
			RemoveBlip(blips[i])
		end
			
		for i=0,255 do
			for k,v in pairs(mechanictable) do
				local playerPed = GetPlayerPed(i)
				if PlayerData ~= nil then
					local playerName = GetPlayerName(i)
					if playerName == mechanictable[k].i then
						if playerPed ~= nil then
							local new_blip = AddBlipForEntity(playerPed)
							BeginTextCommandSetBlipName("STRING");
							AddTextComponentString(mechanictable[k].name);
							EndTextCommandSetBlipName(new_blip);
							SetBlipColour(new_blip, 69)
							SetBlipCategory(new_blip, 2)
							SetBlipScale(new_blip, 1.1)
							blips[k] = new_blip
						else
							local jasem = true
							while jasem do
								playerPed = GetPlayerPed(-1)
								if playerPed ~= nil then
									jasem = false
									local playerName = GetPlayerName(i)
									if playerName == taxitable[k].i then
										local new_blip = AddBlipForEntity(playerPed)
										BeginTextCommandSetBlipName("STRING");
										AddTextComponentString(taxitable[k].name);
										EndTextCommandSetBlipName(new_blip);
										SetBlipColour(new_blip, 46)
										SetBlipCategory(new_blip, 2)
										SetBlipScale(new_blip, 1.1)
										blips[k] = new_blip
									end
								end

								Citizen.Wait(0)
							end
						end
					end
				end
			end
		end
	end
end)
------------------------------------------------