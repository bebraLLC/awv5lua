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



local last_a, last_d = 0
callbacks.Register("CreateMove", function(cmd)
    local flags = entities.GetLocalPlayer():GetPropInt("m_fFlags")
    if flags == nil then return end
      
    if (input.IsButtonDown(65) and input.IsButtonDown(68)) then
        if(last_a ~= nil and last_d ~= nil) then
            if(last_d < last_a) then
                cmd.sidemove = 450
            elseif(last_d > last_a) then
                cmd.sidemove = -450
            end
        end
        return
    end
   
    if (input.IsButtonDown(65)) then
        last_a = globals.CurTime()
    end

    if (input.IsButtonDown(68)) then
        last_d = globals.CurTime()
    end
end)