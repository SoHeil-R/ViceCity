--[[ Gets the ESX library ]]--
ESX = nil 
TriggerEvent("esx:getSharedObject", function(obj)
    ESX = obj
end)

RegisterNetEvent('99kr-shops:Cashier')
AddEventHandler('99kr-shops:Cashier', function(price, basket, account)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local gps, lighter, phone = xPlayer.getInventoryItem('gps'), xPlayer.getInventoryItem('lighter'), xPlayer.getInventoryItem('phone')

    if account == "cash" then
        xPlayer.removeMoney(price)
    else
        xPlayer.removeBank(price)
    end
    
    for i=1, #basket do

        if basket[i]["value"] == 'lighter' then

            if lighter.limit ~= -1 and lighter.count >= lighter.limit then
                pNotify('Shoma fazaye khali baraye Fandak nadarid', 'error', 7000)
            else

                xPlayer.addInventoryItem(basket[i]["value"], basket[i]["amount"])

            end

        elseif basket[i]["value"] == 'gps' then

            if gps.limit ~= -1 and gps.count >= gps.limit then
                pNotify('Shoma fazaye khali baraye GPS nadarid', 'error', 7000)
            else

                xPlayer.addInventoryItem(basket[i]["value"], basket[i]["amount"])

            end
        
        elseif basket[i]["value"] == 'phone' then

            if phone.limit ~= -1 and phone.count >= phone.limit then
                pNotify('Shoma fazaye khali baraye Goshi nardarid', 'error', 7000)
            else

                xPlayer.addInventoryItem(basket[i]["value"], basket[i]["amount"])

            end
        
        else

            xPlayer.addInventoryItem(basket[i]["value"], basket[i]["amount"])

        end
        
    end
    
    pNotify('Shoma mahsolat ro be gheymat for <span style="color: green">$' .. price .. '</span> Kharidari kardid', 'success', 7000)

end)

ESX.RegisterServerCallback('99kr-shops:CheckMoney', function(source, cb, price, account)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local money
    if account == "cash" then
        money = xPlayer.money
    else
        money = xPlayer.bank
    end

    if money >= price then
        cb(true)
    end
    cb(false)
end)

pNotify = function(message, messageType, messageTimeout)
	TriggerClientEvent("pNotify:SendNotification", source, {
		text = message,
		type = messageType,
		queue = "shop_sv",
		timeout = messageTimeout,
		layout = "bottomCenter"
	})
end