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

local hc_ref = gui.Reference("RAGEBOT", "ACCURACY", "WEAPON");
local hcslider = gui.Slider(hc_ref, "lua_hcslider", "New HC Slider", 0, 1, 100)
local tgglkey = gui.Keybox(hc_ref, "ChangeHCKey", "Change HC key", nil);

local lp = entities.GetLocalPlayer()

callbacks.Register( 'Draw', function()
    if (tgglkey:GetValue() == nil) then
        return;
    end
	
	local new_hc = hcslider:GetValue()
	
	if not enabled then
	old_hc = gui.GetValue("rbot.accuracy.weapon." .. (weaponIDs[lp:GetWeaponID()]) .. ".hitchance")
	end
	
	if input.IsButtonDown(tgglkey:GetValue()) then
    gui.SetValue( "rbot.accuracy.weapon." .. (weaponIDs[lp:GetWeaponID()]) .. ".hitchance", new_hc)
    enabled = true
	else
    gui.SetValue( "rbot.accuracy.weapon." .. (weaponIDs[lp:GetWeaponID()]) .. ".hitchance", old_hc)
	enabled = false
end
end)
