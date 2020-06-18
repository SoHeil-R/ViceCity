local PlayersWorking = {}
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function Work(source, item)

	SetTimeout(item[1].time, function()

		if PlayersWorking[source] == true then

			local xPlayer = ESX.GetPlayerFromId(source)
			if xPlayer == nil then
				return
			end

			for i=1, #item, 1 do
				local itemQtty = 0
				if item[i].name ~= _U('delivery') then
					itemQtty = xPlayer.getInventoryItem(item[i].db_name).count
				end

				local requiredItemQtty = 0
				if item[1].requires ~= "nothing" then
					requiredItemQtty = xPlayer.getInventoryItem(item[1].requires).count
				end

				if item[i].name ~= _U('delivery') and itemQtty >= item[i].max then
					TriggerClientEvent('esx:showNotification', source, _U('max_limit', item[i].name))
				elseif item[i].requires ~= "nothing" and requiredItemQtty <= 0 then
					TriggerClientEvent('esx:showNotification', source, _U('not_enough', item[1].requires_name))
				else
					if item[i].name ~= _U('delivery') then
						-- Chances to drop the item
						if item[i].drop == 100 then
							xPlayer.addInventoryItem(item[i].db_name, item[i].add)
						else
							local chanceToDrop = math.random(100)
							if chanceToDrop <= item[i].drop then
								xPlayer.addInventoryItem(item[i].db_name, item[i].add)
							end
						end
					else
						TriggerEvent('esx-salary:ThisHide_modify', source, "add", item[i].price)
					end
				end
			end

			if item[1].requires ~= "nothing" then
				local itemToRemoveQtty = xPlayer.getInventoryItem(item[1].requires).count
				if itemToRemoveQtty > 0 then
					xPlayer.removeInventoryItem(item[1].requires, item[1].remove)
				end
			end

			Work(source, item)

		end
	end)
end

RegisterServerEvent('esx_jobs:startWork')
AddEventHandler('esx_jobs:startWork', function(item)
	if not PlayersWorking[source] then
		PlayersWorking[source] = true
		Work(source, item)
	else
		print(('esx_jobs: %s attempted to exploit the marker!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

RegisterServerEvent('esx_jobs:giveShit')
AddEventHandler('esx_jobs:giveShit', function(item, count)

	if item == "alive_chicken" or item == "slaughtered_chicken" or item == "packaged_chicken" then

		local xPlayer = ESX.GetPlayerFromId(source)
		local thatItem = nil
		if item == "slaughtered_chicken" then
			thatItem = xPlayer.getInventoryItem("alive_chicken")
		elseif item == "packaged_chicken" then
			thatItem = xPlayer.getInventoryItem("slaughtered_chicken")
		end

		if item == "alive_chicken" then

			if count == 1 then
				xPlayer.addInventoryItem(item, count)
			else
				print(('esx_jobs: %s sai kard ba lua injector item give kone!'):format(GetPlayerIdentifiers(source)[1]))
			end

		elseif item == "slaughtered_chicken" then

			if thatItem.count > 0 then

				if count == 1 then

					xPlayer.removeInventoryItem(thatItem.name, 1)
					xPlayer.addInventoryItem(item, count)
				
				else
					print(('esx_jobs: %s sai kard ba lua injector item give kone!'):format(GetPlayerIdentifiers(source)[1]))
				end

			else

				TriggerClientEvent('esx:showNotification', source, 'Shoma ~y~Morgh zende ~s~nadarid~')

			end

		elseif item == "packaged_chicken" then

			if thatItem.count > 0 then

				if count == 5 then

					xPlayer.removeInventoryItem(thatItem.name, 1)
					xPlayer.addInventoryItem(item, count)

				else
					print(('esx_jobs: %s sai kard ba lua injector item give kone!'):format(GetPlayerIdentifiers(source)[1]))
				end

			else

				TriggerClientEvent('esx:showNotification', source, 'Shoma ~y~Morgh ~s~nadarid~')

			end

		end

	else
		print(('esx_jobs: %s sai kard ba lua injector item give kone!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

RegisterServerEvent('esx_jobs:stopWork')
AddEventHandler('esx_jobs:stopWork', function()
	PlayersWorking[source] = false
end)

RegisterServerEvent('esx_jobs:VCcaution')
AddEventHandler('esx_jobs:VCcaution', function(cautionType, cautionAmount, spawnPoint, vehicle)
	local xPlayer = ESX.GetPlayerFromId(source)

	if cautionType == "take" then
		TriggerEvent('esx_addonaccount:getAccount', 'caution', xPlayer.identifier, function(account)
			xPlayer.removeBank(cautionAmount)
			account.addMoney(cautionAmount)
		end)

		TriggerClientEvent('esx:showNotification', source, _U('bank_deposit_taken', ESX.Math.GroupDigits(cautionAmount)))
		TriggerClientEvent('esx_jobs:spawnJobVehicle', source, spawnPoint, vehicle)
	elseif cautionType == "give_back" then

		if cautionAmount > 1 then
			print(('esx_jobs: %s is using cheat engine!'):format(xPlayer.identifier))
			return
		end

		TriggerEvent('esx_addonaccount:getAccount', 'caution', xPlayer.identifier, function(account)
			local caution = account.money
			local toGive = ESX.Math.Round(caution * cautionAmount)
			if toGive > 2000 then
				local newMoney = math.random(500, 1800)
				xPlayer.addBank(newMoney)
				account.removeMoney(newMoney)
				TriggerClientEvent('esx:showNotification', source, _U('bank_deposit_returned', ESX.Math.GroupDigits(newMoney)))
			else
				xPlayer.addBank(toGive)
				account.removeMoney(toGive)
				TriggerClientEvent('esx:showNotification', source, _U('bank_deposit_returned', ESX.Math.GroupDigits(toGive)))
			end
			
		end)
	end
end)
