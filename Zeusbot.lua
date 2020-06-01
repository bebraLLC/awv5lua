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



-------------------- Zeusbot
local zeusbot = gui.Checkbox(gui.Reference("Legitbot", "Other", "Extra"), "enable_zeusbot_chkbox", "Enable Zeusbot", 0)
zeusbot:SetDescription("Enable Zeus Triggerbot")
local function zeuslegit()
if not zeusbot:GetValue() or entities.GetLocalPlayer() == nil then 
return 
end

local Weapon = entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon") 
if Weapon == nil then 
return 
end

local CWeapon = Weapon:GetClass() 
local trige, trigaf, trighc = gui.GetValue("lbot.trg.enable"), gui.GetValue("lbot.trg.autofire"), gui.GetValue("lbot.trg.zeus.hitchance")

if trige ~= 1 and trigaf ~= 1 and trighc ~= gui.GetValue("rbot.accuracy.weapon.zeus.hitchance") then 
trige2, trigaf2, trighc2 = gui.GetValue("lbot.trg.enable"), gui.GetValue("lbot.trg.autofire"), gui.GetValue("lbot.trg.zeus.hitchance") 
end

if CWeapon == "CWeaponTaser" then 
gui.SetValue("lbot.trg.enable", 1) 
gui.SetValue("lbot.trg.autofire", 1) 
gui.SetValue("lbot.trg.zeus.hitchance", gui.GetValue("rbot.accuracy.weapon.zeus.hitchance"))
else 
gui.SetValue("lbot.trg.enable", trige2) 
gui.SetValue("lbot.trg.autofire", trigaf2) 
gui.SetValue("lbot.trg.zeus.hitchance", trighc2) 
end 
end

callbacks.Register("Draw", zeuslegit)
