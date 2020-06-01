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



desyncplus 185 160 true
desyncplus.basedirection.basevalue 180.0
desyncplus.basedirection.maxslider 24.0
desyncplus.basedirection.minslider -20.0
desyncplus.basedirection.state "Standing"
desyncplus.basedirection.type "Jitter"
desyncplus.fakelag.maxslider 2.0
desyncplus.fakelag.minslider 2.0
desyncplus.fakelag.speed 1.0
desyncplus.fakelag.type "Off"
desyncplus.lby.maxslider 42.0
desyncplus.lby.minslider -44.0
desyncplus.lby.speed 22.0
desyncplus.lby.type "Jitter"
desyncplus.lby.value 54.0
desyncplus.misc.invertbasedir "Off"
desyncplus.misc.invertindicator "On"
desyncplus.misc.invertkey 18
desyncplus.misc.invertlby "On"
desyncplus.misc.invertonenemyshot "Off"
desyncplus.misc.invertonhurt "On"
desyncplus.misc.invertonselfshot "Off"
desyncplus.misc.invertrotation "On"
desyncplus.misc.masterswitch "On"
desyncplus.rotation.maxslider 0.0
desyncplus.rotation.minslider 0.0
desyncplus.rotation.speed 1.0
desyncplus.rotation.state "Air"
desyncplus.rotation.type "Off"
desyncplus.slowwalk.maxslider 31.0
desyncplus.slowwalk.minslider 1.0
desyncplus.slowwalk.speed 15.0
desyncplus.slowwalk.type "Jitter"
desyncplus.tab 
desyncplus.tab.extra.indicatorx 10.0
desyncplus.tab.extra.indicatory 870.0
rbot.antiaim.desyncplus.manual.back 40
rbot.antiaim.desyncplus.manual.left 37
rbot.antiaim.desyncplus.manual.right 39
rbot.antiaim.left 167.0 "Desync"
rbot.antiaim.left.lby 25.0
rbot.antiaim.left.rotation -55.0
rbot.antiaim.left.spinspeed 60.0
rbot.antiaim.right -167.0 "Desync"
rbot.antiaim.right.lby -25.0
rbot.antiaim.right.rotation 55.0
rbot.antiaim.right.spinspeed 60.0
rbot.lus_desyncplus_tab 
rbot.lus_desyncplus_tab.lua_desyncplus_configurate "Off"
settings 0 0 false
settings.bd.air.basevalue -90.0
settings.bd.air.maxvalue 38.0
settings.bd.air.minvalue -38.0
settings.bd.air.type "Off"
settings.bd.move.basevalue 180.0
settings.bd.move.maxvalue 24.0
settings.bd.move.minvalue -23.0
settings.bd.move.type "Off"
settings.bd.stand.basevalue 180.0
settings.bd.stand.maxvalue 24.0
settings.bd.stand.minvalue -20.0
settings.bd.stand.type "Jitter"
settings.rotation.air.cyclespeed 24.0
settings.rotation.air.maxvalue 41.0
settings.rotation.air.minvalue -42.0
settings.rotation.air.type "Jitter"
settings.rotation.move.cyclespeed 24.0
settings.rotation.move.maxvalue 19.0
settings.rotation.move.minvalue -26.0
settings.rotation.move.type "Jitter"
settings.rotation.stand.cyclespeed 24.0
settings.rotation.stand.maxvalue 24.0
settings.rotation.stand.minvalue -12.0
settings.rotation.stand.type "Jitter"

