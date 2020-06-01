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



local duck_toggled = false
local temp_crouches = {}

local toggle_key = gui.Keybox(gui.Reference("Misc", "Movement", "Other"), "ToggleDuck.key", "Toggle duck", 17)

callbacks.Register("Draw", function()
    if input.IsButtonReleased(toggle_key:GetValue()) then

        if duck_toggled then
            duck_toggled = false
            temp_crouches = {}
            return
        end

        table.insert(temp_crouches, globals.CurTime())
    end
    if #temp_crouches == 1 then
        if globals.CurTime() - temp_crouches[1] > 1 then
            temp_crouches = {}
        end
    elseif #temp_crouches >= 2 then
        local delay_between_in_presses = temp_crouches[2] - temp_crouches[1]
        if delay_between_in_presses < 0.5 then
            duck_toggled = true
        end
        temp_crouches = {}
    end


end)

callbacks.Register("CreateMove", function(cmd)
    if duck_toggled then
        local buttons = bit.bor(cmd.buttons, 4)
        cmd.buttons = buttons
        return
    end
end)