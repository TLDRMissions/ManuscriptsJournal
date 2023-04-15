local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

addon.Enum = {}

addon.Enum.Drakes = {}
addon.Enum.Drakes.CliffsideWylderdrake = 1
addon.Enum.Drakes.HighlandDrake = 2

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

addon.Enum.Zones = {}
addon.Enum.Zones.ohn = 1
addon.Enum.Zones.ws = 2

addon.Strings = {}
addon.Strings.Drakes = {}
addon.Strings.Drakes[1] = L["Cliffside Wylderdrake"]
addon.Strings.Drakes[2] = L["Highland Drake"]

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

addon.Strings.Zones = {}
addon.Strings.Zones[1] = C_Map.GetAreaInfo(13645)
addon.Strings.Zones[2] = C_Map.GetAreaInfo(13644)
