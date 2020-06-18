ESX = nil
Craft_standard_item = {}
Craft_weapon_item   = {}
Wating_for_craft    = {}
CraftList = {
	items = {
		[1] = {BaseName = "weed_pack", item_number = 3, countitem = 2 ,item_needs = {
			{name="weed",count=1},
			{name="pack",count=2},
			{name="scaler",count=1},
		}},
		[2] = {BaseName = "joint", item_number = 2, countitem = 20 ,item_needs = {
			{name="weed_pack",count=1},
			{name="paper",count=1}
		}},
		[3] = {BaseName = "cocaine_bricks", crafting_station=true ,item_number = 2, countitem = 5 ,item_needs = {
			{name="coca",count=50},
			{name="gasoline",count=1}
		}},
		[4] = {BaseName = "cocaine", item_number = 3, countitem = 20 ,item_needs = {
			{name="cocaine_bricks",count=1},
			{name="pack",count=1},
			{name="scaler",count=1},
		}},
		[5] = {BaseName = "blowtorch", crafting_time = 30000, crafting_station = true, item_number = 4, countitem = 1 ,item_needs = {
			{name="capsul",count=1},
			{name="loole",count=1},
			{name="lockpick",count=1},
			{name="lighter",count=1},
		}},
		[6] = {BaseName = "drill", crafting_time = 120000, crafting_station = true, item_number = 4, countitem = 1 ,item_needs = {
			{name="mattezakhim",count=1},
			{name="drillsharji",count=1},
			{name="battrey",count=2},
			{name="fanar",count=1},
		}},
		[7] = {BaseName = "pure", item_number = 2, crafting_station = true, countitem = 10 ,item_needs = {
			{name="medicine",count=10},
			{name="acetone",count=1}
		}},
		[8] = {BaseName = "meth", item_number = 3, crafting_station = true, countitem = 10 ,item_needs = {
			{name="pure",count=10},
			{name="hydraulic_acid",count=1},
			{name="red_phosphor",count=1},
		}},
		[9] = {BaseName = "morphine", item_number = 2, crafting_station = true, countitem = 1 ,item_needs = {
			{name="poppy",count=10},
			{name="ammonia",count=1},
		}},
		[10] = {BaseName = "heroin", item_number = 3, crafting_station = true, countitem = 5 ,item_needs = {
			{name="morphine",count=1},
			{name="acetic_anhydride",count=1},
			{name="alchol",count=1},

		}},
	},
	weapons = {
		--[1] = {BaseName = "weapon_pistol", item_number = 2,item_needs = {
		--	{name="gold",count=1},
		--	{name="iron",count=1}
		--}},
	}
}
TriggerEvent(
	"esx:getSharedObject",
	function(obj)
		ESX = obj
	end
)

function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
  end

RegisterServerEvent('esx_inventoryhud:ClearCraftitems')
AddEventHandler('esx_inventoryhud:ClearCraftitems', function()
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	if not Wating_for_craft[xPlayer.identifier] and Wating_for_craft[xPlayer.identifier] == nil then
	    if Craft_standard_item[xPlayer.identifier] then
		    for i=1 , #Craft_standard_item[xPlayer.identifier] do
			    local playerItemCount = xPlayer.getInventoryItem(Craft_standard_item[xPlayer.identifier][i].name)
			    local playerlimited = Craft_standard_item[xPlayer.identifier][i].count + playerItemCount.count
			    local playerspace = playerItemCount.limit - playerItemCount.count
			    if playerItemCount.count > playerItemCount.limit or  playerlimited > playerItemCount.limit then
				    xPlayer.addInventoryItem(Craft_standard_item[xPlayer.identifier][i].name, Craft_standard_item[xPlayer.identifier][i].count)
				    TriggerClientEvent('esx_inventoryhud:removeInventoryItem', _source,'item_standard', Craft_standard_item[xPlayer.identifier][i].name, Craft_standard_item[xPlayer.identifier][i].count - playerspace)
				    TriggerClientEvent('esx:showNotification', _source, "~r~Inventory shoma full ast!")
				else
					if Craft_standard_item[xPlayer.identifier][i].count ~= 0 then
					    xPlayer.addInventoryItem(Craft_standard_item[xPlayer.identifier][i].name, Craft_standard_item[xPlayer.identifier][i].count)
					end
			    end
		    end
		    Craft_standard_item[xPlayer.identifier] = {}
	    end
    end
end)

