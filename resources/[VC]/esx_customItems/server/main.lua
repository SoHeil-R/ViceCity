ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('cigarett', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local lighter = xPlayer.getInventoryItem('lighter')

	if lighter.count > 0 then

		xPlayer.removeInventoryItem('cigarett', 1)
		TriggerClientEvent('esx_basicneeds:OnSmokeCigarett', source)
		TriggerClientEvent('esx:showNotification', source, ('Shoma shoro be keshidan cigar kardid'))

	else

		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma baraye etefade az cigar niaz be fandak darid!")

	end
		
end)

ESX.RegisterUsableItem('lotteryticket', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)


		xPlayer.removeInventoryItem('lotteryticket', 1)
		local reward = math.random(50, 150)
		xPlayer.addMoney(reward)
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma yek blit bakht azmayi baz kardid va ^2" .. reward .. "$ ^0 bordid")

		
end)

-- snacks
ESX.RegisterUsableItem('chips', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('chips', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 80000)
	TriggerClientEvent('esx_basicneeds:onEat', source, "prop_ld_snack_01")
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Chips ~w~khordid")

end)	

ESX.RegisterUsableItem('cheesebows', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cheesebows', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 120000)
	TriggerClientEvent('esx_basicneeds:onEat', source, "prop_food_bs_burger2")
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Snack ~w~khordid")

end)	

ESX.RegisterUsableItem('marabou', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('marabou', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 50000)
	TriggerClientEvent('esx_basicneeds:onEat', source, "prop_choc_ego")
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Shokolat ~w~khordid")

end)	
-- snacks

-- drinks
ESX.RegisterUsableItem('cocacola', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cocacola', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source, "prop_ecola_can")
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Noshabe ~w~noshidid")
	
end)	

ESX.RegisterUsableItem('fanta', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('fanta', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source, "ng_proc_sodacan_01b")
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Fanta ~w~noshidid")

end)

ESX.RegisterUsableItem('sprite', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sprite', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source, "ng_proc_sodacan_01b")
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Sprite ~w~noshidid")

end)

ESX.RegisterUsableItem('loka', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('loka', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Abmive ~w~noshidid")

end)
-- drinks	

-- foods
ESX.RegisterUsableItem('pizza', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('pizza', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Pitza ~w~khordid")

end)	

ESX.RegisterUsableItem('burger', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('burger', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 150000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Burger ~w~khordid")

end)	

ESX.RegisterUsableItem('macka', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('macka', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:onEat', source, "prop_ld_snack_01")
	TriggerClientEvent('esx:showNotification', source, "Shoma yek ~g~Pasta ~w~khordid")

end)
-- foods

--- black market items

RegisterServerEvent('esx_customItems:remove')
AddEventHandler('esx_customItems:remove', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(itemName, 1)
end)

ESX.RegisterUsableItem('clip', function(source)
	TriggerClientEvent('esx_customItems:useClipcli', source)
end)

ESX.RegisterUsableItem('silencer', function(source)
    TriggerClientEvent('esx_customItems:useSilencer', source)
end)

ESX.RegisterUsableItem('flashlight', function(source)
    TriggerClientEvent('esx_customItems:useFlashlight', source)
end)

ESX.RegisterUsableItem('grip', function(source)
    TriggerClientEvent('esx_customItems:useGrip', source)
end)

ESX.RegisterUsableItem('yusuf', function(source)
    TriggerClientEvent('esx_customItems:useYusuf', source)
end)

ESX.RegisterUsableItem('blowtorch', function(source)
    TriggerClientEvent('esx_customItems:useBlowtorch', source)
end)