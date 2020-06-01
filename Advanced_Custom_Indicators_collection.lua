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




local function Main()

   if entities.GetLocalPlayer() == nil or not entities.GetLocalPlayer():IsAlive() then
        return
    end

local hc = gui.GetValue("rbot.accuracy.weapon.asniper.hitchance")    
local mindmg = gui.GetValue("rbot.accuracy.weapon.asniper.mindmg")   
local fakewalkkey = gui.GetValue("rbot.accuracy.movement.fakewalkkey")

add.IndicatorForKeybox("Fake Duck", "rbot.antiaim.enable", 2, true, 112, 255, 0, 255, 255, 0, 0, 255)
add.IndicatorForKeybox("Slow Walk", "rbot.accuracy.movement.fakewalkkey", 2, true, 112, 255, 0, 255, 255, 0, 0, 255)
--add.IndicatorForKeybox("IzyWallbang", "walldmgkey", 2, true, 112, 255, 0, 255, 255, 0, 0,255)        		
        		
--add.IndicatorForKeybox("EZWallbang", "rbot_wallbang_key", 2, true, 112, 255, 0, 255, 255, 0, 0,255)        		

  
	
	
end

RunScript("drawInfo.lua")

callbacks.Register( "Draw", "Main", Main);

