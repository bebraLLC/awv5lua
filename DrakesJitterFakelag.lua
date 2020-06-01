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



local ref = gui.Reference("Misc", "Enhancement")

-- BOXES
local main_box = gui.Groupbox(ref, " JitterFakelag Settings",328, 321, 296, 400);


--sliders
local limit = gui.Slider(main_box, "limit", "Limit", 0, 0, 8);
local freq = gui.Slider(main_box, "frequency", "Frequency", 0, 1, 100);
local center = gui.Slider(main_box, "center", "Center", 0, 2, 17);


--vars

local function jitter_fakelag()
	maths = (gui.GetValue("misc.limit") * math.cos((globals.RealTime()) / (gui.GetValue("misc.frequency")*(0.01)))+ gui.GetValue("misc.center"));
	gui.SetValue("misc.fakelag.factor", maths)
end


callbacks.Register("Draw", jitter_fakelag);