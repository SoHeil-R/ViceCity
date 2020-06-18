  local chatInputActive = false
  local chatInputActivating = false
  local muted  = false

  RegisterNetEvent('chatMessage')
  RegisterNetEvent('chat:addTemplate')
  RegisterNetEvent('chat:addMessage')
  RegisterNetEvent('chat:addSuggestion')
  RegisterNetEvent('chat:removeSuggestion')
  RegisterNetEvent('chat:clear')

  -- internal events
  RegisterNetEvent('__cfx_internal:serverPrint')

  RegisterNetEvent('_chat:messageEntered')

  --deprecated, use chat:addMessage
  AddEventHandler('chatMessage', function(author, color, text)
    local args = { text }
    if author ~= "" then
      table.insert(args, 1, author)
    end
    SendNUIMessage({
      type = 'ON_MESSAGE',
      message = {
        color = color,
        multiline = true,
        args = args
      }
    })
  end)

  AddEventHandler('__cfx_internal:serverPrint', function(msg)
    print(msg)

    SendNUIMessage({
      type = 'ON_MESSAGE',
      message = {
        color = { 0, 0, 0 },
        multiline = true,
        args = { msg }
      }
    })
  end)

  AddEventHandler('chat:addMessage', function(message)
    SendNUIMessage({
      type = 'ON_MESSAGE',
      message = message
    })
  end)

  AddEventHandler('chat:addSuggestion', function(name, help, params)
    SendNUIMessage({
      type = 'ON_SUGGESTION_ADD',
      suggestion = {
        name = name,
        help = help,
        params = params or nil
      }
    })
  end)

  AddEventHandler('chat:removeSuggestion', function(name)
    SendNUIMessage({
      type = 'ON_SUGGESTION_REMOVE',
      name = name
    })
  end)

  AddEventHandler('chat:addTemplate', function(id, html)
    SendNUIMessage({
      type = 'ON_TEMPLATE_ADD',
      template = {
        id = id,
        html = html
      }
    })
  end)

  AddEventHandler('chat:clear', function(name)
    SendNUIMessage({
      type = 'ON_CLEAR'
    })
  end)

  RegisterNetEvent("chat:setMuteStatus")
  AddEventHandler("chat:setMuteStatus", function(status)
    
    muted = status

  end)

  RegisterNUICallback('chatResult', function(data, cb)
    chatInputActive = false
    SetNuiFocus(false)

    if not data.canceled then
      local id = PlayerId()

      --deprecated
      local r, g, b = 0, 0x99, 255
      -- local playerID = GetPlayerFromServerId(PlayerId())
      -- local playerName = GetPlayerName(GetPlayerFromServerId(PlayerId()))
      -- TriggerServerEvent('DiscordBot:ToDiscord', 'chat', playerName .. ' [ID: ' .. playerID .. ']', data.message,'user', true, PlayerId(), false)
      TriggerServerEvent('chat:logMessage', data.message)
      if data.message:sub(1, 1) == '/' then
        if not muted then
          ExecuteCommand(data.message:sub(2))
        else

          if data.message:sub(1, 4) == '/ooc' or data.message:sub(1, 2) == '/b' or data.message:sub(1, 2) == '/s' or data.message:sub(1, 3) == '/mp' or data.message:sub(1, 3) == '/me' or data.message:sub(1, 4) == '/do' then

            TriggerEvent('chat:addMessage', {
              color = { 255, 0, 0},
              multiline = true,
              args = {"[SYSTEM]", "^0Shoma nemitavanid hengami ke ^1mute ^0hastid chat konid!"}
              })

          else
            
            ExecuteCommand(data.message:sub(2))

          end
          
        end
        
      else

        if not muted then
          TriggerServerEvent('_chat:messageEntered', GetPlayerName(id), { r, g, b }, data.message)
        else

          TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[SYSTEM]", "^0Shoma nemitavanid hengami ke ^1mute ^0hastid chat konid!"}
            })

        end

      end
    end

    cb('ok')
  end)

  RegisterNUICallback('loaded', function(data, cb)
    TriggerServerEvent('chat:init');

    cb('ok')
  end)

  Citizen.CreateThread(function()
    SetTextChatEnabled(false)
    SetNuiFocus(false)

    while true do
      Wait(0)

      if not chatInputActive then
        if IsControlPressed(0, 245) --[[ INPUT_MP_TEXT_CHAT_ALL ]] then
          chatInputActive = true
          chatInputActivating = true

          SendNUIMessage({
            type = 'ON_OPEN'
          })
        end
      end

      if chatInputActivating then
        if not IsControlPressed(0, 245) then
          SetNuiFocus(true)

          chatInputActivating = false
        end
      end
    end
  end)
