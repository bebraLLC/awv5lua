local ref = gui.Reference( "Misc", "General","Server" )
local gb = gui.Groupbox( ref, "Volume Modifier" )
local cb = gui.Checkbox( gb, "misc.enablevm", "Enable Volume Modifier", 0 )
cb:SetDescription("Default is 1.0")
local lfslid = gui.Slider( gb, "misc.volmod.lfootsteps", "Local Footsteps Volume", 1.0, 0.0, 10.0, 0.5 )
local gfslid = gui.Slider( gb, "misc.volmod.gfootsteps", "Global Footsteps Volume", 1.0, 0.0, 10.0, 0.5 )
local wepslid = gui.Slider( gb, "misc.volmod.wep", "Weapons", 1.0, 0.0, 10.0, 0.5 )
local diaslid = gui.Slider( gb, "misc.volmod.dialogs", "Dialogs Volume", 1.0, 0.0, 10.0, 0.5 )
local ambslid = gui.Slider( gb, "misc.volmod.ambient", "Local Ambient Volume", 1.0, 0.0, 10.0, 0.5 )

local function main()
if entities.GetLocalPlayer() ~= nil then
        client.Command( "snd_setmixer PlayerFootsteps vol " .. lfslid:GetValue(), 1 )
        client.Command( "snd_setmixer GlobalFootsteps vol ".. gfslid:GetValue(), 1 )
        client.Command( "snd_setmixer Weapons vol " .. wepslid:GetValue(), 1 )
        client.Command( "snd_setmixer Dialog vol " .. diaslid:GetValue(), 1 )
        client.Command( "snd_setmixer Ambient vol " .. ambslid:GetValue(), 1 )
   end
end


callbacks.Register( 'Draw', main )