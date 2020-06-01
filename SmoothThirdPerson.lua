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



local activeTP = {};
local currentTP = gui.GetValue("esp.local.thirdpersondist" )
local function add(time, ...)
    table.insert(activeTP, {
        ["time"] = time,
        ["delay"] = globals.RealTime() + time,
        ["tp"] = 0,
    })
end
local function showtp(count, player)
    local nd = currentTP
    if globals.RealTime() < player.delay then
            if player.tp < nd then player.tp = player.tp + (nd - player.tp) * 0.08 end
            if player.tp > nd then player.tp = nd end
            gui.SetValue("esp.local.thirdpersondist", player.tp )
    else
            table.remove(activeTP, count)
    end
end
callbacks.Register('Draw', function()
    if (input.IsButtonPressed(gui.GetValue("esp.local.thirdpersonkey" ))) then
        add(1)
    end
    for index, hittp in pairs(activeTP) do
        showtp(index, hittp)
    end
end);
