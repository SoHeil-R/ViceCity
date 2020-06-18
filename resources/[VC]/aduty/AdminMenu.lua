local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject",function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local permissions = {
	ban = false,
	kick = false,
	spectate = true,
	unban = false,
	teleport = false,
	manageserver = false,
	slap = false,
	freeze = false,
	screenshot = false,
	immune = false,
	anon = false,
	mute = false,
}
function ChangeXPostion(orientation)
	if orientation == "right" then
		return 1320
	elseif orientation == "middle" then
		return 730
	elseif orientation == "left" then
		return 0
	end
end

function ChangeYPostion(orientation)
	if orientation == "down" then
		return 600
	elseif orientation == "middle" then
		return 300
	elseif orientation == "top" then
		return 0
	end
end

local _X = ChangeXPostion("left")
local _Y = ChangeYPostion("top")

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("ViceCity Admin", "~b~Admin Menu" ,_X ,_Y)
_menuPool:Add(mainMenu)

RegisterNetEvent("aduty:requestSpectate")
AddEventHandler('aduty:requestSpectate', function(playerId)
	local playerId = GetPlayerFromServerId(playerId)
	spectatePlayer(GetPlayerPed(playerId),playerId,GetPlayerName(playerId))
end)

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function SelfMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, "SelfMenu", "Self Menu!",_X , _Y)
    local thisItem = NativeUI.CreateItem("More item coming soon!", "")
    --local GodMode = NativeUI.CreateCheckboxItem("GodMode", ketchup, "Namir Shodan! xD")
    submenu:AddItem(thisItem)
    submenu.OnCheckboxChange = function(sender, item, checked_)
        Check = checked_
        if item == newitem then
            ShowNotification("~r~GodMode Status: ~b~"..tostring(Check))
        end
    end
end

function OnlinePlayers(menu)
    local xPlayer = {}

    local submenu = _menuPool:AddSubMenu(menu, "OnlinePlayer", "See online player!",_X , _Y)
    for k,theplayer in pairs(GetActivePlayers()) do
        if NetworkIsPlayerActive(theplayer) and GetPlayerServerId(theplayer) ~= 0 then
            thisPlayer = _menuPool:AddSubMenu(submenu, GetPlayerName(theplayer), "ID ["..GetPlayerServerId(theplayer).."] "..(IsPedDeadOrDying(GetPlayerPed(theplayer), 1) and "~r~DEAD" or "~g~ALIVE"),_X , _Y)
            submenu:AddItem(thisPlayer)
            if permissions.spectate then
			    local thisItem = NativeUI.CreateItem("Spectate Player", "")
			    thisPlayer:AddItem(thisItem)
                thisItem.Activated = function(ParentMenu,SelectedItem)
                    TriggerServerEvent("aduty:requestSpectate",GetPlayerServerId(theplayer))
                end
            end
            local thisItem = NativeUI.CreateItem("More item coming soon!", "")
			thisPlayer:AddItem(thisItem)
        end
    end
end

function spectatePlayer(targetPed,target,name)
	local playerPed = PlayerPedId() -- yourself
	enable = true
	if targetPed == playerPed then enable = false end

	if(enable)then

			local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

			RequestCollisionAtCoord(targetx,targety,targetz)
			NetworkSetInSpectatorMode(true, targetPed)

			DrawPlayerInfo(target)
			ShowNotification("Start spectate "..name)
	else

			local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

			RequestCollisionAtCoord(targetx,targety,targetz)
			NetworkSetInSpectatorMode(false, targetPed)

            --StopDrawPlayerInfo()
            ShowNotification("Stop spectate!")
	end
end

function TeleportOP(menu)
    local submenu = _menuPool:AddSubMenu(menu, "Teleport OP", "Teleport to coords!",_X , _Y)
    local thisItem = NativeUI.CreateItem("More item coming soon!", "")
    submenu:AddItem(thisItem)
    submenu.OnCheckboxChange = function(sender, item, checked_)
        Check = checked_
        if item == newitem then
            ShowNotification("~r~GodMode Status: ~b~"..tostring(Check))
        end
    end
end

function Settings(menu)
    local submenu = _menuPool:AddSubMenu(menu, "Settings", "Menu Serrings",_X , _Y)
    local Menu_X = {"left","middle","right"}
    local Menu_Y = {"top","middle","down"}
    local MenuX = NativeUI.CreateListItem("Menu-X", Menu_X, 1)
    local MenuY = NativeUI.CreateListItem("Menu-Y", Menu_Y, 1)
    local ChangePostion = NativeUI.CreateItem("Change Postion", "Enter to change apply your custom X,Y")
    submenu:AddItem(MenuX)
    submenu:AddItem(MenuY)
    ChangePostion:SetRightBadge(BadgeStyle.Tick)
    submenu:AddItem(ChangePostion)
    submenu.OnItemSelect = function(sender, item, index)
        if item == ChangePostion then
            ChnagedPostion()
            ShowNotification("~r~Menu Postion Change!")
        end
    end
    submenu.OnListChange = function(sender, item, index)
        dish = item:IndexToItem(index)
        if item == MenuX then
            _X = ChangeXPostion(dish)
            ShowNotification("~r~ Your X Menu Change to :~w~"..dish)
        elseif item == MenuY then
            _Y = ChangeYPostion(dish)
            ShowNotification("~r~ Your Y Menu Change to :~w~"..dish) 
        end
        print(_X,_Y)
    end
end
function ChnagedPostion()
    _menuPool:RefreshIndex()
    _menuPool = nil
    mainMenu = nil
    _menuPool = NativeUI.CreatePool()
    mainMenu = NativeUI.CreateMenu("ViceCity Admin", "~b~Admin Menu" ,_X ,_Y)
    _menuPool:Add(mainMenu)
    SelfMenu(mainMenu)
    OnlinePlayers(mainMenu)
    TeleportOP(mainMenu)
    Settings(mainMenu)
    _menuPool:MouseControlsEnabled (false);
    _menuPool:MouseEdgeEnabled (false);
    _menuPool:ControlDisablingEnabled(false);
    _menuPool:RefreshIndex()
end

SelfMenu(mainMenu)
OnlinePlayers(mainMenu)
TeleportOP(mainMenu)
Settings(mainMenu)
_menuPool:MouseControlsEnabled (false);
_menuPool:MouseEdgeEnabled (false);
_menuPool:ControlDisablingEnabled(false);
_menuPool:RefreshIndex()

Citizen.CreateThread(function()
    local ShowButtonHold = false
	local time = 0
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        if IsControlJustPressed(1, Keys["F9"]) then
            
            ESX.TriggerServerCallback('esx_aduty:checkAdmin', function(isAdmin)
                if isAdmin then
                    if ESX.GetPlayerData()['aduty'] == 1 then
                        ChnagedPostion()
                        mainMenu:Visible(not mainMenu:Visible())
                    else
                        ShowNotification("~r~Shoma OnDuty Nistid!")
                    end
                end
            end)
        end
    end
end)