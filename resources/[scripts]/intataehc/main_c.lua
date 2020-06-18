local function doVehicles(f,...)
	local handle,veh = FindFirstVehicle()
	if handle ~= -1 then
		repeat
			Wait()
			f(veh,...) -- calls f with the found vehicle and other passed arguments.
			status,veh = FindNextVehicle(handle) -- update vehicle and make sure there is another vehicle.
		until not status
		EndFindVehicle(handle) -- close the find handle.
	end
end

Citizen.CreateThread(function()
	DecorRegister("GamemodeCar",3)
	DecorRegisterLock()
	while true do
		Citizen.Wait(10)
		doVehicles(function(vehicle)
			if DecorGetInt(vehicle,"GamemodeCar") ~= 955 then
				DeleteVehicle(vehicle)
			end
		end)		
	end
end)