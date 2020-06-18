Citizen.CreateThread(function()
	while true do
		SetDiscordAppId(699915210730897428)
        SetDiscordRichPresenceAssetText('ViceCity Rp')
		SetDiscordRichPresenceAssetSmallText('Discord: discord.gg/cpgQqV2')
		SetDiscordRichPresenceAsset('vicecityblue')
		Citizen.Wait(10000)
		SetDiscordRichPresenceAsset('vicecityred')
		Citizen.Wait(10000)
		SetDiscordRichPresenceAsset('vicecitygif')
		Citizen.Wait(10000)
	end
end)
Citizen.CreateThread(function()
	while true do
	Citizen.Wait(10000)
		local pId = GetPlayerServerId(PlayerId())

		-- Set here the amount of slots you have (Edit if needed)
		local maxPlayerSlots = 64

		-- For loop to get active player (Legacy method)
		players = {}
		for i = 0, 255 do
			if NetworkIsPlayerActive( i ) then
				table.insert( players, i )
			end
		end

		-- Sets the string with variables as RichPresence (Don't touch)
		SetRichPresence(string.format("Players: %s/%s | ID: %s", #players, maxPlayerSlots, pId))
		
		-- It updates every one minute just in case.
		Citizen.Wait(60000)
	end
end)