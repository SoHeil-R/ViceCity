ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('flist', function(source, args, rawCommand)
    
        xPlayer = ESX.GetPlayerFromId(source)
        job = string.lower(xPlayer.job.name)

        if job == "police" then

            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local xP = ESX.GetPlayerFromId(xPlayers[i])
                xPJob = string.lower(xP.job.name)
                if xPJob == 'police' then
                    TriggerClientEvent('chat:addMessage', source, {
                      color = { 255, 0, 0},
                      multiline = true,
                        args = {"^4[^2^*On-Duty^4] ^7" .. string.gsub(xP.name, "_", " ") }
                    })
                elseif xPJob == 'offpolice' then
                    TriggerClientEvent('chat:addMessage', source, {
                      color = { 255, 0, 0},
                      multiline = true,
                        args = {"^4[^1^*Off-Duty^4] ^7" .. string.gsub(xP.name, "_", " ")  }
                    })
                end
            end
        elseif job == "ambulance" then

            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local xP = ESX.GetPlayerFromId(xPlayers[i])
                xPJob = string.lower(xP.job.name)
                if xPJob == 'ambulance' then
                    TriggerClientEvent('chat:addMessage', source, {
                      color = { 255, 0, 0},
                      multiline = true,
                        args = {"^4[^2^*On-Duty^4] ^7" .. string.gsub(xP.name, "_", " ")  }
                    })
                elseif xPJob == 'offambulance' then
                    TriggerClientEvent('chat:addMessage', source, {
                      color = { 255, 0, 0},
                      multiline = true,
                        args = {"^4[^1^*Off-Duty^4] ^7" .. string.gsub(xP.name, "_", " ")  }
                    })
                end
            end
        elseif job == "offpolice" then

            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local xP = ESX.GetPlayerFromId(xPlayers[i])
                xPJob = string.lower(xP.job.name)
                if xPJob == 'police' then
                    TriggerClientEvent('chat:addMessage', source, {
                      color = { 255, 0, 0},
                      multiline = true,
                        args = {"^4[^2^*On-Duty^4] ^7" .. string.gsub(xP.name, "_", " ")  }
                    })
                else if xPJob == 'offpolice' then
                    TriggerClientEvent('chat:addMessage', source, {
                      color = { 255, 0, 0},
                      multiline = true,
                        args = {"^4[^1^*Off-Duty^4] ^7" .. string.gsub(xP.name, "_", " ")  }
                    })
                end
            end
        end
        elseif job == "offambulance" then

            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local xP = ESX.GetPlayerFromId(xPlayers[i])
                xPJob = string.lower(xP.job.name)
                if xPJob == 'ambulance' then
                    TriggerClientEvent('chat:addMessage', source, {
                      color = { 255, 0, 0},
                      multiline = true,
                        args = {"^4[^2^*On-Duty^4] ^7" .. string.gsub(xP.name, "_", " ")  }
                    })
                elseif xPJob == 'offambulance' then
                    TriggerClientEvent('chat:addMessage', source, {
                      color = { 255, 0, 0},
                      multiline = true,
                        args = {"^4[^1^*Off-Duty^4] ^7" .. string.gsub(xP.name, "_", " ")  }
                    })
                end
            end
        end
    end)
