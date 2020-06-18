local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local AdminPerks = false
local ShowID = false
local muted = false
local first = false
local time = 0
local disPlayerNames = 50
local ForceToVisible = false
local owned = false
local Permission_level = nil
local currentTags = {}
playerDistances = {}
Citizen.CreateThread(function()

		while ESX == nil do
			TriggerEvent("esx:getSharedObject",function(obj)
					ESX = obj
                end)
                
			Citizen.Wait(0)
            PlayerData = ESX.GetPlayerData()

            if first then
                ESX.SetPlayerData('aduty',0)
                first = false
            end
            
        end
        
	end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded",function(xPlayer)

        PlayerData = xPlayer
        
    end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob",function(job)

        PlayerData.job = job
        
	end)

RegisterNetEvent("OnDutyHandler")
AddEventHandler("OnDutyHandler",function(perm)
        AdminPerks = true
        ShowID = true
        Permission_level = perm
        ESX.SetPlayerData('aduty',1)
        adminperks()
        ShowPlayerNames()
        
        TriggerServerEvent('DiscordBot:ToDiscord', 'duty', GetPlayerName(PlayerId()), 'OnDuty shod','user', true, source, false)

end)

RegisterNetEvent("OffDutyHandler")
AddEventHandler("OffDutyHandler",function()
        AdminPerks = false
        ShowID = false
        Permission_level = nil
        ESX.SetPlayerData('aduty',0)
        adminperks()
        ShowPlayerNames()

        TriggerServerEvent('DiscordBot:ToDiscord', 'duty', GetPlayerName(PlayerId()), 'OffDuty shod','user', true, source, false)

end)

RegisterNetEvent("OffDutyHandlerForJail")
AddEventHandler("OffDutyHandlerForJail",function()

    ESX.SetPlayerData('aduty',0)
    TriggerEvent("OffDutyHandler")
	TriggerEvent('esx_basicneeds:healPlayer')
	TriggerEvent('aduty:removeSuggestions')
    TriggerEvent('chat:addMessage', {
        color = { 255, 0, 0},
        multiline = true,
        args = {"[SYSTEM]", "^0Shoma ^1OffDuty ^0Shodid!"}
        })
    TriggerServerEvent('aduty:changeDutyStatus', source)

end)

RegisterNetEvent("resetpedHandler")
AddEventHandler("resetpedHandler",function(skin)

        Citizen.CreateThread(function()
        local model = GetHashKey(skin)
        RequestModel(model)
        while not HasModelLoaded(model) do
            RequestModel(model)
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        SetPedComponentVariation(GetPlayerPed(-1), 0, 0, 0, 2)
    end)

end)

RegisterNetEvent("changepedHandler")
AddEventHandler("changepedHandler",function(skin)

        Citizen.CreateThread(function()
        local model = GetHashKey(skin)
        RequestModel(model)
        while not HasModelLoaded(model) do
            RequestModel(model)
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        SetPedComponentVariation(GetPlayerPed(-1), 0, 0, 0, 2)
    end)

end)

RegisterNetEvent("armorHandler")
AddEventHandler("armorHandler",function(armor)

        local ped = GetPlayerPed(-1)
        SetPedArmour(ped, armor) 

end)

RegisterNetEvent("aduty:vehiclelicenseHandler")
AddEventHandler("aduty:vehiclelicenseHandler",function(licenseplate)

    local player = GetPlayerPed(-1)
    if (IsPedSittingInAnyVehicle(player)) then
        
        local vehicle = GetVehiclePedIsIn(player, true)
        SetVehicleNumberPlateText(vehicle, licenseplate)
        ESX.ShowNotification("~g~Shomare pelak be: ~o~" .. licenseplate .. "~g~ taghir kard")

    else
        ESX.ShowNotification("~r~~h~Shoma baraye estefade az in command bayad dakhel mashin bashid")
    end

end)

RegisterNetEvent("aduty:setMuteStatus")
AddEventHandler("aduty:setMuteStatus", function(status)
  
  muted = status
  MutePlayer()

end)

RegisterNetEvent("aduty:forceStatus")
AddEventHandler("aduty:forceStatus", function(status)
  
  ForceToVisible = status
  print(ForceToVisible)
  visibility()

end)

RegisterNetEvent("aduty:refuel")
AddEventHandler("aduty:refuel", function()
  
   local ped = GetPlayerPed(-1)

   if IsPedInAnyVehicle(ped) then

        local vehicle = GetVehiclePedIsIn(ped)
        SetVehicleFuelLevel(vehicle, 100.0)

   else

      TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Shoma baraye estefade az in command bayad dakhel mashin bashid!")

   end

end)

