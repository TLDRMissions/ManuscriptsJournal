local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local sources = addon.Enum.Sources

addon.PepeDB = {
	{
		itemID = 213181,
		questID = 79547,
		name = "A Tiny Dragon Goblet",
        source = sources.Other,
        otherDescription = "Left of the main stairs in Valdrakken",
	},
}