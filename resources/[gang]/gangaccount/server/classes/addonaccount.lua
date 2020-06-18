function CreateGangAccount(name, owner, money, pay)
	local self = {}

	self.name  = name
	self.owner = owner
	self.money = money
	self.pay	= pay

	self.addMoney = function(m)
		self.money = self.money + m

		self.save()

		TriggerClientEvent('gangprop:setMoney', self.name, self.money)
	end

	self.removeMoney = function(m)
		self.money = self.money - m

		self.save()

		TriggerClientEvent('gangprop:setMoney', self.name, self.money)
	end

	self.setMoney = function(m)
		self.money = m

		self.save()

		TriggerClientEvent('gangprop:setMoney', -1, self.name, self.money)
	end

	self.save = function()
		if self.owner == nil then
			MySQL.Async.execute('UPDATE gang_account_data SET money = @money WHERE gang_name = @gang_name',
			{
				['@gang_name']  = self.name,
				['@money']        = self.money
			})
		end
	end

	return self
end