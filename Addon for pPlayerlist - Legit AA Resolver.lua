
local ref = gui.Reference("Misc", "Player List", "Per Player Settings")
local correction = plist.gui.Checkbox("correction", "Legit Anti-Aim Correction", 0)
correction:SetDescription("Attempts to correct enemies legit anti-aim.")
local function normalize(angle)
  return (angle + 180) % 360 - 180
end
callbacks.Register("Draw", function()
local lp = entities.GetLocalPlayer()
for _, player in ipairs( entities.FindByClass("CCSPlayer") ) do
if player:GetTeamNumber() ~= lp:GetTeamNumber() and player:IsAlive() then
local a = plist.GetByIndex(player:GetIndex())
if a.get("correction") then
local vel = math.sqrt(lp:GetPropFloat( "localdata", "m_vecVelocity[0]" )^2 + lp:GetPropFloat( "localdata", "m_vecVelocity[1]" )^2)
if 1 > math.abs(vel) then
a.set("resolver.type", 2)
a.set("resolver.lby_override", -math.min(58, math.max(-58, normalize(player:GetProp("m_angEyeAngles[1]") - player:GetProp("m_flLowerBodyYawTarget")))))
end
end
end
end
end)