ESX.StartPayCheck = function()

	function payCheck()
		local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			local job     = xPlayer.job.grade_name
			local gang	  = xPlayer.gang.name

			local jsalary  = xPlayer.job.grade_salary
			local gsalary  = xPlayer.gang.grade_salary

			if jsalary > 0 then
				if job == 'unemployed' then
					TriggerEvent('esx-salary:ThisHide_modify', xPlayer.source, "add", jsalary)
					TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_help', jsalary), 'CHAR_BANK_MAZE', 9)
				else
					TriggerEvent('esx-salary:ThisHide_modify', xPlayer.source, "add", jsalary)
					TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_salary', jsalary), 'CHAR_BANK_MAZE', 9)
				end
			end

			if gsalary > 0 then
				TriggerEvent('gangaccount:getGangAccount', 'gang_' .. string.lower(gang), function(account)
					if account.money >= gsalary then 
						xPlayer.addBank(gsalary)
						account.removeMoney(gsalary)

						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Gang House', 'Payame Daryafte Hoghogh', 'Mablaqe Daryafti: '.. gsalary, 'CHAR_MP_DETONATEPHONE', 9)
					end
				end)
			end

		end

		SetTimeout(Config.PaycheckInterval, payCheck)

	end

	SetTimeout(Config.PaycheckInterval, payCheck)

end
