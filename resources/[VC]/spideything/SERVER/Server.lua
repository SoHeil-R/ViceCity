DiscordWebhookSystemInfos = 'https://discordapp.com/api/webhooks/699977208403329127/B80G6BYGD0vtDhl3fna-WK-wVsVXKoe4Ux22wXeKDo_po68uwlb2alCbyvTNvxD8hixm'
DiscordWebhookKillinglogs = 'https://discordapp.com/api/webhooks/699977317748965416/BnNx6BAQdgNGeNwYONtKEYYcHfI1Cog0dx5rEi5C0PmMTiCVUtLL6jW3mGRJn-arpeOt'
DiscordWebhookChat        = 'https://discordapp.com/api/webhooks/699977417133129809/ZhTbGuRDjaLZcMF8b95ieP1ZGbe0mBu5bJvX_TZvohzxobK0DTPAkrQ4gv0lNXVemIZT'
DiscordWebhookPwi         = 'https://discordapp.com/api/webhooks/699978328857247786/SNJjnamKA1jG4cnXT56ufOKmT_VtZrSk1ChmPQNygZ6qbuzGy15CTaikhHDtoep6pZUy'
DiscordWebhookloot        = 'https://discordapp.com/api/webhooks/699978441294086236/uTsTKUEl84Hd9TUQ-qP7RVNftoPbXjwaEPuHP0CrUVUmKXlySUm42wIXwp64L_Si_oNw'
DiscordWebhookduty        = 'https://discordapp.com/api/webhooks/699978530448212059/yDTpgX0xbHg-4Azdu6NzuslwwG-3vetwr7BZYFHgl2-O35nNTHaAkD_o6MO3pvHLJdUh'
DiscordWebhookrob         = 'https://discordapp.com/api/webhooks/699978625214316655/prmY_DK7DKaTGNnKa6o-4sCE-iDmGyz1RJ5tq8oujAi9RRy7CquNgLOTsIxg72J8yZac'
DiscordWebhookInventory   = 'https://discordapp.com/api/webhooks/699978733389611049/T6yTs2bMkrqcyKy01TmHTXQG4ZtcpZ0NGVYQ6SGCHVI3BRr839FKsg4HgP1UlhgORgLW'
DiscordWebhookJail        = 'https://discordapp.com/api/webhooks/699978864037855284/HdkaIYP1i1_w92MvIHYJhbyLhib9NHer_2BVtBVeaU4f2mPrMR50KhA7Z2amVV3jxbj4'
DiscordWebhookaJail       = 'https://discordapp.com/api/webhooks/699979381023703182/kIc9Obp2WOWDldcVyxQIhkDnTeIfFCdX0X21Dn-bdbxoD1YCt32sK6Rcj3RgSdAsJbPR'
DiscordWebhookBansystem   = 'https://discordapp.com/api/webhooks/699979479086399548/kYGn3bh0UPRII-rUlw_h6XfW_6GMpTSJulVBdPUMBsohtDSItEQ8WgsC-BMXczVtkkYx'
DiscordWebhookBansystemP  = 'https://discordapp.com/api/webhooks/699979560674131969/aD2eaMam6COCQH1W7FSr9D41akz-OCwHZXW122u4lpzWC8Vhss7qlM0pzVJKeTImJ3f5'
DiscordWebhookDisband     = 'https://discordapp.com/api/webhooks/699979628143706173/brkEDCMhbK4emPxrkxktO-Nt4llFpiYOR8HNXTkd3GrQHKjcsoxf3jiLyXkR3ZAKmjtm'
DiscordWebhookReset       = 'https://discordapp.com/api/webhooks/699979712965116054/eL9dx1aKGHolXnz-iz90bnwplGvbLyR58GcDf5v1LZ--aLrznznw-azpv8WtcjBxAcnd'
DiscordWebhookDrop        = 'https://discordapp.com/api/webhooks/699979855386902570/zAtGNMpckuiXHesjoMIGnFX4mUo2D9odb27QAzalnGj27Gz6hbnNLNkQVt1CbrFPaibj'
DiscordWebhookPickUP      = 'https://discordapp.com/api/webhooks/699979940212244530/1yEax2abYn_RhM9qv8X3N0TBa6EfaB84wxTqoOBoh27TyuqVEgG-yritVVEXYhyXGPhX'
DiscordWebhookAmoneyLog   = 'https://discordapp.com/api/webhooks/699980144491626567/y2820aWszXeGAOw_mrWw6I_R9Yw2B7MUI9-p6O33X7lckHud1BgWG7CJph5-CtvRB0fn'
DiscordWebhookHome        = 'https://discordapp.com/api/webhooks/699980229711626250/40BLRVda1BorJgPLF35SoyITkcN7zcFCz8PZLagLVVWxm2MiftHKPxElpIkBmBYIYigF'


