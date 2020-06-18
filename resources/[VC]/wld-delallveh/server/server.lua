--------------------------------------
------Created By Whit3Xlightning------
--https://github.com/Whit3XLightning--
--------------------------------------
ESX                = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand(Config.commandName, function(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.permission_level > 1 then
         TriggerClientEvent("wld:delallveh", -1)
    else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^1Admin ^0nistid!")
    end

end, false)
