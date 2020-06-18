-- C O N F I G --
interactionDistance = 3.5 --The radius you have to be in to interact with the vehicle.
lockDistance = 25 --The radius you have to be in to lock your vehicle.
local timer = 0
-- E S X --
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
--  V A R I A B L E S --
engineoff = false
saved = false
controlsave_bool = false
-- E N G I N E --
IsEngineOn = true
RegisterNetEvent("engine")
AddEventHandler(
	"engine",
	function()
		local player = GetPlayerPed(-1)

		if (IsPedSittingInAnyVehicle(player)) then
			local vehicle = GetVehiclePedIsIn(player, false)
			if GetPedInVehicleSeat(vehicle, -1) == player then
				if IsEngineOn == true then
					IsEngineOn = false
					SetVehicleEngineOn(vehicle, false, false, false)
					if GetGameTimer() - 2000  > timer then
						ESX.TriggerServerCallback('3dme:getIcName', function(PlayerName)

							if PlayerName ~= nil then
					
								local text = '* ' .. PlayerName .. ' motore vasile naghlie ro khamosh mikone *'
		
		
								TriggerServerEvent('3dme:shareDisplay', text, false)
					
							end
					
						end)
						timer = GetGameTimer()
					end
					
				else
					IsEngineOn = true
					SetVehicleUndriveable(vehicle, false)
					SetVehicleEngineOn(vehicle, true, false, false)
					if GetGameTimer() - 2000  > timer then
						ESX.TriggerServerCallback('3dme:getIcName', function(PlayerName)

							if PlayerName ~= nil then
					
								local text = '* ' .. PlayerName .. ' motore vasile naghlie ro roshan mikone *'
		
		
								TriggerServerEvent('3dme:shareDisplay', text, false)
					
							end
					
						end)
						timer = GetGameTimer()
					end
				end
			end

			while (IsEngineOn == false) do
				SetVehicleUndriveable(vehicle, true)
				Citizen.Wait(0)
			end
		end
	end
)

RegisterNetEvent("engineoff")
AddEventHandler(
	"engineoff",
	function()
		local player = GetPlayerPed(-1)

		if (IsPedSittingInAnyVehicle(player)) then
			local vehicle = GetVehiclePedIsIn(player, false)
			engineoff = true
			ShowNotification("Engine ~r~off~s~.")
			while (engineoff) do
				SetVehicleEngineOn(vehicle, false, false, false)
				SetVehicleUndriveable(vehicle, true)
				Citizen.Wait(0)
			end
		end
	end
)
RegisterNetEvent("engineon")
AddEventHandler(
	"engineon",
	function()
		local player = GetPlayerPed(-1)

		if (IsPedSittingInAnyVehicle(player)) then
			local vehicle = GetVehiclePedIsIn(player, false)
			engineoff = false
			SetVehicleUndriveable(vehicle, false)
			SetVehicleEngineOn(vehicle, true, false, false)
			ShowNotification("Engine ~g~on~s~.")
		end
	end
)
-- T R U N K --
RegisterNetEvent("trunk")
AddEventHandler(
	"trunk",
	function()
		local player = GetPlayerPed(-1)
		if controlsave_bool == true then
			vehicle = saveVehicle
		else
			vehicle = GetVehiclePedIsIn(player, true)
		end

		local isopen = GetVehicleDoorAngleRatio(vehicle, 5)
		local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)

		if distanceToVeh <= interactionDistance then
			if (isopen == 0) then
				SetVehicleDoorOpen(vehicle, 5, 0, 0)
			else
				SetVehicleDoorShut(vehicle, 5, 0)
			end
		else
			ShowNotification("~r~You must be near your vehicle to do that.")
		end
	end
)
-- Left Front Door --
RegisterNetEvent("lfdoor")
AddEventHandler(
	"lfdoor",
	function()
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
			local frontLeftDoor = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "door_dside_f")
			if frontLeftDoor ~= -1 then
				if GetVehicleDoorAngleRatio(vehicle, 0) > 0.0 then
					SetVehicleDoorShut(vehicle, 0, false)
				else
					SetVehicleDoorOpen(vehicle, 0, false)
				end
			else
				ESX.ShowNotification("This vehicle does not have a front driver-side door.")
			end
		else
			ESX.ShowNotification("You must be the driver of a vehicle to use this.")
		end
	end
)

