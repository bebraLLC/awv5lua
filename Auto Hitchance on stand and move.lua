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



--Moving and Standing hitchance--

local rui = gui.Reference( "Ragebot", "Accuracy", "Weapon") 
local enable = gui.Checkbox(rui, "lua.hitchance.move.stand.chkbox", "Use Hitchances by Move and Stand", 0)
local kui = gui.Groupbox(gui.Reference( "Ragebot", "Accuracy", "Weapon"), "Moving and Standing Hitchance")
local hcslider1 = gui.Slider( kui, "asniper.hitchance.move", "Moving Hitchance", 0, 0, 100 )
local hcslider2 = gui.Slider( kui, "asniper.hitchance.stand", "Standing Hitchance", 0, 0, 100 )
local veloslider = gui.Slider( kui, "asniper.hitchance.velocity", "Max StandVelocity", 0, 0, 120, 0.5)


local function movstandhc()
    velocity = math.sqrt(localPlayer:GetPropFloat( "localdata", "m_vecVelocity[0]" )^2 + localPlayer:GetPropFloat( "localdata", "m_vecVelocity[1]" )^2)
    	if velocity > maxVelo then
        gui.SetValue( "rbot.accuracy.weapon.asniper.hitchance", minValue )	-- Moving 	(when Velocity is higher than veloslider Value)
    else
        gui.SetValue( "rbot.accuracy.weapon.asniper.hitchance", maxValue )	-- Standing (when Velocity is lower than veloslider Value)
    end
end

local function sethc()
    minValue = hcslider1:GetValue()
    maxValue = hcslider2:GetValue()
	maxVelo  = veloslider:GetValue()
end


local function localcheck()
if (enable:GetValue() == false) then return end

localPlayer = entities.GetLocalPlayer()
    if localPlayer then
        sethc()
        movstandhc()
    end
end

local function activationCheck()
    if not enable:GetValue() then
            kui:SetInvisible(true);
			kui:SetDisabled(true);
        else
            kui:SetInvisible(false);
			kui:SetDisabled(false)
    end
end


callbacks.Register( "Draw", "activationCheck", activationCheck );

callbacks.Register( "Draw", "localcheck", localcheck )