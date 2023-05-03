local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName) 

local sources = addon.Enum.Sources
local zones = addon.Enum.Zones

local manuscripts = {
    {
        name = "Winding Slitherdrake: Embodiment of the Obsidian Gladiator",
        itemID = 205865,
        questID = 75941,
    },
	{
		name = "Winding Slitherdrake: Antler Horns",
		itemID = 203338,
		questID = 73829,
	},
	--{
	--	name = "Winding Slitherdrake: Armor",
	--	itemID = 203305,
	--	questID = 73793,
	--},
	{
		name = "Winding Slitherdrake: Blonde Hair",
		itemID = 203322,
		questID = 73810,
	},
	{
		name = "Winding Slitherdrake: Blue and Silver Armor",
		itemID = 203300,
		questID = 73788,
        source = sources.Inscription,
	},
	{
		name = "Winding Slitherdrake: Blue Scales",
		itemID = 203350,
		questID = 73841,
	},
	{
		name = "Winding Slitherdrake: Bronze Scales",
		itemID = 203351,
		questID = 73842,
	},
	{
		name = "Winding Slitherdrake: Brown Hair",
		itemID = 203323,
		questID = 73811,
        source = sources.Renown,
        renownFaction = 2564,
        renownRank = 13,
	},
	{
		name = "Winding Slitherdrake: Cluster Chin Horn",
		itemID = 203312,
		questID = 73800,
        source = sources.Vendor,
        vendorName = L["Ponzo"],
        zoneID = 14022,
	},
	{
		name = "Winding Slitherdrake: Cluster Horns",
		itemID = 203331,
		questID = 73820,
	},
	{
		name = "Winding Slitherdrake: Cluster Jaw Horns",
		itemID = 203340,
		questID = 73831,
	},
	{
		name = "Winding Slitherdrake: Curled Cheek Horn",
		itemID = 203321,
		questID = 73809,
	},
	{
		name = "Winding Slitherdrake: Curled Horns",
		itemID = 203334,
		questID = 73824,
	},
	{
		name = "Winding Slitherdrake: Curled Nose",
		itemID = 203346,
		questID = 73837,
        source = sources.Vendor,
        vendorName = L["Ponzo"],
        zoneID = 14022,
	},
	{
		name = "Winding Slitherdrake: Curved Chin Horn",
		itemID = 203314,
		questID = 73802,
        source = sources.Inscription,
	},
	{
		name = "Winding Slitherdrake: Curved Horns",
		itemID = 203335,
		questID = 73825,
        source = sources.Renown,
        renownFaction = 2564,
        renownRank = 13,
	},
	{
		name = "Winding Slitherdrake: Curved Nose Horn",
		itemID = 203349,
		questID = 73840,
	},
	{
		name = "Winding Slitherdrake: Ears",
		itemID = 203320,
		questID = 73808,
	},
	{
		name = "Winding Slitherdrake: Finned Cheek",
		itemID = 203319,
		questID = 73807,
	},
	{
		name = "Winding Slitherdrake: Finned Tip Tail",
		itemID = 203361,
		questID = 73853,
	},
	{
		name = "Winding Slitherdrake: Grand Chin Thorn",
		itemID = 203310,
		questID = 73798,
        source = sources.Renown,
        renownFaction = 2564,
        renownRank = 5,
	},
	{
		name = "Winding Slitherdrake: Green and Bronze Armor",
		itemID = 203299,
		questID = 73787,
	},
	{
		name = "Winding Slitherdrake: Green Scales",
		itemID = 203352,
		questID = 73843,
	},
	{
		name = "Winding Slitherdrake: Hairy Brow",
		itemID = 203308,
		questID = 73796,
        source = sources.Vendor,
        vendorName = L["Ponzo"],
        zoneID = 14022,
	},
	{
		name = "Winding Slitherdrake: Hairy Chin",
		itemID = 203311,
		questID = 73799,
	},
	{
		name = "Winding Slitherdrake: Hairy Crest",
		itemID = 203318,
		questID = 73806,
	},
	{
		name = "Winding Slitherdrake: Hairy Jaw",
		itemID = 203343,
		questID = 73834,
	},
	{
		name = "Winding Slitherdrake: Hairy Tail",
		itemID = 203362,
		questID = 73854,
        source = sources.Renown,
        renownFaction = 2564,
        renownRank = 16,
	},
	{
		name = "Winding Slitherdrake: Hairy Throat",
		itemID = 203365,
		questID = 73854,
        source = sources.Renown,
        renownFaction = 2564,
        renownRank = 16,
	},
	{
		name = "Winding Slitherdrake: Heavy Horns",
		itemID = 203329,
		questID = 73817,
	},
	{
		name = "Winding Slitherdrake: Heavy Scales",
		itemID = 205341,
		questID = 75743,
	},
	{
		name = "Winding Slitherdrake: Helm",
		itemID = 203326,
		questID = 73814,
	},
	{
		name = "Winding Slitherdrake: Horned Brow",
		itemID = 203306,
		questID = 73794,
	},
	{
		name = "Winding Slitherdrake: Impaler Horns",
		itemID = 203339,
		questID = 73830,
	},
	{
		name = "Winding Slitherdrake: Large Finned Crest",
		itemID = 203316,
		questID = 73804,
        source = sources.Renown,
        renownFaction = 2564,
        renownRank = 5,
	},
	{
		name = "Winding Slitherdrake: Large Finned Tail",
		itemID = 203360,
		questID = 73852,
	},
	{
		name = "Winding Slitherdrake: Large Finned Throat",
		itemID = 203363,
		questID = 73855,
	},
	{
		name = "Winding Slitherdrake: Large Spiked Nose",
		itemID = 203347,
		questID = 73838,
        source = sources.Renown,
        renownFaction = 2564,
        renownRank = 16,
	},
	{
		name = "Winding Slitherdrake: Light Blue and Copper Armor",
		itemID = 203301,
		questID = 73789,
	},
	{
		name = "Winding Slitherdrake: Long Chin Horn",
		itemID = 203309,
		questID = 73797,
        source = sources.Rare,
        rareZone = zones.zara,
	},
	{
		name = "Winding Slitherdrake: Long Jaw Horns",
		itemID = 203341,
		questID = 73832,
        source = sources.Renown,
        renownFaction = 2564,
        renownRank = 13,
	},
	{
		name = "Winding Slitherdrake: Paired Horns",
		itemID = 203336,
		questID = 73826,
	},
	{
		name = "Winding Slitherdrake: Plated Brow",
		itemID = 203307,
		questID = 73795,
        source = sources.Rare,
        rareName = L["Alcanon"],
	},
	{
		name = "Winding Slitherdrake: Pointed Nose",
		itemID = 203348,
		questID = 73839,
	},
	{
		name = "Winding Slitherdrake: Purple and Silver Armor",
		itemID = 203302,
		questID = 73790,
	},
	{
		name = "Winding Slitherdrake: Red and Gold Armor",
		itemID = 203303,
		questID = 73791,
	},
	{
		name = "Winding Slitherdrake: Red Hair",
		itemID = 203325,
		questID = 73813,
	},
	{
		name = "Winding Slitherdrake: Red Scales",
		itemID = 203353,
		questID = 73844,
	},
	{
		name = "Winding Slitherdrake: Tan Horns",
		itemID = 203327,
		questID = 73815,
        source = sources.Renown,
        renownFaction = 2564,
        renownRank = 5,
	},
	{
		name = "Winding Slitherdrake: Thorn Horns",
		itemID = 203337,
		questID = 73827,
	},
	{
		name = "Winding Slitherdrake: Triple Jaw Horns",
		itemID = 203342,
		questID = 73833,
	},
	{
		name = "Winding Slitherdrake: Shark Finned Tail",
		itemID = 203359,
		questID = 73851,
	},
	{
		name = "Winding Slitherdrake: Short Horns",
		itemID = 203333,
		questID = 73822,
	},
	{
		name = "Winding Slitherdrake: Single Jaw Horn",
		itemID = 203344,
		questID = 73835,
	},
	{
		name = "Winding Slitherdrake: Small Finned Crest",
		itemID = 203317,
		questID = 73805,
	},
	{
		name = "Winding Slitherdrake: Small Finned Tail",
		itemID = 203358,
		questID = 73850,
        source = sources.Rare,
        rareName = L["Karokta"],
	},
	{
		name = "Winding Slitherdrake: Small Finned Throat",
		itemID = 203364,
		questID = 73856,
        source = sources.Inscription,
	},
	{
		name = "Winding Slitherdrake: Small Spiked Crest",
		itemID = 203315,
		questID = 73803,
	},
	{
		name = "Winding Slitherdrake: Spiked Chin",
		itemID = 203313,
		questID = 73801,
	},
	{
		name = "Winding Slitherdrake: Spiked Horns",
		itemID = 203332,
		questID = 73821,
	},
	{
		name = "Winding Slitherdrake: Spiked Tail",
		itemID = 203357,
		questID = 73849,
	},
	{
		name = "Winding Slitherdrake: Split Jaw Horns",
		itemID = 203345,
		questID = 73836,
        source = sources.Rare,
        rareName = L["Viridian King"],
	},
	{
		name = "Winding Slitherdrake: Swept Horns",
		itemID = 203330,
		questID = 73818,
	},
	{
		name = "Winding Slitherdrake: White and Gold Armor",
		itemID = 203298,
		questID = 73786,
	},
	{
		name = "Winding Slitherdrake: White Hair",
		itemID = 203324,
		questID = 73812,
        source = sources.Inscription,
	},
	{
		name = "Winding Slitherdrake: White Horns",
		itemID = 203328,
		questID = 73816,
	},
	{
		name = "Winding Slitherdrake: White Scales",
		itemID = 203354,
		questID = 73845,
	},
	{
		name = "Winding Slitherdrake: Yellow and Silver Armor",
		itemID = 203304,
		questID = 73792,
        source = sources.Inscription,
	},
	{
		name = "Winding Slitherdrake: Yellow Scales",
		itemID = 203355,
		questID = 73846,
	},
}

for k, v in pairs(manuscripts) do
    v.category = addon.Enum.Drakes.WindingSlitherdrake
    table.insert(addon.db, v)
end