-- Right Front Door --
RegisterNetEvent("rfdoor")
AddEventHandler(
	"rfdoor",
	function()
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
			local frontRightDoor = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "door_pside_f")
			if frontRightDoor ~= -1 then
				if GetVehicleDoorAngleRatio(vehicle, 1) > 0.0 then
					SetVehicleDoorShut(vehicle, 1, false)
				else
					SetVehicleDoorOpen(vehicle, 1, false)
				end
			else
				ESX.ShowNotification("This vehicle does not have a front passenger-side door.")
			end
		else
			ESX.ShowNotification("You must be the driver of a vehicle to use this.")
		end
	end
)

-- Left Rear Door --
RegisterNetEvent("lrdoor")
AddEventHandler(
	"lrdoor",
	function()
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
			local rearLeftDoor = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "door_dside_r")
			if rearLeftDoor ~= -1 then
				if GetVehicleDoorAngleRatio(vehicle, 2) > 0.0 then
					SetVehicleDoorShut(vehicle, 2, false)
				else
					SetVehicleDoorOpen(vehicle, 2, false)
				end
			else
				ESX.ShowNotification("This vehicle does not have a rear driver-side door.")
			end
		else
			ESX.ShowNotification("You must be the driver of a vehicle to use this.")
		end
	end
)

-- Left Rear Door --
RegisterNetEvent("rrdoor")
AddEventHandler(
	"rrdoor",
	function()
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
			local rearRightDoor = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "door_pside_r")
			if rearRightDoor ~= -1 then
				if GetVehicleDoorAngleRatio(vehicle, 3) > 0.0 then
					SetVehicleDoorShut(vehicle, 3, false)
				else
					SetVehicleDoorOpen(vehicle, 3, false)
				end
			else
				ESX.ShowNotification("This vehicle does not have a rear passenger-side door.")
			end
		else
			ESX.ShowNotification("You must be the driver of a vehicle to use this.")
		end
	end
)

-- All Doors --
RegisterNetEvent("alldoors")
AddEventHandler(
	"alldoors",
	function()
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
			if GetVehicleDoorAngleRatio(vehicle, 0) > 0.0 then
				SetVehicleDoorShut(vehicle, 0, false)
				SetVehicleDoorShut(vehicle, 1, false)
				SetVehicleDoorShut(vehicle, 2, false)
				SetVehicleDoorShut(vehicle, 3, false)
				SetVehicleDoorShut(vehicle, 4, false)
				SetVehicleDoorShut(vehicle, 5, false)
			else
				SetVehicleDoorOpen(vehicle, 0, false)
				SetVehicleDoorOpen(vehicle, 1, false)
				SetVehicleDoorOpen(vehicle, 2, false)
				SetVehicleDoorOpen(vehicle, 3, false)
				SetVehicleDoorOpen(vehicle, 4, false)
				SetVehicleDoorOpen(vehicle, 5, false)
			end
		else
			ESX.ShowNotification("You must be the driver of a vehicle to use this.")
		end
	end
)

-- all windows down --
RegisterNetEvent("allwindowsdown")
AddEventHandler(
	"allwindowsdown",
	function()
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
			local frontLeftWindow = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "window_lf")
			local frontRightWindow = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "window_rf")
			local rearLeftWindow = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "window_lr")
			local rearRightWindow = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "window_rr")
			local frontMiddleWindow = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "window_lm")
			local rearMiddleWindow = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "window_rm")
			if
				frontLeftWindow ~= -1 or frontRightWindow ~= -1 or rearLeftWindow ~= -1 or rearRightWindow ~= -1 or
					frontMiddleWindow ~= -1 or
					rearMiddleWindow ~= -1
			 then
				RollDownWindow(vehicle, 0)
				RollDownWindow(vehicle, 1)
				RollDownWindow(vehicle, 2)
				RollDownWindow(vehicle, 3)
				RollDownWindow(vehicle, 4)
				RollDownWindow(vehicle, 5)
			else
				ESX.ShowNotification("This vehicle has no windows.")
			end
		else
			ESX.ShowNotification("You must be the driver of a vehicle to use this.")
		end
	end
)

