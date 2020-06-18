Keys = {
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
local showPlayerBlips = false
local ignorePlayerNameDistance = false
local playerNamesDist = 15
local displayIDHeight = 1.1 --Height of ID above players head(starts at center body mass)
--Set Default Values for Colors
local red = 255
local green = 255
local blue = 255

ESX = nil
isadmin = false
disableForPlayers = false

Citizen.CreateThread(function()

	while ESX == nil do
		TriggerEvent("esx:getSharedObject",function(obj)
				ESX = obj
			end)
			
		Citizen.Wait(0)
		PlayerData = ESX.GetPlayerData()
		
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

RegisterNetEvent('ioh:isAdmin')
AddEventHandler('ioh:isAdmin', function()
	isAdmin = true
end)

function DrawText3D(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(red, green, blue, 255)
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

function ShowNotification(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(msg)
	DrawNotification(0,1)
end

Citizen.CreateThread(function()
	local ShowButtonHold = false
	local time = 0
    while true do
		if IsControlJustPressed(0, Keys['G']) then
			if GetGameTimer() - time > 10000 then
				TriggerServerEvent("proxevent", "Be ID ha Negah Kard.")
				ShowButtonHold = true
				time = GetGameTimer()
			else
				ShowNotification("~r~Lotfan Spam Nakonid!")
			end
		end

		if GetGameTimer() - time > 5000 then
			ShowButtonHold = false
		end

		for i=0,255 do
			N_0x31698aa80e0223f8(i)
		end
		for id = 0, 255 do

			if NetworkIsPlayerActive( id ) and GetPlayerPed( id ) ~= GetPlayerPed( -1 ) then
				ped = GetPlayerPed( id )
				blip = GetBlipFromEntity( ped ) 
	 
				x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
				x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
				distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))

				if distance < playerNamesDist then
					if NetworkIsPlayerTalking(id) then
						red = 0
						green = 255
						blue = 0
						DrawText3D(x2, y2, z2 + displayIDHeight, "[" .. GetPlayerServerId(id) .. "] Talking . . .")

					elseif ShowButtonHold then
						red = 255
						green = 255
						blue = 255
						DrawText3D(x2, y2, z2 + displayIDHeight, "[" .. GetPlayerServerId(id) .. "] | " .. GetPlayerName(id))
					end
				end  
			end
		end
        Citizen.Wait(0)
    end
end)