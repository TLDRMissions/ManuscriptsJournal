local addonName, addon = ...

addon.itemIDToDB = {}

for _, manuscriptData in pairs(addon.db) do
    addon.itemIDToDB[manuscriptData.itemID] = manuscriptData
end
