ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('neons', function(source)
    TriggerClientEvent('neonHandler', source)  
end)

RegisterCommand('changecolor', function(source)
    MySQL.Async.fetchAll("SELECT IsDetective FROM users WHERE identifier=@identifier",{
        ['@identifier'] = GetPlayerIdentifiers(source)[1],
    }, 
    function(result)
            print(result[1].IsDetective)
            if result[1].IsDetective then
                 TriggerClientEvent('vehicleColorChanger', source)
            else
                TriggerClientEvent('esx:showNotification', source, '~r~~h~Shoma Detective nistid')
            end
    end)
    
end)