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



local enable = gui.Checkbox(gui.Reference("VISUALS", "LOCAL", "HELPER"), 'pf_deadtp','Thirdperson while dead', false)

callbacks.Register("Draw", function()
    if enable:GetValue() then
	
	local me = entities.GetLocalPlayer();
	if not me then return
	end;

	if not me:IsAlive() then
		if me:GetPropEntity('m_iObserverMode') == 4 then
		me:SetProp('m_iObserverMode', 5)
       end
end
end	end);
