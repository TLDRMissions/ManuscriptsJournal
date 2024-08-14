local addonName, addon = ...

-- Mage Polymorph Tomes tab

PolymorphsMixin = CreateFromMixins(ShapeshiftsMixin)

function PolymorphsMixin:OnLoad()
    if select(2, UnitClass("player")) ~= "MAGE" then return end
	self.shapeshiftEntryFrames = {};

	self.shapeshiftLayoutData = {};

	if not self.numKnownShapeshifts then self.numKnownShapeshifts = 0 end
    if not self.numPossibleShapeshifts then self.numPossibleShapeshifts = 0 end
    
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

function PolymorphsMixin:SortShapeshiftsIntoEquipmentBuckets()
	-- Sort them into equipment buckets
	local equipBuckets = {};
    
    for _, shapeshiftData in pairs(addon.PolymorphTomesDB) do
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

function PolymorphsMixin:IsCollected(data)
    return IsPlayerSpell(data.spellID)
end
