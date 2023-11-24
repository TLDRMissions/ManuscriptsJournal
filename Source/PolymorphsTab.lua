local addonName, addon = ...

-- Shaman Hex Tomes tab

PolymorphsMixin = CreateFromMixins(ShapeshiftsMixin)

function PolymorphsMixin:OnLoad()
    if select(2, UnitClass("player")) ~= "MAGE" then return end
	self.shapeshiftEntryFrames = {};

	self.shapeshiftLayoutData = {};
	self.itemIDsInCurrentLayout = {};

	if not self.numKnownShapeshifts then self.numKnownShapeshifts = 0 end
    if not self.numPossibleShapeshifts then self.numPossibleShapeshifts = 0 end
    
    local spell = Spell:CreateFromSpellID(118)
    spell:ContinueOnSpellLoad(function()
    	self.tabName = spell:GetSpellName()
    end)
    
    addon.ParentMixin.OnLoad(self)
end

function PolymorphsMixin:SortShapeshiftsIntoEquipmentBuckets()
	-- Sort them into equipment buckets
	local equipBuckets = {};
    
    for _, shapeshiftData in pairs(addon.PolymorphTomesDB) do
    	local itemID = shapeshiftData.itemID
        if not itemID then itemID = -100 end
    		
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

function PolymorphsMixin:IsCollected(data)
    return IsSpellKnown(data.spellID)
end

function PolymorphsMixin:UpdateButton(button)
    if button.itemID and (button.itemID > 0) then
        ShapeshiftsMixin.UpdateButton(self, button)
    else -- Polymorph Pig is not learned from an item
    	local name, rank, itemTexture, castTime, minRange, maxRange, spellID, originalIcon = GetSpellInfo(28272)
        
        button.iconTexture:SetTexture(itemTexture);
    	button.iconTextureUncollected:SetTexture(itemTexture);
    	button.iconTextureUncollected:SetDesaturated(true);

    	button.name:SetText(name);

    	button.name:ClearAllPoints();
    	button.name:SetPoint("LEFT", button, "RIGHT", 9, 3);

    	local collected = IsSpellKnown(28272)
        
        if collected then
    		button.iconTexture:Show();
    		button.iconTextureUncollected:Hide();
    		button.name:SetTextColor(1, 0.82, 0, 1);
    		button.name:SetShadowColor(0, 0, 0, 1);

    		button.slotFrameCollected:Show();
    		button.slotFrameUncollected:Hide();
    		button.slotFrameUncollectedInnerGlow:Hide();
    	else
    		button.iconTexture:Hide();
    		button.iconTextureUncollected:Show();
    		button.name:SetTextColor(0.33, 0.27, 0.20, 1);
    		button.name:SetShadowColor(0, 0, 0, 0.33);

    		button.slotFrameCollected:Hide();
    		button.slotFrameUncollected:Show();
    		button.slotFrameUncollectedInnerGlow:Show();
    	end
    end
end
