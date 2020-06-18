ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_securitycam:unhackanimserver')
AddEventHandler('esx_securitycam:unhackanimserver', function()
	local _source = source
	TriggerClientEvent('esx_securitycam:unhackanim', _source)
end)

RegisterServerEvent('esx_securitycam:setBankHackedState')
AddEventHandler('esx_securitycam:setBankHackedState', function(state)
	print(('esx_securitycam: %s has set the bank cameras to %s!'):format(GetPlayerIdentifiers(source)[1], state))
	TriggerClientEvent('esx_securitycam:setBankHackedState', -1, state)
end)

RegisterServerEvent('esx_securitycam:setPoliceHackedState')
AddEventHandler('esx_securitycam:setPoliceHackedState', function(state)
	print(('esx_securitycam: %s has set the police cameras to %s!'):format(GetPlayerIdentifiers(source)[1], state))
	TriggerClientEvent('esx_securitycam:setPoliceHackedState', -1, state)
end)