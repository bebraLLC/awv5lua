local ref = gui.Reference("Ragebot", "Accuracy", "Weapon")
local weapon_list = { "asniper", "sniper", "scout", "hpistol", "pistol", "rifle" }

local rbot_autosniper_hitchance = gui.Slider(ref, weapon_list[1] .. ".hitchance", "hitchance (auto)", 0, 0, 100);

local rbot_sniper_hitchance = gui.Slider(ref, weapon_list[2] .. ".hitchance", "hitchance (awp)", 0, 0, 100);

local rbot_scout_hitchance = gui.Slider(ref, weapon_list[3] .. ".hitchance", "hitchance (scout)", 0, 0, 100);

local rbot_revolver_hitchance = gui.Slider(ref, weapon_list[4] .. ".hitchance", "hitchance (R8)", 0, 0, 100);

local rbot_pistol_hitchance = gui.Slider(ref, weapon_list[5] .. ".hitchance", "hitchance (pistol)", 0, 0, 100);

local rbot_rifle_hitchance = gui.Slider(ref, weapon_list[6] .. ".hitchance", "hitchance (rifle)", 0, 0, 100);

local adaptive_weapons = {
    -- see line 219
    ["asniper.hitchance"] = { 11, 38 },
    ["sniper.hitchance"] = { 9 },
    ["scout.hitchance"] = { 40 },
    ["hpistol.hitchance"] = { 64, 1 },
    ["pistol.hitchance"] = { 2, 3, 4, 30, 32, 36, 61, 63 },
    ["rifle.hitchance"] = { 7, 8, 10, 13, 16, 39, 60 },
    ["false"] = {},
}

local vars = {
    -- see line 219
    [rbot_autosniper_hitchance] = { 11, 38 },
    [rbot_sniper_hitchance] = { 9 },
    [rbot_scout_hitchance] = { 40 },
    [rbot_revolver_hitchance] = { 64, 1 },
    [rbot_pistol_hitchance] = { 2, 3, 4, 30, 32, 36, 61, 63 },
    [rbot_rifle_hitchance] = { 7, 8, 10, 13, 16, 39, 60 },
    [false] = {},
}


local function table_contains(table, item)
    for i = 1, #table do
        if table[i] == item then
            return true
        end
    end
    return false
end


local function find_key(value) 
    for k, v in pairs(adaptive_weapons) do
        if table_contains(v, value) then
            return k
        end
    end
end


local function entities_check()
    local LocalPlayer = entities.GetLocalPlayer();
    local Player
    if LocalPlayer ~= nil then
        Player = LocalPlayer:GetAbsOrigin()
        if (math.floor((entities.GetLocalPlayer():GetPropInt("m_fFlags") % 4) / 2) == 1) then
            z = 46
        else
            z = 64
        end
        Player.z = Player.z + LocalPlayer:GetPropVector("localdata", "m_vecViewOffset[0]").z
        return Player, LocalPlayer
    end
end


callbacks.Register("Draw", function()
    local Player, LocalPlayer = entities_check()
    if LocalPlayer then
        local weapon = LocalPlayer:GetWeaponID()
        local slider = find_key(weapon) --finding mindamage var  ["asniper.hitchance"] = { 11, 38 },
        if slider ~= nil then
            local slider_vis = ("rbot.accuracy.weapon." .. slider .. ) -- getting the var name of the check boxes/sliders
            if slider ~= false then -- makes sure only support weapon is selected
                    local hitchance = gui.GetValue(slider_vis) --setting hitchance
                    gui.SetValue("rbot.accuracy.weapon." .. slider, hitchance)
                else
                    local defaulthitchance = gui.GetValue("rbot.accuracy.weapon." .. weapon_list, hitchance)
                    gui.SetValue("rbot.accuracy.weapon." .. slider, defaulthitchance)
                end
            end
        end
    end
end)
