local rackdata = {}
local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_rack:loaded')
AddEventHandler('esx_rack:loaded', function()

    local identifier = GetPlayerIdentifier(source)

        for i = 1, #rackdata do
            if rackdata[i].identifier == identifier then
                TriggerClientEvent('esx:rack:changeStatus', source, true, rackdata[i].licensePlate, rackdata[i].weaponName)
                return
            end
        end


end)

RegisterServerEvent('esx_rack:table')
AddEventHandler('esx_rack:table', function(status, data, plate)
    if status == "add" then
        
        local info = {identifier = GetPlayerIdentifier(source), weaponName = data, licensePlate = plate}
        table.insert(rackdata, info)

    elseif status == "remove" then

        local info = {identifier = GetPlayerIdentifier(source), weaponName = data, licensePlate = plate}

        for k,v in pairs(rackdata) do
            if rackdata[k].identifier == info.identifier then
                table.remove(rackdata, k)
            end
        end
    
    end
	

end)