RegisterNetEvent("aduty:vanish")
AddEventHandler("aduty:vanish", function()
  
   vanish = not vanish
   local ped = GetPlayerPed(-1)

    if vanish then
    TriggerServerEvent('aduty:toggleTag', GetPlayerServerId(PlayerId()), true)
    SetEntityVisible(ped, false, false)
    ESX.ShowNotification("Character shoma ba movafaghiat ~r~Gheyb ~w~shod")
    else
    TriggerServerEvent('aduty:toggleTag', GetPlayerServerId(PlayerId()), true)
    SetEntityVisible(ped, true, false)
    ESX.ShowNotification("Character shoma ba movafaghiat ~g~Zaher ~w~shod")
    end

end)

RegisterNetEvent("aduty:visibleForce")
AddEventHandler("aduty:visibleForce", function()
  
    local ped = GetPlayerPed(-1)
    SetEntityVisible(ped, true, false)

end)

RegisterNetEvent("aduty:changeShowStatus")
AddEventHandler("aduty:changeShowStatus", function()
  
    if ShowID then

        ShowID = false
        ShowPlayerNames()
        TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Shoma halat didan player ha ra ^1Khamosh ^0kardid!")
    
    else
    
        ShowID = true
        ShowPlayerNames()
        TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Shoma halat didan player ha ra ^2Roshan ^0kardid!")

    end

end)

RegisterNetEvent('aduty:tag')
AddEventHandler('aduty:tag',function(own)
    owned = own
end)

RegisterNetEvent('aduty:tagChanger')
AddEventHandler('aduty:tagChanger',function(status)
    owned = status
end)


RegisterNetEvent('aduty:returnStatus')
AddEventHandler('aduty:returnStatus', function()
    TriggerServerEvent('aduty:statusHandler', owned)
end)

RegisterNetEvent('aduty:set_tags')
AddEventHandler('aduty:set_tags', function (admins)
    currentTags = admins
end)

RegisterNetEvent("aduty:deleteVehicle")
AddEventHandler("aduty:deleteVehicle", function()
  
    local playerPed = PlayerPedId()
    local vehicle   = ESX.Game.GetVehicleInDirection(4)
    local entity = vehicle
    carModel = GetEntityModel(entity)
    carName = GetDisplayNameFromVehicleModel(carModel)
    NetworkRequestControlOfEntity(entity)
    
    local timeout = 2000
    while timeout > 0 and not NetworkHasControlOfEntity(entity) do
        Wait(100)
        timeout = timeout - 100
    end

    SetEntityAsMissionEntity(entity, true, true)
    
    local timeout = 2000
    while timeout > 0 and not IsEntityAMissionEntity(entity) do
        Wait(100)
        timeout = timeout - 100
    end

    if IsVehicleSeatFree(entity, -1) then
        if DoesEntityExist(entity) then
            TriggerEvent('chat:addMessage', {
                color = { 255, 0, 0},
                multiline = true,
                args = {"[SYSTEM]", "^2 " .. carName .. "^0 ba movafaghiat hazf shod!"}
            })
        end
        
        Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
        
        if (DoesEntityExist(entity)) then 
            DeleteEntity(entity)
        end
    else
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[SYSTEM]", "^2 " .. carName .. "^0 dar hale hazer yek ranande dare"}
        })
    end

end)

RegisterCommand('flip', function(source)
    ESX.TriggerServerCallback('esx_aduty:checkAdmin', function(isAdmin)

        if isAdmin then

            if ESX.GetPlayerData()['aduty'] == 1 then

                local ped = GetPlayerPed(-1)
                if IsPedSittingInAnyVehicle(ped) then
                    local vehicle = GetVehiclePedIsIn(ped, false)
                    SetVehicleOnGroundProperly(vehicle)
                else
                    local vehicle = ESX.Game.GetVehicleInDirection(4)
                    if vehicle ~= 0 then
                        NetworkRequestControlOfEntity(vehicle)
                        SetVehicleOnGroundProperly(vehicle)
                    else
                        TriggerEvent('chat:addMessage', {color = { 255, 0, 0}, multiline = true ,args = {"[SYSTEM]", "^0Hich mashini nazdik shoma nist!"}})
                    end
                end
                
            else

            TriggerEvent('chat:addMessage', {color = { 255, 0, 0}, multiline = true ,args = {"[SYSTEM]", "^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!"}})

            end

        else

            TriggerEvent('chat:addMessage', {color = { 255, 0, 0}, multiline = true ,args = {"[SYSTEM]", "^0Shoma admin nistid!"}})

        end

        end)
end, false)

