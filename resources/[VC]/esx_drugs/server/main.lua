ESX = nil
local playersProcessing = {}
local DrugHandeler

exports.ghmattimysql:execute('SELECT * FROM capture WHERE name = "drug"', {}
, function(drug)
	DrugHandeler = 'gang_' .. string.lower(drug[1].handeler)
end)

RegisterServerEvent('drug:ChangeHandeler')
AddEventHandler('drug:ChangeHandeler', function(newHandler)
	DrugHandeler = 'gang_' .. string.lower(newHandler)
	exports.ghmattimysql:execute('UPDATE capture SET handeler = @handeler WHERE name = "drug"', {
		['@handeler']	= newHandler
	})
end)

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

RegisterServerEvent('esx_jk_drugs:pickedUpCannabis')
AddEventHandler('esx_jk_drugs:pickedUpCannabis', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('weed')
	print(xItem)
	if Config.MultiPlant then
		local picked = math.random(3)
		if xItem.limit ~= -1 and (xItem.count + picked) > xItem.limit then
			TriggerClientEvent('esx:showNotification', _source, _U('weed_inventoryfull'))
		else
			xPlayer.addInventoryItem(xItem.name, picked)
		end
	elseif xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('weed_inventoryfull'))
	else
		xPlayer.addInventoryItem(xItem.name, 1)
	end
end)

ESX.RegisterServerCallback('esx_jk_drugs:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)

	if xItem.limit ~= -1 and xItem.count >= xItem.limit then
		cb(false)
	else
		cb(true)
	end
end)

RegisterServerEvent('esx_jk_drugs:pickedUpCocaPlant')
AddEventHandler('esx_jk_drugs:pickedUpCocaPlant', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('coca')
	local multi = true

	if multi then
		local picked = math.random(3)
		if xItem.limit ~= -1 and (xItem.count + picked) > xItem.limit then
			TriggerClientEvent('esx:showNotification', _source, _U('cocaine_inventoryfull'))
		else
			xPlayer.addInventoryItem(xItem.name, picked)
		end
	elseif xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('cocaine_inventoryfull'))
	else
		xPlayer.addInventoryItem(xItem.name, 1)
	end
end)

RegisterServerEvent('esx_jk_drugs:pickedUpPoppy')
AddEventHandler('esx_jk_drugs:pickedUpPoppy', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('poppy')

	if Config.MultiPlant then
		local picked = math.random(3)
		if xItem.limit ~= -1 and (xItem.count + picked) > xItem.limit then
			TriggerClientEvent('esx:showNotification', _source, _U('opium_inventoryfull'))
		else
			xPlayer.addInventoryItem(xItem.name, picked)
		end
	elseif xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('opium_inventoryfull'))
	else
		xPlayer.addInventoryItem(xItem.name, 5)
	end
end)


function CancelProcessing(playerID)
	if playersProcessing[playerID] then
		ESX.ClearTimeout(playersProcessing[playerID])
		playersProcessing[playerID] = nil
	end
end

RegisterServerEvent('esx_jk_drugs:cancelProcessing')
AddEventHandler('esx_jk_drugs:cancelProcessing', function()
	CancelProcessing(source)
end)

RegisterServerEvent('esx_jk_drugs:restrictedArea')
AddEventHandler('esx_jk_drugs:restrictedArea', function()
	local _source = source
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], (_U('restricted_zone')))
		end
	end
end)

RegisterServerEvent('esx_jk_drugs:testResultsFail')
AddEventHandler('esx_jk_drugs:testResultsFail', function()
	local _source = source
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], (_U('drug_fail')))
		end
	end
end)

RegisterServerEvent('esx_jk_drugs:testResultsFailTipsy')
AddEventHandler('esx_jk_drugs:testResultsFailTipsy', function()
	local _source = source
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], (_U('fail_tipsy')))
		end
	end
end)

RegisterServerEvent('esx_jk_drugs:testResultsFailDrunk')
AddEventHandler('esx_jk_drugs:testResultsFailDrunk', function()
	local _source = source
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], (_U('fail_drunk')))
		end
	end
end)

RegisterServerEvent('esx_jk_drugs:testResultsPass')
AddEventHandler('esx_jk_drugs:testResultsPass', function()
	local _source = source
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], (_U('drug_pass')))
		end
	end
end)

RegisterServerEvent('esx_jk_drugs:testResultsPassBCA')
AddEventHandler('esx_jk_drugs:testResultsPassBCA', function()
	local _source = source
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], (_U('bca_pass')))
		end
	end
end)

RegisterServerEvent('esx_jk_drugs:policeAlert')
AddEventHandler('esx_jk_drugs:policeAlert', function()
	local _source = source
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], (_U('police_alert')))
		end
	end
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)

