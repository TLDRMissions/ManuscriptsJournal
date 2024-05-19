local addonName, addon = ...

addon.itemIDToDB = {}
addon.spellIDToDB = {}

for _, manuscriptData in pairs(addon.db) do
    addon.itemIDToDB[manuscriptData.itemID] = manuscriptData
end

for _, shapeshiftData in pairs(addon.ShapeshiftDB) do
    addon.itemIDToDB[shapeshiftData.itemID] = shapeshiftData
end

for _, hexTomeData in pairs(addon.HexTomesDB) do
    addon.itemIDToDB[hexTomeData.itemID] = hexTomeData
end

for _, polymorphData in pairs(addon.PolymorphTomesDB) do
    if polymorphData.itemID then
        addon.itemIDToDB[polymorphData.itemID] = polymorphData
    else
        addon.spellIDToDB[polymorphData.spellID] = polymorphData
    end
end

for _, grimoireData in pairs(addon.GrimoiresDB) do
    addon.itemIDToDB[grimoireData.itemID] = grimoireData
end

for _, tametomesData in pairs(addon.TameTomesDB) do
    if tametomesData.itemID then
        addon.itemIDToDB[tametomesData.itemID] = tametomesData
    else
        addon.spellIDToDB[tametomesData.spellID] = tametomesData
    end
end

for _, gemData in pairs(addon.MOPRemixGemsDB) do
    addon.itemIDToDB[gemData.itemID] = gemData
end
