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



local main_font = draw.CreateFont("Verdana", 26);
local combo = gui.Combobox(gui.Reference( "MISC","Movement", "Jump"), 'msc_edgejump_vars','Long Jump Type','Normal', 'LJ Bind -forward', 'LJ Bind -back', 'LJ Bind -moveleft', 'LJ Bind -moveright')
local ljbind = gui.Checkbox(gui.Reference( "MISC","Movement", "Jump"), "lj_bind", "LJ Bind Edge Jump", true);
ljbind:SetDescription("Allows you to jump further with one unit extra height.")
local ui_checkbox = gui.Checkbox(gui.Reference( "Visuals", "Other", "Extra"), "lj_bind_status", "LJ Bind Status", false);

local edgejump = gui.GetValue("misc.edgejump");
callbacks.Register("CreateMove", function(cmd)
    
    if (ljbind:GetValue() ~= true) then
        return
    end
    local flags = entities.GetLocalPlayer():GetPropInt("m_fFlags")
    if flags == nil then return end
    
    local onground = bit.band(flags, 1) ~= 0

    
    if (not onground and input.IsButtonDown(edgejump)) then
        cmd:SetButtons( 86 )
        if (combo:GetValue() == 0) then
            return;
        end
            if (combo:GetValue() == 1) then
                client.Command("-forward", true)
                end
                
            if (combo:GetValue() == 2) then
                client.Command("-back", true)
                end
            if (combo:GetValue() == 3) then
                client.Command("-moveright", true)
                end
            if (combo:GetValue() == 4) then
                client.Command("-moveleft", true)
                end
        return
    end

end)

callbacks.Register("Draw", function()

    local x, y = draw.GetScreenSize( )
    local centerX = x / 2

    local lp = entities.GetLocalPlayer(); -- Get our local entity and check if its `nil`, If it's nil lets abort from here
        local flags = entities.GetLocalPlayer():GetPropInt("m_fFlags")
    if flags == nil then return end

    local onground = bit.band(flags, 1) ~= 0

    draw.SetFont(main_font)
        if  edgejump ~= 0 and input.IsButtonDown(edgejump)  then
            draw.Color(255, 255, 255, 255)
            draw.Text( centerX , y - 150, "lj")
        end
    if (onground) then return end
    if  edgejump ~= 0 and input.IsButtonDown(edgejump)  then
    draw.Color(30, 255, 109)
    draw.Text( centerX , y - 150, "lj")
    end
end)