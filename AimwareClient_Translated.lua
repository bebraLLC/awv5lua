local db = {
    prev = "English",
    lang = {"English", "Deutsch",},
    ["English"] = {
        {"Legitbot", "Ragebot", "Visuals", "Misc", "Settings",},
        {
            {"Aimbot", "Triggerbot", "Weapon", "Other", "Semirage",},
            {
                {"Toggle", "Weapon", "Hitbox Selection",},
                {
                    {"Enable", "Enables legit aimbot.",},
                    {"Aim Key", "Set the aimbot on key.",},
                    {"Toggle Key", "Set the toggle key to enable/disable aimbot.",},
                },
                {
                    {"Auto Fire", "Fires without pressing any keys.",},
                    {"Fire On Press", "Fires when pressing the aimbot key.",},
                    {"Auto Pistol Interval", "Interval between shots for automatic mode.",},
                },
                {
                    {[2] = "Order of hitboxes the aimbot will choose."},
                    {[5] = true, "Hitbox Advance Multipler", "How fast aimbot should switch to the next hitbox.",},
                    {[5] = true, "Nearest To Crosshair", "Priority hitbox nearest to crosshair as first.",},
                },
            },
            {
                {"Toggle", "Weapon", "Hitbox Scan",},
                {
                    {"Enable", "Enables triggerbot.",},
                    {"Trigger Key", "Activate triggerbot on key press.",},
                    {"Auto Fire", "Let triggerbot fire without pressing any key.",},
                },
                {
                    {[5] = true, "Trigger Delay", "Delay shot after trigger lock.",},
                    {[5] = true, "Trigger Burst", "Keep firing after trigger lock.",},
                    {[5] = true, "Hit Chance", "Minimum chance to hit before triggerbot shoots.",},
                    {[5] = true, "Anti-Recoil", "Account for recoil when trigger scanning.",},
                },
                {
                    {[2] = "Trigger on selected hitboxes.",},
                },
            },
            {
                {"Accuracy", "Target", "Aiming", "Visibility",},
                {
                    {[5] = true, "Recoil Control System", "Smoothly counter weapon recoil.",},
                    {[5] = true, "Standalone Recoil Control", "Enable RCS while aiming freely.",},
                    {[5] = true, "Horizontal Recoil", "How much of horizontal recoil will be countered.",},
                    {[5] = true, "Vertical Recoil", "How much of Vertical recoil will be countered.",},
                },
                {
                    {[5] = true, "Minimum FOV Range", "Minimum field of view for aim lock.",},
                    {[5] = true, "Maximum FOV Range", "Maximum field of view for aim lock.",},
                    {[5] = true, "Target Switch Delay", "Time aimbot will wait before switching target.",},
                    {[5] = true, "First Shot Delay", "Time till aimbot fires first shot.",},
                },
                {
                    {[5] = true, "Smooth Factor", "Smooth out aimbot movement.",},
                    {[5] = true, "Smooth Method", "Method to use for smooth movement.", {"Dynamic", "Static",},},
                    {[5] = true, "Randomize Factor", "Randomize aimbot target position.",},
                    {[5] = true, "Curve Factor", "How non-linear the movement will be.",},
                },
                {
                    {[5] = true, "Auto Wall", "Fire through penetrable walls.",},
                    {[5] = true, "Through Smoke", "Fire through smoke.",},
                },

            },
            {
                {"Movement", "Extra",},
                {
                    {"Walk Speed Customization", "Enable walk speed modifications.",},
                    {"Walk Speed", "Modify walk speed with this ammount.",},
                    {"Quick Stop", "Makes you stop faster by counter-strafing.",},
                },
                {
                    {"Backtrack Time", "How many position in the past are allowed.",},
                    {"Knife Triggerbot.", "Enable knife triggerbot.",},
                },
            },
            {
                {"Aimbot", "Position Adjustment", "Anti-Aim",},
                {
                    {"Silent Aimbot", "Autoaim when in Low FOV range.",},
                    {"Auto Stop", "Stop when aimbot fires to lower inaccuracy.",},
                },
                {
                    {"Backtracking", "Aim at enemy history positions",},
                    {"Resolver", "Improve accuracy when shooting at enemy anti-aim.",},
                },
                {
                    {"Type", "Maximum affects visible animation.", {"Off", "Minimum", "Maximum",},},
                    {"Direction", "Choose mode for selecting direction", {"Auto", "Manual",},},
                    {"Left Side",},
                    {"Right Side",},
                    {"On Enemy Aiming", "Activate anti-aim only when enemy is aiming at you.",},
                    {"Disable On Knife", "Disable anti-aim when holding knife.",},
                    {"Disable On Grenade", "Disable anti-aim when holding a grenade.",},
                },
            },
        },
        {
            {"Aimbot", "Accuracy", "Hitscan", "Anti-Aim",},
            {
                {"Toggle", "Automation", "Target", "Extra",},
                {
                    {"Enable", "Enables rage aimbot.",},
                    {"Aim Key", "Set the aimbot on key.",},
                    {"Toggle Key", "Set the toggle key to enable/disable aimbot.",},
                },
                {
                    {"Auto Pistol", "Makes pistol fire like an automatic weapon.",},
                    {"Auto Revolver", "Auto cocks the revolver for quicker fire.",},
                    {"Auto Scope", "Scopes with sniper automatically when firing.", {"Off", "On - Auto Unzoom", "On - No Unzoom",},}, 
                },
                {
                    {"FOV", "Maximum field of view the aimbot will target within.",},
                    {"Aim Lock", "Increase priority of latest target.",},
                    {"Silent Aim", "Supress view movement when aimbotting.",},
                },
                {
                    {"Knifebot", "Automatically knife when your target is in range.", {"Off", "Default Knifebot", "Only Backstab", "Quick Stab",},},
                },
            },
            {
                {"Weapon", "Position Adjustment", "Movement",},
                {
                    {[5] = true, "Hit Chance", "Minimum chance to hit before aimbot shoots.",},
                    {[5] = true, "Min Damage", "Minimum damage required after wall penetration.",},
                    {[5] = true, "Anti-Recoil", "Counter Weapon Recoil for higher accuracy.",},
                },
                {
                    {"Backtracking", "Aim at enemy history position.",},
                    {"Resolver", "Improve accuracy when shooting at enemy anti-aim.",},
                },
                {
                    {"Auto Stop", "Counter strafe when shooting to lower accuracy.",},
                    {"Auto Duck", "Crouch when shooting to lower inaccuracy.",},
                    {"Slow Walk Key", "Slow down player movement while holding this key.",},
                    {"Slow Walk Speed", "Makes you stop faster by counter strafing.",},
                    {"Quick Stop", "Makes you stop faster by counter strafing.",},
                },
            },
            {
                {"Hitbox Points", "Hitbox Priority", "Mode", "Advanced",},
                {
                    {[2] = "Amount of points the aimbot will scan for.",},
                },
                {
                    {[2] = "Order of points the aimbot go for first.",},
                },
                {
                    {[5] = true, "Auto Wall", "Shoot through penetrable walls.",},
                    {[5] = true, "Delay Shot", "Wait for more accurate hitbox state.",},
                    {[5] = true, "Lethal Bodyaim", "Bodyaim if the damage will be lethal.",},
                },
                {
                    {"Max Processing Time", "Lower this value to maintain better FPS.",},
                },
            },
            {
                {"Base Direction", "Left Direction", "Right Direction", "Condition", "Advanced",},
                {
                    {[6] = true, "Spinbot Speed",},
                    {[6] = true,"Rotation Offset",},
                    {[6] = true,"LBY Offset",},
                },
                {
                    {[6] = true,"Spinbot Speed",},
                    {[6] = true,"Rotation Offset",},
                    {[6] = true,"LBY Offset",},
                },
                {
                    {[6] = true,"Spinbot Speed",},
                    {[6] = true,"Rotation Offset",},
                    {[6] = true,"LBY Offset",},
                },
                {
                    {"Disable On Use", "Disable anti-aim when pressing the use key.",},
                    {"Disable On Knife", "Disable anti-aim when holding knife.",},
                    {"Disable On Grenade", "Disable anti-aim when holding a grenade.",},
                    {"On Shot", "Prevent your on shot model from getting hit.", {"Default", "Desync", "Shift",},},
                },
                {
                    {"Auto Direction", "Enable left/right direction based on nearby walls.",},
                    {"Anti-Alignment", "Prevent allignment of desync anti-aim.",},
                    {"Anti-Resolver", "Makes continous shots harder to hit.",},
                    {"Pitch Angle", "", {"Off", "89??", "180?? (Untrusted)",},},
                    {"Fake Duck", "Allows you to shoot higher while crouching",},
                },
            },          
        },
        {
            {"Overlay", "Local", "World", "Chams", "Skins", "Other",},
            {
                {"Friendly", "Enemy", "Weapon",},
                {
                    {"Box", "Draw 2D box around entity.", {"Off", "Outlined", "Normal",},},
                    {"Box Precision", "Match 2D box with model bounds.",},
                    {"Name", "Draw entity name.",},
                    {"Skeleton", "Draw player skeleton.",},
                    {"Glow", "Glow effect on player.", {"Off", "Team Color", "Health Color",},},
                    {"Health", "Configure health options.", [4] = {"Bar", "Number",},},
                    {"Armor", "Configure armor options.", [4] = {"Bar", "Number",},},
                    {"Weapon", "Draw weapon name of player.", {"Off", "Active", "All", "Active + Nades",},},
                    {"Flags", "Show player activity", [4] = {"Defusing", "Planting", "Scoped", "Reloading", "Flashed", "Has Defuser", "Has C4",},},
                    {"Money", "Draw amount of money player has.",},
                    {"Barrel", "Draw lines where players is looking.",},
                },
                {
                    {"Box", "Draw 2D box around entity.", {"Off", "Outlined", "Normal",},},
                    {"Box Precision", "Match 2D box with model bounds.",},
                    {"Name", "Draw entity name.",},
                    {"Skeleton", "Draw player skeleton.",},
                    {"Glow", "Glow effect on player.", {"Off", "Team Color", "Health Color",},},
                    {"Health", "Configure health options.", [4] = {"Bar", "Number",},},
                    {"Armor", "Configure armor options.", [4] = {"Bar", "Number",},},
                    {"Weapon", "Draw weapon name of player.", {"Off", "Active", "All", "Active + Nades",},},
                    {"Flags", "Show player activity", [4] = {"Defusing", "Planting", "Scoped", "Reloading", "Flashed", "Has Defuser", "Has C4",},},
                    {"Money", "Draw amount of money player has.",},
                    {"Barrel", "Draw lines where players is looking.",},
                },
                {
                    {"Box", "Draw 2D box around entity.", {"Off", "Outlined", "Normal",},},
                    {"Box Precision", "Match 2D box with model bounds.",},
                    {"Name", "Draw entity name.",},
                    {"Ammo", "Amount of ammo left in weapon.",},
                    {"C4 Timer", "Display time till C4 explosion.",},
                    {"Danger Zone Items", "Various items from danger zone.",},
                    {"Danger Zone Turret", "Turret from danger zone.",},
                },
            },
            {
                {"Camera", "Helper",},
                {
                    {"Third Person Toggle", "Toggle third person view with this key.",},
                    {"Third Person Distance", "Distance of the camera.",},
                    {"Smooth Ghost Model", "Match fake ghost position with real.",},
                },
                {
                    {"Wallbang Damage", "Show penetrable space on walls.",},
                    {"Out Of View", "Display out of view enemies indicators.",},  
                },
            },
            {
                {"Extra", "Materials", "Nade",},
                {
                    {"Hitmarkers", "Play a sound when hitting an enemy.",},
                    {"Sounds", "Display audible sounds on screen.",},
                },
                {
                    {"Walls Color",},
                    {"Static Props Color",},
                    {"Skybox", "Change how the sky looks.",},
                },
                {
                    {"Inferno", "Draw molotov covered inerno.", [4] = {"Local", "Friendly", "Enemy",},},
                    {"Grenade Tracer", "Visualize predicted grenade trajectory.", [4] = {"Local", "Friendly", "Enemy",},},
                },
            },
            {
                {"Friendly", "Enemy", "Local", "Ghost", "Backtrack", "Weapon",},
                {
                    {"Occluded", "Material occluded by walls.", {"Off", "Flat", "Color", "Metalic", "Glow",},},
                    {"Visible", "Visible material.", {"Off", "Flat", "Color", "Metalic", "Glow", "Textured", "Invisible",},},
                    {"Overlay", "Apply over previus materials.", {"Off", "Wireframe",},},
                },
                {
                    {"Occluded", "Material occluded by walls.", {"Off", "Flat", "Color", "Metalic", "Glow",},},
                    {"Visible", "Visible material.", {"Off", "Flat", "Color", "Metalic", "Glow", "Textured", "Invisible",},},
                    {"Overlay", "Apply over previus materials.", {"Off", "Wireframe",},},
                },
                {
                    {"Occluded", "Material occluded by walls.", {"Off", "Flat", "Color", "Metalic", "Glow",},},
                    {"Visible", "Visible material.", {"Off", "Flat", "Color", "Metalic", "Glow", "Textured", "Invisible",},},
                    {"Overlay", "Apply over previus materials.", {"Off", "Wireframe",},},
                },
                {
                    {"Occluded", "Material occluded by walls.", {"Off", "Flat", "Color", "Metalic", "Glow",},},
                    {"Visible", "Visible material.", {"Off", "Flat", "Color", "Metalic", "Glow", "Textured", "Invisible",},},
                    {"Overlay", "Apply over previus materials.", {"Off", "Wireframe",},},
                },
                {
                    {"Occluded", "Material occluded by walls.", {"Off", "Flat", "Color", "Metalic", "Glow",},},
                    {"Visible", "Visible material.", {"Off", "Flat", "Color", "Metalic", "Glow", "Textured", "Invisible",},},
                    {"Overlay", "Apply over previus materials.", {"Off", "Wireframe",},},
                },
                {
                    {"Occluded", "Material occluded by walls.", {"Off", "Flat", "Color", "Metalic", "Glow",},},
                    {"Visible", "Visible material.", {"Off", "Flat", "Color", "Metalic", "Glow", "Textured", "Invisible",},},
                    {"Overlay", "Apply over previus materials.", {"Off", "Wireframe",},},
                },
            },
            {
                {"Change visual items",},
                {
                    {"Item", "Select weapon or model.",},
                    {"Paint Kits", "Select skin of model",},
                    {"Wear", "Quality of item texture.",},
                    {"Seed", "Seed of texture generation.",},
                    {"StatTrak", "Kill counter of weapon.",},
                    {"Name", "Custom name of item.",},
                    {"Add",},
                    {"Remove",},
                },
            },
            {
                {"Extra", "Performance", "Effects",},
                {
                    {"Radar", "Display custom radar.",},
                    {"Radar Range", "Set radar range.",},
                    {"Crosshair", "Display custom crosshair.",},
                    {"Crosshair Recoil", "Draws the spot where your shots will go.", {"Off", "Line", "Fade",},},
                    {"Anti-OBS", "Hide visuals from screen recorder.",},
                    {"Anti-Screenshot", "Hide visuals from screenshots.",},
                    {"Preserve Killfeed", "Preserve the killfeed.",},
                },
                {
                    {"No Render For Teammates",},
                    {"No Render For Enemies",},
                    {"No Render For Weapons",},
                    {"No Render For Ragdolls",},
                    {"Disable Far Models",},
                },
                {
                    {"No Flash",},
                    {"No Smoke",},
                    {"No Recoil",},
                    {"No Scope",},
                    {"No Scope Overlay",},
                    {"No Sky",},
                    {"No Fog",},
                    {"No Post Processing",},
                },
            },
        },
        {
            {"General", "Movement", "Enhancement",},
            {
                {"Extra", "Logs", "Restrictions", "Bypass", "Server",},
                {
                    {"Show Spectators", "See who is spectating you.",},
                    {"Show Ranks", "Show ranks of players.",},
                    {"Auto-Accept Match", "Automatically accept match.",},
                },
                {
                    {"Log Damage", "Log damage dealt to enemies.",},
                    {"Log Purchases", "Log purchases made by enemy team.",},
                    {"Log Console", "Log Console messages on screen.",},
                },
                {
                    {"Anti-Untrusted", "Restrict Various features on Valve servers.",},
                },
                {
                    {"Bypass sv_pure", "Allow custom models and materials from csgo directory.",},
                    {"Bypass sv_cheats", "Bypass protected convars.",},
                    {"Unlock Steam Achievements",},
                    {"Show hidden ConVars",},
                },
                {
                    {"sv_maxunlag", "Configure server-side max backtracking factor.",},
                    {"sv_maxusrcmdprocessticks", "Configure server-side max lag factor.",},
                },
            },
            {
                {"Jump", "Other", "Strafe",},
                {
                    {"Auto Jump", "Select auto jump mode for bunnyhopping.", {"Off", "Perfect", "Legit",},},
                    {"Edge Jump", "Jump right before falling of an edge.",},
                    {"Duck Jump", "Reach higher by crouching while jumping.",},
                    {"Auto Jump-Bug", "No fall damage when landing from certain height.",},
                },
                {
                    {"Fast Duck", "Exploit movement code to crouch quicker.",},
                    {"Slide Walk", "Glitch animation to appear sliding."},
                },
                {
                    {"Enable", "Enable autostrafer to gain more speed.",},
                    {"Air Strafe", "Increases forward speed while jumping.",},
                    {"Strafe Mode", "Select style of autostrafing.", {"Silent", "Normal", "Sideways", "W-Only", "Mouse",},},
                    {"Circle Strafe", "Strafe in circles when pressing a key.",},
                    {"Snake Strafe", "Strafe like a snake when pressing a key.",},
                    {"Retrack Speed", "Autostrafe in direction of pressed keys.",},
                    {"WASD-Movement", "Autostrafe in direction of pressed keys.",},
                },
            },
            {
                {"Fakelag", "Fakelatency", "Appearance",},
                {
                    {"Enable", "Enable lag effect.",},
                    {"On Key", "Enable lag only when holding this key.",},
                    {"Type", 'Type or "patern" of lag.', {"Normal", "Adaptive", "Random", "Switch",},},
                    {"Factor", "How many commands will be chocked.",},
                    {"Enable Peek Mode", "Lag your model behind wall when peeking.",},
                    {"Conditions", "Configure fakelag options.", [4] = {"While Standing", "While In Air", "While On Ground",},},
                },
                {
                    {"Enable", "Enable latency modifier.",},
                    {"On Key", "Increase latency only when holding this key.",},
                    {"Amount", "Absolute latency to achieve.",},
                },
                {
                    {"Steal Name", "Steal other player name, limited to 5 times.",},
                    {"Invisible Name", "Make your name invisible",},
                    {"Chat Spam", "Advertise AIMWARE in chat.",},
                    {"Clantag Changer", "Put AIMWARE as your clantag.",},
                },
            },
        },
        {
            {"Configurations", "Lua Scripts", "Advanced",},
            {
                {"Manage configurations",},
                {
                    {"Name", "Create or rename configuration.",},
                    {"Create",},
                    {"Rename",},
                    {"Load",},
                    {"Save",},
                    {"Reset",},
                    {"Delete",},
                    {"Export To Clipboard",},
                    {"Import From Clipboard",},
                    {"Set As Default",},
                    {"Refresh List",},
                },
            },
            {
                {"Manage scripts",},
                {
                    {"Name", "Create or rename configuration.",},
                    {"Create",},
                    {"Rename",},
                    {"Edit (BETA)",},
                    {"Load",},
                    {"Unload",},
                    {"Reset Lua State",},
                    {"Delete",},
                    {"Set As Autorun",},
                    {"Refresh List",},
                },
            },
            {
                {"Manage Advanced Settings",},
                {
                    {"Open Menu Key", "Bind for main menu toggle.",},
                    {"Open Console Key", "Console for more customization.",},
                    {"Dpi Scale", "Scale the UI size by this amount.",},
                    {"Open Settings Folder",},
                    {"Menu Language",},
                },
            },
        },
    },
    ["Deutsch"] = {
        {"Legitbot", "Ragebot", "Visuell", "Misc", "Settings",},
        {
            {"Aimbot", "Triggerbot", "Waffe", "Andere", "Semirage",},
            {
                {"Toggle", "Waffe", "Hitbox Auswahl",},
                {
                    {"Aktivieren", "Aktiviert den Legit Aimbot.",},
                    {"Aim Taste", "Setzt die Taste des Legit Aimbots.",},
                    {"Toggle Taste", "Aktiviert/Deaktiviert den Legit Aimbot",},
                },
                {
                    {"Automatisches Feuern", "Schie??t ohne eine Taste zu dr??cken.",},
                    {"Feuern auf Tastendruck", "Schie??t nur wenn entsprechende Taste gedr??ckt ist.",},
                    {"Auto Pistol Interval", "Intervall zwischen Pistolen Sch??ssen.",},
                },
                {
                    {[2] = "Reihenfolge die der Aimbot f??r die Hitboxen w??hlt."},
                    {[5] = true, "Hitbox Wechsel Pause", "Wie schnell der Aimbot auf die n??chste Hitbox zielt.",},
                    {[5] = true, "Nah zum Fadenkreuz", "W??hlt die Hitbox als erstes die am Fadenkreuz dran ist.",},
                },
            },
            {
                {"Toggle", "Waffe", "Hitbox Scan",},
                {
                    {"Aktivieren", "Aktiviert den Triggerbot.",},
                    {"Trigger Taste", "Triggerbot reagiert nur bei Tastendruck.",},
                    {"Automatisches Feuern", "Triggerbot funktioniert ohne Tastendruck.",},
                },
                {
                    {[5] = true, "Trigger Verz??gerung", "Zeit, nachdem der Triggerbot schie??t.",},
                    {[5] = true, "Trigger Burst", "Zeit, wie lange nach dem Triggern weitergeschossen wird",},
                    {[5] = true, "Trefferchance", "Wahrscheinlichkeit mit dem Triggerbot zu treffen.",},
                    {[5] = true, "Kein R??cksto??", "Reduziert Recoil beim Benutzen des Triggerbots.",},
                },
                {
                    {[2] = "Trigger auf ausgew??hlten Hitboxen.",},
                },
            },
            {
                {"Genauigkeit", "Ziel", "Aiming", "Sichtbarkeit",},
                {
                    {[5] = true, "Kein Aimbot R??cksto??", "Vermindert R??cksto?? beim Schie??en mit dem Aimbot.",},
                    {[5] = true, "Kein R??cksto??", "Reduziert R??cksto?? auch ohne Aimbot.",},
                    {[5] = true, "Horizontale Einstellung", "Horizontaler Widerstand beim Schie??en.",},
                    {[5] = true, "Vertikale Einstellung", "Vertikaler Widerstand beim Schie??en.",},
                },
                {
                    {[5] = true, "Mindest-Aimbot Sichtfeld", "Aimbot visiert mindestens in diesem Umkreis an.",},
                    {[5] = true, "Maximales Aimbot Sichtfeld", "Aimbot visiert maximal in diesem Umkreis an.",},
                    {[5] = true, "Ziel??nderungs-Verz??gerung", "Zeit, bevor der Aimbot einen neuen Gegner anvisiert.",},
                    {[5] = true, "Erste Schuss Verz??gerung", "Zeit, wie lange der Aimbot wartet vorm Schie??en.",},
                },
                {
                    {[5] = true, "Gl??ttungs Faktor", "Rundet die Bewegung des Aimbots ab.",},
                    {[5] = true, "Gl??ttungs Methode", "Methode zum Abrunden.", {"Dynamisch", "Statisch",},},
                    {[5] = true, "Randomisierungs Faktor", "Randomisiert Anvisieren des Aimbots.",},
                    {[5] = true, "Rundungs Faktor", "Aimbot Bewegung ist kurviger und weniger linear.",},
                },
                {
                    {[5] = true, "Auto Wall", "Visiert durch durchdringbare W??nde an.",},
                    {[5] = true, "Durch Smoke", "Visiert durch Smokegranaten an.",},
                },
    
            },
            {
                {"Bewegung", "Extra",},
                {
                    {"Laufgeschwindigkeits Anpassung", "Aktiviert Laufgeschwindigkeits Modifikationen.",},
                    {"Laufgeschwindigkeit", "??ndert automatische Laufgeschwindigkeit.",},
                    {"Schnelles Stoppen", "Schnelleres Stoppen durch das erwidern der Laufrichtung.",},
                },
                {
                    {"Backtrack Zeit", "Zeit, in der vorherige Positionen von Gegnern treffbar sind.",},
                    {"Messer Triggerbot", "Aktiviert den Triggerbot mit dem Messer.",},
                },
            },
            {
                {"Aimbot", "Positionsjustierung", "Anti-Aim",},
                {
                    {"Silent Aimbot", "Automatisches Zielen in geringem Sichtfeld.",},
                    {"Automatisches Stoppen", "Weniger Ungenauigkeit aufgrund des Stoppens der Bewegung.",},
                },
                {
                    {"Backtracking", "Visiert vorherige Positionen der Gegner an.",},
                    {"Resolver", "Verbessert Genauigkeit bei Gegnern mit Anti-Aim.",},
                },
                {
                    {"St??rke", "Maximum ist sichtbar beim Zuschauen.", {"Aus", "Minimum", "Maximum",},},
                    {"Richtung", "Modus zum W??hlen der Richtung.", {"Auto", "Manuell",},},
                    {"Linke Seite",},
                    {"Rechte Seite",},
                    {"Wenn Gegner anvisiert", "Aktiviert Anti-Aim wenn der Gegner dich anvisiert.",},
                    {"Deaktivieren auf Messer", "Deaktiviert Anti-Aim auf dem Messer.",},
                    {"Deaktivieren auf Granaten", "Deaktiviert Anti-Aim auf Granaten.",},
                },
            },
        },
        {
            {"Aimbot", "Genauigkeit", "Hitscan", "Anti-Aim",},
            {
                {"Toggle", "Automatisierung", "Ziel", "Extra",},
                {
                    {"Aktivieren", "Aktiviert den Rage Aimbot.",},
                    {"Aimbot Taste", "Setzt die Taste des Rage Aimbots.",},
                    {"Toggle Taste", "Aktiviert/Deaktiviert den Rage Aimbot.",},
                },
                {
                    {"Automatische Pistole", "Pistolen schie??en wie Automatikwaffen.",},
                    {"Automatischer Revolver", "L??sst den Revolver schneller schie??en.",},
                    {"Automatischer Scope", "Aktiviert automatisch die Zielansicht.", {"Aus", "An - Auto Unzoom", "An - Kein Unzoom",},}, 
                },
                {
                    {"Sichtfeld", "Maximales Sichtfeld, worin der Aimbot anvisiert.",},
                    {"Aim Lock", "Bleibt auf Gegner bis dieser erledigt ist.",},
                    {"Silent Aim", "Kein Sichtbares Zucken auf Ziel.",},
                },
                {
                    {"Knifebot", "Greift Gegner automatisch mit dem Messer an.", {"An", "Normaler Knifebot", "Nur Backstab", "Schnelles Stechen",},},
                },
            },
            {
                {"Waffe", "Positionsjustierung", "Bewegung",},
                {
                    {[5] = true, "Trefferchance", "Mindest-Trefferchance mit dem Aimbot zu treffen.",},
                    {[5] = true, "Mindest-Schaden", "Mindest-Schaden bevor der Aimbot schie??t.",},
                    {[5] = true, "Kein Recoil", "Entfernt Recoil aufgrund besserer Genauigkeit.",},
                },
                {
                    {"Backtracking", "Ragebot visiert vorherige Positionen der Gegner an.",},
                    {"Resolver", "Verbessert Genauigkeit bei Gegnern mit Anti-Aim.",},
                },
                {
                    {"Automatisches Stoppen", "Weniger Ungenauigkeit aufgrund des Stoppens der Bewegung.",},
                    {"Automatisches Ducken", "Bei geringer Genauigkeit duckt sich der Spieler automatisch.",},
                    {"Slow Walk Taste", "Verlangsamt Laufbewegung auf Tastendruck.",},
                    {"Slow Walk Geschwindigkeit", "Geschwindigkeit des Slow Walks.",},
                    {"Schnelles Stoppen", "Schnelleres Stoppen durch das erwidern der Laufrichtung.",},
                },
            },
            {
                {"Hitbox Punkte", "Hitbox Priorit??t", "Modus", "Erweitert",},
                {
                    {[2] = "Anzahl der Punkte die der Aimbot anvisiert.",},
                },
                {
                    {[2] = "Reihenfolge der Punkte die der Aimbot anvisiert.",},
                },
                {
                    {[5] = true, "Auto Wall", "Visiert durch durchdringbare W??nde an.",},
                    {[5] = true, "Schuss Verz??gerung", "Wartet auf einen genaueren Hitbox Status.",},
                    {[5] = true, "T??dliches Bodyaim", "Visiert den K??rper an wenn soweit t??dlich.",},
                },
                {
                    {"Maximale Processing Zeit", "Verringere diesen Wert um bessere FPS zu erlangen.",},
                },
            },
            {
                {"Basis Ausrichtung", "Linke Ausrichtung", "Rechte Ausrichtung", "Zustand", "Erweitert",},
                {
                    {[6] = true, "Spinbot Geschwindigkeit",},
                    {[6] = true,"Rotations Offset",},
                    {[6] = true,"LBY Offset",},
                },
                {
                    {[6] = true,"Spinbot Geschwindigkeit",},
                    {[6] = true,"Rotations Offset",},
                    {[6] = true,"LBY Offset",},
                },
                {
                    {[6] = true,"Spinbot Geschwindigkeit",},
                    {[6] = true,"Rotations Offset",},
                    {[6] = true,"LBY Offset",},
                },
                {
                    {"Deaktiviere beim Interagieren", "Deaktiviert Anti-Aim auf der CS:GO Interaktionstaste",},
                    {"Deaktivieren auf Messer", "Deaktiviert Anti-Aim auf dem Messer.",},
                    {"Deaktivieren auf Granaten", "Deaktiviert Anti-Aim auf Granaten.",},
                    {"On Shot", "Verhindert, dass das Onshot Model getroffen wird.", {"Normal", "Desync", "Shift",},},
                },
                {
                    {"Automatisches Ausrichten", "Richtet das Anti-Aim nach vorhandenen Hindernissen aus.",},
                    {"Anti-Alignment", "Verhindert festsetzen des Desync Anti-Aims",},
                    {"Anti-Resolver", "Bei durchg??ngigem Feuern weniger treffbar.",},
                    {"Pitch Gradzahl", "", {"Aus", "89??", "180?? (Bannbar)",},},
                    {"Fake Duck", "L??sst dich w??hrend dem Ducken wie beim Stehen schie??en.",},
                },
            },          
        },
        {
            {"??bersicht", "Lokal", "Welt", "Chams", "Skins", "Andere",},
            {
                {"Team", "Gegner", "Waffen",},
                {
                    {"Box", "Zeichnet eine 2D Box.", {"Aus", "Outlined", "Normal",},},
                    {"Box Precision", "Zeichnet eine pr??zisere Box um das Objekt.",},
                    {"Name", "Zeichnet Name des Objekts.",},
                    {"Skelett", "Zeichnet Skelett des Spielers.",},
                    {"Glow", "Malt einen Glow Effekt um Spieler", {"Aus", "Team Farbe", "Gesundheits Farbe",},},
                    {"Gesundheit", "Gesundheits Optionen konfigurieren.", [4] = {"Balken", "Nummer",},},
                    {"R??stung", "R??stungs Optionen konfigurieren.", [4] = {"Balken", "Nummer",},},
                    {"Waffen", "Zeichnet den Waffen Namen.", {"Aus", "Aktiv", "Alle", "Aktiv + Granaten",},},
                    {"Flags", "Zeigt Aktivit??ten des Spielers", [4] = {"Entsch??rft", "Platziert", "Scoped", "L??dt nach", "Geflashed", "Hat Defuser", "Hat C4",},},
                    {"Geld", "Zeichnet wie viel Geld der Spieler hat.",},
                    {"Blickrichtung", "Malt eine Linie, wo der Spieler hinguckt.",},
                },
                {
                    {"Box", "Zeichnet eine 2D Box.", {"Aus", "Outlined", "Normal",},},
                    {"Box Precision", "Zeichnet eine pr??zisere Box um das Objekt.",},
                    {"Name", "Zeichnet Name des Objekts.",},
                    {"Skelett", "Zeichnet Skelett des Spielers.",},
                    {"Glow", "Malt einen Glow Effekt um Spieler", {"Aus", "Team Farbe", "Gesundheits Farbe",},},
                    {"Gesundheit", "Gesundheits Optionen konfigurieren.", [4] = {"Balken", "Nummer",},},
                    {"R??stung", "R??stungs Optionen konfigurieren.", [4] = {"Balken", "Nummer",},},
                    {"Waffen", "Zeichnet den Waffen Namen.", {"Aus", "Aktiv", "Alle", "Aktiv + Granaten",},},
                    {"Flags", "Zeigt Aktivit??ten des Spielers", [4] = {"Entsch??rft", "Platziert", "Scoped", "L??dt nach", "Geflashed", "Hat Defuser", "Hat C4",},},
                    {"Geld", "Zeichnet wie viel Geld der Spieler hat.",},
                    {"Blickrichtung", "Malt eine Linie, wo der Spieler hinguckt.",},
                },
                {
                    {"Box", "Zeichnet eine 2D Box.", {"Aus", "Outlined", "Normal",},},
                    {"Box Precision", "Zeichnet eine pr??zisere Box um das Objekt.",},
                    {"Name", "Zeichnet Name des Objekts",},
                    {"Munition", "Anzahl der Munition die in der Waffe vorhanden ist.",},
                    {"C4 Timer", "Zeigt einen Timer an, wann die Bombe explodiert.",},
                    {"Danger Zone Items", "Zeigt verschiedene Gegenst??nde in Dangerzone an.",},
                    {"Danger Zone Gesch??tz", "Zeigt Gesch??tze in Dangerzone an.",},
                },
            },
            {
                {"Camera", "Hilfestellungen",},
                {
                    {"Third Person Toggle", "Aktiviert die Third Person Sicht.",},
                    {"Third Person Distanz", "Distanz der Third Person Sicht.",},
                    {"Smooth Ghost Model", "Ghost Model geht mit echtem Model einher.",},
                },
                {
                    {"Wallbang Schaden", "Zeigt penetrierbare Fl??chen auf Hindernissen an.",},
                    {"Au??erhalb des Sichtfelds", "Zeigt Gegner au??erhalb des Sichtfelds an.",},  
                },
            },
            {
                {"Extra", "Materialien", "Granaten",},
                {
                    {"Hitmarker", "Spielt einen Sound beim Treffen eines Gegners.",},
                    {"Schritte", "Zeit Schritte visuell an.",},
                },
                {
                    {"Walls Color",},
                    {"Static Props Color",},
                    {"Skybox", "??ndert das Aussehen des Himmels",},
                },
                {
                    {"Inferno", "Zeigt Brandgranaten und Molotovs an.", [4] = {"Eigene", "Team", "Gegner",},},
                    {"Granaten Prognose", "Zeigt an, wo Granaten hinfliegen.", [4] = {"Eigene", "Team", "Gegner",},},
                },
            },
            {
                {"Team", "Gegner", "Lokal", "Ghost", "Backtrack", "Weapon",},
                {
                    {"Verdeckt", "Material verdeckt von Hindernissen.", {"Aus", "Flat", "Color", "Metalic", "Glow",},},
                    {"Sichtbar", "Sichtbares Material.", {"Aus", "Flat", "Color", "Metalic", "Glow", "Textured", "Invisible",},},
                    {"Overlay", "Ersetzt vorherige Materialien.", {"Aus", "Wireframe",},},
                },
                {
                    {"Verdeckt", "Material verdeckt von Hindernissen.", {"Aus", "Flat", "Color", "Metalic", "Glow",},},
                    {"Sichtbar", "Sichtbares Material.", {"Aus", "Flat", "Color", "Metalic", "Glow", "Textured", "Invisible",},},
                    {"Overlay", "Ersetzt vorherige Materialien.", {"Aus", "Wireframe",},},
                },
                {
                    {"Verdeckt", "Material verdeckt von Hindernissen.", {"Aus", "Flat", "Color", "Metalic", "Glow",},},
                    {"Sichtbar", "Sichtbares Material.", {"Aus", "Flat", "Color", "Metalic", "Glow", "Textured", "Invisible",},},
                    {"Overlay", "Ersetzt vorherige Materialien.", {"Aus", "Wireframe",},},
                },
                {
                    {"Verdeckt", "Material verdeckt von Hindernissen.", {"Aus", "Flat", "Color", "Metalic", "Glow",},},
                    {"Sichtbar", "Sichtbares Material.", {"Aus", "Flat", "Color", "Metalic", "Glow", "Textured", "Invisible",},},
                    {"Overlay", "Ersetzt vorherige Materialien.", {"Aus", "Wireframe",},},
                },
                {
                    {"Verdeckt", "Material verdeckt von Hindernissen.", {"Aus", "Flat", "Color", "Metalic", "Glow",},},
                    {"Sichtbar", "Sichtbares Material.", {"Aus", "Flat", "Color", "Metalic", "Glow", "Textured", "Invisible",},},
                    {"Overlay", "Ersetzt vorherige Materialien.", {"Aus", "Wireframe",},},
                },
                {
                    {"Verdeckt", "Material verdeckt von Hindernissen.", {"Aus", "Flat", "Color", "Metalic", "Glow",},},
                    {"Sichtbar", "Sichtbares Material.", {"Aus", "Flat", "Color", "Metalic", "Glow", "Textured", "Invisible",},},
                    {"Overlay", "Ersetzt vorherige Materialien.", {"Aus", "Wireframe",},},
                },
            },
            {
                {"Visuelle Items ??ndern",},
                {
                    {"Item", "W??hle Waffe or Model",},
                    {"Paint Kits", "W??hle Skins f??r Waffen",},
                    {"Wear", "Qualit??t des Skins",},
                    {"Seed", "Seed der Textur-Generation",},
                    {"StatTrak", "Kill-Z??hler f??r Waffen",},
                    {"Name", "Eigener Name f??r Waffen.",},
                    {"Hinzuf??gen",},
                    {"Entfernen",},
                },
            },
            {
                {"Extra", "Performance", "Effekte",},
                {
                    {"Radar", "Zeigt Radar an.",},
                    {"Radar Reichweite", "Setzt Radar Reichweite.",},
                    {"Fadenkreuz", "Zeigt eigenes Fadenkreuz an.",},
                    {"R??cksto??-Fadenkreuz", "Zeichnet wo Sch??sse aufgrund von R??cksto?? einschlagen.", {"Aus", "Linie", "Fade",},},
                    {"Anti-OBS", "Versteckt Visuelle Effekte beim Aufnehmen mit OBS",},
                    {"Anti-Screenshot", "Zeigt keine Visuellen Effekte auf Screenshots.",},
                    {"Preserve Killfeed", "Killfeed verschwindet erst beim Rundenbeginn.",},
                },
                {
                    {"Kein Rendern f??r Teammitglieder",},
                    {"Kein Rendern f??r Gegner",},
                    {"Kein Rendern f??r Waffen",},
                    {"Kein Rendern f??r Todesanimationen",},
                    {"Kein Rendern f??r weit entfernte Objekte",},
                },
                {
                    {"Kein Flash Effekt",},
                    {"Kein Smoke Effekt",},
                    {"Kein visueller R??cksto??",},
                    {"Kein Scope",},
                    {"Kein Scope Overlay",},
                    {"Kein Himmel",},
                    {"Kein Nebel",},
                    {"Kein Post Processing",},
                },
            },
        },
        {
            {"Allgemein", "Bewegung", "Verbesserung",},
            {
                {"Extra", "Logs", "Beschr??nkungen", "Bypass", "Server",},
                {
                    {"Zeige Zuschauer", "Zeigt an, wer dir zuschaut.",},
                    {"Zeige R??nge", "Zeigt R??nge von Spielern.",},
                    {"Automatisches Akzeptieren", "Automatisches Akzeptieren beim Suchen eines Spiels.",},
                },
                {
                    {"Schaden Logs", "Zeichnet Schaden der Runde auf.",},
                    {"Eink??ufe Logs", "Zeichnet Eink??ufe des Gegnerteams auf.",},
                    {"Konsolen Logs", "Zeigt Konsolen Operationen auf dem Bildschirm.",},
                },
                {
                    {"Anti-Untrusted", "Verhindert das Nutzen von Features auf VAC Servern.",},
                },
                {
                    {"Bypass sv_pure", "Verhindert das Untersuchen auf Vollst??ndigkeit der Materialien.",},
                    {"Bypass sv_cheats", "Bypasst gesch??tze convars.",},
                    {"Steam Errungenschaften freischalten.",},
                    {"Zeige versteckte ConVars",},
                },
                {
                    {"sv_maxunlag", "Konfiguriert maximales Backtracking auf Seiten des Servers.",},
                    {"sv_maxusrcmdprocessticks", "Konfiguriert maximalen Fakelag auf Seiten des Servers.",},
                },
            },
            {
                {"Springen", "Andere", "Strafe",},
                {
                    {"Automatisches Springen", "W??hlt Modus f??rs Bunnyhopping.", {"Aus", "Perfekt", "Legit",},},
                    {"Kanten Sprung", "Springt kurz vor der Kante ab.",},
                    {"Geducktes Springen", "Springe h??her durchs Ducken beim Springen.",},
                    {"Auto Jump-Bug", "Kein Fallschaden beim Herunterfallen von gewissen H??hen.",},
                },
                {
                    {"Schnelles Ducken", "Schnelleres Ducken durch Exploit im Movement.",},
                    {"Slide Walk", "Glitcht Laufanimation sodass es aussieht als w??rde man rutschen."},
                },
                {
                    {"Aktivieren", "Aktiviert Autostrafer um h??here Geschwindigkeiten zu erreichen.",},
                    {"Air Strafe", "Erh??ht Geschwindigkeit beim Springen.",},
                    {"Strafe Modus", "W??hlt Style vom Autostrafing.", {"Lautlos", "Normal", "Seitw??rts", "W-Only", "Maus",},},
                    {"Circle Strafe", "Strafed automatisch im Kreis.",},
                    {"Snake Strafe", "Strafed wie eine Schlange.",},
                    {"Retrack Speed", "Zeit wie lange der Strafer braucht um die Richtung zu wechseln.",},
                    {"WASD-Movement", "Bewegt sich in Richtung der gedr??ckten Tasten.",},
                },
            },
            {
                {"Fakelag", "Fakelatency", "Erscheinung",},
                {
                    {"Aktivieren", "Aktiviert Lag Effekt.",},
                    {"Auf Taste", "Aktiviert den Lag nur, wenn Taste gedr??ckt ist.",},
                    {"Art", "Art oder Muster des Fakelags.", {"Normal", "Adaptiv", "Random", "Switch",},},
                    {"Faktor", "Wie viele Pakete gechoked werden.",},
                    {"Aktiviert Peek Modus", "Laggt das Model hinter eine Wand beim Peeken.",},
                    {"Zust??nde", "Konfiguriert Fakelag.", [4] = {"Beim Stehen", "In der Luft", "Auf dem Boden",},},
                },
                {
                    {"Aktivieren", "Aktiviert die Fakelatenz",},
                    {"Auf Taste", "Latenz wird nur erh??ht wenn Taste gedr??ckt ist.",},
                    {"Wert", "H??chste Latenz die erreicht wird.",},
                },
                {
                    {"Namen stehlen", "Stiehlt Namen von anderen Spielern, limitiert auf 5.",},
                    {"Unsichtbarer Name", "Macht den eigenen Namen unsichtbar.",},
                    {"Chat Spam", "Bewirbt AIMWARE im Chat",},
                    {"Clantag Changer", "Setzt AIMWARE als dein Clantag.",},
                },
            },
        },
        {
            {"Configs", "Lua Scripts", "Erweitert",},
            {
                {"Configs verwalten",},
                {
                    {"Name", "Erstellen oder umbenennen einer Config.",},
                    {"Erstellen",},
                    {"Umbenennen",},
                    {"Laden",},
                    {"Speichern",},
                    {"Reset",},
                    {"L??schen",},
                    {"Export zum Clipboard",},
                    {"Import vom Clipboard",},
                    {"Als Default setzen",},
                    {"Liste aktualisieren",},
                },
            },
            {
                {"Scripts verwalten",},
                {
                    {"Name", "Erstellen oder umbenennen eines Scripts.",},
                    {"Erstellen",},
                    {"Umbenennen",},
                    {"Editieren (BETA)",},
                    {"Laden",},
                    {"Entladen",},
                    {"Reset Lua State",},
                    {"L??schen",},
                    {"Als Autorun setzen",},
                    {"Liste aktualisieren",},
                },
            },
            {
                {"Erweiterte Einstellungen verwalten",},
                {
                    {"Menu Taste", "Taste mit der das Menu ge??ffnet wird.",},
                    {"Konsole Taste", "Taste mit der die Konsole ge??ffnet wird.",},
                    {"DPI Scale", "Skaliert die Gr????e des UI.",},
                    {"Open Settings Folder",},
                    {"Menu Sprache",},
                },
            },
        },
    },

};

