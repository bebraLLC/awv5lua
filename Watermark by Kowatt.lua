-- Lua coded by Kowatt || Lua repo [github.com/Kowatt/aimware]

function init()
 	
	local player = entities.GetLocalPlayer()
	if player == nil then
		return
	end

	rect();
	text();


if entities.FindByClass( "CBasePlayer" )[1] ~= nil then
	ping = entities.GetPlayerResources():GetPropInt( "m_iPing", client.GetLocalPlayerIndex() )
end

 end 


local frame_rate = 0.0
    local get_abs_fps = function()
        frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * globals.AbsoluteFrameTime()
        return math.floor((1.0 / frame_rate) + 0.5)
end


local guiRef = gui.Reference("MISC", "GENERAL", "EXTRA");
local guiText = gui.Text(guiRef, "Kowatt's Watermark settings");
local sliderX = gui.Slider(guiRef, "X postion", "X postion", 1, 0, 1920);
local sliderY = gui.Slider(guiRef, "Y postion", "Y postion", 1, 0, 1080);
local font_picker = gui.ColorPicker(guiRef, "font_color", "Text Color", 255, 255, 255, 255);
local background_picker = gui.ColorPicker(guiRef, "background_color", "Background Color", 25, 25, 25, 150);
local outline_picker = gui.ColorPicker(guiRef, "outline_color", "Outline Color", 25, 25, 25, 255);

function text()
	local font1 = draw.CreateFont("Pixel Inversions Regular", 20, 500);

	local x = math.floor(sliderX:GetValue());
	local y = math.floor(sliderY:GetValue());

	draw.SetFont(font1);
	draw.Color(font_picker:GetValue());
	draw.Text(x+10, y+12, "FPS :");
	draw.Text(x + 80, y+12, get_abs_fps());
	draw.Text(x + 135, y+12, "PING :");
	draw.Text(x + 220, y+12, ping);
	
end

function rect()


	local x = math.floor(sliderX:GetValue());
	local y = math.floor(sliderY:GetValue());

	draw.Color(background_picker:GetValue());
    draw.FilledRect(x, y, x+275, y + 40);
    draw.Color(outline_picker:GetValue());
    draw.OutlinedRect(x, y, x+275, y+40);



end

callbacks.Register('Draw', 'init', init);
