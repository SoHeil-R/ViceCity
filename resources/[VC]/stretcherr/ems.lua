ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

strNames = { 'v_med_bed1', 'v_med_bed2','prop_ld_binspawnedobj_01'} -- Add more model strings here if you'd like
strHashes = {}
animDict = 'missfbi5ig_0'
animName = 'lyinginpain_loop_steve'
isOnstr = false
spawned = false
spawnedobj = nil
sit = false

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

CreateThread(function()
    for k,v in ipairs(strNames) do
        table.insert( strHashes, GetHashKey(v))
    end
end) 


RegisterCommand('sstr', function() 
        
        if ESX.PlayerData.job.name == "ambulance" then

            if not spawned then
                LoadModel('v_med_bed2')
                local coords = GetEntityCoords(GetPlayerPed(-1))
                local x, y, z = coords.x, coords.y, coords.z
                local formattedCoords = {
                    x = ESX.Math.Round(coords.x, 1),
                    y = ESX.Math.Round(coords.y, 1) + 1,
                    z = ESX.Math.Round(coords.z, 1) - 1
                }
                spawnedobj = CreateObject(GetHashKey('v_med_bed2'), formattedCoords.x, formattedCoords.y, formattedCoords.z, true)
                
                spawned = true
            else
                TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Shoma nemitavanid bishtar az yek brankard dashte bashid!")
            end
            
        else
            TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Shoma medic nistid!")
        end
        
end, false)

RegisterCommand('ro', function(source, args)
    if ESX.PlayerData.job.name == "ambulance" then

        if spawned and spawnedobj ~= nil then

            NetworkFadeOutEntity(spawnedobj, false, false)
            NetworkRegisterEntityAsNetworked(spawnedobj)
            Citizen.Wait(100)           
                                            
            NetworkRequestControlOfEntity(spawnedobj)            

            if not IsEntityAMissionEntity(spawnedobj) then
                SetEntityAsMissionEntity(spawnedobj)        
            end

            Citizen.Wait(400)            
            DeleteEntity(spawnedobj)
            spawnedobj = nil
            spawned = false

        else
            TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Shoma brankardi baraye hazf kardan nadarid!")
        end
    
    else
        TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Shoma medic nistid!")
    end

end, false)

RegisterCommand('ar', function(source, args)
    if ESX.PlayerData.job.name == "ambulance" then

        DeleteOBJ('v_med_bed2')

    else
        TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Shoma medic nistid!")
    end

end, false)

function DeleteOBJ(theobject)
    --[ Deletes The Object ]
    local object = GetHashKey(theobject)
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    if DoesObjectOfTypeExistAtCoords(x, y, z, 2.5, object, true) then
        local obj = GetClosestObjectOfType(x, y, z, 2.5, object, false, false, false)
        NetworkFadeOutEntity(obj, false, false)
        NetworkRegisterEntityAsNetworked(obj)
        Citizen.Wait(100)           
                                        
        NetworkRequestControlOfEntity(obj)            

        if not IsEntityAMissionEntity(obj) then
            SetEntityAsMissionEntity(obj)        
        end

        Citizen.Wait(400)            
        DeleteEntity(obj)
    else
        TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Hich brankardi nazdik shoma nist!")
    end
end

function VehicleInFront()
    local vehicle = ESX.Game.GetVehicleInDirection(4)
    if vehicle ~= 0 then
        local models = {
            1171614426
        }

        if contains(models, GetEntityModel(vehicle)) then
            return vehicle
        else
            TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Shoma faghat brankard ra dakhel ambulance mitavanid begozarid!")
        end

    else
        TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Shoma nazdik hich mashini nistid!")
    end
    
end

function contains(table, val)
    for i = 1, #table do
        if table[i] == val then
            return true
        end
    end
    return false
end

local open = false
RegisterCommand('bdoors', function(source)

    if ESX.PlayerData.job.name == "ambulance" then

        veh = VehicleInFront()
        if open == false then
            open = true
            SetVehicleDoorOpen(veh, 2, false, false)
            Citizen.Wait(1000)
            SetVehicleDoorOpen(veh, 3, false, false)
        elseif open == true then
            open = false
            SetVehicleDoorShut(veh, 2, false)
            SetVehicleDoorShut(veh, 3, false)
        end
        
    else
        TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Shoma medic nistid!")
    end

end, false)

local incar = false
RegisterCommand('pstr', function(source, args)
    
    if ESX.PlayerData.job.name == "ambulance" then

        if incar == false then 
            StreachertoCar()
            incar = true
        elseif incar == true then
            incar = false
            StretcheroutCar()
        end

    else
        TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Shoma medic nistid!")
    end

end, false)

