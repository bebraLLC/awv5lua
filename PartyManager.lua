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



--[[
	Title: PartyManager
	Author: w1nter#4947
	Version: 1.0
]]--

-- GUI references and localization of party table.
local party = {}
local group = gui.Groupbox(gui.Reference("Misc", "General"), "Party Manager", 16, 472, 296, 325)
local input = gui.Editbox(group, friendCode, "Friend Code")

-- Button to grab input from editbox and insert it into the party table.
gui.Button(group, "Add to Party", function()
	table.insert(party, input:GetValue())
	panorama.RunScript([[
		var xuid = FriendsListAPI.GetXuidFromFriendCode("]]..input:GetValue()..[[");
		var name = FriendsListAPI.GetFriendName(xuid);
		$.Msg(`Added \"${name}\" to the party.`);
	]])
end)

-- Button tp print all added friend codes to game console.
gui.Button(group, "Print Members", function()
	for k, v in pairs(party) do
		panorama.RunScript([[
			var xuid = FriendsListAPI.GetXuidFromFriendCode("]]..party[k]..[[");
			var name = FriendsListAPI.GetFriendName(xuid);
			$.Msg(`${name}: ]]..party[k]..[[`);
		]])
	end
end)

-- Button to invite all added friend codes to game lobby.
gui.Button(group, "Invite Members", function()
	for k, v in pairs(party) do
		panorama.RunScript([[
			var xuid = FriendsListAPI.GetXuidFromFriendCode("]]..party[k]..[[");
			var name = FriendsListAPI.GetFriendName(xuid);
			if(LobbyAPI.IsSessionActive() == false) {
				LobbyAPI.CreateSession();
			}
			FriendsListAPI.ActionInviteFriend(xuid, '');
			$.Msg(`Invited \"${name}\" to the lobby.`);
		]])
	end
end)