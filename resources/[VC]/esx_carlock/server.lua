ESX               = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('carlock:isVehicleOwner', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	exports.ghmattimysql:scalar('SELECT owner FROM owned_vehicles WHERE (owner = @player or owner = @gang) AND plate = @plate', {
		['@player'] = xPlayer.identifier,
		['@gang']  	= xPlayer.gang.name,
		['@plate'] 	= plate
	}, function(result)
		if result then
			cb(result == xPlayer.identifier or result == xPlayer.gang.name)
		else
			cb(false)
		end
	end)
end)