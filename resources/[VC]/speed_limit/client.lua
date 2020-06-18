-------------------------------------------------------------------------------
-- Title: Speed limiter.
-- Author: Serpico -- twitch.tv/SerpicoTV
-- Description: This script will restict the speed of the vehicle when
--              INPUT_MP_TEXT_CHAT_TEAM is pressed. To disable, press
--              INPUT_VEH_SUB_ASCEND + INPUT_MP_TEXT_CHAT_TEAM
-------------------------------------------------------------------------------
local useMph = false -- if false, it will display speed in kph
local speedLimited = false

Citizen.CreateThread(function()
  local resetSpeedOnEnter = true
  while true do
    Citizen.Wait(0)
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed,false)
    if GetPedInVehicleSeat(vehicle, -1) == playerPed and IsPedInAnyVehicle(playerPed, false) then

      -- This should only happen on vehicle first entry to disable any old values
      if resetSpeedOnEnter then
        maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
        SetEntityMaxSpeed(vehicle, maxSpeed)
        resetSpeedOnEnter = false
        speedLimited = false
      end
      -- Disable speed limiter
      if IsControlJustReleased(0,29) and speedLimited then
		speedLimited = false
        maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
        SetEntityMaxSpeed(vehicle, maxSpeed)
        showHelpNotification("Speed limiter disabled", 1)
      -- Enable speed limiter
      elseif IsControlJustReleased(0,29) and not speedLimited then
		speedLimited = true
        cruise = GetEntitySpeed(vehicle)
        SetEntityMaxSpeed(vehicle, cruise)
        if useMph then
			cruise = math.floor(cruise * 2.23694 + 0.5)
			showHelpNotification("Speed limiter set to "..cruise.." mph.", 0)
        else
			cruise = math.floor(cruise * 3.6 + 0.5)
			showHelpNotification("Speed limiter set to "..cruise.." km/h.", 0)
        end
      end
    else
      resetSpeedOnEnter = true
    end
  end
end)

function showHelpNotification(msg, type)
	if type == 0 then 
		TriggerEvent("pNotify:SendNotification", {text = msg, type = "success", timeout = math.random(1000, 10000), layout = "centerLeft", queue = "left"})
	else
		TriggerEvent("pNotify:SendNotification", {text = msg, type = "error", timeout = math.random(1000, 10000), layout = "centerLeft", queue = "left"})
	end
end


RegisterCommand('cruise', function(source, args)

    if args[1] then

      local speedLimit = tonumber(args[1])

        if speedLimit then
          local limit = (speedLimit / 3.6)
          local ped = GetPlayerPed(-1)
          local vehicle = GetVehiclePedIsIn(ped,false)

            if IsPedInAnyVehicle(ped, false) then
              

                 if GetPedInVehicleSeat(vehicle, -1) == ped then

                  local vehicleSpeed = GetEntitySpeed(vehicle)
                  vehicleSpeed = math.floor(vehicleSpeed * 3.6 + 0.5)

                  if vehicleSpeed < speedLimit then

                    SetEntityMaxSpeed(vehicle, limit)
                    showHelpNotification("Speed limiter set to ".. speedLimit .." km/h.", 0)
                    speedLimited = true

                  else

                    TriggerEvent('chat:addMessage', {
                      color = { 255, 0, 0},
                      multiline = true,
                      args = {"[SYSTEM]", "^0Sorat feliye mashin shoma az cruise bishtar ast!"}
                      })
                   
                 end

                 else

                  TriggerEvent('chat:addMessage', {
                    color = { 255, 0, 0},
                    multiline = true,
                    args = {"[SYSTEM]", "^0Shoma baraye estefade az in dastor bayad ranande bashid!"}
                    })

                 end

            else

              TriggerEvent('chat:addMessage', {
								color = { 255, 0, 0},
								multiline = true,
								args = {"[SYSTEM]", "^0Shoma baraye estefade az in dastor bayad dadkhel mashin bashid!"}
                })

            end
          
        else

          TriggerEvent('chat:addMessage', {
								color = { 255, 0, 0},
								multiline = true,
								args = {"[SYSTEM]", "^0Soma dar ghesmat cruise faghat mitavanid adad vared konid!"}
                })
                
        end

    else

        TriggerEvent('chat:addMessage', {
          color = { 255, 0, 0},
          multiline = true,
          args = {"[SYSTEM]", "^0Shoma dar ghesmat cruise adadi vared nakardid!"}
          })

    end

end)

TriggerEvent('chat:addSuggestion', '/cruise', 'Baraye limit kardan soorat mashin', {
  { name="Soraat", help="Meghdar soraat" }
})