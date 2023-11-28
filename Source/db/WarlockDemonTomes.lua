local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local sources = addon.Enum.Sources

addon.GrimoiresDB = {
	{
		itemID = 207178,
		questID = 76743,
		name = "Grimoire of the Darkfire Imp",
        source = sources.Vendor,
        vendorName = L["Imp Mother Dyala"],
        zoneID = 7875,
	},
	{
		itemID = 207295,
		questID = 76744,
		name = "Grimoire of the Dreadfire Imp",
        source = sources.Vendor,
        vendorName = L["Vi'el"],
        zoneID = 618,
	},
	{
		itemID = 129018,
		questID = 76369,
		name = "Grimoire of the Fel Imp",
        source = sources.Inscription,
	},
	{
		itemID = 207297,
		questID = 76746,
		name = "Grimoire of the Felblaze Imp",
        source = sources.Dungeon,
        bossName = L["Pusillin"], -- Not listed as a boss in the EJ
        zoneID = 2557,
	},
	{
		itemID = 207294,
		questID = 76747,
		name = "Grimoire of the Felfrost Imp",
        source = sources.ZoneDrop,
        zoneID = 5861,
	},
	{
		itemID = 207114,
		questID = 76742,
		name = "Grimoire of the Fiendish Imp",
        source = sources.Vendor,
        vendorName = L["Aridormi"],
        zoneID = 7502,
	},
	{
		itemID = 207111,
		questID = 76737,
		name = "Grimoire of the Hellfire Fel Imp",
        source = sources.Raid,
        bossName = EJ_GetEncounterInfo(1560), -- Terestian Illhoof
	},
	{
		itemID = 207296,
		questID = 76745,
		name = "Grimoire of the Netherbound Imp",
        source = sources.Rare,
        rareName = L["Matron Folnuna"],
        zoneID = 8574,
	},
	{
		itemID = 207113,
		questID = 76741,
		name = "Grimoire of the Trickster Fel Imp",
        source = sources.Other,
        otherDescription = L["Time Rifts"],
	},
	{
		itemID = 207112,
		questID = 76740,
		name = "Grimoire of the Void-Touched Fel Imp",
        source = sources.Vendor,
        vendorName = L["Cupri"],
        zoneID = 3703,
	},
	{
		itemID = 139311,
		questID = 76375,
		name = "Grimoire of the Voidlord",
        source = sources.Inscription,
	},
	{
		itemID = 147117,
		questID = 76377,
		name = "Orb of the Fel Temptress",
        source = sources.Dungeon,
        bossName = L["Hellblaze Temptress"], -- Named Trash
        zoneID = 8527,
	},
	{
		itemID = 147119,
		questID = 76372,
		name = "Grimoire of the Shadow Succubus",
        source = sources.Inscription,
	},
	{
		itemID = 139310,
		questID = 76373,
		name = "Grimoire of the Shivarra",
        source = sources.Inscription,
	},
	{
		itemID = 208051,
		questID = 77180,
		name = "Grimoire of the Antoran Felhunter",
        source = sources.Raid,
        bossName = EJ_GetEncounterInfo(1987), -- Felhounds of Sargeras
	},
	{
		itemID = 208052,
		questID = 77181,
		name = "Grimoire of the Voracious Felmaw",
        source = sources.Other,
        otherDescription = L["Time Rifts"],
	},
	{
		itemID = 208050,
		questID = 77183,
		name = "Grimoire of the Xorothian Felhunter",
        source = sources.Chest,
        chestName = L["Singed Grimoire"],
        zoneID = 8638,
	},
	{
		itemID = 208048,
		questID = 77182,
		name = "Ritual of the Voidmaw Felhunter",
        source = sources.Chest,
        chestName = L["Torn Page"],
        zoneID = 8443,
	},
	{
		itemID = 139315,
		questID = 76376,
		name = "Grimoire of the Wrathguard",
        source = sources.Inscription,
	},
	{
		itemID = 139314,
		questID = 76370,
		name = "Grimoire of the Abyssal",
        source = sources.Inscription,
	},
}
