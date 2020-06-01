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



local misc_movement_other_ref = gui.Reference("MISC", "MOVEMENT", "Other")
local velocity_on_stand_enable = gui.Checkbox( misc_movement_other_ref,  "velocity_on_stand_enabled", "Enable velocity on stand", false)
local velocity_on_stand = gui.Slider(misc_movement_other_ref, "velocity_on_stand","Velocity while standing", 5, 0, 10, 0.01);

delay = globals.CurTime() + 0.05


local blacklisted_weapons = {
"CMolotovGrenade",
"CSmokeGrenade",
"CHEGrenade",
"CFlashbang",
"CDecoyGrenade"
}

function is_blacklisted_weapon(weapon_class)
for k,v in pairs(blacklisted_weapons) do
if v == weapon_class then
return true
end
end
return false
end



callbacks.Register("CreateMove", function(cmd)

if not entities.GetLocalPlayer() then return end

if not entities.GetLocalPlayer():IsAlive() or is_blacklisted_weapon(entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon"):GetClass()) then return end
local VelocityX = entities.GetLocalPlayer():GetPropFloat( "localdata", "m_vecVelocity[0]" );
local VelocityY = entities.GetLocalPlayer():GetPropFloat( "localdata", "m_vecVelocity[1]" );
local speed = math.sqrt(VelocityX^2 + VelocityY^2);
if speed > velocity_on_stand:GetValue() then delay = globals.CurTime() + 0.05 return end

if delay > globals.CurTime() then
switch = not switch
delay = globals.CurTime() + 0.05
end

if switch and velocity_on_stand_enable:GetValue() then
cmd:SetSideMove(velocity_on_stand:GetValue())
elseif not switch and velocity_on_stand_enable:GetValue() then
cmd:SetSideMove(-velocity_on_stand:GetValue())
end
end)