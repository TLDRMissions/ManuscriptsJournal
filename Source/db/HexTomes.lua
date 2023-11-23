local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local sources = addon.Enum.Sources

addon.HexTomesDB = {
	{
		itemID = 136972,
		spellID = 211015,
		name = "Tome of Hex: Cockroach",
        source = sources.Vendor,
        vendorName = L["Cravitz Lorent"],
        zoneID = 7502,
	},
	{
		itemID = 136938,
		spellID = 210873,
		name = "Tome of Hex: Compy",
        source = sources.Vendor,
        vendorName = L["Flamesmith Lanying"],
        zoneID = 7745,
	},
	{
		itemID = 136969,
		spellID = 211004,
		name = "Tome of Hex: Spider",
        source = sources.Dungeon,
        bossName = L["Nal'tira"],
        zoneID = 7855,
	},
	--{
	--	itemID = 136971,
	--	spellID = 211010,
	--	name = "Tome of Hex: Snake",
	--},
	{
		itemID = 159841,
		spellID = 269352,
		name = "Tome of Hex: Skeletal Hatchling",
        source = sources.Dungeon,
        bossName = L["Rezan"],
        zoneID = 9028,
	},
	{
		itemID = 162624,
		spellID = 277784,
		name = "Tome of Hex: Wicker Mongrel",
        source = sources.Reputation,
        reputation = 2161,
        reputationRank = 7,
        factionExclusive = "Alliance",
	},
	{
		itemID = 162623,
		spellID = 277778,
		name = "Tome of Hex: Zandalari Tendonripper",
        source = sources.Reputation,
        reputation = 2103,
        reputationRank = 7,
        factionExclusive = "Horde",
	},
	{
		itemID = 172405,
		spellID = 309328,
		name = "Tome of Hex: Living Honey",
        source = sources.Rare,
        rareName = L["Honey Smasher"],
	},
}

for key, data in pairs(addon.HexTomesDB) do
    if data.factionExclusive and (UnitFactionGroup("player") ~= data.factionExclusive) then
        addon.HexTomesDB[key] = nil
    end
end
