local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local sources = addon.Enum.Sources

addon.TameTomesDB = {
	{
		itemID = 94232,
		spellID = 138430,
		name = "Ancient Tome of Dinomancy",
        source = sources.ZoneDrop,
        zoneID = 6661,
	},
    {
		itemID = 134125,
		spellID = 205154,
		name = "Mecha-Bond Imprint Matrix",
        --source = sources., -- engineering
	},
    {
		itemID = 147580,
		spellID = 242155,
		name = "Tome of the Hybrid Beast",
        source = sources.Vendor,
        vendorName = "Pan the Kind Hand",
        zoneID = 7877,
	},
    {
		itemID = 166502,
        questID = 54753,
		name = "Blood-Soaked Tome of Dark Whispers",
        source = sources.Raid,
        bossName = L["Zul"],
	},
    {
		itemID = 183123,
        questID = 62254,
		name = "How to School Your Serpent",
        source = sources.Reputation,
        reputation = 1271,
        reputationRank = 8,
	},
    {
		itemID = 183124,
        questID = 62255,
		name = "Simple Tome of Bone-Binding",
        source = sources.ZoneDrop,
        zoneID = 11462,
	},
    {
		itemID = 180705,
        questID = 61160,
		name = "Gargon Training Manual",
        source = sources.Rare,
        rareName = "Huntmaster Petrus",
	},
    {
		itemID = 201791,
        questID = 72094,
		name = "How to Train a Dragonkin",
        source = sources.Quest,
        sourceQuestID = 72372,
	},
    {
		spellID = 390631,
        questID = 66444,
		name = "Ottuk Taming",
        source = sources.Quest,
        sourceQuestID = 66444,
	},
    {
		itemID = 211314,
        questID = 78842,
		name = "Cinder of Companionship",
        source = sources.Raid,
        bossName = L["Fyrakk"],
	},
}