-- all windows up --
RegisterNetEvent("allwindowsup")
AddEventHandler(
	"allwindowsup",
	function()
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
			local frontLeftWindow = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "window_lf")
			local frontRightWindow = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "window_rf")
			local rearLeftWindow = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "window_lr")
			local rearRightWindow = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "window_rr")
			local frontMiddleWindow = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "window_lm")
			local rearMiddleWindow = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "window_rm")
			if
				frontLeftWindow ~= -1 or frontRightWindow ~= -1 or rearLeftWindow ~= -1 or rearRightWindow ~= -1 or
					frontMiddleWindow ~= -1 or
					rearMiddleWindow ~= -1
			 then
				RollUpWindow(vehicle, 0)
				RollUpWindow(vehicle, 1)
				RollUpWindow(vehicle, 2)
				RollUpWindow(vehicle, 3)
				RollUpWindow(vehicle, 4)
				RollUpWindow(vehicle, 5)
			else
				ESX.ShowNotification("This vehicle has no windows.")
			end
		else
			ESX.ShowNotification("You must be the driver of a vehicle to use this.")
		end
	end
)

-- H O O D --
RegisterNetEvent("hood")
AddEventHandler(
	"hood",
	function()
		local player = GetPlayerPed(-1)
		if controlsave_bool == true then
			vehicle = saveVehicle
		else
			vehicle = GetVehiclePedIsIn(player, true)
		end

		local isopen = GetVehicleDoorAngleRatio(vehicle, 4)
		local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)

		if distanceToVeh <= interactionDistance then
			if (isopen == 0) then
				SetVehicleDoorOpen(vehicle, 4, 0, 0)
			else
				SetVehicleDoorShut(vehicle, 4, 0)
			end
		else
			ShowNotification("~r~You must be near your vehicle to do that.")
		end
	end
)
-- L O C K --
RegisterNetEvent("lockLights")
AddEventHandler("lockLights", function(vehicle)
		local vehicle = vehicle
		SetVehicleLights(vehicle, 2)
		Citizen.Wait(150)
		SetVehicleLights(vehicle, 0)
		Citizen.Wait(150)
		SetVehicleLights(vehicle, 2)
		Citizen.Wait(150)
		SetVehicleLights(vehicle, 0)
	end)

