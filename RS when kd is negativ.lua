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



-- RESET SCORE WHEN K/D IS NEGATIV

local function rs( Event ) 
    if ( Event:GetName() == 'player_death' ) then     
        local ME = client.GetLocalPlayerIndex();
        local INT_UID = Event:GetInt( 'userid' );
       local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );
        
        if (INDEX_Victim == ME) then
        local m_iKills = entities.GetPlayerResources():GetPropInt("m_iKills", client.GetLocalPlayerIndex())
        local m_iDeaths = entities.GetPlayerResources():GetPropInt("m_iDeaths", client.GetLocalPlayerIndex())
        local kd = m_iKills / m_iDeaths;
            
			chatmsg = string.format( "!rs" )	
			
			if (kd < 1) then
                client.ChatSay(chatmsg)
            end
        end        
    end 
end 

client.AllowListener( 'player_death' ); 
callbacks.Register( 'FireGameEvent', 'rs', rs );

----- End RESET SCORE WHEN K/D IS NEGATIV

