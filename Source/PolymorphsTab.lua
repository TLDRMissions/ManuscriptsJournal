local addonName, addon = ...

-- Mage Polymorph Tomes tab

PolymorphsMixin = CreateFromMixins(ShapeshiftsMixin)

function PolymorphsMixin:OnLoad()
    if select(2, UnitClass("player")) ~= "MAGE" then return end

    -- Note: tried using Spell:CreateFromSpellID and Spell:ContinueOnSpellLoad
    -- this led to taint issues with the spellbook frame
    -- I guess this addon calling those functions tainted the whole chain
    -- which the spellbook frame tried to use later on
    -- Have to use the more... primitive version instead
    
    local name = C_Spell.GetSpellInfo(118).name
    self.tabName = name
    if not name then
        local ticker = C_Timer.NewTicker(1, function()
            name = C_Spell.GetSpellInfo(118).name
            if name then
                self.tabName = name
                ticker:Cancel()
            end
        end)
    end
    
    addon.ParentMixin.OnLoad(self)
end

function PolymorphsMixin:IsCollected(data)
    return IsPlayerSpell(data.spellID)
end

function PolymorphsMixin:GetEntryDB()
    return addon.PolymorphTomesDB
end