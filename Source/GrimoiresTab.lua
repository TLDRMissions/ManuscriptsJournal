local addonName, addon = ...

-- Warlock Demon Grimoires tab

-- Each manuscript button entry dimension
local BUTTON_WIDTH = 208;
local BUTTON_HEIGHT = 50;

-- Padding around each manuscript button
local BUTTON_PADDING_X = 0;
local BUTTON_PADDING_Y = 16;

-- The total height of a manuscript header
local HEADER_HEIGHT = 37

-- Y padding before the first header of a page
local FIRST_HEADER_Y_PADDING = 0;
-- Y padding before additional headers after the first header of a page
local ADDITIONAL_HEADER_Y_PADDING = 16;

-- Max height of a page before starting a new page, when the view mode is in "all classes"
local VIEW_MODE_FULL_PAGE_HEIGHT = 370;
-- Max width of a page before starting a new row
local PAGE_WIDTH = 625;

-- The starting X offset of a page
local START_OFFSET_X = 40;
-- The starting Y offset of a page
local START_OFFSET_Y = -25;

-- Additional Y offset of a page when the view mode is in "all classes"
local VIEW_MODE_FULL_ADDITIONAL_Y_OFFSET = 0;

local NEW_ROW_OPCODE = -1; -- Used to indicate that the layout should move to the next row

GrimoiresMixin = CreateFromMixins(ShapeshiftsMixin)

function GrimoiresMixin:OnLoad()
    if select(2, UnitClass("player")) ~= "WARLOCK" then return end
	self.shapeshiftEntryFrames = {};
    self.grimoireHeaderFrames = {};

	self.shapeshiftLayoutData = {};

	if not self.numKnownShapeshifts then self.numKnownShapeshifts = 0 end
    if not self.numPossibleShapeshifts then self.numPossibleShapeshifts = 0 end
    
    self.tabName = "Demon Appearances"
    
    addon.ParentMixin.OnLoad(self)
end

function GrimoiresMixin:SortShapeshiftsIntoEquipmentBuckets()
	-- Sort them into equipment buckets
	local equipBuckets = {};
    
    for _, shapeshiftData in pairs(addon.GrimoiresDB) do
    	local collected = self:IsCollected(shapeshiftData)
        
        local category = shapeshiftData.category
        if category then
            if not equipBuckets[category] then
                equipBuckets[category] = {}
            end
            
            table.insert(equipBuckets[category], shapeshiftData)
        
            if collected then
                self.numKnownShapeshifts = self.numKnownShapeshifts + 1
    	    end
    	    self.numPossibleShapeshifts = self.numPossibleShapeshifts + 1
        end
	end

	return equipBuckets;
end

function GrimoiresMixin:IsCollected(data)
    return C_QuestLog.IsQuestFlaggedCompleted(data.questID)
end

function GrimoiresMixin:SortEquipBucketsIntoPages(equipBuckets)
	if not next(equipBuckets) then
		return;
	end

	local currentPage = {};
	local pageHeight = VIEW_MODE_FULL_PAGE_HEIGHT
	local heightLeft = pageHeight;
	local widthLeft = PAGE_WIDTH;

	for category in ipairs(addon.Strings.WarlockCategories) do
		local equipBucket = equipBuckets[category];

		if equipBucket then
    		if heightLeft < HEADER_HEIGHT + BUTTON_PADDING_Y + BUTTON_HEIGHT then
    			-- Not enough room to add the upcoming header for this bucket, move to next page
    			table.insert(self.shapeshiftLayoutData, currentPage);
    			heightLeft = pageHeight;
    			currentPage = {};
    		end

    		-- Add header
    		table.insert(currentPage, addon.Strings.WarlockCategories[category])
    		if #currentPage > 1 then
    			heightLeft = heightLeft - ADDITIONAL_HEADER_Y_PADDING - BUTTON_HEIGHT - BUTTON_PADDING_Y;
    		else
    			heightLeft = heightLeft - FIRST_HEADER_Y_PADDING;
    		end

    		widthLeft = PAGE_WIDTH;
    		heightLeft = heightLeft - HEADER_HEIGHT;

			-- Add buttons
			for i, itemID in ipairs(equipBucket) do
				if widthLeft < BUTTON_WIDTH + BUTTON_PADDING_X then
					-- Not enough room for another entry, try going to a new row
					widthLeft = PAGE_WIDTH;

					if heightLeft < BUTTON_HEIGHT + BUTTON_PADDING_Y then
						-- Not enough room for another row of entries, move to next page
						table.insert(self.shapeshiftLayoutData, currentPage);

						heightLeft = pageHeight - HEADER_HEIGHT;
						currentPage = {};
					else
						-- Room for another row
						table.insert(currentPage, NEW_ROW_OPCODE);
						heightLeft = heightLeft - BUTTON_HEIGHT - BUTTON_PADDING_Y;
					end
				end

				widthLeft = widthLeft - BUTTON_WIDTH - BUTTON_PADDING_X;
				table.insert(currentPage, itemID);
			end
		end
	end

	table.insert(self.shapeshiftLayoutData, currentPage);
