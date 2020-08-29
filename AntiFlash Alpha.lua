--- Made by Clipper / superyu'#7167

local flashbangs = {}
client.AllowListener("flashbang_detonate")
local ref = gui.Reference('VISUALS', 'Other', 'Effects')
local Flash_percentage = gui.Checkbox(ref, 'vis_flash_percentage', 'Anti FlashAlpha', true)
local Flashpercent = gui.Slider(ref, "vis_flash_percentage_slider", "Max FlashAlpha", 100, 1, 255)
local set = gui.SetValue
local color = draw.Color
local filledRect = draw.FilledRect
local getScreenSize = draw.GetScreenSize
local time = globals.RealTime

callbacks.Register("Draw", function()
    if not Flash_percentage:GetValue() then return end
	set("esp.other.noflash", 0)
    local pLocal = entities.GetLocalPlayer()
    if pLocal then
        if pLocal:IsAlive() then
            pLocal:SetProp("m_flFlashMaxAlpha", Flashpercent:GetValue())

            for k, v in pairs(flashbangs) do
                local leftTime = v - (time() - pLocal:GetProp("m_flFlashDuration"))
                if leftTime < 0 then
                    table.remove(flashbangs, k)
                end
                local screenX, screenY = getScreenSize()
                screenX, screenY = screenX / 2, screenY / 2
                color(0, 0, 0, 155)
                filledRect(screenX+100, screenY+45, screenX-100, screenY+65)
                if (leftTime / pLocal:GetProp("m_flFlashDuration")) < 0.4 then
                    color(25, 255, 25, 155)
                else
                    color(255, 25, 25, 155)
                end
                filledRect(screenX-98 + ((98*2) * (leftTime / pLocal:GetProp("m_flFlashDuration"))), screenY+47, screenX-98, screenY+63)
            end
        end
    end
end)

callbacks.Register("FireGameEvent", function(event)
    if Flash_percentage:GetValue() and event:GetName() == "flashbang_detonate" then
        table.insert(flashbangs, time())
    end
end)