function adminperks()

    Citizen.CreateThread( function()
        while true do
            Citizen.Wait(250)
            
            if AdminPerks then
                ResetPlayerStamina(PlayerId())
                SetEntityInvincible(GetPlayerPed(-1), true)
                SetPlayerInvincible(PlayerId(), true)
                SetPedCanRagdoll(GetPlayerPed(-1), false)
                ClearPedBloodDamage(GetPlayerPed(-1))
                ResetPedVisibleDamage(GetPlayerPed(-1))
                ClearPedLastWeaponDamage(GetPlayerPed(-1))
                SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
                SetEntityCanBeDamaged(GetPlayerPed(-1), false)
            else
                SetEntityInvincible(GetPlayerPed(-1), false)
                SetPlayerInvincible(PlayerId(), false)
                SetPedCanRagdoll(GetPlayerPed(-1), true)
                ClearPedLastWeaponDamage(GetPlayerPed(-1))
                SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
                SetEntityCanBeDamaged(GetPlayerPed(-1), true)
            end

        end
        
    end)

end

function visibility()

    Citizen.CreateThread( function()
        while true do
            Citizen.Wait(0)
            
            if ForceToVisible then
                SetEntityVisible(GetPlayerPed(-1), true, false)
            end

        end
        
    end)

end

Citizen.CreateThread(function()

	while true do
        Wait(1)
            
            if (IsControlPressed(1, 21) and IsControlPressed(1, 38)) then
                
                if time == 0 then

                    time = 3

                    ESX.TriggerServerCallback('esx_aduty:checkAdmin', function(isAdmin)

                        if isAdmin then

                            if ESX.GetPlayerData()['aduty'] == 1 then

                                local playerPed = GetPlayerPed(-1)
                                local WaypointHandle = GetFirstBlipInfoId(8)
                                if DoesBlipExist(WaypointHandle) then
                                    local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, WaypointHandle, Citizen.ResultAsVector())
                                    SetEntityCoordsNoOffset(playerPed, coord.x, coord.y, -199.5, false, false, false, true)
                                    ESX.ShowNotification("Shoma be marker roye map teleport shodid!")
                                else
                                    ESX.ShowNotification("Markeri baraye teleport shodan vojoud nadarad!")
                                end

                            else

                                TriggerEvent('chat:addMessage', {
                                    color = { 255, 0, 0},
                                    multiline = true,
                                    args = {"[SYSTEM]", "^0Shoma nemitavanid dar halat ^1OffDuty ^0be marker roye map teleport konid!"}
                                })

                            end

                            end

                        end)

             end


        end
        
        while time > 0 do

            Citizen.Wait(1000)

            time = time -1
            
        end
       
		
    end

end)
    


