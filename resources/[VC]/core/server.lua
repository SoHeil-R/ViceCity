ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CheckSwat(target, cb)
    local xPlayer = ESX.GetPlayerFromId(target)
	MySQL.Async.fetchAll(
		'SELECT IsSwat FROM users WHERE identifier=@identifier',
		{
            ['@identifier'] = xPlayer.identifier,
        }, function(result)
			if result[1].IsSwat then
				cb(true)
			else
				cb(false)
			end

		end
	)
end

function CheckSheriff(target, cb)
    local xPlayer = ESX.GetPlayerFromId(target)
	MySQL.Async.fetchAll(
		'SELECT IsSheriff FROM users WHERE identifier=@identifier',
		{
            ['@identifier'] = xPlayer.identifier,
        }, function(result)
			if result[1].IsSheriff then
				cb(true)
			else
				cb(false)
			end

		end
	)
end

function CheckHR(target, cb)
    local xPlayer = ESX.GetPlayerFromId(target)
	MySQL.Async.fetchAll(
		'SELECT IsSheriff FROM users WHERE identifier=@identifier',
		{
            ['@identifier'] = xPlayer.identifier,
        }, function(result)
			if result[1].IsHR then
				cb(true)
			else
				cb(false)
			end

		end
	)
end

function CheckXray(target, cb)
    local xPlayer = ESX.GetPlayerFromId(target)
	MySQL.Async.fetchAll(
		'SELECT IsXray FROM users WHERE identifier=@identifier',
		{
            ['@identifier'] = xPlayer.identifier,
        }, function(result)
			if result[1].IsXray then
				cb(true)
			else
				cb(false)
			end

		end
	)
end

ESX.RegisterServerCallback('esx_core:checkswat', function(source, cb, target)
	CheckSwat(target, cb)
end)

ESX.RegisterServerCallback('esx_core:checksheriff', function(source, cb, target)
	CheckSheriff(target, cb)
end)

ESX.RegisterServerCallback('esx_core:checkhr', function(source, cb, target)
	CheckHR(target, cb)
end)

ESX.RegisterServerCallback('esx_core:checkxray', function(source, cb, target)
	CheckXray(target, cb)
end)

