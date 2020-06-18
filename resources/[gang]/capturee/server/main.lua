LiveCapture = nil
local DefinedCaptures = {}

exports.ghmattimysql:execute('SELECT * FROM capture', {}
, function(result)
    for k,v in pairs(result) do
        table.insert(DefinedCaptures, v)
    end
end)

-- {name = 'benzin', reward = 'fuel:ChangeFuelHandeler', coordinate = {x = -805.779, y = 189.870, z = 71.835}},
-- {name = 'drug'  , reward = 'drug:ChangeDrugHandeler', coordinate = {x = -805.779, y = 189.870, z = 71.835}},
-- {name = 'weapon', reward = 'weapon:ChangeHandeler'  , coordinate = {x = -805.779, y = 189.870, z = 71.835}}

AddEventHandler('esx:playerLoaded', function(source)
    if LiveCapture then
        TriggerClientEvent('capture:CaptureStarted', source, LiveCapture.capData, LiveCapture.untilEnd())
    end
end)

TriggerEvent('es:addAdminCommand', 'startcap', 6, function(source, args, user)

    local captureName
    if args[1] then
        captureName   = string.lower(args[1])
    else
        TriggerClientEvent('chat:addMessage', source, { args = { '^3Capture System', 'Lotfan Esm Capture ro vared konid' } })
        CancelEvent()
        return
    end
    local CapDetails


    if not LiveCapture then
        for k,v in pairs(DefinedCaptures) do
            if v.name == captureName then
                CapDetails = v
                break
            end
        end
        if CapDetails then
            LiveCapture = CreateCapture(CapDetails.name, json.decode(CapDetails.coordinate), CapDetails.reward, CapDetails.handeler)
        else
            TriggerClientEvent('chat:addMessage', source, { args = { '^3Capture System', captureName .. ' Esm Yek capture Nist!' } })
        end
    else
        TriggerClientEvent('chat:addMessage', source, { args = { '^3Capture System', 'Dar Hale Hazer Yek Capture dar jaryan ast' } })
    end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Start Kardan Capture", params = {{name = "Capture Name", help = "Esm Capture ro vared konid"}}})

RegisterNetEvent('capture:CaptureMe')
AddEventHandler('capture:CaptureMe', function()
    local _source       = source
    local Player        = ESX.GetPlayerFromId(_source)
    
    LiveCapture.NewHandeler(Player.gang.name)
end)