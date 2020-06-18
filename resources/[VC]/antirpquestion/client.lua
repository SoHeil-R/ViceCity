--[[ QUESTION ANTI RP -- @DiiiaZoTe ]]
-- ***************** NUI Variables
local questionOpen = false

RegisterNetEvent('antirpquestion:notMade')
AddEventHandler('antirpquestion:notMade', function()
	openGui()
	questionOpen = true
end)

-- ***************** Open Gui and Focus NUI
function openGui()
  SetNuiFocus(true)
  SendNUIMessage({openQuestion = true})
end

-- ***************** Close Gui and disable NUI
function closeGui()
  questionOpen = false
  SetNuiFocus(false)
  SendNUIMessage({openQuestion = false})
end

-- ***************** Disable controls while GUI open
Citizen.CreateThread(function()
  while true do
    if questionOpen then
      local ply = GetPlayerPed(-1)
      local active = true
      DisableControlAction(0, 1, active) -- LookLeftRight
      DisableControlAction(0, 2, active) -- LookUpDown
      DisablePlayerFiring(ply, true) -- Disable weapon firing
      DisableControlAction(0, 142, active) -- MeleeAttackAlternate
      DisableControlAction(0, 106, active) -- VehicleMouseControlOverride
      if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
        SendNUIMessage({type = "click"})
      end
    end
    Citizen.Wait(0)
  end
end)

-- ***************** NUI Callback Methods
-- Callbacks pages opening

RegisterNUICallback('question', function(data, cb)
  SendNUIMessage({openSection = "question"})
  cb('ok')
end)

-- Callback actions triggering server events
RegisterNUICallback('close', function(data, cb)
  -- if question success
  closeGui()
  TriggerServerEvent('antirpquestion:success')
  cb('ok')
end)

RegisterNUICallback('kick', function(data, cb)
  closeGui()
  TriggerServerEvent('antirpquestion:kick')
  cb('ok')
end)






