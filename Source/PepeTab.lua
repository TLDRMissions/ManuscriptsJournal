local addonName, addon = ...

-- Mage Polymorph Tomes tab

PepeMixin = CreateFromMixins(ShapeshiftsMixin)

function PepeMixin:OnLoad()
    self.tabName = "Pepe"
    
    addon.ParentMixin.OnLoad(self)
end

function PepeMixin:GetEntryDB()
    return addon.PepeDB
end