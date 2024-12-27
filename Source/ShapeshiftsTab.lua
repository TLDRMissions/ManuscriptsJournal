local addonName, addon = ...

local SHAPESHIFT_SORT_ORDER = {
    addon.Enum.Shapeshifts.Bear,
    addon.Enum.Shapeshifts.Cat,
    addon.Enum.Shapeshifts.Moonkin,
    addon.Enum.Shapeshifts.Tree,
    addon.Enum.Shapeshifts.Travel,
    addon.Enum.Shapeshifts.Flight,
    addon.Enum.Shapeshifts.Aquatic,
    addon.Enum.Shapeshifts.All,
}

local NUM_SHAPESHIFTS = 0
for _ in pairs(addon.Enum.Shapeshifts) do
    NUM_SHAPESHIFTS = NUM_SHAPESHIFTS + 1
end

-- Druid Shapeshifts tab

ShapeshiftsMixin = CreateFromMixins(addon.ParentMixin)

function ShapeshiftsMixin:GetNumCategories()
    return NUM_SHAPESHIFTS
end

function ShapeshiftsMixin:GetAllCategory()
    return addon.Enum.Shapeshifts.All
end

function ShapeshiftsMixin:GetSortOrder()
    return SHAPESHIFT_SORT_ORDER
end

function ShapeshiftsMixin:GetCategoryStrings()
    return addon.Strings.Shapeshifts
end

function ShapeshiftsMixin:GetEntryDB()
    return addon.ShapeshiftDB
end

function ShapeshiftsMixin:GetFilterDB()
    return ShapeshiftsJournalFiltersDB
end

function ShapeshiftsMixin:OnLoad()
    if select(2, UnitClass("player")) ~= "DRUID" then return end
    self.tabName = AUCTION_CATEGORY_GLYPHS

    addon.ParentMixin.OnLoad(self)
    
    EventUtil.ContinueOnAddOnLoaded(addonName, function()
        if not ShapeshiftsJournalAccountWideDB then
            ShapeshiftsJournalAccountWideDB = {}
        end
        if not ShapeshiftsJournalFiltersDB then
            ShapeshiftsJournalFiltersDB = {}
        end
        self:FullRefreshIfVisible()
    end)
end

function ShapeshiftsMixin:IsCollected(data)
    if data.questID then
        local collected = C_QuestLog.IsQuestFlaggedCompleted(data.questID)
        if collected and ShapeshiftsJournalAccountWideDB then
            ShapeshiftsJournalAccountWideDB[data.questID] = collected
        end
        if (not collected) and ShapeshiftsJournalAccountWideDB and ShapeshiftsJournalAccountWideDB[data.questID] then
            collected = true
        end
        return collected
    end
    
    if data.artifactID then
        local artifactAppearanceSetID, artifactAppearanceID, appearanceName, displayIndex, unlocked, failureDescription, uiCameraID, altHandCameraID, swatchColorR, swatchColorG, swatchColorB, modelOpacity, modelSaturation, obtainable = C_ArtifactUI.GetAppearanceInfoByID(data.artifactID)
        return unlocked
    end
    
    if data.customizationID then
        return self:IsAppearanceCollected(data.customizationID)
    end
    
    if data.isCollected then
        return data.isCollected()
    end
end

function ShapeshiftsMixin:IsAppearanceCollected(appearanceID)
    return ShapeshiftsJournalAccountWideDB["aid"..appearanceID]
end

local noInfinite
hooksecurefunc(C_BarberShop, "GetAvailableCustomizations", function()
    if noInfinite then return end
    noInfinite = true
    local categories = C_BarberShop.GetAvailableCustomizations()
    noInfinite = nil
    for _, category in ipairs(categories) do
        if category.spellShapeshiftFormID then
            for _, option in ipairs(category.options) do
                for _, choice in ipairs(option.choices) do
                    ShapeshiftsJournalAccountWideDB["aid"..choice.id] = not choice.isLocked
                end
            end
        end
    end
end)