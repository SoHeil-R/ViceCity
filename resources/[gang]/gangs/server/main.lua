ESX = nil
local Gangs = {}
local RegisteredGangs = {}
local TempGangs = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GetGang(gang)
	for i=1, #RegisteredGangs, 1 do
		if RegisteredGangs[i] == gang then
			local gn = {}
			gn.name = gang
			gn.account = 'gang_' .. string.lower(gn.name)
			return gn
		end
	end
end


MySQL.ready(function()
	local result = MySQL.Sync.fetchAll('SELECT * FROM gangs', {})

	for i=1, #result, 1 do
		print('Gang '.. result[i].name .. ' Loaded')
		Gangs[result[i].name]        	= result[i]
		Gangs[result[i].name].grades 	= {}
		RegisteredGangs[i] 				= result[i].name
		Gangs[result[i].name].vehicles 	= {}
		exports.ghmattimysql:execute('SELECT * FROM owned_vehicles WHERE owner = @owner',{
			['@owner'] = result[i].name
		}, function(vehResult)
			for j=1, #vehResult do
				Gangs[result[i].name].vehicles[j] = json.decode(vehResult[j].vehicle)
			end
		end)
	end

 	local result2 = MySQL.Sync.fetchAll('SELECT * FROM gang_grades', {})

 	for i=1, #result2, 1 do
		Gangs[result2[i].gang_name].grades[tonumber(result2[i].grade)] = result2[i]
	end
end)


AddEventHandler('gangs:registerGang', function(source, name, expire)
	local found = false

 	local gang = name

 	for i=1, #RegisteredGangs, 1 do
		if RegisteredGangs[i] == gang then
			found = true
			break
		end
	end

 	if not found then
		table.insert(TempGangs, {gang = name, expire = expire})
		TriggerClientEvent('esx:showNotification', source, gang)
	else
		TriggerClientEvent('esx:showNotification', source, 'This Gang Created Before!')
	end
end)

