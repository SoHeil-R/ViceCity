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

local voice = {default = 5.0, shout = 15.0, whisper = 2.0, current = 0, level = nil}
local IsLoaded = false
local isGpsOn = false

RegisterNetEvent("esx_voice:changeLoadStatus")
AddEventHandler("esx_voice:changeLoadStatus", function(status)

	IsLoaded = status
	
end)

RegisterNetEvent("esx_voice:changeGpsStatus")
AddEventHandler("esx_voice:changeGpsStatus", function(status)

	isGpsOn = status
	if isGpsOn then
		drawLevel(255, 255, 255, 255, 0.175, 0.892)
	else
		drawLevel(255, 255, 255, 255, 0.175, 0.960)
	end
	
	
end)

function drawLevel(r, g, b, a, x , y)
	SetTextFont(4)
	SetTextScale(0.5, 0.5)
	SetTextColour(r, g, b, a)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()

	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(_U('voice', voice.level))
	EndTextCommandDisplayText(x, y)
end

AddEventHandler('onClientMapStart', function()
	if voice.current == 0 then
		NetworkSetTalkerProximity(voice.default)
	elseif voice.current == 1 then
		NetworkSetTalkerProximity(voice.shout)
	elseif voice.current == 2 then
		NetworkSetTalkerProximity(voice.whisper)
	end
end)

AddEventHandler('playerSpawned', function()
    NetworkSetTalkerProximity(5.0)
end)

Citizen.CreateThread(function()
    RequestAnimDict('facials@gen_male@variations@normal')
    RequestAnimDict('mp_facial')

    while true do
        Citizen.Wait(300)
        local myId = PlayerId()

        for _,player in ipairs(GetActivePlayers()) do
            local boolTalking = NetworkIsPlayerTalking(player)

            if player ~= myId then
                if boolTalking then
                    PlayFacialAnim(GetPlayerPed(player), 'mic_chatter', 'mp_facial')
                elseif not boolTalking then
                    PlayFacialAnim(GetPlayerPed(player), 'mood_normal_1', 'facials@gen_male@variations@normal')
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		if IsControlJustPressed(1, Keys['H']) then
			voice.current = (voice.current + 1) % 3
			if voice.current == 0 then
				NetworkSetTalkerProximity(voice.default)
				voice.level = _U('normal')
			elseif voice.current == 1 then
				NetworkSetTalkerProximity(voice.shout)
				voice.level = _U('shout')
			elseif voice.current == 2 then
				NetworkSetTalkerProximity(voice.whisper)
				voice.level = _U('whisper')
			end
		end

		if voice.current == 0 then
			voice.level = _U('normal')
		elseif voice.current == 1 then
			voice.level = _U('shout')
		elseif voice.current == 2 then
			voice.level = _U('whisper')
		end

		if IsLoaded then

		if isGpsOn then

			if NetworkIsPlayerTalking(PlayerId()) then
				drawLevel(41, 128, 185, 255, 0.175, 0.892)
			elseif not NetworkIsPlayerTalking(PlayerId()) then
				drawLevel(255, 255, 255, 255, 0.175, 0.892)
			end

		else

			if NetworkIsPlayerTalking(PlayerId()) then
				drawLevel(41, 128, 185, 255, 0.175, 0.960)
			elseif not NetworkIsPlayerTalking(PlayerId()) then
				drawLevel(255, 255, 255, 255, 0.175, 0.960)
			end

		end

		end

	end
end)
