local addonName, addon = ...

-- Hunter Tame Tomes tab

TameTomesMixin = CreateFromMixins(ShapeshiftsMixin)

function TameTomesMixin:OnLoad()
    if select(2, UnitClass("player")) ~= "HUNTER" then return end

    -- Refer to comments in PolymorphsMixin:OnLoad
    
    local name = C_Spell.GetSpellInfo(1515).name
    self.tabName = name
    if not name then
        local ticker = C_Timer.NewTicker(1, function()
            name = C_Spell.GetSpellInfo(1515).name
            if name then
                self.tabName = name
                ticker:Cancel()
            end
        end)
    end
    
    addon.ParentMixin.OnLoad(self)
end

function TameTomesMixin:GetEntryDB()
    return addon.TameTomesDB
end

function TameTomesMixin:IsCollected(data)
    if data.questID then
        return C_QuestLog.IsQuestFlaggedCompleted(data.questID)
    else
        return IsPlayerSpell(data.spellID)
    end
end
