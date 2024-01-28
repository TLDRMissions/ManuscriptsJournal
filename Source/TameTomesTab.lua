local addonName, addon = ...

-- Hunter Tame Tomes tab

TameTomesMixin = CreateFromMixins(ShapeshiftsMixin)

function TameTomesMixin:OnLoad()
    if select(2, UnitClass("player")) ~= "HUNTER" then return end
	self.shapeshiftEntryFrames = {};

	self.shapeshiftLayoutData = {};

	if not self.numKnownShapeshifts then self.numKnownShapeshifts = 0 end
    if not self.numPossibleShapeshifts then self.numPossibleShapeshifts = 0 end
    
    -- Refer to comments in PolymorphsMixin:OnLoad
    
    local name = GetSpellInfo(1515)
    self.tabName = name
    if not name then
        local ticker = C_Timer.NewTicker(1, function()
            name = GetSpellInfo(1515)
            if name then
                self.tabName = name
                ticker:Cancel()
            end
        end)
    end
    
    addon.ParentMixin.OnLoad(self)
end

function TameTomesMixin:SortShapeshiftsIntoEquipmentBuckets()
	-- Sort them into equipment buckets
	local equipBuckets = {};
    
    for _, shapeshiftData in pairs(addon.TameTomesDB) do
    	local itemID, spellID = shapeshiftData.itemID, shapeshiftData.spellID
    		
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

function TameTomesMixin:IsCollected(data)
    if data.questID then
        return C_QuestLog.IsQuestFlaggedCompleted(data.questID)
    else
        return IsSpellKnown(data.spellID)
    end
end
