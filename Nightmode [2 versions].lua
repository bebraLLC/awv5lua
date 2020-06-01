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



--[[local reference = gui.Reference("VISUALS", "WORLD", "Extra");
local exposure = gui.Slider(reference, "nex_bloom_exposure", "Night Mode", 100, 1, 100);
callbacks.Register("Draw", "Night Mode", function()
local controller = entities.FindByClass("CEnvTonemapController")[1];
if(controller) then
controller:SetProp("m_bUseCustomAutoExposureMin", 1);
controller:SetProp("m_bUseCustomAutoExposureMax", 1);

controller:SetProp("m_flCustomAutoExposureMin", exposure:GetValue()/100);
controller:SetProp("m_flCustomAutoExposureMax", exposure:GetValue()/100);
end
end)
--]]

--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#

 --[[Made by superyu'#7167]]--
VALUE = gui.Slider(gui.Reference("Visuals", "World", "Materials"), "esp.world.materials.nightmode", "Nightmode", 1, 1, 100);
APPLY = gui.Button(gui.Reference("Visuals", "World", "Materials"), "Apply Nightmode", function()
    local v = (100 - VALUE:GetValue()) / 100
    materials.Enumerate(function(mat)
        if string.find(mat:GetTextureGroupName(), "World") then
            mat:ColorModulate(v, v, v);
        end
    end)
end)
