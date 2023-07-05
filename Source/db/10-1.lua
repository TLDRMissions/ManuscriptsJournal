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
        source = sources.Container,
        containerID = 205226,
    },
    {
        category = drakes.CliffsideWylderdrake,
        name = "Cliffside Wylderdrake: Spiked Club Tail",
        itemID = 197021,
        questID = 69221,
        source = sources.Rare,
        rareName = L["Kob'rok"], 
    },
    {
        category = drakes.HighlandDrake,
        name = "Highland Drake: Bronze and Green Armor",
        itemID = 197156,
        questID = 69357,
        source = sources.Fyrakk,
        fyrakkType = addon.Enum.Fyrakk.Chest,
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
        source = sources.Rare,
        rareName = L["Flowfy"],
    },
    {
        category = drakes.RenewedProtoDrake,
        name = "Renewed Proto-Drake: Short Spiked Crest",
        itemID = 197364,
        questID = 69565,
        source = sources.Rare,
        rareName = L["Colossian"],
    },
    {
        category = drakes.RenewedProtoDrake,
        name = "Renewed Proto-Drake: Plated Jaw",
        itemID = 202275,
        questID = 73059,
        source = sources.Chest,
        chestName = CLUB_FINDER_ANY_FLAG,
        zoneID = 14022,
    },
    {
        category = drakes.RenewedProtoDrake,
        name = "Renewed Proto-Drake: Pronged Tail",
        itemID = 202280,
        questID = 73060,
        source = sources.Container,
        containerID = 205226,
    },
    {
        category = drakes.RenewedProtoDrake,
        name = "Renewed Proto-Drake: Brown Hair",
        itemID = 197369,
        questID = 69570,
        source = sources.Renown,
        renownFaction = 2507,
        renownRank = "9",
    },
    {
        category = drakes.HighlandDrake,
        name = "Highland Drake: Tapered Chin",
        itemID = 197104,
        questID = 69305,
        source = sources.Container,
        containerID = 205226,
    },
    {
        category = drakes.CliffsideWylderdrake,
        name = "Cliffside Wylderdrake: Split Horns",
        itemID = 196997,
        questID = 69197,
        source = sources.Container,
        containerID = 205226, 
    },
    {
        category = drakes.RenewedProtoDrake,
        name = "Renewed Proto-Drake: Black and Red Armor",
        itemID = 197348,
        questID = 69549,
        source = sources.Fyrakk,
        fyrakkType = addon.Enum.Fyrakk.Boss,
    },
    {
        category = drakes.WindborneVelocidrake,
        name = "Windborne Velocidrake: Bronze and Green Armor",
        itemID = 197577,
        questID = 69781,
        source = sources.Fyrakk,
        fyrakkType = addon.Enum.Fyrakk.Chest,
    },
    {
        category = drakes.RenewedProtoDrake,
        name = "Renewed Proto-Drake: Bronze and Pink Armor",
        itemID = 197353,
        questID = 69554,
        source = sources.Fyrakk,
        fyrakkType = addon.Enum.Fyrakk.Chest,
    },
    {
        category = drakes.RenewedProtoDrake,
        name = "Renewed Proto-Drake: Bruiser Horns",
        itemID = 202277,
        questID = 73057,
        source = sources.Fyrakk,
        fyrakkType = addon.Enum.Fyrakk.Boss,
    },
    {
        category = drakes.CliffsideWylderdrake,
        name = "Cliffside Wylderdrake: Bronze and Teal Armor",
        itemID = 196965,
        questID = 69165,
        source = sources.Fyrakk,
        fyrakkType = addon.Enum.Fyrakk.Chest, 
    },
    {
        category = drakes.HighlandDrake,
        name = "Highland Drake: Spiked Legs",
        itemID = 197134,
        questID = 69335,
        source = sources.Quest,
        sourceQuestID = 72950,
    },
    {
        category = drakes.HighlandDrake,
        name = "Highland Drake: Embodiment of the Hellforged",
        itemID = 205876,
        questID = 75967,
        source = sources.Raid,
        bossName = L["Scalecommander Sarkareth"],
    },
    --
    -- ADDED IN 10.1.5
    --
    {
        category = drakes.RenewedProtoDrake,
        name = "Renewed Proto-Drake: Infinite Scales",
        itemID = 208104,
        questID = 77255,
    },
    {
        category = drakes.WindingSlitherdrake,
        name = "Winding Slitherdrake: Infinite Scales",
        itemID = 208106,
        questID = 77259,
    },
    {
        category = drakes.CliffsideWylderdrake,
        name = "Cliffside Wylderdrake: Infinite Scales",
        itemID = 208102,
        questID = 77258,
    },
    {
        category = drakes.WindborneVelocidrake,
        name = "Windborne Velocidrake: Infinite Scales",
        itemID = 208105,
        questID = 77256,
    },
}

for k, v in pairs(manuscripts) do
    table.insert(addon.db, v)
end
