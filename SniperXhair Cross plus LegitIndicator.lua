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



-- SniperCrosshair

local VIS_MAIN_REF = gui.Reference( "VISUALS", "LOCAL", "Helper" );
local AWSniperCrosshair = gui.Checkbox( VIS_MAIN_REF, "lua_snipercrosshair", "Sniper Crosshair", 1 );
	
local function on_sniper(Event)    

	if AWSniperCrosshair:GetValue() then
if (Event:GetName() ~= 'item_equip') then return; end
if (client.GetLocalPlayerIndex() == client.GetPlayerIndexByUserID(Event:GetInt('userid'))) then
    if Event:GetString('item') == "awp" or Event:GetString('item') == "ssg08" or Event:GetString('item') == "scar20" or Event:GetString('item') == "g3sg1" then
            drawCrosshair = true
    else										--if Event:GetString('item') ~= "awp" and Event:GetString('item') ~= "ssg08" and Event:GetString('item') ~= "scar20" and Event:GetString('item') ~= "g3sg1" then
            drawCrosshair = false
       end end end end


local function ifCrosshair()
local screenCenterX, screenY = draw.GetScreenSize(); scX = screenCenterX / 2; scY = screenY / 2;
	if drawCrosshair == true then
		
	if (gui.GetValue("lbot.master") == true) then
		draw.Color(0, 255, 0, 255)
        draw.Line(scX, scY - 8, scX, scY + 8);  --line down
        draw.Line(scX - 8, scY, scX + 8, scY); --line across
	else										--if (gui.GetValue("lbot_enable") == false) then
		draw.Color(255, 0, 0, 255)
        draw.Line(scX, scY - 8, scX, scY + 8);  --line down
        draw.Line(scX - 8, scY, scX + 8, scY); --line across
	end
	elseif drawCrosshair == false then
--HERE--
return
end end

client.AllowListener('item_equip');
callbacks.Register("FireGameEvent", "if on sniper", on_sniper); 
callbacks.Register("Draw", "sniper crosshairs", ifCrosshair);

-- End SniperCrosshair
