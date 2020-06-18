local rob = false
local robbers = {}
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('esx_holdupbank:toofar')
AddEventHandler('esx_holdupbank:toofar', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_cancelled_at') .. Banks[robb].nameofbank)
			TriggerClientEvent('esx_holdupbank:killblip', xPlayers[i])
		end
	end
	TriggerEvent('DiscordBot:ToDiscord', 'rob', 'Bank Rob Log', GetPlayerName(source) .. ' Canceled bank robbery in ' .. Banks[robb].nameofbank ,'user', true, source, false)
	if(robbers[source])then
		TriggerClientEvent('esx_holdupbank:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('esx:showNotification', source, _U('robbery_has_cancelled') .. Banks[robb].nameofbank)
	end
end)

RegisterServerEvent('esx_holdupbank:rob')
AddEventHandler('esx_holdupbank:rob', function(robb)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local drill = xPlayer.getInventoryItem('drill')
	local xPlayers = ESX.GetPlayers()
	local oocname =  GetPlayerName(source)
	
	if Banks[robb] then

		local bank = Banks[robb]

		if (os.time() - bank.lastrobbed) < 7200 and bank.lastrobbed ~= 0 then

			TriggerClientEvent('esx:showNotification', source, _U('already_robbed') .. math.floor((7200 - (os.time() - bank.lastrobbed))/60) .. _U('minute'))
			return
		end


		local cops = 0
		for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
				cops = cops + 1
			end
		end


		if rob == false then
		xPlayer = ESX.GetPlayerFromId(source) 
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', source, _U('cant_robb'))
			return
		end
		  if xPlayer.getInventoryItem('drill').count >= 1 then

			if(cops >= Config.NumberOfCopsRequired) then
			 xPlayer.removeInventoryItem('drill', 1)
				rob = true
				for i=1, #xPlayers, 1 do
					local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
					if xPlayer.job.name == 'police' then
							TriggerClientEvent('esx:showNotification', xPlayers[i], _U('rob_in_prog') .. bank.nameofbank)
							TriggerClientEvent('esx_holdupbank:setblip', xPlayers[i], Banks[robb].position)
					end
				end
				TriggerEvent('DiscordBot:ToDiscord', 'rob', 'Bank Rob Log' , oocname .. ' Started bank robbery in ' ..bank.nameofbank ,'user', true, source, false)

				TriggerClientEvent('esx:showNotification', source, _U('started_to_rob') .. bank.nameofbank .. _U('do_not_move'))
				TriggerClientEvent('esx:showNotification', source, _U('alarm_triggered'))
				TriggerClientEvent('esx:showNotification', source, _U('hold_pos'))
				TriggerClientEvent('esx_holdupbank:currentlyrobbing', source, robb)
				TriggerClientEvent('esx_holdupbank:doTheRobbery', source, robb)
				Banks[robb].lastrobbed = os.time()
				robbers[source] = robb
				local savedSource = source
				-- SetTimeout(360000, function()
				-- 	if(robbers[savedSource])then
				-- 		rob = false
				-- 		TriggerClientEvent('esx_holdupbank:robberycomplete', savedSource, job)
				-- 		if(xPlayer)then
				-- 			xPlayer.addAccountMoney('black_money', bank.reward)
				-- 			local xPlayers = ESX.GetPlayers()
				-- 			for i=1, #xPlayers, 1 do
				-- 				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				-- 				if xPlayer.job.name == 'police' then
				-- 						TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_complete_at') .. bank.nameofbank .. _U('robbery_complete_at2'))
				-- 						TriggerClientEvent('esx_holdupbank:killblip', xPlayers[i])
				-- 				end
				-- 			end
				-- 		end
				-- 	end
				-- end)
			else
				TriggerClientEvent('esx:showNotification', source, _U('min_two_police') .. Config.NumberOfCopsRequired)
			end
		else
			TriggerClientEvent('esx:showNotification', source, _U('drill'))
		end
		else
			TriggerClientEvent('esx:showNotification', source, _U('robbery_already'))
		end
	end
end)

RegisterServerEvent('esx_holdupbank:giveReward')
AddEventHandler('esx_holdupbank:giveReward', function(robb)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local reward = Banks[robb].reward
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
				TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_complete_at') .. bank.nameofbank .. _U('robbery_complete_at2'))
				TriggerClientEvent('esx_holdupbank:killblip', xPlayers[i])
		end
	end
	xPlayer.addMoney(reward)
	TriggerEvent('DiscordBot:ToDiscord', 'rob', 'Bank Rob Log', GetPlayerName(source) .. ' Completed bank robbery in ' .. Banks[robb].nameofbank .. ' and rewarded with: ' .. reward .. '$' ,'user', true, source, false)
	TriggerClientEvent('esx:showNotification', source, 'Robbery ba ~g~movafaghiat kamel~s~ shod va shoma ~y~' .. reward .. '$~s~ daryaft kardid!')

end)