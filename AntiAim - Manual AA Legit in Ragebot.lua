local w, h = draw.GetScreenSize()
local aa_ref = gui.Reference("Ragebot", "Anti-Aim")
local gb = gui.Groupbox(aa_ref, "Legit Anti-Aim", 15, 720, 300, 400)
local nf_key = gui.Keybox(gb, "nkey", "Off Key", 0)
local left_key = gui.Keybox(gb, "leftkey", "Left Key", 0)
local right_key = gui.Keybox(gb, "rightkey", "Right Key", 0)
local lby_angle = gui.Slider(gb, "lbyangle", "LBY Offset", 58, 0, 180)
local wposition = gui.Slider(gb, "w", "W Position", w/2, 0, w)
local yposition = gui.Slider(gb, "h", "H Position", h/2, 0, h)

nf_key:SetDescription("Removes Legit Desync")
left_key:SetDescription("Key used to set Fake to Left Side")
right_key:SetDescription("Key used to set Fake to Right Side")
lby_angle:SetDescription("Set LBY Flick angle")
wposition:SetDescription("Sets W Screenposition for the Indicator")
yposition:SetDescription("Sets H Screenposition for the Indicator")


local left = true
local nofake = true
   
local textFont = draw.CreateFont('Tahoma', 25, 100)

callbacks.Register( "Draw", "Inverter", function()
    draw.SetFont(textFont)
    draw.Color(128,0,0,255)

    if engine.GetServerIP() ~= nil then
if left and not nofake then
            draw.Text(wposition:GetValue(),hposition:GetValue(), "L <--")
        elseif not left and not nofake then
            draw.Text(wposition:GetValue(),hposition:GetValue(), "R -->")
        end
    end

    if left_key:GetValue() ~= 0 then
        if input.IsButtonPressed(left_key:GetValue()) then
            left = true
            nofake = false
        end
    end

    if right_key:GetValue() ~= 0 then
        if input.IsButtonPressed(right_key:GetValue()) then
            left = false
            nofake = false
        end
    end

    if nf_key:GetValue() ~= 0 then
        if input.IsButtonPressed(nf_key:GetValue()) then
            nofake = true
            gui.SetValue("rbot.antiaim.base", 0)
            gui.SetValue("rbot.antiaim.base.rotation", 0)
            gui.SetValue("rbot.antiaim.base.lby", 0)
            gui.SetValue("rbot.antiaim.advanced.antialign", 0)
        end
    end

    if left and not nofake then
        gui.SetValue("rbot.antiaim.base.lby", lby_angle:GetValue() * -1)
        gui.SetValue("rbot.antiaim.base.rotation", 58)
        gui.SetValue("rbot.antiaim.base", 0)
        gui.SetValue("rbot.antiaim.advanced.pitch", 0)
        gui.SetValue("rbot.antiaim.advanced.antialign", 1)
    elseif not left and not nofake then
        gui.SetValue("rbot.antiaim.base.lby", lby_angle:GetValue())
        gui.SetValue("rbot.antiaim.base.rotation", -58)
        gui.SetValue("rbot.antiaim.base", 0)
        gui.SetValue("rbot.antiaim.advanced.pitch", 0)
        gui.SetValue("rbot.antiaim.advanced.antialign", 1)
    end
end);