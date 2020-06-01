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



--=== Copyright © 2019-2020, Liga-Lua, All rights reserved, License GPL. ===---

local Version = "4c"

local RightAA = false
local LeftAA = false
local BackAA = true
local LastInvert = globals.TickCount()
local LastAA = globals.TickCount()
local AATick = 0
local gunTable = {
    [2] = "pistol",
    [11] = "asniper",
    [38] = "asniper",
}
local pirmaryAutoBuy = {
    [0] = "scar20",
    [1] = "awp",
    [2] = "ssg08"
}
local secondaryAutoBuy = {
    [0] = "elite",
    [1] = "deagle",
}

local GUIR = gui.Reference("RAGEBOT")
local GUI = gui.Tab(GUIR, "ligalua", "Liga-Lua [".. Version.. "]")
local AATab = gui.Groupbox(GUI, "Anti-Aim", 10, 10, 200, 200)
local MISCTab = gui.Groupbox(GUI, "Misc", 220, 10, 200, 200)
local AIMTab = gui.Groupbox(GUI, "Aimbot", 430, 10, 200, 200)
local AUTOBUYTab = gui.Groupbox(GUI, "Autobuy", 10, 240, 200, 200)
local AutoBuyP = gui.Combobox(AUTOBUYTab, "autobuyp", "Auto Buy Primary", "Auto Sniper", "AWP", "Scout")
local AutoBuyS = gui.Combobox(AUTOBUYTab, "autobuys", "Auto Buy Secondary", "Dualies", "Heavy")
local KillSay = gui.Checkbox(MISCTab, "killsay", "Kill Say", false)
local ToxicSay = gui.Checkbox(MISCTab, "talkshit", "Toxic Say", false)
local AutoBuy = gui.Checkbox(MISCTab, "autobuy", "Auto Buy", true)
local ManualAA = gui.Checkbox(AATab, "manualaa", "Manual AA", false)
local LigaAA = gui.Checkbox(AATab, "ligaaa", "Liga AA", true)
local TickAA = gui.Slider(AATab, "aatick", "AA Ticks", 1, 1, 8)
local InvertAA = gui.Keybox(AATab, "invertaa", "Invert AA Key", 88)
local BetterResolver = gui.Checkbox(AIMTab, "betterresolver", "Better Resolver", true)
local BetterDT = gui.Checkbox(AIMTab, "betterdf", "Better Double Tap", true)