RegisterCommand("division", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer["job"]["name"] == "police" then
        if xPlayer["job"]["grade"] == 7 or xPlayer["job"]["grade"] == 8 then
    if args[1] and args[2] and args[3] then
        local target = tonumber(args[1])
        if target ~= nil then
            if GetPlayerName(target) then
                local TargetPlayer = ESX.GetPlayerFromId(target)
                if TargetPlayer["job"]["name"] == "police" or TargetPlayer["job"]["name"] == "offpolice" then
            if args[2] == 'detective' then

                if args[3] == 'false' or args[3] == 'true' then
                    if args[3] == 'true' then
                        MySQL.Async.execute('UPDATE users SET IsDetective=true WHERE identifier=@identifier', 
                        {
                            ['@identifier'] = GetPlayerIdentifiers(target)[1], 
                            
                        }, function(rowsChanged)
                            if rowsChanged > 0 then
                                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma be ^2" .. GetPlayerName(target) .. " ^0Rank detective dadid!")
                                TriggerClientEvent('chatMessage', target, "[SYSTEM]", {255, 0, 0}, " ^0Shoma vared divison ^2Detective ^0shodid!")
                            end
                        end)
                else
                    MySQL.Async.execute('UPDATE users SET IsDetective=false WHERE identifier=@identifier', 
                    {
                        ['@identifier'] = GetPlayerIdentifiers(target)[1], 
                        
                    }, function(rowsChanged)
                        if rowsChanged > 0 then
                            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma az ^1" .. GetPlayerName(target) .. " ^0Rank detective ra gereftid!")
                            TriggerClientEvent('chatMessage', target, "[SYSTEM]", {255, 0, 0}, " ^0Shoma az divison ^2Detective ^1Ekhraj ^0shodid!")
                        end
                    end)
                end
                else
                    TriggerClientEvent('esx:showNotification', source, '~r~~h~voroudi true/false ast')
                end

            elseif args[2] == 'swat' then

                if args[3] == 'false' or args[3] == 'true' then
                    if args[3] == 'true' then
                        MySQL.Async.execute('UPDATE users SET IsSwat=true WHERE identifier=@identifier', 
                        {
                            ['@identifier'] = GetPlayerIdentifiers(target)[1], 
                            
                        }, function(rowsChanged)
                            if rowsChanged > 0 then
                                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma be ^2" .. GetPlayerName(target) .. " ^0Rank SWAT dadid!")
                                TriggerClientEvent('chatMessage', target, "[SYSTEM]", {255, 0, 0}, " ^0Shoma vared divison ^2SWAT ^0shodid!")
                            end
                        end)
                else
                    MySQL.Async.execute('UPDATE users SET IsSwat=false WHERE identifier=@identifier', 
                    {
                        ['@identifier'] = GetPlayerIdentifiers(target)[1], 
                        
                    }, function(rowsChanged)
                        if rowsChanged > 0 then
                            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma az ^1" .. GetPlayerName(target) .. " ^0Rank SWAT ra gereftid!")
                            TriggerClientEvent('chatMessage', target, "[SYSTEM]", {255, 0, 0}, " ^0Shoma az divison ^2SWAT ^1Ekhraj ^0shodid!")
                        end
                    end)
                end
                else
                        TriggerClientEvent('esx:showNotification', source, '~r~~h~voroudi true/false ast')
                end  
                
            elseif args[2] == 'sheriff' then

                if args[3] == 'false' or args[3] == 'true' then
                    if args[3] == 'true' then
                        MySQL.Async.execute('UPDATE users SET IsSheriff=true WHERE identifier=@identifier', 
                        {
                            ['@identifier'] = GetPlayerIdentifiers(target)[1], 
                            
                        }, function(rowsChanged)
                            if rowsChanged > 0 then
                                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma be ^2" .. GetPlayerName(target) .. " ^0Rank Sheriff dadid!")
                                TriggerClientEvent('chatMessage', target, "[SYSTEM]", {255, 0, 0}, " ^0Shoma vared divison ^2Sheriff ^0shodid!")
                            end
                        end)
                else
                    MySQL.Async.execute('UPDATE users SET IsSheriff=false WHERE identifier=@identifier', 
                    {
                        ['@identifier'] = GetPlayerIdentifiers(target)[1], 
                        
                    }, function(rowsChanged)
                        if rowsChanged > 0 then
                            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma az ^1" .. GetPlayerName(target) .. " ^0Rank Sheriff ra gereftid!")
                            TriggerClientEvent('chatMessage', target, "[SYSTEM]", {255, 0, 0}, " ^0Shoma az divison ^2Sheriff ^1Ekhraj ^0shodid!")
                        end
                    end)
                end
                else
                        TriggerClientEvent('esx:showNotification', source, '~r~~h~voroudi true/false ast')
                end 
                
            elseif args[2] == 'hr' then

                if args[3] == 'false' or args[3] == 'true' then
                    if args[3] == 'true' then
                        MySQL.Async.execute('UPDATE users SET IsHR=true WHERE identifier=@identifier', 
                        {
                            ['@identifier'] = GetPlayerIdentifiers(target)[1], 
                            
                        }, function(rowsChanged)
                            if rowsChanged > 0 then
                                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma be ^2" .. GetPlayerName(target) .. " ^0Rank HumanResource dadid!")
                                TriggerClientEvent('chatMessage', target, "[SYSTEM]", {255, 0, 0}, " ^0Shoma vared divison ^2HumanResource ^0shodid!")
                            end
                        end)
                else
                    MySQL.Async.execute('UPDATE users SET IsHR=false WHERE identifier=@identifier', 
                    {
                        ['@identifier'] = GetPlayerIdentifiers(target)[1], 
                        
                    }, function(rowsChanged)
                        if rowsChanged > 0 then
                            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma az ^1" .. GetPlayerName(target) .. " ^0Rank HumanResource ra gereftid!")
                            TriggerClientEvent('chatMessage', target, "[SYSTEM]", {255, 0, 0}, " ^0Shoma az divison ^2HumanResource ^1Ekhraj ^0shodid!")
                        end
                    end)
                end
                else
                        TriggerClientEvent('esx:showNotification', source, '~r~~h~voroudi true/false ast')
                end 

            elseif args[2] == 'xray' then

                if args[3] == 'false' or args[3] == 'true' then
                    if args[3] == 'true' then
                        MySQL.Async.execute('UPDATE users SET IsXray=true WHERE identifier=@identifier', 
                        {
                            ['@identifier'] = GetPlayerIdentifiers(target)[1], 
                            
                        }, function(rowsChanged)
                            if rowsChanged > 0 then
                                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma be ^2" .. GetPlayerName(target) .. " ^0Rank Xray dadid!")
                                TriggerClientEvent('chatMessage', target, "[SYSTEM]", {255, 0, 0}, " ^0Shoma vared divison ^2Xray ^0shodid!")
                            end
                        end)
                else
                    MySQL.Async.execute('UPDATE users SET IsXray=false WHERE identifier=@identifier', 
                    {
                        ['@identifier'] = GetPlayerIdentifiers(target)[1], 
                        
                    }, function(rowsChanged)
                        if rowsChanged > 0 then
                            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma az ^1" .. GetPlayerName(target) .. " ^0Rank Xray ra gereftid!")
                            TriggerClientEvent('chatMessage', target, "[SYSTEM]", {255, 0, 0}, " ^0Shoma az divison ^2Xray ^1Ekhraj ^0shodid!")
                        end
                    end)
                end
                else
                        TriggerClientEvent('esx:showNotification', source, '~r~~h~voroudi true/false ast')
                end 

            else
                TriggerClientEvent('esx:showNotification', source, '~r~~h~Divison mored nazar shoma vojoud nadarad!')
            end
        else
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^1" .. GetPlayerName(target) .. " ^0Police nist!")
        end
           else
            TriggerClientEvent('esx:showNotification', source, '~r~~h~Player mored nazar online nist!')
        end
        else
            TriggerClientEvent('esx:showNotification', source, '~r~h~Shoma dar ghesmat ID faghat bayad adad vared konid')
            
        end
    else
        TriggerClientEvent('esx:showNotification', source, '~r~~h~Syntax Eshtebah ast')
    end
else
    TriggerClientEvent('esx:showNotification', source, '~r~~h~Dastresi shoma baraye in dastor kafi nist')
end
else
    TriggerClientEvent('esx:showNotification', source, '~r~~h~Shoma police nistid')
end
end)

