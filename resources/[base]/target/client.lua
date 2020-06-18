function Target()
  local camCoords              = GetCamCoord(nil)
  local right, forward, up, at = GetCamMatrix(nil)
  local forwardCoords          = camCoords + forward * 1000.0
  local rayHandle              = CastRayPointToPoint(camCoords.x, camCoords.y, camCoords.z, forwardCoords.x, forwardCoords.y, forwardCoords.z, -1, GetPlayerPed(-1),  0)
  
  local rayHandle, hit, surface, coords, entity = GetRaycastResult(rayHandle)
  if hit then
    return hit
  end
  return nil
end

Citizen.CreateThread(function()
  local show   = false
  while true do
    local entity = Target()
    if entity then
      if not show then
        show = true
        SendNUIMessage({
          show    = true
        })
      end
    else
      if show then
        show = false
        SendNUIMessage({
          show    = false
        })
      end
    end
    Wait(333)
  end
end)