AddEventHandler('gangs:saveGangs', function(source)
	for j=1, #TempGangs, 1 do
		table.insert(RegisteredGangs, TempGangs[j].gang)

		Gangs[TempGangs[j].gang] 			= {}
		Gangs[TempGangs[j].gang].label      = 'gang'
		Gangs[TempGangs[j].gang].name      	= TempGangs[j].gang
		Gangs[TempGangs[j].gang].grades 	= {}
		Gangs[TempGangs[j].gang].vehicles 	= {}

		TriggerEvent('esx_addoninventory:addGang', 	GetGang(TempGangs[j].gang).account)
		TriggerEvent('esx_datastore:addGang', 		GetGang(TempGangs[j].gang).account)
		
		local ranks = {'Thug','Hustler','Soldier','Trigger','Street Boss','Kingpin'}
		
		TriggerEvent('es_extended:addGang', TempGangs[j].gang, ranks)
		TriggerEvent('gangaccount:addGang', TempGangs[j].gang)

		MySQL.Async.execute('INSERT INTO `gangs` (`name`, `label`) VALUES (@name, @label)', {
			['@name'] 		= TempGangs[j].gang,
			['@label']    = 'gang',
		}, function(e)
		--log here
		end)
		for i=1, 6, 1 do
			Gangs[TempGangs[j].gang].grades[i] 				= {}
			Gangs[TempGangs[j].gang].grades[i].gang_name 	= TempGangs[j].gang
			Gangs[TempGangs[j].gang].grades[i].grade 		= i
			Gangs[TempGangs[j].gang].grades[i].name 		= 'Rank' .. i
			Gangs[TempGangs[j].gang].grades[i].label 		= ranks[i]
			Gangs[TempGangs[j].gang].grades[i].salary 		= 100 * i
			Gangs[TempGangs[j].gang].grades[i].skin_male 	= '[]'
			Gangs[TempGangs[j].gang].grades[i].skin_female 	= '[]'


			MySQL.Async.execute('INSERT INTO `gang_grades` (`gang_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (@gang_name, @grade, @name, @label, @salary, @skin_male, @skin_female)', {
				['@gang_name'] 	 = TempGangs[j].gang,
				['@grade']    	 = i,
				['@name'] 		 = 'Rank '..i,
				['@label']       = ranks[i],
				['@salary'] 	 = 100*i,
				['@skin_male']   = '[]',
				['@skin_female'] = '[]',
			}, function(e)
			--log here
			end)
		end
		MySQL.Async.execute('INSERT INTO `gang_account` (`name`, `label`, `shared`) VALUES (@name, @label, @shared)', {
			['@name'] 	  = 'gang_'..string.lower(TempGangs[j].gang),
			['@label']    = 'gang',
			['@shared']   = 1,
		}, function(e)
		--log here
		end)
		MySQL.Async.execute('INSERT INTO `gang_account_data` (`gang_name`, `money`, `owner`) VALUES (@gang_name, @money, @owner)', {
			['@gang_name'] 	= 'gang_'..string.lower(TempGangs[j].gang),
			['@money']    	= 0,
			['@owner']   	= nil,
		}, function(e)
		--log here
		end)
		MySQL.Async.execute('INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES (@name, @owner, @data)', {
			['@name'] 		= 'gang_'..string.lower(TempGangs[j].gang),
			['@owner']   	= nil,
			['@data'] 		= '[]'
		}, function(e)
		--log here
		end)
		MySQL.Async.execute('INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES (@name, @label, @shared)', {
			['@name'] 		= 'gang_'..string.lower(TempGangs[j].gang),
			['@label']    	= 'gang',
			['@shared']   	= 1
		}, function(e)
		--log here
		end)
		MySQL.Async.execute('INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES (@name, @label, @shared)', {
			['@name'] 		= 'gang_'..string.lower(TempGangs[j].gang),
			['@label']    	= 'gang',
			['@shared']   	= 1
		}, function(e)
		--log here
		end)
		MySQL.Async.execute('INSERT INTO `gangs_data` (`gang_name`, `vehicles`, `vehprop`, `expire_time`) VALUES (@gang_name, @vehicles, @vehprop, (NOW() + INTERVAL @time DAY))', {
			['@gang_name'] 		= TempGangs[j].gang,
			['@vehicles']		= '[]',
			['@vehprop']		= '[]',
			['@time']			= TempGangs[j].expire
		}, function(e)
		--log here
		end)
		
		TriggerClientEvent('esx:showNotification', source, 'You Added ' .. TempGangs[j].gang .. ' Gang!')
	end
	TempGangs = {}
end)

AddEventHandler('gangs:changeGangData', function(name, data, pos, source)
	local gang = name
	local data = data

	if data == 'blip' then
		blip(name,pos,function(callback)
			if callback then
				TriggerClientEvent('esx:showNotification', source, 'You updated '..data..' point of '..gang..' Gang!')
			end
		end)
	elseif data == 'armory' then
		armory(name,pos,function(callback)
			if callback then
				TriggerClientEvent('esx:showNotification', source, 'You updated '..data..' point of '..gang..' Gang!')
			end
		end)
	elseif data == 'locker' then
		locker(name,pos,function(callback)
			if callback then
				TriggerClientEvent('esx:showNotification', source, 'You updated '..data..' point of '..gang..' Gang!')
			end
		end)
	elseif data == 'boss' then
		boss(name,pos,function(callback)
			if callback then
				TriggerClientEvent('esx:showNotification', source, 'You updated '..data..' point of '..gang..' Gang!')
			end
		end)
	elseif data == 'veh' then
		veh(name,pos,function(callback)
			if callback then
				TriggerClientEvent('esx:showNotification', source, 'You updated '..data..' point of '..gang..' Gang!')
			end
		end)
	elseif data == 'vehdel' then
		vehdel(name,pos,function(callback)
			if callback then
				TriggerClientEvent('esx:showNotification', source, 'You updated '..data..' point of '..gang..' Gang!')
			end
		end)
	elseif data == 'vehspawn' then
		vehspawn(name,pos,function(callback)
			if callback then
				TriggerClientEvent('esx:showNotification', source, 'You updated '..data..' point of '..gang..' Gang!')
			end
		end)
	elseif data == 'expire' then
		expire(name,pos,function(callback)
			if callback then
				TriggerClientEvent('esx:showNotification', source, 'You updated '..data..' time of '..gang..' Gang!')
			end
		end)
	end
end)