RegisterCommand('changeoutfit', function(source)
    MySQL.Async.fetchAll("SELECT IsDetective FROM users WHERE identifier=@identifier",{
        ['@identifier'] = GetPlayerIdentifiers(source)[1],
    }, 
    function(result)
            if result[1].IsDetective then
                 TriggerClientEvent('outfitHandler', source)
            else
                TriggerClientEvent('esx:showNotification', source, '~r~~h~Shoma Detective nistid')
            end
    end)
    
end)

RegisterCommand('vest', function(source)
    MySQL.Async.fetchAll("SELECT IsDetective FROM users WHERE identifier=@identifier",{
        ['@identifier'] = GetPlayerIdentifiers(source)[1],
    }, 
    function(result)
            if result[1].IsDetective then
                 TriggerClientEvent('vestHandler', source)
            else
                TriggerClientEvent('esx:showNotification', source, '~r~~h~Shoma Detective nistid')
            end
    end)
    
end)

RegisterCommand('mask', function(source)
    MySQL.Async.fetchAll("SELECT IsDetective FROM users WHERE identifier=@identifier",{
        ['@identifier'] = GetPlayerIdentifiers(source)[1],
    }, 
    function(result)
            if result[1].IsDetective then
                 TriggerClientEvent('maskHandler', source)
            else
                TriggerClientEvent('esx:showNotification', source, '~r~~h~Shoma Detective nistid')
            end
    end)
    
end)

