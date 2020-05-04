    local tick_count = 0
    local ref_c = gui.Reference("Ragebot", "Aimbot", "Toggle")
    local check_c = gui.Checkbox(ref_c, "fakelag.onshot", "Fakelag on Shot", false)

    local ref = gui.Reference("Ragebot", "Hitscan", "Mode")
    local key_aw = gui.Keybox(ref, "autowall.key", "Autowall on key", 0)
    local tickcount = 0

    local ref_1 = gui.Reference("Ragebot", "Anti-Aim", "Advanced")
    local box_left = gui.Keybox(ref_1, "manual.aa.left", "Left ", gui.GetValue("lbot.antiaim.leftkey"))
    local box_right = gui.Keybox(ref_1, "manual.aa.right", "Right ", gui.GetValue("lbot.antiaim.rightkey"))

    local left = false
    local right = false

    local ref_trigger = gui.Reference( "Legitbot","Triggerbot","Toggle")
    local magnet = gui.Keybox( ref_trigger, "magnet", "Magnet", 0 )
    magnet:SetDescription("Activates Ragebot autoshot while pressed for fov set below")
    local fov_slider = gui.Slider(ref_trigger,"magnet.fov","Magnet Fov",1,0,180)
    fov_slider:SetDescription("Use manual legit aa, after setting keys reload")
    gui.SetValue("rbot.antiaim.base","0.0 Desync")
    gui.SetValue("rbot.antiaim.advanced.pitch","Off")
    gui.SetValue("rbot.antiaim.advanced.autodir",false)
    gui.SetValue("rbot.antiaim.advanced.antialign",false)
    gui.SetValue("rbot.antiaim.advanced.antiresolver",false)
        
    callbacks.Register("Draw", function(cmd)
        local left_key = box_left:GetValue()
        local right_key = box_right:GetValue()
        local aw = key_aw:GetValue()
        local magnet_key = magnet:GetValue()

        if left_key ~= 0 or right_key ~= 0 then
            if input.IsButtonPressed(right_key) then
                gui.SetValue("rbot.antiaim.base.rotation", -58)
                gui.SetValue("rbot.antiaim.base.lby", 120)
            elseif input.IsButtonPressed(left_key) then
                gui.SetValue("rbot.antiaim.base.rotation", 58)
                gui.SetValue("rbot.antiaim.base.lby", -120)
            end
        end
        if  magnet_key ~= 0 then 
            if input.IsButtonDown(magnet_key) then
                gui.SetValue("rbot.master",true)
                gui.SetValue("rbot.aim.key", magnet_key)
                gui.SetValue("rbot.aim.target.fov", fov_slider:GetValue())
            end
            if not input.IsButtonDown(magnet_key) then
                gui.SetValue("lbot.master",true)
            end
        end

        if aw ~= 0 and gui.GetValue("rbot.master") then
            if input.IsButtonPressed(aw) and not gui.GetValue("rbot.hitscan.mode.shared.autowall") then
                gui.SetValue("rbot.hitscan.mode.shared.autowall", true)
            elseif input.IsButtonPressed(aw) and gui.GetValue("rbot.hitscan.mode.shared.autowall") then
                gui.SetValue("rbot.hitscan.mode.shared.autowall", false)
            end
        end
    end)

    callbacks.Register("CreateMove", function(cmd)
        
        if not check_c:GetValue() or not gui.GetValue("rbot.master") then
            return
        end

        local IN_ATTACK = bit.lshift(1, 0)
        local IN_ATTACK2 = bit.lshift(1, 11)
        if bit.band(cmd.buttons, IN_ATTACK) == IN_ATTACK then
            tick_count = globals.TickCount()
            cmd:SetSendPacket(false)
        end

        if tick_count + 7 > globals.TickCount() then
            cmd:SetSendPacket(false)
        end
    end)