local addonName, addon = ...

-- Warlock Demon Grimoires tab

GrimoiresMixin = CreateFromMixins(ShapeshiftsMixin)

function GrimoiresMixin:OnLoad()
    if select(2, UnitClass("player")) ~= "WARLOCK" then return end

    self.tabName = PET_TYPE_DEMON.." "..ARTIFACTS_APPEARANCE_TAB
    
    addon.ParentMixin.OnLoad(self)
end

function GrimoiresMixin:GetEntryDB()
    return addon.GrimoiresDB
end

function GrimoiresMixin:GetSortOrder()
    return {1,2,3,4,5,6,7,8,9}
end

function GrimoiresMixin:GetNumCategories()
    return #addon.Strings.WarlockCategories
end

function GrimoiresMixin:GetCategoryStrings()
    return addon.Strings.WarlockCategories
end