RegisterCommand('invite', function(source, args, users)
    MySQL.Async.fetchAll("SELECT IsHR FROM users WHERE identifier=@identifier",{
        ['@identifier'] = GetPlayerIdentifiers(source)[1],
    }, 
    function(result)
            if result[1].IsHR then
                local sourcePlayer = ESX.GetPlayerFromId(source)
                if sourcePlayer.job.name == 'police' then
                if args[1] then
                if tonumber(args[1]) then
                    local target = tonumber(args[1])
                    local xPlayer = ESX.GetPlayerFromId(args[1])
            
                    if xPlayer then
                        if xPlayer.job.name ~= "police" and xPlayer.job.name ~= "offpolice" and xPlayer.job.name ~= "psuspend" then
                            xPlayer.setJob('police', 0)
                            TriggerClientEvent('chatMessage', source, "[POLICE]", {255, 0, 0}, " ^0Shoma ^2" .. GetPlayerName(args[1]) .. " ^0Ra estekhdam kardid!")
                            TriggerClientEvent('chatMessage', target, "[POLICE]", {255, 0, 0}, " ^2" .. GetPlayerName(source) .. " ^0Shoma ra estekhdam kard!")
                        else
                            TriggerClientEvent('esx:showNotification', source, '~r~~h~Player mored nazar dar hale hazer police hast!')
                        end
                    else
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0player mored nazar online nist")
                    end
                else
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0shoma faghat mitavanid az adad dar ghesmat ID estefade konid")
                end
            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0shoma dar ghesmat id chizi vared nakardid")
            end
        else
            TriggerClientEvent('esx:showNotification', source, '~r~~h~Shoma police ya onduty nistid')
        end
            else
                TriggerClientEvent('esx:showNotification', source, '~r~~h~Shoma ozv HumanResource nistid')
            end
    end)
end)

RegisterCommand('pkick', function(source, args, users)
    MySQL.Async.fetchAll("SELECT IsHR FROM users WHERE identifier=@identifier",{
        ['@identifier'] = GetPlayerIdentifiers(source)[1],
    }, 
    function(result)
            if result[1].IsHR then
                local sourcePlayer = ESX.GetPlayerFromId(source)
                if sourcePlayer.job.name == 'police' then
                if args[1] then
                if tonumber(args[1]) then
                    local target = tonumber(args[1])
                    local xPlayer = ESX.GetPlayerFromId(args[1])
                    
            
                    if xPlayer then
                        if xPlayer.job.name == "police" or xPlayer.job.name == "offpolice" or xPlayer.job.name == "psuspend" then
                            if sourcePlayer.job.grade > xPlayer.job.grade then
                            xPlayer.setJob('unemployed', 0)
                            TriggerClientEvent('chatMessage', source, "[POLICE]", {255, 0, 0}, " ^0Shoma ^1" .. GetPlayerName(args[1]) .. " ^0Ra az PD ekhraj kadid!")
                            TriggerClientEvent('chatMessage', target, "[POLICE]", {255, 0, 0}, " ^2" .. GetPlayerName(source) .. " ^0Shoma ra az PD ekhraj kard!")
                            else
                                TriggerClientEvent('esx:showNotification', source, '~r~~h~Shoma nemitavanid kasi ke rank bala tari az shoma darad ra kick konid!')
                            end
                        else
                            TriggerClientEvent('esx:showNotification', source, '~r~~h~Shakhs mored nazar police nist!')
                        end
                    else
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0player mored nazar online nist")
                    end
                else
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0shoma faghat mitavanid az adad dar ghesmat ID estefade konid")
                end
            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0shoma dar ghesmat id chizi vared nakardid")
            end
        else
            TriggerClientEvent('esx:showNotification', source, '~r~~h~Shoma police ya onduty nistid')
        end
            else
                TriggerClientEvent('esx:showNotification', source, '~r~~h~Shoma ozv HumanResource nistid')
            end
    end)
end)

