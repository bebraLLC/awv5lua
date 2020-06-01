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



local REF = gui.Reference( "Misc", "General", "Extra" )
local CHECKBOX = gui.Checkbox( REF, "defusebot", "Defuse Bot", false )
CHECKBOX:SetDescription("Automatically defuses the bomb before it explodes.")
local SLIDER = gui.Slider( REF, "defusebot.timer", "Defuse Bot Timer", 0.5, 0, 2, 0.05 )
local SPAM = gui.Checkbox( REF, "defusebot.spam", "Spam before Defusing", false )
SPAM:SetDescription("Spams the defuse button on the bomb.")

local spamToggle = false
local waitTicks = 0
local defusing = false

callbacks.Register( "Draw", function()
    if CHECKBOX:GetValue() then
        SLIDER:SetInvisible(false)
        SPAM:SetInvisible(false)
    else
        SLIDER:SetInvisible(true)
        SPAM:SetInvisible(true)
    end
end )

callbacks.Register( "CreateMove", function(cmd)
    local defuseTime = 0
    if entities.GetLocalPlayer():GetProp("m_bHasDefuser") == 1 then defuseTime = 5 else defuseTime = 10 end
    if not CHECKBOX:GetValue() then return end
    local lPlayer = entities.GetLocalPlayer()
    local bomb = entities.FindByClass("CPlantedC4")[1];
    if bomb == nil or lPlayer == nil then return end
    if lPlayer:GetTeamNumber() ~= 3 then return end
    if bomb:GetProp("m_bBombDefused") ~= 0 then return end
    local bombOrigin = bomb:GetAbsOrigin()
    local lPlayerOrigin = lPlayer:GetAbsOrigin()
    if vector.Distance( { bombOrigin["x"], bombOrigin["y"], bombOrigin["z"] }, {lPlayerOrigin["x"], lPlayerOrigin["y"], lPlayerOrigin["z"]}) > 75 then return end
    if math.abs(globals.CurTime() - bomb:GetProp("m_flC4Blow")) - defuseTime < 0 and not defusing then return end
    if math.abs(globals.CurTime() - bomb:GetProp("m_flC4Blow")) - defuseTime <= SLIDER:GetValue() then
        defusing = true
        cmd.buttons = cmd.buttons + 32
    elseif SPAM:GetValue() then
        if waitTicks >= 20 then
            cmd.buttons = cmd.buttons + 32
            waitTicks = 0
        end
        waitTicks = waitTicks + 1
    end
end )