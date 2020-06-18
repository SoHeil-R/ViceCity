--================================================================================================
--==                                VARIABLES - DO NOT EDIT                                     ==
--================================================================================================
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('bank:VCdeposit')
AddEventHandler('bank:VCdeposit', function(amount)
	local _source = source
	
	local xPlayer = ESX.GetPlayerFromId(_source)
	if amount == nil or amount <= 0 or amount > xPlayer.money then
		TriggerClientEvent('bank:result', _source, "error", "Montant invalide.")
	else
		xPlayer.removeMoney(amount)
		xPlayer.addBank(tonumber(amount))
		TriggerClientEvent('bank:result', _source, "success", "Dépot effectué.")
	end
end)


RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local base = 0
	amount = tonumber(amount)
	base = xPlayer.bank
	if amount == nil or amount <= 0 or amount > base then
		TriggerClientEvent('bank:result', _source, "error", "Montant invalide.")
	else
		xPlayer.removeBank( amount)
		xPlayer.addMoney(amount)
		TriggerClientEvent('bank:result', _source, "success", "Retrait effectué.")
	end
end)

RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	balance = xPlayer.bank
	TriggerClientEvent('currentbalance1', _source, balance)
end)


RegisterServerEvent('bank:VCtransfer')
AddEventHandler('bank:VCtransfer', function(to, amountt)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(to)
	local balance = 0

	if(zPlayer == nil or zPlayer == -1) then
		TriggerClientEvent('bank:result', _source, "error", "Destinataire introuvable.")
	else
		balance = xPlayer.bank
		zbalance = zPlayer.bank
		
		if tonumber(_source) == tonumber(to) then
			TriggerClientEvent('bank:result', _source, "error", "Vous ne pouvez pas faire de transfert à vous même.")
		else
			if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
				TriggerClientEvent('bank:result', _source, "error", "Vous n'avez pas assez d'argent en banque.")
			else
				xPlayer.removeBank(tonumber(amountt))
				zPlayer.addBank(tonumber(amountt))
				TriggerClientEvent('bank:result', _source, "success", "Transfert effectué.")
			end
		end
	end
end)





