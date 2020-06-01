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



local ref = gui.Reference("Visuals","Local","Helper")
local check = gui.Checkbox(ref, "sniper.dot", "Sniper Dot", false)
local color = gui.ColorPicker(ref, "sniper.dot.color", "Sniper Dot Color", 127, 255, 0, 150)

local function is_holding_sniper(weapon)
    if (weapon == nil) then
        return false
    end
    local name = weapon:GetName()

    if (string.find(name, "awp") or string.find(name, "ssg08") or string.find(name, "g3sg1") or string.find(name, "scar20")) then
        return true
    end

    return false
end

callbacks.Register("Draw", function()
    local local_player = entities.GetLocalPlayer()
    if (local_player == nil) then return end
    if (not local_player:IsAlive()) then return end
    local weapon = entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon")
    if(weapon == nil) then return end
if check:GetValue() then
    if (is_holding_sniper(weapon)) then
        local w, h = draw.GetScreenSize()

        draw.Color(color:GetValue())
        draw.FilledCircle(w/2, h/2, 1)
    end
end
end)