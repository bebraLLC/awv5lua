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



local GetLocalPlayer, IsButtonDown = entities.GetLocalPlayer, input.IsButtonDown
local r = gui.Reference('MISC', 'AUTOMATION', 'Other')
local enabled = gui.Checkbox(r, 'fast_plant', 'Fast Plant', false)
local hotkey = gui.Keybox(r, 'fast_plant_key', 'Fast Plant Key', 0) -- Don't make it "e" or "mouse 1"

callbacks.Register('CreateMove', function(cmd)
	if not enabled:GetValue() then
		return
	end

	local key = hotkey:GetValue()
	if key == 0 or not IsButtonDown( key ) then
		return
	end

	local lp = GetLocalPlayer()
	local weapon = lp:GetPropEntity('m_hActiveWeapon')
	local weapon = weapon ~= nil and weapon:GetClass() == 'CC4'
	local in_zone = weapon and lp:GetPropInt('m_bInBombZone') == 1
	local flag = lp:GetProp('m_fFlags')
	local in_air = flag == 256 or flag == 262

	if in_zone and not in_air then 
		cmd:SetButtons( (1 << 5) )
	end 
end)
