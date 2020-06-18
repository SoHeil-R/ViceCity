RegisterServerEvent('ioh:checkadmin')
AddEventHandler('ioh:checkadmin', function()
	local _source = source
	TriggerEvent('es:getPlayerFromId', _source, function(user)
		if user ~= nil then 
			if user.getGroup() == "superadmin" then
				TriggerClientEvent('ioh:isAdmin', source)
			end
		end
	end)
end)