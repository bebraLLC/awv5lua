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



local sorrytbl = {"am sorry that","am feeling sad after","am distressed because","am upset with myself because","have been diagnosed with depression because","am broken hearted that","apologize that","would like to apologize because","am quite remorseful because","am ashamed of myself because"};
local killtbl = {"killed","destroyed","put an end to","ended","assassinated","terminated","eliminated","executed","slaughtered","butchered","shot and killed"};
local regrettbl = {":(","Please forgive me","I didn't mean to.","I'm a failure","I will go easy on you next time.","That was my fault","Please excuse my behaviour"};

local function CHAT_KillSay( Event )

   if ( Event:GetName() == 'player_death' ) then

       local ME = client.GetLocalPlayerIndex();

       local INT_UID = Event:GetInt( 'userid' );
       local INT_ATTACKER = Event:GetInt( 'attacker' );

       local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
       local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );

       local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
       local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );

       if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then

           client.ChatSay(NAME_Victim  .. ", I " .. sorrytbl[math.random( #sorrytbl )] .. " I " .. killtbl[math.random( #killtbl )] .. " you. " .. regrettbl[math.random( #regrettbl )]);

       end

   end

end

client.AllowListener( 'player_death' );

callbacks.Register( 'FireGameEvent', 'AWKS', CHAT_KillSay );