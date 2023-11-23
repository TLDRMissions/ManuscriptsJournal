local addonName, addon = ...

-- Shaman Hex Tomes tab

HexTomesMixin = CreateFromMixins(ShapeshiftsMixin)

function HexTomesMixin:OnLoad()
    if select(2, UnitClass("player")) ~= "SHAMAN" then return end
	self.shapeshiftEntryFrames = {};

	self.shapeshiftLayoutData = {};
	self.itemIDsInCurrentLayout = {};

	if not self.numKnownShapeshifts then self.numKnownShapeshifts = 0 end
    if not self.numPossibleShapeshifts then self.numPossibleShapeshifts = 0 end
    
    local spell = Spell:CreateFromSpellID(51514)
    spell:ContinueOnSpellLoad(function()
    	self.tabName = spell:GetSpellName()
    end)
    
    addon.ParentMixin.OnLoad(self)
end

function HexTomesMixin:SortShapeshiftsIntoEquipmentBuckets()
	-- Sort them into equipment buckets
	local equipBuckets = {};
    
    for _, shapeshiftData in pairs(addon.HexTomesDB) do
    	local itemID = shapeshiftData.itemID
    		
    	if not equipBuckets[1] then
    		equipBuckets[1] = {}
    	end

    	table.insert(equipBuckets[1], itemID)

        if self:IsCollected(shapeshiftData) then
            self.numKnownShapeshifts = self.numKnownShapeshifts + 1
    	end
    	self.numPossibleShapeshifts = self.numPossibleShapeshifts + 1

    	self.itemIDsInCurrentLayout[itemID] = true;
	end

	return equipBuckets;
end

function HexTomesMixin:IsCollected(data)
    return IsSpellKnown(data.spellID)
end