function FoundWeaponI(xPlayer)
	local found = {}
	for i = 1 ,#CraftList.weapons do
		print(CraftList.weapons[i].BaseName)
		for b = 1 , #CraftList.weapons[i].item_needs do
			for c=1 , #Craft_standard_item[xPlayer] do
				print(Craft_standard_item[xPlayer][c].name ,CraftList.weapons[i].item_needs[b].name )
				if Craft_standard_item[xPlayer][c].name == CraftList.weapons[i].item_needs[b].name and Craft_standard_item[xPlayer][c].count == CraftList.weapons[i].item_needs[b].count then
					table.insert(found, {IsDown = true})
					print("added true")
					break
				end
			end
		end
		for X=1 ,#found do
			if #found == CraftList.weapons[i].item_number then
				return i
			end
		end
		found = {}
		print("--------------")
	end
end

function FoundItems(xPlayer)
	local found = {}
	for i = 1 ,#CraftList.items do
		print(CraftList.items[i].BaseName)
		for b = 1 , #CraftList.items[i].item_needs do
			for c=1 , #Craft_standard_item[xPlayer] do
				print(Craft_standard_item[xPlayer][c].name ,CraftList.items[i].item_needs[b].name )
				if Craft_standard_item[xPlayer][c].name == CraftList.items[i].item_needs[b].name and Craft_standard_item[xPlayer][c].count == CraftList.items[i].item_needs[b].count then
					table.insert(found, {IsDown = true})
					print("added true")
					break
				end
			end
		end
		for X=1 ,#found do
			if #found == CraftList.items[i].item_number then
				return i
			end
		end
		found = {}
		print("--------------")
	end
end

RegisterServerEvent('esx_inventoryhud:StartCraft')
AddEventHandler('esx_inventoryhud:StartCraft', function()
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	if not Wating_for_craft[xPlayer.identifier] and Wating_for_craft[xPlayer.identifier] == nil then
	    if Craft_standard_item[xPlayer.identifier] and Craft_standard_item[xPlayer.identifier][1] ~= nil then
		    TriggerClientEvent('esx:showNotification', _source, "~g~Bezar yekam fekr konam!")
			local WeaponisFound = FoundWeaponI(xPlayer.identifier)
			local ItemisFound   = FoundItems(xPlayer.identifier)

		    if WeaponisFound then
				Wating_for_craft[xPlayer.identifier] = {type = "weapon",name = CraftList.weapons[WeaponisFound].BaseName,table = WeaponisFound}
				TriggerClientEvent('esx_inventoryhud:StartCraftitem', _source)
			elseif ItemisFound then
				Wating_for_craft[xPlayer.identifier] = {type = "item",name = CraftList.items[ItemisFound].BaseName , count = CraftList.items[ItemisFound].countitem ,table = ItemisFound}
				if CraftList.items[ItemisFound].crafting_station then
					    TriggerClientEvent('esx_inventoryhud:CraftingStation', _source, CraftList.items[ItemisFound].BaseName,(CraftList.items[ItemisFound].crafting_time or 20000))
				else
				    TriggerClientEvent('esx_inventoryhud:StartCraftitem', _source,(CraftList.items[ItemisFound].crafting_time or 20000))
				end
		    else
			    TriggerClientEvent('esx:showNotification', _source, "~r~Ane mage!")
		    end
	    else
		    TriggerClientEvent('esx:showNotification', _source, "~r~Shoma itemi dar daste khod barye craft nadarid!")
		end
	else
		TriggerClientEvent('esx:showNotification', _source, "~r~Shoma Dar hale craft yek item hastid!")
	end
end)

