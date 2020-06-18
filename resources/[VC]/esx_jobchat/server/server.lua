ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('flist', function(source, args, rawCommand)
    
        xPlayer = ESX.GetPlayerFromId(source)
        job = string.lower(xPlayer.job.name)
        playerCoords = GetEntityCoords()


        characterName = string.gsub(exports.essentialmode:GetPlayerICName(source), "_", " ");
        if characterName ~= nil then name = characterName end



        if job == "police" then

            jobGrade = str:gsub("^%l", string.upper)

            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local xP = ESX.GetPlayerFromId(xPlayers[i])
                xPJob = string.lower(xP.job.name)
                if xPJob == 'police' then
                    TriggerClientEvent('chat:addMessage', source, {
                      color = { 255, 0, 0},
                      multiline = true,
                        args = {"^4[^2^*On-Duty^4] ^3" .. name }
                    })
                elseif xPJob == 'offpolice' then
                    TriggerClientEvent('chat:addMessage', source, {
                      color = { 255, 0, 0},
                      multiline = true,
                        args = {"^4[^2^*Off-Duty^4] ^3" .. name }
                    })
                end
            end
        elseif job == "ambulance" then
            
            jobGrade = str:gsub("^%l", string.upper)

            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local xP = ESX.GetPlayerFromId(xPlayers[i])
                xPJob = string.lower(xP.job.name)
                if xPJob == 'ambulance' then
                    TriggerClientEvent('chat:addMessage', source, {
                      color = { 255, 0, 0},
                      multiline = true,
                        args = {"^4[^2^*On-Duty^4] ^3" .. name }
                    })
                elseif xPJob == 'offambulance' then
                    TriggerClientEvent('chat:addMessage', source, {
                      color = { 255, 0, 0},
                      multiline = true,
                        args = {"^4[^2^*Off-Duty^4] ^3" .. name }
                    })
                end
            end
        end
    end)
