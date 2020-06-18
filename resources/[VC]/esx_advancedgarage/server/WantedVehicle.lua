function CreateVehicleWanted(plate, source)

    local self = {}
    self.plate  = plate
    self.source = source
    self.found = nil

    self.setState = function(v)
        if not self.found then
            self.found = v
        end
    end

    -- SetTimeout(1000 * 60 * 5, function()
    SetTimeout(1000 * 60 * 5, function()
        if self.found ~= false then
            exports.ghmattimysql:execute('UPDATE `owned_vehicles` SET `stored` = @stored WHERE `plate` = @plate',{
                ['@stored'] = true,
                ['@plate']  = self.plate
            }, function()
                TriggerClientEvent('esx:showNotification', self.source, 'Mashine Shoma Peyda Shod, Be parking moraje\'e konid')                    
            end)
        else
            TriggerClientEvent('esx:showNotification', self.source, 'Mashine Shoma Peyda nashod va poole shoma bargasht khord')
        end
        VehicleWanted[self.plate] = nil
    end)
    
    return self
end