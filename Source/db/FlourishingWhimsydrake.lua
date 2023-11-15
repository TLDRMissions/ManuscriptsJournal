local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName) 

local sources = addon.Enum.Sources
local zones = addon.Enum.Zones

local manuscripts = {
	{
		name = "Flourishing Whimsydrake: Back Fins ",
		itemID = 210482,
        questID = 78400,
        source = sources.Renown,
        renownFaction = 2574,
        renownRank = 6,
	},
	{
		name = "Flourishing Whimsydrake: Horns ",
		itemID = 210486,
        questID = 78406,
        source = sources.Renown,
        renownFaction = 2574,
        renownRank = 13,
	},
	{
		name = "Flourishing Whimsydrake: Long Snout ",
		itemID = 210485,
        questID = 78405,
        source = sources.Renown,
        renownFaction = 2574,
        renownRank = 13,
	},
	{
		name = "Flourishing Whimsydrake: Neck Fins ",
		itemID = 210487,
        questID = 78407,
        source = sources.Renown,
        renownFaction = 2574,
        renownRank = 13,
	},
	{
		name = "Flourishing Whimsydrake: Night Scales ",
		itemID = 210479,
        questID = 78408,
        source = sources.Renown,
        renownFaction = 2574,
        renownRank = 19,
	},
	{
		name = "Flourishing Whimsydrake: Ridged Brow ",
		itemID = 210483,
        questID = 78403,
        source = sources.Renown,
        renownFaction = 2574,
        renownRank = 6,
	},
	{
		name = "Flourishing Whimsydrake: Sunset Scales ",
		itemID = 210481,
        questID = 78410,
        source = sources.Renown,
        renownFaction = 2574,
        renownRank = 19,
	},
	{
		name = "Flourishing Whimsydrake: Underbite Snout ",
		itemID = 210484,
        questID = 78404,
        source = sources.Renown,
        renownFaction = 2574,
        renownRank = 6,
	},
	{
		name = "Flourishing Whimsydrake: Body Armor",
		itemID = 210471,
        questID = 78401,
	},
	{
		name = "Flourishing Whimsydrake: Gold and Pink Armor",
		itemID = 210478,
        questID = 78399,
	},
	{
		name = "Flourishing Whimsydrake: Helmet",
		itemID = 210476,
        questID = 78402,
	},
	{
		name = "Flourishing Whimsydrake: Sunrise Scales",
		itemID = 210480,
        questID = 78409,
        source = sources.Raid,
        bossName = L["Aurostor, the Hibernating"],
	},
}

for k, v in pairs(manuscripts) do
    v.category = addon.Enum.Drakes.FlourishingWhimsydrake
    table.insert(addon.db, v)
end
