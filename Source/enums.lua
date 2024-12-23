local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

addon.Enum = {}

addon.Enum.Drakes = {}
addon.Enum.Drakes.CliffsideWylderdrake = 1
addon.Enum.Drakes.HighlandDrake = 2
addon.Enum.Drakes.RenewedProtoDrake = 3
addon.Enum.Drakes.WindborneVelocidrake = 4
addon.Enum.Drakes.WindingSlitherdrake = 5
addon.Enum.Drakes.GrottoNetherwingDrake = 6
addon.Enum.Drakes.FlourishingWhimsydrake = 7
addon.Enum.Drakes.All = 8

addon.Enum.Shapeshifts = {}
addon.Enum.Shapeshifts.Bear = 1
addon.Enum.Shapeshifts.Cat = 2
addon.Enum.Shapeshifts.Moonkin = 3
addon.Enum.Shapeshifts.Tree = 4
addon.Enum.Shapeshifts.Travel = 5
addon.Enum.Shapeshifts.Aquatic = 6
addon.Enum.Shapeshifts.Flight = 7
addon.Enum.Shapeshifts.Other = 8
addon.Enum.Shapeshifts.All = 9

addon.Enum.Sources = {}
addon.Enum.Sources.Rare = 1
addon.Enum.Sources.Reputation = 2
addon.Enum.Sources.Renown = 3
addon.Enum.Sources.Inscription = 4
addon.Enum.Sources.Dungeon = 5
addon.Enum.Sources.Hunt = 6
addon.Enum.Sources.Container = 7
addon.Enum.Sources.Quest = 8
addon.Enum.Sources.Vendor = 9
addon.Enum.Sources.Raid = 10
addon.Enum.Sources.Chest = 11
addon.Enum.Sources.Unknown = 12
addon.Enum.Sources.Fyrakk = 13
addon.Enum.Sources.DragonRacingContainer = 14
addon.Enum.Sources.DragonRacingAchievement = 15
addon.Enum.Sources.PvPSeason = 16
addon.Enum.Sources.WorldEvent = 17
addon.Enum.Sources.Superbloom = 18
addon.Enum.Sources.ZoneDrop = 19
addon.Enum.Sources.Other = 20

addon.Enum.Zones = {}
addon.Enum.Zones.ohn = 1
addon.Enum.Zones.ws = 2
addon.Enum.Zones.zara = 3

addon.Enum.Fyrakk = {}
addon.Enum.Fyrakk.Boss = 1
addon.Enum.Fyrakk.Chest = 2

addon.Enum.SJ = {}
addon.Enum.SJ.BUILD_9_0 = 37474
addon.Enum.SJ.BUILD_9_0_5 = 37862
addon.Enum.SJ.BUILD_9_1 = 39185
addon.Enum.SJ.BUILD_9_1_5 = 40871
addon.Enum.SJ.BUILD_9_2 = 42069

addon.Enum.WarlockCategories = {}
addon.Enum.WarlockCategories.Imp = 1
addon.Enum.WarlockCategories.Voidwalker = 2
addon.Enum.WarlockCategories.Sayaad = 3
addon.Enum.WarlockCategories.Felhunter = 4
addon.Enum.WarlockCategories.Felguard = 5
addon.Enum.WarlockCategories.Infernal = 6
addon.Enum.WarlockCategories.Darkglare = 7
addon.Enum.WarlockCategories.Tyrant = 8
addon.Enum.WarlockCategories.Doomguard = 9

addon.Strings = {}
addon.Strings.Drakes = {}
do
    local item1 = Item:CreateFromItemID(194521)
    item1:ContinueOnItemLoad(function()
        addon.Strings.Drakes[1] = item1:GetItemName() 
    end)
    local item2 = Item:CreateFromItemID(194705)
    item2:ContinueOnItemLoad(function()
        addon.Strings.Drakes[2] = item2:GetItemName() 
    end)
    local item3 = Item:CreateFromItemID(194034)
    item3:ContinueOnItemLoad(function()
        addon.Strings.Drakes[3] = item3:GetItemName() 
    end)
    local item4 = Item:CreateFromItemID(194549)
    item4:ContinueOnItemLoad(function()
        addon.Strings.Drakes[4] = item4:GetItemName() 
    end)
    local item5 = Item:CreateFromItemID(204361)
    item5:ContinueOnItemLoad(function()
        addon.Strings.Drakes[5] = item5:GetItemName()
    end)
    local item6 = Item:CreateFromItemID(206156)
    item6:ContinueOnItemLoad(function()
        addon.Strings.Drakes[6] = item6:GetItemName()
    end)
    local item7 = Item:CreateFromItemID(210412)
    item7:ContinueOnItemLoad(function()
        addon.Strings.Drakes[7] = item7:GetItemName()
    end)
end
addon.Strings.Drakes[8] = ACHIEVEMENTFRAME_FILTER_ALL

