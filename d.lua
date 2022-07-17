-- FFI
ffi.cdef[[
	typedef void* (__cdecl* tCreateInterface)(const char* name, int* returnCode);
    typedef int(__fastcall* clantag_t)(const char*, const char*);
	void* GetProcAddress(void* hModule, const char* lpProcName);
    void* GetModuleHandleA(const char* lpModuleName);
]]

-- Vars
local PHook_Var_RL = false
local PHook_Screen_X, PHook_Screen_Y = draw.GetScreenSize()
local ragebot_accuracy_weapon = gui.Reference("Ragebot", "Accuracy", "Weapon")
local baim = 1
local awtggl = true

local fn_change_clantag = mem.FindPattern("engine.dll", "53 56 57 8B DA 8B F9 FF 15")
local set_clantag = ffi.cast("clantag_t", fn_change_clantag)

local function menu_weapon(var)
    local wp = string.match(var, [["(.+)"]])
    local wp = string.lower(wp)
    if wp == "heavy pistol" then
        return "hpistol"
    elseif wp == "auto sniper" then
        return "asniper"
    elseif wp == "submachine gun" then
        return "smg"
    elseif wp == "light machine gun" then
        return "lmg"
    else
        return wp
    end
end

local clantag_anim = {
    " [ A ] ",
    " [ AZ ] ", 
    " [ AZU ] ",
    " [ AZUR ] ",
    " [ AZURE ] ",
    " [ AZURE. ] ",
    " [ AZURE.L ] ",
    " [ AZURE.LU ] ",
    " [ AZURE.LUA ] ",
    " [ AZURE.LU ] ",
    " [ AZURE.L ] ",
    " [ AZURE. ] ",
    " [ AZURE ] ",
    " [ AZUR ] ",
    " [ AZU ] ",
    " [ AZ ] ",
    " [ A ] ",
}

-- Gui
local PHook_Tab                                             = gui.Tab(gui.Reference("Settings"), "PHook_tab", "azure.lua")
local PHook_Tab_GroupBox_Main                               = gui.Groupbox(PHook_Tab, "Main", 16, 16, 296, 100 )
local PHook_Tab_GroupBox_Main_CT                            = gui.Checkbox( PHook_Tab_GroupBox_Main, "PHook_CT", "Clantag", 0 )
local PHook_Tab_GroupBox_Main_Toggler                       = gui.Checkbox( PHook_Tab_GroupBox_Main, "PHook_toggler", "MT", 0 )
PHook_Tab_GroupBox_Main_Toggler:SetDescription("Bind this on key")
local PHook_Tab_GroupBox_Main_BAIM_Toggler                  = gui.Keybox( PHook_Tab_GroupBox_Main, "PHook_BAIM_toggler", "BAIM Toggle", 0 )
local PHook_Tab_GroupBox_Main_JWalk                         = gui.Keybox( PHook_Tab_GroupBox_Main, "PHook_Jwalk", "Jitter Walk", 0 )
local PHook_Tab_GroupBox_Main_AW_Toggler                    = gui.Keybox( PHook_Tab_GroupBox_Main, "PHook_AW_toggler", "AW Toggle", 0 )
local PHook_Tab_GroupBox_Main_Inverter                      = gui.Keybox( PHook_Tab_GroupBox_Main, "PHook_Inverter", "AA Inverter", 0 )
local PHook_Tab_GroupBox_Main_DFOV_Checkbox                 = gui.Checkbox( PHook_Tab_GroupBox_Main, "PHook_indicators_DFOV", "Dynamic FOV", 0 )
local PHook_Tab_GroupBox_Main_DFOV_Min_Slider               = gui.Slider( PHook_Tab_GroupBox_Main, "PHook_indicators_Min_DFOV", "Minimum FOV", 5, 0, 30 )
local PHook_Tab_GroupBox_Main_DFOV_Max_Slider               = gui.Slider( PHook_Tab_GroupBox_Main, "PHook_indicators_Max_DFOV", "Maximum FOV", 20, 0, 30 )

local PHook_Tab_GroupBox_Indicators                         = gui.Groupbox(PHook_Tab, "Indicators", 328, 16, 296, 100 )
local PHook_Tab_GroupBox_Main_Indicators_WmarkColor         = gui.ColorPicker( PHook_Tab_GroupBox_Indicators, "PHook_Tab_GroupBox_Main_Indicators_WmarkColor", "Watermark Color", 152, 25, 25, 255 )
local PHook_Tab_GroupBox_Main_Indicators_Multibox           = gui.Multibox( PHook_Tab_GroupBox_Indicators, "Indicators")
PHook_Tab_GroupBox_Main_Indicators_Multibox:SetDescription("Enables indicators")
local PHook_Tab_GroupBox_Main_Indicators_Position_Selector  = gui.Combobox( PHook_Tab_GroupBox_Indicators, "PHook_Tab_GroupBox_Main_Indicators_Position_Selector", "Indicators Position", "1", "2" )
local PHook_Tab_GroupBox_Main_Indicators_RL_Checkbox        = gui.Checkbox( PHook_Tab_GroupBox_Main_Indicators_Multibox, "PHook_indicators_RL", "MT", 0 )
local PHook_Tab_GroupBox_Main_Indicators_FOV_Checkbox       = gui.Checkbox( PHook_Tab_GroupBox_Main_Indicators_Multibox, "PHook_indicators_FOV", "FOV", 0 )
local PHook_Tab_GroupBox_Main_Indicators_DMG_Checkbox       = gui.Checkbox( PHook_Tab_GroupBox_Main_Indicators_Multibox, "PHook_indicators_DMG", "Minimum Damage", 0 )
local PHook_Tab_GroupBox_Main_Indicators_BAIM_Checkbox      = gui.Checkbox( PHook_Tab_GroupBox_Main_Indicators_Multibox, "PHook_indicators_BAIM", "BAIM", 0 )
local PHook_Tab_GroupBox_Main_Indicators_AW_Checkbox        = gui.Checkbox( PHook_Tab_GroupBox_Main_Indicators_Multibox, "PHook_indicators_AW", "Auto Wall", 0 )  
local PHook_Tab_GroupBox_Main_Indicators_Resolver_Checkbox  = gui.Checkbox( PHook_Tab_GroupBox_Main_Indicators_Multibox, "PHook_indicators_Resolver", "Resolver", 0 )
local PHook_Tab_GroupBox_Main_Indicators_AA_Checkbox        = gui.Checkbox( PHook_Tab_GroupBox_Main_Indicators_Multibox, "PHook_indicators_AA", "Anti Aim", 0 )
local PHook_Tab_GroupBox_Main_Indicators_1_Font_Slider      = gui.Slider( PHook_Tab_GroupBox_Indicators, "PHook_Tab_GroupBox_Main_Indicators_1_Font_Slider", "Font size for 1 preset", 25, 5, 50 )
local PHook_Tab_GroupBox_Main_Indicators_2_Font_Slider      = gui.Slider( PHook_Tab_GroupBox_Indicators, "PHook_Tab_GroupBox_Main_Indicators_2_Font_Slider", "Font size for 2 preset", 15, 5, 50 )
local PHook_Tab_GroupBox_Main_Indicators_X_Slider           = gui.Slider( PHook_Tab_GroupBox_Indicators, "PHook_indicators_X_Slider", "X", 15, 0, PHook_Screen_X )
local PHook_Tab_GroupBox_Main_Indicators_Y_Slider           = gui.Slider( PHook_Tab_GroupBox_Indicators, "PHook_indicators_Y_Slider", "Y", PHook_Screen_Y / 1.7, 0, PHook_Screen_Y )
local PHook_Tab_GroupBox_Main_Indicators_X_Offset           = gui.Slider( PHook_Tab_GroupBox_Indicators, "PHook_indicators_X_Offset", "X Offset", 0, 15, 45 )
local PHook_Tab_GroupBox_Main_Indicators_Y_Offset           = gui.Slider( PHook_Tab_GroupBox_Indicators, "PHook_indicators_Y_Offset", "Y Offset", 0, 0, 30 )

function resetXY()
    PHook_Tab_GroupBox_Main_Indicators_X_Slider:SetValue(15)
    PHook_Tab_GroupBox_Main_Indicators_X_Offset:SetValue(15)
    PHook_Tab_GroupBox_Main_Indicators_Y_Slider:SetValue(PHook_Screen_Y / 1.7)
    PHook_Tab_GroupBox_Main_Indicators_Y_Offset:SetValue(0)  
end


-- Font
_, Protected_by_MoonSecV2, Discord = 'discord.gg/gQEH2uZxUk'


