local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

addon.Enum = {}

addon.Enum.Drakes = {}
addon.Enum.Drakes.CliffsideWylderdrake = 1
addon.Enum.Drakes.HighlandDrake = 2
addon.Enum.Drakes.RenewedProtoDrake = 3
addon.Enum.Drakes.WindborneVelocidrake = 4
addon.Enum.Drakes.WindingSlitherdrake = 5

addon.Enum.Sources = {}
addon.Enum.Sources.Rare = 1
addon.Enum.Sources.Reputation = 2
addon.Enum.Sources.Renown = 3
addon.Enum.Sources.Achievement = 4
addon.Enum.Sources.Inscription = 5
addon.Enum.Sources.Dungeon = 6
addon.Enum.Sources.Hunt = 7
addon.Enum.Sources.Container = 8
addon.Enum.Sources.Quest = 9
addon.Enum.Sources.Vendor = 10
addon.Enum.Sources.Raid = 11
addon.Enum.Sources.Chest = 12
addon.Enum.Sources.Unknown = 13
addon.Enum.Sources.Fyrakk = 14

addon.Enum.Zones = {}
addon.Enum.Zones.ohn = 1
addon.Enum.Zones.ws = 2
addon.Enum.Zones.zara = 3

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
end

addon.Strings.Sources = {}
addon.Strings.Sources[1] = L["Rare Spawns"]
addon.Strings.Sources[2] = REPUTATION
addon.Strings.Sources[3] = COVENANT_SANCTUM_TAB_RENOWN
addon.Strings.Sources[4] = BATTLE_PET_SOURCE_6
addon.Strings.Sources[5] = INSCRIPTION
addon.Strings.Sources[6] = TRACKER_HEADER_DUNGEON
addon.Strings.Sources[7] = L["Grand Hunts"]
addon.Strings.Sources[8] = AUCTION_CATEGORY_CONTAINERS
addon.Strings.Sources[9] = BATTLE_PET_SOURCE_2
addon.Strings.Sources[10] = BATTLE_PET_SOURCE_3
addon.Strings.Sources[11] = CALENDAR_TYPE_RAID
addon.Strings.Sources[12] = ITEM_CONTAINER
addon.Strings.Sources[13] = COMBATLOG_FILTER_STRING_UNKNOWN_UNITS
addon.Strings.Sources[14] = C_QuestLog.GetTitleForQuestID(75887)

addon.Strings.Zones = {}
addon.Strings.Zones[1] = C_Map.GetAreaInfo(13645)
addon.Strings.Zones[2] = C_Map.GetAreaInfo(13644)
addon.Strings.Zones[3] = C_Map.GetAreaInfo(14022)
