local addonName, addon = ...

addon.itemIDToDB = {}

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
        addon.itemIDToDB[-100] = polymorphData
    end
end
