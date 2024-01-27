local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local sources = addon.Enum.Sources

addon.PolymorphTomesDB = {
	{
		itemID = 22739,
		spellID = 28271,
		name = "Tome of Polymorph: Turtle",
        -- Source: Various. Fishing in Cata zones. A few places in ZG.
	},
	{
		itemID = 44709,
		spellID = 61305,
		name = "Tome of Polymorph: Black Cat",
        source = sources.Vendor,
        vendorName = L["Endora Moorehead"],
        zoneID = 4395,
	},
    {
        spellID = 28272,
        name = "Polymorph: Pig",
    },
	--{
	--	itemID = 44600,
	--	spellID = 61025,
	--	name = "Tome of Polymorph: Serpent",
	--},
	{
		itemID = 44793,
		spellID = 61721,
		name = "Tome of Polymorph: Rabbit",
        source = sources.WorldEvent,
        worldEventName = C_TransmogCollection.GetSourceRequiredHoliday(21598)
	},
	--{
	--	itemID = 44811,
	--	spellID = 61780,
	--	name = "Tome of Polymorph: Turkey",
	--},
	{
		itemID = 120138,
		spellID = 161354,
		name = "Tome of Polymorph: Monkey",
        -- Source: various monkeys around the world
	},
	--{
	--	itemID = 120139,
	--	spellID = 161355,
	--	name = "Tome of Polymorph: Penguin",
	--},
	{
		itemID = 120137,
		spellID = 161353,
		name = "Tome of Polymorph: Polar Bear Cub",
        source = sources.ZoneDrop,
        zoneID = 65,
	},
	{
		itemID = 120140,
		spellID = 126819,
		name = "Tome of Polymorph: Porcupine",
	},
	{
		itemID = 162626,
		spellID = 277792,
		name = "Tome of Polymorph: Bumblebee",
        factionExclusive = "Alliance",
        source = sources.Reputation,
        reputation = 2162,
        reputationRank = 7,
	},
	{
		itemID = 162625,
		spellID = 277787,
		name = "Tome of Polymorph: Direhorn",
        factionExclusive = "Horde",
        source = sources.Reputation,
        reputation = 2103,
        reputationRank = 7,
	},
	{
		itemID = 200205,
		spellID = 391622,
		name = "Tome of Polymorph: Duck",
        source = sources.Quest,
        sourceQuestID = 71002,
	},
}

for key, data in pairs(addon.PolymorphTomesDB) do
    if data.factionExclusive and (UnitFactionGroup("player") ~= data.factionExclusive) then
        addon.PolymorphTomesDB[key] = nil
    end
end
