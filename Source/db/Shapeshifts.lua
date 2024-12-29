local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local sources = addon.Enum.Sources
local shapeshifts = addon.Enum.Shapeshifts

addon.ShapeshiftDB = {
	-- Claws of Ursoc
    {
        artifactID = 267,
        category = shapeshifts.Bear,
    },
    {
        artifactID = 268,
        category = shapeshifts.Bear,
    },
    {
        artifactID = 269,
        category = shapeshifts.Bear,
    },
    -- Stonepaw
    {
        artifactID = 270,
        category = shapeshifts.Bear,
    },
    {
        artifactID = 274,
        category = shapeshifts.Bear,
    },
    {
     	artifactID = 275,
        category = shapeshifts.Bear,
    },
    {
     	artifactID = 276,
        category = shapeshifts.Bear,
    },
    -- Avatar to Ursol
    {
        artifactID = 277,
        category = shapeshifts.Bear,
    },
    {
        artifactID = 271,
        category = shapeshifts.Bear,
    },
    {
        artifactID = 278,
        category = shapeshifts.Bear,
    },
    {
        artifactID = 279,
        category = shapeshifts.Bear,
    },
    -- Fallen to Nightmare
    {
        artifactID = 272,
        category = shapeshifts.Bear,
    },
    { 
        artifactID = 280,
        category = shapeshifts.Bear,
    },
    {
        artifactID = 281,
        category = shapeshifts.Bear,
    },
    {
        artifactID = 282,
        category = shapeshifts.Bear,
    },
    -- Might of the Grizzlemaw
    {
        artifactID = 990,
        category = shapeshifts.Bear,
    },
    {
        artifactID = 991,
        category = shapeshifts.Bear,
    },
    {
        artifactID = 992,
        category = shapeshifts.Bear,
    },
    {
        artifactID = 993,
        category = shapeshifts.Bear,
    },
    -- Guardian of the Glade
    {
        artifactID = 283,
        category = shapeshifts.Bear,
    },
    {
        artifactID = 273,
        category = shapeshifts.Bear,
    },
    {
        artifactID = 284,
        category = shapeshifts.Bear,
    },
    {
        artifactID = 285,
        category = shapeshifts.Bear,
    },
    -- 27 Runebear Yellow
    {
		itemID = 210751,
		questID = 78528,
		name = "Mark of the Hibernating Runebear",
        source = sources.Raid,
        bossName = L["Aurostor, the Hibernating"],
        category = shapeshifts.Bear,
	},
    -- 28 Bristlebruin Green
    {
		itemID = 210729,
		questID = 78517,
		name = "Mark of the Verdant Bristlebruin",
        source = sources.Rare,
        rareName = L["Moragh the Slothful"],
        category = shapeshifts.Bear,
	},
    -- 29 Bristlebruin Ash
    {
		itemID = 210727,
		questID = 78518,
		name = "Pollenfused Bristlebruin Fur Sample",
        source = sources.Chest,
        chestName = L["Pollenfused Bristlebruin Fur Sample"],
        category = shapeshifts.Bear,
	},
    -- 30 Umbraclaw Brown
    {
		itemID = 210738,
		questID = 78519,
		name = "Mark of the Loamy Umbraclaw",
        source = sources.ZoneDrop,
        zoneID = 14529,
        category = shapeshifts.Bear,
	},
    -- 31 Unbraclaw White
    {
		itemID = 210739,
		questID = 78520,
		name = "Mark of the Snowy Umbraclaw",
        source = sources.Chest,
        chestName = L["Dreamseed Cache"],
        category = shapeshifts.Bear,
	},
    -- 32 Umbraclaw Black
    {
		itemID = 210647,
		questID = 78481,
		name = "Mark of the Umbramane",
        source = sources.Rare,
        rareName = L["Mosa Umbramane"],
        category = shapeshifts.Bear,
	},

    -- ==================
    -- CAT FORM
    -- ==================
    
    -- Fangs of Ashamane
    {
        artifactID = 287,
        category = shapeshifts.Cat,
    },
    {
        artifactID = 429,
        category = shapeshifts.Cat,
    },
    {
        artifactID = 431,
        category = shapeshifts.Cat,
    },
    -- Nature's Fury
    {
        artifactID = 436,
        category = shapeshifts.Cat,
    },
    {
        artifactID = 432,
        category = shapeshifts.Cat,
    },
    {
        artifactID = 437,
        category = shapeshifts.Cat,
    },
    {
        artifactID = 438,
        category = shapeshifts.Cat,
    },
    -- Primal Stalker
    {
        artifactID = 434,
        category = shapeshifts.Cat,
    },
    {
        artifactID = 442,
        category = shapeshifts.Cat,
    },
    {
        artifactID = 443,
        category = shapeshifts.Cat,
    },
    {
        artifactID = 444,
        category = shapeshifts.Cat,
    },
    -- Incarnation of Nightmare
    {
        artifactID = 433,
        category = shapeshifts.Cat,
    },
    {
        artifactID = 439,
        category = shapeshifts.Cat,
    },
    {
        artifactID = 440,
        category = shapeshifts.Cat,
    },
    {
        artifactID = 441,
        category = shapeshifts.Cat,
    },
    -- Ghost of the Pridemother
    {
        artifactID = 435,
        category = shapeshifts.Cat,
    },
    {
        artifactID = 445,
        category = shapeshifts.Cat,
    },
    {
        artifactID = 446,
        category = shapeshifts.Cat,
    },
    {
        artifactID = 447,
        category = shapeshifts.Cat,
    },
    -- Feather of the Moonspirit
    {
        artifactID = 830,
        category = shapeshifts.Cat,
    },
    {
        artifactID = 831,
        category = shapeshifts.Cat,
    },
    {
        artifactID = 832,
        category = shapeshifts.Cat,
    },
    {
        artifactID = 833,
        category = shapeshifts.Cat,
    },
    -- 26 Druid of the Flame
    {
        icon = 317242,
        name = function() return C_Spell.GetSpellName(427655) end, -- Druid of the Flame
        category = shapeshifts.Cat,
        source = sources.Other,
        otherDescription = function()
                local toyCollected = PlayerHasToy(122304)
                local transmogCollected = C_TransmogCollection.PlayerHasTransmog(69897) or C_TransmogCollection.PlayerHasTransmog(71466)
                
                local toyString = toyCollected and "|cff00ff00" or "|cffff0000"
                local _, toyName = C_ToyBox.GetToyInfo(122304)
                toyString = toyString .. toyName .. "|r"
                
                local transmogString = transmogCollected and "|cff00ff00" or "|cffff0000"
                local transmogName = C_Item.GetItemNameByID(69897) or ""
                transmogString = transmogString .. transmogName .. "|r"
                return TOY .. ": " .. toyString .. ", or " .. TRANSMOGRIFICATION .. ": " .. transmogString
            end,
        isCollected = function()
                return PlayerHasToy(122304) or C_TransmogCollection.PlayerHasTransmog(69897) or C_TransmogCollection.PlayerHasTransmog(71466)
            end,
    },
    -- 27 Dreamsaber Blue
    {
		itemID = 210728,
		questID = 78521,
		name = "Moon-Blessed Claw",
        source = sources.Container,
        containerID = 210991,
        category = shapeshifts.Cat,
	},
    -- 28 Dreamsaber Purple
    {
		itemID = 210650,
		questID = 78503,
		name = "Mark of the Keen-Eyed Dreamsaber",
        source = sources.Rare,
        rareName = L["Keen-eyed Cian"],
        category = shapeshifts.Cat,
	},
    -- 29 Dreamsaber Green
    {
		itemID = 210669,
		questID = 78507,
		name = "Mark of the Evergreen Dreamsaber",
        source = sources.ZoneDrop,
        zoneID = 14529,
        category = shapeshifts.Cat,
	},
    
    
    -- ==================
    -- MOONKIN FORM
    -- ==================
    
    {
		itemID = 211280,
		questID = 78525,
		name = "Feather of the Smoke Red Moon",
        source = sources.Raid,
        bossName = L["Tindral Sageswift"],
        category = shapeshifts.Moonkin,
	},
    
    -- ==================
    -- TREE FORM
    -- ==================
    
    -- ==================
    -- FLIGHT FORM
    -- ==================
	{
		itemID = 162029,
		questID = 62676,
		name = "Mark of the Humble Flyer",
        source = sources.Inscription,
        category = shapeshifts.Flight,
	},
    {
		itemID = 129021,
		questID = 62675,
		name = "Mark of the Sentinel",
        source = sources.Inscription,
        category = shapeshifts.Flight,
	},
    {
        spellID = 243616,
        questID = 46319,
        name = "Archdruid's Lunarwing Form",
        source = sources.Quest,
        sourceQuestID = 46319,
        category = shapeshifts.Flight,
    },
	{
		itemID = 187888,
		questID = 64987,
		name = "Mark of the Shimmering Ardenmoth",
        source = sources.Inscription,
        category = shapeshifts.Flight,
	},
	{
		itemID = 187936,
		questID = 65062,
		name = "Mark of the Sable Ardenmoth",
        source = sources.Inscription,
        category = shapeshifts.Flight,
	},
	{
		itemID = 187933,
		questID = 65058,
		name = "Mark of the Duskwing Raven",
        source = sources.Inscription,
        category = shapeshifts.Flight,
	},
	{
		itemID = 187931,
		questID = 65059,
		name = "Mark of the Regal Dredbat",
        source = sources.Inscription,
        category = shapeshifts.Flight,
	},
	{
		itemID = 187887,
		questID = 65048,
		name = "Mark of the Gloomstalker Dredbat",
        source = sources.Inscription,
        category = shapeshifts.Flight,
	},
	-- 9 Anu'relos
    {
		itemID = 210754,
		questID = 78527,
		name = "Feather of the Blazing Somnowl",
        source = sources.Raid,
        bossName = L["Fyrakk"],
        category = shapeshifts.Flight,
	},
	{
		itemID = 210645,
		questID = 78479,
		name = "Feather of Friends",
        source = sources.Quest,
        sourceQuestID = 78066,
        category = shapeshifts.Flight,
	},
	{
		itemID = 210535,
		questID = 78448,
		name = "Mark of the Slumbering Somnowl",
        source = sources.ZoneDrop,
        zoneID = 14529,
        category = shapeshifts.Flight,
	},
    
    -- ==================
    -- AQUATIC FORM
    -- ==================
	{
		itemID = 40919,
		questID = 62673,
		name = "Mark of the Orca",
        source = sources.Inscription,
        category = shapeshifts.Aquatic,
	},
	{
		itemID = 162022,
		questID = 62674,
		name = "Mark of the Dolphin",
        source = sources.Inscription,
        category = shapeshifts.Aquatic,
	},
	{
		itemID = 162027,
		questID = 62672,
		name = "Mark of the Tideskipper",
        source = sources.Inscription,
        category = shapeshifts.Aquatic,
	},
	{
		itemID = 210753,
		questID = 78516,
		name = "Scale of the Prismatic Whiskerfish",
        source = sources.ZoneDrop,
        zoneID = 14529,
        category = shapeshifts.Aquatic,
	},
    
    -- ==================
    -- TRAVEL FORM
    -- ==================
    {
		itemID = 89868,
		questID = 62677,
		name = "Mark of the Cheetah",
        source = sources.Inscription,
        category = shapeshifts.Travel,
	},
	{
		itemID = 140630,
		questID = 62678,
		name = "Mark of the Doe",
        source = sources.Inscription,
        category = shapeshifts.Travel,
	},
    {
		itemID = 187884,
		questID = 64986,
		name = "Mark of the Twilight Runestag",
        source = sources.Inscription,
        category = shapeshifts.Travel,
	},
	{
		itemID = 187934,
		questID = 65061,
		name = "Mark of the Midnight Runestag",
        source = sources.Inscription,
        category = shapeshifts.Travel,
	},
	{
		itemID = 211081,
		questID = 78514,
		name = "Mark of the Auroral Dreamtalon",
        source = sources.Chest,
        chestName = L["Dreamseed Cache"],
        category = shapeshifts.Travel,
	},
	{
		itemID = 211080,
		questID = 78512,
		name = "Mark of the Boreal Dreamtalon",
        source = sources.Chest,
        chestName = L["Dreamseed Cache"],
        category = shapeshifts.Travel,
	},
	{
		itemID = 210683,
		questID = 78513,
		name = "Mark of the Dreamtalon Matriarch",
        source = sources.Rare,
        rareName = L["Matriarch Keevah"],
        category = shapeshifts.Travel,
	},
	{
		itemID = 210674,
		questID = 78511,
		name = "Mark of the Sable Dreamtalon",
        source = sources.Rare,
        rareName = L["Ristar the Rabid"],
        category = shapeshifts.Travel,
	},
	{
		itemID = 210684,
		questID = 78515,
		name = "Mark of the Thriving Dreamtalon",
        source = sources.ZoneDrop,
        zoneID = 14529,
        category = shapeshifts.Travel,
	},
	{
		itemID = 210735,
		questID = 78523,
		name = "Mark of the Auric Dreamstag",
        source = sources.Inscription,
        category = shapeshifts.Travel,
	},
	{
		itemID = 210731,
		questID = 78522,
		name = "Mark of the Lush Dreamstag",
        source = sources.ZoneDrop,
        zoneID = 14529,
        category = shapeshifts.Travel,
	},
	{
		itemID = 210736,
		questID = 78524,
		name = "Mark of the Smoldering Dreamstag",
        source = sources.Rare,
        rareName = L["Talthonei Ashwhisper"],
        category = shapeshifts.Travel,
	},
}
