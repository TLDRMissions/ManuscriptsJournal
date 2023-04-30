local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName) 

local sources = addon.Enum.Sources
local zones = addon.Enum.Zones

local manuscripts = {
    {
        category = addon.Enum.Drakes.HighlandDrake,
        name = "Highland Drake: Embodiment of the Hellforged",
        itemID = 205876,
        questID = 75967,
        source = sources.Raid,
        bossName = EJ_GetInstanceInfo(1208),
    }, 
}

for k, v in pairs(manuscripts) do
    table.insert(addon.db, v)
end
