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



local all_says = {
    hegrenade = {
        'Catch retard!',
		'Here, a hot Portato!'
    },

    flashbang = {
        'Look a bird!',
		'3, 2, 1, Cheeeese'
    },

    molotov = {
        'BURN BABY BURN!!!',
		'Barbecue Time'
    },

    smokegrenade = {
        'I am a ninja',
		'Hide and seek, just wait, i´m comin'
    },

    incgrenade = {
        'BURN BABY BURN!!!',
		'Barbecue Time'
    },
	
	decoy = {
		'Time to pFake'
	}
}

local function throw_say(e)
    if e:GetName() ~= 'grenade_thrown' then
        return
    end

    if client.GetPlayerIndexByUserID(e:GetInt('userid')) ~= client.GetLocalPlayerIndex() then
        return
    end

    local says = all_says[e:GetString('weapon')]
    client.ChatSay( says[math.random(#says)] )
end

client.AllowListener('grenade_thrown')
callbacks.Register('FireGameEvent', throw_say)