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



local font = draw.CreateFont("Verdana", 32, 900)
local x, y = draw.GetScreenSize()
--local x = 1280 -- startposition scrolling text (0 = left  max = right)
local y = 0

function main()
  -- x, y = draw.GetScreenSize()
	 if(x < -500)then
        x = 1300
    end
    x = x  -1
    draw.SetFont(font)
    draw.Color(255, 0, 0, 255)
    draw.Text(x , 0, "AIMWARE ")
	draw.Color(255, 255, 255, 255)
    draw.Text(x+158 , 0, "4EVER")
	draw.Color(255, 0, 0, 255)
    draw.Text(x+251 , 0, " | ")
	draw.Color(255, 255, 255, 255)
    draw.Text(x+280 , 0, "Polak")
	draw.Color(255, 0, 0, 255)
    draw.Text(x+360 , 0, " beste")

end

callbacks.Register("Draw", "killme", main)