function StreachertoCar()
    
    veh = VehicleInFront()
    ped = GetPlayerPed(-1)
    local pedCoords = GetEntityCoords(ped)
    local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("v_med_bed2"), false)
    if DoesEntityExist(closestObject) then
        if GetVehiclePedIsIn(ped, false) == 0 and DoesEntityExist(veh) and IsEntityAVehicle(veh) then
            AttachEntityToEntity(closestObject, veh, 0.0, 0.0, -3.7, 0.0, 0.0, 0.0, 90.0, false, false, true, false, 2, true)
            FreezeEntityPosition(closestObject, true)
        end
    else
        TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Hich brankardi nazdik shoma nist")
    end
end

function StretcheroutCar()
    veh = VehicleInFront()
    ped = GetPlayerPed(-1)
    local pedCoords = GetEntityCoords(ped)
    local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("v_med_bed2"), false)
    if DoesEntityExist(closestObject) then
        if GetVehiclePedIsIn(playerPed, false) == 0 and DoesEntityExist(veh) and IsEntityAVehicle(veh) then
            DetachEntity(closestObject, true, true)
            FreezeEntityPosition(closestObject, false)
            coords = GetEntityCoords(closestObject, false)
            SetEntityCoords(closestObject, coords.x-3,coords.y,coords.z)
            PlaceObjectOnGroundProperly(closestObject)
        end
    else
        TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Hich brankardi nazdik shoma nist")
    end
end
-----------------------------------------------------------------------------------------------------------------------

RegisterCommand('cstr', function(source, args)
    
    if ESX.PlayerData.job.name == "ambulance" then

        local sleep = 500
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("v_med_bed2"), false)
        if DoesEntityExist(closestObject) then
            sleep = 5
            local wheelChairCoords = GetEntityCoords(closestObject)
            local wheelChairForward = GetEntityForwardVector(closestObject)
            local sitCoords = (wheelChairCoords + wheelChairForward * - 0.5)
            local pickupCoords = (wheelChairCoords + wheelChairForward * 0.3)
            if GetDistanceBetweenCoords(pedCoords, pickupCoords, true) <= 2.0 then
                PickUp(closestObject)
            end
        else
            TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Hich brankardi nazdik shoma nist!")
        end 

    else
        TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Shoma medic nistid!")
    end

end, false)

RegisterCommand('tstr', function(source, args)
    
    if ESX.PlayerData.job.name == "ambulance" then

        if args[1] then
			local target = tonumber(args[1])

			if target then

				if GetPlayerName(GetPlayerFromServerId(target)) ~= "**Invalid**" then

					if GetPlayerName(PlayerId()) == GetPlayerName(GetPlayerFromServerId(target)) then
						TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Shoma nemitavanid khodetan ra roye brankard gharar dahid!")
						return
					end

					local coords = GetEntityCoords(GetPlayerPed(-1))
					local tcoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))

					if GetDistanceBetweenCoords(coords, tcoords, true) < 2 then


						ESX.TriggerServerCallback('esx_cpr:checkdeath', function(IsDead)
							if IsDead then

								TriggerServerEvent('esx_stretcher:putOnStretchers', target)

							else
								TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Shoma nemitavanid player zende ra roye brankard gharar dahid!")
							end
						end, target)

					else
						TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Shoma az player mored nazar khili door hastid!")
					end

				else
					TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Player mored nazar online nist!")
				end

			else
				TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Shoma dar ghesmat ID faghat mitavanid adad vared konid!")
			end

	   else
		TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Shoma dar ghesmat ID chizi vared nakardid!")
	   end 

    else
        TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Shoma medic nistid!")
    end

end, false)

RegisterNetEvent("ARPF-EMS:getintostretcher")
AddEventHandler("ARPF-EMS:getintostretcher", function()

    if not sit then
        local sleep = 500
        local pP = GetPlayerPed(-1)
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("v_med_bed2"), false)
            if DoesEntityExist(closestObject) then
            sleep = 5
            local wheelChairCoords = GetEntityCoords(closestObject)
            local wheelChairForward = GetEntityForwardVector(closestObject)
            local sitCoords = (wheelChairCoords + wheelChairForward * - 0.5)
            local pickupCoords = (wheelChairCoords + wheelChairForward * 0.3)
                if GetDistanceBetweenCoords(pedCoords, sitCoords, true) <= 2.0 then
                    TriggerEvent('sit', closestObject) 
                end
            end
    else
        local sleep = 500
        local pP = GetPlayerPed(-1)
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("v_med_bed2"), false)
            if DoesEntityExist(closestObject) then
            sleep = 5
            local wheelChairCoords = GetEntityCoords(closestObject)
            local wheelChairForward = GetEntityForwardVector(closestObject)
            local sitCoords = (wheelChairCoords + wheelChairForward * - 0.5)
            local pickupCoords = (wheelChairCoords + wheelChairForward * 0.3)
                if GetDistanceBetweenCoords(pedCoords, sitCoords, true) <= 2.0 then
                    TriggerEvent('sit', closestObject) 
                end
            end
        TriggerEvent('unsit', closestObject) 
    end
end)


function revivePed(ped)
  local playerPos = GetEntityCoords(ped, true)

  NetworkResurrectLocalPlayer(playerPos, true, true, false)
  SetPlayerInvincible(ped, false)
  ClearPedBloodDamage(ped)