RegisterServerEvent('esx_inventoryhud:EndCraftItem')
AddEventHandler('esx_inventoryhud:EndCraftItem', function()
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	if Wating_for_craft[xPlayer.identifier] then
		local NTabel = Wating_for_craft[xPlayer.identifier].table
		if Wating_for_craft[xPlayer.identifier].type == "weapon" then
		    if xPlayer.hasWeapon(Wating_for_craft[xPlayer.identifier].name) then
			    TriggerClientEvent('esx:showNotification', _source, "~r~Wait What :|!")
			else
				for i = NTabel ,#CraftList.weapons do
					for b=1 , #CraftList.weapons[i].item_needs do
						print( CraftList.weapons[i].item_needs[b].name, CraftList.weapons[i].item_needs[b].count)
						RemoveVIR(xPlayer, CraftList.weapons[i].item_needs[b].name, CraftList.weapons[i].item_needs[b].count)
					end
					break
				end
		        xPlayer.addWeapon(Wating_for_craft[xPlayer.identifier].name, 20)
		    end
			Wating_for_craft[xPlayer.identifier] = nil
		elseif Wating_for_craft[xPlayer.identifier].type == "item" then
			local sourceItem = xPlayer.getInventoryItem(Wating_for_craft[xPlayer.identifier].name)
				if (sourceItem.count + 1) > sourceItem.limit then
					TriggerClientEvent('esx:showNotification', _source, "~r~Inventory shoma fazye kafi nadarad!")
				else
					for i = NTabel ,#CraftList.items do
						for b=1 , #CraftList.items[i].item_needs do
							RemoveVIR(xPlayer, CraftList.items[i].item_needs[b].name, CraftList.items[i].item_needs[b].count)
						end
						break
					end
					xPlayer.addInventoryItem(Wating_for_craft[xPlayer.identifier].name, Wating_for_craft[xPlayer.identifier].count)
				end
			Wating_for_craft[xPlayer.identifier] = nil
		end
	else
		TriggerClientEvent('esx:showNotification', _source, "~r~Shoma Hich item dar entezar craft nadarid!")
	end
end)

RegisterServerEvent('esx_inventoryhud:CancelCraft')
AddEventHandler('esx_inventoryhud:CancelCraft', function()
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	if Wating_for_craft[xPlayer.identifier] then
		Wating_for_craft[xPlayer.identifier] = nil
	else
		TriggerClientEvent('esx:showNotification', _source, "~r~Shoma Hich item barye cancel kardan nadarid!")
	end
end)

function AddItem(player, item, label, count)
	if not Wating_for_craft[player.identifier] and Wating_for_craft[player.identifier] == nil then
	local playerItemCount = player.getInventoryItem(item).count
	if playerItemCount >= count and count > 0 then
		print(item,count,label,player.identifier)
		player.removeInventoryItem(item, count)
		 if Craft_standard_item[player.identifier] then
				for i=1 , #Craft_standard_item[player.identifier] do
					if Craft_standard_item[player.identifier][i].name == item  then
						Craft_standard_item[player.identifier][i] = {name = item , label = label, count = count + Craft_standard_item[player.identifier][i].count}
						print(json.encode(Craft_standard_item[player.identifier]))
						return false
					end
				end
			table.insert(Craft_standard_item[player.identifier], {name = item , label = label, count = count})
			print("hey",json.encode(Craft_standard_item[player.identifier]))
		   else
			Craft_standard_item[player.identifier] = {{name = item , label = label, count = count}}
			print(json.encode(Craft_standard_item[player.identifier]))
		end
	else
		TriggerClientEvent('esx:showNotification', player.source, "~r~Error\nlotfan tedade dooroti ra entekhab konid!")
	end
	else
		TriggerClientEvent('esx:showNotification', player.source, "~r~Error\nShoma dar hale craft item hastid!")
	end

end

function RemoveVIR(player, item, count)
	local item,count  = item,count
	if Craft_standard_item[player.identifier] then
		for i=1 , #Craft_standard_item[player.identifier] do
			print(item)
			if Craft_standard_item[player.identifier][i].name == item  and Craft_standard_item[player.identifier][i].name ~= "scaler" then
				local baseitem = Craft_standard_item[player.identifier][i].count - count
				Craft_standard_item[player.identifier][i] = {name = item , label = Craft_standard_item[player.identifier][i].label, count = baseitem}
			end
		end
	end
end

