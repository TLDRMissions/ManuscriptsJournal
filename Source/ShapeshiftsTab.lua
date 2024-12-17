local addonName, addon = ...

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

-- Druid Shapeshifts tab

ShapeshiftsMixin = CreateFromMixins(addon.ParentMixin)

function ShapeshiftsMixin:OnLoad()
    if select(2, UnitClass("player")) ~= "DRUID" then return end
	self.shapeshiftEntryFrames = {};

	self.shapeshiftLayoutData = {};

	if not self.numKnownShapeshifts then self.numKnownShapeshifts = 0 end
    if not self.numPossibleShapeshifts then self.numPossibleShapeshifts = 0 end
    
    self.tabName = AUCTION_CATEGORY_GLYPHS
    
    self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
    
    addon.ParentMixin.OnLoad(self)
    
    EventUtil.ContinueOnAddOnLoaded(addonName, function()
        if not ShapeshiftsJournalAccountWideDB then
            ShapeshiftsJournalAccountWideDB = {}
        end
        self:FullRefreshIfVisible()
    end)
end

function ShapeshiftsMixin:FullRefreshIfVisible()
	self.needsDataRebuilt = true;
	self:RefreshViewIfVisible();
end

function ShapeshiftsMixin:RefreshViewIfVisible()
	if self:IsVisible() then
		self:RefreshView();
	else
		self.needsRefresh = true;
	end
end

function ShapeshiftsMixin:RebuildLayoutData()
	if not self.needsDataRebuilt then
		return;
	end
	self.needsDataRebuilt = false;

	self.shapeshiftLayoutData = {};

    self.numKnownShapeshifts = 0
    self.numPossibleShapeshifts = 0

	local equipBuckets = self:SortShapeshiftsIntoEquipmentBuckets();
	self:SortEquipBucketsIntoPages(equipBuckets);
	self.PagingFrame:SetMaxPages(math.max(#self.shapeshiftLayoutData, 1));
end

function ShapeshiftsMixin:SortShapeshiftsIntoEquipmentBuckets()
	-- Sort them into equipment buckets
	local equipBuckets = {};
    
    for _, shapeshiftData in pairs(addon.ShapeshiftDB) do
        local collected = self:IsCollected(shapeshiftData)
    		
    	if not equipBuckets[1] then
    		equipBuckets[1] = {}
    	end

    	table.insert(equipBuckets[1], shapeshiftData)

        if collected then
            self.numKnownShapeshifts = self.numKnownShapeshifts + 1
    	end
    	self.numPossibleShapeshifts = self.numPossibleShapeshifts + 1
	end

	return equipBuckets;
end

function ShapeshiftsMixin:SortEquipBucketsIntoPages(equipBuckets)
	if not next(equipBuckets) then
		return;
	end

	local currentPage = {};
	local pageHeight = VIEW_MODE_FULL_PAGE_HEIGHT
	local heightLeft = pageHeight;
	local widthLeft = PAGE_WIDTH;

    local equipBucket = equipBuckets[1];

    if equipBucket then
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

	table.insert(self.shapeshiftLayoutData, currentPage);
end

function ShapeshiftsMixin:LayoutCurrentPage()
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
                print("error: header found when not expected")
			else
				-- Entry
				numEntriesInUse = numEntriesInUse + 1;
				local entry = self:AcquireFrame(self.shapeshiftEntryFrames, numEntriesInUse, "CHECKBUTTON", "ManuscriptSpellButtonTemplate");
                if layoutData.itemID then
                    entry.itemID = layoutData.itemID
                else
                    entry.itemID = nil
                    entry.spellID = layoutData.spellID
                end

				if entry:IsVisible() then
					-- If the button was already visible (going to a new page and being reused) we have to update the button immediately instead of deferring the update through the OnShown
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
end

function ShapeshiftsMixin:IsCollected(data)
    local collected = C_QuestLog.IsQuestFlaggedCompleted(data.questID)
    if collected and ShapeshiftsJournalAccountWideDB then
        ShapeshiftsJournalAccountWideDB[data.questID] = collected
    end
    if (not collected) and ShapeshiftsJournalAccountWideDB and ShapeshiftsJournalAccountWideDB[data.questID] then
        collected = true
    end
    return collected
end
