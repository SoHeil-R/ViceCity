ESX                 = nil
Config              = {}
Config.TimerInSec   = 600

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CreateCapture(name, coords, reward, handeler)

    local self    = {}
    
    self.handeler = handeler

    self.reward   = reward

    self.timer    = os.time(os.date("!*t")) + Config.TimerInSec

    self.untilEnd = function()
        return self.timer - os.time(os.date("!*t"))
    end

    self.capData  = {
        name      = name,
        coords    = coords,
        gang      = handeler
    }

    self.NewHandeler  = function(handeler)
        self.handeler       = handeler
        self.capData.gang   = handeler
        self.timer          = os.time(os.date("!*t")) + Config.TimerInSec
        TriggerClientEvent('capture:ChangeCaptureHandler', -1, self.handeler, self.untilEnd())
        self.ActivateCapture()
    end

    self.CaptureStatus = function()
        if self.timer then
            local secondsAfterLastCapture = self.timer - os.time(os.date("!*t"))
            if secondsAfterLastCapture <= 1 then
                return true
            else
                return false
            end
        else
            return 0
        end
    end

    self.GiveReward = function()
        TriggerClientEvent('capture:CaptureEnded', -1, self.handeler)
        -- TriggerEvent('ResourceManager:EndCapture') Maybe you deserve it later :D
        TriggerEvent(self.reward, self.handeler)
        LiveCapture = nil
    end

    self.ActivateCapture = function()
        SetTimeout(Config.TimerInSec * 1000, function()
            if self.CaptureStatus() then
                self.GiveReward()
            end
        end)
    end

    -- Give notification About Starting Capture
    TriggerClientEvent('capture:CaptureStarted', -1, self.capData, self.untilEnd())
    self.ActivateCapture()

    return self
end