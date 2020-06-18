ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- E N G I N E --
AddEventHandler('chatMessage', function(s, n, m)
  local message = string.lower(m)
  if message == "/engine off" then
    CancelEvent()
    --------------
    TriggerClientEvent('engineoff', s)
  elseif message == "/engine on" then
    CancelEvent()
    --------------
    TriggerClientEvent('engineon', s)
  elseif message == "/engine" then
    CancelEvent()
    --------------
    TriggerClientEvent('engine', s)
  end
end)
-- T R U N K --
AddEventHandler('chatMessage', function(s, n, m)
  local message = string.lower(m)
  if message == "/trunk" then
    CancelEvent()
    --------------
    TriggerClientEvent('trunk', s)
  end
end)
-- Left Front Door --
AddEventHandler('chatMessage', function(s, n, m)
  local message = string.lower(m)
  if message == "/lfdoor" then
    CancelEvent()
    --------------
    TriggerClientEvent('lfdoor', s)
  end
end)

-- Right Front Door --
AddEventHandler('chatMessage', function(s, n, m)
  local message = string.lower(m)
  if message == "/rfdoor" then
    CancelEvent()
    --------------
    TriggerClientEvent('rfdoor', s)
  end
end)

-- Left Rear Door --
AddEventHandler('chatMessage', function(s, n, m)
  local message = string.lower(m)
  if message == "/lrdoor" then
    CancelEvent()
    --------------
    TriggerClientEvent('lrdoor', s)
  end
end)

-- Right Rear Door --
AddEventHandler('chatMessage', function(s, n, m)
  local message = string.lower(m)
  if message == "/rrdoor" then
    CancelEvent()
    --------------
    TriggerClientEvent('rrdoor', s)
  end
end)

-- all doors --
AddEventHandler('chatMessage', function(s, n, m)
  local message = string.lower(m)
  if message == "/alldoors" then
    CancelEvent()
    --------------
    TriggerClientEvent('alldoors', s)
  end
end)

-- all windows down --
AddEventHandler('chatMessage', function(s, n, m)
  local message = string.lower(m)
  if message == "/allwindowsdown" then
    CancelEvent()
    --------------
    TriggerClientEvent('allwindowsdown', s)
  end
end)

-- all windows up --
AddEventHandler('chatMessage', function(s, n, m)
  local message = string.lower(m)
  if message == "/allwindowsup" then
    CancelEvent()
    --------------
    TriggerClientEvent('allwindowsup', s)
  end
end)

-- H O O D --
AddEventHandler('chatMessage', function(s, n, m)
  local message = string.lower(m)
  if message == "/hood" then
    CancelEvent()
    --------------
    TriggerClientEvent('hood', s)
  end
end)
-- L O C K --
AddEventHandler('chatMessage', function(s, n, m)
  local message = string.lower(m)
  if message == "/lock" then
    CancelEvent()
    --------------
    TriggerClientEvent('lock', s)
  end
end)
-- S A V E --
RegisterCommand("save", function(source, args)

      if args[2] == nil then
        if args[1] then

            local licenseplate = string.upper(args[1])

            TriggerClientEvent('save', source, licenseplate)
            
        else
          TriggerClientEvent('save', source)
        end
      
      else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Lotfan tamami shomare pelak ra faghat dar ghesmat aval vared konid")
      end


end)

-- R E M O T E --
AddEventHandler('chatMessage', function(s, n, m)
  local message = string.lower(m)
  if message == "/sveh" then
    CancelEvent()
    --------------
    TriggerClientEvent('controlsave', s)
  end
end)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end