RegisterCommand('suspend', function(source, args, users)
    MySQL.Async.fetchAll("SELECT IsHR FROM users WHERE identifier=@identifier",{
        ['@identifier'] = GetPlayerIdentifiers(source)[1],
    }, 
    function(result)
            if result[1].IsHR then
                local sourcePlayer = ESX.GetPlayerFromId(source)
                if sourcePlayer.job.name == 'police' then
                if args[1] then
                if tonumber(args[1]) then
                    local target = tonumber(args[1])
                    local xPlayer = ESX.GetPlayerFromId(args[1])
                    
            
                    if xPlayer then
                        if xPlayer.job.name == "police" or xPlayer.job.name == "offpolice" or xPlayer.job.name == "psuspend" then
                            if sourcePlayer.job.grade > xPlayer.job.grade then
                                xPlayer.setJob('psuspend', xPlayer.job.grade)
                                TriggerClientEvent('chatMessage', source, "[POLICE]", {255, 0, 0}, " ^0Shoma ^1" .. GetPlayerName(args[1]) .. " ^0Ra suspend kardid!")
                                TriggerClientEvent('chatMessage', target, "[POLICE]", {255, 0, 0}, " ^2" .. GetPlayerName(source) .. " ^0Shoma ra suspend kard!")
                            else
                                TriggerClientEvent('esx:showNotification', source, '~r~~h~Shoma nemitavanid kasi ke rank bala tari az shoma darad ra suspend konid!')
                            end
                        else
                            TriggerClientEvent('esx:showNotification', source, '~r~~h~Shakhs mored nazar police nist!')
                        end
                    else
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0player mored nazar online nist")
                    end
                else
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0shoma faghat mitavanid az adad dar ghesmat ID estefade konid")
                end
            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0shoma dar ghesmat id chizi vared nakardid")
            end
        else
            TriggerClientEvent('esx:showNotification', source, '~r~~h~Shoma police ya onduty nistid')
        end
            else
                TriggerClientEvent('esx:showNotification', source, '~r~~h~Shoma ozv HumanResource nistid')
            end
    end)
end)

RegisterCommand('findnumber', function(source, args, users)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == "police" then

        if args[1] then

            if string.len(args[1]) == 10 then

            number = tonumber(args[1])

                if number then

                    MySQL.Async.fetchAll('SELECT playerName FROM users WHERE phone_number=@number', 
                    {
                        ['@number'] =  number

                    }, function(data)
                        if data[1] then

                            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0 In Shomare be naame ^3" .. string.gsub(data[1].playerName, "_", " ") .. " ^0Ast!")
                                                    
                        else

                            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "^0 In shomare vojoud nadarad")
                            
                        end
                    end)

                else
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat Shomare vaghat mitavanid adad vared konid!")
                end
            
            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shomare bayad 11 raghami bashad!")
            end

        else
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat Shomare chizi vared nakardid!")
        end

    else
        TriggerClientEvent('chatMessage', source, "[POLICE]", {255, 0, 0}, " ^0Shoma police nistid!")
    end
end)

