ESX = nil
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
AddEventHandler(
	"esx:playerLoaded",
	function(xPlayer)
		PlayerData = xPlayer
	end
)

RegisterNetEvent("esx:setJob")
AddEventHandler(
	"esx:setJob",
	function(job)
		PlayerData.job = job
	end
)

-----------------------
-- Damaged Walk Mode --
-----------------------

local hurt = false
	Citizen.CreateThread(function()
		while true do
			Wait(1000)
			TriggerEvent('skinchanger:getSkin', function(skin)
				--  male
					if skin.sex == 0 then
						if GetEntityHealth(GetPlayerPed(-1)) <= 150 then
							SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
						end
						if GetEntityHealth(GetPlayerPed(-1)) <= 130 then
							setHurt()
						elseif hurt and GetEntityHealth(GetPlayerPed(-1)) > 130 then
							setNotHurt()
						end
				--  female
					elseif skin.sex == 1 then
						if GetEntityHealth(GetPlayerPed(-1)) <= 136 then
							SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
						end
						if GetEntityHealth(GetPlayerPed(-1)) <= 120 then
							setHurt()
						elseif hurt and GetEntityHealth(GetPlayerPed(-1)) > 120 then
							setNotHurt()
						end
					end
				end)
		end
	end)

function setHurt()
    hurt = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", true)
	SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
	DisableControlAction(0, 21) 
	DisableControlAction(0,22)
end

function setNotHurt()
    hurt = false
	SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
    ResetPedMovementClipset(GetPlayerPed(-1))
    ResetPedWeaponMovementClipset(GetPlayerPed(-1))
    ResetPedStrafeClipset(GetPlayerPed(-1))
end
----------------
-- Walk Shake --
----------------

playerMoving = false

Citizen.CreateThread(function()
	while true do Wait(1000)
		if not IsPedInAnyVehicle(PlayerPedId(), false) and GetEntitySpeed(PlayerPedId()) >= 0.5 and GetFollowPedCamViewMode() ~= 4 then
			if playerMoving == false then
				ShakeGameplayCam("ROAD_VIBRATION_SHAKE", 0.25)
				playerMoving = true
			end
		else
			if playerMoving == true then
				StopGameplayCamShaking(false)
				playerMoving = false
			end
		end
	end
end)