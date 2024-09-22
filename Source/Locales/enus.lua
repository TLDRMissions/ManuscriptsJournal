local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "enUS", true)
if not L then return end

-- Misc strings
L["MANUSCRIPTS_PROGRESS_FORMAT"] = "%d/%d"
L["Rare Spawns"] = true
L["ADDON_NAME"] = "Manuscripts"
L["Source:"] = true
L["Grand Hunts"] = true
L["Required Rank:"] = true
L["Various in:"] = true
L["Various"] = true
L["Bugged"] = "Due to a bug, this may be unobtainable."
L["Dragon Racing Container"] = "Dragon Racing "..AUCTION_CATEGORY_CONTAINERS
L["Dragon Racing Achievement"] = "Dragon Racing "..BATTLE_PET_SOURCE_6
L["Treasure Chest"] = "Chest"
L["PvP Seasonal"] = true

L["Time Rifts"] = QuestUtils_GetQuestName(76984)
QuestEventListener:AddCallback(76984, function()
	L["Time Rifts"] = QuestUtils_GetQuestName(76984)
end)

-- Reputation and Friendship ranks
L["Friend"] = true
L["True Friend"] = true
L["Maximum"] = true
L["High"] = true
L["Medium"] = true
L["Low"] = true

-- Vendors
L["Kraxxus"] = true
L["Meiz"] = true
L["Ponzo"] = true
L["Maztha"] = true
L["Cravitz Lorent"] = true
L["Flamesmith Lanying"] = true
L["Endora Moorehead"] = true
L["Imp Mother Dyala"] = true
L["Vi'el"] = true
L["Aridormi"] = true
L["Cupri"] = true
L["Gigi Gigavoid"] = true
L["Sir Finley"] = "Sir Finley Mrrgglton"
L["Reno Jackson"] = true

-- Rare spawns
L["Honey Smasher"] = true
L["Gethdazr"] = true
L["Corrupted Proto-Dragon"] = true
L["Diluu"] = true
L["Treasure-Mad Trambladd"] = true
L["Shadeslash Trakken"] = true
L["Tikarr Frostclaw"] = true
L["Sparkspitter Vrak"] = true
L["Phleep"] = true
L["Sandana the Tempest"] = true
L["Innumerable Ruination"] = true
L["Lord Epochbrgl"] = true
L["Researcher Sneakwing"] = true
L["Razk'vex the Untamed"] = true
L["Ancient Hornswog"] = true
L["Acrosoth"] = true
L["Tomnu"] = true
L["Nulltheria the Void Gazer"] = true
L["Shade of Grief"] = true
L["Blightpaw the Depraved"] = true
L["High Shaman Rotknuckle"] = true
L["Blightfur"] = true
L["Klozicc the Ascended"] = true
L["Beogoka"] = true
L["Notfar the Unbearable"] = true
L["Graniteclaw"] = true
L["O'nank Shorescour"] = true
L["Brackle"] = true
L["Gorjo the Crab Shackler"] = true
L["Skewersnout"] = true
L["Swog'ranka"] = true
L["Massive Magmashell"] = true
L["Loot Specialist"] = true
L["Fisherman Tinnak"] = true
L["Forgotten Gryphon"] = true
L["Sharpfang"] = true
L["Mange the Outcast"] = true
L["Snarglebone"] = true
L["Scav Notail"] = true
L["Dragonhunter Igordan"] = true	
L["Rohzor Forgesmash"] = true
L["Cauldronbearer Blakor"] = true
L["Rasnar the War Ender"] = true			
L["Dragonhunter Gorund"] = true	
L["Captain Lancer"] = true
L["Anhydros the Tidetaker"] = true
L["Gushgut the Beaksinker"] = true
L["Cascade"] = true	
L["Snufflegust"] = true
L["Astray Splasher"] = true
L["Seereel, the Spring"] = true	
L["Spellwrought Snowman"] = true
L["Seeker Teryx"] = true
L["Salkii"] = true
L["Disoriented Watcher"] = true
L["Forgotten Creation"] = true
L["Ancient Protector"] = true
L["Broodweaver Araznae"] = true
L["Phenran"] = true
L["Unstable Arcanogolem"] = true
L["Srivantor"] = true
L["Oshigol"] = true
L["Magmaton"] = true
L["Mahg the Trampler"] = true
L["Spellforged Brute"] = true
L["Skag the Thrower"] = true
L["Tenmod"] = true
L["Honmor"] = true
L["Liskheszaera"] = true
L["Trilvarus Loreweaver"] = true
L["Motivator Krathos"] = true
L["Grand Artificer Zeerak"] = true
L["Gnarls"] = true
L["Azra's Prized Peony"] = true
L["Morlash"] = true
L["Spellforged Destroyer"] = true
L["Arkhuu"] = true
L["Overseer Stonetongue"] = true
L["Overloading Defense Matrix"] = true
L["Harkyn Grymstone"] = true
L["Umbrelskul"] = true
L["Erkhart Stormvein"] = true
L["Firava the Rekindler"] = true
L["Summoned Destroyer"] = true
L["Bisquius"] = true
L["Qalashi War Mammoth"] = true
L["Battlehorn Pyrhus"] = true
L["Lookout Mordren"] = true
L["Worldcarver A'tir"] = true
L["Moskhoi"] = true
L["Smogswog the Firebreather"] = true
L["Death's Shadow"] = true
L["Gamgus"] = true
L["Galnmor"] = true
L["Infernum"] = true
L["Kain Firebrand"] = true
L["Zenet Avis"] = true
L["Prozela Galeshot"] = true
L["Ty'foon the Ascended"] = true
L["Terillod the Devout"] = true
L["Mikrin of the Raging Winds"] = true
L["Tempestrian"] = true
L["Gaelzion"] = true
L["Pipspark Thundersnap"] = true
L["Karantun"] = true
L["Voraazka"] = true
L["Wyrmslayer Angvardi"] = true
L["Ookbeard"] = true
L["Volcanakk"] = true
L["Lady Shaz'ra"] = true
L["Blue Terror"] = true
L["Pyrachniss"] = true
L["Shardwing"] = true
L["Matron Folnuna"] = true
L["Radix"] = true
L["Ixallon the Soulbreaker"] = true
            