ESX.RegisterServerCallback('esx_jk_drugs:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

RegisterServerEvent('esx_jk_drugs:removeItem')
AddEventHandler('esx_jk_drugs:removeItem', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem(item, 1)
end)

RegisterServerEvent('esx_jk_drugs:giveItem')
AddEventHandler('esx_jk_drugs:giveItem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)
	local count = 1

	if xItem.limit ~= -1 then
		count = xItem.limit - xItem.count
	end

	if xItem.count < xItem.limit then
		xPlayer.addInventoryItem(itemName, count)
	else
		TriggerClientEvent('esx:showNotification', source, "You're at maximum items")
	end
end)

RegisterServerEvent('esx_drugs:sellDrug')
AddEventHandler('esx_drugs:sellDrug', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = DrugDealerItems.get(itemName)
	local xItem = xPlayer.getInventoryItem(itemName)

	if not price then
		print(('esx_drugs: %s attempted to sell an invalid drug!'):format(xPlayer.identifier))
		return
	end

	if xItem.count < amount then
		TriggerClientEvent('esx:showNotification', source, _U('dealer_notenough'))
		return
	end

	price = ESX.Math.Round(price * amount)

	xPlayer.addMoney(price)

	xPlayer.removeInventoryItem(xItem.name, amount)

	-- TriggerEvent('gangaccount:getGangAccount', DrugHandeler, function(account)
	-- 	account.addMoney(price)
	-- end)

	TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', amount, xItem.label, ESX.Math.GroupDigits(price)))
end)

ESX.RegisterUsableItem('joint', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('joint', 1)

		TriggerClientEvent('esx_jk_drugs:useItem', source, 'joint')

		Citizen.Wait(1000)
end)

ESX.RegisterUsableItem('cocaine', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('cocaine', 1)

		TriggerClientEvent('esx_jk_drugs:useItem', source, 'cocaine')

		Citizen.Wait(1000)
end)

ESX.RegisterUsableItem('crack', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('crack', 1)

		TriggerClientEvent('esx_jk_drugs:useItem', source, 'crack')

		Citizen.Wait(1000)
end)

ESX.RegisterUsableItem('meth', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('meth', 1)

		TriggerClientEvent('esx_jk_drugs:useItem', source, 'meth')

		Citizen.Wait(1000)
end)

ESX.RegisterUsableItem('heroin', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('heroin', 1)

		TriggerClientEvent('esx_jk_drugs:useItem', source, 'heroin')

		Citizen.Wait(1000)
end)

ESX.RegisterUsableItem('drugtest', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('drugtest', 1)

		TriggerClientEvent('esx_jk_drugs:useItem', source, 'drugtest')

		Citizen.Wait(1000)
end)

ESX.RegisterUsableItem('fakepee', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('fakepee', 1)

		TriggerClientEvent('esx_jk_drugs:useItem', source, 'fakepee')

		Citizen.Wait(1000)
end)

ESX.RegisterUsableItem('beer', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('beer', 1)

		TriggerClientEvent('esx_jk_drugs:useItem', source, 'beer')

		Citizen.Wait(1000)
end)

ESX.RegisterUsableItem('tequila', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('tequila', 1)

		TriggerClientEvent('esx_jk_drugs:useItem', source, 'tequila')

		Citizen.Wait(1000)
end)

ESX.RegisterUsableItem('vodka', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('vodka', 1)

		TriggerClientEvent('esx_jk_drugs:useItem', source, 'vodka')

		Citizen.Wait(1000)
end)

ESX.RegisterUsableItem('whiskey', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('whiskey', 1)

		TriggerClientEvent('esx_jk_drugs:useItem', source, 'whiskey')

		Citizen.Wait(1000)
end)

ESX.RegisterUsableItem('breathalyzer', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('breathalyzer', 1)

		TriggerClientEvent('esx_jk_drugs:useItem', source, 'breathalyzer')

		Citizen.Wait(1000)
end)

function Generator()
	local self = {}
	self.get = function(k)
		return self[k]
	end

	self.regen	= function()
		self.joint	    = math.random(9, 10)
		self.cocaine	= math.random(37, 38)
		self.heroin	    = math.random(150, 155)
		self.meth		= math.random(95, 100)
		TriggerClientEvent('esx_jk_drugs:getPrice', -1, {
			{name = 'joint' 	    , price = self.joint},
			{name = 'crack'			, price = self.crack},
			{name = 'cocaine'		, price = self.cocaine},
			{name = 'heroin'		, price = self.heroin},
			{name = 'meth'			, price = self.meth}
		})
	end

	self.getPrices = function(name)
		return self[name]
	end
	return self
end
DrugDealerItems = Generator()

AddEventHandler('esx:playerLoaded', function(source)
	TriggerClientEvent('esx_jk_drugs:getPrice', source, {
		{name = 'joint' 	    , price = DrugDealerItems.get('joint')},
		{name = 'cocaine'		, price = DrugDealerItems.get('cocaine')},
		{name = 'heroin'		, price = DrugDealerItems.get('heroin')},
		{name = 'meth'			, price = DrugDealerItems.get('meth')}
	})
end)

function loop()
	DrugDealerItems.regen()

  	SetTimeout(1000*60*10, loop)
end

loop()
