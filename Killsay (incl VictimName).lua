local killsays = {    
[1] = "Uninstall your hacks, _name_.",    
[2] = "How do you hack and lose, _name_?",    
[3] = "More bad please.",    
[4] = "HAHAHAHAHAHA",    
[5] = "WOOOOOOOOOOW",    
[6] = "Get a refund, _name_.",    
[7] = "How bad are you, _name_?",    
[8] = "Wow, didn't even hit me, _name_.",    
[9] = "Wow more bad please, _name_.",    
[10] = "Get on my level, _name_.",    
[11] = "And that ladies and gentlemen is how you win at HvH.",    
[12] = "You missed.",    
[13] = "Scrub.",    
[14] = "#cantresolve, _name_.",    
[15] = "You're bad, _name_.",    
[16] = "So mad.",    
[17] = "_name_ sucks.",    
[18] = "_name_ is so fucking bad.",    
[19] = "I hope you didn't pay for those, _name_.",    
[20] = "You think you can run from me, _name_?!",    
[21] = "Wow, _name_ cheats and calls me pathetic.",    
[22] = "You seriously think you can run from me?",    
[23] = "You're complete garbage, _name_.",    
[24] = "Why can't you defeat me, _name_?",    
[25] = "WHAT A BADDIE!",    
[26] = "Just uninstall and don't come back, _name_.",    
[27] = "How did you pay money for items and still suck at this game, _name_?",    
[28] = "Why are you so bad, _name_?",    
[29] = "OH YOU DIED AGAIN! HAHAHAAHAH!",    
[30] = "Fucking uninstall this game you're so trash, _name_.",    
[31] = "F IN CHAT.",    
[32] = "I don't think you can get any more mad right now, _name_.",    
[33] = "I fucking really wanna know how you're so bad at this game, _name_.",    
[34] = "You're fucking trash, _name_.",    
[35] = "You wanna 1v1 me?",    
[36] = "2bad4me",    
[37] = "Uninstall.",    
[38] = "Go Fuck Yourself With A Spoon, _name_.",
[39] = "You're complete garbage.",
[40] = "You lose.",
[41] = "Super bad.",
[42] = "HAH",
[43] = "WHAT A BADDIE!",
[44] = "C'mon baddie.",
[45] = "Get rolled again.",
[46] = "Can't even hit me.",
[47] = "You lose again.",
[48] = "MORE BAD PLEASE",
[49] = "He's not even hitting me once.",
[50] = "Fucking nub.",
[51] = "Sucks for you.",
[52] = "Nah, you're just bad.",
[53] = "OH YOU DIED AGAIN",
[54] = "WOW",
[55] = "Man, you're getting shitted on.",
[56] = "NOPE",
[57] = "2fast4u",
[58] = "Dead.",
[59] = "Suck my dick.",
[60] = "You wanna 1v1 me?",
[61] = "LOL YOU LOSE KID",
[62] = "HOW DO YOU HACK AND LOSE?!?!?!?",
[63] = "LMAO",
[64] = "XDDDDDDD",
[65] = "ENJOY YOUR LOSS KID",
[66] = "EZ",
[67] = "What is this, nigger day?",
[68] = "Why so many blacks?!",
[69] = "Fucking nigger black horse.",
[70] = "How do you hack and die?",
[71] = "Nah you suck.",
[72] = "Died again?!",
[73] = "WHAT THE FUCK!!!!!!!",
[74] = "I killed the hacker though.",
[75] = "Blacks committed 52% of violent crimes between 1980 and 2008, despite being 13% of the population. ~JusticeBureau",
[76] = "Blacks are Bad Fact #666: Average white IQ: 104 Average black IQ: 85. ~American SAT IQ Scores in 2015",
[77] = "SUCH A BADDIE",
[78] = "_name_ YOU'RE PRETTY BAD",
[79] = "HOW DO YOU HACK AND LOSE YOU NIGGER",
[80] = "WHAT A BADDIE",
[81] = "BAD",
[82] = "2bad",
[83] = "SO BAD",
[84] = "NOPE",
[85] = "YOU CAN'T EVEN KILL ME",
[86] = "Owned.",
[87] = "HAD FUN GETTING ROLLED?",
[88] = "_name_, get rolled, K?",
[89] = "Wow, he cheats and calls me pathetic.",
[90] = "_name_, you seriously think you can run from me?",
[91] = ":)",
[92] = "Scrub.",
[93] = "Missed again.",
[94] = "You can't even hit me with normal aimbot.",
[95] = "So mad.",
[96] = "You so bad.",
[97] = "Bad.",
[98] = "Can't beat me?",
[99] = "Those are some bad hacks you got there.",
[100] = "That hack sucks.",
[101] = "Thems some bad hacks buddy.",
[102] = "You = bad.",
[103] = "Yeah, I think I won.",
[104] = "What a baddie.",
[105] = "Wow more bad please.",
[106] = "Wow, didn't even hit me.",
[107] = "How bad are you?",
[108] = "WOOOOOOOW",
[109] = "HAHAHAHAHAHA",
[110] = "How do you hack and lose?",
[111] = "Uninstall your hacks.",
[112] = "More bad please.",
[113] = "Sorry try again.",
[114] = "You can't even hit me.",
}

local function CHAT_KillSay( Event )        

if ( Event:GetName() == 'player_death' ) then                

local ME = client.GetLocalPlayerIndex();                
local INT_UID = Event:GetInt( 'userid' );        
local INT_ATTACKER = Event:GetInt( 'attacker' );                
local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );        
local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );                
local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );        
local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );                

if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then                        

local response = tostring(killsays[math.random(#killsays)]);                

response = response:gsub("_name_", NAME_Victim);                

client.ChatSay( ' ' .. response );                
	
		end        
	end    
end

client.AllowListener( 'player_death' );

callbacks.Register( 'FireGameEvent', 'AWKS', CHAT_KillSay );