callbacks.Register("Draw", function()
   local me = entities.GetLocalPlayer();
   if not me then return
   end;

   if not me:IsAlive() then
       if me:GetPropEntity("m_hObserverTarget") then
           me:SetProp("m_iObserverMode", 5)
       end
	end
end);
