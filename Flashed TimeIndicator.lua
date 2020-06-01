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



--- Made by Clipper / superyu'#7167

local flashbangs = {}
client.AllowListener("flashbang_detonate")

local set = gui.SetValue
local color = draw.Color
local filledRect = draw.FilledRect
local getScreenSize = draw.GetScreenSize
local time = globals.RealTime

callbacks.Register("Draw", function()
    set("esp.other.noflash", 0)
    local pLocal = entities.GetLocalPlayer()
    if pLocal then
        if pLocal:IsAlive() then
            pLocal:SetProp("m_flFlashMaxAlpha", 0)

            for k, v in pairs(flashbangs) do
                local leftTime = v - (time() - pLocal:GetProp("m_flFlashDuration"))
                if leftTime < 0 then
                    table.remove(flashbangs, k)
                end
                local screenX, screenY = getScreenSize()
                screenX, screenY = screenX / 2, screenY / 2
                color(0, 0, 0, 155)
                filledRect(screenX+100, screenY+45, screenX-100, screenY+65)
                if (leftTime / pLocal:GetProp("m_flFlashDuration")) < 0.4 then
                    color(25, 255, 25, 155)
                else
                    color(255, 25, 25, 155)
                end
                filledRect(screenX-98 + ((98*2) * (leftTime / pLocal:GetProp("m_flFlashDuration"))), screenY+47, screenX-98, screenY+63)
            end
        end
    end
end)

callbacks.Register("FireGameEvent", function(event)
    if event:GetName() == "flashbang_detonate" then
        table.insert(flashbangs, time())
    end
end)
