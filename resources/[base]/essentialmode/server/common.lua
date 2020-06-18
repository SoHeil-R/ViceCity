ESX                      = {}
ESX.Players              = {}
ESX.UsableItemsCallbacks = {}
ESX.Items                = {}
ESX.ServerCallbacks      = {}
ESX.TimeoutCount         = -1
ESX.CancelledTimeouts    = {}
ESX.LastPlayerData       = {}
ESX.Pickups              = {}
ESX.PickupId             = 0
ESX.Jobs                 = {}
ESX.Gangs			 	 = {}

AddEventHandler('esx:getSharedObject', function(cb)
	cb(ESX)
end)

function getSharedObject()
	return ESX
end

MySQL.ready(function()
	exports.ghmattimysql:execute('SELECT * FROM items', {}, function(result)
		for i=1, #result, 1 do
			ESX.Items[result[i].name] = {
				label     = result[i].label,
				limit     = result[i].limit,
				rare      = (result[i].rare       == 1 and true or false),
				canRemove = (result[i].can_remove == 1 and true or false),
			}
		end
	end)

	local result = MySQL.Sync.fetchAll('SELECT * FROM jobs', {})

	for i=1, #result do
		ESX.Jobs[result[i].name] = result[i]
		ESX.Jobs[result[i].name].grades = {}
	end

	local result2 = MySQL.Sync.fetchAll('SELECT * FROM job_grades', {})

	for i=1, #result2 do
		if ESX.Jobs[result2[i].job_name] then
			ESX.Jobs[result2[i].job_name].grades[tonumber(result2[i].grade)] = result2[i]
		else
			print(('es_extended: invalid job "%s" from table job_grades ignored!'):format(result2[i].job_name))
		end
	end

	for k,v in pairs(ESX.Jobs) do
		if next(v.grades) == nil then
			ESX.Jobs[v.name] = nil
			print(('es_extended: ignoring job "%s" due to missing job grades!'):format(v.name))
		end
	end

	local gang = MySQL.Sync.fetchAll('SELECT * FROM gangs', {})

	for i=1, #gang do
		ESX.Gangs[gang[i].name] = gang[i]
		ESX.Gangs[gang[i].name].grades = {}
	end

	local gang2 = MySQL.Sync.fetchAll('SELECT * FROM gang_grades', {})

	for i=1, #gang2 do
		if ESX.Gangs[gang2[i].gang_name] then
			ESX.Gangs[gang2[i].gang_name].grades[tonumber(gang2[i].grade)] = gang2[i]
		else
			print(('es_extended: invalid gang "%s" from table gang_grades ignored!'):format(gang2[i].gang_name))
		end
	end

	for k,v in pairs(ESX.Gangs) do
		if next(v.grades) == nil then
			ESX.Gangs[v.name] = nil
			print(('es_extended: ignoring gang "%s" due to missing gang grades!'):format(v.name))
		end
	end
end)

RegisterCommand('gangs', function()
	print(ESX.dump(ESX.Gangs))
end, false)

AddEventHandler('playerLoaded', function(source, player)
	local items           = {}
	local playerItems     = player.inventory

	for i=1, #playerItems, 1 do
		items[playerItems[i].name] = playerItems[i].count
	end
end)

RegisterServerEvent('esx:triggerServerCallback')
AddEventHandler('esx:triggerServerCallback', function(name, requestId, ...)
	local _source = source

	ESX.TriggerServerCallback(name, requestID, _source, function(...)
		TriggerClientEvent('esx:serverCallback', _source, requestId, ...)
	end, ...)
end)

RegisterServerEvent('es_extended:addGang')
AddEventHandler('es_extended:addGang', function(name,ranks)
	ESX.Gangs[name] = {name = name,label = 'gang'}
	ESX.Gangs[name].grades = {}
	for i=1, #ranks, 1 do
		ESX.Gangs[name].grades[tonumber(i)] = {gang_name = name, grade = i, name = 'Rank'..i, label = 'Rank'..i, salary = 100*i, skin_male = '{}', skin_female = '{}'}
	end
end)