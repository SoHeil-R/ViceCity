local ESX = nil
local salary = 0
local vehicles = {};

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx-salary:checkModelForVehicle')
AddEventHandler('esx-salary:checkModelForVehicle', function(model)
    local vehicleName = GetDisplayNameFromVehicleModel(model)
    if not contains(vehicles, vehicleName) then
        table.insert(vehicles, vehicleName)
    end
    TriggerServerEvent('esx-salary:passTheVehicleName', vehicles)
end)

RegisterNetEvent('esx-salary:modify')
AddEventHandler('esx-salary:modify', function(type, amount)

    if type == "add" then

        salary = salary + amount

    elseif type == "set" then
        
        salary = amount

    end

end)

RegisterCommand('takesalary', function(source)


    if checkDistance() then
        TriggerServerEvent('esx-salary:calculateSalary', GetPlayerServerId(PlayerId()))
    else
        TriggerEvent("chatMessage", "[SYSTEM]", {255, 0, 0}, "^0Shoma baraye bardasht salary bayad nazdik be baje bank bashid!")
    end
    
end, false)

-- RegisterCommand('addsalary', function(source, args)


--     local types = args[2]
--     local target = tonumber(args[1])
--     local amount = tonumber(args[3])
--     TriggerServerEvent('esx-salary:modify', target, types, amount)
    
-- end, false)

Citizen.CreateThread(function()
    Holograms()
end)

function checkDistance()
    local coords = GetEntityCoords(GetPlayerPed(-1))
    for k,v in pairs(Config.Zones) do
        for i=1, #v.Pos, 1 do
            if GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, false) < 2 then
                return true
            end
        end
    end
    return false
end

function contains(table, val)
    for i = 1, #table do
        if table[i] == val then
            return true
        end
    end
    return false
end

function Holograms()
	while true do
            Citizen.Wait(0)
            for k,v in pairs(Config.Zones) do
                for i=1, #v.Pos, 1 do
                    if GetDistanceBetweenCoords( v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, GetEntityCoords(GetPlayerPed(-1)), false) < 10.0 then
                        Draw3DText( v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, Config.Label, 4, 0.1, 0.1)
                        Draw3DText( v.Pos[i].x, v.Pos[i].y, v.Pos[i].z - 0.250, "Salary: " .. salary .. "$", 4, 0.1, 0.1)	
                    end	             
                end
            end
	end
end

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
         local px,py,pz=table.unpack(GetGameplayCamCoords())
         local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
         local scale = (1/dist)*20
         local fov = (1/GetGameplayCamFov())*100
         local scale = scale*fov   
         SetTextScale(scaleX*scale, scaleY*scale)
         SetTextFont(fontId)
         SetTextProportional(1)
         SetTextColour(250, 250, 250, 255)
         SetTextDropshadow(1, 1, 1, 1, 255)
         SetTextEdge(2, 0, 0, 0, 150)
         SetTextDropShadow()
         SetTextOutline()
         SetTextEntry("STRING")
         SetTextCentre(1)
         AddTextComponentString(textInput)
         SetDrawOrigin(x,y,z+2, 0)
         DrawText(0.0, 0.0)
         ClearDrawOrigin()
end