local function SetLanguage(lg)
    for i = 1, #db[db.prev][1] do
        for j = 1, #db[db.prev][(i + 1)][1] do
            for k = 1, #db[db.prev][(i + 1)][(j + 1)][1] do
                for l = 1, #db[db.prev][(i + 1)][(j + 1)][(k + 1)] do                   
                    if db[db.prev][(i + 1)][(j + 1)][(k + 1)][l][5] == nil and db[db.prev][(i + 1)][(j + 1)][(k + 1)][l][6] == nil then --Cannot acces inside of per weapon groupboxes and aa tab
                        if db[db.prev][(i + 1)][(j + 1)][(k + 1)][l][1] ~= nil then
                            local curr_ref = gui.Reference(db[db.prev][1][i], db[db.prev][(i + 1)][1][j], db[db.prev][(i + 1)][(j + 1)][1][k], db[db.prev][(i + 1)][(j + 1)][(k + 1)][l][1]);
                            if db[db.prev][(i + 1)][(j + 1)][(k + 1)][l][4] ~= nil then
                                for m = 1, #db[db.prev][(i + 1)][(j + 1)][(k + 1)][l][4] do --Multibox
                                    gui.Reference(db[db.prev][1][i], db[db.prev][(i + 1)][1][j], db[db.prev][(i + 1)][(j + 1)][1][k], db[db.prev][(i + 1)][(j + 1)][(k + 1)][l][1], db[db.prev][(i + 1)][(j + 1)][(k + 1)][l][4][m]):SetName(db[lg][(i + 1)][(j + 1)][(k + 1)][l][4][m]);
                                end;
                            end;
                            if db[db.prev][(i + 1)][(j + 1)][(k + 1)][l][3] ~= nil then
                                curr_ref:SetOptions(unpack(db[lg][(i + 1)][(j + 1)][(k + 1)][l][3])); --Radio buttons doesn't accept :SetOptions
                            end;
                            if db[db.prev][(i + 1)][(j + 1)][(k + 1)][l][2] ~= nil then                                
                                curr_ref:SetDescription(db[lg][(i + 1)][(j + 1)][(k + 1)][l][2]);
                            end;                        
                                curr_ref:SetName(db[lg][(i + 1)][(j + 1)][(k + 1)][l][1]);
                        else
                            if db[db.prev][(i + 1)][(j + 1)][(k + 1)][l][2] ~= nil then --Some Groupboxes have descriptions but it seems broken in per weapon groupboxes
                                gui.Reference(db[db.prev][1][i], db[db.prev][(i + 1)][1][j], db[db.prev][(i + 1)][(j + 1)][1][k]):SetDescription(db[lg][(i + 1)][(j + 1)][(k + 1)][l][2]);
                            end;
                        end;
                    end;
                end;
            gui.Reference(db[db.prev][1][i], db[db.prev][(i + 1)][1][j], db[db.prev][(i + 1)][(j + 1)][1][k]):SetName(db[lg][(i + 1)][(j + 1)][1][k]);
            end;
        gui.Reference(db[db.prev][1][i], db[db.prev][(i + 1)][1][j]):SetName(db[lg][(i + 1)][1][j]);
        end;
    gui.Reference(db[db.prev][1][i]):SetName(db[lg][1][i]);
    end;
    db.prev = lg;
end;

local ui_select = gui.Combobox(gui.Reference("Settings", "Advanced", "Manage advanced settings"), "language", "Menu Language", unpack(db.lang));

callbacks.Register("Draw", function()
    if db.lang[(ui_select:GetValue() + 1)] ~= db.prev then
        SetLanguage(db.lang[(ui_select:GetValue() + 1)]);
    end;
end);

callbacks.Register("Unload", function()
    SetLanguage(db.lang[1]);
end);