local function MISC_CHATSAY(event)
    if(entities.GetLocalPlayer() == nil) then return end

    local KillSayT
    local DeathSayT
    local KillSayH
    local DeathSayH

    if(ToxicSay:GetValue() == true) then
        KillSayT = "Get fucked nn"
        DeathSayT = "Lucky shot nn retard"
        KillSayH = "Get 1'd nn who.ru??"
        DeathSayH = "[Gamsense] Missed due to prediction"
    else
        KillSayT = "You'll get me next time"
        KillSayH = "I swear I shot your body"
        DeathSayT = "Rip"
        DeathSayH = "ns"
    end

    if(event:GetName() == "player_death" and KillSay:GetValue()) then
        local LocalPlayer = client.GetLocalPlayerIndex()
        local VictimID = event:GetInt("userid")
        local AttackerID = event:GetInt("attacker")
        local IndexVictim = client.GetPlayerIndexByUserID(VictimID)
        local IndexAttacker = client.GetPlayerIndexByUserID(AttackerID) 

        if(IndexAttacker == LocalPlayer and IndexVictim ~= LocalPlayer and #KillSayT > 0) then
            if(event:GetFloat("headshot") == 1) then
                client.ChatSay(KillSayH)
            else
                client.ChatSay(KillSayT)
            end
        elseif(IndexAttacker ~= LocalPlayer and IndexVictim == LocalPlayer and #DeathSayT > 0) then
            if(event:GetFloat("headshot") == 1) then
                client.ChatSay(DeathSayH)
            else
                client.ChatSay(DeathSayT)
            end
        end
    end
end

local function MISC_AUTOBUY(event)
    if(entities.GetLocalPlayer() == nil) then return end

    if(event:GetName() == "round_prestart" and AutoBuy:GetValue()) then
        client.Command("buy ".. pirmaryAutoBuy[AutoBuyP:GetValue()])
        client.Command("buy ".. secondaryAutoBuy[AutoBuyS:GetValue()])
        client.Command("buy smokegrenade; buy hegrenade; buy incgrenade; buy flashbang; buy vesthelm; buy vest;")
    end
end

local function AA_MANUAL()
    if(entities.GetLocalPlayer() == nil) then return end

    if(not LigaAA:GetValue() and ManualAA:GetValue()) then
        if(input.IsButtonDown(37)) then
            RightAA = false
            LeftAA = true
            BackAA = false
        elseif(input.IsButtonDown(39)) then
            RightAA = true
            LeftAA = false
            BackAA = false
        elseif(input.IsButtonDown(40)) then
            RightAA = false
            LeftAA = false
            BackAA = true
        end

        if(RightAA) then
            gui.SetValue("rbot.antiaim.base", -90.0)
        elseif(LeftAA) then
            gui.SetValue("rbot.antiaim.base", 90.0)
        elseif(BackAA) then
            gui.SetValue("rbot.antiaim.base", -180.0)
        end
    end
end

local function AA_LIGA()
    if(entities.GetLocalPlayer() == nil) then return end

    if(LigaAA:GetValue() and not ManualAA:GetValue() and globals.TickCount() - LastAA > TickAA:GetValue()) then
        if(AATick == 1 and math.random(1,4) == 2) then
            gui.SetValue("rbot.antiaim.base", 170.0)
        elseif(AATick == 2) then
            gui.SetValue("rbot.antiaim.base", -170.0)
        elseif(AATick == 3) then
            gui.SetValue("rbot.antiaim.base", -180.0)
        elseif(AATick == 4) then
            gui.SetValue("rbot.antiaim.base", -130.0)
        elseif(AATick == 5) then
            gui.SetValue("rbot.antiaim.base", 130.0)
        elseif(AATick == 6) then
            gui.SetValue("rbot.antiaim.base", -180.0)
        elseif(AATick > 6) then
            gui.SetValue("rbot.antiaim.base.lby", tonumber(gui.GetValue("rbot.antiaim.base.lby")) * -1)
            AATick = 0
        end

        AATick = AATick + 1
        LastAA = globals.TickCount()
    end
end

local function AA_INVERT()
    if(entities.GetLocalPlayer() == nil) then return end

    if(globals.TickCount() - LastInvert > 6) then
        if(input.IsButtonDown(InvertAA:GetValue())) then
            gui.SetValue("rbot.antiaim.base.lby", tonumber(gui.GetValue("rbot.antiaim.base.lby")) * -1)
            gui.SetValue("rbot.antiaim.base.rotation", tonumber(gui.GetValue("rbot.antiaim.base.rotation")) * -1)
        end

        LastInvert = globals.TickCount()
    end
end

local function AIM_BETTERRESOLVER()
    if(entities.GetLocalPlayer() == nil) then return end

    if(BetterResolver:GetValue()) then
        local CurrentFPS = 1000 / globals.AbsoluteFrameTime()

        if(CurrentFPS < 60 * 1000 and gui.GetValue("rbot.hitscan.maxprocessingtime")) then
            gui.SetValue("rbot.hitscan.maxprocessingtime", gui.GetValue("rbot.hitscan.maxprocessingtime") - 5)
        elseif(CurrentFPS > 60 * 1000 and gui.GetValue("rbot.hitscan.maxprocessingtime")) then
            gui.SetValue("rbot.hitscan.maxprocessingtime", gui.GetValue("rbot.hitscan.maxprocessingtime") + 5)
        end
    end
end

local function AIM_BETTERDT()
    if(entities.GetLocalPlayer() == nil) then return end

    if(BetterDT:GetValue()) then
        if(gunTable[entities.GetLocalPlayer():GetWeaponID()] ~= nil) then
            local gunClass = tostring(gunTable[entities.GetLocalPlayer():GetWeaponID()])

            gui.SetValue("rbot.accuracy.weapon.".. gunClass.. ".doublefirehc",  100 - tonumber(gui.GetValue("rbot.accuracy.weapon.".. gunClass.. ".hitchance")) - 10)
        end
    end
end

client.AllowListener("player_death")
client.AllowListener("round_prestart")

callbacks.Register("FireGameEvent", "CHAT_KILLSAY", MISC_CHATSAY)
callbacks.Register("FireGameEvent", "BUY_AUTOBUY", MISC_AUTOBUY)
callbacks.Register("Draw", "AIM_BETTERRESOLVER", AIM_BETTERRESOLVER)
callbacks.Register("Draw", "AA_MANUAL", AA_MANUAL)
callbacks.Register("Draw", "AA_LIGA", AA_LIGA)
callbacks.Register("Draw", "AA_INVERT", AA_INVERT)
callbacks.Register("Draw", "AIM_BETTERDF", AIM_BETTERDT)