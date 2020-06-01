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



print("Loaded Aspect Ratio By Starlordaiden!")local a={}local b=gui.Reference("MISC","Enhancement")local c=gui.Groupbox(b,"AspectRatio",16,710,297)local d=gui.Checkbox(c,"aspect_ratio_check","Aspect Ratio Changer",false)local e=gui.Slider(c,"aspect_ratio_reference","Force Aspect Ratio",100,1,199)local function f(g,h)while g~=0 do g,h=math.fmod(h,g),g end;return h end;local function i(j)local k,l=draw.GetScreenSize()local m=k*j/l;if j==1 or not d:GetValue()then m=0 end;client.SetConVar("r_aspectratio",tonumber(m),true)end;local function n()local k,l=draw.GetScreenSize()for o=1,200 do local p=o*0.01;p=2-p;local q=f(k*p,l)if k*p/q<100 or p==1 then a[o]=k*p/q..":"..l/q end end;local r=e:GetValue()*0.01;r=2-r;i(r)end;callbacks.Register('Draw',"Aspect Ratio",n)
