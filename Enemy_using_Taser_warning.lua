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



local warning = gui.Checkbox( gui.Reference( "Visuals", "Overlay", "Enemy" ), "vis.taserwarning", "Taserwarning", 0 )
local function drawEspHook(builder)
if warning:GetValue() then
        local lp = entities.GetLocalPlayer();
        local pe = builder:GetEntity();
        if pe:IsPlayer() and pe:IsAlive() and pe:GetTeamNumber() ~= lp:GetTeamNumber() and pe:GetWeaponID() == 31 then
                builder:Color(255, 0, 0)
                builder:AddTextTop("TASER")
            else
            return
        end
    end
end

callbacks.Register( 'DrawESP', drawEspHook )