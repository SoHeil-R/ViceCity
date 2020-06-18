ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterCommand("ad", function(source, args)
	
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == "mechanic" then

		if xPlayer.job.grade == 4 or xPlayer.job.grade == 3 then

			if args[1] then

				local xPlayers = ESX.GetPlayers()
				for i=1, #xPlayers, 1 do
					TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Etelaee Mechanici', string.gsub(xPlayer.name, "_", " "), table.concat(args, " "), 'CHAR_LS_CUSTOMS', 1)
				end

			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Shoma nemitavanid tabligh khali befrestid!")
			end

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Shoma dastresi kafi baraye estefade az tablighat nadarid!")
		end
	
	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Shoma mechanic nistid!")
	end
	

end, false)
	
