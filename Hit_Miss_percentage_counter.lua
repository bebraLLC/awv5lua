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



local color = gui.ColorPicker(gui.Reference("Visuals", "Other", "Extra"), "HitMiss.Text.cPicker", "Hit Miss Percentage Counter Color", 124,176,34,200)

local s = 0;
local h = 0;
local m = 0;

local t = nil

client.AllowListener("player_hurt")
client.AllowListener("weapon_fire")
client.AllowListener("round_announce_match_start")
client.AllowListener("player_connect_full")
client.AllowListener("round_announce_warmup")

callbacks.Register( "FireGameEvent", "Events", function(e)
    if e:GetName() == "player_hurt" then
        local ME = client.GetLocalPlayerIndex()
        if client.GetPlayerIndexByUserID(e:GetInt("attacker")) == ME and client.GetPlayerIndexByUserID(e:GetInt("userid")) ~= ME and not entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon"):GetName():match("knife") then
            if t~=nil then
                h=h+1
            end
        end
    end
    if e:GetName() == "weapon_fire" then
        if client.GetPlayerIndexByUserID(e:GetInt("userid")) == client.GetLocalPlayerIndex() and not entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon"):GetName():match("knife") then
            if t~=nil then
                s=s+1
            end
        end
    end
    
    if e:GetName() == "round_announce_match_start" or e:GetName() == "player_connect_full" or e:GetName() == "round_announce_warmup" then
        s,h,m=0,0,0
    end
end)

local textFont = draw.CreateFont('Verdana', 25, 3000)

callbacks.Register( "Draw", "UpdateValues", function()
    if not entities.GetLocalPlayer() then return end
    if not entities.GetLocalPlayer():IsAlive() then return end
    m=s-h
    local width,height = draw.GetScreenSize()
    draw.SetFont(textFont)
    draw.Color(color:GetValue() )
    draw.Text(5, height/2, "Hits:"..h)
    draw.Text(5, height/2+25, "Misses:"..m)
    draw.Text(5, height/2+50, "Total:"..s)
    if s == 0 and h == 0 and m == 0 then
        draw.Text(5, height/2+75, "Percentage:100%")
    else
        draw.Text(5, height/2+75, "Percentage:".. string.format("%.1f",(h/s*100) or 0).."%",true,-1)
        end
end)

callbacks.Register("AimbotTarget", function(e)
    local test = pcall(function() tostring(e:GetHealth()) end)
    if test then
        t = e
    else
        t = nil
    end
end)