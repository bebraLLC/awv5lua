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



--[[
	Script: Disable fakelag while using a revolver, grenade or a zeus.
	Developed By: velololxd
	Published: 8/3/2018 | 8:00 AM EST
	Last Updated: 8/3/2018 | 8:00 AM EST
]]

local set = gui.SetValue;
local get = gui.GetValue;
local userid_to_index = client.GetPlayerIndexByUserID;
local get_local_player = client.GetLocalPlayerIndex;

local function on_item_equip(Event)
	-- returns if the current event is not the item_equip event
	if (Event:GetName() ~= 'item_equip') then
		return;
	end

	local local_player, userid, item, weptype = get_local_player(), Event:GetInt('userid'), Event:GetString('item'), Event:GetInt('weptype');

	-- checks if the local players index is equal to the player that called the event
	if (local_player == userid_to_index(userid)) then
		if (item == "deagle" or weptype == 9) then
			set("misc.fakelag.enable", false);
		else
			set("misc.fakelag.enable", true);
		end
	end
end

client.AllowListener('item_equip');
callbacks.Register("FireGameEvent", "on_item_equip", on_item_equip);