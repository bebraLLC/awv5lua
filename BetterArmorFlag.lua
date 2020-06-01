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



local ui_ref = gui.Reference("Visuals", "Overlay", "Enemy", "Armor");
local ui_armor = {
    gui.Checkbox(ui_ref, "armor_enable", "Flag", false),
    gui.Checkbox(ui_ref, "armor_lack", "Only Show Lack", false),
};
callbacks.Register("DrawESP", function(builder)
    if ui_armor[1]:GetValue() == false or entities.GetLocalPlayer() == nil then return; end; local pEntity = builder:GetEntity();
    if pEntity:GetIndex() ~= entities.GetLocalPlayer():GetIndex() and pEntity:GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber() and pEntity:IsPlayer() then
        local flagHK = "";
        if ui_armor[2]:GetValue() then
            if (pEntity:GetPropInt("m_ArmorValue") == 0) then flagHK = "∅HK";
            else flagHK = (pEntity:GetPropInt("m_bHasHelmet") == 0 and "∅H" or ""); end;
        else
            if (pEntity:GetPropInt("m_bHasHelmet") == 1) then flagHK = "HK";
            else flagHK = ((pEntity:GetPropInt("m_ArmorValue") > 0) and "K" or ""); end;
        end;
	    builder:AddTextRight(flagHK);
end; end);