addon.Strings.Shapeshifts = {}
addon.Strings.Shapeshifts[1] = C_Spell.GetSpellName(5487)
addon.Strings.Shapeshifts[2] = C_Spell.GetSpellName(768)
addon.Strings.Shapeshifts[3] = C_Spell.GetSpellName(197625)
addon.Strings.Shapeshifts[4] = C_Spell.GetSpellName(33891)
addon.Strings.Shapeshifts[5] = C_Spell.GetSpellName(783)
addon.Strings.Shapeshifts[6] = C_Spell.GetSpellName(276012)
addon.Strings.Shapeshifts[7] = C_Spell.GetSpellName(165962)
addon.Strings.Shapeshifts[8] = OTHER
addon.Strings.Shapeshifts[9] = ACHIEVEMENTFRAME_FILTER_ALL

addon.Strings.Sources = {}
addon.Strings.Sources[1] = L["Rare Spawns"]
addon.Strings.Sources[2] = REPUTATION
addon.Strings.Sources[3] = COVENANT_SANCTUM_TAB_RENOWN
--addon.Strings.Sources[4] = BATTLE_PET_SOURCE_6
addon.Strings.Sources[4] = INSCRIPTION
addon.Strings.Sources[5] = TRACKER_HEADER_DUNGEON
addon.Strings.Sources[6] = L["Grand Hunts"]
addon.Strings.Sources[7] = AUCTION_CATEGORY_CONTAINERS
addon.Strings.Sources[8] = BATTLE_PET_SOURCE_2
addon.Strings.Sources[9] = BATTLE_PET_SOURCE_3
addon.Strings.Sources[10] = CALENDAR_TYPE_RAID
addon.Strings.Sources[11] = L["Treasure Chest"]
addon.Strings.Sources[12] = COMBATLOG_FILTER_STRING_UNKNOWN_UNITS
addon.Strings.Sources[13] = C_QuestLog.GetTitleForQuestID(75887)
addon.Strings.Sources[14] = L["Dragon Racing Container"]
addon.Strings.Sources[15] = L["Dragon Racing Achievement"]
addon.Strings.Sources[16] = L["PvP Seasonal"]
addon.Strings.Sources[17] = BATTLE_PET_SOURCE_7
addon.Strings.Sources[18] = C_QuestLog.GetTitleForQuestID(78203)
addon.Strings.Sources[19] = BUG_CATEGORY2
addon.Strings.Sources[20] = AUCTION_SUBCATEGORY_OTHER

addon.Strings.Zones = {}
addon.Strings.Zones[1] = C_Map.GetAreaInfo(13645) -- Ohn'aran
addon.Strings.Zones[2] = C_Map.GetAreaInfo(13644) -- Waking Shores
addon.Strings.Zones[3] = C_Map.GetAreaInfo(14022) -- Zaralek
addon.Strings.Zones[4] = C_Map.GetAreaInfo(13646) -- The Azure Span
addon.Strings.Zones[5] = C_Map.GetAreaInfo(13647) -- Thaldraszus
addon.Strings.Zones[6] = C_Map.GetAreaInfo(13862) -- Valdrakken
addon.Strings.Zones[7] = C_Map.GetAreaInfo(14433) -- The Forbidden Reach
addon.Strings.Zones[8] = C_Map.GetAreaInfo(13642) -- Dragon Isles

addon.Strings.Fyrakk = {}
addon.Strings.Fyrakk[1] = L["Disciples of Fyrakk"]
addon.Strings.Fyrakk[2] = L["Secured Shipment"]

addon.Strings.WarlockCategories = {}
addon.Strings.WarlockCategories[1] = C_Spell.GetSpellInfo(688).name
addon.Strings.WarlockCategories[2] = C_Spell.GetSpellInfo(697).name
addon.Strings.WarlockCategories[3] = C_Spell.GetSpellInfo(366222).name
addon.Strings.WarlockCategories[4] = C_Spell.GetSpellInfo(691).name
addon.Strings.WarlockCategories[5] = C_Spell.GetSpellInfo(30146).name
addon.Strings.WarlockCategories[6] = C_Spell.GetSpellInfo(1122).name
addon.Strings.WarlockCategories[7] = C_Spell.GetSpellInfo(205180).name
addon.Strings.WarlockCategories[8] = C_Spell.GetSpellInfo(265187).name
addon.Strings.WarlockCategories[9] = C_Spell.GetSpellInfo(18540).name

addon.Enum.WarlockCategories.Imp = 1
addon.Enum.WarlockCategories.Voidwalker = 2
addon.Enum.WarlockCategories.Sayaad = 3
addon.Enum.WarlockCategories.Felhunter = 4
addon.Enum.WarlockCategories.Felguard = 5
addon.Enum.WarlockCategories.Infernal = 6
addon.Enum.WarlockCategories.Darkglare = 7
addon.Enum.WarlockCategories.Tyrant = 8
addon.Enum.WarlockCategories.Doomguard = 9
