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



local weapon_dt = {"pistol", "smg", "rifle", "shotgun", "asniper", "lmg",};
local curr_dt, history = false, false;

callbacks.Register("CreateMove", "dt check", function()
    if weapon_dt[entities.GetLocalPlayer():GetWeaponType()] == nil then return; end;
    curr_dt = gui.GetValue("rbot.accuracy.weapon." .. weapon_dt[entities.GetLocalPlayer():GetWeaponType()] .. ".doublefire") ~= 0;
    if curr_dt == true then
        history = true;
        gui.SetValue("misc.fakelag.enable", 0);
    elseif curr_dt == false and history == true then
        if math.sqrt(entities.GetLocalPlayer():GetPropFloat( "localdata", "m_vecVelocity[0]" )^2 + entities.GetLocalPlayer():GetPropFloat( "localdata", "m_vecVelocity[1]" )^2) == 0 then
            gui.SetValue("misc.fakelag.enable", 1);
            history = false;
        end;
    end;
end);