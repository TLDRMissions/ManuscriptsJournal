local addonName, addon = ...

addon.itemIDToDB = {}
addon.spellIDToDB = {}

for _, mainData in pairs({addon.db, addon.ShapeshiftDB, addon.HexTomesDB, addon.PolymorphTomesDB, addon.GrimoiresDB, addon.TameTomesDB, addon.DirigibleDB}) do
    for _, data in pairs(mainData) do
        if data.itemID then
            addon.itemIDToDB[data.itemID] = data
        elseif data.spellID then
            addon.spellIDToDB[data.spellID] = data
        end
    end
end