RegisterCommand('unsuspend', function(source, args, users)
    MySQL.Async.fetchAll("SELECT IsHR FROM users WHERE identifier=@identifier",{
        ['@identifier'] = GetPlayerIdentifiers(source)[1],
    }, 
    function(result)
            if result[1].IsHR then
                local sourcePlayer = ESX.GetPlayerFromId(source)
                if sourcePlayer.job.name == 'police' then
                if args[1] then
                if tonumber(args[1]) then
                    local target = tonumber(args[1])
                    local xPlayer = ESX.GetPlayerFromId(args[1])
                    
            
                    if xPlayer then
                        if xPlayer.job.name == "psuspend" then
                            if sourcePlayer.job.grade > xPlayer.job.grade then
                                xPlayer.setJob('offpolice', xPlayer.job.grade)
                                TriggerClientEvent('chatMessage', source, "[POLICE]", {255, 0, 0}, " ^0Shoma ^1" .. GetPlayerName(args[1]) .. " ^0Ra az suspend daravardid!")
                                TriggerClientEvent('chatMessage', target, "[POLICE]", {255, 0, 0}, " ^2" .. GetPlayerName(source) .. " ^0Shoma ra az suspend daravard!")
                            else
                                TriggerClientEvent('esx:showNotification', source, '~r~~h~Shoma nemitavanid kasi ke rank bala tari az shoma darad ra az suspend daravarid!')
                            end
                        else
                            TriggerClientEvent('esx:showNotification', source, '~r~~h~Shakhs mored nazar suspend nist!')
                        end
                    else
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0player mored nazar online nist")
                    end
                else
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0shoma faghat mitavanid az adad dar ghesmat ID estefade konid")
                end
            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0shoma dar ghesmat id chizi vared nakardid")
            end
        else
            TriggerClientEvent('esx:showNotification', source, '~r~~h~Shoma police ya onduty nistid')
        end
            else
                TriggerClientEvent('esx:showNotification', source, '~r~~h~Shoma ozv HumanResource nistid')
            end
    end)
end)

RegisterCommand('fine', function(source, args, users)
                local xPlayer = ESX.GetPlayerFromId(source)
                if xPlayer.permission_level > 1 then
                    if args[1] and args[2] and args[3] then
                        target = tonumber(args[1]) 
                     if target then

                        if GetPlayerName(target) then
                            local targetPlayer = ESX.GetPlayerFromId(target)
                            money = tonumber(args[2])
                            if money then
                                       if targetPlayer.bank >= money then

                                         local previousmoney = targetPlayer.bank
                                         targetPlayer.removeBank(money)
                                         TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma az^1 " .. GetPlayerName(target) .. " ^0Mablagh ^2" .. money .. "$ ^0kam kardid!" )
                                         TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Pool ghadimi ^3" .. GetPlayerName(target) .. " ^1" .. previousmoney .. "$^0 Pool jadid ^2" .. targetPlayer.bank .. "$" )

                                            local reason = table.concat(args, " ",3)
                                            TriggerClientEvent('chatMessage', -1, "[SYSTEM]", {255, 0, 0}, " ^6" .. GetPlayerName(target) .. " ^2" .. money .. "$ ^0 Jarime shod be elat ^3^*" .. reason )
                                            

                                            MySQL.Async.execute('INSERT INTO fines (identifier, name, fineamount, reason, punisher) VALUES (@identifier, @name, @fineamount, @reason, @punisher)', 
                                            {
                                                ['@identifier'] = GetPlayerIdentifiers(target)[1], 
                                                ['@name'] = GetPlayerName(target),
                                                ['@fineamount'] = money,
                                                ['@reason'] = reason,
                                                ['@punisher']= GetPlayerName(source)
                                            })

                                       else
                                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Pool player mored nazar baraye in meghdar az jarime kafi nist!")
                                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Poole ^1" .. GetPlayerName(target) .. " ^2" .. targetPlayer.bank .. "$ ^0ast!" )
                                       end
                            else
                                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat fine faghat mitavanid adad vared konid!")
                            end

                        else
                            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Player mored nazar online nist!")
                        end

                     else
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat ID faghat mitavanid adad vared konid!")
                     end
                    else
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Syntax vared shode eshtebah ast!")
                    end
                else
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma admin nistid!")
                end
end)

function GetCharacterName(source)
    local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
        ['@identifier'] = GetPlayerIdentifiers(source)[1]
    })

    if result[1] and result[1].firstname and result[1].lastname then
        return ('%s %s'):format(result[1].firstname, result[1].lastname)
    else
        return GetPlayerName(source)
    end
end

