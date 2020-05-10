local misc_movement_other_ref = gui.Reference("MISC", "MOVEMENT", "Other")
local velocity_on_stand_enable = gui.Checkbox( misc_movement_other_ref,  "velocity_on_stand_enabled", "Enable velocity on stand", false)
local velocity_on_stand = gui.Slider(misc_movement_other_ref, "velocity_on_stand","Velocity while standing", 5, 1, 10, 0.01);

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