RegisterNetEvent("aduty:addSuggestions")
AddEventHandler("aduty:addSuggestions",function()

        TriggerEvent('chat:addSuggestion', '/aduty', 'Jahat on/off duty shodan admini', {
        })

        TriggerEvent('chat:addSuggestion', '/changeped', 'Jahat avaz kardan ped', {
            { name="EsmPed", help="Esm ped mored nazar" }
        })

        TriggerEvent('chat:addSuggestion', '/resetped', 'Jahat reset kardan ped be halat admini', {
        })

        TriggerEvent('chat:addSuggestion', '/w', 'Jahat ferestadan whisper admini', {
            { name="Peygham", help="Peygham mored nazar" }
        })

        TriggerEvent('chat:addSuggestion', '/setarmor', 'Jahat avaz kardan armor player', {
            { name="ID", help="ID player mored nazar" },
            { name="Armor", help="Meghdar armor beyn 0-100" }
        })

        TriggerEvent('chat:addSuggestion', '/fineoffline', 'Jarime kardan player be sorat offline', {
            { name="Esm", help="Esm daghigh player ba horof bozorg va kochik" },
            { name="Meghdar", help="Meghdar jarime" },
            { name="Dalil", help="Dalil jarime" }
        })

        TriggerEvent('chat:addSuggestion', '/fine', 'Jarime kardan player be sorat online', {
            { name="ID", help="ID player mored nazar" },
            { name="Meghdar", help="Meghdar jarime" },
            { name="Dalil", help="Dalil jarime" }
        })

        TriggerEvent('chat:addSuggestion', '/ajailoffline', 'Admin jail kardan player be sorat offline', {
            { name="Esm", help="Esm daghigh player ba horof bozorg va kochik" },
            { name="Zaman", help="Zaman admin jail be daghighe" },
            { name="Dalil", help="Dalil admin jail" }
        })

        TriggerEvent('chat:addSuggestion', '/ajail', 'Admin jail kardan player be sorat online', {
            { name="ID", help="ID player mored nazar" },
            { name="Zaman", help="Zaman admin jail be daghighe" },
            { name="Dalil", help="Dalil admin jail" }
        })

        TriggerEvent('chat:addSuggestion', '/aunjail', 'Admin unjail kardan player be sorat online', {
            { name="ID", help="ID player mored nazar" }
        })

        TriggerEvent('chat:addSuggestion', '/money', 'Taghir dadan pol player', {
            { name="ID", help="ID player mored nazar" },
            { name="NoePool", help="Noe pool ebarat ast az cash/bank/black" },
            { name="Meghdar", help="Meghdar pool mored nazar" }
        })

        TriggerEvent('chat:addSuggestion', '/plate', 'Avaz kardan shomare pelak mashin', {
            { name="Pelak", help="Pelak mored nazar" }
        })

        TriggerEvent('chat:addSuggestion', '/a', 'Ferestadan adminchat', {
            { name="Peygham", help="Peygham mored nazar" }
        })

        TriggerEvent('chat:addSuggestion', '/kick', 'Kick kardan player', {
            { name="ID", help="ID player mored nazar" },
            { name="Dalil", help="Dalil kick shodan" }
        })

        TriggerEvent('chat:addSuggestion', '/mute', 'Jahat mute kardan player', {
            { name="ID", help="ID player mored nazar" },
            { name="Dalil", help="Dalil mute shodan player" }
        })

        TriggerEvent('chat:addSuggestion', '/unmute', 'Jahat unmute kardan player', {
            { name="ID", help="ID player mored nazar" }
        })

        TriggerEvent('chat:addSuggestion', '/toggleid', 'Jahat toggle kardan halat didan ID playerha', {
        })

        TriggerEvent('chat:addSuggestion', '/resetaccount', 'Jahat reset kardan account player', {
            { name="ESM", help="Esm player mored nazar" },
            { name="Dalil", help="Dalil reset kardan account" }
        })

        TriggerEvent('chat:addSuggestion', '/disband', 'Jahat disband kardan family', {
            { name="ESM", help="Esm family mored nazar" },
            { name="Dalil", help="Dalil disband kardan gang" }
        })

        TriggerEvent('chat:addSuggestion', '/skinreload', 'Reload player skin', {
            { name="Player", help="ID yek player ya reload hame ba 'all'" },
        })

        TriggerEvent('chat:addSuggestion', '/charmenu', 'Reload player skin', {
            { name="Player", help="Player ID" },
        })

        TriggerEvent('chat:addSuggestion', '/vanish', 'baraye avaz kardan vaziat dide shodan', {
        })

        TriggerEvent('chat:addSuggestion', '/dv2', 'delete kardan mashin haye delete nashodani', {
        })

        TriggerEvent('chat:addSuggestion', '/atoggle', 'toggle kardan tag admini baraye hame', {
        })

        TriggerEvent('chat:addSuggestion', '/owntoggle', 'toggle kardan tag admini baraye khod', {
        })

        TriggerEvent('chat:addSuggestion', '/creategang', 'Sakhtan Gang, Hasas be Horofe bozorg va Kochak', {
            { name="GangName", help="Esme Gang" },
            { name="Expire", help="Tedad Roz etebare Gang ra Vared konid" },
        })

        TriggerEvent('chat:addSuggestion', '/savegangs', 'Zakhire Kardane Gang\'e Sakhte Shode', {})

        TriggerEvent('chat:addSuggestion', '/changegangdata', 'Taqir Dadane Makane Option haye Gang', {
            { name="GangName", help="Esme Gang" },
            { name="option", help="Entekhabe option:(blip, armory, locker, boss, veh, vehdel, vehspawn, expire)" },
        })
end)

