local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local sources = addon.Enum.Sources

addon.PepeDB = {
	{
		itemID = 213181,
		questID = 79547,
		name = "A Tiny Dragon Goblet",
        source = sources.ZoneDrop,
        zoneID = 2112,
	},
	{
		itemID = 213207,
		questID = 79551,
		name = "A Tiny Ear Warmer",
        source = sources.ZoneDrop,
        zoneID = 2024,
	},
    {
		itemID = 213202,
		questID = 79550,
		name = "A Tiny Explorer's Hat",
        source = sources.ZoneDrop,
        zoneID = 2022,
	},
	{
		itemID = 186593,
		questID = 64136,
		name = "A Tiny Pair of Wings",
        source = sources.Covenant,
        covenantID = 1,
        renownRank = 56,
	},
	{
		itemID = 186524,
		questID = 64098,
		name = "A Tiny Vial of Slime",
        source = sources.Covenant,
        covenantID = 4,
        renownRank = 56,
	},
	{
		itemID = 186473,
		questID = 64078,
		name = "A Tiny Winter Staff",
        source = sources.Covenant,
        covenantID = 3,
        renownRank = 56,
	},
   	{
		itemID = 186580,
		questID = 64132,
		name = "A Tiny Sinstone",
        source = sources.Covenant,
        covenantID = 2,
        renownRank = 56,
	},
    --[[
   	{
		itemID = ,
		questID = ,
		name = "",
        source = sources.ZoneDrop,
        zoneID = ,
	},
   	{
		itemID = ,
		questID = ,
		name = "",
        source = sources.ZoneDrop,
        zoneID = ,
	},
   	{
		itemID = ,
		questID = ,
		name = "",
        source = sources.ZoneDrop,
        zoneID = ,
	},
   	{
		itemID = ,
		questID = ,
		name = "",
        source = sources.ZoneDrop,
        zoneID = ,
	},
   	{
		itemID = ,
		questID = ,
		name = "",
        source = sources.ZoneDrop,
        zoneID = ,
	},
   	{
		itemID = ,
		questID = ,
		name = "",
        source = sources.ZoneDrop,
        zoneID = ,
	},
   	{
		itemID = ,
		questID = ,
		name = "",
        source = sources.ZoneDrop,
        zoneID = ,
	},
   	{
		itemID = ,
		questID = ,
		name = "",
        source = sources.ZoneDrop,
        zoneID = ,
	},
   	{
		itemID = ,
		questID = ,
		name = "",
        source = sources.ZoneDrop,
        zoneID = ,
	},
--]]
}