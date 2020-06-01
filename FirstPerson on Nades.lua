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



-- First person grenade helper by Scape#4313
-- Request from laorent on fourms
client.Command('sv_cheats', 1, true);
local disableOnNade = gui.Checkbox(gui.Reference("Visuals", "Local", "Camera"), "thirdpersonnade", "Disable On Nade", false);
disableOnNade:SetDescription("Disable thirdperson when holding a grenade");

local thirdpersonKey = gui.GetValue("esp.local.thirdpersonkey");
local thirdpersonActive = true;
client.Command("thirdperson", true);

local function firstPersonGrenade() 
   
if not thirdpersonKey then return error(NOthirdPersonkey) end;
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