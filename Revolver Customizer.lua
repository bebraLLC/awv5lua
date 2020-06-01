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



local ref = gui.Reference("RAGEBOT", "AIMBOT", "Automation")
local cb = gui.Checkbox(ref, "rbot_revolver_autocock_ex", "Custom Auto-Revolver", false)
local cockspeed = gui.Slider(ref, "rbot_revolver_autocock_ex_speed", "Auto-Revolver speed", 15, 1, 50)
local delay = gui.Slider(ref, "rbot_revolver_autocock_ex_delay", "Auto-Revolver delay", 6, 0, 50)

local function on_create_move(cmd)
   local me = entities.GetLocalPlayer()
   if cb:GetValue() and me ~= nil and me:GetHealth() > 0 then
       if bit.band(cmd:GetButtons(), bit.lshift(1, 0)) > 0 then
           return
       end

       local wep = me:GetPropEntity("m_hActiveWeapon")

       if wep:GetClass() == "CDEagle" and wep:GetWeaponID() == 64 then
           cmd:SetButtons(bit.bor(cmd:GetButtons(), bit.lshift(1, 0)))

           local m_flPostponeFireReadyTime = wep:GetPropFloat("m_flPostponeFireReadyTime")
           if m_flPostponeFireReadyTime > 0 and m_flPostponeFireReadyTime - (cockspeed:GetValue() / 100) < globals.CurTime() then
               cmd:SetButtons(bit.band(cmd:GetButtons(), bit.bnot(bit.lshift(1, 0))))

               if m_flPostponeFireReadyTime + globals.TickInterval() * 16 + (delay:GetValue() / 100) > globals.CurTime() then
                    cmd:SetButtons(bit.bor(cmd:GetButtons(), bit.lshift(1, 11)))
               end
           end
       end
   end
end

callbacks.Register("CreateMove", on_create_move)