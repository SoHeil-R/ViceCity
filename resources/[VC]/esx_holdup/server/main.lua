local rob = false
local robbers = {}
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_holdup:toofar')
AddEventHandler('esx_holdup:toofar', function(robb)
	local _source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_cancelled_at', Stores[robb].nameofstore))
			TriggerClientEvent('esx_holdup:killblip', xPlayers[i])
		end
	end
	if robbers[_source] then
		TriggerClientEvent('esx_holdup:toofarlocal', _source)
		robbers[_source] = nil
		TriggerClientEvent('esx:showNotification', _source, _U('robbery_cancelled_at', Stores[robb].nameofstore))
	end
end)

RegisterServerEvent('esx_holdup:rob')
AddEventHandler('esx_holdup:rob', function(robb)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local oocname =  GetPlayerName(source)

	if Stores[robb] then
		local store = Stores[robb]

		if (os.time() - store.lastrobbed) < Config.TimerBeforeNewRob and store.lastrobbed ~= 0 then
			TriggerClientEvent('esx:showNotification', _source, _U('recently_robbed', Config.TimerBeforeNewRob - (os.time() - store.lastrobbed)))
			return
		end

		local cops = 0
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'police' then
				cops = cops + 1
			end
		end

		if not rob then
			if cops >= Config.PoliceNumberRequired then

				local blowtorch = xPlayer.getInventoryItem("blowtorch")

				if blowtorch.count > 0 then

					for i=1, #xPlayers, 1 do
						local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
						if xPlayer.job.name == 'police' then
							TriggerClientEvent('esx:showNotification', xPlayers[i], _U('rob_in_prog', store.nameofstore))
							TriggerClientEvent('esx_holdup:setblip', xPlayers[i], Stores[robb].position)
						end
					end

					xPlayer.removeInventoryItem("blowtorch", 1)
					TriggerEvent('DiscordBot:ToDiscord', 'rob', "Rob Log", oocname .. ' Started store robbery in ' ..store.nameofstore ,'user', true, source, false)
					TriggerClientEvent('esx_holdup:currentlyrobbing', _source, robb)
					TriggerClientEvent('esx_holdup:dotherobbery', _source, robb)
					Stores[robb].lastrobbed = os.time()
				
				else

				TriggerClientEvent('esx:showNotification', _source, 'Shoma baraye baaz kardan sandogh bayad ~y~BlowTorch ~s~dashte bashid!')
				
				end
	
			else
				TriggerClientEvent('esx:showNotification', _source, _U('min_police', Config.PoliceNumberRequired))
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('robbery_already'))
		end
	end
end)

RegisterServerEvent('esx_holdup:robcomplete')
AddEventHandler('esx_holdup:robcomplete', function(robb)

	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local store = Stores[robb]
	local award = store.reward
	local savedSource = _source
	TriggerClientEvent('esx_holdup:robberycomplete', savedSource, award)
	TriggerEvent('DiscordBot:ToDiscord', 'rob', "Rob Log", GetPlayerName(_source) .. ' have completed store robbery in ' .. store.nameofstore ,'user', true, source, false)

	if Config.GiveBlackMoney then
		xPlayer.addAccountMoney('black_money', award)
	else
		xPlayer.addMoney(award)
	end
	
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_complete_at', store.nameofstore))
			TriggerClientEvent('esx_holdup:killblip', xPlayers[i])
		end
	end
	
end)

RegisterServerEvent('esx_holdup:robcancel')
AddEventHandler('esx_holdup:robcancel', function(robb)

	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local store = Stores[robb]
	local award = store.reward
	local savedSource = _source
	TriggerEvent('DiscordBot:ToDiscord', 'rob', "Rob Log", GetPlayerName(_source) .. ' canceled store robbery in ' .. store.nameofstore ,'user', true, source, false)
	
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], "Robbery dar " .. store.nameofstore .. " cancel shod" )
			TriggerClientEvent('esx_holdup:killblip', xPlayers[i])
		end
	end
	
end)