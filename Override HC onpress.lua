local setValue = gui.SetValue
local getValue = gui.GetValue
local creg = callbacks.Register
local button_held = input.IsButtonDown
local y_offset = gui.Slider(gui.Reference("Visuals","Local","Helper"), "y.ind.offset", "HC Override Indicators Y-Offset", -70, -450, 450)
local screenX, screenY = draw.GetScreenSize()
local half_screenY = screenY / 2
local enabled = false
local reduce_hc_ref = gui.Reference("RAGEBOT", "ACCURACY", "WEAPON");
local hcslider = gui.Slider(reduce_hc_ref, "lua_hcslider", "New HC Slider", 0, 1, 100)
--local asnipermindmgslider = gui.Slider(reduce_hc_ref,"asnipermindmgslider", "New MinDmg Slider", 0, 1, 100)
local tgglkey = gui.Keybox(reduce_hc_ref, "ChangeHCKey", "Change HC key", false);

local weaponIDs = {
    --get the rest from https://tf2b.com/itemlist.php?gid=730
[9] = "sniper",
[40] = "scout",
[38] = "asniper",
[11] = "asniper",
[1] = "hpistol",
[2] = "pistol",
[31] = "zeus"
};

local lp = entities.GetLocalPlayer()

-- cache old hc/dmg to restore later
-- local old_hc = getValue("rbot.accuracy.weapon." .. (weaponIDs[lp:GetWeaponID()]) .. "hitchance")


local function reduce()


if (tgglkey:GetValue() == false) then
        return;
    end

-- the amount to adjust
local new_hc = hcslider:GetValue()
--local new_dmg = asnipermindmgslider:GetValue()

if not enabled then
old_hc = getValue("rbot.accuracy.weapon." .. (weaponIDs[lp:GetWeaponID()]) .. "hitchance")
end--local old_dmg = get("rbot.accuracy.weapon.asniper.mindmg")


    if button_held(tgglkey:GetValue()) then
        draw.Color(255,0,0,255);
        draw.Text(10, half_screenY-45+y_offset:GetValue(), "Accuracy Mode: Reduced")
        
        draw.Color(255,255,255,255)
        draw.Text(10, half_screenY-30+y_offset:GetValue(), "Hitchance:  " .. math.floor(new_hc))
       -- draw.Text(10, 645, "Minimum DMG:  " .. math.floor(new_dmg))
         setValue("rbot.accuracy.weapon." .. (weaponIDs[lp:GetWeaponID()]) .. "hitchance", (new_hc))
      --  set("rbot.accuracy.weapon.asniper.mindmg", asnipermindmgslider:GetValue())
        enabled = true
    else
        draw.Color(0,255,0,255)
        draw.Text(10, half_screenY-45+y_offset:GetValue(), "Accuracy Mode: Normal")
        draw.Color(255,255,255,255)
        
        draw.Text(10, half_screenY-30+y_offset:GetValue(), "Hitchance:  " .. math.floor(old_hc))
      --  draw.Text(10, 645, "Minimum DMG:  " .. math.floor(old_dmg))
        
        setValue("rbot.accuracy.weapon." .. (weaponIDs[lp:GetWeaponID()]) .. "hitchance", (old_hc))
      --  set("rbot.accuracy.weapon.asniper.mindmg", old_dmg)
	  enabled = false
    end
end

creg("Draw", "reduce", reduce)