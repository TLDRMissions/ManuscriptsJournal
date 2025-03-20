local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local sources = addon.Enum.Sources
local zones = addon.Enum.Zones
local drakes = addon.Enum.Drakes

local manuscripts = {
    {
        itemID = 235696,
        questID = 82193,
        name = "Delver's Dirigible Schematic: Explorer Decal",
    },
	{
        itemID = 235687,
        questID = 82180,
        name = "Delver's Dirigible Schematic: Spoiler",
        source = sources.Vendor,
        vendorName = L["Sir Finley"],
        zoneID = 14771,
    },
    {
        itemID = 235686,
        questID = 82190,
        name = "Delver's Dirigible Schematic: White Paint",
        source = sources.Vendor,
        vendorName = L["Sir Finley"],
        zoneID = 14771,
    },
    {
        itemID = 235685,
        questID = 82168,
        name = "Delver's Dirigible Schematic: Drill",
        source = sources.Vendor,
        vendorName = L["Sir Finley"],
        zoneID = 14771,
    },
    {
        itemID = 235684,
        questID = 82182,
        name = "Delver's Dirigible Schematic: Glider",
        source = sources.Vendor,
        vendorName = L["Sir Finley"],
        zoneID = 14771,
    },
    {
        itemID = 235683,
        questID = 82173,
        name = "Delver's Dirigible Schematic: Turbine",
        source = sources.Vendor,
        vendorName = L["Sir Finley"],
        zoneID = 14771,
    },
    {
        itemID = 235695,
        questID = 82189,
        name = "Delver's Dirigible Schematic: Red Paint",
    },
    --[[{
        itemID = 238837,
        questID = 86198,
        name = "Delver's Dirigible Schematic: Pale Paint",
    },
    {
        itemID = 238839,
        questID = 86199,
        name = "Delver's Dirigible Schematic: Arathi Decal",
    },]]
    {
        itemID = 235688,
        questID = 82174,
        name = "Delver's Dirigible Schematic: Fan",
    },
    {
        itemID = 235698,
        questID = 82194,
        name = "Delver's Dirigible Schematic: Horde Decal",
    },
    {
        itemID = 235697,
        questID = 82192,
        name = "Delver's Dirigible Schematic: Alliance Decal",
    },
    {
        itemID = 235689,
        questID = 82186,
        name = "Delver's Dirigible Schematic: Kite",
    },
    {
        itemID = 235692,
        questID = 82177,
        name = "Delver's Dirigible Schematic: Thrusters",
    },
    {
        itemID = 235690,
        questID = 82169,
        name = "Delver's Dirigible Schematic: Harpoon",
    },
    {
        itemID = 235691,
        questID = 82191,
        name = "Delver's Dirigible Schematic: Yellow Paint",
    },
    {
        itemID = 235694,
        questID = 82117,
        name = "Delver's Dirigible Schematic: Blue Paint",
    },
    {
        itemID = 235693,
        questID = 82175,
        name = "Delver's Dirigible Schematic: Rocket",
    },
    
    -- Gob-trotter schematics
	{
        itemID = 233196,
        questID = 86296,
        name =  "Delver's Gob-Trotter Schematic: Gold",
        source = sources.Achievement,
        achievementID = 41210,
    },
	{
        itemID = 230217,
        questID = 85177,
        name =  "Delver's Gob-Trotter Schematic: Flamethrower",
        source = sources.Vendor,
        vendorName = L["Reno Jackson"],
        zoneID = 14771,
    },
    {
        itemID = 230216,
        questID = 85175,
        name =  "Delver's Gob-Trotter Schematic: Harpoon",
        source = sources.Vendor,
        vendorName = L["Reno Jackson"],
        zoneID = 14771,
    },
    {
        itemID = 230219,
        questID = 85181,
        name =  "Delver's Gob-Trotter Schematic: Balloon",
        source = sources.Vendor,
        vendorName = L["Reno Jackson"],
        zoneID = 14771,
    },
    {
        itemID = 230218,
        questID = 85179,
        name =  "Delver's Gob-Trotter Schematic: Pipes",
        source = sources.Vendor,
        vendorName = L["Reno Jackson"],
        zoneID = 14771,
    },
    {
        itemID = 230220,
        questID = 85183,
        name =  "Delver's Gob-Trotter Schematic: Green",
        source = sources.Vendor,
        vendorName = L["Reno Jackson"],
        zoneID = 14771,
    },
    
}

for k, v in pairs(manuscripts) do
    table.insert(addon.DirigibleDB, v)
end