end

local inBedDicts = "anim@gangops@morgue@table@"
local inBedAnims = "ko_front"
RegisterNetEvent('sit')
AddEventHandler('sit', function(strObject)
    local closestPlayer, closestPlayerDist = GetClosestPlayer()
    local pP = GetPlayerPed(-1)
    if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
        if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), inBedDicts, inBedAnims, 3) then
            ShowNotification("Somebody is already using the wheelchair!")
            return
        end
    end

    LoadAnim(inBedDicts)
  if IsPedDeadOrDying(pP) then
    revivePed(pP)
    AttachEntityToEntity(PlayerPedId(), strObject, 0, 0, 0.0, 2.1, 0.0, 0.0, 220.0, 0.0, false, false, false, false, 2, true)
    local heading = GetEntityHeading(strObject)
    wasdead = true
    sit = true
    while IsEntityAttachedToEntity(PlayerPedId(), strObject) do
        Citizen.Wait(5)

        if IsPedDeadOrDying(PlayerPedId()) then
            DetachEntity(PlayerPedId(), true, true)
        end

        if not IsEntityPlayingAnim(PlayerPedId(), inBedDicts, inBedAnims, 3) then
            TaskPlayAnim(PlayerPedId(), inBedDicts, inBedAnims, 8.0, 8.0, -1, 69, 1, false, false, false)
        end

        -- if IsControlPressed(0, 32) then
        --     PlaceObjectOnGroundProperly(strObject)
        -- end
        -- if IsControlJustPressed(0, 73) then
        --     TriggerEvent("unsit", strObject)
        -- end
    end 
  elseif not IsPedDeadOrDying(pP) then
    AttachEntityToEntity(PlayerPedId(), strObject, 0, 0, 0.0, 2.1, 0.0, 0.0, 270.0, 0.0, false, false, false, false, 2, true)
    local heading = GetEntityHeading(strObject)
    wasdead = false
    while IsEntityAttachedToEntity(PlayerPedId(), strObject) do
        Citizen.Wait(5)

        if IsPedDeadOrDying(PlayerPedId()) then
            DetachEntity(PlayerPedId(), true, true)
        end

        if not IsEntityPlayingAnim(PlayerPedId(), inBedDicts, inBedAnims, 3) then
            TaskPlayAnim(PlayerPedId(), inBedDicts, inBedAnims, 8.0, 8.0, -1, 69, 1, false, false, false)
        end

        -- if IsControlPressed(0, 32) then
        --     PlaceObjectOnGroundProperly(strObject)
        -- end
        -- if IsControlJustPressed(0, 73) then
        --     TriggerEvent("unsit", strObject)
        -- end
    end 
  end      
end)


RegisterNetEvent('unsit')
AddEventHandler('unsit', function(strObject)   
    DetachEntity(PlayerPedId(), true, true)
    local x, y, z = table.unpack(GetEntityCoords(strObject) + GetEntityForwardVector(strObject) * - 0.7)
    SetEntityCoords(PlayerPedId(), x,y,z)
end)

-------------------------------- FUNCTIONS ----------------------------------------------------------------------------

PickUp = function(strObject)
    local closestPlayer, closestPlayerDist = GetClosestPlayer()

    if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
        if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'anim@heists@box_carry@', 'idle', 3) then
            ShowNotification("Somebody is already driving the wheelchair!")
            return
        end
    end

    NetworkRequestControlOfEntity(strObject)

    LoadAnim("anim@heists@box_carry@")

    AttachEntityToEntity(strObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.6, -1.43, 180.0, 170.0, 90.0, 0.0, false, false, true, false, 2, true)
    --AttachEntityToEntity(entity1, entity2, boneIndex, xPos, yPos, zPos, xRot, yRot, zRot, p9, useSoftPinning, collision, isPed, vertexIndex, fixedRot)
    while IsEntityAttachedToEntity(strObject, PlayerPedId()) do
        Citizen.Wait(5)

        if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) then
            TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
        end

        if IsPedDeadOrDying(PlayerPedId()) then
            DetachEntity(strObject, true, true)
        end

        if IsControlJustPressed(0, 73) then
            DetachEntity(strObject, true, true)
        end
    end
end

DrawText3Ds = function(coords, text, scale)
    local x,y,z = coords.x, coords.y, coords.z
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 215)

    AddTextComponentString(text)
    DrawText(_x, _y)

    local factor = (string.len(text)) / 370

    DrawRect(_x, _y + 0.0150, 0.030 + factor, 0.025, 41, 11, 41, 100)
end

GetPlayers = function()
    local players = {}

    for i = 0, 256 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

GetClosestPlayer = function()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
end

LoadAnim = function(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        
        Citizen.Wait(1)
    end
end

LoadModel = function(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        
        Citizen.Wait(1)
    end
end

ShowNotification = function(msg)
    SetNotificationTextEntry('STRING')
    AddTextComponentSubstringWebsite(msg)
    DrawNotification(false, true)
end