RegisterNetEvent("lock")
AddEventHandler("lock",function()

	local vehicle = {}
	local name = nil
	if PlayerData.job.name == "police" then
		
			vehicles = {
				1912215274,
				-2007026063,
				2046537925,
				-1627000575,
				456714581,
				-1323100960,
				2071877360,
				831758577,
				699188170,
				1341474454,
				-1674384553,
				-1973172295,
				1127131465,
				-1647941228,
				-34623805,
				-1683328900,
				1922257928,
				-305727417,
				-304857564,
				-1176401295,
				1624609239,
				-1661555510,
				1663218586,
				353883353,
				-982610657,
				-1083357304,
				1496279100,
				-1959382956,
				-834607087,
				-1631996672,
				653331214,
				38057582
			}
			name = "police"

	elseif PlayerData.job.name == "ambulance" then

		vehicles = {
			1171614426,
			469291905,
			-1647941228,
			353883353
		}
		name = "ambulance"
	elseif PlayerData.job.name == "mechanic" then

		vehicles = {
			-1349095620,
			-1323100960,
			2132890591
		}
		name = "mechanic"

	elseif PlayerData.job.name == "taxi" then

		vehicles = {
			-956048545,
			1123216662,
			-1961627517
		}
		name = "taxi"
		
	else

		ESX.ShowNotification("~r~Shoma ozv hich organ dolati nistid")
		return

	end

		if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then

			local player = GetPlayerPed(-1)
			local vehicle = GetVehiclePedIsUsing(player)
			local islocked = GetVehicleDoorLockStatus(vehicle)
			if DoesEntityExist(vehicle) then
				

				local function contains(table, val)
					for i = 1, #table do
						if table[i] == val then
							return true
						end
					end
					return false
				end
				if contains(vehicles, GetEntityModel(vehicle)) then
				
						if (islocked == 1 or islocked == 0) then
							SetVehicleDoorsLocked(vehicle, 2)
							ShowNotification(
								"Shoma ~y~" ..
									GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) .. "~w~ ra ~r~ghofl ~w~kardid."
							)
							TriggerEvent("lockLights", vehicle)
							local dict = "anim@mp_player_intmenu@key_fob@"
							RequestAnimDict(dict)
							while not HasAnimDictLoaded(dict) do
								Citizen.Wait(0)
							end
							if not IsPedInAnyVehicle(PlayerPedId(), true) then
								TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
							end
							SetVehicleDoorShut(vehicle, 0, false)
							SetVehicleDoorShut(vehicle, 1, false)
							SetVehicleDoorShut(vehicle, 2, false)
							SetVehicleDoorShut(vehicle, 3, false)
							SetVehicleDoorShut(vehicle, 4, false)
							SetVehicleDoorShut(vehicle, 5, false)
							PlayVehicleDoorCloseSound(vehicle, 1)
							TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "lock", 0.5)
							ESX.TriggerServerCallback('3dme:getIcName', function(PlayerName)

								if PlayerName ~= nil then
						
									local text = '* ' .. PlayerName .. ' vasile naghlie ro ghofl mikone *'

	
									TriggerServerEvent('3dme:shareDisplay', text, false)
						
								end
						
							end)
							

						elseif islocked == 2 then
							SetVehicleDoorsLocked(vehicle, 1)
							ShowNotification(
								"Shoma ~y~" ..
									GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) .. "~w~ ra ~g~baaz ~w~kardid."
							)
							TriggerEvent("lockLights", vehicle)
							local dict = "anim@mp_player_intmenu@key_fob@"
							RequestAnimDict(dict)
							while not HasAnimDictLoaded(dict) do
								Citizen.Wait(0)
							end
							if not IsPedInAnyVehicle(PlayerPedId(), true) then
								TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
							end
							PlayVehicleDoorCloseSound(vehicle, 1)
							TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "unlock", 0.5)
							ESX.TriggerServerCallback('3dme:getIcName', function(PlayerName)

								if PlayerName ~= nil then
						
									local text = '* ' .. PlayerName .. ' vasile naghlie ro baz mikone *'

	
									TriggerServerEvent('3dme:shareDisplay', text, false)
						
								end
						
							end)

						end
			
				else
					ShowNotification("~r~~h~In yek mashin " .. name .. " nist")
				end
			else
				ShowNotification("~r~~h~Hich mashini nazdik shoma nist.")
			end

			

		else

			local player = GetPlayerPed(-1)
			local vehicle = ESX.Game.GetVehicleInDirection(4)
			local islocked = GetVehicleDoorLockStatus(vehicle)
			local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
			if DoesEntityExist(vehicle) then
				

				local function contains(table, val)
					for i = 1, #table do
						if table[i] == val then
							return true
						end
					end
					return false
				end
				if contains(vehicles, GetEntityModel(vehicle)) then
				
						if (islocked == 1 or islocked == 0) then
							SetVehicleDoorsLocked(vehicle, 2)
							ShowNotification(
								"Shoma ~y~" ..
									GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) .. "~w~ ra ~r~ghofl ~w~kardid."
							)
							TriggerEvent("lockLights", vehicle)
							local dict = "anim@mp_player_intmenu@key_fob@"
							RequestAnimDict(dict)
							while not HasAnimDictLoaded(dict) do
								Citizen.Wait(0)
							end
							if not IsPedInAnyVehicle(PlayerPedId(), true) then
								TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
							end
							SetVehicleDoorShut(vehicle, 0, false)
							SetVehicleDoorShut(vehicle, 1, false)
							SetVehicleDoorShut(vehicle, 2, false)
							SetVehicleDoorShut(vehicle, 3, false)
							SetVehicleDoorShut(vehicle, 4, false)
							SetVehicleDoorShut(vehicle, 5, false)
							PlayVehicleDoorCloseSound(vehicle, 1)
							TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "lock", 0.5)
							ESX.TriggerServerCallback('3dme:getIcName', function(PlayerName)

								if PlayerName ~= nil then
						
									local text = '* ' .. PlayerName .. ' vasile naghlie ro ghofl mikone *'

	
									TriggerServerEvent('3dme:shareDisplay', text, false)
						
								end
						
							end)

						elseif islocked == 2 then
							SetVehicleDoorsLocked(vehicle, 1)
							ShowNotification(
								"Shoma ~y~" ..
									GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) .. "~w~ ra ~g~baaz ~w~kardid."
							)
							TriggerEvent("lockLights", vehicle)
							local dict = "anim@mp_player_intmenu@key_fob@"
							RequestAnimDict(dict)
							while not HasAnimDictLoaded(dict) do
								Citizen.Wait(0)
							end
							if not IsPedInAnyVehicle(PlayerPedId(), true) then
								TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
							end
							PlayVehicleDoorCloseSound(vehicle, 1)
							TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "unlock", 0.5)
							ESX.TriggerServerCallback('3dme:getIcName', function(PlayerName)

								if PlayerName ~= nil then
						
									local text = '* ' .. PlayerName .. ' vasile naghlie ro baz mikone *'

	
									TriggerServerEvent('3dme:shareDisplay', text, false)
						
								end
						
							end)

						end
			
				else
					ShowNotification("~r~~h~In yek mashin " .. name .. " nist")
				end
			else
				
				local player = GetPlayerPed(-1)
				local vehicle = saveVehicle
				local islocked = GetVehicleDoorLockStatus(vehicle)
				local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
				if DoesEntityExist(vehicle) then
						if distanceToVeh <= lockDistance then
							if (islocked == 1 or islocked == 0) then
								SetVehicleDoorsLocked(vehicle, 2)
								ShowNotification(
									"Shoma ~y~" ..
										GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) .. "~w~ ra ~r~ghofl ~w~kardid."
								)
								TriggerEvent("lockLights", vehicle)
								local dict = "anim@mp_player_intmenu@key_fob@"
							RequestAnimDict(dict)
							while not HasAnimDictLoaded(dict) do
								Citizen.Wait(0)
							end
							if not IsPedInAnyVehicle(PlayerPedId(), true) then
								TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
							end
							SetVehicleDoorShut(vehicle, 0, false)
							SetVehicleDoorShut(vehicle, 1, false)
							SetVehicleDoorShut(vehicle, 2, false)
							SetVehicleDoorShut(vehicle, 3, false)
							SetVehicleDoorShut(vehicle, 4, false)
							SetVehicleDoorShut(vehicle, 5, false)
							PlayVehicleDoorCloseSound(vehicle, 1)
							TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "lock", 0.5)
								ESX.TriggerServerCallback('3dme:getIcName', function(PlayerName)

									if PlayerName ~= nil then
							
										local text = '* ' .. PlayerName .. ' vasile naghlie ro ghofl mikone *'
	
		
										TriggerServerEvent('3dme:shareDisplay', text, false)
							
									end
							
								end)

							elseif islocked == 2 then
								SetVehicleDoorsLocked(vehicle, 1)
								ShowNotification(
									"Shoma ~y~" ..
										GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) .. "~w~ ra ~g~baaz ~w~kardid."
								)
								TriggerEvent("lockLights", vehicle)
								local dict = "anim@mp_player_intmenu@key_fob@"
							RequestAnimDict(dict)
							while not HasAnimDictLoaded(dict) do
								Citizen.Wait(0)
							end
							if not IsPedInAnyVehicle(PlayerPedId(), true) then
								TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
							end
							PlayVehicleDoorCloseSound(vehicle, 1)
							TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "unlock", 0.5)
								ESX.TriggerServerCallback('3dme:getIcName', function(PlayerName)

									if PlayerName ~= nil then
							
										local text = '* ' .. PlayerName .. ' vasile naghlie ro baz mikone *'
	
		
										TriggerServerEvent('3dme:shareDisplay', text, false)
							
									end
							
								end)
								
							end
						else
							ShowNotification("~r~Shoma nazdik mashin nistid.")
						end
				else
					ShowNotification("~r~~h~Shoma Mashin save shodeyi nadarid.")
				end

			end
			
		end