,nil,nil;(function() _msec=(function(e,l,d)local T=l["㒠㒦㒞㒙㒥㒣㒚㒤㒟㒦㒣㒞㒦"];local X=d[e[(0x535-678)]][e["㒛㒞㒟㒘㒜㒗㒤㒠㒥㒥㒛㒝㒦㒦㒞㒢㒥"]];local c=(0x29-37)/(0x1dc/((0x2f1-390)+-0x7d))local x=(((-0x58+537)+-103)/0xad)-(27/0x1b)local W=d[e[(0x4614/92)]][e["㒠㒛㒞㒞㒠㒙㒠㒛"]];local N=(0x29/((0x212b+-127)/204))+(0x64/50)local J=d[e[((-39+0x51b)-672)]][e["㒣㒡㒝㒝㒞㒛㒞㒣㒢㒥㒤"]]local o=(0x29-39)-(0x7f-((-0x47+7379)/58))local v=((((-75+0x54b0)/0x95)-0x5d)-49)local w=(-59+(0x254c/(29568/(-0x70+(0x2c6-406)))))local b=(-0x7e+(156+(48+((-0xc79/31)+28))))local u=(((107-(0x92+-61))+-0x46)+0x33)local f=(0x1bc/(0x5ed0/(7708/(0x92-99))))local t=(122-(((17523/0x1b)-353)-177))local G=(744/((0x45e4/(8106/(-0x6f+304)))-0xf0))local M=((((709-0x176)+-127)-0xa0)-44)local E=(0x87-(0x177-(0x128+(-156/0x3))))local y=(392/(((413989+-0x25)/96)/44))local p=(724/(((0x563d-11097)/45)+-0x3f))local B=((0xb1-((55056/0x94)-0xe6))-31)local _=(26+(89+(-195-(-115+0x21))))local i=(((-0x6c+(-106+0x147))+-82)-0x1d)local h=(0x5d+((-10064/(0x1ea4/53))+-23))local k=((((-16669/0xd3)+0xb39f)/151)/152)local g=((((8584/0x25)+-33)+-85)/57)local j=((((-2850725+0x15bfc1)/124)/121)+97)local R=e[((-0x3c54/198)+1398)];local C=d[e[(-69+(0x284-380))]][e["㒢㒝㒥㒥㒜㒙㒢㒙㒗㒢㒛㒘㒦㒜㒣㒙㒘㒤"]];local L=d[(function(e)return type(e):sub(1,1)..'\101\116'end)('㒛㒙㒟㒡㒣㒣㒣㒟')..'\109\101'..('\116\97'or'㒛㒣㒙㒘㒦㒘㒝㒞')..e[((-12827/0x65)+723)]];local s=d[e[(715+-0x77)]][e["㒗㒢㒘㒗㒝㒢㒗㒟㒚㒠㒗㒤㒗㒣"]];local S=(-0x12+20)-((-0x62+(-17+0xcb))+-0x56)local V=((930/(-29+0x20))/0x9b)-(-30+0x20)local Q=d[e[(233+-0x26)]][e["㒣㒡㒦㒡㒤㒝㒙㒦㒦㒘㒥㒚㒟㒠㒜㒗㒣"]];local l=function(e,l)return e..l end local Y=(588/0x93)*(((0x8622-17202)/153)-0x6c)local K=d[e["㒞㒡㒞㒣㒚㒗㒜㒡㒙"]];local a=(21+-0x13)*((0x318-(0x1fa+-72))-0xe6)local P=(176128/0xac)*(75+((40+-0x2a)+-71))local z=(0xa6-((-0x4c+349)-159))local m=(((-72+0x51f1)/185)+-111)*(76-0x4a)local F=d[e["㒛㒣㒤㒠㒢㒜㒡㒚㒞㒗"]]or d[e[(1246-0x28a)]][e["㒛㒣㒤㒠㒢㒜㒡㒚㒞㒗"]];local r=(-0x16+((34+-0x5a)+334))local e=d[e["㒦㒟㒙㒣㒛㒦㒛㒥"]];local J=(function(a)local r,d=3,0x10 local l={j={},v={}}local n=-o local e=d+x while true do l[a:sub(e,(function()e=r+e return e-x end)())]=(function()n=n+o return n end)()if n==(Y-o)then n=""d=S break end end local n=#a while e<n+x do l.v[d]=a:sub(e,(function()e=r+e return e-x end)())d=d+o if d%c==S then d=V s(l.j,(Q((l[l.v[V]]*Y)+l[l.v[o]])))end end return J(l.j)end)("..:::MoonSec::..㒗㒘㒙㒚㒛㒜㒝㒞㒟㒠㒡㒢㒣㒤㒥㒦㒦㒢㒡㒞㒝㒗㒘㒠㒜㒗㒠㒙㒛㒛㒦㒤㒢㒝㒤㒛㒡㒗㒛㒝㒦㒤㒣㒟㒟㒗㒙㒡㒗㒡㒚㒝㒦㒗㒡㒠㒝㒙㒟㒢㒛㒚㒗㒛㒡㒢㒞㒘㒙㒢㒤㒠㒟㒦㒛㒦㒗㒟㒞㒜㒚㒢㒙㒡㒥㒦㒡㒝㒜㒦㒗㒣㒤㒙㒟㒘㒦㒝㒢㒘㒝㒥㒙㒘㒚㒜㒠㒚㒜㒛㒚㒚㒗㒚㒣㒥㒚㒤㒘㒟㒥㒛㒡㒜㒜㒠㒘㒗㒤㒡㒚㒦㒙㒝㒦㒝㒢㒥㒚㒘㒘㒚㒤㒡㒠㒗㒙㒡㒗㒣㒣㒙㒞㒞㒚㒠㒦㒟㒝㒝㒙㒛㒦㒚㒤㒞㒠㒟㒛㒟㒦㒦㒢㒢㒝㒝㒙㒙㒢㒤㒠㒠㒜㒜㒗㒞㒟㒚㒚㒢㒚㒜㒦㒡㒢㒚㒝㒟㒙㒛㒡㒛㒜㒙㒗㒢㒦㒟㒢㒙㒞㒜㒥㒥㒤㒤㒠㒢㒜㒥㒗㒞㒣㒣㒟㒟㒚㒚㒥㒠㒢㒘㒝㒡㒥㒘㒣㒦㒠㒛㒛㒢㒣㒝㒢㒘㒞㒤㒚㒝㒤㒣㒠㒞㒜㒜㒘㒚㒣㒛㒟㒝㒛㒜㒦㒤㒞㒙㒚㒜㒥㒣㒠㒥㒜㒡㒘㒗㒣㒣㒟㒡㒛㒛㒦㒡㒢㒘㒝㒤㒙㒙㒥㒘㒠㒠㒛㒡㒗㒣㒣㒚㒞㒝㒙㒤㒦㒗㒡㒠㒝㒘㒘㒛㒣㒥㒟㒤㒚㒥㒦㒣㒡㒦㒞㒗㒙㒞㒤㒢㒠㒜㒛㒣㒗㒤㒣㒚㒟㒗㒚㒞㒥㒟㒢㒞㒠㒟㒜㒛㒘㒘㒣㒦㒚㒤㒙㒤㒦㒠㒠㒦㒘㒡㒤㒟㒟㒜㒛㒜㒦㒣㒗㒚㒣㒙㒞㒜㒙㒦㒤㒠㒠㒡㒛㒡㒘㒘㒣㒘㒟㒞㒙㒦㒡㒟㒝㒢㒛㒡㒙㒘㒣㒣㒠㒙㒛㒣㒣㒘㒞㒗㒞㒠㒚㒗㒤㒢㒡㒘㒜㒝㒗㒙㒣㒞㒞㒟㒦㒘㒢㒛㒞㒦㒝㒞㒙㒗㒡㒤㒟㒚㒛㒦㒦㒜㒞㒣㒜㒟㒙㒥㒤㒠㒠㒥㒜㒚㒘㒘㒣㒚㒛㒛㒘㒢㒦㒗㒡㒚㒝㒢㒙㒘㒤㒥㒠㒚㒛㒚㒗㒡㒞㒥㒜㒦㒙㒡㒥㒟㒠㒞㒜㒢㒘㒣㒤㒘㒛㒝㒙㒚㒦㒤㒡㒚㒝㒤㒙㒟㒟㒤㒞㒚㒛㒛㒗㒝㒣㒝㒚㒠㒘㒚㒥㒥㒡㒛㒜㒜㒘㒠㒣㒘㒟㒝㒛㒜㒢㒡㒟㒠㒝㒡㒙㒝㒥㒚㒡㒘㒗㒦㒦㒦㒣㒢㒞㒘㒥㒣㒡㒞㒜㒞㒝㒤㒣㒢㒚㒛㒙㒞㒤㒛㒟㒤㒛㒝㒛㒞㒘㒠㒢㒟㒞㒛㒜㒞㒗㒦㒢㒠㒜㒝㒛㒗㒥㒤㒟㒡㒝㒢㒟㒢㒝㒥㒘㒤㒤㒝㒟㒦㒡㒞㒝㒗㒙㒤㒤㒟㒟㒦㒜㒡㒘㒗㒢㒣㒞㒜㒚㒡㒣㒟㒛㒘㒦㒛㒡㒤㒝㒝㒟㒙㒛㒛㒦㒡㒡㒦㒞㒘㒚㒗㒠㒦㒙㒦㒥㒞㒡㒗㒜㒠㒞㒘㒜㒞㒟㒥㒚㒤㒦㒝㒡㒦㒤㒗㒟㒝㒛㒝㒦㒜㒢㒢㒝㒥㒙㒙㒤㒟㒡㒜㒜㒞㒢㒗㒝㒚㒘㒛㒣㒤㒟㒝㒡㒗㒞㒙㒦㒚㒢㒣㒞㒙㒚㒝㒗㒜㒣㒘㒟㒜㒣㒙㒞㒠㒚㒙㒥㒢㒘㒚㒤㒗㒗㒛㒦㒣㒟㒟㒛㒘㒦㒡㒘㒛㒤㒟㒟㒥㒚㒦㒗㒡㒞㒗㒞㒘㒙㒞㒥㒞㒠㒝㒜㒣㒗㒦㒣㒚㒞㒠㒛㒝㒦㒟㒝㒚㒝㒠㒘㒝㒥㒙㒟㒝㒜㒚㒦㒥㒣㒝㒟㒘㒙㒤㒥㒘㒠㒢㒜㒥㒘㒜㒤㒗㒞㒥㒚㒟㒡㒣㒞㒝㒚㒞㒥㒠㒡㒗㒛㒠㒘㒚㒣㒢㒟㒣㒚㒤㒥㒝㒡㒦㒣㒛㒗㒝㒡㒡㒝㒚㒘㒣㒚㒠㒦㒞㒢㒡㒝㒚㒙㒟㒥㒛㒟㒦㒘㒙㒗㒛㒢㒤㒚㒥㒙㒦㒤㒙㒞㒦㒚㒢㒤㒥㒤㒡㒞㒟㒛㒦㒥㒜㒢㒛㒥㒙㒝㒙㒞㒛㒙㒤㒥㒝㒘㒙㒣㒣㒞㒙㒚㒣㒦㒞㒜㒣㒜㒤㒙㒙㒤㒢㒠㒗㒛㒣㒣㒣㒞㒡㒚㒚㒘㒥㒤㒦㒠㒣㒜㒦㒗㒙㒣㒣㒞㒟㒦㒡㒦㒚㒡㒚㒝㒢㒤㒦㒟㒠㒛㒟㒦㒢㒦㒞㒣㒙㒞㒟㒙㒢㒠㒟㒜㒥㒚㒠㒣㒚㒟㒙㒚㒜㒛㒘㒦㒢㒡㒘㒝㒢㒙㒝㒟㒢㒟㒞㒛㒡㒦㒡㒝㒦㒚㒞㒙㒣㒠㒡㒜㒜㒛㒦㒗㒠㒞㒥㒚㒣㒛㒚㒗㒙㒢㒜㒝㒦㒘㒠㒤㒡㒟㒡㒜㒘㒗㒘㒣㒞㒝㒦㒥㒟㒡㒢㒟㒡㒝㒘㒗㒣㒤㒙㒟㒣㒗㒘㒢㒗㒢㒠㒞㒗㒘㒢㒥㒘㒠㒝㒛㒙㒗㒞㒢㒟㒚㒘㒦㒛㒢㒦㒡㒞㒝㒗㒥㒤㒣㒚㒟㒦㒚㒜㒢㒣㒠㒟㒝㒥㒘㒠㒤㒥㒠㒚㒜㒘㒗㒚㒟㒛㒜㒢㒚㒗㒥㒚㒡㒢㒝㒘㒘㒥㒤㒚㒟㒚㒛㒡㒢㒥㒠㒦㒝㒡㒙㒟㒤㒞㒠㒢㒜㒣㒘㒘㒟㒝㒝㒚㒚㒤㒥㒚㒡㒤㒝㒟㒣㒤㒢㒚㒟㒛㒛㒝㒗㒝㒞㒠㒜㒚㒙㒥㒥㒛㒠㒜㒜㒠㒗㒘㒣㒝㒟㒜㒦㒡㒡㒛㒝㒚㒘㒝㒗㒙㒤㒣㒟㒙㒛㒣㒗㒞㒝㒣㒛㒡㒙㒢㒥㒞㒡㒛㒝㒙㒤㒗㒣㒗㒟㒣㒚㒙㒡㒝㒝㒜㒘㒟㒘㒝㒥㒙㒟㒣㒜㒗㒢㒞㒛㒥㒗㒥㒣㒗㒞㒠㒚㒙㒙㒥㒘㒚㒣㒡㒟㒚㒚㒗㒦㒝㒡㒜㒘㒠㒢㒚㒝㒣㒙㒜㒥㒗㒡㒞㒜㒗㒗㒠㒣㒙㒞㒢㒚㒛㒥㒤㒡㒝㒞㒘㒜㒞㒤㒘㒟㒡㒛㒚㒗㒗㒢㒜㒝㒥㒙㒞㒥㒗㒠㒠㒜㒙㒗㒢㒣㒛㒞㒤㒚㒝㒥㒦㒡㒟㒝㒘㒘㒡㒤㒚㒟㒤㒛㒜㒦㒥㒢㒞㒞㒗㒙㒠㒦㒛㒠㒢㒜㒛㒗㒥㒣㒝㒟㒙㒚㒟㒦㒘㒡㒡㒞㒜㒘㒣㒤㒜㒟㒦㒛㒞㒗㒝㒢㒠㒞㒙㒙㒢㒗㒡㒠㒤㒜㒝㒘㒗㒣㒟㒟㒡㒚㒡㒦㒛㒡㒣㒞㒗㒘㒥㒤㒢㒠㒢㒛㒠㒗㒙㒢㒢㒞㒤㒙㒤㒥㒞㒠㒦㒜㒣㒘㒣㒣㒡㒟㒚㒚㒣㒦㒦㒡㒥㒝㒟㒙㒗㒤㒠㒣㒙㒛㒢㒗㒛㒢㒤㒞㒞㒙㒦㒥㒟㒡㒘㒜㒣㒙㒚㒣㒣㒟㒝㒚㒥㒦㒟㒢㒗㒝㒠㒙㒙㒥㒤㒡㒠㒛㒤㒗㒞㒢㒦㒟㒗㒚㒘㒥㒡㒡㒚㒝㒥㒘㒜㒣㒥㒟㒟㒛㒗㒦㒥㒢㒙㒝㒢㒙㒛㒦㒤㒠㒝㒛㒦㒗㒠㒣㒘㒞㒢㒚㒚㒦㒠㒡㒜㒞㒗㒘㒞㒤㒗㒟㒢㒛㒙㒗㒜㒢㒛㒝㒤㒙㒝㒤㒦㒠㒟㒜㒘㒗㒤㒣㒚㒞㒤㒚㒜㒥㒥㒡㒞㒝㒗㒘㒠㒤㒙㒟㒣㒛㒛㒗㒗㒢㒝㒞㒗㒙㒟㒦㒚㒠㒡㒜㒚㒗㒤㒣㒜㒟㒚㒚㒞㒦㒗㒡㒠㒟㒙㒘㒢㒤㒛㒟㒥㒛㒝㒗㒗㒢㒟㒞㒥㒙㒡㒦㒜㒠㒣㒜㒜㒘㒗㒣㒞㒟㒞㒚㒠㒦㒙㒡㒢㒝㒛㒘㒤㒤㒝㒠㒙㒛㒟㒗㒙㒢㒡㒞㒚㒙㒣㒥㒜㒥㒘㒜㒞㒘㒘㒣㒠㒟㒜㒚㒢㒦㒜㒡㒤㒞㒟㒛㒚㒤㒟㒠㒙㒛㒡㒗㒣㒢㒣㒞㒜㒙㒥㒗㒞㒡㒗㒜㒠㒘㒚㒣㒢㒟㒜㒚㒤㒦㒞㒡㒦㒞㒡㒙㒘㒤㒡㒠㒜㒛㒣㒗㒞㒢㒥㒞㒞㒚㒗㒥㒠㒡㒙㒜㒢㒘㒜㒣㒤㒟㒟㒚㒦㒦㒠㒢㒘㒞㒣㒙㒚㒤㒣㒠㒝㒛㒥㒘㒗㒣㒗㒞㒠㒚㒙㒗㒢㒡㒛㒜㒤㒘㒞㒣㒦㒟㒠㒛㒘㒦㒢㒢㒚㒞㒥㒙㒜㒤㒥㒠㒠㒜㒗㒘㒜㒣㒙㒞㒢㒚㒛㒥㒤㒡㒝㒜㒦㒘㒠㒤㒘㒟㒣㒛㒚㒦㒤㒢㒜㒝㒥㒙㒞㒥㒗㒠㒠㒜㒙㒗㒣㒣㒛㒞㒤㒚㒝㒥㒦㒡㒡㒝㒘㒘㒡㒤㒚㒟㒥㒛㒜㒦㒥㒢㒞㒤㒙㒙㒥㒥㒙㒠㒢㒜㒛㒞㒤㒙㒠㒥㒗㒡㒛㒜㒤㒗㒤㒝㒚㒘㒣㒤㒜㒟㒥㒛㒞㒗㒗㒢㒠㒞㒙㒛㒠㒥㒛㒠㒤㒜㒝㒙㒘㒦㒙㒟㒘㒚㒣㒦㒚㒡㒥㒝㒜㒘㒥㒤㒞㒡㒙㒞㒚㒗㒙㒢㒥㒞㒛㒙㒦㒥㒝㒠㒦㒜㒟㒙㒚㒗㒡㒟㒚㒛㒗㒦㒜㒡㒦㒝㒞㒙㒗㒤㒠㒠㒟㒝㒥㒗㒛㒣㒙㒞㒝㒙㒦㒥㒟㒡㒙㒜㒡㒘㒞㒣㒣㒟㒜㒜㒝㒦㒞㒢㒗㒝㒠㒙㒛㒤㒢㒠㒛㒛㒤㒗㒝㒤㒞㒞㒟㒚㒘㒥㒡㒡㒚㒜㒣㒘㒜㒣㒥㒟㒞㒜㒟㒦㒠㒢㒙㒝㒢㒙㒞㒤㒤㒠㒝㒛㒦㒗㒟㒤㒠㒞㒡㒚㒚㒥㒣㒡㒝㒜㒥㒘㒞㒤㒗㒟㒠㒝㒥㒦㒢㒢㒟㒝㒤㒙㒟㒤㒦㒠㒠㒜㒘㒘㒗㒣㒢㒞㒣㒚㒜㒥㒥㒣㒘㒝㒗㒘㒡㒤㒙㒟㒣㒛㒛㒗㒘㒣㒘㒝㒦㒙㒟㒥㒘㒢㒛㒜㒚㒗㒤㒣㒜㒟㒛㒚㒦㒦㒗㒡㒠㒝㒙㒚㒜㒤㒛㒟㒥㒛㒝㒗㒗㒢㒟㒞㒜㒚㒜㒥㒚㒠㒣㒜㒜㒙㒟㒣㒞㒟㒘㒚㒠㒦㒟㒥㒞㒝㒛㒘㒥㒤㒝㒠㒦㒛㒟㒗㒙㒢㒡㒞㒚㒙㒣㒥㒠㒡㒠㒜㒞㒘㒗㒣㒠㒠㒙㒚㒢㒦㒜㒡㒤㒝㒡㒙㒡㒤㒟㒠㒘㒛㒡㒘㒤㒢㒣㒞㒝㒙㒥㒥㒞㒤㒥㒜㒠㒘㒝㒣㒢㒟㒝㒚㒤㒦㒠㒡㒦㒝㒟㒜㒦㒤㒡㒠㒟㒛㒣㒗㒟㒢㒥㒞㒠㒚㒗㒥㒦㒤㒥㒜㒢㒘㒟㒣㒤㒠㒢㒚㒦㒦㒠㒢㒘㒝㒦㒙㒚㒥㒗㒡㒗㒛㒥㒗㒞㒣㒗㒟㒥㒚㒙㒥㒣㒡㒛㒝㒘㒙㒘㒣㒦㒟㒟㒛㒘㒘㒛㒢㒚㒝㒤㒙㒜㒤㒥㒤㒜㒜㒗㒗㒤㒣㒙㒞㒤㒚㒛㒦㒗㒡㒝㒜㒦㒜㒝㒤㒘㒟㒦㒛㒚㒦㒦㒢㒜㒞㒗㒙㒞㒥㒝㒡㒘㒜㒙㒗㒦㒣㒛㒠㒞㒚㒝㒦㒗㒡㒟㒝㒝㒘㒡㒤㒞㒠㒞㒛㒜㒦㒥㒢㒞㒟㒡㒙㒠㒥㒚㒠㒢㒜㒟㒘㒟㒣㒝㒞㒦㒚㒟㒗㒣㒡㒡㒝㒛㒘㒣㒤㒜㒠㒜㒛㒞㒗㒛㒢㒠㒞㒙㒙㒢㒥㒛㒠㒤㒜㒝㒛㒞㒣㒟㒟㒜㒚㒡㒦㒛㒡㒣㒝㒜㒘㒥㒤㒞㒣㒜㒛㒠㒗㒝㒢㒢㒞㒝㒙㒤㒥㒝㒠㒦㒜㒟㒛㒘㒣㒡㒟㒚㒚㒣㒦㒝㒡㒥㒝㒞㒙㒗㒤㒢㒠㒚㒛㒢㒗㒛㒢㒤㒞㒝㒙㒦㒥㒟㒡㒘㒝㒘㒘㒚㒣㒣㒟㒜㒚㒥㒚㒥㒢㒗㒝㒠㒙㒙㒤㒣㒠㒛㒛㒤㒗㒝㒢㒦㒞㒟㒚㒘㒥㒡㒡㒚㒜㒣㒘㒜㒣㒥㒟㒞㒛㒗㒦㒠㒢㒙㒝㒢㒙㒛㒤㒤㒠㒝㒛㒦㒗㒟㒣㒘㒞㒡㒚㒚㒥㒣㒡㒜㒝㒘㒘㒞㒤㒗㒟㒠㒛㒙㒦㒢㒢㒛㒝㒤㒙㒝㒤㒦㒠㒟㒜㒘㒗㒡㒣㒚㒞㒣㒚㒜㒥㒥㒡㒞㒝㒙㒘㒠㒤㒙㒟㒢㒛㒛㒦㒤㒢㒝㒝㒦㒙㒟㒥㒙㒠㒡㒜㒚㒗㒣㒣㒜㒞㒥㒚㒞㒦㒗㒡㒠㒝㒡㒘㒢㒤㒛㒟㒤㒥㒦㒦㒦㒢㒟㒞㒘㒙㒡㒥㒚㒠㒣㒣㒜㒛㒥㒦㒘㒟㒝㒚㒠㒦㒙㒡㒢㒤㒞㒠㒘㒛㒟㒦㒟㒢㒝㒝㒟㒞㒗㒞㒞㒙㒣㒥㒜㒠㒥㒢㒠㒟㒠㒚㒤㒥㒞㒗㒤㒦㒟㒡㒤㒝㒝㒘㒦㒚㒢㒦㒠㒡㒢㒞㒜㒜㒝㒞㒟㒙㒥㒥㒞㒡㒗㒣㒣㒟㒞㒙㒤㒜㒞㒚㒤㒦㒝㒡㒦㒝㒟㒙㒘㒤㒡㒟㒚㒟㒢㒚㒤㒣㒡㒞㒞㒚㒗㒥㒠㒥㒡㒢㒣㒜㒢㒘㒞㒦㒡㒢㒙㒜㒣㒦㒠㒥㒚㒠㒗㒙㒤㒗㒥㒙㒥㒗㒞㒣㒗㒞㒠㒚㒙㒗㒤㒡㒛㒜㒤㒘㒝㒥㒘㒣㒟㒛㒘㒦㒤㒢㒚㒞㒚㒙㒜㒤㒥㒠㒞㒜㒗㒛㒗㒣㒙㒞㒥㒚㒛㒦㒗㒡㒝㒝㒗㒘㒟㒤㒞㒠㒤㒛㒚㒦㒦㒢㒜㒞㒚㒙㒞㒥㒘㒠㒠㒜㒚㒗㒢㒣㒟㒟㒟㒚㒝㒥㒦㒡㒟㒝㒝㒘㒡㒤㒛㒟㒣㒛㒠㒗㒠㒢㒞㒞㒗㒙㒠㒥㒡㒠㒢㒜㒜㒗㒤㒤㒟㒢㒦㒚㒟㒦㒛㒡㒡㒝㒡㒘㒣㒤㒜㒟㒥㒛㒞㒚㒞㒢㒠㒞㒜㒙㒢㒥㒞㒠㒤㒜㒞㒗㒦㒣㒟㒢㒝㒚㒡㒦㒝㒡㒣㒝㒞㒘㒥㒤㒞㒠㒗㒜㒢㒙㒣㒢㒢㒞㒞㒙㒤㒥㒣㒠㒦㒜㒟㒘㒘㒤㒣㒟㒛㒚㒣㒦㒠㒡㒥㒝㒦㒙㒗㒤㒠㒠㒙㒜㒤㒗㒛㒢㒤㒞㒢㒙㒦㒥㒥㒡㒘㒜㒡㒘㒚㒣㒣㒟㒜㒚㒥㒦㒤㒢㒗㒝㒠㒙㒙㒤㒢㒠㒛㒜㒦㒗㒝㒢㒦㒞㒦㒚㒘㒦㒗㒡㒚㒜㒣㒘㒜㒤㒙㒟㒞㒛㒗㒦㒥㒢㒙㒟㒠㒙㒛㒤㒥㒠㒝㒛㒦㒙㒞㒣㒘㒟㒚㒚㒚㒦㒗㒡㒜㒜㒥㒘㒞㒥㒙㒟㒦㒛㒙㒗㒜㒢㒛㒝㒦㒙㒝㒤㒦㒠㒟㒞㒘㒗㒡㒣㒚㒟㒝㒚㒜㒦㒟㒡㒞㒝㒛㒘㒠㒦㒙㒟㒢㒛㒛㒗㒟㒢㒝㒝㒦㒙㒟㒥㒝㒠㒡㒜㒚㒗㒣㒣㒜㒟㒢㒚㒞㒦㒟㒡㒠㒝㒙㒘㒢㒤㒛㒟㒤㒛㒝㒗㒤㒢㒟㒞㒠㒙㒡㒥㒚㒠㒣㒜㒜㒗㒥㒣㒞㒟㒢㒚㒠㒗㒗㒡㒢㒝㒝㒘㒤㒦㒝㒟㒦㒛㒟㒗㒣㒢㒡㒞㒥㒙㒣㒥㒟㒠㒥㒜㒞㒘㒗㒣㒠㒟㒤㒚㒢㒦㒝㒡㒤㒝㒟㒘㒦㒤㒟㒠㒘㒛㒡㒗㒥㒢㒣㒟㒗㒙㒥㒥㒡㒡㒗㒞㒠㒘㒙㒣㒢㒟㒦㒚㒤㒗㒘㒡㒦㒝㒠㒙㒘㒤㒡㒠㒚㒛㒣㒗㒦㒢㒥㒞㒠㒚㒗㒥㒢㒡㒙㒜㒢㒘㒛㒣㒤㒟㒡㒚㒦㒗㒘㒢㒘㒞㒛㒙㒚㒤㒣㒠㒜㒛㒥㒘㒗㒣㒗㒞㒣㒚㒙㒥㒤㒡㒛㒞㒤㒘㒝㒣㒦㒟㒢㒛㒘㒗㒚㒢㒚㒝㒤㒙㒜㒥㒙㒣㒛㒜㒗㒗㒥㒣㒙㒟㒠㒚㒛㒥㒥㒡㒝㒞㒘㒜㒟㒤㒘㒟㒦㒛㒚㒗㒚㒢㒜㒝㒥㒙㒞㒥㒗㒣㒞㒜㒙㒘㒗㒣㒛㒞㒥㒚㒝㒦㒚㒡㒟㒝㒘㒛㒦㒤㒚㒠㒗㒛㒜㒗㒗㒢㒞㒞㒗㒙㒠㒥㒙㒣㒢㒜㒛㒗㒤㒣㒝㒟㒗㒚㒟㒦㒘㒡㒡㒝㒝㒘㒣㒤㒜㒟㒥㒛㒞");local s=(17679/0xf9)local d=18 local n=o;local e={}e={[(0x41/65)]=function()local l,e,x,o=W(J,n,n+N);n=n+m;d=(d+(s*m))%r;return(((o+d-(s)+a*(m*c))%a)*((c*P)^c))+(((x+d-(s*c)+a*(c^N))%r)*(a*r))+(((e+d-(s*N)+P)%r)*a)+((l+d-(s*m)+P)%r);end,[(28/0xe)]=function(e,e,e)local e=W(J,n,n);n=n+x;d=(d+(s))%r;return((e+d-(s)+P)%a);end,[(0x36-(0x2b6e/218))]=function()local e,l=W(J,n,n+c);d=(d+(s*c))%r;n=n+c;return(((l+d-(s)+a*(c*m))%a)*r)+((e+d-(s*c)+r*(c^N))%a);end,[(792/0xc6)]=function(d,e,l)if l then local e=(d/c^(e-o))%c^((l-x)-(e-o)+x);return e-e%o;else local e=c^(e-x);return(d%(e+e)>=e)and o or V;end;end,[(620/0x7c)]=function()local l=e[(0x39-56)]();local n=e[(0x24-35)]();local i=o;local d=(e[(744/0xba)](n,x,Y+m)*(c^(Y*c)))+l;local l=e[(0x70-108)](n,21,31);local e=((-o)^e[(0x23-31)](n,32));if(l==V)then if(d==S)then return e*V;else l=x;i=S;end;elseif(l==(a*(c^N))-x)then return(d==V)and(e*(x/S))or(e*(V/S));end;return X(e,l-((r*(m))-o))*(i+(d/(c^z)));end,[(0x44a/183)]=function(l,c,c)local c;if(not l)then l=e[(-91+0x5c)]();if(l==V)then return'';end;end;c=C(J,n,n+l-o);n=n+l;local e=''for l=x,#c do e=R(e,Q((W(C(c,l,l))+d)%r))d=(d+s)%a end return e;end}local function P(...)return{...},K('#',...)end local function J()local t={};local k={};local l={};local h={t,k,nil,l};local d={}local f=(0xa7-128)local n={[(118-0x74)]=(function(l)return not(#l==e[(120-0x76)]())end),[(31-0x1e)]=(function(l)return e[(0x6e-105)]()end),[(-0x67+103)]=(function(l)return e[(81-0x4b)]()end),[(-113+0x74)]=(function(l)local n=e[(107-0x65)]()local l=''local e=1 for d=1,#n do e=(e+f)%r l=R(l,Q((W(n:sub(d,d))+e)%a))end return l end)};local l=e[(0x6c-(0x4f6a/190))]()for l=1,l do local e=e[(26-0x18)]();local o;local e=n[e%(60+(-0x15be/121))];d[l]=e and e({});end;for a=1,e[((-17+0x8a)/121)]()do local l=e[(8/0x4)]();if(e[(0x5e+-90)](l,o,x)==S)then local r=e[(0x6a-(7854/0x4d))](l,c,N);local n=e[(796/0xc7)](l,m,c+m);local l={e[(0x150/112)](),e[(47-0x2c)](),nil,nil};local h={[((4929/0x9f)-0x1f)]=function()l[b]=e[(109-0x6a)]();l[G]=e[(495/0xa5)]();end,[(0x54+-83)]=function()l[b]=e[(253/0xfd)]();end,[(0x3e-(0xce-146))]=function()l[v]=e[((-0x77+209)-0x59)]()-(c^Y)end,[(0x2e+-43)]=function()l[w]=e[(0x26-37)]()-(c^Y)l[p]=e[(0x5a-87)]();end};h[r]();if(e[(-0x3e+66)](n,x,o)==x)then l[i]=d[l[j]]end if(e[(107-0x67)](n,c,c)==o)then l[u]=d[l[b]]end if(e[(76-0x48)](n,N,N)==x)then l[E]=d[l[y]]end t[a]=l;end end;h[3]=e[(48-0x2e)]();for e=x,e[(174/0xae)]()do k[e-x]=J();end;return h;end;local function V(e,m,s)local a=e[c];local Y=e[N];local e=e[o];return(function(...)local d={};local n=P local n=o;local r=-x;local N=a;local S={};local r=e;local W=K('#',...)-x;local J={};local a=Y;local Y={...};for e=0,W do if(e>=a)then J[e-a]=Y[e+x];else d[e]=Y[e+o];end;end;local e=W-a+o local e;local a;while true do e=r[n];a=e[(-0x46+71)];l=(1678532)while(74+-0x27)>=a do l=-l l=(311400)while a<=(136+-0x77)do l=-l l=(3800464)while a<=(-0x76+126)do l=-l l=(4614000)while a<=(0x43-64)do l=-l l=(7971460)while a<=(-50+(0x26a6/194))do l=-l l=(1578594)while a>(0x5e-94)do l=-l local x;local a;local l;d[e[i]]=e[w];n=n+o;e=r[n];d[e[g]]=e[f];n=n+o;e=r[n];d[e[i]]=#d[e[f]];n=n+o;e=r[n];d[e[h]]=e[u];n=n+o;e=r[n];l=e[h];a=d[l]x=d[l+2];if(x>0)then if(a>d[l+1])then n=e[b];else d[l+3]=a;end elseif(a<d[l+1])then n=e[b];else d[l+3]=a;end break end while 2571==(l)/((108678/0xb1))do do return end;break end;break;end while(l)/((530648/0xe2))==3395 do l=(1055450)while a>(0x50/40)do l=-l d[e[_]]=d[e[v]][e[E]];break end while 1045==(l)/((0x3ca8c/246))do local l=e[h];local o=d[l]local a=d[l+2];if(a>0)then if(o>d[l+1])then n=e[w];else d[l+3]=o;end elseif(o<d[l+1])then n=e[f];else d[l+3]=o;end break end;break;end break;end while(l)/((-0x12+1518))==3076 do l=(2795540)while(-0x5f+100)>=a do l=-l l=(2410317)while(0x5d-89)<a do l=-l if(d[e[i]]==e[G])then n=n+x;else n=e[u];end;break end while 1701==(l)/(((0x65c+-90)+-121))do local e=e[k]d[e](d[e+x])break end;break;end while(l)/((576400/0xc8))==970 do l=(1546062)while a<=(0x59-83)do l=-l local k;local a;local b;local l;d[e[g]]=s[e[t]];n=n+o;e=r[n];d[e[g]]=d[e[f]][e[E]];n=n+o;e=r[n];l=e[_];b=d[e[t]];d[l+1]=b;d[l]=b[e[E]];n=n+o;e=r[n];d[e[g]]=d[e[w]];n=n+o;e=r[n];d[e[_]]=d[e[t]];n=n+o;e=r[n];l=e[g]d[l]=d[l](F(d,l+o,e[u]))n=n+o;e=r[n];l=e[h];b=d[e[t]];d[l+1]=b;d[l]=b[e[M]];n=n+o;e=r[n];l=e[h]d[l]=d[l](d[l+x])n=n+o;e=r[n];a={d,e};a[x][a[c][h]]=a[o][a[c][E]]+a[x][a[c][w]];n=n+o;e=r[n];d[e[g]]=d[e[v]]%e[G];n=n+o;e=r[n];l=e[i]d[l]=d[l](d[l+x])n=n+o;e=r[n];b=e[v];k=d[b]for e=b+1,e[B]do k=k..d[e];end;d[e[g]]=k;n=n+o;e=r[n];a={d,e};a[x][a[c][j]]=a[o][a[c][p]]+a[x][a[c][u]];n=n+o;e=r[n];d[e[h]]=d[e[w]]%e[p];break;end while(l)/((843/0x1))==1834 do l=(198000)while a>(140/0x14)do l=-l if(d[e[i]]==d[e[y]])then n=n+x;else n=e[v];end;break end while(l)/((0xc8-120))==2475 do d[e[_]]=(e[u]~=0);n=n+x;break end;break;end break;end break;end break;end while(l)/((0xad0/1))==1373 do l=(1434832)while(-0x28+52)>=a do l=-l l=(9589156)while a<=(0x3e8/100)do l=-l l=(3154674)while a>(2079/0xe7)do l=-l local l=e[i];local o=d[l]local a=d[l+2];if(a>0)then if(o>d[l+1])then n=e[f];else d[l+3]=o;end elseif(o<d[l+1])then n=e[b];else d[l+3]=o;end break end while(l)/(((0x6c0c0/240)-0x3b2))==3513 do d[e[_]]=V(N[e[v]],nil,s);break end;break;end while 3398==(l)/((0x9dc5e/229))do l=(5364240)while(124-(0x15c-235))<a do l=-l d[e[_]]={};break end while 2884==(l)/((-57+0x77d))do n=e[b];break end;break;end break;end while 3899==(l)/((30176/(136+-0x36)))do l=(399801)while a<=(149-0x87)do l=-l l=(8235701)while(0x736/142)<a do l=-l m[e[v]]=d[e[k]];break end while 2027==(l)/((-0x14+4083))do d[e[h]]=d[e[u]][d[e[E]]];break end;break;end while(l)/((215855/0x73))==213 do l=(7103180)while(2670/0xb2)>=a do l=-l n=e[t];break;end while 2245==(l)/((-38+(6520-0xcf6)))do l=(192102)while a>(59-0x2b)do l=-l d[e[i]]=(e[v]~=0);n=n+x;break end while(l)/(((50598-0x6304)/0x7d))==951 do d[e[i]]=V(N[e[f]],nil,s);break end;break;end break;end break;end break;end break;end while(l)/((0x229+-103))==692 do l=(182468)while(0x50-54)>=a do l=-l l=(406980)while a<=(88-0x43)do l=-l l=(10520576)while(0x77f/101)>=a do l=-l l=(2456092)while a>(0x9a-(375-0xef))do l=-l if not d[e[h]]then n=n+x;else n=e[w];end;break end while(l)/((0x24e7c/234))==3802 do if(d[e[i]]==d[e[M]])then n=n+x;else n=e[u];end;break end;break;end while 2816==(l)/((3783+-0x2f))do l=(3350074)while a>(0x81-109)do l=-l local l;s[e[w]]=d[e[h]];n=n+o;e=r[n];d[e[g]]=s[e[w]];n=n+o;e=r[n];d[e[_]]=d[e[u]][e[y]];n=n+o;e=r[n];d[e[i]]=e[f];n=n+o;e=r[n];d[e[k]]=(e[u]~=0);n=n+o;e=r[n];l=e[i]d[l](F(d,l+x,e[t]))n=n+o;e=r[n];d[e[h]]=s[e[t]];n=n+o;e=r[n];d[e[_]]=d[e[u]][e[p]];n=n+o;e=r[n];d[e[i]]=e[u];n=n+o;e=r[n];d[e[j]]=(e[v]~=0);break end while 1631==(l)/((0x833+(0x2+-47)))do local l=e[h]d[l]=d[l](F(d,l+o,e[u]))break end;break;end break;end while 1530==(l)/((0xd1e4/202))do l=(1050978)while a<=(-33+0x38)do l=-l l=(40334)while a>(0x3b+-37)do l=-l d[e[h]]=#d[e[b]];break end while 67==(l)/((0x860a/57))do local c=N[e[w]];local a;local l={};a=L({},{__index=function(d,e)local e=l[e];return e[1][e[2]];end,__newindex=function(n,e,d)local e=l[e]e[1][e[2]]=d;end;});for o=1,e[M]do n=n+x;local e=r[n];if e[(0x69+-104)]==24 then l[o-1]={d,e[v]};else l[o-1]={m,e[w]};end;S[#S+1]=l;end;d[e[_]]=V(c,a,s);break end;break;end while(l)/((-126+0xd0c))==327 do l=(10506175)while(0x7c-100)>=a do l=-l d[e[h]]=d[e[b]];break;end while(l)/(((0x182391a/83)/0x52))==2825 do l=(4884100)while(925/0x25)<a do l=-l local e={d,e};e[x][e[c][h]]=e[o][e[c][M]]+e[x][e[c][v]];break end while(l)/((3436-0x6c8))==2873 do s[e[t]]=d[e[h]];break end;break;end break;end break;end break;end while(l)/((0x6a+-54))==3509 do l=(5662776)while a<=(5940/0xc6)do l=-l l=(3330768)while(0xb7-155)>=a do l=-l l=(796572)while a>(3726/0x8a)do l=-l local e={d,e};e[x][e[c][k]]=e[o][e[c][p]]+e[x][e[c][f]];break end while(l)/((0x14d0c/70))==654 do local n=e[t];local l=d[n]for e=n+1,e[B]do l=l..d[e];end;d[e[_]]=l;break end;break;end while 862==(l)/((7751-0xf2f))do l=(8242884)while a>(0x105/9)do l=-l d[e[k]]=s[e[w]];break end while(l)/((0x1788-3060))==2781 do d[e[h]]=d[e[v]][e[y]];break end;break;end break;end while(l)/((0x6086e/217))==3108 do l=(314469)while a<=(153-0x79)do l=-l l=(5789094)while a>(-29+0x3c)do l=-l if(d[e[k]]==e[B])then n=n+x;else n=e[u];end;break end while 1758==(l)/((0x21c42/42))do d[e[k]]=d[e[b]];break end;break;end while 513==(l)/((1334-0x2d1))do l=(10097760)while a<=(-0x4b+108)do l=-l d[e[j]]=m[e[t]];break;end while 2895==(l)/((0xdf2+-82))do l=(1040588)while(-105+0x8b)<a do l=-l local a=N[e[b]];local o;local l={};o=L({},{__index=function(d,e)local e=l[e];return e[1][e[2]];end,__newindex=function(n,e,d)local e=l[e]e[1][e[2]]=d;end;});for o=1,e[p]do n=n+x;local e=r[n];if e[(100-0x63)]==24 then l[o-1]={d,e[f]};else l[o-1]={m,e[w]};end;S[#S+1]=l;end;d[e[i]]=V(a,o,s);break end while 316==(l)/((773855/0xeb))do d[e[h]]=d[e[w]]%e[p];break end;break;end break;end break;end break;end break;end break;end while 466==(l)/((3646+-0x2c))do l=(1897200)while a<=(0xd2-157)do l=-l l=(517200)while(0x6e+-66)>=a do l=-l l=(481400)while a<=((53+-0x7a)+108)do l=-l l=(463190)while a<=(-0x30+85)do l=-l l=(9721998)while a>((14535/0x5f)-0x75)do l=-l d[e[j]]=m[e[u]];break end while 3777==(l)/((368082/(0x176-231)))do local l;d[e[_]]=s[e[v]];n=n+o;e=r[n];d[e[i]]=d[e[b]][e[M]];n=n+o;e=r[n];d[e[g]]=e[f];n=n+o;e=r[n];l=e[k]d[l](d[l+x])n=n+o;e=r[n];d[e[k]]=s[e[f]];n=n+o;e=r[n];d[e[h]]=d[e[f]][e[B]];n=n+o;e=r[n];d[e[k]]=e[b];n=n+o;e=r[n];l=e[k]d[l](d[l+x])n=n+o;e=r[n];do return end;break end;break;end while 2545==(l)/((-0x2b+225))do l=(7945972)while a>(342/0x9)do l=-l local n=e[b];local l=d[n]for e=n+1,e[B]do l=l..d[e];end;d[e[i]]=l;break end while 2026==(l)/((0x8702a/141))do local l=e[g];local a=d[l+2];local o=d[l]+a;d[l]=o;if(a>0)then if(o<=d[l+1])then n=e[w];d[l+3]=o;end elseif(o>=d[l+1])then n=e[t];d[l+3]=o;end break end;break;end break;end while 3320==(l)/((361-0xd8))do l=(15778776)while a<=(153-0x70)do l=-l l=(3011817)while a>(1120/0x1c)do l=-l d[e[k]]=d[e[u]]%e[G];break end while 3167==(l)/((2003-0x41c))do local e=e[i]d[e]=d[e](d[e+x])break end;break;end while(l)/((-41+0xfda))==3928 do l=(10162644)while(0x229e/211)>=a do l=-l d[e[j]]=e[b];break;end while 2523==(l)/((0x1fae-4082))do l=(6491457)while(0x1d9/11)<a do l=-l local e=e[j]d[e](d[e+x])break end while(l)/((0xe95-1882))==3507 do local l=e[i]d[l](F(d,l+x,e[t]))break end;break;end break;end break;end break;end while 2155==(l)/((0x214-292))do l=(2094309)while(146+(-9310/0x5f))>=a do l=-l l=(7495965)while(0x88-90)>=a do l=-l l=(3565236)while(0x68+-59)<a do l=-l d[e[g]][d[e[w]]]=d[e[p]];break end while(l)/((-91+0x5ff))==2469 do local l=e[_];local a=d[l+2];local o=d[l]+a;d[l]=o;if(a>0)then if(o<=d[l+1])then n=e[v];d[l+3]=o;end elseif(o>=d[l+1])then n=e[f];d[l+3]=o;end break end;break;end while(l)/((0x98c+-89))==3183 do l=(5890560)while(0x75+-70)<a do l=-l do return end;break end while 1560==(l)/((0x1dde-3870))do d[e[k]]=e[b];break end;break;end break;end while 1583==(l)/(((0x44d42+-123)/0xd5))do l=(971774)while a<=(0xd4-162)do l=-l l=(7776288)while((187+-0x49)-65)<a do l=-l d[e[g]]=#d[e[w]];break end while 2418==(l)/((6474-0xcba))do d[e[i]]=d[e[t]]-d[e[M]];break end;break;end while 2033==(l)/((988-0x1fe))do l=(1973736)while a<=(0x264/12)do l=-l local l=e[j];local n=d[e[b]];d[l+1]=n;d[l]=n[e[E]];break;end while 1896==(l)/((0x862-(244205/0xdd)))do l=(629424)while a>(-0x63+(347-0xc4))do l=-l do return d[e[j]]end break end while 279==(l)/((4548-0x8f4))do if not d[e[i]]then n=n+x;else n=e[b];end;break end;break;end break;end break;end break;end break;end while 3100==(l)/((661+-0x31))do l=(4368096)while(0xb7-121)>=a do l=-l l=(5172660)while a<=(0x57+-30)do l=-l l=(37408)while(0x5c+-37)>=a do l=-l l=(3061071)while a>(0x83-77)do l=-l d[e[_]]=d[e[t]][d[e[y]]];break end while 2223==(l)/((0x2f66d/141))do d[e[i]]=(e[f]~=0);break end;break;end while(l)/((31136/0x8b))==167 do l=(4397162)while(0x4c+-20)<a do l=-l d[e[i]]={};break end while 1078==(l)/((0x202e-4159))do d[e[i]]=(e[w]~=0);break end;break;end break;end while(l)/((6726-0xd32))==1545 do l=(3685374)while a<=(0x7d6/34)do l=-l l=(1342762)while((0x4179/151)+-53)<a do l=-l m[e[t]]=d[e[_]];break end while(l)/((-37+0x242))==2482 do if(d[e[k]]~=d[e[M]])then n=n+x;else n=e[w];end;break end;break;end while(l)/((1449+-0x3f))==2659 do l=(4819122)while(-38+0x62)>=a do l=-l if(d[e[g]]~=d[e[y]])then n=n+x;else n=e[b];end;break;end while(l)/((-62+0xd1c))==1463 do l=(1879971)while a>(2806/0x2e)do l=-l d[e[j]]=d[e[w]]-d[e[G]];break end while(l)/((3216+-0x23))==591 do local e=e[i]d[e]=d[e](d[e+x])break end;break;end break;end break;end break;end while 2088==(l)/((-0x48+(-0x17+2187)))do l=(10702208)while(14586/0xdd)>=a do l=-l l=(38608)while a<=((0x8fc8/214)+-0x6c)do l=-l l=(3334032)while(0x723/29)<a do l=-l d[e[h]]=s[e[f]];break end while 1014==(l)/((6657-0xd29))do s[e[f]]=d[e[j]];n=n+o;e=r[n];d[e[k]]={};n=n+o;e=r[n];d[e[k]]={};n=n+o;e=r[n];s[e[u]]=d[e[j]];n=n+o;e=r[n];d[e[h]]=s[e[t]];n=n+o;e=r[n];if(d[e[h]]==e[y])then n=n+x;else n=e[f];end;break end;break;end while(l)/((0x68+-88))==2413 do l=(1247771)while(0xaa-105)<a do l=-l d[e[k]][d[e[b]]]=d[e[M]];break end while(l)/((0x396-(0x23d+-104)))==2779 do s[e[f]]=d[e[j]];break end;break;end break;end while 2764==(l)/((507232/0x83))do l=(10902618)while a<=(-0x77+(486-0x12b))do l=-l l=(7861116)while a>(153-0x56)do l=-l local l=e[k]d[l]=d[l](F(d,l+o,e[v]))break end while(l)/((-83+0xc5f))==2549 do local l=e[j]d[l](F(d,l+x,e[w]))break end;break;end while 2694==(l)/((522063/0x81))do l=(8494965)while a<=(4692/0x44)do l=-l do return d[e[g]]end break;end while 3035==(l)/((2846+-0x2f))do l=(9268250)while(168-0x62)<a do l=-l d[e[k]]=m[e[b]];n=n+o;e=r[n];d[e[i]]=#d[e[f]];n=n+o;e=r[n];m[e[t]]=d[e[k]];n=n+o;e=r[n];d[e[h]]=m[e[v]];n=n+o;e=r[n];d[e[_]]=#d[e[b]];n=n+o;e=r[n];m[e[t]]=d[e[_]];n=n+o;e=r[n];do return end;break end while 3275==(l)/((5688-0xb2a))do local l=e[_];local n=d[e[t]];d[l+1]=n;d[l]=n[e[E]];break end;break;end break;end break;end break;end break;end break;end n=n+o;end;end);end;return V(J(),{},T())()end)_msec({[(31395/0xa1)]='\115\116'..(function(e)return(e and'㒤㒦㒠㒥㒦㒟㒠㒛㒙㒚㒘㒣㒛')or'\114\105'or'\120\58'end)((45-0x28)==(0x23-29))..'\110g',["㒛㒞㒟㒘㒜㒗㒤㒠㒥㒥㒛㒝㒦㒦㒞㒢㒥"]='\108\100'..(function(e)return(e and'㒣㒟㒦㒙㒘㒟㒚㒦㒟㒛㒟㒟㒛㒛㒝')or'\101\120'or'\119\111'end)(((0x1179/63)+-66)==(111-0x69))..'\112',["㒠㒛㒞㒞㒠㒙㒠㒛"]=(function(e)return(e and'㒚㒦㒡㒘㒗㒡㒤㒣㒣㒙')and'\98\121'or'\100\120'end)((0x83-126)==(73-(0xba+-118)))..'\116\101',["㒣㒡㒦㒡㒤㒝㒙㒦㒦㒘㒥㒚㒟㒠㒜㒗㒣"]='\99'..(function(e)return(e and'㒗㒟㒜㒥㒘㒗㒞㒣')and'\90\19\157'or'\104\97'end)((0x68-99)==(0x1d4/156))..'\114',[(-30+0x272)]='\116\97'..(function(e)return(e and'㒠㒟㒙㒡㒥㒣㒜㒣㒠㒢㒣㒤㒠㒝㒝㒜㒚')and'\64\113'or'\98\108'end)((1308/0xda)==(0x5f-90))..'\101',["㒢㒝㒥㒥㒜㒙㒢㒙㒗㒢㒛㒘㒦㒜㒣㒙㒘㒤"]=(function(e)return(e and'㒝㒡㒠㒜㒤㒤㒛㒤㒢㒣㒥㒙㒙㒞㒗㒤㒦㒠')or'\115\117'or'\78\107'end)((0x28e/218)==(0x53+-52))..'\98',["㒣㒡㒝㒝㒞㒛㒞㒣㒢㒥㒤"]='\99\111'..(function(e)return(e and'㒥㒛㒦㒙㒘㒙㒞㒢㒠㒙㒞㒞㒥㒣㒡㒥㒤㒛')and'\110\99'or'\110\105\103\97'end)((0x52-51)==(85-0x36))..'\97\116',[(0x1c4df/177)]=(function(e,l)return(e and'㒚㒛㒥㒢㒞㒥㒜㒤㒜')and'\48\159\158\188\10'or'\109\97'end)(((250-0x92)+-0x63)==(35-0x1d))..'\116\104',[(2743-0x58f)]=(function(e,l)return((0x44-63)==(90-(192-0x69))and'\48'..'\195'or e..((not'\20\95\69'and'\90'..'\180'or l)))or'\199\203\95'end),["㒗㒢㒘㒗㒝㒢㒗㒟㒚㒠㒗㒤㒗㒣"]='\105\110'..(function(e,l)return(e and'㒛㒦㒣㒛㒡㒞㒡㒝㒦㒛㒢㒤㒡㒢㒥')and'\90\115\138\115\15'or'\115\101'end)((0x83-126)==(163-0x84))..'\114\116',["㒛㒣㒤㒠㒢㒜㒡㒚㒞㒗"]='\117\110'..(function(e,l)return(e and'㒢㒥㒜㒗㒥㒗㒞㒘㒤㒦㒝㒥㒦㒘㒣')or'\112\97'or'\20\38\154'end)(((2392/0x1a)-87)==(0x70+-81))..'\99\107',["㒞㒡㒞㒣㒚㒗㒜㒡㒙"]='\115\101'..(function(e)return(e and'㒥㒟㒠㒚㒤㒤㒙㒡')and'\110\112\99\104'or'\108\101'end)((35-0x1e)==(217/0x7))..'\99\116',["㒦㒟㒙㒣㒛㒦㒛㒥"]='\116\111\110'..(function(e,l)return(e and'㒛㒜㒙㒚㒦㒚㒙㒝㒤㒛㒥㒟㒣㒟㒙㒚㒠㒙㒣')and'\117\109\98'or'\100\97\120\122'end)((29+-0x18)==(0x55+-80))..'\101\114'},{["㒠㒦㒞㒙㒥㒣㒚㒤㒟㒦㒣㒞㒦"]=((getfenv)or(function()return(_ENV)end))},((getfenv)or(function()return(_ENV)end))()) end)()




-- Draw
local PHook_Font = draw.CreateFont("Verdana", 25, 1000)
local PHook_Font_2 = draw.CreateFont("Verdana", 15, 1000)
local fizcord_watermark_font = draw.CreateFont( "Arial", 16 )
local din_pro_keybind = draw.CreateFont( "Arial", 15 )


local function Update_Fonts()
    PHook_Font = 0
    PHook_Font_2 = 0
    PHook_Font = draw.CreateFont("Verdana", PHook_Tab_GroupBox_Main_Indicators_1_Font_Slider:GetValue(), 1000)
    PHook_Font_2 = draw.CreateFont("Verdana", PHook_Tab_GroupBox_Main_Indicators_2_Font_Slider:GetValue(), 1000)
end

local PHook_Tab_GroupBox_Main_Indicators_UpdFonts           = gui.Button( PHook_Tab_GroupBox_Indicators, "Update Fonts", Update_Fonts )
local PHook_Tab_GroupBox_Main_Indicators_ResetPos           = gui.Button( PHook_Tab_GroupBox_Indicators, "Reset X/Y", resetXY )

local PHook_Tab_GroupBox_ViewModel                          = gui.Groupbox(PHook_Tab, "ViewModel", 16, 530, 296, 100 )
local PHook_Tab_GroupBox_ViewModel_SC                       = gui.Checkbox( PHook_Tab_GroupBox_ViewModel, "PHook_Tab_GroupBox_ViewModel_SC", "Sniper Crosshair", 0 )
local PHook_Tab_GroupBox_ViewModel_X                        = gui.Slider( PHook_Tab_GroupBox_ViewModel, "PHook_Tab_GroupBox_ViewModel_X", "X", 2, -20, 20 )
local PHook_Tab_GroupBox_ViewModel_Y                        = gui.Slider( PHook_Tab_GroupBox_ViewModel, "PHook_Tab_GroupBox_ViewModel_Y", "Y", -2, -20, 20 )
local PHook_Tab_GroupBox_ViewModel_Z                        = gui.Slider( PHook_Tab_GroupBox_ViewModel, "PHook_Tab_GroupBox_ViewModel_Z", "Z", -2, -20, 20 )
local PHook_Tab_GroupBox_ViewModel_FOV                      = gui.Slider( PHook_Tab_GroupBox_ViewModel, "PHook_Tab_GroupBox_ViewModel_FOV", "ViewModel FOV", 54, 40, 90 )
local PHook_Tab_GroupBox_ViewModel_ViewFOV                  = gui.Slider( PHook_Tab_GroupBox_ViewModel, "PHook_Tab_GroupBox_ViewModel_ViewFOV", "View FOV", 90, 50, 120 )
local PHook_Tab_GroupBox_ViewModel_ARatio                   = gui.Slider( PHook_Tab_GroupBox_ViewModel, "PHook_Tab_GroupBox_ViewModel_ARatio", "Aspect Ratio", 100, 1, 199)


local function get_LP()
    return entities.GetLocalPlayer()
end

local Clantag = function()
    
    if PHook_Tab_GroupBox_Main_CT:GetValue() then
        local curtime = math.floor(globals.CurTime() * 2.3);
        if old_time ~= curtime then
            set_clantag(clantag_anim[curtime % #clantag_anim+1], clantag_anim[curtime % #clantag_anim+1]);
        end
        old_time = curtime;
        clantagset = 1;
    else
        if clantagset == 1 then
            clantagset = 0;
            set_clantag("", "");
        end
    end
    
end

local function get_Indicators()
    local Indicators = {}
    local PHook_Indicators_Index = 1

    -- Rage / Legit
    if PHook_Tab_GroupBox_Main_Indicators_RL_Checkbox:GetValue() and gui.GetValue("rbot.aim.enable") then
        Indicators[PHook_Indicators_Index] = "MT"
        PHook_Indicators_Index = PHook_Indicators_Index + 1
    end

    -- FOV
    if PHook_Tab_GroupBox_Main_Indicators_FOV_Checkbox:GetValue() and gui.GetValue("rbot.master") then
        Indicators[PHook_Indicators_Index] = "FOV: ".. gui.GetValue("rbot.aim.target.fov")
        PHook_Indicators_Index = PHook_Indicators_Index + 1 
    end

    -- DMG
    if PHook_Tab_GroupBox_Main_Indicators_DMG_Checkbox:GetValue() and gui.GetValue("rbot.master") then
        local weapon = menu_weapon(ragebot_accuracy_weapon:GetValue())
        if weapon ~= "knife" then
            local mindmg = gui.GetValue("rbot.accuracy.weapon." .. weapon .. ".mindmg")
            Indicators[PHook_Indicators_Index] = "DMG: "..mindmg
            PHook_Indicators_Index = PHook_Indicators_Index + 1 
        end
        
    end
    
    -- AWALL
    if PHook_Tab_GroupBox_Main_Indicators_AW_Checkbox:GetValue() then
        local weapon = menu_weapon(ragebot_accuracy_weapon:GetValue())
        if weapon ~= "knife" then
            local awall = gui.GetValue("rbot.hitscan.mode." .. weapon .. ".autowall")
            if awtggl and gui.GetValue("rbot.master") then
                Indicators[PHook_Indicators_Index] = "AW"
                PHook_Indicators_Index = PHook_Indicators_Index + 1 
            end
        end
    end
    
    -- BAIM
    if baim%2 == 0 and PHook_Tab_GroupBox_Main_Indicators_BAIM_Checkbox:GetValue() then
        Indicators[PHook_Indicators_Index] = "BAIM"
        PHook_Indicators_Index = PHook_Indicators_Index + 1 
    end

    -- Resolver
    if PHook_Tab_GroupBox_Main_Indicators_Resolver_Checkbox:GetValue() and gui.GetValue("rbot.accuracy.posadj.resolver") and gui.GetValue("rbot.master") then
        Indicators[PHook_Indicators_Index] = "Resolver"
        PHook_Indicators_Index = PHook_Indicators_Index + 1
    end

    -- AA
    if PHook_Tab_GroupBox_Main_Indicators_AA_Checkbox:GetValue() then
        draw.SetFont( PHook_Font )
        local Rage_AA = gui.GetValue( "rbot.antiaim.base" )
        local Rage_AA_Slice = string.sub (Rage_AA, string.find (Rage_AA, ' ') + 2, string.len(Rage_AA ) - 1)
        if gui.GetValue("rbot.master") and Rage_AA_Slice == "Off" then
            Indicators[PHook_Indicators_Index] = "No AA"
            PHook_Indicators_Index = PHook_Indicators_Index + 1
        elseif gui.GetValue("rbot.master") and Rage_AA_Slice ~= "Off" then
            if string.sub (Rage_AA, string.find (Rage_AA, ' ') + 2, string.len(Rage_AA ) - 1) ~= "Desync" then
                Indicators[PHook_Indicators_Index] = "AA Type:" .. string.sub (Rage_AA, string.find (Rage_AA, ' ') + 2, string.len(Rage_AA ) - 1)
                PHook_Indicators_Index = PHook_Indicators_Index + 1
            else 
                local Desync_Side = "None"
                local invrtr = false
                if gui.GetValue("rbot.antiaim.base.rotation") > 0 and gui.GetValue("rbot.antiaim.base.lby") < 0 then 
                    Desync_Side = "->"
                    draw.Color(255, 255, 255, 255)
                    draw.TextShadow(PHook_Screen_X / 2 - 65, PHook_Screen_Y / 2 - 10, "⮘")
                    invrtr = true
                elseif gui.GetValue("rbot.antiaim.base.rotation") < 0 and gui.GetValue("rbot.antiaim.base.lby") > 0 then
                    Desync_Side = "<-"
                    invrtr = false
                    draw.Color(255, 255, 255, 255)
                draw.TextShadow(PHook_Screen_X / 2 + 50 , PHook_Screen_Y / 2 - 10, "⮚")
                elseif gui.GetValue("rbot.antiaim.base.rotation") < 0 and gui.GetValue("rbot.antiaim.base.lby") == 0 then
                    Desync_Side = "<-"
                    invrtr = false
                    draw.Color(255, 255, 255, 255)
                draw.TextShadow(PHook_Screen_X / 2 + 50 , PHook_Screen_Y / 2 - 10, "⮚")
                elseif gui.GetValue("rbot.antiaim.base.rotation") > 0 and gui.GetValue("rbot.antiaim.base.lby") == 0 then
                    Desync_Side = "->"
                    invrtr = true
                    draw.Color(255, 255, 255, 255)
                    draw.TextShadow(PHook_Screen_X / 2 - 65, PHook_Screen_Y / 2 - 10, "⮘")
                else 
                    Desync_Side = "Eblan"
                end
                Indicators[PHook_Indicators_Index] = "AA Type: " .. string.sub (Rage_AA, string.find (Rage_AA, ' ') + 2, string.len(Rage_AA ) - 1)
                PHook_Indicators_Index = PHook_Indicators_Index + 1
            end
        end
    end

    return Indicators

end

local function draw_Indicators(Indicators)

    if PHook_Tab_GroupBox_Main_Indicators_Position_Selector:GetValue() == 0 then
        PHook_Tab_GroupBox_Main_Indicators_X_Slider:SetDisabled(false)
        PHook_Tab_GroupBox_Main_Indicators_X_Offset:SetDisabled(true)
        PHook_Tab_GroupBox_Main_Indicators_Y_Slider:SetDisabled(false)
        PHook_Tab_GroupBox_Main_Indicators_Y_Offset:SetDisabled(true)
    elseif PHook_Tab_GroupBox_Main_Indicators_Position_Selector:GetValue() == 1 then
        PHook_Tab_GroupBox_Main_Indicators_X_Slider:SetDisabled(true)
        PHook_Tab_GroupBox_Main_Indicators_X_Offset:SetDisabled(false)
        PHook_Tab_GroupBox_Main_Indicators_Y_Slider:SetDisabled(true)
        PHook_Tab_GroupBox_Main_Indicators_Y_Offset:SetDisabled(false)
    end

    if engine.GetServerIP() ~= nil then
        if get_LP() ~= nil then
            if Indicators ~= nil then
                if PHook_Tab_GroupBox_Main_Indicators_Position_Selector:GetValue() == 0 then
                    for index in pairs(Indicators) do
                        draw.SetFont(PHook_Font)
                        draw.TextShadow(PHook_Tab_GroupBox_Main_Indicators_X_Slider:GetValue(), PHook_Tab_GroupBox_Main_Indicators_Y_Slider:GetValue() + (index * 25), Indicators[index])
                    end
                elseif PHook_Tab_GroupBox_Main_Indicators_Position_Selector:GetValue() == 1 then
                    for index in pairs(Indicators) do
                        draw.SetFont(PHook_Font_2)
                        draw.TextShadow(PHook_Screen_X/2 - 15 + PHook_Tab_GroupBox_Main_Indicators_X_Offset:GetValue(), PHook_Screen_Y/2 - 15 + PHook_Tab_GroupBox_Main_Indicators_Y_Offset:GetValue() + (index * 15), Indicators[index])
                    end
                end
            end
        end
    end
end


local function main()
    if(engine.GetServerIP() ~= nil) then
        if get_LP():GetPropInt("m_iTeamNum") == 2 or get_LP():GetPropInt("m_iTeamNum") == 3 then
            Clantag()
        end
    end

    local Indicators = get_Indicators()
    draw_Indicators(Indicators)
    
    if PHook_Tab_GroupBox_Main_Toggler:GetValue() then
        gui.SetValue( "rbot.aim.enable", 1 )
    else
        gui.SetValue( "rbot.aim.enable", 0 )
    end

end



local viewangles;

local function dynamicfov_logic()
    local pLocal = entities.GetLocalPlayer()
    
    if not PHook_Tab_GroupBox_Main_DFOV_Checkbox:GetValue() then return end
    if not pLocal then return end
    if not pLocal:GetAbsOrigin() then return end
    
    local dynamicfov_new_fov = gui.GetValue("rbot.aim.target.fov")
    local players = entities.FindByClass("CCSPlayer")
    local enemy_players = {}
    
    local min_fov = PHook_Tab_GroupBox_Main_DFOV_Min_Slider:GetValue()
    local max_fov = PHook_Tab_GroupBox_Main_DFOV_Max_Slider:GetValue()
    
    if min_fov > max_fov then
    local store_min_fov = min_fov
    min_fov = max_fov
    max_fov = store_min_fov
    end
    
    for i = 1, #players do
    if players[i]:GetPropInt("m_iTeamNum") ~= entities.GetLocalPlayer():GetPropInt("m_iTeamNum") and not players[i]:IsDormant() and players[i]:IsAlive() then
    table.insert(enemy_players, players[i])
    end
    end
    
    if #enemy_players ~= 0 then
    local own_hitbox = pLocal:GetHitboxPosition(0)
    local own_x, own_y, own_z = own_hitbox.x, own_hitbox.y, own_hitbox.z
    local own_pitch, own_yaw = viewangles.pitch, viewangles.yaw
    closest_enemy = nil
    local closest_distance = math.huge
    
    for i = 1, #enemy_players do
    local enemy = enemy_players[i]
    local enemy_x, enemy_y, enemy_z = enemy:GetHitboxPosition(0).x, enemy:GetHitboxPosition(0).y, enemy:GetHitboxPosition(0).z
    local x = enemy_x - own_x
    local y = enemy_y - own_y
    local z = enemy_z - own_z
    
    local yaw = (math.atan2(y, x) * 180 / math.pi)
    local pitch = -(math.atan2(z, math.sqrt(math.pow(x, 2) + math.pow(y, 2))) * 180 / math.pi)
    
                local yaw_dif = math.abs(own_yaw % 360 - yaw % 360) % 360
                local pitch_dif = math.abs(own_pitch - pitch) % 360
    
                if yaw_dif > 180 then
                    yaw_dif = 360 - yaw_dif
                end
    
                local real_dif = math.sqrt(math.pow(yaw_dif, 2) + math.pow(pitch_dif, 2))
    
                if closest_distance > real_dif then
                    closest_distance = real_dif
                    closest_enemy = enemy
                end
    end
    
    if closest_enemy ~= nil then
    local closest_enemy_x, closest_enemy_y, closest_enemy_z = closest_enemy:GetHitboxPosition(0).x, closest_enemy:GetHitboxPosition(0).y, closest_enemy:GetHitboxPosition(0).z
                local real_distance = math.sqrt(math.pow(own_x - closest_enemy_x, 2) + math.pow(own_y - closest_enemy_y, 2) + math.pow(own_z - closest_enemy_z, 2))
    
                dynamicfov_new_fov = max_fov - ((max_fov - min_fov) * (real_distance - 250) / 1000)
    end
    if (dynamicfov_new_fov > max_fov) then
                dynamicfov_new_fov = max_fov
            elseif dynamicfov_new_fov < min_fov then
                dynamicfov_new_fov = min_fov
            end
    
            dynamicfov_new_fov = math.floor(dynamicfov_new_fov + 0.5)
    
            if (dynamicfov_new_fov > closest_distance) then
                bool_in_fov = true
            else
                bool_in_fov = false
            end
        else
            dynamicfov_new_fov = min_fov
            bool_in_fov = false
        end
    
        if dynamicfov_new_fov ~= old_fov then
            gui.SetValue("rbot.aim.target.fov", dynamicfov_new_fov)
        end
end
    
callbacks.Register("Draw", "dynfov", dynamicfov_logic)

callbacks.Register("CreateMove", function(cmd)
    viewangles = cmd:GetViewAngles()
    end)

function OnlybaimEnable()
    baimshared = gui.GetValue("rbot.hitscan.points.shared.scale")
    baimzeus = gui.GetValue("rbot.hitscan.points.zeus.scale")
    baimauto = gui.GetValue("rbot.hitscan.points.asniper.scale")
    baimsniper = gui.GetValue("rbot.hitscan.points.sniper.scale")
    baimpistol = gui.GetValue("rbot.hitscan.points.pistol.scale")
    baimrevolver = gui.GetValue("rbot.hitscan.points.hpistol.scale")
    baimsmg = gui.GetValue("rbot.hitscan.points.smg.scale")
    baimrifle = gui.GetValue("rbot.hitscan.points.rifle.scale")
    baimshotgun = gui.GetValue("rbot.hitscan.points.shotgun.scale")
    baimscout = gui.GetValue("rbot.hitscan.points.scout.scale")
    baimlmg = gui.GetValue("rbot.hitscan.points.lmg.scale")
    
    gui.Command('rbot.hitscan.points.shared.scale 0 3 0 3 4 0 0 0')
    gui.Command('rbot.hitscan.points.zeus.scale 0 3 0 3 4 0 0 0')
    gui.Command('rbot.hitscan.points.asniper.scale 0 3 0 3 4 0 0 0')
    gui.Command('rbot.hitscan.points.sniper.scale 0 3 0 3 4 0 0 0')
    gui.Command('rbot.hitscan.points.pistol.scale 0 3 0 3 4 0 0 0')
    gui.Command('rbot.hitscan.points.hpistol.scale 0 3 0 3 4 0 0 0')
    gui.Command('rbot.hitscan.points.smg.scale 0 3 0 3 4 0 0 0')
    gui.Command('rbot.hitscan.points.rifle.scale 0 3 0 3 4 0 0 0')
    gui.Command('rbot.hitscan.points.shotgun.scale 0 3 0 3 4 0 0 0')
    gui.Command('rbot.hitscan.points.scout.scale 0 3 0 3 4 0 0 0')
    gui.Command('rbot.hitscan.points.lmg.scale  0 3 0 3 4 0 0 0')
    gui.SetValue( "rbot.hitscan.mode.shared.bodyaim.force", true )
    gui.SetValue( "rbot.hitscan.mode.zeus.bodyaim.force", true )
    gui.SetValue( "rbot.hitscan.mode.asniper.bodyaim.force", true )
    gui.SetValue( "rbot.hitscan.mode.sniper.bodyaim.force", true )
    gui.SetValue( "rbot.hitscan.mode.pistol.bodyaim.force", true )
    gui.SetValue( "rbot.hitscan.mode.hpistol.bodyaim.force", true )
    gui.SetValue( "rbot.hitscan.mode.smg.bodyaim.force", true )
    gui.SetValue( "rbot.hitscan.mode.rifle.bodyaim.force", true )
    gui.SetValue( "rbot.hitscan.mode.shotgun.bodyaim.force", true )
    gui.SetValue( "rbot.hitscan.mode.scout.bodyaim.force", true )
    gui.SetValue( "rbot.hitscan.mode.lmg.bodyaim.force", true )

end
    
function OnlybaimDisable()
    gui.Command('rbot.hitscan.points.shared.scale ' ..baimshared)
    gui.Command('rbot.hitscan.points.zeus.scale ' ..baimzeus)
    gui.Command('rbot.hitscan.points.asniper.scale ' ..baimauto)
    gui.Command('rbot.hitscan.points.sniper.scale ' ..baimsniper)
    gui.Command('rbot.hitscan.points.pistol.scale ' ..baimpistol)
    gui.Command('rbot.hitscan.points.hpistol.scale ' ..baimrevolver)
    gui.Command('rbot.hitscan.points.smg.scale ' ..baimsmg)
    gui.Command('rbot.hitscan.points.rifle.scale ' ..baimrifle)
    gui.Command('rbot.hitscan.points.shotgun.scale ' ..baimshotgun)
    gui.Command('rbot.hitscan.points.scout.scale ' ..baimscout)
    gui.Command('rbot.hitscan.points.lmg.scale ' ..baimlmg)
    gui.SetValue( "rbot.hitscan.mode.shared.bodyaim.force", false )
    gui.SetValue( "rbot.hitscan.mode.zeus.bodyaim.force", false )
    gui.SetValue( "rbot.hitscan.mode.asniper.bodyaim.force", false )
    gui.SetValue( "rbot.hitscan.mode.sniper.bodyaim.force", false )
    gui.SetValue( "rbot.hitscan.mode.pistol.bodyaim.force", false )
    gui.SetValue( "rbot.hitscan.mode.hpistol.bodyaim.force", false )
    gui.SetValue( "rbot.hitscan.mode.smg.bodyaim.force", false )
    gui.SetValue( "rbot.hitscan.mode.rifle.bodyaim.force", false )
    gui.SetValue( "rbot.hitscan.mode.shotgun.bodyaim.force", false )
    gui.SetValue( "rbot.hitscan.mode.scout.bodyaim.force", false )
    gui.SetValue( "rbot.hitscan.mode.lmg.bodyaim.force", false )
end
    
    
function BaimOnKey()
    if PHook_Tab_GroupBox_Main_BAIM_Toggler:GetValue() == 0 then return end
        if(input.IsButtonPressed(PHook_Tab_GroupBox_Main_BAIM_Toggler:GetValue())) then
            baim = baim + 1;
        elseif(input.IsButtonDown) then
        -- do nothing
        end
        if(input.IsButtonReleased(PHook_Tab_GroupBox_Main_BAIM_Toggler:GetValue())) then
                if (baim%2 == 0) then
                        OnlybaimEnable()
                        baim = 0;
                elseif (baim%2 == 1) then
                        OnlybaimDisable()
                        baim = 1;
                end
              
        end 
        
end
callbacks.Register( "Draw", "BaimOnKey", BaimOnKey )

function InvertOnKey()
    if PHook_Tab_GroupBox_Main_Inverter:GetValue() ~= 0 then
    if input.IsButtonPressed(PHook_Tab_GroupBox_Main_Inverter:GetValue()) then
        gui.SetValue( "rbot.antiaim.base.rotation", -gui.GetValue( "rbot.antiaim.base.rotation" ) )
        gui.SetValue( "rbot.antiaim.base.lby", -gui.GetValue( "rbot.antiaim.base.lby" ) )
    end
end
end

callbacks.Register("Draw", "InvertOnKey", InvertOnKey)

function JitterWalk()
    if PHook_Tab_GroupBox_Main_JWalk:GetValue() ~= 0 then
    if input.IsButtonDown(PHook_Tab_GroupBox_Main_JWalk:GetValue()) then
        gui.SetValue( "rbot.antiaim.base.rotation", -gui.GetValue( "rbot.antiaim.base.rotation" ) )
        gui.SetValue( "rbot.antiaim.base.lby", -gui.GetValue( "rbot.antiaim.base.lby" ) )
    end
end
end

callbacks.Register("Draw", "JitterWalk", JitterWalk)

function AWallOnKey()
    if PHook_Tab_GroupBox_Main_AW_Toggler:GetValue() ~= 0 then
    if input.IsButtonPressed(PHook_Tab_GroupBox_Main_AW_Toggler:GetValue()) then
        awtggl = not awtggl
    end
    if awtggl then   
        gui.SetValue( "rbot.hitscan.mode.shared.autowall", 1)
        gui.SetValue( "rbot.hitscan.mode.zeus.autowall", 1)
        gui.SetValue( "rbot.hitscan.mode.asniper.autowall", 1)
        gui.SetValue( "rbot.hitscan.mode.hpistol.autowall", 1)
        gui.SetValue( "rbot.hitscan.mode.lmg.autowall", 1)
        gui.SetValue( "rbot.hitscan.mode.pistol.autowall", 1)
        gui.SetValue( "rbot.hitscan.mode.shotgun.autowall", 1)
        gui.SetValue( "rbot.hitscan.mode.smg.autowall", 1)
        gui.SetValue( "rbot.hitscan.mode.scout.autowall", 1)
        gui.SetValue( "rbot.hitscan.mode.sniper.autowall", 1)
        gui.SetValue( "rbot.hitscan.mode.rifle.autowall", 1)
    else
        gui.SetValue( "rbot.hitscan.mode.shared.autowall", 0)
        gui.SetValue( "rbot.hitscan.mode.zeus.autowall", 0)
        gui.SetValue( "rbot.hitscan.mode.asniper.autowall", 0)
        gui.SetValue( "rbot.hitscan.mode.hpistol.autowall", 0)
        gui.SetValue( "rbot.hitscan.mode.lmg.autowall", 0)
        gui.SetValue( "rbot.hitscan.mode.pistol.autowall", 0)
        gui.SetValue( "rbot.hitscan.mode.shotgun.autowall", 0)
        gui.SetValue( "rbot.hitscan.mode.smg.autowall", 0)
        gui.SetValue( "rbot.hitscan.mode.scout.autowall", 0)
        gui.SetValue( "rbot.hitscan.mode.sniper.autowall", 0)
        gui.SetValue( "rbot.hitscan.mode.rifle.autowall", 0)
        end
    end
end

callbacks.Register("Draw", "AWallOnKey", AWallOnKey)

callbacks.Register("Draw", main)
callbacks.Register("Draw", draw_Indicators)



-- Unlock Inventory Access
panorama.RunScript([[
	LoadoutAPI.IsLoadoutAllowed = () => {
		return true;
	};
]])

-- Viewmodel
a=0;
i = 0;
callbacks.Register("Draw", function(event)
    client.SetConVar("viewmodel_offset_x", PHook_Tab_GroupBox_ViewModel_X:GetValue(), true)
    client.SetConVar("viewmodel_offset_z", PHook_Tab_GroupBox_ViewModel_Z:GetValue(), true)
    client.SetConVar("viewmodel_offset_y", PHook_Tab_GroupBox_ViewModel_Y:GetValue(), true)   
    gui.SetValue("esp.local.viewmodelfov", PHook_Tab_GroupBox_ViewModel_FOV:GetValue()) 
    gui.SetValue("esp.local.fov", PHook_Tab_GroupBox_ViewModel_ViewFOV:GetValue()) 
    
end)

callbacks.Register('Draw', function()
	if not PHook_Tab_GroupBox_ViewModel_SC:GetValue()  then
		if not PHook_Tab_GroupBox_ViewModel_SC:GetValue() and client.GetConVar('weapon_debug_spread_show') == '3' then
			client.SetConVar('weapon_debug_spread_show', 0, true)
			return
		end
		return
	end

    if(engine.GetServerIP() ~= nil) then
        if get_LP():GetWeaponType() == 5 and get_LP():GetPropBool("m_bIsScoped") == false then
            client.SetConVar('weapon_debug_spread_show', 3, true)
        else
            client.SetConVar('weapon_debug_spread_show', 0, true)
        end	
    end
	
end)



local aspect_ratio_table = {};
 
 
 
local function gcd(m, n) while m ~= 0 do m, n = math.fmod(n, m), m; end return n end

local function set_aspect_ratio(aspect_ratio_multiplier)
local screen_width, screen_height = draw.GetScreenSize(); local aspectratio_value = (screen_width*aspect_ratio_multiplier)/screen_height;
if aspect_ratio_multiplier == 1  then aspectratio_value = 0; end
client.SetConVar( "r_aspectratio", tonumber(aspectratio_value), true); end

local function on_aspect_ratio_changed()
local screen_width, screen_height = draw.GetScreenSize();
for i=1, 200 do local i2=i*0.01; i2 = 2 - i2; local divisor = gcd(screen_width*i2, screen_height); if screen_width*i2/divisor < 100 or i2 == 1 then aspect_ratio_table = screen_width*i2/divisor .. ":" .. screen_height/divisor; end end
local aspect_ratio = PHook_Tab_GroupBox_ViewModel_ARatio:GetValue()*0.01; aspect_ratio = 2 - aspect_ratio; set_aspect_ratio(aspect_ratio); end
callbacks.Register('Draw', "does shit" ,on_aspect_ratio_changed)


-- Watermark

local realtimefps = 21
local realtimeping = 21
local player_name = "azure.lua"
local separator = "  |  "

function WatermarkFunc()
    
    local screen_w, screen_h = draw.GetScreenSize();
    
    local playerResources = entities.GetPlayerResources();

    local frame_rate = 0/10

    local get_abs_fps = function()
        frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * globals.AbsoluteFrameTime()
        return math.floor((1 / frame_rate)+ 0.5)
    end

    if(engine.GetServerIP() ~= nil) then
        if globals.RealTime() - realtimeping > 0.5 then
            if (engine.GetServerIP() == "loopback") then
                server = "localhost"
            elseif string.find(engine.GetServerIP(), "A") then
                server = "valve"
            else
                server = engine.GetServerIP()
            end
            delay = 'delay: ' .. playerResources:GetPropInt("m_iPing", get_LP():GetIndex()) .. 'ms';
            tick = math.floor( 1.0 / globals.TickInterval() ) .. ' tick';
            tickrealtimepingcountping = globals.RealTime()
        end
    end

    if (get_LP() ~= nil) then
        fizcord_watermark_text = player_name .. separator .. server .. separator .. delay .. separator .. tick;
    else
        fizcord_watermark_text =  separator .. player_name .. separator ;
    end
    if(engine.GetServerIP() ~= nil) then
        draw.SetScissorRect(screen_w - draw.GetTextSize(fizcord_watermark_text)-11, 10,draw.GetTextSize(fizcord_watermark_text)-2,80);
        draw.SetFont( fizcord_watermark_font )
        draw.Color(PHook_Tab_GroupBox_Main_Indicators_WmarkColor:GetValue())
        draw.ShadowRect(screen_w - draw.GetTextSize(fizcord_watermark_text)-31, 10, screen_w - 10,13,20)
        draw.FilledRect( screen_w - draw.GetTextSize(fizcord_watermark_text)-31, 10, screen_w - 10, 13  )
        draw.Color(gui.GetValue( "theme.header.text" ))
        draw.Text( screen_w - draw.GetTextSize(fizcord_watermark_text) - 20, 20, fizcord_watermark_text )
    end
        draw.SetScissorRect(0, 0, draw.GetScreenSize());
end

callbacks.Register( "Draw", WatermarkFunc )

