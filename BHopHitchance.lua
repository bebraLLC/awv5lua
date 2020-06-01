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



-- BHop Hitchance by stacky

local SLIDER = gui.Slider( gui.Reference( "Misc", "Movement", "Jump" ), "hitchance", "Hit Chance", 100, 0, 100 )
callbacks.Register( "CreateMove", function(cmd)
    if (gui.GetValue( "misc.autojump" ) ~= '"Off"' or bit.band(cmd.buttons, 2) == 0 or
        bit.band(entities.GetLocalPlayer():GetPropInt("m_fFlags"), 1) == 0 or math.random(1, 100) >= SLIDER:GetValue()) then return end
    cmd.buttons = cmd.buttons - 2
end )