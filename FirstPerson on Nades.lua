-- First person grenade helper by Scape#4313
-- Request from laorent on fourms
local disableOnNade = gui.Checkbox(gui.Reference("Visuals", "Local", "Camera"), "thirdpersonnade", "Disable On Nade", false);
disableOnNade:SetDescription("Disable thirdperson when holding a grenade");

local thirdpersonKey = gui.GetValue("esp.local.thirdpersonkey");
local thirdpersonActive = true;
client.Command("thirdperson", true);

local function firstPersonGrenade() 
    local localPlayer = entities.GetLocalPlayer();

    if input.IsButtonPressed(thirdpersonKey) then
        thirdpersonActive = not thirdpersonActive;
    end

    if disableOnNade:GetValue() and localPlayer then
        local weaponType = localPlayer:GetPropEntity('m_hActiveWeapon'):GetWeaponType()

        if weaponType == 9 then
            client.Command("firstperson", true);
        else
            if thirdpersonActive then
                client.Command("thirdperson", true);
            end
        end
    end
end

callbacks.Register("Draw", firstPersonGrenade);