ESX = nil
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
local doit = true

Citizen.CreateThread(
	function()
		while ESX == nil do
			TriggerEvent(
				"esx:getSharedObject",
				function(obj)
					ESX = obj
				end
			)
			Citizen.Wait(0)
			PlayerData = ESX.GetPlayerData()
		end
	end
)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded",
	function(xPlayer)
        PlayerData = xPlayer
        Citizen.Wait(10000)
    end)

RegisterNetEvent("esx:setJob")
AddEventHandler(
	"esx:setJob",
	function(job)
		PlayerData.job = job
	end
)

RegisterCommand("jailmenu", function(source, args)

	if PlayerData.job.name == "police" then
		OpenJailMenu()
	else
		ESX.ShowNotification("Shoma police nistid!")
	end
end)

function LoadAnim(animDict)
	RequestAnimDict(animDict)

	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(10)
	end
end

function LoadModel(model)
	RequestModel(model)

	while not HasModelLoaded(model) do
		Citizen.Wait(10)
	end
end

function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(1)
	HideHudComponentThisFrame(2)
	HideHudComponentThisFrame(3)
	HideHudComponentThisFrame(4)
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13)
	HideHudComponentThisFrame(11)
	HideHudComponentThisFrame(12)
	HideHudComponentThisFrame(15)
	HideHudComponentThisFrame(18)
	HideHudComponentThisFrame(19)
end

function Cutscene()

		if ESX.GetPlayerData()['aduty'] == 1 then
			TriggerEvent("OffDutyHandlerForJail", source)
		end
		if ESX.GetPlayerData()['cfix'] == 1 then
			TriggerEvent("resetchar", source)
		end
		Citizen.Wait(1500)
	
		changeClothes()

	doit = true
	DisableKeys()

	DoScreenFadeOut(100)

	Citizen.Wait(250)

	local Male = GetHashKey("mp_m_freemode_01")

	if PlayerData.job.name == "police" then
		TriggerServerEvent("esx-qalle-jail:jobSet", source)
	end
		
		SetPedArmour(PlayerPedId(), 0)
		ClearPedBloodDamage(PlayerPedId())
		ResetPedVisibleDamage(PlayerPedId())
		ClearPedLastWeaponDamage(PlayerPedId())
		RemoveAllPedWeapons(PlayerPedId(), true)

	LoadModel(-1320879687)

	local PolicePosition = Config.Cutscene["PolicePosition"]
	local Police = CreatePed(5, -1320879687, PolicePosition["x"], PolicePosition["y"], PolicePosition["z"], PolicePosition["h"], false)
	TaskStartScenarioInPlace(Police, "WORLD_HUMAN_PAPARAZZI", 0, false)

	local PlayerPosition = Config.Cutscene["PhotoPosition"]
	SetEntityCoords(PlayerPedId(), PlayerPosition["x"], PlayerPosition["y"], PlayerPosition["z"] - 1)
	SetEntityHeading(PlayerPedId(), PlayerPosition["h"])
	FreezeEntityPosition(PlayerPedId(), true)

	Cam()

	Citizen.Wait(1000)

	DoScreenFadeIn(100)

	Citizen.Wait(10000)

	DoScreenFadeOut(250)

	local JailPosition = Config.JailPositions["Cell"]
	SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"])
	DeleteEntity(Police)
	SetModelAsNoLongerNeeded(-1320879687)

	Citizen.Wait(1000)

	DoScreenFadeIn(250)

	TriggerServerEvent("InteractSound_SV:PlayOnSource", "cell", 0.3)

	RenderScriptCams(false,  false,  0,  true,  true)
	FreezeEntityPosition(PlayerPedId(), false)
	DestroyCam(Config.Cutscene["CameraPos"]["cameraId"])

	doit = false
	InJail(nil, true)
end

function Cam()
	local CamOptions = Config.Cutscene["CameraPos"]

	CamOptions["cameraId"] = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

    SetCamCoord(CamOptions["cameraId"], CamOptions["x"], CamOptions["y"], CamOptions["z"])
	SetCamRot(CamOptions["cameraId"], CamOptions["rotationX"], CamOptions["rotationY"], CamOptions["rotationZ"])

	RenderScriptCams(true, false, 0, true, true)
