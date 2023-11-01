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
        source = sources.Container,
        containerID = 211413,
	},
    {
		category = drakes.WindingSlitherdrake,
		name = "Winding Slitherdrake: Embodiment of the Verdant Gladiator",
		itemID = 210064,
        questID = 78216,
        source = sources.PvPSeason,
        achievementID = 17740, -- Season 3
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
	},
}

for k, v in pairs(manuscripts) do
    table.insert(addon.db, v)
end
