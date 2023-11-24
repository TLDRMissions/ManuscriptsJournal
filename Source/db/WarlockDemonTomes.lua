local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local sources = addon.Enum.Sources

addon.GrimoiresDB = {
	{
		itemID = 207178,
		spellID = 76743,
		name = "Grimoire of the Darkfire Imp",
        source = sources.Vendor,
        vendorName = L["Imp Mother Dyala"],
        zoneID = 7875,
	},
	{
		itemID = 207295,
		spellID = 76744,
		name = "Grimoire of the Dreadfire Imp",
        source = sources.Vendor,
        vendorName = L["Vi'el"],
        zoneID = 618,
	},
	{
		itemID = 129018,
		spellID = 76369,
		name = "Grimoire of the Fel Imp",
        source = sources.Inscription,
	},
	{
		itemID = 207297,
		spellID = 76746,
		name = "Grimoire of the Felblaze Imp",
        source = sources.Dungeon,
        bossName = L["Pusillin"], -- Not listed as a boss in the EJ
        zoneID = 2557,
	},
	{
		itemID = 207294,
		spellID = 76747,
		name = "Grimoire of the Felfrost Imp",
        source = sources.ZoneDrop,
        zoneID = 5861,
	},
	{
		itemID = 207114,
		spellID = 76742,
		name = "Grimoire of the Fiendish Imp",
        source = sources.Vendor,
        vendorName = L["Aridormi"],
        zoneID = 7502,
	},
	{
		itemID = 207111,
		spellID = 76737,
		name = "Grimoire of the Hellfire Fel Imp",
        source = sources.Raid,
        bossName = EJ_GetEncounterInfo(1560), -- Terestian Illhoof
	},
	{
		itemID = 207296,
		spellID = 76745,
		name = "Grimoire of the Netherbound Imp",
        source = sources.Rare,
        rareName = L["Matron Folnuna"],
        zoneID = 8574,
	},
	{
		itemID = 207113,
		spellID = 76741,
		name = "Grimoire of the Trickster Fel Imp",
        source = sources.Other,
        otherDescription = L["Time Rifts"],
	},
	{
		itemID = 207112,
		spellID = 76740,
		name = "Grimoire of the Void-Touched Fel Imp",
        source = sources.Vendor,
        vendorName = L["Cupri"],
        zoneID = 3703,
	},
	{
		itemID = 139311,
		spellID = 76375,
		name = "Grimoire of the Voidlord",
        source = sources.Inscription,
	},
	{
		itemID = 147117,
		spellID = 76377,
		name = "Orb of the Fel Temptress",
        source = sources.Dungeon,
        bossName = L["Hellblaze Temptress"], -- Named Trash
        zoneID = 8527,
	},
	{
		itemID = 147119,
		spellID = 76372,
		name = "Grimoire of the Shadow Succubus",
        source = sources.Inscription,
	},
	{
		itemID = 139310,
		spellID = 76373,
		name = "Grimoire of the Shivarra",
        source = sources.Inscription,
	},
	{
		itemID = 208051,
		spellID = 77180,
		name = "Grimoire of the Antoran Felhunter",
        source = sources.Raid,
        bossName = EJ_GetEncounterInfo(1987), -- Felhounds of Sargeras
	},
	{
		itemID = 208052,
		spellID = 77181,
		name = "Grimoire of the Voracious Felmaw",
        source = sources.Other,
        otherDescription = L["Time Rifts"],
	},
	{
		itemID = 208050,
		spellID = 77183,
		name = "Grimoire of the Xorothian Felhunter",
        source = sources.Chest,
        chestName = L["Singed Grimoire"],
        zoneID = 8638,
	},
	{
		itemID = 208048,
		spellID = 77182,
		name = "Ritual of the Voidmaw Felhunter",
        source = sources.Chest,
        chestName = L["Torn Page"],
        zoneID = 8443,
	},
	{
		itemID = 139315,
		spellID = 76376,
		name = "Grimoire of the Wrathguard",
        source = sources.Inscription,
	},
	{
		itemID = 139314,
		spellID = 76370,
		name = "Grimoire of the Abyssal",
        source = sources.Inscription,
	},
}