end

function DisableKeys()

	Citizen.CreateThread(function()
		while doit do

			DisableControlAction(0, Keys['F1'],true)
			DisableControlAction(0, Keys['F3'],true)
			DisableControlAction(0, Keys['F5'],true)
			DisableControlAction(0, Keys['R'], true)
			DisableControlAction(0, Keys[','], true)
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Right click
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
            DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 27, true) -- Arrow up
			DisableAllControlActions(0)

			Citizen.Wait(0)
		end

	end)
	
end

function changeClothes()
	TriggerEvent('skinchanger:getSkin', function(skin)
		--  male
			   if skin.sex == 0 then
				 local clothesSkin = {
				 ['tshirt_1'] = 15, ['tshirt_2'] = 0,
				 ['bproof_1'] = 0,  ['bproof_2'] = 0,
				 ['mask_1'] = 0,   ['mask_2'] = 0,
				 ['helmet_1'] = -1,  ['helmet_2'] = 0,
				 ['bags_1'] = -1,  ['bags_2'] = 0,
				 ['decals_1'] = 0,   ['decals_2'] = 0,
				 ['chain_1'] = 0,    ['chain_2'] = 0,
				 ['torso_1'] = 5, ['torso_2'] = 0,
				 ['arms'] = 5,
				 ['pants_1'] = 9, ['pants_2'] = 4,
				 ['shoes_1'] = 42, ['shoes_2'] = 2,
				 }
				 TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		--  female
			   elseif skin.sex == 1 then
				 local clothesSkin = {
				 ['tshirt_1'] = 15, ['tshirt_2'] = 0,
				 ['bproof_1'] = 0,  ['bproof_2'] = 0,
				 ['mask_1'] = 0,   ['mask_2'] = 0,
				 ['helmet_1'] = -1,  ['helmet_2'] = 0,
				 ['bags_1'] = -1,  ['bags_2'] = 0,
				 ['decals_1'] = 0,   ['decals_2'] = 0,
				 ['chain_1'] = 0,    ['chain_2'] = 0,
				 ['torso_1'] = 4, ['torso_2'] = 12,
				 ['arms'] = 4,
				 ['pants_1'] = 5, ['pants_2'] = 15,
				 ['shoes_1'] = 81, ['shoes_2'] = 23,
				 }
				 TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			 end
		end)
end

function TeleportPlayer(pos)

	local Values = pos

	if #Values["goal"] > 1 then

		local elements = {}

		for i, v in pairs(Values["goal"]) do
			table.insert(elements, { label = v, value = v })
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'teleport_jail',
			{
				title    = "Choose Position",
				align    = 'center',
				elements = elements
			},
		function(data, menu)

			local action = data.current.value
			local position = Config.Teleports[action]

			if action == "Security" then

				if PlayerData.job.name ~= "police" then
					ESX.ShowNotification("Kilid nadarid!")
					return
				end
			end

			menu.close()

			DoScreenFadeOut(100)

			Citizen.Wait(250)

			SetEntityCoords(PlayerPedId(), position["x"], position["y"], position["z"])

			Citizen.Wait(250)

			DoScreenFadeIn(100)
			
		end,

		function(data, menu)
			menu.close()
		end)
	else
		local position = Config.Teleports[Values["goal"][1]]

		DoScreenFadeOut(100)

		Citizen.Wait(250)

		SetEntityCoords(PlayerPedId(), position["x"], position["y"], position["z"])

		Citizen.Wait(250)

		DoScreenFadeIn(100)
	end
end

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Teleports["Boiling Broke"]["x"], Config.Teleports["Boiling Broke"]["y"], Config.Teleports["Boiling Broke"]["z"])

    SetBlipSprite (blip, 188)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.8)
    SetBlipColour (blip, 49)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Boilingbroke Penitentiary')
    EndTextCommandSetBlipName(blip)
end)