function RemoveItem(player, item, label, count)
	if not Wating_for_craft[player.identifier] and Wating_for_craft[player.identifier] == nil then
	local sourceItem = player.getInventoryItem(item)
	if Craft_standard_item[player.identifier] then
		for i=1 , #Craft_standard_item[player.identifier] do
			local playerlimited = count + sourceItem.count
			local playerspace = sourceItem.limit - sourceItem.count
			local baseitem = Craft_standard_item[player.identifier][i].count - count
			if Craft_standard_item[player.identifier][i].name == item and Craft_standard_item[player.identifier][i].count >= count then
				if playerlimited > sourceItem.limit then
					TriggerClientEvent('esx:showNotification', player.source, "~r~Error\nShoma mojaz be in kar nistid!")
				else
					Craft_standard_item[player.identifier][i] = {name = item , label = label, count = baseitem}
					player.addInventoryItem(item, count)
				end
			else
				TriggerClientEvent('esx:showNotification', player.source, "~r~Error\nlotfan tedade dooroti ra entekhab konid!")
			end
		end
	end
	else
		TriggerClientEvent('esx:showNotification', player.source, "~r~Error\nShoma dar hale craft item hastid!")
	end
end
RegisterServerEvent('esx_inventoryhud:putCraftItem')
AddEventHandler('esx_inventoryhud:putCraftItem', function(owner, type, item, label, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	if type == 'item_standard' then
		AddItem(xPlayer,item,label,count)
	end
end)

RegisterServerEvent('esx_inventoryhud:getCraftItem')
AddEventHandler('esx_inventoryhud:getCraftItem', function(owner, type, item, label, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	if type == 'item_standard' then
		RemoveItem(xPlayer, item, label, count)
	end
end)


ESX.RegisterServerCallback('esx_inventoryhud:getCraftItems', function(source, cb, owner)
	local xPlayer      = ESX.GetPlayerFromId(source)
	local CSI = Craft_standard_item[xPlayer.identifier]
	cb({
		items      = CSI,
		weapons    = Craft_weapon_item
	})
end)

ESX.RegisterServerCallback("esx_inventoryhud:getPlayerInventory",function(source, cb, target)
		local targetXPlayer = ESX.GetPlayerFromId(target)

		if targetXPlayer ~= nil then
			cb({inventory = targetXPlayer.inventory, money = targetXPlayer.money, weapons = targetXPlayer.loadout})
		else
			cb(nil)
		end
end)

RegisterServerEvent("esx_inventoryhud:tradePlayerItem")
AddEventHandler("esx_inventoryhud:tradePlayerItem",function(from, target, type, itemName, itemCount)
		local _source = from

		local sourceXPlayer = ESX.GetPlayerFromId(_source)
		local targetXPlayer = ESX.GetPlayerFromId(target)

		if type == "item_standard" then
			local sourceItem = sourceXPlayer.getInventoryItem(itemName)
			local targetItem = targetXPlayer.getInventoryItem(itemName)

			if sourceItem and itemCount > 0 and sourceItem.count >= itemCount then
				if targetItem.limit ~= -1 and (targetItem.count + itemCount) > targetItem.limit then
				else
					sourceXPlayer.removeInventoryItem(itemName, itemCount)
					targetXPlayer.addInventoryItem(itemName, itemCount)
				end
			end
		elseif type == "item_money" then
			if itemCount > 0 and sourceXPlayer.getMoney() >= itemCount then
				sourceXPlayer.removeMoney(itemCount)
				targetXPlayer.addMoney(itemCount)
			end
		elseif type == "item_account" then
			if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
				sourceXPlayer.removeAccountMoney(itemName, itemCount)
				targetXPlayer.addAccountMoney(itemName, itemCount)
			end
		elseif type == "item_weapon" then
			if not targetXPlayer.hasWeapon(itemName) then
				sourceXPlayer.removeWeapon(itemName)
				targetXPlayer.addWeapon(itemName, itemCount)
			end
		end
	end
)

RegisterCommand(
	"openinventory",
	function(source, args, rawCommand)
		if IsPlayerAceAllowed(source, "inventory.openinventory") then
			local target = tonumber(args[1])
			local targetXPlayer = ESX.GetPlayerFromId(target)

			if targetXPlayer ~= nil then
				TriggerClientEvent("esx_inventoryhud:openPlayerInventory", source, target, targetXPlayer.name)
			else
				TriggerClientEvent("chatMessage", source, "^1" .. _U("no_player"))
			end
		else
			TriggerClientEvent("chatMessage", source, "^1" .. _U("no_permissions"))
		end
	end
)
