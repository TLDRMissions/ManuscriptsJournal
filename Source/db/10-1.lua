local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName) 

local sources = addon.Enum.Sources
local zones = addon.Enum.Zones
local drakes = addon.Enum.Drakes

local manuscripts = {
    {
        category = drakes.CliffsideWylderdrake,
        name = "Cliffside Wylderdrake: Small Head Spikes",
        itemID = 196978,
        questID = 69178,
        --source = sources., 
    },
    {
        category = drakes.CliffsideWylderdrake,
        name = "Cliffside Wylderdrake: Spiked Club Tail",
        itemID = 197021,
        questID = 69221,
        --source = sources., 
    },
    {
        category = drakes.HighlandDrake,
        name = "Highland Drake: Bronze and Green Armor",
        itemID = 197156,
        questID = 69357,
    },
    {
        category = drakes.HighlandDrake,
        name = "Highland Drake: Ornate Helm",
        itemID = 197120,
        questID = 69321,
        source = sources.Renown,
        renownFaction = 2564,
        renownRank = 19,
    },
    {
        category = drakes.HighlandDrake,
        name = "Highland Drake: Spiked Head",
        itemID = 197109,
        questID = 69310,
    },
    {
        category = drakes.RenewedProtoDrake,
        name = "Renewed Proto-Drake: Short Spiked Crest",
        itemID = 197364,
        questID = 69565,
    },
    {
        category = drakes.RenewedProtoDrake,
        name = "Renewed Proto-Drake: Plated Jaw",
        itemID = 202275,
        questID = 73059,
    },
}

for k, v in pairs(manuscripts) do
    table.insert(addon.db, v)
end
