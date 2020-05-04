local PopupSystem = {
    version = "1";
    link = "https://raw.githubusercontent.com/superyor/PopupSystem/master/PopupSystem.lua";
    versionLink = "https://raw.githubusercontent.com/superyor/PopupSystem/master/version.txt";

    sounds = {"blip2", "button10"},
    popups = {},
    popupcount = 1;
}

function PopupSystem:createPopupType1(title, text, width, height, sound, buttonSound, buttonCallback)
    if sound then
        client.Command("play buttons/" .. self.sounds[sound], true)
    end
    local popup = {};
    popup.id = self.popupcount;
    popup.position = {};
    popup.position.x = 1920 / 2;
    popup.position.y = 1080 / 2;

    if pcall(draw.GetScreenSize) then
        popup.position.x, popup.position.y = draw.GetScreenSize()
        popup.position.x = popup.position.x / 2;
        popup.position.y = popup.position.y / 2;
    end

    local varname = "popup.id." .. popup.id
    popup.window = gui.Window(varname .. ".window", title, popup.position.x-150, popup.position.y-100, width, height)
    popup.group = gui.Groupbox(popup.window, title, 16, 16, width-32, height)
    popup.text = gui.Text(popup.group, text)
    popup.button = gui.Button(popup.group, "OK", function()
        popup.text:Remove()
        popup.group:Remove()
        popup.window:Remove()
        popup.button:Remove()

        if buttonSound then
            client.Command("play buttons/" .. self.sounds[buttonSound], true);
        end

        if buttonCallback then
            buttonCallback();
        end

    end)
    popup.button:SetWidth((width-32)-32)
end

local function updateCheck()
    if PopupSystem.version ~= http.Get(PopupSystem.versionLink) then
        local script = file.Open("Modules\\Superyu\\PopupSystem.lua", "w");
        newScript = http.Get(PopupSystem.link)
        script:Write(newScript);
        script:Close()
        return false;
    else
        return true;
    end
end

if updateCheck() then
    return PopupSystem;
else
    return "Updated";
end
