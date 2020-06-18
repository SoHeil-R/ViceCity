ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_carrental:counttaxi', function(source, cb)
	CountTaxi(cb)
end)

function CountTaxi(cb)

	local xPlayers = ESX.GetPlayers()
	local taxi = 0
	for i=1, #xPlayers, 1 do 
	
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == "taxi" then
			taxi = taxi + 1
		end
	
	end

	if taxi < 3 then
		cb(true)
	else
		cb(false)
	end

end

RegisterServerEvent("chargePlayer")
AddEventHandler("chargePlayer", function(chargeAmount)
     local xPlayer        = ESX.GetPlayerFromId(source)
     xPlayer.removeMoney(chargeAmount)
     CancelEvent()
end)

RegisterServerEvent("devAddPlayer")
AddEventHandler("devAddPlayer", function(devAddAmount)
	TriggerEvent("es:getPlayerFromId", source, function(user)
		user.addMoney(devAddAmount)
		CancelEvent()
	end)
end)