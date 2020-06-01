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



-- Crosshair_black_n_white

local VISUALz = gui.Reference('VISUALS', 'Other', 'Extra')
local visualtabmisc = gui.Text(VISUALz, "Choose a Custom Crosshair")
local basicbitch_crosshair = gui.Checkbox( VISUALz, "msc_basicbitch", "Black n White MiniCrosshair", 0)
function basicbitchxhair()
if not basicbitch_crosshair:GetValue() then return end;
        if entities.GetLocalPlayer() == nil then end;
    if basicbitch_crosshair:GetValue() then
        local screencenter2X, screencenter2Y = draw.GetScreenSize() --getting the full screensize
        screencenter2X = screencenter2X / 2; screencenter2Y = screencenter2Y / 2 --dividing the screensize by 2 will place it perfectly in the center whatever resolution
        draw.Color( 255, 255, 255, 255)
        draw.RoundedRect(screencenter2X+1 , screencenter2Y+1 , screencenter2X-1, screencenter2Y-1)
        draw.Color( 0, 0,0, 255)
        draw.RoundedRect(screencenter2X , screencenter2Y , screencenter2X, screencenter2Y)
end
end
callbacks.Register( "Draw", basicbitchxhair)

