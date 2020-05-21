if not timer then
    timer = {}
    local timers = {}

    function timer.Exists(name)
        for k,v in pairs(timers) do
            if name == v.name then
                return true
            end
        end
        return false
    end


    function timer.Simple(name, delay, func)
        if not timer.Exists(name) then
            table.insert(timers, {type = "Simple", name = name, func = func, lastTime = globals.CurTime() + delay, delay = delay})
        end
    end


    function timer.Remove(name)
        for k,v in pairs(timers or {}) do
            if name == v.name then
                table.remove(timers, k)
                return true
            end
        end
        return false
    end


    function timer.Tick()
        for k, v in pairs(timers or {}) do
            if not v.pause then
                -- timer.Create
                if v.type == "Create" then
                    if v.repetitions <= 0 then
                        table.remove(timers, k)
                    end
                    if globals.CurTime() >= v.lastTime then
                        v.lastTime = globals.CurTime() + v.delay
                        v.repStartTime = globals.CurTime()
                        v.func()
                        v.repetitions = v.repetitions - 1
                    end
                -- timer.Simple
                elseif v.type == "Simple" then
                    if globals.CurTime() >= v.lastTime then
                        v.func()
                        table.remove(timers, k)
                    end
                -- timer.Spam
                elseif v.type == "Spam" then
                    v.func()
                    if globals.CurTime() >= v.lastTime + v.duration then
                        table.remove(timers, k)
                    end
                end
            end
        end
    end
end

callbacks.Register( "Draw", timer.Tick)



local Loader_Window = gui.Tab(gui.Reference("Settings"), "loader.tab", "Lua loader")

function file.Exists(file_name)
  local exists = false
  file.Enumerate(function(_name)
    if file_name == _name then
      exists = true
    end
  end)
  return exists
end

function file.Contents(file_name)
  local f = file.Open(file_name, "r")
  local contents = f:Read()
  f:Close()
  return contents
end

