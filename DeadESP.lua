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



-- DeadESP
local w,h = 0,0
local rage_ref_extra = gui.Reference("VISUALS");
local deadesp_tab = gui.Tab(rage_ref_extra, "deadesp.tab", "DeadESP")
local deadesp_group = gui.Groupbox(deadesp_tab, "Deadesp")
local deadespwallhack = gui.Keybox(deadesp_group, "wallhackkey", "DeadESP Wallhackkey", false); 		-- Set wallhack-key and hold the key to enable enemy.occluded chams aka Wallhack
local DeadESPchamstggl = gui.Combobox(deadesp_group, 'lua_deadesptgglchams_combobox', 'DeadESP Chams when toggle', 'Off', 'Flat', 'Color', 'Metallic', 'Glow' )	-- Change Wallhack ChamsMode onthefly
local DeadESPchams_while_spec = gui.Combobox(deadesp_group, 'lua_deadespchams_while_spec_combobox', 'DeadESP Chams while Spectating', 'Off', 'Flat', 'Color', 'Metallic', 'Glow' )	-- Change Wallhack ChamsMode onthefly


local function ESP_Always_OnDead( ) 

w, h = draw.GetScreenSize()

	if entities.GetLocalPlayer() == nil or NULL then
			return
			

	else if (deadespwallhack:GetValue() ~= 0) then		
		 if entities.GetLocalPlayer():IsAlive() == true and input.IsButtonDown(deadespwallhack:GetValue()) then
				gui.SetValue("esp.chams.enemy.occluded", DeadESPchamstggl:GetValue())
				draw.Color(128,0,0,255)
				draw.Text(15, 560, "Visuals On")
	
	elseif entities.GetLocalPlayer():IsAlive() == true and not input.IsButtonDown(deadespwallhack:GetValue()) then
            
			gui.SetValue("esp.overlay.enemy.name", false)
            gui.SetValue("esp.chams.enemy.occluded", false)
			gui.SetValue("esp.chams.enemy.visible", "2")
			gui.SetValue("esp.chams.enemy.overlay", false)
			gui.SetValue("esp.chams.enemyattachments.occluded", false)
			gui.SetValue("esp.chams.enemyattachments.visible", false)
			gui.SetValue("esp.chams.enemyattachments.overlay", false)
			gui.SetValue("esp.chams.friendlyattachments.occluded", false)
			gui.SetValue("esp.chams.friendlyattachments.visible", false)
			gui.SetValue("esp.chams.friendlyattachments.overlay", false)
            gui.SetValue("esp.overlay.enemy.scoped", false)
            gui.SetValue("esp.overlay.enemy.reloading", false)
            gui.SetValue("esp.overlay.enemy.health.healthnum", false)
            gui.SetValue("esp.overlay.enemy.health.healthbar", false)
            gui.SetValue("esp.overlay.enemy.weapon", false)
            gui.SetValue("esp.overlay.enemy.box", false)
            gui.SetValue("esp.overlay.enemy.hasdefuser", false)
            gui.SetValue("esp.overlay.enemy.hasc4", false)
			gui.SetValue("esp.overlay.weapon.ammo", false)
            gui.SetValue("esp.overlay.enemy.barrel", false)
			gui.SetValue("esp.overlay.enemy.armor", false)
			
	
	elseif entities.GetLocalPlayer():IsAlive() == false then

            gui.SetValue("esp.overlay.enemy.name", true)
            gui.SetValue("esp.chams.enemy.occluded", DeadESPchams_while_spec:GetValue())
			gui.SetValue("esp.chams.enemy.visible", "2")
			gui.SetValue("esp.chams.enemy.overlay", "1")
			gui.SetValue("esp.chams.enemyattachments.occluded", false)
			gui.SetValue("esp.chams.enemyattachments.visible", false)
			gui.SetValue("esp.chams.enemyattachments.overlay", false)
            gui.SetValue("esp.chams.friendlyattachments.occluded", false)
			gui.SetValue("esp.chams.friendlyattachments.visible", false)
			gui.SetValue("esp.chams.friendlyattachments.overlay", false)
			gui.SetValue("esp.overlay.enemy.scoped", false)
            gui.SetValue("esp.overlay.enemy.reloading", false)
            gui.SetValue("esp.overlay.enemy.health.healthnum", false)
            gui.SetValue("esp.overlay.enemy.health.healthbar", true)
			gui.SetValue("esp.overlay.enemy.weapon", "1")
            gui.SetValue("esp.overlay.enemy.box", false)
            gui.SetValue("esp.overlay.enemy.hasdefuser", true)
            gui.SetValue("esp.overlay.enemy.hasc4", true)
            gui.SetValue("esp.overlay.enemy.barrel", false)
			gui.SetValue("esp.overlay.enemy.armor", "1")

			end
		end			
	end
end

callbacks.Register( "Draw", "espalwaysondead", ESP_Always_OnDead );

-- End DeadESP
