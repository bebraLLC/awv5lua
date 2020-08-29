local menu = gui.Reference("MISC", "GENERAL", "Extra")
local killsound = gui.Checkbox(menu, "killsound", "Kill Sound", 0)
local snd_time = gui.Slider(menu, "snd_time", "Sound Length", 1.7, 0, 5, 0.1)
local currentTime = 0
local timer = 0
local enabled = true

killsound:SetDescription("Plays sound when you kill someone")
local function handler()
currentTime = globals.RealTime()
if currentTime >= timer then
timer = globals.RealTime() + snd_time:GetValue()
if enabled then
client.SetConVar("voice_loopback", 0, true)
client.SetConVar("voice_inputfromfile", 0, true)
client.Command("-voicerecord", true)
enabled = false
end
end
end
local function on_player_death(Event)
if killsound:GetValue() == false or Event:GetName() ~= "player_death" then
return
end
local INT_ATTACKER = Event:GetInt("attacker")
local INT_VICTIM = Event:GetInt("userid")
if INT_ATTACKER == nil then
return
end
local local_ent = client.GetLocalPlayerIndex()
local attacker_ent = entities.GetByUserID(INT_ATTACKER)
local victim_ent = entities.GetByUserID(INT_VICTIM)
if local_ent == nil or attacker_ent == nil then
return
end
if (attacker_ent:GetIndex() == local_ent) and (local_ent ~= victim_ent) then
if enabled then
enabled = not enabled
client.SetConVar("voice_loopback", 0, true)
client.SetConVar("voice_inputfromfile", 0, true)
client.Command("-voicerecord", true)
end
client.SetConVar("voice_loopback", 1, true)
client.SetConVar("voice_inputfromfile", 1, true)
client.Command("+voicerecord", true)
timer, enabled = globals.RealTime() + snd_time, true
end
end
client.AllowListener("player_death")
callbacks.Register("FireGameEvent", on_player_death)
callbacks.Register("Draw", handler)