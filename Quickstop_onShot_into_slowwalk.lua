local misc_movement_ref = gui.Reference("Ragebot", "ACCURACY", "MOVEMENT")
local on_shot_quickstop = gui.Checkbox( misc_movement_ref, "on_shot_quickstop_enabled", "On shot quick stop", false)
local on_shot_quickstop_into_slowwalk = gui.Checkbox( misc_movement_ref, "on_shot_quickstop_into_slowwalk.enabled", "On shot quickstop into slowwalk", false)
local quickstop_ticks = gui.Slider(misc_movement_ref, "quickstop_ticks", "On shot quickstop aggression", 7, 1, 20);
local slowwalk_duration = gui.Slider(misc_movement_ref, "quickstop_ticks", "Slow walk duration after quickstop (seconds)", 0.5, 0, 1, 0.1);


local blacklisted_weapons = {
"CKnife",
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


delay = globals.CurTime() 
function OnShotFired(GameEvent) 
if GameEvent:GetName() == "weapon_fire" then
player_fired = entities.GetByUserID(GameEvent:GetInt("userid"))
if tostring(player_fired) == tostring(entities.GetLocalPlayer()) then -- idk
delay = globals.CurTime() + slowwalk_duration:GetValue()
end
end
end

client.AllowListener("player_hurt")
client.AllowListener("weapon_fire")
callbacks.Register("FireGameEvent", OnShotFired)


stopped = false
delay_2 = globals.CurTime()

counter = 0

  
function quick_stop(cmd)
local VelocityX = entities.GetLocalPlayer():GetPropFloat( "localdata", "m_vecVelocity[0]" );
local VelocityY = entities.GetLocalPlayer():GetPropFloat( "localdata", "m_vecVelocity[1]" );
local VelocityZ = entities.GetLocalPlayer():GetPropFloat( "localdata", "m_vecVelocity[2]" );
local speed = math.sqrt(VelocityX^2 + VelocityY^2);

local velocity = {x = VelocityX, y = VelocityY, z = VelocityZ}
local directionX, directionY, directionZ = vector.Angles( {velocity.x,velocity.y,velocity.z} )

viewanglesX, viewanglesY = cmd:GetViewAngles()
directionY = viewanglesY - directionY
dirForwardX, dirForwardY, dirForwardZ = vector.AngleForward({directionX, directionY, directionZ})

negated_directionX, negated_directionY, negated_directionZ = vector.Multiply({dirForwardX, dirForwardY, dirForwardZ}, -speed)

cmd:SetForwardMove(negated_directionX)
cmd:SetSideMove(negated_directionY)
end





callbacks.Register("CreateMove", function(cmd)
if not on_shot_quickstop:GetValue() then return end

if not entities.GetLocalPlayer() then return end
if not entities.GetLocalPlayer():IsAlive() then return end
weapon_class = entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon"):GetClass()
if is_blacklisted_weapon(weapon_class) then return end

if globals.CurTime() > delay then
stopped = false
end

if entities.GetLocalPlayer():GetPropInt("cslocaldata", "m_iShotsFired") ~= 0 then
delay = globals.CurTime() + slowwalk_duration:GetValue()
end

if globals.CurTime() < delay and not stopped then
quick_stop(cmd)
counter = counter + 1
if counter > quickstop_ticks:GetValue() then
stopped = true
counter = 0
end
end

if stopped and on_shot_quickstop_into_slowwalk:GetValue() then
if input.IsButtonDown(65) then
gui.SetValue("rbot.accuracy.movement.slowkey", 65)
elseif input.IsButtonDown(68) then
gui.SetValue("rbot.accuracy.movement.slowkey", 68)
end
else
gui.SetValue("rbot.accuracy.movement.slowkey", 16)
end

end) 
