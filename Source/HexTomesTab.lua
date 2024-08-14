local addonName, addon = ...

-- Shaman Hex Tomes tab

HexTomesMixin = CreateFromMixins(ShapeshiftsMixin)

function HexTomesMixin:OnLoad()
    if select(2, UnitClass("player")) ~= "SHAMAN" then return end
	self.shapeshiftEntryFrames = {};

	self.shapeshiftLayoutData = {};

	if not self.numKnownShapeshifts then self.numKnownShapeshifts = 0 end
    if not self.numPossibleShapeshifts then self.numPossibleShapeshifts = 0 end
    
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

function HexTomesMixin:SortShapeshiftsIntoEquipmentBuckets()
	-- Sort them into equipment buckets
	local equipBuckets = {};
    
    for _, shapeshiftData in pairs(addon.HexTomesDB) do
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

function HexTomesMixin:IsCollected(data)
    return IsPlayerSpell(data.spellID)
end
