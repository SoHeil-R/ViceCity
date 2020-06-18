ESX = nil
local showGps = false
local keepHealthBar = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData() == nil do
		
		Citizen.Wait(10)
	end
	
	PlayerData = ESX.GetPlayerData()

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = ESX.GetPlayerData()

	TriggerEvent('esx_gps:removeGPS')
	TriggerEvent('streetlabel:changeGpsStatus', false)
	TriggerEvent('esx_voice:changeGpsStatus', false)

	for i=1, #PlayerData.inventory, 1 do
		if PlayerData.inventory[i].name == 'gps' then
			if PlayerData.inventory[i].count > 0 then
				TriggerEvent('esx_gps:addGPS')
				TriggerEvent('streetlabel:changeGpsStatus', true)
				TriggerEvent('esx_voice:changeGpsStatus', true)
			end
		end
	end

end)

RegisterNetEvent('esx_gps:addGPS')
AddEventHandler('esx_gps:addGPS', function()
	if keepHealthBar == true then
		showGps = true
	else
		DisplayRadar(true)
		TriggerEvent('streetlabel:changeGpsStatus', true)
		TriggerEvent('esx_voice:changeGpsStatus', true)
	end
end)

RegisterNetEvent('esx_gps:removeGPS')
AddEventHandler('esx_gps:removeGPS', function()
	if keepHealthBar == true then
		showGps = false
	else
		DisplayRadar(false)
		TriggerEvent('streetlabel:changeGpsStatus', false)
		TriggerEvent('esx_voice:changeGpsStatus', false)
	end

end)

Citizen.CreateThread(function()
	while keepHealthBar do
		Wait(0)
            if showGps == false then
            	DrawRect(0.085, 0.890, 0.14, 0.160, 0, 0, 0, 255);
            	SetRadarBigmapEnabled( false, false )
            end

		end
		
end)