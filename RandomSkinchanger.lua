-- indexes of last paintkit available for each weapon
-- this may change after new skins are introduced to the game
USP= 61 
DUAL= 322 
P250= 26 
REVOLVER= 64 
CZAUTO= 63 
DEAGLE= 1
FIVESEVEN= 3 
GLOCK= 4 
P2000= 32 
TEC9= 30 
local AK47= { [1] = 7; }
AUG= 8 
FAMAS= 10 
GALIL= 13 
M4A1S= 60 
M4A4= 16 
SG553= 39 
MAC10= 17
MP7= 33 
MP9= 34 
MP5= 23 
BIZON= 26 
P90= 19
UMP45= 24 
MAG7= 27 
NOVA= 35 
SAWEDOFF= 29 
XM1014= 25
M249= 14 
NEGEV= 28
AWP= 9
G3SG1= 11 
SCAR= 38 
SCOUT= 40 
MOLOTOV= 46 
HEGRENADE= 44 
FLASH= 43
SMOKE= 45
DECOY= 47
INCRENDIARY= 48
ZEUS= 31

bayonet = 33
butterfly = 23
falchion = 23
flipknife = 33
gut = 33
gypsy_jackknife = 11
karambit = 33
m9_bayonet = 33
push = 23
stiletto = 11
survival_bowie = 23
tactical = 23
ursus = 11
widowmaker = 11

local function main(event)
 
    -- if skinchanger is disabled, dont do nothing
    if (gui.GetValue("esp.skins.enable") == On) then
	return
	end
 
    -- on player spawn
    --if (event:GetName() == 'player_spawn') then
	-- on round prestart
	if (event:GetName() == 'round_prestart') then

		

		-- shuffle gun paintkits
        gui.SetValue("skin.add weapon_ak", math.random(#AK47))
        gui.SetValue("skin.add", math.random(AUG))
        gui.SetValue("skin.add", math.random(AWP))
        gui.SetValue("skin.add", math.random(BIZON))
        gui.SetValue("skin.add", math.random(CZAUTO))
        gui.SetValue("skin.add", math.random(DEAGLE))
        gui.SetValue("skin.add", math.random(DUAL))
        gui.SetValue("skin.add", math.random(FAMAS))
        gui.SetValue("skin.add", math.random(FIVESEVEN))
        gui.SetValue("skin.add", math.random(G3SG1))
        gui.SetValue("skin.add", math.random(GALIL))
        gui.SetValue("skin.add", math.random(GLOCK))
        gui.SetValue("skin.add", math.random(P2000))
        gui.SetValue("skin.add", math.random(M249))
        gui.SetValue("skin.add", math.random(M4A4))
        gui.SetValue("skin.add", math.random(M4A1S))
        gui.SetValue("skin.add", math.random(MAC10))
        gui.SetValue("skin.add", math.random(MAG7))
        gui.SetValue("skin.add", math.random(MP5SD))
        gui.SetValue("skin.add", math.random(MP7))
        gui.SetValue("skin.add", math.random(MP9))
        gui.SetValue("skin.add", math.random(NEGEV))
        gui.SetValue("skin.add", math.random(NOVA))
        gui.SetValue("skin.add", math.random(P250))
        gui.SetValue("skin.add", math.random(P90))
        gui.SetValue("skin.add", math.random(REVOLVER))
        gui.SetValue("skin.add", math.random(SAWEDOFF))
        gui.SetValue("skin.add", math.random(SCAR20))
        gui.SetValue("skin.add", math.random(SG553))
        gui.SetValue("skin.add", math.random(SSG08))
        gui.SetValue("skin.add", math.random(TEC9))
        gui.SetValue("skin.add", math.random(UMP45))
        gui.SetValue("skin.add", math.random(USP))
        gui.SetValue("skin.add", math.random(XM1014))
       if condition then
           -- body
       end
	
--		knives = 
--		{ 
--		"skin.add weapon_bayonet", "skin.add weapon_butterfly", "skin.add weapon_falchion", "skin.add weapon_flip",
--		"skin.add weapon_gut", "skin.add weapon_gypsy_jackknife", "skin.add weapon_karambit", "skin.add weapon_m9_bayonet",
--		"skin.add weapon_push", "skin.add weapon_stiletto", "skin.add weapon_survival_bowie", "skin.add weapon_tactical",
--		"skin.add weapon_ursus", "skin.add weapon_widowmaker"
--		}
--		
--		for _, knive in ipairs(knives) do
--			gui.SetValue(knive, 1)
--		end
--		
--		-- shuffle knife paintkits
--        gui.SetValue("skin.add weapon_bayonet", math.random(bayonet))
--        gui.SetValue("skin.add weapon_butterfly", math.random(butterfly))
--        gui.SetValue("skin.add weapon_falchion", math.random(falchion))
--        gui.SetValue("skin.add weapon_flip", math.random(flipknife))
--        gui.SetValue("skin.add weapon_gut", math.random(gut))
--        gui.SetValue("skin.add weapon_gypsy_jackknife", math.random(gypsy_jackknife)) -- navaja
--        gui.SetValue("skin.add weapon_karambit", math.random(karambit))
--        gui.SetValue("skin.add weapon_m9_bayonet", math.random(m9_bayonet))
--        gui.SetValue("skin.add weapon_push", math.random(push)) -- shadow daggers
--        gui.SetValue("skin.add weapon_stiletto", math.random(stiletto))
--        gui.SetValue("skin.add weapon_survival_bowie", math.random(survival_bowie))
--        gui.SetValue("skin.add weapon_tactical", math.random(tactical)) -- huntsman
--        gui.SetValue("skin.add weapon_ursus", math.random(ursus))
--        gui.SetValue("skin.add weapon_widowmaker", math.random(widowmaker)) -- talon
	   
        -- apply changes
        client.Command('cl_fullupdate', true)
    end
end

client.AllowListener('player_spawn')
callbacks.Register('FireGameEvent', 'random_skins', main)