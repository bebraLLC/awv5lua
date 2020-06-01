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



local flickticks = 0;-- Dont change 
local breakticks = 0;-- Dont change 

local lastfake = 1;-- Dont change 
local lastreal = 1;-- Dont change 

local flickpertick = 100; -- If tick = then flick

local clearflicks = 130; -- Fake Desync time in ticks

local realontick = 1; -- Time to set real after reset either it will set fake

local desyncfake = 3; -- Set fake desync mode still/balance/stretch/jitter
local desyncreal = 1; -- Set real desync mode still/balance/stretch/jitter



desyncs = {
   "Still",
   "Balance",
   "Stretch",
   "Jitter"
}


function DesyncFlick()
  
  if (flickticks > flickpertick) then
 
        gui.SetValue("rbot_antiaim_stand_desync", desyncfake);
        lastfake = gui.GetValue("rbot_antiaim_stand_desync");
        desync = 2;
        if( flickticks == clearflicks) then
        
        flickticks = 0;
        end 
            else
        if (breakticks > realontick) then
        
       gui.SetValue("rbot_antiaim_stand_desync", desyncreal);
        lastreal = gui.GetValue("rbot_antiaim_stand_desync");
        
        
        desync = 3;
        breakticks = 0;
        end    
           
      
     
    end

    flickticks = flickticks + 1;
    breakticks = breakticks + 1;

end

function StringDraw() 
draw.Color( 220, 50, 50 );

    draw.Text( 128, 500, flickticks );
    
    if (lastreal == gui.GetValue("rbot_antiaim_stand_desync")) then
    
    draw.Color( 50, 255, 50 );
    draw.Text( 128, 630, "Real : " ..desyncs[lastreal] );
    draw.Color( 255, 50, 50 );
    draw.Text( 128, 570, "Fake : " ..desyncs[lastfake] );
    
                else
        
    draw.Color( 50, 255, 50 );
    draw.Text( 128, 570, "Fake : " ..desyncs[lastfake] );
    draw.Color( 255, 50, 50 );
    draw.Text( 128, 630, "Real : " ..desyncs[lastreal] );
    
    end
end

callbacks.Register( "Draw", "StringDraw", StringDraw );

callbacks.Register( "Draw", "DesyncFlick", DesyncFlick);