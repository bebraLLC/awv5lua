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



--Fakeduck Viewmodel Animation by Grieschoel aka AEONS

local getLocal = function() return entities.GetLocalPlayer() end
local ref = gui.Reference("Visuals", "Local", "Camera");
local whyamiwastingmytime = gui.Checkbox( ref, fuckmyass, "Fakeduck Animation", false )
local viewmodelZ = (client.GetConVar("viewmodel_offset_z"));
function yourmumsahoe()
if whyamiwastingmytime:GetValue() then
if getLocal() then
if getLocal():IsAlive() then
local shitthisisboring = gui.GetValue('rbot.antiaim.advanced.fakecrouchkey')
local andsofuckinguseless = input.IsButtonDown( shitthisisboring )                                            
local yourmum = entities.GetLocalPlayer();
local tbagmodeengaged = yourmum:GetProp('m_flDuckAmount')            
if  andsofuckinguseless == true then
client.SetConVar("viewmodel_offset_z", viewmodelZ - (tbagmodeengaged*8), true)
else client.SetConVar("viewmodel_offset_z", viewmodelZ, true)
end end end end end                        
callbacks.Register("Draw", yourmumsahoe)