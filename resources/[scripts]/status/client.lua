------------------------------------------------------------------
--                          Variables
------------------------------------------------------------------

local AutoSaveHungerThirst = true             -- Boolean to update hunger / thirst
local AutoSaveHungerThirstTimer = 138000      -- Value in ms. Currently set to 2min30
local showHud = true                          -- Boolean to show / hide HUD
local factorHunger = (1000 * 100) / 2400000   -- Ratio to consume hunger's bar
local factorThirst = (1000 * 100) / 1800000   -- Ratio to consume thirst's bar
local hunger = 100                            -- Init hunger's variable. Set to 100 for development.
local thirst = 100                            -- Init thirst's variable. Set to 100 for development.
local health = 100
local armor  = 100
local w = 1920
local h = 1080
local x = 0.885
local y = 0.175

------------------------------------------------------------------
--                          Functions
------------------------------------------------------------------

function updateHUD(health, armor)
  SendNUIMessage({
    update = true,
    health = health,
    armor  = armor
  })
end

function MakeDigit(value)
	local left,num,right = string.match(value,'^([^%d]*%d)(%d*)(.-)$')

	return ('$' .. left..(num:reverse():gsub('(%d%d%d)','%1' .. ','):reverse())..right)
end

------------------------------------------------------------------
--                          Events
------------------------------------------------------------------

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  local job = xPlayer.job
  local gang = xPlayer.gang
  if gang.name ~= 'nogang' then
    SendNUIMessage({action = "gang", value = string.gsub(gang.name, "_", " ") .. " | " .. gang.grade_label})
  end
  if string.lower(job.name) ~= 'nojob' and (string.lower(job.name) ~= 'police' or job.ext == nil) then
      SendNUIMessage({action = "job", value = job.label .. " | " .. job.grade_label, icon = job.name})
  elseif job.ext and job.name == 'police' then
    if job.label == "Off-Duty" then
      SendNUIMessage({action = "job", value = job.ext:gsub("^%l", string.upper) .. " | " .. job.grade_label, icon = job.ext})
    else
      SendNUIMessage({action = "job", value = job.ext:gsub("^%l", string.upper) .. " | " .. 'Off-Duty', icon = job.ext})
    end
  end
  SendNUIMessage({action = "playerName", value = string.gsub(xPlayer.name, "_", " ") })
  SendNUIMessage({action = "cash", value = MakeDigit(xPlayer.money)})
end)

RegisterNetEvent('moneyUpdate')
AddEventHandler('moneyUpdate', function(money)
  SendNUIMessage({action = "cash", value = MakeDigit(money)})
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  if string.lower(job.name) ~= 'nojob' and (string.lower(job.name) ~= 'police' or job.ext == nil) then
      SendNUIMessage({action = "job", value = job.label .. " | " .. job.grade_label, icon = job.name})
  elseif job.ext and job.name == 'police' then
    if job.label == "Off-Duty" then
      SendNUIMessage({action = "job", value = job.ext:gsub("^%l", string.upper) .. " | " .. job.grade_label, icon = job.ext})
    else
      SendNUIMessage({action = "job", value = job.ext:gsub("^%l", string.upper) .. " | " .. 'Off-Duty', icon = job.ext})
    end    
  else
    SendNUIMessage({action = "job", value = 'hide', icon = job.name})
  end
end)

RegisterNetEvent('status:updatePing')
AddEventHandler('status:updatePing', function(ping)
  SendNUIMessage({action = "ping", value = ping})
end)

RegisterNetEvent('esx:setGang')
AddEventHandler('esx:setGang', function(gang)
  if gang.name ~= 'nogang' then
    SendNUIMessage({action = "gang", value = gang.name .. " | " .. gang.grade_label})
  else
    SendNUIMessage({action = "gang", value = 'hide'})
  end
end)

RegisterNetEvent('ShowStatus')
AddEventHandler('ShowStatus', function(state)
  showHud = state
end)

RegisterCommand('togglehud', function()
  showHud = not showHud
  TriggerEvent('toggleID', showHud)
end, false)

------------------------------------------------------------------
--                          Citizen
------------------------------------------------------------------
RegisterNetEvent('esx_customui:updateStatus')
AddEventHandler('esx_customui:updateStatus', function(status)
	SendNUIMessage({action = "updateStatus", status = status})
end)

AddEventHandler('Status:radio', function(data)
  SendNUIMessage(data)
end)

RegisterNetEvent('showStatus')
AddEventHandler('showStatus', function()
  -- Show HUD
  Citizen.CreateThread(function()
    local showed = false
    while true do
      if showed ~= showHud and not IsPauseMenuActive() then
        SendNUIMessage({
          display = showHud
        })
        showed = showHud
      end
      if IsPauseMenuActive() and showed then
        SendNUIMessage({
          display = false
        })
        showed = false
      end
      if showHud then
        local ped = GetPlayerPed(-1)
        -- Health
        local pedhealth = GetEntityHealth(ped)

        if pedhealth < 100 then
          health = 0
        else
          pedhealth = pedhealth - 100
          health    = pedhealth
        end
        -- armor
        local armor = GetPedArmour(ped)
        updateHUD(health, armor)
      end
      Citizen.Wait(1000)
    end
  end)

  Citizen.CreateThread(function()
    local handle = RegisterPedheadshotTransparent(PlayerPedId())
    while not IsPedheadshotValid(handle) do
      Wait(0)
      handle = RegisterPedheadshotTransparent(PlayerPedId())
    end
    while not IsPedheadshotReady(handle) do
      Wait(0)
    end
    local txd = GetPedheadshotTxdString(handle)
    while true do
      Wait(0)
      if showHud then
          DrawSprite(txd, txd, x, y, w, h, 0, 255, 255, 255, 10000);
      end
    end
  end)
end)

RegisterNUICallback('setmugpos', function(data)
  w = data.w
  h = data.h
  x = data.x + (data.w/2)
  y = data.y + (data.h/2)
end)
