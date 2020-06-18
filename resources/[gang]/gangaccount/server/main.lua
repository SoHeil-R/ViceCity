ESX                  = nil
local AccountsIndex  = {}
local GangAccounts = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()
	local result = MySQL.Sync.fetchAll('SELECT * FROM gang_account')

	for i=1, #result, 1 do
		local name   = result[i].name
		local shared = result[i].shared

		local result2 = MySQL.Sync.fetchAll('SELECT * FROM gang_account_data WHERE gang_name = @gang_name', {
			['@gang_name'] = name
		})

		if shared ~= 0 then
			local money = nil
			local pay	= false

			if #result2 == 0 then
				MySQL.Sync.execute('INSERT INTO gang_account_data (gang_name, money, owner) VALUES (@gang_name, @money, NULL)',
				{
					['@gang_name'] 		= name,
					['@money']        	= 0
				})

				money = 0
			else
				money = result2[1].money
				pay		= result2[1].pay
			end

			local gangAccount   = CreateGangAccount(name, nil, money, pay)
			GangAccounts[name] = gangAccount
		end
	end
end)

function GetGangAccount(name)
	return GangAccounts[name]
end

AddEventHandler('gangaccount:getGangAccount', function(name, cb)
	cb(GetGangAccount(name))
end)

AddEventHandler('gangaccount:addGang', function(gangname)
	gang = 'gang_' .. string.lower(gangname)
	local gangAccount   = CreateGangAccount(gang, nil, 0, 0)
	GangAccounts[gang] = gangAccount
end)

AddEventHandler('gangaccount:updateGangAccount', function(name, cb)

	local result = MySQL.Sync.fetchAll('SELECT * FROM gang_account_data WHERE gang_name = @gang_name', {
		['@gang_name'] = name
	})
	
	local money = nil
	
	GangAccounts[name].money = result[1].money
	
	cb(GetGangAccount(name))
end)