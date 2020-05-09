local button_held = input.IsButtonDown
local localPlayer = entities.GetLocalPlayer()
local y_offset = gui.Slider(gui.Reference("Visuals","Local","Helper"), "y.ind.offset", "HC Override Indicators Y-Offset", -70, -450, 450);
local screenX, screenY = draw.GetScreenSize()
local half_screenY = screenY / 2
local enabled = false
local ref = gui.Reference("RAGEBOT","ACCURACY","WEAPON")
local tgglekey = gui.Keybox(ref, "ChangeDmgKey", "HC Togglekey", 0);

-- Variables

local list_rbotweapons = 
{
	["shared"] = "shared",	
	["pistol"] = "pistol",
	["revolver"] = "revolver",
	["smg"] = "smg",
	["rifle"] = "rifle",
	["shotgun"] = "shotgun",
	["scout"] = "scout",
	["asniper"] = "autosniper",
	["sniper"] = "sniper",
	["lmg"] = "lmg";
}


for key_index, str_rbotweapon in pairs(list_rbotweapons) do
	
local hc_ref = gui.Reference("RAGEBOT", "ACCURACY", "WEAPON", key_index, "HITCHANCE")
hcslider = gui.Slider(hc_ref, string.format("rbot.accuracy.weapon." .. str_rbotweapon .. ".hitchance"), "hcslider","New HC Value", 1, 100, 1)
	
end



local function reduce()

if (localPlayer == nil) then return end;
if (tgglkey:GetValue() == 0) then return end;

-- the amount to adjust
local new_hc = hcslider:GetValue()

if not enabled then
old_hc = gui.GetValue(hc_ref, string.format("rbot.accuracy.weapon." , str_rbotweapon .. ".hitchance"))
end



    if button_held(tgglkey:GetValue()) then
        draw.Color(255,0,0,255);
        draw.Text(10, half_screenY-45+y_offset:GetValue(), "Accuracy Mode: Reduced")
        
        draw.Color(255,255,255,255)
        draw.Text(10, half_screenY-30+y_offset:GetValue(), "Hitchance:  " .. math.floor(new_hc))

        gui.SetValue(hc_ref, string.format("rbot.accuracy.weapon." .. str_rbotweapon .. ".hitchance")(new_hc))
        enabled = true
    else
        draw.Color(0,255,0,255)
        draw.Text(10, half_screenY-45+y_offset:GetValue(), "Accuracy Mode: Normal")
        draw.Color(255,255,255,255)
        
        draw.Text(10, half_screenY-30+y_offset:GetValue(), "Hitchance:  " .. math.floor(old_hc))
        
        gui.SetValue(hc_ref, string.format("rbot.accuracy.weapon." .. str_rbotweapon .. ".hitchance")(old_hc))
	  enabled = false
    end
end

callbacks.Register("Draw", reduce)
