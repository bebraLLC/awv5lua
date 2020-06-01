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



local guiRef1 = gui.Reference( "Ragebot", "Accuracy", "Movement" )
local enable = gui.Checkbox( guiRef1, "fakewalk", "Fakewalk", false )
enable:SetDescription("Use Fakewalk instead of Slowwalk");
local fakewalkgroupbox = gui.Groupbox(gui.Reference( "Ragebot", "Accuracy", "Movement" ), "Fakewalk Settings")
local fakewalkkey = gui.Keybox(fakewalkgroupbox, "fakewalkkey", "Fakewalkkey", 0)
fakewalkkey:SetDescription("Start Fakewalking when holding down this Key");

local function activationCheck()
    if not enable:GetValue() then
            fakewalkgroupbox:SetInvisible(true);
			fakewalkgroupbox:SetDisabled(true);
        else
            fakewalkgroupbox:SetInvisible(false);
			fakewalkgroupbox:SetDisabled(false)
    end
end

local function createMoveHook(cmd)

	
		if input.IsButtonDown( "a" ) and input.IsButtonDown( fakewalkkey:GetValue() ) and not input.IsButtonDown( "d" ) then
            cmd.sendpacket = false
            cmd.sidemove = -55
            cmd.sendpacket = false
            cmd.sidemove = -55
            cmd.sendpacket = false
            cmd.sidemove = -55
            cmd.sendpacket = false
            cmd.sidemove = -55
            cmd.sendpacket = false
            cmd.sendpacket = false
            cmd.sidemove = 0
            cmd.sendpacket = true
            cmd.sidemove = 0
            cmd.sendpacket = false
            cmd.sidemove = -55
        end
        if input.IsButtonDown( "d" ) and input.IsButtonDown( fakewalkkey:GetValue() ) and not input.IsButtonDown( "a" ) then
            cmd.sendpacket = false
            cmd.sidemove = 55
            cmd.sendpacket = false
            cmd.sidemove = 55
            cmd.sendpacket = false
            cmd.sidemove = 55
            cmd.sendpacket = false
            cmd.sidemove = 55
            cmd.sendpacket = false
            cmd.sendpacket = false
            cmd.sidemove = 0
            cmd.sendpacket = true
            cmd.sidemove = 0
            cmd.sendpacket = false
            cmd.sidemove = 55
        end
        if input.IsButtonDown( "s" ) and input.IsButtonDown( fakewalkkey:GetValue() ) and not input.IsButtonDown( "w" ) then
            cmd.sendpacket = false
            cmd.forwardmove = -55
            cmd.sendpacket = false
            cmd.forwardmove = -55
            cmd.sendpacket = false
            cmd.forwardmove = -55
            cmd.sendpacket = false
            cmd.forwardmove = -55
            cmd.sendpacket = false
            cmd.sendpacket = false
            cmd.forwardmove = 0
            cmd.sendpacket = true
            cmd.forwardmove = 0
            cmd.sendpacket = false
            cmd.forwardmove = -55
        end
        if input.IsButtonDown( "w" ) and input.IsButtonDown( fakewalkkey:GetValue() ) and not input.IsButtonDown( "s" ) then
            cmd.sendpacket = false
            cmd.forwardmove = 55
            cmd.sendpacket = false
            cmd.forwardmove = 55
            cmd.sendpacket = false
            cmd.forwardmove = 55
            cmd.sendpacket = false
            cmd.forwardmove = 55
            cmd.sendpacket = false
            cmd.sendpacket = false
            cmd.forwardmove = 0
            cmd.sendpacket = true
            cmd.forwardmove = 0
            cmd.sendpacket = false
            cmd.forwardmove = 55
        end
	end

callbacks.Register( "Draw", "activationCheck", activationCheck );
callbacks.Register("CreateMove", createMoveHook)