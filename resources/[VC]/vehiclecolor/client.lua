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
local neonsStatus = true

function SetVehicleMaxMods(vehicle)
	local props = {
		color1 = math.random(0, 159),
		color2 = math.random(0, 159),
        pearlescentColor = math.random(0, 159),
	}
	

	ESX.Game.SetVehicleProperties(vehicle, props)
	SetVehicleDirtLevel(vehicle, 0.0)
end

RegisterNetEvent("vehicleColorChanger")
AddEventHandler("vehicleColorChanger",function(source)
    if PlayerData.job.name == 'police' then
            local player = GetPlayerPed(-1)
		    if (IsPedSittingInAnyVehicle(player)) then
            local vehicles = {
                -834607087,
                -1973172295
                
            }
            local function contains(table, val)
                for i = 1, #table do
                    if table[i] == val then
                        return true
                    end
                end
                return false
            end
        
            local car = GetVehiclePedIsIn(player, false)
            if car then
                if GetPedInVehicleSeat(car, -1) == player then
                    if contains(vehicles, GetEntityModel(GetVehiclePedIsIn(player))) then
                        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                        SetVehicleMaxMods(vehicle)
                        SetVehicleNeonLightsColour(vehicle,math.random(0, 255),math.random(0, 255),math.random(0, 255))
                        ESX.ShowNotification("~g~~h~Rang Mashin ba movafaghiat taghir kard")
                     else
                         ESX.ShowNotification("~r~Shoma nemitavanid rang in mashin ra taghir dahid")
                     end
                else 
                ESX.ShowNotification("~r~~h~Faghat ranande mitavanad az in dastor estefade konad!")
                end
            end
    else
        ESX.ShowNotification("~r~~h~Shoma baraye estefade az in command bayad dakhel mashin bashid")
    end
    else
        ESX.ShowNotification("~r~~h~Shoma police nistid")
    end
end)

RegisterNetEvent("neonHandler")
AddEventHandler("neonHandler",function(source)
    local player = GetPlayerPed(-1)
    if (IsPedSittingInAnyVehicle(player)) then
        local car = GetVehiclePedIsIn(player, false)
        if car then
            if GetPedInVehicleSeat(car, -1) == player then
                local veh = GetVehiclePedIsUsing(player)
        

                if neonsStatus then
                    SetVehicleNeonLightEnabled(veh, 0, false)
                    SetVehicleNeonLightEnabled(veh, 1, false)
                    SetVehicleNeonLightEnabled(veh, 2, false)
                    SetVehicleNeonLightEnabled(veh, 3, false)
                  neonsStatus = false
                  ESX.ShowNotification("~g~~h~Neon haye mashin khamosh shodanad!")
                else
                    SetVehicleNeonLightEnabled(veh, 0, true)
                    SetVehicleNeonLightEnabled(veh, 1, true)
                    SetVehicleNeonLightEnabled(veh, 2, true)
                    SetVehicleNeonLightEnabled(veh, 3, true)
                    neonsStatus = true
                    ESX.ShowNotification("~g~~h~Neon haye mashin roshan shodand!")
                end
            else 
                ESX.ShowNotification("~r~~h~Faghat ranande mitavanad az in dastor estefade konad!")
            end
        end
     else
        ESX.ShowNotification("~r~~h~Shoma baraye estefade az in command bayad dakhel mashin bashid")
     end
end)