L["Elemental Storms"] = true

-- 10.1 rare spawns
L["Alcanon"] = true
L["Colossian"] = true
L["Flowfy"] = true
L["Karokta"] = true
L["Kob'rok"] = true
L["Viridian King"] = true
L["Invoq"] = true
L["Emberdusk"] = true
L["Skornak"] = true
L["Dinn"] = true
L["General Zskorro"] = true
L["Subterrax"] = true
L["Spinmarrow"] = true
L["Kapraku"] = true
L["Magtembo"] = true
L["Goopal"] = true
L["Professor Gastrinax"] = true

-- 10.2 rares
L["Matriarch Keevah"] = true
L["Ristar the Rabid"] = true
L["Keen-eyed Cian"] = true
L["Moragh the Slothful"] = true
L["Talthonei Ashwhisper"] = true
L["Mosa Umbramane"] = true

-- bosses
L["Primal Tsunami"] = EJ_GetEncounterInfo(2511)
L["Echo of Doragosa"] = EJ_GetEncounterInfo(2514)
L["Warlord Sargha"] = EJ_GetEncounterInfo(2501)
L["Decatriarch Wratheye"] = EJ_GetEncounterInfo(2474)
L["Raszageth the Storm-Eater"] = EJ_GetEncounterInfo(2499)
L["Balakar Khan"] = EJ_GetEncounterInfo(2477)
L["Scalecommander Sarkareth"] = EJ_GetEncounterInfo(2520)
L["Chrono-Lord Deios"] = EJ_GetEncounterInfo(2538)
L["Fyrakk"] = EJ_GetEncounterInfo(2519)
L["Tindral Sageswift"] = EJ_GetEncounterInfo(2565)
L["Aurostor, the Hibernating"] = EJ_GetEncounterInfo(2562)
L["Nal'tira"] = EJ_GetEncounterInfo(1500)
L["Rezan"] = EJ_GetEncounterInfo(2083)
L["Zul"] = EJ_GetEncounterInfo(2195)

-- dungeon / raid trash
L["Pusillin"] = true
L["Hellblaze Temptress"] = true

-- containers
L["Obsidian Grand Cache"] = true
L["Forgotten Dragon Treasure"] = true
L["Waterlogged Bundle"] = true
L["Smelly Trash Pile"] = true
L["Somnut"] = true
L["Dreamseed Cache"] = select(3, C_MountJournal.GetMountInfoExtraByID(1815))
L["Pollenfused Bristlebruin Fur Sample"] = true
L["Singed Grimoire"] = true
L["Torn Page"] = true

-- Fyrakk
L["Disciples of Fyrakk"] = QuestUtils_GetQuestName(74775).."; "..QuestUtils_GetQuestName(75239)
QuestEventListener:AddCallback(74775, function()
	L["Disciples of Fyrakk"] = QuestUtils_GetQuestName(74775).."; "..QuestUtils_GetQuestName(75239)
end)
QuestEventListener:AddCallback(75239, function()
	L["Disciples of Fyrakk"] = QuestUtils_GetQuestName(74775).."; "..QuestUtils_GetQuestName(75239)
end)
L["Secured Shipment"] = true