function blip(gang, pos, callback)
	MySQL.Async.execute('UPDATE gangs_data SET blip = @pos WHERE gang_name = @gang_name', {
		['@gang_name']      = gang,
		['@pos']  			= json.encode(pos)
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function armory(gang, pos, callback)
	MySQL.Async.execute('UPDATE gangs_data SET armory = @pos WHERE gang_name = @gang_name', {
		['@gang_name']      = gang,
		['@pos']  			= json.encode(pos)
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function locker(gang, pos, callback)
	MySQL.Async.execute('UPDATE gangs_data SET locker = @pos WHERE gang_name = @gang_name', {
		['@gang_name']      = gang,
		['@pos']  			= json.encode(pos)
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function boss(gang, pos, callback)
	MySQL.Async.execute('UPDATE gangs_data SET boss = @pos WHERE gang_name = @gang_name', {
		['@gang_name']      = gang,
		['@pos']  			= json.encode(pos)
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function veh(gang, pos, callback)
	MySQL.Async.execute('UPDATE gangs_data SET veh = @pos WHERE gang_name = @gang_name', {
		['@gang_name']      = gang,
		['@pos']  			= json.encode(pos)
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function vehdel(gang, pos, callback)
	MySQL.Async.execute('UPDATE gangs_data SET vehdel = @pos WHERE gang_name = @gang_name', {
		['@gang_name']      = gang,
		['@pos']  			= json.encode(pos)
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function vehspawn(gang, pos, callback)
	MySQL.Async.execute('UPDATE gangs_data SET vehspawn = @pos WHERE gang_name = @gang_name', {
		['@gang_name']      = gang,
		['@pos']  			= json.encode(pos)
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function expire(gang, time, callback)
	MySQL.Async.execute('UPDATE gangs_data SET expire_time = (NOW() + INTERVAL @time DAY) WHERE gang_name = @gang_name', {
		['@gang_name']      = gang,
		['@time']			= time
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end


AddEventHandler('gangs:getGangs', function(cb)
	cb(RegisteredSocieties)
end)

AddEventHandler('gangs:getGang', function(name, cb)
	cb(GetGang(name))
end)

RegisterServerEvent('gangs:withdrawMoney')
AddEventHandler('gangs:withdrawMoney', function(gangName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local gang = GetGang(gangName)
	amount = ESX.Math.Round(tonumber(amount))

 	if xPlayer.gang.name ~= gang.name then
		print(('gangs: %s attempted to call withdrawMoney!'):format(xPlayer.identifier))
		return
	end

 	TriggerEvent('gangaccount:getGangAccount', gang.account, function(account)
		if amount > 0 and account.money >= amount then
			account.removeMoney(amount)
			xPlayer.addMoney(amount)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn', ESX.Math.GroupDigits(amount)))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
		end
	end)
end)

RegisterServerEvent('gangs:depositMoney')
AddEventHandler('gangs:depositMoney', function(gang, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local gang = GetGang(gang)
	amount = ESX.Math.Round(tonumber(amount))

 	if xPlayer.gang.name ~= gang.name then
		print(('gangs: %s attempted to call depositMoney!'):format(xPlayer.identifier))
		return
	end

 	if amount > 0 and xPlayer.money >= amount then
		TriggerEvent('gangaccount:getGangAccount', gang.account, function(account)
			xPlayer.removeMoney(amount)
			account.addMoney(amount)
		end)

 		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', ESX.Math.GroupDigits(amount)))
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
	end
end)

RegisterServerEvent('gangs:saveOutfit')
AddEventHandler('gangs:saveOutfit', function(grade, skin)
	local xPlayer = ESX.GetPlayerFromId(source)

	if skin.sex == 0 then
		exports.ghmattimysql:execute('UPDATE gang_grades SET skin_male = @skin WHERE (gang_name = @gang AND label = @grade)',{
			['skin']  = json.encode(skin),
			['gang']  = xPlayer.gang.name,
			['grade'] = grade
		})
	else
		exports.ghmattimysql:execute('UPDATE gang_grades SET skin_female = @skin WHERE (gang_name = @gang AND label = @grade)',{
			['skin']  = json.encode(skin),
			['gang']  = xPlayer.gang.name,
			['grade'] = grade
		})
	end
end)

ESX.RegisterServerCallback('gangs:getGangData', function(source, cb, gang)
	if ESX.DoesGangExist(gang,6) then
		MySQL.Async.fetchAll(
			'SELECT * FROM gangs_data WHERE gang_name = @gang_name AND `expire_time` > NOW()',
			{
				['@gang_name'] = gang
			},
			function(data)
				cb(data[1])
			end
		)
	else
		cb(nil)
	end

end)

ESX.RegisterServerCallback('gangs:getGangMoney', function(source, cb, gang)
	local gang = GetGang(gang)

 	if gang then
		TriggerEvent('gangaccount:getGangAccount', gang.account, function(account)
			cb(account.money)
		end)
	else
		cb(0)
	end
end)

ESX.RegisterServerCallback('gangs:getGangInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local gangaccount= GetGang(xPlayer.gang.name)
	local items      = {}
	local weapons    = {}

	TriggerEvent('esx_addoninventory:getSharedInventory', gangaccount.account, function(inventory)
		items = inventory.items
	end)

	TriggerEvent('esx_datastore:getSharedDataStore', gangaccount.account, function(store)
		weapons = store.get('weapons') or {}
	end)

	cb({
		items      = items,
		weapons    = weapons
	})
end)

ESX.RegisterServerCallback('gangs:getPropertyInventory', function(source, cb, station)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = {}
	local weapons    = {}
	local gang 		 = GetGang(station)

	if xPlayer.gang.name ~= gang.name then
		print(('gangs: %s attempted to call getStock without permission!'):format(xPlayer.identifier))
		return
	end
	
	TriggerEvent('esx_addoninventory:getSharedInventory', gang.account, function(inventory)
		items = inventory.items
	end)

	TriggerEvent('esx_datastore:getSharedDataStore', gang.account, function(store)
		weapons = store.get('weapons') or {}
	end)

	cb({
		items      = items,
		weapons    = weapons
	})
end)

RegisterServerEvent('gangs:getFromInventory')
AddEventHandler('gangs:getFromInventory', function(type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local gangaccount  = GetGang(xPlayer.gang.name)

	if type == 'item_standard' then

		local sourceItem = xPlayer.getInventoryItem(item)

		TriggerEvent('esx_addoninventory:getSharedInventory', gangaccount.account, function(inventory)
			local inventoryItem = inventory.getItem(item)

			-- is there enough in the property?
			if count > 0 and inventoryItem.count >= count then
			
				-- can the player carry the said amount of x item?
				if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
					TriggerClientEvent('esx:showNotification', _source, _U('player_cannot_hold'))
				else
					inventory.removeItem(item, count)
					xPlayer.addInventoryItem(item, count)
					TriggerClientEvent('esx:showNotification', _source, _U('have_withdrawn', count, inventoryItem.label))
				end
			else
				TriggerClientEvent('esx:showNotification', _source, _U('not_enough_in_property'))
			end
		end)

	elseif type == 'item_weapon' then
		local ammo = xPlayer.hasWeapon(item)

		if not ammo then
			TriggerEvent('esx_datastore:getSharedDataStore', gangaccount.account, function(store)
				local storeWeapons = store.get('weapons') or {}
				local weaponName   = nil
				local ammo         = nil

				for i=1, #storeWeapons, 1 do
					if storeWeapons[i].name == item then
						weaponName = storeWeapons[i].name
						ammo       = storeWeapons[i].ammo

						table.remove(storeWeapons, i)
						break
					end
				end

				store.set('weapons', storeWeapons)
				xPlayer.addWeapon(weaponName, ammo)
			end)
		else
			TriggerClientEvent('esx:showNotification', _source, 'Shoma Dar hale Hazer in Aslahe ro darid')			
		end

	end

end)

RegisterServerEvent('gangs:addToInventory')
AddEventHandler('gangs:addToInventory', function(type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local gangaccount  = GetGang(xPlayer.gang.name)

	if type == 'item_standard' then

		local playerItemCount = xPlayer.getInventoryItem(item).count

		if playerItemCount >= count and count > 0 then
			TriggerEvent('esx_addoninventory:getSharedInventory', gangaccount.account, function(inventory)
				xPlayer.removeInventoryItem(item, count)
				inventory.addItem(item, count)
				TriggerClientEvent('esx:showNotification', _source, 'Shoma '..count..' ta '.. inventory.getItem(item).label .. ' Dakhel Gang Gozashtid')
			end)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('invalid_quantity'))
		end

	elseif type == 'item_weapon' then
		local ammo = xPlayer.hasWeapon(item)

		if ammo then
			TriggerEvent('esx_datastore:getSharedDataStore', gangaccount.account, function(store)
				local storeWeapons = store.get('weapons') or {}

				table.insert(storeWeapons, {
					name = item,
					ammo = ammo
				})

				store.set('weapons', storeWeapons)
				xPlayer.removeWeapon(item)
			end)
		end
	end
end)

ESX.RegisterServerCallback('gangs:removeArmoryWeapon', function(source, cb, weaponName, station)
	local gang = GetGang(station)
	local xPlayer = ESX.GetPlayerFromId(source)
	local alreadyHaveWeapon = false
	if xPlayer.gang.name ~= gang.name then
		print(('gangs: %s attempted to removeArmoryWeapon!'):format(xPlayer.identifier))
		return
	end
	
	for i=#xPlayer.loadout, 1, -1 do
		if xPlayer.loadout[i].name == weaponName then
			alreadyHaveWeapon = true
		end
	end
	if not alreadyHaveWeapon then
		xPlayer.addWeapon(weaponName, 1000)
		TriggerEvent('esx_datastore:getSharedDataStore', gang.account, function(store)

			local weapons = store.get('weapons')

			if weapons == nil then
				weapons = {}
			end

			local foundWeapon = false

			for i=1, #weapons, 1 do
				if weapons[i].name == weaponName then
					weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
					foundWeapon = true
				end
			end

			if not foundWeapon then
				table.insert(weapons, {
					name  = weaponName,
					count = 0
				})
			end

			store.set('weapons', weapons)

			cb()

			end)
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Shoma in Aslahe ro Darid!')
	end

end)

ESX.RegisterServerCallback('gangs:buy', function(source, cb, amount, station)
	local gang = GetGang(station)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.gang.name ~= gang.name then
		print(('gangs: %s attempted to buy!'):format(xPlayer.identifier))
		return
	end
	TriggerEvent('gangaccount:getGangAccount', gang.account, function(account)
		if account.money >= amount then
			account.removeMoney(amount)
			cb(true)
		else
			cb(false)
		end
	end)
end)

ESX.RegisterServerCallback('gangs:getEmployees', function(source, cb, gang)
	print('gang')
	MySQL.Async.fetchAll('SELECT playerName, identifier, gang, gang_grade FROM users WHERE gang = @gang ORDER BY gang_grade DESC', {
		['@gang'] = gang
	}, function (result)
		local employees = {}

		for i=1, #result, 1 do
			table.insert(employees, {
				name       = result[i].playerName,
				identifier = result[i].identifier,
				gang = {
					name        = result[i].gang,
					label       = Gangs[result[i].gang].label,
					grade       = result[i].gang_grade,
					grade_name  = Gangs[result[i].gang].grades[tonumber(result[i].gang_grade)].name,
					grade_label = Gangs[result[i].gang].grades[tonumber(result[i].gang_grade)].label
				}
			})
		end

		cb(employees)
	end)
end)

ESX.RegisterServerCallback('gangs:getGang', function(source, cb, gang)
	local gang    = json.decode(json.encode(Gangs[gang]))
	local grades = {}

 	for k,v in pairs(gang.grades) do
		table.insert(grades, v)
	end

 	table.sort(grades, function(a, b)
		return a.grade < b.grade
	end)

	gang.grades = grades

 	cb(gang)
end)


ESX.RegisterServerCallback('gangs:setGang', function(source, cb, identifier, gang, grade, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local isBoss = xPlayer.gang.grade == 6

 	if isBoss then
		local xTarget = ESX.GetPlayerFromIdentifier(identifier)

 		if xTarget then
			xTarget.setGang(gang, grade)

 			if type == 'hire' then
				TriggerClientEvent('esx:showNotification', xTarget.source, _U('you_have_been_hired', gang))
			elseif type == 'promote' then
				TriggerClientEvent('esx:showNotification', xTarget.source, _U('you_have_been_promoted'))
			elseif type == 'fire' then
				TriggerClientEvent('esx:showNotification', xTarget.source, _U('you_have_been_fired', xTarget.gang.label))
			end

 			cb()
		else
			MySQL.Async.execute('UPDATE users SET gang = @gang, gang_grade = @gang_grade WHERE identifier = @identifier', {
				['@gang']        = gang,
				['@gang_grade']  = grade,
				['@identifier'] 	 = identifier
			}, function(rowsChanged)
				cb()
			end)
		end
	else
		print(('gangs: %s attempted to setGang'):format(xPlayer.identifier))
		cb()
	end
end)

ESX.RegisterServerCallback('gangs:setGangSalary', function(source, cb, gang, grade, salary)
	local isBoss = isPlayerBoss(source, gang)
	local identifier = GetPlayerIdentifier(source, 0)

 	if isBoss then
		if salary <= Config.MaxSalary then
			MySQL.Async.execute('UPDATE gang_grades SET salary = @salary WHERE gang_name = @gang_name AND grade = @grade', {
				['@salary']   = salary,
				['@gang_name'] = gang.name,
				['@grade']    = grade
			}, function(rowsChanged)
				Gangs[gang.name].grades[tonumber(grade)].salary = salary
				local xPlayers = ESX.GetPlayers()

 				for i=1, #xPlayers, 1 do
					local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

 					if xPlayer.gang.name == gang.name and xPlayer.gang.grade == grade then
						xPlayer.setGang(gang, grade)
					end
				end

 				cb()
			end)
		else
			print(('gangs: %s attempted to setGangSalary over config limit!'):format(identifier))
			cb()
		end
	else
		print(('gangs: %s attempted to setGangSalary'):format(identifier))
		cb()
	end
end)

ESX.RegisterServerCallback('gangs:getOnlinePlayers', function(source, cb)
	local xPlayers = ESX.GetPlayers()
	local players  = {}

 	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		table.insert(players, {
			source     = xPlayer.source,
			identifier = xPlayer.identifier,
			name       = xPlayer.name,
			gang       = xPlayer.gang
		})
	end

 	cb(players)
end)

ESX.RegisterServerCallback('gangs:getVehiclesInGarage', function(source, cb, gangName)
	cb(Gangs[gangName].vehicles)
end)

RegisterCommand('veh', function()
	print(ESX.dump(Gangs))
end, false)

RegisterCommand('veha', function()
	print(ESX.dump(Gangs['Daltons'].vehicles))
end, false)

ESX.RegisterServerCallback('gangs:isBoss', function(source, cb, gang)
	cb(isPlayerBoss(source, gang))
end)

function isPlayerBoss(playerId, gang)
	local xPlayer = ESX.GetPlayerFromId(playerId)

 	if xPlayer.gang.label == 'gang' and xPlayer.gang.grade == 6 then
		return true
	else
		print(('gangs: %s attempted open a gang boss menu!'):format(xPlayer.identifier))
		return false
	end
end
