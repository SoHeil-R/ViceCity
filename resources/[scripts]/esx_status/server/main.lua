ESX                    = nil
local RegisteredStatus = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_status:update')
AddEventHandler('esx_status:update', function(status)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil then
		xPlayer.set('status', status)
	end
end)