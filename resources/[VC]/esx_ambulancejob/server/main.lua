ESX = nil
local playersHealing = {}
BooleanConventor = { [1]=true, [0]=false }

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_ambulancejob:VreviveC')
AddEventHandler('esx_ambulancejob:VreviveC', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' or xPlayer.permission_level > 0 then
		xPlayer.addMoney(Config.ReviveReward)
		TriggerClientEvent('esx_ambulancejob:VreviveC', target)
	else
		print(('esx_ambulancejob: %s attempted to revive!'):format(xPlayer.identifier))
	end

end)

RegisterServerEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:heal', target, type)
	else
		print(('esx_ambulancejob: %s attempted to heal!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_ambulancejob:RequestTeleport')
AddEventHandler('esx_ambulancejob:RequestTeleport', function(target, x, y, z)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
	 TriggerClientEvent('esx_ambulancejob:teleportPatient', target, x, y, z)
	else
		print(('esx_ambulancejob: %s attempted to use teleporter!'):format(xPlayer.identifier))
	end

end)

RegisterServerEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:putInVehicle', target)
	else
		print(('esx_ambulancejob: %s attempted to put in vehicle!'):format(xPlayer.identifier))
	end
	
end)

RegisterNetEvent('esx_ambulancejob:changeStabilizeStatus')
AddEventHandler('esx_ambulancejob:changeStabilizeStatus', function(target, status)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:changeStabilizeStatus', target, status)

		if status then
			TriggerClientEvent('chatMessage', target, "[Medic]", {255, 0, 0}, " ^0Vaziat badan shoma ^2sabet ^0shod!")
		end
	else
		print(('esx_ambulancejob: %s attempted to stabilize someone!'):format(xPlayer.identifier))
	end
end)


TriggerEvent('esx_phone:registerNumber', 'ambulance', _U('alert_ambulance'), true, true)

TriggerEvent('esx_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})

ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.RemoveCashAfterRPDeath then
		if xPlayer.money > 0 then
			xPlayer.removeMoney(xPlayer.money)
		end
	end

	if Config.RemoveItemsAfterRPDeath then
		for i=1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
			end
		end
	end

	local playerLoadout = {}
	if Config.RemoveWeaponsAfterRPDeath then
		for i=1, #xPlayer.loadout, 1 do
			xPlayer.removeWeapon(xPlayer.loadout[i].name)
		end
	else -- save weapons & restore em' since spawnmanager removes them
		for i=1, #xPlayer.loadout, 1 do
			table.insert(playerLoadout, xPlayer.loadout[i])
		end

		-- give back wepaons after a couple of seconds
		Citizen.CreateThread(function()
			Citizen.Wait(5000)
			for i=1, #playerLoadout, 1 do
				if playerLoadout[i].label ~= nil then
					xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
				end
			end
		end)
	end

	cb()
end)

if Config.EarlyRespawnFine then
	ESX.RegisterServerCallback('esx_ambulancejob:checkBalance', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money

		cb(bankBalance >= Config.EarlyRespawnFineAmount)
	end)

	RegisterServerEvent('esx_ambulancejob:payFine')
	AddEventHandler('esx_ambulancejob:payFine', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		local fineAmount = Config.EarlyRespawnFineAmount

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('respawn_bleedout_fine_msg', ESX.Math.GroupDigits(fineAmount)))
		xPlayer.removeAccountMoney('bank', fineAmount)
	end)
end

RegisterServerEvent('esx_ambulancejob:syncDeadBody')
AddEventHandler('esx_ambulancejob:syncDeadBody', function(SourceID, TargetID)
    TriggerClientEvent('esx_ambulancejob:finishCPR', TargetID, SourceID)
end)


ESX.RegisterServerCallback('esx_ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

ESX.RegisterServerCallback('esx_ambulancejob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		print(('esx_ambulancejob: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
		cb(false)
	else
		if xPlayer.money >= price then
			xPlayer.removeMoney(price)
	
			MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (@owner, @vehicle, @plate, @type, @job, @stored)', {
				['@owner'] = xPlayer.identifier,
				['@vehicle'] = json.encode(vehicleProps),
				['@plate'] = vehicleProps.plate,
				['@type'] = type,
				['@job'] = xPlayer.job.name,
				['@stored'] = true
			}, function (rowsChanged)
				cb(true)
			end)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundPlate, foundNum

	for k,v in ipairs(nearbyVehicles) do
		local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = v.plate,
			['@job'] = xPlayer.job.name
		})

		if result[1] then
			foundPlate, foundNum = result[1].plate, k
			break
		end
	end

	if not foundPlate then
		cb(false)
	else
		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = foundPlate,
			['@job'] = xPlayer.job.name
		}, function (rowsChanged)
			if rowsChanged == 0 then
				print(('esx_ambulancejob: %s has exploited the garage!'):format(xPlayer.identifier))
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end

