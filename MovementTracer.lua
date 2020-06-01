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



local TickCountValue = 64 * 2;
local DataItems = { };
local LastTickCount = globals.TickCount();

local function GetFadeRGB(Factor, Speed)
    local r = math.floor(math.sin(Factor * Speed) * 127 + 128)
    local g = math.floor(math.sin(Factor * Speed + 2) * 127 + 128)
    local b = math.floor(math.sin(Factor * Speed + 4) * 127 + 128)
    return r, g, b;
end

local function MotionTrajectory()
    
    local LocalPlayer = entities.GetLocalPlayer();
    if (LocalPlayer == nil or LocalPlayer:IsAlive() ~= true) then
        DataItems = { };
        return;
    end
    
    ScreenX, ScreenY = draw.GetScreenSize();
    
    for i = 1, #DataItems do
        local ItemCurrent = DataItems[i];
        local ItemNext = DataItems[i + 1];
        
        if (ItemCurrent ~= nil and ItemNext ~= nil) then
            local CPosX, CPosY = client.WorldToScreen(ItemCurrent.x, ItemCurrent.y, ItemCurrent.z);
            local NPosX, NPosY = client.WorldToScreen(ItemNext.x, ItemNext.y, ItemNext.z);

            if (CPosX ~= nil and CPosY ~= nil and NPosX ~= nil and NPosY ~= nil and CPosX < ScreenX and CPosY < ScreenY and NPosX < ScreenX and NPosY < ScreenY) then
                local ColorR, ColorG, ColorB = GetFadeRGB(i / 10, 1);
                draw.Color(ColorR, ColorG, ColorB, 255);
                draw.Line(CPosX, CPosY, NPosX, NPosY);
                draw.Line(CPosX + 1, CPosY + 1, NPosX + 1, NPosY + 1);
            end
        end
    end
    
    
    local CurrentTickCount = globals.TickCount();
    if (CurrentTickCount - LastTickCount < 1) then
        return;
    end
    
    LastTickCount = CurrentTickCount;
    
    ----------------------------------------------
    
    local LocX, LocY, LocZ = LocalPlayer:GetAbsOrigin();
    local ItemData = { x = LocX, y = LocY, z = LocZ };

    table.insert(DataItems, 1, ItemData);
    if (#DataItems == TickCountValue + 1) then
        table.remove(DataItems, TickCountValue + 1);
    end
    
end

callbacks.Register("Draw", "CbDraw", MotionTrajectory);