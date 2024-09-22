local addonName, addon = ...

-- Delves Dirigible tab

DirigibleMixin = CreateFromMixins(ShapeshiftsMixin)

function DirigibleMixin:OnLoad()
	self.shapeshiftEntryFrames = {};

	self.shapeshiftLayoutData = {};

	if not self.numKnownShapeshifts then self.numKnownShapeshifts = 0 end
    if not self.numPossibleShapeshifts then self.numPossibleShapeshifts = 0 end
    
    local item = Item:CreateFromItemID(219391)
    item:ContinueOnItemLoad(function()
		self.tabName = item:GetItemName()
	end)
    
    addon.ParentMixin.OnLoad(self)
end

function DirigibleMixin:SortShapeshiftsIntoEquipmentBuckets()
	-- Sort them into equipment buckets
	local equipBuckets = {};
    
    for _, shapeshiftData in pairs(addon.DirigibleDB) do
    	if not equipBuckets[1] then
    		equipBuckets[1] = {}
    	end

    	table.insert(equipBuckets[1], shapeshiftData)

        if self:IsCollected(shapeshiftData) then
            self.numKnownShapeshifts = self.numKnownShapeshifts + 1
    	end
    	self.numPossibleShapeshifts = self.numPossibleShapeshifts + 1
	end

	return equipBuckets;
end

function DirigibleMixin:IsCollected(data)
    return C_QuestLog.IsQuestFlaggedCompleted(data.questID)
end
