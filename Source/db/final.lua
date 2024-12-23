local addonName, addon = ...

addon.itemIDToDB = {}

for _, mainData in pairs({addon.db, addon.ShapeshiftDB, addon.HexTomesDB, addon.PolymorphTomesDB, addon.GrimoiresDB, addon.TameTomesDB, addon.DirigibleDB}) do
    for _, data in pairs(mainData) do
        if data.itemID then
            addon.itemIDToDB[data.itemID] = data
        end
    end
end