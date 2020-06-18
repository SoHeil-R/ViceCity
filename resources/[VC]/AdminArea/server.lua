---------------------------------
--- Admin Area, Made by FAXES ---
---------------------------------
ESX                 = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('setada', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.permission_level > 1 then

        if xPlayer.get('aduty') then
            local radius = tonumber(args[1])
            TriggerClientEvent("Fax:AdminAreaSet", -1, source, radius)
        else
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
        end

    else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma admin nistid!")
    end
end)

RegisterCommand('clearada', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer.permission_level > 1 then

        if xPlayer.get('aduty') then
              TriggerClientEvent("Fax:AdminAreaClear", -1, source)
        else
              TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
        end

    else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma admin nistid!")
    end
end)