if DiscordWebhookSystemInfos == nil and DiscordWebhookKillinglogs == nil and DiscordWebhookChat == nil then
	local Content = LoadResourceFile(GetCurrentResourceName(), 'config.lua')
	Content = load(Content)
	Content()
end
if DiscordWebhookSystemInfos == 'WEBHOOK_LINK_HERE' then
	print('\n\nERROR\n' .. GetCurrentResourceName() .. ': Please add your "System Infos" webhook\n\n')
else
	PerformHttpRequest(DiscordWebhookSystemInfos, function(Error, Content, Head)
		if Content == '{"code": 50027, "message": "Invalid Webhook Token"}' then
			print('\n\nERROR\n' .. GetCurrentResourceName() .. ': "System Infos" webhook non-existing!\n\n')
		end
	end)
end
if DiscordWebhookKillinglogs == 'WEBHOOK_LINK_HERE' then
	print('\n\nERROR\n' .. GetCurrentResourceName() .. ': Please add your "Killing Log" webhook\n\n')
else
	PerformHttpRequest(DiscordWebhookKillinglogs, function(Error, Content, Head)
		if Content == '{"code": 50027, "message": "Invalid Webhook Token"}' then
			print('\n\nERROR\n' .. GetCurrentResourceName() .. ': "Killing Log" webhook non-existing!\n\n')
		end
	end)
end
if DiscordWebhookChat == 'WEBHOOK_LINK_HERE' then
	print('\n\nERROR\n' .. GetCurrentResourceName() .. ': Please add your "Chat" webhook\n\n')
else
	PerformHttpRequest(DiscordWebhookChat, function(Error, Content, Head)
		if Content == '{"code": 50027, "message": "Invalid Webhook Token"}' then
			print('\n\nERROR\n' .. GetCurrentResourceName() .. ': "Chat" webhook non-existing!\n\n')
		end
	end)
end
	
-- System Infos
PerformHttpRequest(DiscordWebhookSystemInfos, function(Error, Content, Head) end, 'POST', json.encode({username = SystemName, content = '**FiveM server webhook started**'}), { ['Content-Type'] = 'application/json' })

AddEventHandler('playerConnecting', function()
	TriggerEvent('DiscordBot:ToDiscord', DiscordWebhookSystemInfos, SystemName, '```css\n' .. GetPlayerName(source) .. ' connecting\n```', SystemAvatar, false)
end)

AddEventHandler('playerDropped', function(Reason)
	TriggerEvent('DiscordBot:ToDiscord', DiscordWebhookSystemInfos, SystemName, '```fix\n' .. GetPlayerName(source) .. ' left (' .. Reason .. ')\n```', SystemAvatar, false)
end)

-- Killing Log
RegisterServerEvent('DiscordBot:playerDied')
AddEventHandler('DiscordBot:playerDied', function(Message, Weapon)
	local date = os.date('*t')
	
	if date.day < 10 then date.day = '0' .. tostring(date.day) end
	if date.month < 10 then date.month = '0' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
	if Weapon then
		Message = Message .. ' [' .. Weapon .. ']'
	end
	TriggerEvent('DiscordBot:ToDiscord', DiscordWebhookKillinglogs, SystemName, Message .. ' `' .. date.day .. '.' .. date.month .. '.' .. date.year .. ' - ' .. date.hour .. ':' .. date.min .. ':' .. date.sec .. '`', SystemAvatar, false)
end)

-- Chat
-- AddEventHandler('chatMessage', function(Source, Name, Message)
	
-- 		print('Log message: ' .. Message)
-- 		print(Name)
-- 		print(Source)
-- 		--Getting the steam avatar if available
-- 		TriggerEvent('DiscordBot:ToDiscord', 'chat', Name .. ' [ID: ' .. Source .. ']', Message, 'user', true, Source, false) --Sending the message to discord

-- end)

