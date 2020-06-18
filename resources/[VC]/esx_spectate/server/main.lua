ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)

TriggerEvent('es:addAdminCommand', 'spec', 1, function(source, args, user)
    TriggerClientEvent('esx_spectate:spectate', source, target)
end, function(source, args, user)
    TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end)

ESX.RegisterServerCallback('esx_spectate:getPlayerData', function(source, cb, id)
    local xPlayer = ESX.GetPlayerFromId(id)
    if xPlayer ~= nil then
        cb(xPlayer)
    end
end)

RegisterServerEvent('esx_spectate:kick')
AddEventHandler('esx_spectate:kick', function(target, msg)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level > 0 then
		DropPlayer(target, msg)
	else
		print(('esx_spectate: %s attempted to kick a player!'):format(xPlayer.identifier))
		DropPlayer(source, "esx_spectate: you're not authorized to kick people dummy.")
	end
end)

ESX.RegisterServerCallback('esx_spectate:getOtherPlayerData', function(source, cb, target)
        
        local xPlayer = ESX.GetPlayerFromId(target)
        if xPlayer ~= nil then
            local identifier = GetPlayerIdentifiers(target)[1]
            
            local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
                ['@identifier'] = identifier
            })
            
            local name = string.gsub(result[1].playerName, "_", " ")
            local sex = result[1].sex
            local dob = result[1].dateofbirth
            local money = result[1].money
            local bank = result[1].bank
            
            local data = {
                name = GetPlayerName(target),
                job = xPlayer.job,
                inventory = xPlayer.inventory,
                weapons = xPlayer.loadout,
                name = name,
                sex = sex,
                dob = dob,
                money = money,
                bank = bank
            }
            
            TriggerEvent('esx_license:getLicenses', target, function(licenses)
                data.licenses = licenses
                cb(data)
            end)
        end
end)
