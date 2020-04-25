local ref_gui = gui.Reference("Misc", "Enhancement")
local msc_ref = gui.Text(ref_gui, "HitMarker on the Center")
local hitcross = gui.Checkbox(msc_ref, 'lua_healthshot_hitcross_enabled', 'Enable crosshair marker', 0)
local hitmarkerColor = gui.ColorPicker(hitcross, "lua_healthshot_hitcross_color", "", 255, 165, 10, 255);
hitcross:SetDescription("Drawing a marker on the center of screen") 
local linesize = gui.Slider(msc_ref, 'lua_healthshot_hitcross_slider', 'Crosshair marker size', 15, 0, 20)

local CrossTime = 0
local alpha = 0;
local screenCenterX, screenCenterY = draw.GetScreenSize();
screenCenterX = screenCenterX / 2;
screenCenterY = screenCenterY / 2;


local function Hitmarker(e)

local event_name = e:GetName()
if (event_name ~= 'player_hurt') then 
return 
end
  
	if (event_name == 'player_hurt') then

 
		if (hitcross:GetValue() == true) then
		print("Enabled the crosshair marker feature ;P")
		CrossTime = globals.RealTime()
		end
	end
end

callbacks.Register('Draw', function()
  local step = 255 / 0.3 * globals.FrameTime()
  local r,g,b,a = hitmarkerColor:GetValue()
  if CrossTime + 0.4 > globals.RealTime() then
     alpha = 255
  else
     alpha = alpha - step
  end
  if (alpha > 0) then
    linesizeValue = linesize:GetValue()
     draw.Color( r,g,b,alpha)
     draw.Line( screenCenterX, screenCenterY - linesizeValue / 2, screenCenterX, screenCenterY - ( linesizeValue ))
     draw.Line( screenCenterX - linesizeValue / 2, screenCenterY, screenCenterX - ( linesizeValue ), screenCenterY)
     draw.Line( screenCenterX, screenCenterY + linesizeValue / 2, screenCenterX, screenCenterY + ( linesizeValue ))
     draw.Line( screenCenterX + linesizeValue / 2, screenCenterY, screenCenterX + ( linesizeValue ), screenCenterY)
  end
end);

callbacks.Register("FireGameEvents", "Hitmarker", Hitmarker)