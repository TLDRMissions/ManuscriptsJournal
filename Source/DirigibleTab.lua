local addonName, addon = ...

-- Delves Dirigible tab

DirigibleMixin = CreateFromMixins(ShapeshiftsMixin)

function DirigibleMixin:OnLoad()
    local item = Item:CreateFromItemID(219391)
    item:ContinueOnItemLoad(function()
		self.tabName = item:GetItemName()
	end)
    
    addon.ParentMixin.OnLoad(self)
end

function DirigibleMixin:GetEntryDB()
    return addon.DirigibleDB
end