function split (inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end


local spacers = {}
function GB_SetHeight(group_box, height)
    if spacers[group_box] then
        spacers[group_box]:Remove()
        local spacer = gui.Text(group_box, "")
        spacer:SetPosY(height)
    else
        local spacer = gui.Text(group_box, "")
        spacer:SetPosY(height)
        spacers[group_box] = spacer
    end
end


local readme = [[


--------------------------------------------------------------------------------------------------------------------
README.txt
Lua loader is meant to make it easier for aimware users to try, test and download scripts from the aimware forums that other aimware users have made and publiclily released.
If you have a script and don't want it on here, and your script is on here PM Chicken4676 on the aimware forums.
]]

local Loader_approved_scripts_gb = gui.Groupbox(Loader_Window, "Approved scripts\n\n\n\n", 15, 15, 610, 50)
local Loader_approved_scripts_header = gui.Text(Loader_approved_scripts_gb, [[    
Approved scripts - This is where you can find approved aimware scripts, approved meaning an aimware moderator verfied this is a working lua script.
]] .. readme)


local Loader_search_filter = gui.Editbox(Loader_Window, "loader.filter", "Search fitler")

local Loader_unapproved_scripts = gui.Button(Loader_Window, "Unapproved scripts", function() end)
local Loader_approved_scripts = gui.Button(Loader_Window, "Approved scripts", function() end)
local Loader_autoload_scripts = gui.Button(Loader_Window, "Autoload scripts",  function() end)
Loader_unapproved_scripts:SetDisabled(true)
Loader_autoload_scripts:SetDisabled(true)

Loader_search_filter:SetPosX(15)


Loader_unapproved_scripts:SetWidth(200)
Loader_approved_scripts:SetWidth(200)
Loader_autoload_scripts:SetWidth(200)

Loader_unapproved_scripts:SetPosX(15)
Loader_approved_scripts:SetPosX(15)
Loader_autoload_scripts:SetPosX(15)

Loader_approved_scripts:SetPosY(320)
Loader_approved_scripts:SetPosX(218)

Loader_autoload_scripts:SetPosY(320)
Loader_autoload_scripts:SetPosX(420)




local temp_running_files = {}
local download_path = "lua_loader/downloaded_files/"
local temp_path = "lua_loader/temp_files/"

function temp_file_exists(id)
    return file.Exists(temp_path .. id .. ".lua")
end

function downloaded_file_exists(id)
    return file.Exists(download_path .. id .. ".lua")
end

function RunLuaScript(url, id)
    if downloaded_file_exists(id) then
        LoadScript(download_path .. id .. ".lua")
        print("Running downloaded verison")
        return
    end
    http.Get(url, function(text)
        local f = nil
        local temp_file_path = temp_path .. id .. ".lua"
        if temp_file_exists(id) then        
            f = file.Open(temp_file_path, "w")
        else
            print(id, type(id), string.len(id))
            f = file.Open(temp_path .. id  .. ".lua", "a")
        end
        print("Running temp version")

        f:Write(text)
        f:Close()
        LoadScript(temp_file_path)
        table.insert(temp_running_files, temp_file_path)
    end)
end

function UnloadLuaScript(id)
    if downloaded_file_exists(id) then -- user downloaded this lua file
        UnloadScript(download_path .. id .. ".lua")
    else
        UnloadScript(temp_path .. id .. ".lua")
        file.Delete(temp_path .. id .. ".lua")
    end
end

function DownloadLuaScript(url, id)
    local file_path = download_path .. id .. ".lua"
    local f = nil
    http.Get(url, function(text)
        if downloaded_file_exists(id) then
            if file.Contents(file_path) == text then
                print("Lua has not been updated.")
                return
            end
            print("Lua has received an update")
            f = file.Open(file_path, "w")
        else
            f = file.Open(file_path, "a")
        end
        f:Write(text)
        f:Close()
    end)
end

function UninstallLuaScript(id)
    if downloaded_file_exists(id) then
        UnloadScript(download_path .. id .. ".lua")
        file.Delete(download_path .. id .. ".lua")
    end
end


local script_boxes = {}

function CreateScriptBox(script_info)
    local width = 300    
    local group_box = gui.Groupbox(Loader_Window, script_info.forum_title .. ' ' .. script_info.id, 0,0, width, 0)
    local author_text = gui.Text(group_box, "Author: " .. script_info.author)

    local b = {}
    b.run_button = gui.Button(group_box, "Run", function() 
        RunLuaScript(script_info.raw_code_url, script_info.id)
        timer.Simple("_1", 0.1, function() b.unrun_button:SetInvisible(false) end)
        b.run_button:SetInvisible(true)
    end)

    b.unrun_button = gui.Button(group_box, "Unload", function() 
        UnloadLuaScript(script_info.id)
        timer.Simple("_2", 0.1, function() b.run_button:SetInvisible(false) end)
        b.unrun_button:SetInvisible(true)
    end)

    b.download_button = gui.Button(group_box, "Download", function() 
        DownloadLuaScript(script_info.raw_code_url, script_info.id)
        timer.Simple("_1", 0.1, function() b.uninstall_button:SetInvisible(false) end)
        b.download_button:SetInvisible(true)
    end)

    b.uninstall_button = gui.Button(group_box, "Uninstall", function() 
        UninstallLuaScript(script_info.id)
        timer.Simple("_1", 0.1, function() b.download_button:SetInvisible(false) end)
        b.uninstall_button:SetInvisible(true)
    end)



    local script_box = {
        forum_title = script_info.forum_title,
        forum_url = script_info.forum_url,
        author = script_info.author,


        group_box = group_box,

        

        url_button = gui.Button(group_box, "Forum link", function() 
            panorama.RunScript('SteamOverlayAPI.OpenExternalBrowserURL("' .. script_info.forum_url .. '")')
        end),
        autorun_checkbox = gui.Checkbox(group_box, "autorun", "Autorun", false )
    }
    b.run_button:SetWidth(100)
    b.unrun_button:SetWidth(100)

    b.unrun_button:SetPosY(29)
    b.unrun_button:SetInvisible(true)

    b.download_button:SetWidth(100)
    b.download_button:SetPosY(29)
    b.download_button:SetPosX(102)

    b.uninstall_button:SetWidth(100)
    b.uninstall_button:SetPosY(29)
    b.uninstall_button:SetPosX(102)

    if downloaded_file_exists(script_info.id) then
        b.uninstall_button:SetInvisible(false)
        b.download_button:SetInvisible(true)

    else
        b.uninstall_button:SetInvisible(true)
        b.download_button:SetInvisible(false)
    end

    script_box.url_button:SetWidth(75)
    script_box.url_button:SetPosY(29)
    script_box.url_button:SetPosX(204)


    script_box.autorun_checkbox:SetPosY(-40)
    script_box.autorun_checkbox:SetPosX(205)
    script_box.autorun_checkbox:SetDisabled(true)
    table.insert(script_boxes, script_box)
end


function adjust_layout()
    local starting_pos_y = 290 -- The Y pos for the first row of group boxes to be placed
    local spacing = 80
    local filter = Loader_search_filter:GetValue()
    if filter:len() == 0 then
        for i, script_box in ipairs(script_boxes) do
            script_box.group_box:SetInvisible(false)
            if i % 2 == 0 then
                script_box.group_box:SetPosX(325)
                script_box.group_box:SetPosY(starting_pos_y + spacing * (i - 1))
            else
                script_box.group_box:SetPosY(starting_pos_y + spacing * i)
                script_box.group_box:SetPosX(15)
            end
        end
    else
        local filtered_script_boxes = {}
        for k, script_box in pairs(script_boxes) do
            if string.match(script_box.forum_title, filter) or string.match(script_box.author, filter) then
                script_box.group_box:SetInvisible(false)
                table.insert(filtered_script_boxes, script_box)
            else
                script_box.group_box:SetInvisible(true)
            end
        end


        for i, script_box in ipairs(filtered_script_boxes) do
            if i % 2 == 0 then
                script_box.group_box:SetPosX(325)
                script_box.group_box:SetPosY(starting_pos_y + spacing * (i - 1))
            else
                script_box.group_box:SetPosY(starting_pos_y + spacing * i)
                script_box.group_box:SetPosX(15)
            end
        end


    end
end

callbacks.Register("Draw", adjust_layout)



function stringtotable(text)
    local scripts = {
        approved_scripts = {},
        unapproved_scripts = {}
    }
    for k, v in pairs(script_boxes) do
        v.group_box:Remove()
    end
    script_boxes = {}
    local lines = split(text, "\n")
    for k, line in pairs(lines) do
        if string.sub(line, 1, 2) ~= "--" then
            local line_split = split(line, "|")
            line_split[1] = line_split[1]:gsub("|", "")
            line_split[6]  = line_split[6]:sub(1, -2)
            local script =  {
                category = line_split[1],
                forum_title = line_split[2],
                forum_url = line_split[3],
                raw_code_url = line_split[4],
                author = line_split[5],
                id = line_split[6],
            }
            if line_split[1] == "approved_scripts" then
                table.insert(scripts.approved_scripts, script)
            end
        end
    end
    return scripts
end



local delay = globals.CurTime() - 1
function heartbeat()
    if globals.CurTime() > delay then
        http.Get("https://raw.githubusercontent.com/AWSCRIPtS001/AimwareScripts1/master/aimware_scripts.txt", function(text)
            local scripts_table = stringtotable(text)
            for k, approved_script in pairs(scripts_table.approved_scripts) do
                CreateScriptBox(approved_script)
            end
        end)
        delay = globals.CurTime() + 60
    end
end

callbacks.Register("Draw", heartbeat)