end)

function getPriceFromHash(hashKey, jobGrade, type)
	if type == 'helicopter' then
		local vehicles = Config.AuthorizedHelicopters[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	elseif type == 'car' then
		local vehicles = Config.AuthorizedVehicles[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	end

	return 0
end

RegisterServerEvent('esx_ambulancejob:removeItem')
AddEventHandler('esx_ambulancejob:removeItem', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem(item, 1)

	if item == 'bandage' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_bandage'))
	elseif item == 'medikit' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_medikit'))
	end
end)

RegisterServerEvent('esx_ambulancejob:giveItem')
AddEventHandler('esx_ambulancejob:giveItem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'ambulance' then
		print(('esx_ambulancejob: %s attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	elseif (itemName ~= 'medikit' and itemName ~= 'bandage') then
		print(('esx_ambulancejob: %s attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	end

	local xItem = xPlayer.getInventoryItem(itemName)
	local count = 1

	if xItem.limit ~= -1 then
		count = xItem.limit - xItem.count
	end

	if xItem.count < xItem.limit then
		xPlayer.addInventoryItem(itemName, count)
	else
		TriggerClientEvent('esx:showNotification', source, _U('max_item'))
	end
end)

RegisterCommand('revive', function(source, args)
local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.permission_level > 0 then

		if xPlayer.get('aduty') then

			if args[1] ~= nil then

				if GetPlayerName(tonumber(args[1])) ~= nil then
					print(('esx_ambulancejob: %s used admin revive'):format(GetPlayerIdentifiers(source)[1]))
					TriggerClientEvent('esx_ambulancejob:VreviveC', tonumber(args[1]))
				end

			else
				TriggerClientEvent('esx_ambulancejob:VreviveC', source)
			end

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end

	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma admin nistid!")
	end
						
end)
RegisterCommand('reviveall', function(source)
local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.permission_level >= 4 then
		if xPlayer.get('aduty') then
			for _,v in pairs(GetPlayers()) do
				Wait(100)
				TriggerClientEvent('esx_ambulancejob:VreviveC', v)
			end
		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end

	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma Ejaze in kar ro nadarid!")
	end
						
end)	


ESX.RegisterUsableItem('medikit', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('medikit', 1)
	
		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'medikit')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('bandage', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('bandage', 1)
	
		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'bandage')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:getDeathStatus', function(source, cb)
	local identifier = GetPlayerIdentifiers(source)[1]
	local DeadList = {}
	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result[1] then
			table.insert(DeadList, {IsDead = BooleanConventor[result[1].is_dead],InJure = BooleanConventor[result[1].injure]})
			cb(DeadList)
		else
			print("NotFOund")
		end
	end)
end)

ESX.RegisterServerCallback('esx_ambulancejob:checkinjure', function(source, cb,playerid)
	local identifier = GetPlayerIdentifiers(playerid)[1]
	local DeadList = {}
	exports.ghmattimysql:execute('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result[1] then
			table.insert(DeadList, {IsDead = result[1].is_dead,InJure = result[1].injure})
			cb(DeadList)
		else
			print("NotFOund")
		end
	end)
end)

RegisterServerEvent('esx_ambulancejob:setDeathStatus')
AddEventHandler('esx_ambulancejob:setDeathStatus', function(istype,isDead)
	if type(isDead) ~= 'boolean' then
		print(('esx_ambulancejob: %s attempted to parse something else than a boolean to setDeathStatus!'):format(identifier))
		return
	end
	local identifier = GetPlayerIdentifiers(source)[1]
    if istype == "Dead" then
		exports.ghmattimysql:execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {['@identifier'] = identifier,['@isDead'] = isDead})
		exports.ghmattimysql:execute('UPDATE users SET injure  = @injure WHERE identifier = @identifier', {['@identifier'] = identifier,['@injure'] = false})
    elseif istype == "Injure" then
	    exports.ghmattimysql:execute('UPDATE users SET injure  = @injure WHERE identifier = @identifier', {['@identifier'] = identifier,['@injure'] = isDead})
    end
end)
