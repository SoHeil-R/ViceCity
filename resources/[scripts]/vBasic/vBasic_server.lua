-- vBasic by Vespura.
-- v4.0 / 29-06-2018
-- No need to touch anything in here, use the convars instead.


-- Settings (convars)
local settings = {}

settings.pvp                    =       GetConvarInt("vBasic.pvp", 0) -- 0 = do nothing, 1 = force enable, 2 = force disable
settings.neverWanted            =       (GetConvar("vBasic.neverWanted", "false") == "true") and true or false
settings.noEmergencyServices    =       (GetConvar("vBasic.noEmergencyServices", "false") == "true") and true or false
settings.godmode                =       GetConvarInt("vBasic.godmode", 0) -- 0 = do nothing, 1 = force enable, 2 = (try to) force disable
settings.welcomeMessage         =       GetConvar("vBasic.welcomeMessage", "Hello ^1{player}^0, welcome to the server! Please read the rules and enjoy your stay.")
settings.isWelcomeMessageGlobal =       (GetConvar("vBasic.isWelcomeMessageGlobal", "false") == "true") and true or false
settings.enableWhitelist        =       (GetConvar("vBasic.enableWhitelist", "false") == "true") and true or false
settings.whitelistMessage       =       GetConvar("vBasic.whitelistMessage", "Sorry, this server is whitelisted and you're not on the list, or the server is in maintenance mode.")
settings.trafficDensity         =       tonumber(GetConvar("vBasic.trafficDensity", "1.0"))
settings.pedDensity             =       tonumber(GetConvar("vBasic.pedDensity", "1.0"))
settings.unlimitedStamina       =       (GetConvar("vBasic.unlimitedStamina", "true") == "true") and true or false


-- Handle the sending of settings to clients whenever a client requests the settings.
RegisterServerEvent("vBasic:getSettings")
AddEventHandler("vBasic:getSettings", function()
    TriggerClientEvent("vBasic:setSettings", source, json.encode(settings))
    if (settings.welcomeMessage ~= "none" and settings.welcomeMessage ~= "") then
        local msgString = string.gsub(settings.welcomeMessage, "{player}", GetPlayerName(source))
        local message = {args = {msgString}, color = {255,255,255}, multiline = true}
        if (settings.isWelcomeMessageGlobal) then
            TriggerClientEvent("chat:addMessage", -1, message)
        else
            TriggerClientEvent("chat:addMessage", source, message)
        end
    end
end)

-- Handle the whitelist whenever a player joins and the whitelist is enabled.
if (settings.enableWhitelist) then
    AddEventHandler("playerConnecting", function(playerName, setKickReason, deferrals)
        local s = source
        deferrals.defer()
        Citizen.Wait(1500) -- wait 1.5 sec before checking due to some weird connection bug that occurs, making IsPayerAceAllowed always return false.
        if (not IsPlayerAceAllowed(s, "vBasic.whitelisted")) then
            deferrals.done(settings.whitelistMessage)
            CancelEvent()
            Citizen.Wait(500)
            print("Connecting: " .. playerName .. " [Connection canceled, not whitelisted]")
        else
            deferrals.done()
            print("Connecting: " .. playerName .. " [Connection allowed, player is whitelisted]")
        end
    end)
end