end)

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end
-- S A V E --
RegisterNetEvent("save")
AddEventHandler("save",function(pelak)

		local player = GetPlayerPed(-1)
		if (IsPedSittingInAnyVehicle(player)) then
			print("This is vehicle model: " .. GetEntityModel(GetVehiclePedIsIn(player)))
			if PlayerData.job.name == "police" then
				local vehicles = {
					1912215274,
					-2007026063,
					2046537925,
					-1627000575,
					456714581,
					-1323100960,
					2071877360,
					831758577,
					699188170,
					1341474454,
					-1674384553,
					-1973172295,
					1127131465,
					-1647941228,
					-34623805,
					-1683328900,
					1922257928,
					-305727417,
					-304857564,
					-1176401295,
					1624609239,
					-1661555510,
					1663218586,
					353883353,
					-982610657,
					-1083357304,
					1496279100,
					-1959382956,
					-834607087,
					-1631996672,
					653331214,
					38057582
				}

				local function contains(table, val)
					for i = 1, #table do
						if table[i] == val then
							return true
						end
					end
					return false
				end
				if contains(vehicles, GetEntityModel(GetVehiclePedIsIn(player))) then
					if saved == true then
						--remove from saved.
						saveVehicle = nil
						RemoveBlip(targetBlip)
						ShowNotification("Mashin ~g~save~w~ shode shoma ~r~hazf~w~ shod.")
						saved = false
					elseif saved == false then
						RemoveBlip(targetBlip)
						saveVehicle = GetVehiclePedIsIn(player, true)
						local vehicle = saveVehicle
						targetBlip = AddBlipForEntity(vehicle)
						SetBlipSprite(targetBlip, 41)
						SetBlipDisplay(targetBlip, 4)
						SetBlipScale(targetBlip, 0.8)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(pelak) -- set blip's "name"
						EndTextCommandSetBlipName(targetBlip)
						SetVehicleNumberPlateText(vehicle, pelak)
						ShowNotification(
							"~y~" ..
								GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) ..
									"~w~ Be onvan mashin shoma ~g~save ~w~Shod."
						)
						saved = true
					end
				else
					ShowNotification("~r~~h~Shoma Faghat Ghader be save kardan mashin haye police hastid")
				end

			elseif PlayerData.job.name == "mechanic" then

				local vehicles = {
					-1349095620,
					-1323100960,
					2132890591
				}

				local function contains(table, val)
					for i = 1, #table do
						if table[i] == val then
							return true
						end
					end
					return false
				end
				if contains(vehicles, GetEntityModel(GetVehiclePedIsIn(player))) then
					if saved == true then
						--remove from saved.
						saveVehicle = nil
						RemoveBlip(targetBlip)
						ShowNotification("Mashin ~g~save~w~ shode shoma ~r~hazf~w~ shod.")
						saved = false
					elseif saved == false then
						RemoveBlip(targetBlip)
						saveVehicle = GetVehiclePedIsIn(player, true)
						local vehicle = saveVehicle
						targetBlip = AddBlipForEntity(vehicle)
						SetBlipSprite(targetBlip, 225)
						SetVehicleNumberPlateText(vehicle, 'Mechanic')
						ShowNotification(
							"~y~" ..
								GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) ..
									"~w~ Be onvan mashin shoma ~g~save ~w~Shod."
						)
						saved = true
					end
				else
					ShowNotification("~r~~h~Shoma Faghat Ghader be save kardan mashin haye mechanici hastid")
				end


			elseif PlayerData.job.name == "ambulance" then

				local vehicles = {
					1171614426,
					469291905,
					-1647941228,
					353883353
				}

				local function contains(table, val)
					for i = 1, #table do
						if table[i] == val then
							return true
						end
					end
					return false
				end
				if contains(vehicles, GetEntityModel(GetVehiclePedIsIn(player))) then
					if saved == true then
						--remove from saved.
						saveVehicle = nil
						RemoveBlip(targetBlip)
						ShowNotification("Mashin ~g~save~w~ shode shoma ~r~hazf~w~ shod.")
						saved = false
					elseif saved == false then
						RemoveBlip(targetBlip)
						saveVehicle = GetVehiclePedIsIn(player, true)
						local vehicle = saveVehicle
						targetBlip = AddBlipForEntity(vehicle)
						SetBlipSprite(targetBlip, 225)
						SetVehicleNumberPlateText(vehicle, 'Ambulance')
						ShowNotification(
							"~y~" ..
								GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) ..
									"~w~ Be onvan mashin shoma ~g~save ~w~Shod."
						)
						saved = true
					end
				else
					ShowNotification("~r~~h~Shoma Faghat Ghader be save kardan mashin haye medic hastid")
				end

			elseif PlayerData.job.name == "taxi" then

				local vehicles = {
					-956048545,
					1123216662,
					-1961627517
				}

				local function contains(table, val)
					for i = 1, #table do
						if table[i] == val then
							return true
						end
					end
					return false
				end
				if contains(vehicles, GetEntityModel(GetVehiclePedIsIn(player))) then
					if saved == true then
						--remove from saved.
						saveVehicle = nil
						RemoveBlip(targetBlip)
						ShowNotification("Mashin ~g~save~w~ shode shoma ~r~hazf~w~ shod.")
						saved = false
					elseif saved == false then
						RemoveBlip(targetBlip)
						saveVehicle = GetVehiclePedIsIn(player, true)
						local vehicle = saveVehicle
						targetBlip = AddBlipForEntity(vehicle)
						SetBlipSprite(targetBlip, 225)
						SetVehicleNumberPlateText(vehicle, 'taxi')
						ShowNotification(
							"~y~" ..
								GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) ..
									"~w~ Be onvan mashin shoma ~g~save ~w~Shod."
						)
						saved = true
					end
				else
					ShowNotification("~r~~h~Shoma Faghat Ghader be save kardan mashin haye taxi hastid")
				end
			
			else

				ESX.ShowNotification("Shoma ozv hich organ dolati nistid")

			end
		end
			

	end)

-- R E M O T E --
RegisterNetEvent("controlsave")
AddEventHandler(
	"controlsave",
	function()
		if controlsave_bool == false then
			controlsave_bool = true
			if saveVehicle == nil then
				ShowNotification("~r~No saved vehicle.")
			else
				ShowNotification(
					"You are no longer controlling your ~y~" ..
						GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(saveVehicle)))
				)
			end
		else
			controlsave_bool = false
			if saveVehicle == nil then
				ShowNotification("~r~No saved vehicle.")
			else
				ShowNotification(
					"You are no longer controlling your ~y~" ..
						GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(saveVehicle)))
				)
			end
		end
	end
)


Citizen.CreateThread( function()
    while true do 
        Citizen.Wait(1)

		if IsControlJustReleased(0, 178) then 

			TriggerEvent('engine')
			
		end

		if IsControlJustReleased(0, 20) then 

			if GetGameTimer() - 2000  > timer then

				TriggerEvent('lock')

				timer = GetGameTimer()

			else

				timer = GetGameTimer()
				ESX.ShowNotification("~r~Lotfan spam nakonid")

			end
			
		end
        
    end
end )