RegisterNetEvent("aduty:removeSuggestions")
AddEventHandler("aduty:removeSuggestions",function()

        TriggerEvent('chat:removeSuggestion', '/aduty')

        TriggerEvent('chat:removeSuggestion', '/changeped')

        TriggerEvent('chat:removeSuggestion', '/resetped')

        TriggerEvent('chat:removeSuggestion', '/w')

        TriggerEvent('chat:removeSuggestion', '/setarmor')

        TriggerEvent('chat:removeSuggestion', '/fineoffline')

        TriggerEvent('chat:removeSuggestion', '/fine')

        TriggerEvent('chat:removeSuggestion', '/ajailoffline')

        TriggerEvent('chat:removeSuggestion', '/ajail')

        TriggerEvent('chat:removeSuggestion', '/aunjail')

        TriggerEvent('chat:removeSuggestion', '/money')

        TriggerEvent('chat:removeSuggestion', '/plate')

        TriggerEvent('chat:removeSuggestion', '/a')

        TriggerEvent('chat:removeSuggestion', '/kick')

        TriggerEvent('chat:removeSuggestion', '/mute')

        TriggerEvent('chat:removeSuggestion', '/unmute')

        TriggerEvent('chat:removeSuggestion', '/toggleid')

        TriggerEvent('chat:removeSuggestion', '/resetaccount')

        TriggerEvent('chat:removeSuggestion', '/disband')

        TriggerEvent('chat:removeSuggestion', '/vanish')

        TriggerEvent('chat:removeSuggestion', '/dv2')

        TriggerEvent('chat:removeSuggestion', '/charmenu')

        TriggerEvent('chat:removeSuggestion', '/savegangs')

        TriggerEvent('chat:removeSuggestion', '/creategang')

        TriggerEvent('chat:removeSuggestion', '/changegangdata')

        TriggerEvent('chat:removeSuggestion', '/atoggle')

        TriggerEvent('chat:removeSuggestion', '/owntoggle')

end)

function MutePlayer()

    Citizen.CreateThread(function()

		while muted do

			DisableControlAction(0, Keys['N'], true)

            Citizen.Wait(0)
            
		end

	end)

end

function ShowPlayerNames()
    
    Citizen.CreateThread(function()
        Wait(50)
        while true do
            if ShowID then


                    for id = 0, 255 do 
                        if NetworkIsPlayerActive(id) then
                            if GetPlayerPed(id) ~= GetPlayerPed(-1) then
                                if (playerDistances[id] < disPlayerNames) then
                                    x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
                                        DrawText3D(x2, y2, z2+1, GetPlayerServerId(id) .. " | " .. GetPlayerName(id), 255,255,255)
                                end  
                            end
                        end
                    end

            end
            Citizen.Wait(0)
        end
    end)


    Citizen.CreateThread(function()
        while true do
            if ShowID then

                for id = 0, 255 do
                    if GetPlayerPed(id) ~= GetPlayerPed(-1) then
                        x1, y1, z1 = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
                        x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
                        distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
                        playerDistances[id] = distance
                    end
                end

            end
            Citizen.Wait(1000)
        end
      end)

    end
function CheckPermission(Permission)
    local label
    if Permission == 1 then
        label ="~y~[HELPER] ~w~"
    elseif Permission == 2 then
        label ="~b~[ADMIN] ~w~"
    elseif Permission == 3 then
        label ="~g~[SENIOR ADMIN] ~w~"
    elseif Permission == 4 then
        label ="~o~[HEAD ADMIN] ~w~"
    elseif Permission == 5 then
        label ="~p~[SERVER MANAGEMENT] ~w~"
    elseif Permission == 6 then
        label ="~u~[DEVELOPER] ~w~"
    elseif Permission == 7 then
        label ="~r~[CO OWNER] ~w~"
    elseif Permission >= 8 then
        label ="~r~[OWNER] ~w~"
    end
    return label
end
Citizen.CreateThread(function ()
    while true do
    Citizen.Wait(0)
            local currentPed = PlayerPedId()
            local currentPos = GetEntityCoords(currentPed)
            local cx,cy,cz = table.unpack(currentPos)
            cz = cz + 1.2
            if Permission_level then
                label = CheckPermission(tonumber(Permission_level))
            end
             if owned then
                DrawText3D(cx,cy,cz, label) 
             end
    
            for k, v in pairs(currentTags) do
                local adminPed = GetPlayerPed(GetPlayerFromServerId(v.source))
                local adminCoords = GetEntityCoords(adminPed)
                local x,y,z = table.unpack(adminCoords)
                z = z + 1.2
                local distance = GetDistanceBetweenCoords(vector3(cx,cy,cz), vector3(x,y,z), true)
                if distance < 10 and v.hide == false and GetPlayerServerId(PlayerId()) ~= v.source then
                    DrawText3D(x,y,z, CheckPermission(tonumber(v.permission)) .. GetPlayerName(GetPlayerFromServerId(v.source))) 
                end
            end
    end
end)

function DrawText3D(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.7*scale, 1.2*scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(220, 220, 0, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
	    World3dToScreen2d(x,y,z, 0) --Added Here
        DrawText(_x,_y)
    end
end