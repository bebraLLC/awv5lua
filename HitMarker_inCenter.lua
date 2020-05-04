local ref_gui = gui.Reference("Visuals", "Local", "Helper")
local msc_ref = gui.Text(ref_gui, "HitMarker on the Center")
local allenabled = gui.Checkbox(ref_gui, 'lua_healthshot_hitsound_enabled', 'Hitsound/marker lua enabled', 1)
local hitcross = gui.Checkbox(msc_ref, 'lua_healthshot_hitcross_enabled', 'Enable crosshair marker', 0)
local hitmarkerColor = gui.ColorPicker(ref_gui, "lua_healthshot_hitcross_color", "", 255, 165, 10, 255);
hitcross:SetDescription("Drawing a marker on the center of screen") 
local linesize = gui.Slider(ref_gui, 'lua_healthshot_hitcross_slider', 'Crosshair marker size', 15, 1, 30)
local hitcrossrotate = gui.Checkbox(ref_gui, 'lua_healthshot_hitcross_rotated', 'Rotate marker by 45', 0)

local CrossTime = 0
local alpha = 0;
local screenCenterX, screenCenterY = draw.GetScreenSize();
screenCenterX = screenCenterX / 2;
screenCenterY = screenCenterY / 2;


local function hitcross_marker()
	
if not allenabled:GetValue() then
	return
end	
	
if (hitcross:GetValue() == true) then
	CrossTime = globals.RealTime()
end
end
callbacks.Register('FireGameEvent', "hitcross_marker", hitcross_marker)


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
	if(hitcrossrotate:GetValue() == true) then
        draw.Line( screenCenterX - linesizeValue / 2, screenCenterY - linesizeValue / 2, screenCenterX - ( linesizeValue ), screenCenterY - ( linesizeValue ))
        draw.Line( screenCenterX - linesizeValue / 2, screenCenterY + linesizeValue / 2, screenCenterX - ( linesizeValue ), screenCenterY + ( linesizeValue ))
        draw.Line( screenCenterX + linesizeValue / 2, screenCenterY + linesizeValue / 2, screenCenterX + ( linesizeValue ), screenCenterY + ( linesizeValue ))
        draw.Line( screenCenterX + linesizeValue / 2, screenCenterY - linesizeValue / 2, screenCenterX + ( linesizeValue ), screenCenterY - ( linesizeValue ))
	else
        draw.Line( screenCenterX, screenCenterY - linesizeValue / 2, screenCenterX, screenCenterY - ( linesizeValue ))
        draw.Line( screenCenterX - linesizeValue / 2, screenCenterY, screenCenterX - ( linesizeValue ), screenCenterY)
        draw.Line( screenCenterX, screenCenterY + linesizeValue / 2, screenCenterX, screenCenterY + ( linesizeValue ))
        draw.Line( screenCenterX + linesizeValue / 2, screenCenterY, screenCenterX + ( linesizeValue ), screenCenterY)
	end
end

if not allenabled:GetValue() then
	hitcross:SetInvisible( true )
	linesize:SetInvisible( true )
	else
if hitcross:GetValue() == false then
    linesize:SetInvisible( true )
    hitcrossrotate:SetInvisible( true )
	else
    linesize:SetInvisible( false )
    hitcrossrotate:SetInvisible( false )
end
end
	hitcross:SetInvisible( not allenabled:GetValue() )
end);