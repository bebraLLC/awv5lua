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



local ref = gui.Reference("Misc", "Enhancement", "Fakelag")
local dt_setting1 = gui.Combobox( ref, "dt.switch1", "DT Base Setting", "Off", "Shift" , "Rapid")
local dt_setting2 = gui.Combobox( ref, "dt.switch2", "DT Key Setting", "Off", "Shift" , "Rapid")
local dt_keybox = gui.Keybox( ref, "dt.key", "Doubletap Switch Key", 0)
local dt_keya = gui.GetValue("misc.fakelag.dt.key")

local function dt_key_switch()
    local dt_keya = gui.GetValue("misc.fakelag.dt.key")
    local dt_set1 = gui.GetValue("misc.fakelag.dt.switch1")
    local dt_set2 = gui.GetValue("misc.fakelag.dt.switch2")
    if input.IsButtonDown(dt_keya) then
        gui.SetValue("rbot.accuracy.weapon.asniper.doublefire", dt_set2)
    else
        gui.SetValue("rbot.accuracy.weapon.asniper.doublefire", dt_set1)
    end
end
callbacks.Register( "Draw", dt_key_switch)