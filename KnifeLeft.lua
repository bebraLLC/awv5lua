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



function on_knife_righthand(Event)    
     if (Event:GetName() ~= 'item_equip') then
        return;
     end

    if (client.GetLocalPlayerIndex() == client.GetPlayerIndexByUserID(Event:GetInt('userid'))) then
        if Event:GetString('item') == "knife" then
            client.Command( "cl_righthand 0", true );
        else
            client.Command( "cl_righthand 1", true );
        end
    end
end

client.AllowListener('item_equip');
callbacks.Register("FireGameEvent", "on_knife_righthand", on_knife_righthand);