RegisterCommand('f', function(source, args)

    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == "police" or xPlayer.job.name == "offpolice" or xPlayer.job.name == "psuspend" or xPlayer.job.name == "ambulance" or xPlayer.job.name == "offambulance" or xPlayer.job.name == "mechanic" or xPlayer.job.name == "offmecano" then
        if args[1] then

                        local dutytext = nil
                        local jobGrade = xPlayer.job.grade_label
                        local name = GetPlayerName(source)
                        local message = table.concat(args, " ")
                        

                        if xPlayer.job.name == "police" or xPlayer.job.name == "ambulance" or xPlayer.job.name == "mechanic" then

                            dutytext = "^4[^2^*On-Duty ^4| ^1^*"

                        elseif xPlayer.job.name == "offpolice" or xPlayer.job.name == "offambulance" or xPlayer.job.name == "offmecano" then

                            dutytext = "^4[^2^*Off-Duty ^4| ^1^*"

                        elseif xPlayer.job.name == "psuspend" then

                            dutytext = "^4[^2^*Suspended ^4| ^1^*"

                        end

                        if xPlayer.job.name == "police" or xPlayer.job.name == "offpolice" or xPlayer.job.name == "psuspend" then

                            local xPlayers = ESX.GetPlayers()

                            for i=1, #xPlayers, 1 do

                                local xP = ESX.GetPlayerFromId(xPlayers[i])

                                if xP.job.name == 'police' or xP.job.name == "offpolice" or xP.job.name == "psuspend" then

                                    TriggerClientEvent('chatMessage', xPlayers[i], "", {255, 0, 0}, dutytext .. "^1" ..jobGrade .. "^4]: ^3" .. name .. " ^4(( " .. "^0^*" .. message .. "^4 ))")

                                end

                            end

                        end

                        -- age player medic bod

                        if xPlayer.job.name == "ambulance" or xPlayer.job.name == "offambulance" then

                            local xPlayers = ESX.GetPlayers()

                            for i=1, #xPlayers, 1 do

                                local xP = ESX.GetPlayerFromId(xPlayers[i])

                                if xP.job.name == 'ambulance' or xP.job.name == "offambulance" then

                                    TriggerClientEvent('chatMessage', xPlayers[i], "", {255, 0, 0}, dutytext .. "^1" ..jobGrade .. "^4]: ^3" .. name .. " ^4(( " .. "^0^*" .. message .. "^4 ))")

                                end

                            end

                        end

                        -- age player mechanic bod

                        if xPlayer.job.name == "mechanic" or xPlayer.job.name == "offmecano" then

                            local xPlayers = ESX.GetPlayers()

                            for i=1, #xPlayers, 1 do

                                local xP = ESX.GetPlayerFromId(xPlayers[i])

                                if xP.job.name == 'mechanic' or xP.job.name == 'offmecano' then

                                    TriggerClientEvent('chatMessage', xPlayers[i], "", {255, 0, 0}, dutytext .. "^1" ..jobGrade .. "^4]: ^3" .. name .. " ^4(( " .. "^0^*" .. message .. "^4 ))")

                                end

                            end

                        end

                    else
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid matn khali befrestid!")
                    end

    else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ozv department haye dolati nistid!")
    end

end)

function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end

TriggerEvent('es:addCommand', 'tas', function(source, args, user)
	local lngth = tablelength(args)
	if(lngth ~= 1) then
		TriggerEvent('tas:error', source, "/tas (tedad)")
		return
	end
	-- if(~is_int(args[1])) then
	-- 	return
	-- end

	
	local count = tonumber(args[1])
	if( count >= 5) then
		TriggerEvent('tas:error', source, "kheyli ziad shod")
		return
	end
    
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = xPlayer.name
    local words = {}
    local word = {}
    for w in (name):gmatch("([^_]*)") do 
        table.insert(words, w)
    end
    for w in (name):gmatch("([^_]*)") do 
        table.insert(word, w)
    end

	local text = math.random(1,6)
	for i = 2,count do
        text = text .. ', ' .. math.random(1,6)
	end
	TriggerClientEvent("sendRollThatShit", source)
	TriggerClientEvent("sendTasMessage", -1, source, "^1Tas(^3" .. word[1] .. "^1)", text)
end)



AddEventHandler('tas:error', function(source, message)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1Tas', message } } )
end)