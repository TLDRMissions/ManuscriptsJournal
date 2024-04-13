local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName) 

local sources = addon.Enum.Sources
local zones = addon.Enum.Zones

local manuscripts = {
	{
		name = "Grotto Netherwing Drake: Barbed Tail",
		itemID = 207779,
        questID = 77150,
        source = sources.ZoneDrop,
        zoneID = 14529,
	},
	{
		name = "Grotto Netherwing Drake: Chin Spike",
		itemID = 207762,
        questID = 77133,
        source = sources.Superbloom,
	},
	{
		name = "Grotto Netherwing Drake: Chin Tendrils",
		itemID = 207761,
        questID = 77132,
        source = sources.Inscription,
	},
	{
		name = "Grotto Netherwing Drake: Cluster Spiked Back",
		itemID = 207759,
        questID = 77130,
        source = sources.Chest,
        chestName = L["Dreamseed Cache"],
	},
	{
		name = "Grotto Netherwing Drake: Cluster Spiked Crest",
		itemID = 207765,
        questID = 77136,
        source = sources.DragonRacingContainer,
        containerID = 210549,
	},
	{
		name = "Grotto Netherwing Drake: Head Spike",
		itemID = 207764,
        questID = 77135,
        source = sources.Chest,
        chestName = L["Dreamseed Cache"],
	},
	{
		name = "Grotto Netherwing Drake: Long Horns",
		itemID = 207772,
        questID = 77143,
        source = sources.Chest,
        chestName = L["Dreamseed Cache"],
	},
	{
		name = "Grotto Netherwing Drake: Outcast Pattern",
		itemID = 207769,
        questID = 77140,
        source = sources.Chest,
        chestName = L["Dreamseed Cache"],
	},
	{
		name = "Grotto Netherwing Drake: Short Horns",
		itemID = 207771,
        questID = 77142,
        source = sources.ZoneDrop,
        zoneID = 14529,
	},
	{
		name = "Grotto Netherwing Drake: Single Horned Crest",
		itemID = 207763,
        questID = 77134,
        source = sources.Superbloom,
	},
	{
		name = "Grotto Netherwing Drake: Spiked Jaw",
		itemID = 207773,
        questID = 77144,
        source = sources.Inscription,
	},
	{
		name = "Grotto Netherwing Drake: Triple Spiked Crest",
		itemID = 207766,
        questID = 77137,
        source = sources.ZoneDrop,
        zoneID = 14529,
	},
	{
		name = "Grotto Netherwing Drake: Armor",
		itemID = 207760,
        questID = 77131,
	},
	{
		name = "Grotto Netherwing Drake: Black Scales",
		itemID = 207776,
        questID = 77147,
        source = sources.DragonRacingAchievement,
        achievementID = 19478,
	},
	{
		name = "Grotto Netherwing Drake: Double Finned Tail",
		itemID = 207778,
        questID = 77149,
        source = sources.DragonRacingContainer,
        containerID = 210549,
	},
	{
		name = "Grotto Netherwing Drake: Finned Jaw",
		itemID = 207774,
        questID = 77145,
        source = sources.Superbloom,
	},
	{
		name = "Grotto Netherwing Drake: Helm",
		itemID = 207770,
        questID = 77141,
	},
	{
		name = "Grotto Netherwing Drake: Purple and Silver Armor",
		itemID = 207757,
        questID = 77128,
	},
	{
		name = "Grotto Netherwing Drake: Spiked Back",
		itemID = 207758,
        questID = 77129,
        source = sources.DragonRacingContainer,
        containerID = 210549,
	},
	{
		name = "Grotto Netherwing Drake: Teal Scales",
		itemID = 207775,
        questID = 77146,
	},
	{
		name = "Grotto Netherwing Drake: Tempestuous Pattern",
		itemID = 207767,
        questID = 77138,
        source = sources.Superbloom,
	},
	{
		name = "Grotto Netherwing Drake: Violet Scales",
		itemID = 211381,
        questID = 78878,
	},
	{
		name = "Grotto Netherwing Drake: Volatile Pattern",
		itemID = 207768,
        questID = 77139,
        source = sources.DragonRacingContainer,
        containerID = 210549,
	},
	{
		name = "Grotto Netherwing Drake: Yellow Scales",
		itemID = 207777,
        questID = 77148,
	},
}

for k, v in pairs(manuscripts) do
    v.category = addon.Enum.Drakes.GrottoNetherwingDrake
    table.insert(addon.db, v)
end
