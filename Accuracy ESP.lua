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



function blacklisted(ply, weapon_dmg)
local blacklisted_weapons = {
"CKnife",
"CMolotovGrenade",
"CSmokeGrenade",
"CHEGrenade",
"CFlashbang",
"CDecoyGrenade",
"CIncendiaryGrenade",
"inferno",
"hegrenade"
}

local weapon_class = entities.GetLocalPlayer:GetPropEntity("m_hActiveWeapon"):GetClass()
for k, blacklisted_weapon in pairs(blacklisted_weapons) do
if weapon_class == blacklisted_weapon or weapon_dmg == blacklisted_weapon then
return true
end
end
return false

end

local accuracy_info = {}

function accuracy_info:find_player(ply)
for i, v in ipairs(self) do
if ply == v.name then
return v,i
end
end
return false, false
end


function accuracy_info:handle_shot(type, ply)
local player, index = self:find_player(ply:GetName())
if type == "shot" then
if player then
self[index].total_shots = self[index].total_shots + 1
else
table.insert(self, {total_shots = 1, total_hits = 0, name = ply:GetName(), ply = ply})
end
elseif type == "hit" then
if player then
self[index].total_hits = self[index].total_hits + 1
else
table.insert(self, {total_hits = 1, total_shots = 0, name = ply:GetName(), ply = ply})
end
end
end


callbacks.Register("FireGameEvent", function(e)
if e then
if e:GetName() == "weapon_fire" then
local ply = entities.GetByUserID(e:GetInt("userid"))
if blacklisted(ply, '') then return end
accuracy_info:handle_shot("shot", ply)

elseif e:GetName() == "player_hurt" then
local ply = entities.GetByUserID(e:GetInt("attacker"))
local wep = e:GetString("weapon") -- weapon damage done w/
if blacklisted(ply, wep) then return end
accuracy_info:handle_shot("hit", ply)
end
end
end)

client.AllowListener("weapon_fire")
client.AllowListener("player_hurt")

function round(number, decimals)
    local power = 10^decimals
    return math.floor(number * power) / power
end

function highest_shots()
local highest = 0
local highest_name = ''
for k, v in pairs(accuracy_info) do
if type(v) ~= "function" and v.total_shots > highest then
highest = v.total_shots
highest_name = v.name
end
end
return highest_name
end


local function OnDrawESP( builder )
    local name = builder:GetEntity():GetName()

local highest_name = highest_shots()
if name == highest_name then
builder:Color( 0, 255, 0, 255 )
else
builder:Color( 55, 0, 200, 255 )
end
local info = accuracy_info:find_player(name)
if not info then return end
builder:AddTextTop( "Accuracy: " .. round(info.total_hits * 100 / info.total_shots, 1) .. " (" .. info.total_shots .. ")");
end

callbacks.Register( "DrawESP", OnDrawESP );