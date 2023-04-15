local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName) 

local sources = addon.Enum.Sources
local zones = addon.Enum.Zones

local manuscripts = {
    {
        name = "Highland Drake: Coiled Horns",
        itemID = 197125,
        questID = 69326,
        source = sources.Rare,
        rareNames = {
            L["Diluu"],
            L["Corrupted Proto-Dragon"],
        },
    },
}

for k, v in pairs(manuscripts) do
    v.iconID = 254291
    v.category = addon.Enum.Drakes.WindborneVelocidrake
    table.insert(addon.db, v)
end
