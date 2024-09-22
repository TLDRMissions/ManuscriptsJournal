local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local sources = addon.Enum.Sources

addon.DirigibleDB = {
    {
        itemID = 225542,
        questID = 83308,
        name = "Delver's Dirigible Schematic: Void",
        source = sources.Other,
        otherDescription = "Zekvir T??",
    },
	{
        itemID = 224771,
        questID = 82181,
        name = "Delver's Dirigible Schematic: Empennage",
        source = sources.Vendor,
        vendorName = L["Sir Finley"],
        zoneID = 14771,
    },
	{
        itemID = 224960,
        questID = 82176,
        name =  "Delver's Dirigible Schematic: Lantern Wing",
        source = sources.Vendor,
        vendorName = L["Reno Jackson"],
        zoneID = 14771,
    },
	{
        itemID = 224769,
        questID = 82183,
        name = "Delver's Dirigible Schematic: Rotor Blades",
        source = sources.Vendor,
        vendorName = L["Sir Finley"],
        zoneID = 14771,
    },
	{
        itemID = 224979,
        questID = 82185,
        name = "Delver's Dirigible Schematic: Zeppelin",
        source = sources.Vendor,
        vendorName = L["Reno Jackson"],
        zoneID = 14771,
    },
	{
        itemID = 224768,
        questID = 82171,
        name = "Delver's Dirigible Schematic: Wing-Mounted Propeller",
        source = sources.Vendor,
        vendorName = L["Sir Finley"],
        zoneID = 14771,
    },
	{
        itemID = 224770,
        questID = 82167,
        name = "Delver's Dirigible Schematic: Front-Mounted Propeller",
        source = sources.Vendor,
        vendorName = L["Sir Finley"],
        zoneID = 14771,
    },
	{
        itemID = 224982,
        questID = 82179,
        name = "Delver's Dirigible Schematic: Exhaust",
        source = sources.Vendor,
        vendorName = L["Reno Jackson"],
        zoneID = 14771,
    },
	{
        itemID = 224981,
        questID = 82187,
        name = "Delver's Dirigible Schematic: Brown Paint",
        source = sources.Vendor,
        vendorName = L["Reno Jackson"],
        zoneID = 14771,
    },
	{
        itemID = 224980,
        questID = 82170,
        name = "Delver's Dirigible Schematic: Front-Mounted Lantern",
        source = sources.Vendor,
        vendorName = L["Reno Jackson"],
        zoneID = 14771,
    },
}