end

function GrimoiresMixin:LayoutCurrentPage()
	local pageLayoutData = self.shapeshiftLayoutData[self.PagingFrame:GetCurrentPage()];

	local numEntriesInUse = 0;
	local numHeadersInUse = 0;

	if pageLayoutData then
		local offsetX = START_OFFSET_X;
		local offsetY = START_OFFSET_Y;
		offsetY = offsetY + VIEW_MODE_FULL_ADDITIONAL_Y_OFFSET;

		for i, layoutData in ipairs(pageLayoutData) do
			if layoutData == NEW_ROW_OPCODE then
				assert(i ~= 1); -- Never want to start a new row first thing on a page, something is wrong with the page creator
				offsetX = START_OFFSET_X;
				offsetY = offsetY - BUTTON_HEIGHT - BUTTON_PADDING_Y;
			elseif type(layoutData) == "string" then
				-- Header
				numHeadersInUse = numHeadersInUse + 1;
				local header = self:AcquireFrame(self.grimoireHeaderFrames, numHeadersInUse, "FRAME", "ManuscriptHeaderTemplate");
				header.text:SetText(layoutData);

				if i > 1 then
					-- Additional headers on the same page should have additional spacing between the sections
					offsetY = offsetY - ADDITIONAL_HEADER_Y_PADDING - BUTTON_HEIGHT - BUTTON_PADDING_Y;
				else
					offsetY = offsetY - FIRST_HEADER_Y_PADDING;
				end
				header:SetPoint("TOP", self.iconsFrame, "TOP", 0, offsetY);

				offsetX = START_OFFSET_X;
				offsetY = offsetY - HEADER_HEIGHT;
			else
				-- Entry
				numEntriesInUse = numEntriesInUse + 1;
				local entry = self:AcquireFrame(self.shapeshiftEntryFrames, numEntriesInUse, "CHECKBUTTON", "ManuscriptSpellButtonTemplate");
				if layoutData.itemID then
                    entry.itemID = layoutData.itemID
                else
                    entry.spellID = layoutData.spellID
                end

				if entry:IsVisible() then
					-- If the button was already visible (going to a new page and being reused we have to update the button immediately instead of deferring the update through the OnShown
					self:UpdateButton(entry);
				end

				if i == 1 then
					-- Continuation of a section from a previous page
					-- Move everything down as if there was a header
					offsetY = offsetY - HEADER_HEIGHT;
				end

				entry:SetPoint("TOPLEFT", self.iconsFrame, "TOPLEFT", offsetX, offsetY);

				offsetX = offsetX + BUTTON_WIDTH + BUTTON_PADDING_X;
			end
		end
	end

	addon.ActivatePooledFrames(self.shapeshiftEntryFrames, numEntriesInUse);
	addon.ActivatePooledFrames(self.grimoireHeaderFrames, numHeadersInUse);
end
