-- Moving standing dtmode --

local tui = gui.Groupbox( gui.Reference( "Ragebot", "Accuracy", "Weapon"), "Moving and Standing DoubletabMode")
local dt_moving = gui.Combobox( tui, "asniper.doublefire.move", "DT Mode moving", "Off", "Shift" , "Rapid")
local dt_standing = gui.Combobox( tui, "asniper.doublefire.stand", "DT Mode standing", "Off", "Shift" , "Rapid")
local maxVelocity = gui.Slider(tui, "asniper.doublefire.velocity", "Max StandVelocity", 0, 0, 120, 0.5)


local function movstanddoubletabmode()
local velocity = math.sqrt(localPlayer:GetPropFloat( "localdata", "m_vecVelocity[0]" )^2 + localPlayer:GetPropFloat( "localdata", "m_vecVelocity[1]" )^2)
		
    	if velocity > maxVelo then
        gui.SetValue( "rbot.accuracy.weapon.asniper.doublefire", dt_move )	-- Moving 	(when Velocity is higher than veloslider Value)
    else
        gui.SetValue( "rbot.accuracy.weapon.asniper.doublefire", dt_stand)	-- Standing (when Velocity is lower than veloslider Value)
    end
end

local function setdoubletabmode()
dt_move = dt_moving:GetValue()
dt_stand = dt_standing:GetValue()
maxVelo = maxVelocity:GetValue()

end
local function localcheck()
    localPlayer = entities.GetLocalPlayer()
    if localPlayer then
        setdoubletabmode()
        movstanddoubletabmode()
    end
end

callbacks.Register( "Draw",  localcheck )