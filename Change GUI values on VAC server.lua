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



local GetServerIP, SetValue = engine.GetServerIP, gui.SetValue
local set_0 = false

local vars = {
    'rab_autobuy_masterswitch',
    'lua_fakelag_moving',
    'lua_fakelag_inair',
}

local function applyServerID()
local server_ip = GetServerIP()

  if (engine.GetServerIP() ~= nil and engine.GetMapName() ~= nil) then

    if not server_ip:find('A:') then
		return
else
        if not set_0 then
            for i=1, #vars do SetValue(vars[i], 0) end
            set_0 = true
        
    elseif set_0 then
            for i=1, #vars do SetValue(vars[i], 1) end
            set_0 = false
        end end end
    end
end

callbacks.Register('Draw', applyServerID)