local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local sources = addon.Enum.Sources
local zones = addon.Enum.Zones
local drakes = addon.Enum.Drakes

local manuscripts = {
    -- These five were in the game files but were added to the vendor in 11.2
    {
        itemID = 235692,
        questID = 82177,
        name = "Delver's Dirigible Schematic: Thrusters",
        source = sources.Vendor,
        vendorName = L["Sir Finley"],
        zoneID = 14771,
        category = 1,
    },
    {
        itemID = 235691,
        questID = 82191,
        name = "Delver's Dirigible Schematic: Yellow Paint",
        source = sources.Vendor,
        vendorName = L["Sir Finley"],
        zoneID = 14771,
        category = 1,
    },
    {
        itemID = 235690,
        questID = 82169,
        name = "Delver's Dirigible Schematic: Harpoon",
        source = sources.Vendor,
        vendorName = L["Sir Finley"],
        zoneID = 14771,
        category = 1,
    },
    {
        itemID = 235689,
        questID = 82186,
        name = "Delver's Dirigible Schematic: Kite",
        source = sources.Vendor,
        vendorName = L["Sir Finley"],
        zoneID = 14771,
        category = 1,
    },
    {
        itemID = 235688,
        questID = 82174,
        name = "Delver's Dirigible Schematic: Fan",
        source = sources.Vendor,
        vendorName = L["Sir Finley"],
        zoneID = 14771,
        category = 1,
    },
    

    
    -- Mana-skimmer schematics
    -- This one already existed in 11.1 but finally had a source added in 11.2, the rest were new in 11.2
    {
        itemID = 235696,
        questID = 82193,
        name = "Delver's Dirigible Schematic: Explorer Decal",
        source = sources.Vendor,
        vendorName = L["Reno Jackson"],
        zoneID = 14771,
        category = 1,
    },
    {
        itemID = 238178,
        questID = 88814,
        name =  "Delver's Mana-Skimmer Schematic: Canister",
        source = sources.Vendor,
        vendorName = L["Reno Jackson"],
        zoneID = 14771,
        category = 3,
    },
    {
        itemID = 238181,
        questID = 88820,
        name =  "Delver's Mana-Skimmer Schematic: Energy Thrusters",
        source = sources.Vendor,
        vendorName = L["Reno Jackson"],
        zoneID = 14771,
        category = 3,
    },
    {
        itemID = 238177,
        questID = 88816,
        name =  "Delver's Mana-Skimmer Schematic: Emitter",
        source = sources.Vendor,
        vendorName = L["Reno Jackson"],
        zoneID = 14771,
        category = 3,
    },
    {
        itemID = 238179,
        questID = 88815,
        name =  "Delver's Mana-Skimmer Schematic: Quad Glider",
        source = sources.Vendor,
        vendorName = L["Reno Jackson"],
        zoneID = 14771,
        category = 3,
    },
    {
        itemID = 238180,
        questID = 88817,
        name =  "Delver's Mana-Skimmer Schematic: Void Paint",
        source = sources.Vendor,
        vendorName = L["Reno Jackson"],
        zoneID = 14771,
        category = 3,
    },
}

for k, v in pairs(manuscripts) do
    table.insert(addon.DirigibleDB, v)
end
