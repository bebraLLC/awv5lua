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



--SimpleSpeclist by Cheeseot
local specshit = gui.Reference( "MISC", "GENERAL", "Extra")
local BetterSpecBox = gui.Checkbox( specshit, "lua_betterspec", "Simple speclist", 1 )
BetterSpecBox:SetDescription("Position based on default spectator window.")

function betterspec()
local specfont = draw.CreateFont('Vendetta', 20)
local sorting = 0
local specpos1, specpos2 = gui.GetValue("spectators")
	if BetterSpecBox:GetValue() then
	gui.SetValue("misc.showspec", 0)
	local lp = entities.GetLocalPlayer()
		if lp ~= nil then
			for i, v in ipairs(entities.FindByClass("CCSPlayer")) do
			local player = v
				if player ~= lp and not player:IsAlive() then
				local name = player:GetName()
					if player:GetPropEntity("m_hObserverTarget") ~= nil then
					local playerindex = player:GetIndex()
					local botcheck = client.GetPlayerInfo(playerindex)
						if (not botcheck["IsGOTV"] and not botcheck["IsBot"]) then
						local target = player:GetPropEntity("m_hObserverTarget");
							if target:IsPlayer() then
							local targetindex = target:GetIndex()
							local myindex = client.GetLocalPlayerIndex()
								if lp:IsAlive() then
									if targetindex == myindex then
									draw.SetFont(specfont)
									draw.Color(255,255,255,255)
									draw.Text( specpos1, specpos2 + (sorting * 16), name )
									draw.TextShadow( specpos1, specpos2 + (sorting * 16), name )
									sorting = sorting + 1
									end
								end	
								if not lp:IsAlive() then
									if lp:GetPropEntity("m_hObserverTarget") ~= nil then
									local myspec = lp:GetPropEntity("m_hObserverTarget")
									local myspecindex = myspec:GetIndex()
									if targetindex == myspecindex then
									draw.SetFont(specfont)
									draw.Color(255,255,255,255)
									draw.Text( specpos1, specpos2 + (sorting * 16), name )
									draw.TextShadow( specpos1, specpos2 + (sorting * 16), name )
									sorting = sorting + 1
									end
								end
								end
							end
						end
					end
				end
			end
		end
	end
end	
callbacks.Register ("Draw", "betterspec", betterspec)
--SimpleSpeclist by Cheeseot