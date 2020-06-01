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



--[[
    ███▄▄▄▄      ▄████████  ▄███████▄     ▄████████
    ███▀▀▀██▄   ███    ███ ██▀     ▄██   ███    ███
    ███   ███   ███    ███       ▄███▀   ███    █▀
    ███   ███   ███    ███  ▀█▀▄███▀▄▄  ▄███▄▄▄   
    ███   ███ ▀███████████   ▄███▀   ▀ ▀▀███▀▀▀   
    ███   ███   ███    ███ ▄███▀         ███    █▄
    ███   ███   ███    ███ ███▄     ▄█   ███    ███
     ▀█   █▀    ███    █▀   ▀████████▀   ██████████
                                                    --]]

--indicator:https://aimware.net/forum/thread-130899.html?

local DT_REF = gui.Reference( "RAGEBOT", "Accuracy", "Weapon" )
local BETTERCHAMS_TAB = gui.Tab(gui.Reference("RAGEBOT"), "ragebot.doubletap.tab", "Doubletap on key")
local DT_GB = gui.Groupbox(gui.Reference("RAGEBOT", "Doubletap on key"), "Settings", 15, 15, 600, 600)
local selectMode = gui.Combobox( DT_GB, "ragebot.doubletap.mode", "Mode", "Off", "Hold", "Toggle")
local selectInterval = gui.Combobox( DT_GB, "ragebot.doubletap.interval", "Interval", "Off", "Shift", "Rapid", "Rapid (Fast Charge)")
local selectWeapon = gui.Combobox( DT_GB, "ragebot.doubletap.weapon", "Weapon", "Autosniper", "Pistols", "Rifles", "SMG", "LMG", "Heavy Pistol" )
local setKey = gui.Keybox( DT_GB, "ragebot.doubletap.key", "Doubletap key", 0 )
local pressed = false;

local LocalPlayerEntity = entities.GetLocalPlayer()
local weapons = {

[0] = "asniper",
[1] = "pistol",
[2] = "rifle",
[3] = "smg",
[4] = "lmg",
[5] = "hpistol"

}

local function mainFunction()
if setKey:GetValue() == 0 then
return
end
if setKey:GetValue() ~= 0 and selectMode:GetValue() ~= 0 and selectInterval:GetValue() ~= 0 then     
if input.IsButtonDown(gui.GetValue( "rbot.ragebot.doubletap.tab.ragebot.doubletap.key" ) ) and selectInterval:GetValue() == 1 then
gui.SetValue( "rbot.accuracy.weapon." .. (weapons[selectWeapon:GetValue()]) .. ".doublefire", 1 )
end
if input.IsButtonDown(gui.GetValue( "rbot.ragebot.doubletap.tab.ragebot.doubletap.key" ) ) and selectInterval:GetValue() == 2 then
    gui.SetValue( "rbot.accuracy.weapon." .. (weapons[selectWeapon:GetValue()]) .. ".doublefire", 2 )
end
if input.IsButtonDown(gui.GetValue( "rbot.ragebot.doubletap.tab.ragebot.doubletap.key" ) ) and selectInterval:GetValue() == 3 then
    gui.SetValue( "rbot.accuracy.weapon." .. (weapons[selectWeapon:GetValue()]) .. ".doublefire", 3 )
    end
if not input.IsButtonDown(gui.GetValue( "rbot.ragebot.doubletap.tab.ragebot.doubletap.key" ) )  then
    gui.SetValue( "rbot.accuracy.weapon." .. (weapons[selectWeapon:GetValue()]) .. ".doublefire", 0 )
end                   
end

if setKey:GetValue() ~= 0 and selectMode:GetValue() == 2 and selectInterval:GetValue() ~= 0 then
if input.IsButtonPressed(setKey:GetValue()) then toggle = not toggle
end   
if toggle and selectInterval:GetValue() == 1 then
    gui.SetValue( "rbot.accuracy.weapon." .. (weapons[selectWeapon:GetValue()]) .. ".doublefire", 1 )
end
if toggle and selectInterval:GetValue() == 2 then
    gui.SetValue( "rbot.accuracy.weapon." .. (weapons[selectWeapon:GetValue()]) .. ".doublefire", 2 )
end
if toggle and selectInterval:GetValue() == 3 then
    gui.SetValue( "rbot.accuracy.weapon." .. (weapons[selectWeapon:GetValue()]) .. ".doublefire", 3 )
if not toggle then
    gui.SetValue( "rbot.accuracy.weapon." .. (weapons[selectWeapon:GetValue()]) .. ".doublefire", 0 )   
end   
end
end

if LocalPlayerEntity then
    local screenW, screenH = draw.GetScreenSize()
    if gui.GetValue( "rbot.accuracy.weapon." .. (weapons[selectWeapon:GetValue()]) .. ".doublefire") ~= 0 then
        draw.Color(124, 176, 34)
    else
        draw.Color(255, 25, 25)
    end
    draw.SetFont( draw.CreateFont("Verdana", 30, 2000) )
    draw.TextShadow(10, screenH - 250, "DT" )
end
end

callbacks.Register( 'Draw', mainFunction )        