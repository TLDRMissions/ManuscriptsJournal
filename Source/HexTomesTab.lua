local addonName, addon = ...

-- Shaman Hex Tomes tab

HexTomesMixin = CreateFromMixins(ShapeshiftsMixin)

function HexTomesMixin:OnLoad()
    if select(2, UnitClass("player")) ~= "SHAMAN" then return end

    -- Refer to comments in PolymorphsMixin:OnLoad
    
    local name = C_Spell.GetSpellInfo(51514).name
    self.tabName = name
    if not name then
        local ticker = C_Timer.NewTicker(1, function()
            name = C_Spell.GetSpellInfo(51514).name
            if name then
                self.tabName = name
                ticker:Cancel()
            end
        end)
    end
    
    addon.ParentMixin.OnLoad(self)
end

function HexTomesMixin:IsCollected(data)
    return IsPlayerSpell(data.spellID)
end

function HexTomesMixin:GetEntryDB()
    return addon.HexTomesDB
end