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



local LUA_menu_MISC = gui.Reference("SETTINGS", "MISCELLANEOUS")
gui.Text(LUA_menu_MISC, "	")
local LUA_sun_mover = gui.Groupbox(LUA_menu_MISC, "~ Sun Position Manipulator ~")
local sunmove_enable = gui.Checkbox(LUA_sun_mover, "Lua_sun_enable", "Lua_sun_enable", 0)
local LUA_sun_slider_x = gui.Slider(LUA_sun_mover, "LUA_sun_slider_x", "Sun Controll X", 0, -180, 180)
local LUA_sun_slider_y = gui.Slider(LUA_sun_mover, "LUA_sun_slider_y", "Sun Controll Y", 0, -180, 180)
local LUA_sun_slider_z = gui.Slider(LUA_sun_mover, "LUA_sun_slider_z", "Sun Controll Z", 0, -180, 180)
local sun
local controll_x
local controll_y
local controll_z
local function sun_stuff()
if (sunmove_enable:GetValue() == true) then

  sun = entities.FindByClass("CCascadeLight")[1]
   if sun ~= nil then
      controll_x = gui.GetValue("LUA_sun_slider_x")
      controll_y = gui.GetValue("LUA_sun_slider_y")
      controll_z = gui.GetValue("LUA_sun_slider_z")
      sun:SetPropVector({controll_x,controll_y,controll_z},"m_envLightShadowDirection")
end

else
return
end
end

callbacks.Register("Draw", sun_stuff)