local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName) 

local sources = addon.Enum.Sources
local zones = addon.Enum.Zones
local drakes = addon.Enum.Drakes

local manuscripts = {    
	{
		category = drakes.HighlandDrake,
		name = "Highland Drake: Winter Veil Armor",
		itemID = 210432,
        questID = 78371,
        source = sources.WorldEvent,
	},
	{
		category = drakes.RenewedProtoDrake,
		name = "Renewed Proto-Drake: Embodiment of Shadowflame",
		itemID = 210537,
        questID = 78453,
        source = sources.Raid,
        bossName = L["Fyrakk"],
        unobtainable = true,
	},
    {
		category = drakes.RenewedProtoDrake,
		name = "Renewed Proto-Drake: Embodiment of the Blazing",
		itemID = 210536,
        questID = 78451,
        source = sources.Raid,
        bossName = L["Fyrakk"],
	},
	{
		category = drakes.WindingSlitherdrake,
		name = "Winding Slitherdrake: Cluster Jaw Horns ",
		itemID = 203340,
        questID = 73831,
        source = sources.Superbloom,
	},
    {
		category = drakes.WindingSlitherdrake,
		name = "Winding Slitherdrake: Embodiment of the Verdant Gladiator",
		itemID = 210064,
        questID = 78216,
        source = sources.PvPSeason,
        achievementID = 19091, -- Season 3
        unobtainable = true,
	},
    {
		category = drakes.WindingSlitherdrake,
		name = "Highland Drake: Embodiment of the Draconic Gladiator",
		itemID = 216710,
        questID = 80014,
        source = sources.PvPSeason,
        achievementID = 19490, -- Season 4
        unobtainable = true,
	},
	{
		category = drakes.WindingSlitherdrake,
		name = "Winding Slitherdrake: Hairy Chin",
		itemID = 203311,
        questID = 73799,
        source = sources.Inscription,
	},
	{
		category = drakes.WindingSlitherdrake,
		name = "Winding Slitherdrake: Small Spiked Crest",
		itemID = 203315,
        questID = 73803,
        source = sources.Chest,
        chestName = L["Somnut"],
        zoneID = 14529,
	},
	{
		category = drakes.WindingSlitherdrake,
		name = "Winding Slitherdrake: Spiked Horns",
		itemID = 203332,
        questID = 73821,
        source = sources.Chest,
        chestName = L["Somnut"],
        zoneID = 14529,
	},
	{
		category = drakes.WindingSlitherdrake,
		name = "Winding Slitherdrake: Spiked Tail",
		itemID = 203357,
        questID = 73849,
        source = sources.Chest,
        chestName = L["Somnut"],
        zoneID = 14529,
	},
	{
		category = drakes.WindingSlitherdrake,
		name = "Winding Slitherdrake: Thorn Horns",
		itemID = 203337,
        questID = 73827,
        source = sources.DragonRacingContainer,
        containerID = 210549,
	},
    {
        name = "Renewed Proto-Drake: Green Hair",
        category = drakes.RenewedProtoDrake,
        itemID = 197371,
        questID = 69572,
        source = sources.Superbloom,
    },
    {
        name = "Winding Slitherdrake: Heavy Horns",
        category = drakes.WindingSlitherdrake,
        itemID = 203329,
        questID = 73817,
        source = sources.Superbloom,
    },
    {
        name = "Winding Slitherdrake: Single Jaw Horn",
        category = drakes.WindingSlitherdrake,
        itemID = 203344,
        questID = 73835,
        source = sources.Superbloom,
    },
    {
        name = "Winding Slitherdrake: Short Horns",
        category = drakes.WindingSlitherdrake,
        itemID = 203333,
        questID = 73822,
        source = sources.DragonRacingContainer,
        containerID = 210549,
    },
    {
        name = "Renewed Proto-Drake: Love Armor",
        category = drakes.RenewedProtoDrake,
        itemID = 211812,
        questID = 79088,
        source = sources.WorldEvent,
    },
    {
        name = "Winding Slitherdrake: Lunar Festival Armor",
        category = drakes.WindingSlitherdrake,
        itemID = 211868,
        questID = 79112,
        source = sources.WorldEvent,
    },
    {
        category = drakes.WindingSlitherdrake,
        name = "Winding Slitherdrake: Void Scales",
        itemID = 213561,
        questID = 79690,
        source = sources.Quest,
        sourceQuestID = 79021,
    },
    {
        category = drakes.CliffsideWylderdrake,
        name = "Cliffside Wylderdrake: Midsummer Fire Festival Armor",
        itemID = 224163,
        questID = 82741,
        source = sources.WorldEvent,
    },
}

for k, v in pairs(manuscripts) do
    table.insert(addon.db, v)
end