--Event to actually send Messages to Discord
RegisterServerEvent('DiscordBot:ToDiscord')
AddEventHandler('DiscordBot:ToDiscord', function(WebHook, Name, Message, Image, External, Source, TTS)
	if Message == nil or Message == '' then
		return nil
	end
	if TTS == nil or TTS == '' then
		TTS = false
	end
	if External then
		if WebHook:lower() == 'chat' then
			WebHook = DiscordWebhookChat
		elseif WebHook:lower() == 'system' then
			WebHook = DiscordWebhookSystemInfos
		elseif WebHook:lower() == 'kill' then
			WebHook = DiscordWebhookKillinglogs
		elseif WebHook:lower() == 'pwi' then
			WebHook = DiscordWebhookPwi
		elseif WebHook:lower() == 'rob' then
			WebHook = DiscordWebhookrob
		elseif WebHook:lower() == 'loot' then
			WebHook = DiscordWebhookloot
		elseif WebHook:lower() == 'home' then
			WebHook = DiscordWebhookHome
		elseif WebHook:lower() == 'inventory' then
			WebHook = DiscordWebhookInventory
		elseif WebHook:lower() == 'duty' then
			WebHook = DiscordWebhookduty
		elseif WebHook:lower() == 'jail' then
			WebHook = DiscordWebhookJail
		elseif WebHook:lower() == 'ajail' then
			WebHook = DiscordWebhookaJail
		elseif WebHook:lower() == 'bansystem' then
			WebHook = DiscordWebhookBansystem
		elseif WebHook:lower() == 'bansystemp' then
			WebHook = DiscordWebhookBansystemP
		elseif WebHook:lower() == 'disband' then
			WebHook = DiscordWebhookDisband	
		elseif WebHook:lower() == 'reset' then
			WebHook = DiscordWebhookReset
		elseif WebHook:lower() == 'drop' then
			WebHook = DiscordWebhookDrop
		elseif WebHook:lower() == 'pickup' then
			WebHook = DiscordWebhookPickUP
		elseif WebHook:lower() == 'amoney' then
			WebHook = DiscordWebhookAmoneyLog
		elseif not Webhook:find('discordapp.com/api/webhooks') then
			print('ToDiscord event called without a specified webhook!')
			return nil
		end
		
		if Image:lower() == 'steam' then
			Image = UserAvatar
			if GetIDFromSource('steam', Source) then
				PerformHttpRequest('http://steamcommunity.com/profiles/' .. tonumber(GetIDFromSource('steam', Source), 16) .. '/?xml=1', function(Error, Content, Head)
					local SteamProfileSplitted = stringsplit(Content, '\n')
					for i, Line in ipairs(SteamProfileSplitted) do
						if Line:find('<avatarFull>') then
							Image = Line:gsub('	<avatarFull><!%[CDATA%[', ''):gsub(']]></avatarFull>', '')
							return PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Image, tts = TTS}), {['Content-Type'] = 'application/json'})
						end
					end
				end)
			end
		elseif Image:lower() == 'user' then
			Image = UserAvatar
		else
			Image = SystemAvatar
		end
	end
	PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Image, tts = TTS}), {['Content-Type'] = 'application/json'})
end)

-- Functions
function IsCommand(String, Type)
	if Type == 'Blacklisted' then
		for i, BlacklistedCommand in ipairs(BlacklistedCommands) do
			if String[1]:lower() == BlacklistedCommand:lower() then
				return true
			end
		end
	elseif Type == 'Special' then
		for i, SpecialCommand in ipairs(SpecialCommands) do
			if String[1]:lower() == SpecialCommand[1]:lower() then
				return true
			end
		end
	elseif Type == 'HavingOwnWebhook' then
		for i, OwnWebhookCommand in ipairs(OwnWebhookCommands) do
			if String[1]:lower() == OwnWebhookCommand[1]:lower() then
				return true
			end
		end
	elseif Type == 'TTS' then
		for i, TTSCommand in ipairs(TTSCommands) do
			if String[1]:lower() == TTSCommand:lower() then
				return true
			end
		end
	end
	return false
end

function ReplaceSpecialCommand(String)
	for i, SpecialCommand in ipairs(SpecialCommands) do
		if String[1]:lower() == SpecialCommand[1]:lower() then
			String[1] = SpecialCommand[2]
		end
	end
	return String
end

function GetOwnWebhook(String)
	for i, OwnWebhookCommand in ipairs(OwnWebhookCommands) do
		if String[1]:lower() == OwnWebhookCommand[1]:lower() then
			if OwnWebhookCommand[2] == 'WEBHOOK_LINK_HERE' then
				print('Please enter a webhook link for the command: ' .. String[1])
				return DiscordWebhookChat
			else
				return OwnWebhookCommand[2]
			end
		end
	end
end

function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end
	
	local t={} ; i=1
	
	for str in string.gmatch(input, '([^'..seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	
	return t
end

function GetIDFromSource(Type, ID) --(Thanks To WolfKnight [forum.FiveM.net])
    local IDs = GetPlayerIdentifiers(ID)
    for k, CurrentID in pairs(IDs) do
        local ID = stringsplit(CurrentID, ':')
        if (ID[1]:lower() == string.lower(Type)) then
            return ID[2]:lower()
        end
    end
    return nil
end