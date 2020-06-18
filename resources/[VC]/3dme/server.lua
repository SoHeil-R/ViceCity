local logEnabled = false
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text, status)
	TriggerClientEvent('3dme:triggerDisplay', -1, text, source, status)
	if logEnabled then
		setLog(text, source)
	end
end)

RegisterServerEvent('esx:VCgiveInventoryItem')
AddEventHandler('esx:VCgiveInventoryItem', function(target, type, itemName, itemCount)
	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	local sourceName = sourceXPlayer.name
	local targetName = targetXPlayer.name
	local words = {}
	local word = {}
	for w in (sourceName):gmatch("([^_]*)") do 
		table.insert(words, w)
	end
	for w in (targetName):gmatch("([^_]*)") do 
		table.insert(word, w)
	end

	if type == 'item_money' then


		if itemCount > 0 and sourceXPlayer.money >= itemCount then
			TriggerClientEvent('3dme:triggerDisplay', -1, words[1] .. ' be ' .. word[1] .. ' meghdari pool dad' , _source, false)
		end

	elseif type == 'item_weapon' then

			local weaponLabel = ESX.GetWeaponLabel(itemName)

			if itemCount > 0 then
				TriggerClientEvent('3dme:triggerDisplay', -1, words[1] .. ' be ' .. word[1].. ' yek ' .. weaponLabel .. ' dad' , _source, false)
			else
				TriggerClientEvent('3dme:triggerDisplay', -1, words[1] .. ' be ' .. word[1] .. ' yek ' .. weaponLabel .. ' dad' , _source, false)
			end
			
	end

end)

function setLog(text, source)
	local time = os.date("%d/%m/%Y %X")
	local name = GetPlayerName(source)
	local identifier = GetPlayerIdentifiers(source)
	local data = time .. ' : ' .. name .. ' - ' .. identifier[1] .. ' : ' .. text

	local content = LoadResourceFile(GetCurrentResourceName(), "log.txt")
	local newContent = content .. '\r\n' .. data
	SaveResourceFile(GetCurrentResourceName(), "log.txt", newContent, -1)
end

ESX.RegisterServerCallback('3dme:getIcName', function (source, cb)
	
	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer then
			local name = xPlayer.name
			local words = {}
			for w in (name):gmatch("([^_]*)") do 
				table.insert(words, w)
			end
			cb(words[1])
		end

end)