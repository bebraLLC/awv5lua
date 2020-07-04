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



local y_offset = gui.Slider(gui.Reference("Visuals","Local","Helper"), "simple.indicators.y.ind.offset", "Simple Indicators Y Offset", -70, -450, 450)
local screenX, screenY = draw.GetScreenSize()
local half_screenY = screenY / 2
local button_held = input.IsButtonDown
local font = draw.CreateFont("Tahoma", 20, 700)


callbacks.Register("Draw", function()
	if not entities.GetLocalPlayer() then
	return
	else

local hc = gui.GetValue("rbot.accuracy.weapon.asniper.hitchance")    
local mindmg = gui.GetValue("rbot.accuracy.weapon.asniper.mindmg")   
local fakeduckkey = gui.GetValue("rbot.antiaim.extra.fakecrouchkey")	
	
	draw.SetFont(font)
	
	if (gui.GetValue("rbot.antiaim.advanced.autodir") == true) then
        draw.Color(0,128,0,255)
        draw.TextShadow(16, half_screenY+15+y_offset:GetValue(), "FreeStand")
	else
        draw.Color(128,0,0,255)
		draw.TextShadow(16, half_screenY+15+y_offset:GetValue(), "FreeStand")
    end

	if (gui.GetValue("misc.fakelag.enable") == true) then
        draw.Color(0,128,0,255)
        draw.TextShadow(16, half_screenY+35+y_offset:GetValue(), "Fakelag")
	else
        draw.Color(128,0,0,255)
		draw.TextShadow(16, half_screenY+35+y_offset:GetValue(), "Fakelag")
    end

    if (gui.GetValue("rbot.master") == true) and (gui.GetValue("rbot.aim.key") == 0) then
        draw.Color(0,128,0,255)
        draw.TextShadow(16, half_screenY+55+y_offset:GetValue(), "AutoFire")
	else
        draw.Color(128,0,0,255)
		draw.TextShadow(16, half_screenY+55+y_offset:GetValue(), "AutoFire")
    end

	if (gui.GetValue("rbot.accuracy.weapon.asniper.hitchance") ~= nil) then  
        draw.Color(0,128,0,255)
		draw.TextShadow(16, half_screenY+75+y_offset:GetValue(), "HC % is")
        draw.Color(0,0,128,255)
		draw.TextShadow(88, half_screenY+75+y_offset:GetValue(), ''..hc)
	else
		draw.Color(0,0,128,255)
		draw.TextShadow(16, half_screenY+95+y_offset:GetValue(), "No Toggleble Gun")	
	end
	
	if (gui.GetValue("rbot.accuracy.weapon.asniper.mindmg") ~= nil) then  
        draw.Color(0,128,0,255)
		draw.TextShadow(16, half_screenY+95+y_offset:GetValue(), "MinDMG" )
	    draw.Color(0,0,128,255)
		draw.TextShadow(88, half_screenY+95+y_offset:GetValue(), ''..mindmg )
	else
		draw.Color(0,0,128,255)
		draw.TextShadow(16, half_screenY+95+y_offset:GetValue(), "No Toggleble Gun")
	end

	if button_held(fakeduckkey) == true then
		draw.Color(0,128,0,255)
		draw.TextShadow(16, half_screenY+115+y_offset:GetValue(), "Fakeduckin" )
	else
	    draw.Color(128,0,0,255)
		draw.TextShadow(16, half_screenY+115+y_offset:GetValue(), "Fakeduckin" )
	end 
	end
end)
	
-- lua created by soar#9999

-- skeet font
local light_font = draw.CreateFont("Tahoma", 27, 600);

local function doubletap_indicator(pos)

	draw.SetFont(light_font)

	if gui.GetValue("rbot.accuracy.weapon.asniper.doublefire") > 0 then
		draw.Color(130, 180, 0)
	else
		draw.Color(233, 4, 4)
	end

	draw.TextShadow(10, 985 + (pos * 25), "DT")
end

local function fake_indicator(pos)
	
	local pLocalPlayer = entities.GetLocalPlayer();

 	local vx = pLocalPlayer:GetPropFloat("localdata", "m_vecVelocity[0]")
   	local vy = pLocalPlayer:GetPropFloat("localdata", "m_vecVelocity[1]")
	
	local velocity = math.floor(math.min(10000, math.sqrt(vx*vx + vy*vy) + 0.5))

	draw.SetFont(light_font)

	if velocity < 1 and not input.IsButtonDown(0x20) then
		draw.Color(130, 180, 0)
	else
		draw.Color(141, 153, 0)
	end

	if input.IsButtonDown(0x20) then
		draw.Color(233, 4, 4)
	end

	draw.TextShadow(10, 985 + (pos * 25), "FAKE")
end


callbacks.Register( "Draw", function()
	
	local pLocalPlayer = entities.GetLocalPlayer();

	if pLocalPlayer == nil then
	return;
	end

	if not pLocalPlayer:IsAlive() then
	return;
	end
	
	local flags = pLocalPlayer:GetPropInt("m_fFlags")
 	local onground = bit.band(flags, 1) ~= 0

	local vx = pLocalPlayer:GetPropFloat("localdata", "m_vecVelocity[0]")
   	local vy = pLocalPlayer:GetPropFloat("localdata", "m_vecVelocity[1]")
	local velocity = math.floor(math.min(10000, math.sqrt(vx*vx + vy*vy) + 0.5))

	if not input.IsButtonDown(0x20) or velocity < 220 then
		doubletap_indicator(0);	
		fake_indicator(1);
	else
		if velocity > 220 and input.IsButtonDown(0x20) then
			doubletap_indicator(0);	
			fake_indicator(1);	
			lc_indicator(1);
		end
	end
end)