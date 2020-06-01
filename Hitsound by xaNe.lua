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



local refz = gui.Reference( "MISC")
local Hitsound_tab = gui.Tab(refz, "misc_tab_hitsound", "HitSound")
local AWHitsoundchkbx = gui.Checkbox(Hitsound_tab, "lua_hitsound_active", "Enable Hitsounds[xaNe]", true)
local mhvolume = gui.Slider( Hitsound_tab, "mhvolume", "Volume", 50, 0, 100)


local function HitGroup( INT_HITGROUP )
   if INT_HITGROUP == 0 then
       return "body";
   elseif INT_HITGROUP == 1 then
       return "head";
   elseif INT_HITGROUP == 2 then
       return "chest";
   elseif INT_HITGROUP == 3 then
       return "stomach";
   elseif INT_HITGROUP == 4 then 
       return "left arm";
   elseif INT_HITGROUP == 5 then 
       return "right arm";
   elseif INT_HITGROUP == 6 then 
       return "left leg";
   elseif INT_HITGROUP == 7 then 
       return "right leg";
   elseif INT_HITGROUP == 8 then 
       return "hitbox 8";
   elseif INT_HITGROUP == 9 then 
      return "hitbox 9";
   elseif INT_HITGROUP == 10 then 
       return "body";
   end
end

local function on_player_hurt_or_death(Event)
			

	if AWHitsoundchkbx:GetValue() == true then

					
if (Event:GetName() == "player_hurt") then
		
		local LOCAL_PLAYER = client.GetLocalPlayerIndex();
		local ID_VICTIM, ID_ATTACKER, HITGROUP = Event:GetInt("userid"), Event:GetInt("attacker"), Event:GetInt("hitgroup");
		local INDEX_VICTIM, INDEX_ATTACKER = client.GetPlayerIndexByUserID(ID_VICTIM), client.GetPlayerIndexByUserID(ID_ATTACKER);

if (INDEX_ATTACKER == LOCAL_PLAYER and INDEX_VICTIM ~= LOCAL_PLAYER and HITGROUP == 1) then
		volume = gui.GetValue("mhvolume");
		client.Command("playvol */Rust_hs.wav "..volume, true);		-- */rust_hs.wav (headshot sound)
end

elseif (INDEX_ATTACKER == LOCAL_PLAYER and INDEX_VICTIM ~= LOCAL_PLAYER and HITGROUP ~= 1) then
		volume = gui.GetValue("mhvolume");
		client.Command("playvol */Hitsound_retro.wav "..volume, true);  --  sound\\misc\\m1.wav (bodyhit sound)

		end
	
	
if (Event:GetName() == "player_death") then
	
if (INDEX_ATTACKER == LOCAL_PLAYER and INDEX_VICTIM ~= LOCAL_PLAYER) then
		volume = gui.GetValue("mhvolume");
		client.Command("playvol */Hitsound_new.wav "..volume, true);
		end
	end
end
end

client.AllowListener( "player_death" )
client.AllowListener( "player_hurt" )
callbacks.Register( "FireGameEvent",  "on_player_hurt_or_death", on_player_hurt_or_death)