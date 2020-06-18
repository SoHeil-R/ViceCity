ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('chatMessage', function(source, name, msg)
    sm = stringsplit(msg, " ");
    if sm[1] == "/r" then
        CancelEvent()

        xPlayer = ESX.GetPlayerFromId(source)
        job = string.lower(xPlayer.job.name)
        playerCoords = GetEntityCoords()


        characterName = string.gsub(exports.essentialmode:GetPlayerICName(source), "_", " ");
        if characterName ~= nil then name = characterName end



        if job == "police" then
            
            str = xPlayer.job.grade_label
            jobGrade = str:gsub("^%l", string.upper)

            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local xP = ESX.GetPlayerFromId(xPlayers[i])
                xPJob = string.lower(xP.job.name)
				if xPJob ~= 'police' then
				TriggerClientEvent("sendProximityMessage", xPlayers[i], source, "^4[^2^*Radio^4] ^3" .. name.." ^8^*: ^r", "^0^* " .. string.sub(msg,4), { 0, 0, 255 }) end

                if xPJob == 'police' then
                    TriggerClientEvent('chat:addMessage', xPlayers[i], {
                      color = { 255, 0, 0},
                      multiline = true,
                        args = {"^4[^2^*Radio ^4| ^1^*".. jobGrade .. "^4] ^3" .. name.." ^8^*^~>>^r" .. "^0^* " .. string.sub(msg,4)}
                    })
                end
            end
        elseif job == "ambulance" then
            
            str = xPlayer.job.grade_label
            jobGrade = str:gsub("^%l", string.upper)

            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local xP = ESX.GetPlayerFromId(xPlayers[i])
                xPJob = string.lower(xP.job.name)
				if xPJob ~= 'ambulance' then
				TriggerClientEvent("sendProximityMessage", xPlayers[i], source, "^4[^2^*Radio^4] ^3" .. name.." ^8^*: ^r", "^0^* " .. string.sub(msg,4), { 0, 0, 255 }) end

                if xPJob == 'ambulance' then
                    TriggerClientEvent('chat:addMessage', xPlayers[i], {
                      color = { 255, 0, 0},
                      multiline = true,
                        args = {"^4[^2^*Radio ^4| ^1^*".. jobGrade .. "^4] ^3" .. name.." ^8^*^~>>^r" .. "^0^* " .. string.sub(msg,4)}
                    })
                end
            end
        elseif job == "mechanic" then
            
            str = xPlayer.job.grade_label
            jobGrade = str:gsub("^%l", string.upper)

            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local xP = ESX.GetPlayerFromId(xPlayers[i])
                xPJob = string.lower(xP.job.name)
				if xPJob ~= 'mechanic' then
				TriggerClientEvent("sendProximityMessage", xPlayers[i], source, "^4[^2^*Radio^4] ^3" .. name.." ^8^*: ^r", "^0^* " .. string.sub(msg,4), { 0, 0, 255 }) end

                if xPJob == 'mechanic' then
                    TriggerClientEvent('chat:addMessage', xPlayers[i], {
                      color = { 255, 0, 0},
                      multiline = true,
                        args = {"^4[^2^*Radio ^4| ^1^*".. jobGrade .. "^4] ^3" .. name.." ^8^*^~>>^r" .. "^0^* " .. string.sub(msg,4)}
                    })
                end
            end
        end
		
    elseif sm[1] == "/dep" then
        CancelEvent()

        xPlayer = ESX.GetPlayerFromId(source)
        job = string.lower(xPlayer.job.name)
        playerCoords = GetEntityCoords()
		jobs = xPlayer.job.name:gsub("^%l", string.upper)

        characterName = string.gsub(exports.essentialmode:GetPlayerICName(source), "_", " ");
        if characterName ~= nil then name = characterName end


        if job == "police" or job == "ambulance" or job == "mechanic" then
            
            str = xPlayer.job.grade_label
            jobGrade = str:gsub("^%l", string.upper)

            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local xP = ESX.GetPlayerFromId(xPlayers[i])
                xPJob = string.lower(xP.job.name)
				if xPJob ~= 'police' and xPJob ~='ambulance' and xPJob ~= 'mechanic' then
				TriggerClientEvent("sendProximityMessage", xPlayers[i], source, "^4[^2^*Radio^4] ^3" .. name.." ^8^*: ^r", "^0^* " .. string.sub(msg,6), { 0, 0, 255 })

                elseif xPJob == 'police' then
                    TriggerClientEvent('chat:addMessage', xPlayers[i], {
                      color = { 255, 0, 0},
                      multiline = true,
                        args = {"^4[^2^*Department ^4| ^1^*".. jobs .. "^4] ^3" .. name.." ^8^*:^r" .. "^0^* " .. string.sub(msg,6)}
                    })
				elseif xPJob == 'mechanic' then
                    TriggerClientEvent('chat:addMessage', xPlayers[i], {
                      color = { 255, 0, 0},
                      multiline = true,
                        args = {"^4[^2^*Department ^4| ^1^*".. jobs .. "^4] ^3" .. name.." ^8^*:^r" .. "^0^* " .. string.sub(msg,6)}
                    })
				elseif xPJob == 'ambulance' then
					TriggerClientEvent('chat:addMessage', xPlayers[i], {
                      color = { 255, 0, 0},
                      multiline = true,
                        args = {"^4[^2^*Department ^4| ^1^*".. jobs .. "^4] ^3" .. name.." ^8^*:^r" .. "^0^* " .. string.sub(msg,6)}
                    })
                end
            end
        end

    elseif sm[1] == "/news" then
        CancelEvent()

        xPlayer = ESX.GetPlayerFromId(source)
        job = string.lower(xPlayer.job.name)


        str = xPlayer.job.grade_label
        jobGrade = str:gsub("^%l", string.upper)

        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xP = ESX.GetPlayerFromId(xPlayers[i])
            xPJob = string.lower(xP.job.name)
            if xPJob == 'journaliste' then
                TriggerClientEvent('chat:addMessage', xPlayers[i], {
                    color = { 255, 0, 0},
                    multiline = true,
                    args = {"^4[^2 NEWS ^4]: ^3" .. name .. ": ^4 " .. "^0^*" .. string.sub(msg,6) .. "^4 "}
                })
            else
                TriggerClientEvent('esx:showNotification', source, '^4[^2 NEWS ^4]: ^3Payame Shoma daryaft shod! Lotfan mokhtasate khod ra az tarighe SMS ersal konid!')
            end
        end
    end
end)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end
function message(text)
    TriggerEvent("chatMessage", "[Server]", {255, 47, 47}, "^0" .. text)
end 