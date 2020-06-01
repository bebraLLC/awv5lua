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



local FlatHealth = [[UnlitGeneric {
    $color          "[0 0 0]"
    $enthealth      "0"
    $tempVar        "1"
    $resVal         "0"
        
    proxies
    {
    Health
    {
        scale       "1"
        resultVar   "$enthealth"
    }
        Subtract
    {
        srcVar1     "$tempVar"
        srcVar2     "$enthealth"
        resultVar   "$color[0]"
    }
    Equals
    {
        srcVar1     "$enthealth"
        resultVar   "$color[1]"
    }
    }
}]]

local FlatHealthMat = materials.Create("FlatHealth", FlatHealth, "idk what to put here" )

local ColorHealth = [[VertexLitGeneric {
    $color          "[0 0 0]"
    $enthealth      "0"
    $tempVar        "1"
    $resVal         "0"
        
    proxies
    {
    Health
    {
        scale       "1"
        resultVar   "$enthealth"
    }
        Subtract
    {
        srcVar1     "$tempVar"
        srcVar2     "$enthealth"
        resultVar   "$color[0]"
    }
    Equals
    {
        srcVar1     "$enthealth"
        resultVar   "$color[1]"
    }
    }
}]]

local ColorHealthMat = materials.Create("ColorHealth", ColorHealth, "Polak pls give example" )

local enemyref = gui.Reference("Visuals", "Chams", "Enemy")
local friendref = gui.Reference("Visuals", "Chams", "Friendly")
local enemycombo = gui.Combobox( enemyref, "enemyhealth", "Health Chams", "Off", "Flat", "Color" )
local friendcombo = gui.Combobox( friendref, "friendhealth", "Health Chams", "Off", "Flat", "Color" )

local function DrawModelHook(Context)
    if Context:GetEntity() ~= nil then
        local LocalPayer = entities.GetLocalPlayer()
        if LocalPayer ~= nil then
            if Context:GetEntity():IsPlayer() then
                if enemycombo:GetValue() ~= 0 then
                    gui.SetValue("esp.chams.enemy.visible", 0)
                    if (Context:GetEntity():GetTeamNumber() ~= LocalPayer:GetTeamNumber()) then
                        if enemycombo:GetValue() == 1 then
                            Context:ForcedMaterialOverride(FlatHealthMat)
                        elseif enemycombo:GetValue() == 2 then
                            Context:ForcedMaterialOverride(ColorHealthMat)
                        end
                    end
                end
                if friendcombo:GetValue() ~= 0 then
                    gui.SetValue("esp.chams.friendly.visible", 0)
                    if (Context:GetEntity():GetTeamNumber() == LocalPayer:GetTeamNumber()) and (Context:GetEntity() ~= LocalPlayer) then
                        if friendcombo:GetValue() == 1 then
                            Context:ForcedMaterialOverride(FlatHealthMat)
                        elseif friendcombo:GetValue() == 2 then
                            Context:ForcedMaterialOverride(ColorHealthMat)
                        end
                    end
                end
            end
        end
    end
end

callbacks.Register("DrawModel", DrawModelHook)