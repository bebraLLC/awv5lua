-- DeadESP (This version only works with the default Chams provided by Aimware.net; not working with AdvancedChams or others atm)

local w,h = 0,0
ScreenSize = draw.GetScreenSize()
get = gui.GetValue()
set = gui.SetValue()
player = entities.GetLocalplayer()
color = draw.Color
text = draw.TextShadow

local visual_refs = gui.Reference("VISUALS");
local deadesp_tab = gui.Tab(visual_refs, "deadesp.tab", "DeadESP")
local deadesp_group = gui.Groupbox(deadesp_tab, "DeadESP")
local deadesp_wallhack_key = gui.Keybox(deadesp_group, "wallhackkey", "DeadESP Holdkey", false); 		-- Box to set a hold-key to enable enemy.occluded chams aka Wallhack
deadesp_wallhack_key:SetDescription("Turn on Chams thru Wallz while alive");
local deadesp_chams_on_tggl = gui.Combobox(deadesp_group, 'deadespontgglchams_combobox', 'DeadESP Chams on hold', 'Off', 'Flat', 'Color', 'Metallic', 'Glow' )	-- Box to change WallhackChams Mode onthefly
deadesp_chams_on_tggl:SetDescription("Chams used for Wallhack on hold")
local deadesp_chams_while_spec = gui.Combobox(deadesp_group, 'deadesp_chams_while_spec_combobox', 'DeadESP Chams while Spectating', 'Off', 'Flat', 'Color', 'Metallic', 'Glow' )	-- Change Wallhack ChamsMode onthefly
deadesp_chams_while_spec:SetDescription("Chams used for Wallhack when spectator")
local wh_chams_indicators_clr = gui.ColorPicker(deadesp_group, "wh.chams.ind.color", "WH Chams Indicators Color", 180,0,0,255)
gui.Text(deadesp_group, "Created by ticzz [ https://github.com/ticzz/Aimware-v5-luas/blob/c7f6ed6a85533d14e3821d39274612cae2c7137f/DeadESP.lua ]")


local function DeadESP( ) 
w, h = ScreenSize

	if not player then
			return
	end		

	if player:IsAlive() == false then										-- Dead and spectating someone

            set("esp.overlay.enemy.name", true)
            set("esp.chams.enemy.occluded", deadesp_chams_while_spec:GetValue())
			set("esp.chams.enemy.visible", "2")
			set("esp.chams.enemy.overlay", "1")
			set("esp.chams.enemyattachments.occluded", false)
			set("esp.chams.enemyattachments.visible", false)
			set("esp.chams.enemyattachments.overlay", false)
            set("esp.chams.friendlyattachments.occluded", false)
			set("esp.chams.friendlyattachments.visible", false)
			set("esp.chams.friendlyattachments.overlay", false)
			set("esp.overlay.enemy.scoped", false)
            set("esp.overlay.enemy.reloading", false)
            set("esp.overlay.enemy.health.healthnum", false)
            set("esp.overlay.enemy.health.healthbar", true)
			set("esp.overlay.enemy.weapon", "1")
            set("esp.overlay.enemy.box", false)
            set("esp.overlay.enemy.hasdefuser", true)
            set("esp.overlay.enemy.hasc4", true)
            set("esp.overlay.enemy.barrel", false)
			set("esp.overlay.enemy.armor", "1")

	elseif player:IsAlive() == true then								-- Alive
            
			set("esp.overlay.enemy.name", false)
            set("esp.chams.enemy.occluded", false)
			set("esp.chams.enemy.visible", "2")
			set("esp.chams.enemy.overlay", false)
			set("esp.chams.enemyattachments.occluded", false)
			set("esp.chams.enemyattachments.visible", false)
			set("esp.chams.enemyattachments.overlay", false)
			set("esp.chams.friendlyattachments.occluded", false)
			set("esp.chams.friendlyattachments.visible", false)
			set("esp.chams.friendlyattachments.overlay", false)
            set("esp.overlay.enemy.scoped", false)
            set("esp.overlay.enemy.reloading", false)
            set("esp.overlay.enemy.health.healthnum", false)
            set("esp.overlay.enemy.health.healthbar", false)
            set("esp.overlay.enemy.weapon", false)
            set("esp.overlay.enemy.box", false)
            set("esp.overlay.enemy.hasdefuser", false)
            set("esp.overlay.enemy.hasc4", false)
			set("esp.overlay.weapon.ammo", false)
            set("esp.overlay.enemy.barrel", false)
			set("esp.overlay.enemy.armor", false)
	end
	
	if (deadesp_wallhack_key:GetValue() ~= nil or false) then		
	
	if player:IsAlive() == true and input.IsButtonDown(deadesp_wallhack_key:GetValue()) then		-- Alive, holding down the wh-key
				set("esp.chams.enemy.occluded", deadesp_chams_on_tggl:GetValue())

				color(wh_chams_indicators_clr:GetValue())
				text(15, h/2, "Wallhack Chams OnKey")
			
		end			
	end
end

callbacks.Register( "Draw", DeadESP );