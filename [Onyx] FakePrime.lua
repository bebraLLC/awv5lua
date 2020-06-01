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



--[Onyx] FakePrime.lua for AIMWARE V5
--Author: OurmineOGTv#6846
--Unofficial AW Discord Server: https://discord.com/invite/5eH69PF
--Only people in lobby see this "prime".
--If you click button one time you must wait +/- 10-20 seconds

local OnyxRef = gui.Reference("Misc", "Enhancement", "Appearance")
local OnyxActivate = gui.Checkbox(OnyxRef, "onyx.fake.prime", "Fake Prime", false)
local prime = 0;

local function fakePrime()
    if OnyxActivate:GetValue() then
        prime = 1
    else
        prime = 0
    end
    panorama.RunScript([[
        var waitForPlayerUpdateEventHandler = null;
        if (!LobbyAPI.IsSessionActive()) { 
            LobbyAPI.CreateSession(); 
        }
        function stopCustomEvents() {
            if (waitForPlayerUpdateEventHandler != null) {
                $.UnregisterForUnhandledEvent( 'PanoramaComponent_Lobby_PlayerUpdated', waitForPlayerUpdateEventHandler);
                waitForPlayerUpdateEventHandler = null;
            }
        }
        stopCustomEvents();
        var playerData = {
            update: {
                members: {
                }
            }
        }
        var updateMessage = "";
        if (PartyListAPI.GetXuidByIndex(0) != 0) {
            var machineName = "machine0"
            updateMessage += "Update/Members/" + machineName + "/player0/game/prime ]] .. prime .. [[";
        }
        waitForPlayerUpdateEventHandler = $.RegisterForUnhandledEvent( "PanoramaComponent_Lobby_PlayerUpdated", function(xuid) {
            PartyListAPI.UpdateSessionSettings(updateMessage);
        });
        PartyListAPI.UpdateSessionSettings(updateMessage);
    ]])
    print("prime: " .. prime)
end

local OnyxFakeActivate = gui.Button(OnyxRef, "Force Reload", fakePrime)
