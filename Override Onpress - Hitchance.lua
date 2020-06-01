----    Base    code    for    auto    updating.
--
--local    cS    =    GetScriptName()
--local    cV    =    '1.0.0'
--local    gS    =    'PUT    LINK    TO    RAW    LUA    SCRIPT'
--local    gV    =    'PUT    LINK    TO    RAW    VERSION'
--
--local    function    AutoUpdate()
--	if    gui.GetValue('lua_allow_http')    and    gui.GetValue('lua_allow_cfg')    then
--		local    nV    =    http.Get(gV)
--		if    cV    ~=    nV    then
--			local    nF    =    http.Get(gS)
--			local    cF    =    file.Open(cS,    'w')
--			cF:Write(nF)
--			cF:Close()
--			print(cS,    'updated    from',    cV,    'to',    nV)
--		else
--			print(cS,    'is    up-to-date.')
--		end
--	end
--end		
--
--callbacks.Register('Draw',    'Auto    Update')
--callbacks.Unregister('Draw',    'Auto    Update')



local guiSet = gui.SetValue
local guiGet = gui.GetValue
local rage_ref_extra = gui.Reference("RAGEBOT", "ACCURACY", "WEAPON");
local chengeDamageText = gui.Text(rage_ref_extra, "--- Changer Hitchance ---");
local newHitchance = gui.Slider(rage_ref_extra, "newHitchance", "HitChance", 1, 0, 100);
local changeKey = gui.Keybox(rage_ref_extra, "ChangeDmgKey", "Change HC key", 0);
local auto = guiGet("rbot.accuracy.weapon.asniper.hitchance")
local sniper = guiGet("rbot.accuracy.weapon.sniper.hitchance")
local pistol = guiGet("rbot.accuracy.weapon.pistol.hitchance")
local revolver = guiGet("rbot.accuracy.weapon.hpistol.hitchance")
local smg = guiGet("rbot.accuracy.weapon.smg.hitchance")
local rifle = guiGet("rbot.accuracy.weapon.rifle.hitchance")
local shotgun = guiGet("rbot.accuracy.weapon.shotgun.hitchance")
local scout = guiGet("rbot.accuracy.weapon.scout.hitchance")
local lmg = guiGet("rbot.accuracy.weapon.lmg.hitchance")
local toggle = 1;
function changehcMain()
    if(input.IsButtonPressed(changeKey:GetValue())) then
            toggle = toggle + 1;
    elseif(input.IsButtonDown) then
    -- do nothing
    end
    if(input.IsButtonReleased(changeKey:GetValue())) then
            if (toggle%2 == 0) then
                    auto = guiGet("rbot.accuracy.weapon.asniper.hitchance")
                    sniper = guiGet("rbot.accuracy.weapon.sniper.hitchance")
                    pistol = guiGet("rbot.accuracy.weapon.pistol.hitchance")
                    revolver = guiGet("rbot.accuracy.weapon.hpistol.hitchance")
                    smg = guiGet("rbot.accuracy.weapon.smg.hitchance")
                    rifle = guiGet("rbot.accuracy.weapon.rifle.hitchance")
                    shotgun = guiGet("rbot.accuracy.weapon.shotgun.hitchance")
                    scout = guiGet("rbot.accuracy.weapon.scout.hitchance")
                    lmg = guiGet("rbot.accuracy.weapon.lmg.hitchance")

                    guiSet("rbot.accuracy.weapon.asniper.hitchance", math.floor(newHitchance:GetValue()))
                    guiSet("rbot.accuracy.weapon.sniper.hitchance", math.floor(newHitchance:GetValue()))
                    guiSet("rbot.accuracy.weapon.pistol.hitchance", math.floor(newHitchance:GetValue()))
                    guiSet("rbot.accuracy.weapon.hpistol.hitchance", math.floor(newHitchance:GetValue()))
                    guiSet("rbot.accuracy.weapon.smg.hitchance", math.floor(newHitchance:GetValue()))
                    guiSet("rbot.accuracy.weapon.rifle.hitchance", math.floor(newHitchance:GetValue()))
                    guiSet("rbot.accuracy.weapon.shotgun.hitchance", math.floor(newHitchance:GetValue()))
                    guiSet("rbot.accuracy.weapon.scout.hitchance", math.floor(newHitchance:GetValue()))
                    guiSet("rbot.accuracy.weapon.lmg.hitchance", math.floor(newHitchance:GetValue()))
                    toggle = 0;
            elseif (toggle%2 == 1) then
                guiSet("rbot.accuracy.weapon.asniper.hitchance", auto)
                guiSet("rbot.accuracy.weapon.sniper.hitchance", sniper)
                guiSet("rbot.accuracy.weapon.pistol.hitchance", pistol)
                guiSet("rbot.accuracy.weapon.hpistol.hitchance", revolver)
                guiSet("rbot.accuracy.weapon.smg.hitchance", smg)
                guiSet("rbot.accuracy.weapon.rifle.hitchance", rifle)
                guiSet("rbot.accuracy.weapon.shotgun.hitchance", shotgun)
                guiSet("rbot.accuracy.weapon.scout.hitchance", scout)
                guiSet("rbot.accuracy.weapon.lmg.hitchance", lmg)
                toggle = 1;
            end
    end
end
callbacks.Register("Draw", "changehcMain", changehcMain);