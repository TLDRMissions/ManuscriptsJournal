local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")

local collectedManuscriptFilter = true
local uncollectedManuscriptFilter = true
local unusableManuscriptFilter = false
local sourceFilter = {}
local selectedBarID

local DRAKE_SORT_ORDER = {
    addon.Enum.Drakes.WindingSlitherdrake,
    addon.Enum.Drakes.RenewedProtoDrake,
    addon.Enum.Drakes.WindborneVelocidrake,
    addon.Enum.Drakes.HighlandDrake,
    addon.Enum.Drakes.CliffsideWylderdrake,
    addon.Enum.Drakes.GrottoNetherwingDrake,
    addon.Enum.Drakes.FlourishingWhimsydrake,
    addon.Enum.Drakes.All,
}

local NUM_DRAKES = 0
for _ in pairs(addon.Enum.Drakes) do
    NUM_DRAKES = NUM_DRAKES + 1
end

local function SetManuscriptSourceFilter(source, checked)
    sourceFilter[source] = checked
end

local function GetManuscriptSourceFilter(source)
    if sourceFilter[source] == nil then
        return true
    end
    return sourceFilter[source]
end

local function SetAllSourceFilters(checked)
    for i = 1, 99 do
        sourceFilter[i] = checked
    end
end

local function SetDefaultFilters()
    collectedManuscriptFilter = true
    uncollectedManuscriptFilter = true
    unusableManuscriptFilter = false
    ManuscriptsJournalFiltersDB.collected = true
    ManuscriptsJournalFiltersDB.uncollected = true
    ManuscriptsJournalFiltersDB.unusable = false
    SetAllSourceFilters(true)
end

local function IsUsingDefaultFilters()
    if not (collectedManuscriptFilter and uncollectedManuscriptFilter and (not unusableManuscriptFilter)) then return false end
    
    for i = 1, 99 do
        if sourceFilter[i] == false then
             return false
        end
    end
    return true
end

local function GetCollectedManuscriptFilter()
    return collectedManuscriptFilter
end

local function GetUncollectedManuscriptFilter()
    return uncollectedManuscriptFilter
end

local function GetUnusableManuscriptFilter()
    return unusableManuscriptFilter
end

local function GetNumSources()
    return #addon.Strings.Sources
end

local function GetSourceName(index)
    return addon.Strings.Sources[index]
end

-- adapted from Blizzard_Collections\Blizzard_HeirloomCollection

ManuscriptsMixin = CreateFromMixins(addon.ParentMixin)

function ManuscriptsJournal_OnEvent(self, event, ...)
	if event == "UNIT_SPELLCAST_SUCCEEDED" then
        self:OnManuscriptsUpdated(...)
	end
end

function ManuscriptsJournal_OnShow(self)
	CollectionsJournal:SetPortraitToAsset("Interface\\Icons\\Inv_glyph_minordruid");

	if self.needsRefresh then
		self:RefreshView();
	end
end

function ManuscriptsJournal_OnMouseWheel(self, delta)
	self.PagingFrame:OnMouseWheel(delta);
end

function ManuscriptsJournal_UpdateButton(self)
	self:GetParent():GetParent():UpdateButton(self);
end

do
    local function add(list)
        local left
        local r, g, b = 1, 0, 0
        for _, name in ipairs(list) do
            if left then
                local r1, g1, b1, r2, g2, b2 = r, g, b, r, g, b
                if (r==0) and (g==0) and (b==1) then
                    r1, g1, b1 = 1, 1, 0
                elseif (r==0) and (g==1) and (b==0) then
                    r2, g2, b2 = 1, 0, 1
                end
                GameTooltip:AddDoubleLine(left, name, r1, g1, b1, b2, r2, g2)
                left = nil
                r, g, b = g, b, r
            else
                left = name
            end
        end
        if left then
            if (r==0) and (g==0) and (b==1) then
                r, g, b = 1, 1, 0
            end
            GameTooltip:AddLine(left, r, g, b)
        end
    end

    function ManuscriptsJournalSpellButton_OnEnter(self)
    	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");

    	self.UpdateTooltip = ManuscriptsJournalSpellButton_OnEnter;
        
        local db
        if self.itemID then
            db = addon.itemIDToDB[self.itemID]
            GameTooltip:SetItemByID(db.itemID)
        else
            db = addon.spellIDToDB[self.spellID]
            GameTooltip:SetSpellByID(db.spellID)
        end
        local source = db.source
        if source == nil then return end
        
        GameTooltip:AddLine(" ")
        GameTooltip:AddDoubleLine(L["Source:"], addon.Strings.Sources[source] or "", 1, 1, 1, 1, 1, 1)
            
        if source == addon.Enum.Sources.Rare then
            if db.rareNames then
                add(db.rareNames)
            elseif db.rareName then
                GameTooltip:AddLine(db.rareName)
            elseif db.rareZone then
                GameTooltip:AddDoubleLine(L["Various in:"], addon.Strings.Zones[db.rareZone])
            end
        elseif source == addon.Enum.Sources.Reputation then
            if db.reputations then
                local reputations = {}
                for _, reputationID in ipairs(db.reputations) do
                    local name = GetFactionInfoByID(reputationID)
                    table.insert(reputations, name)
                end
                add(reputations)
            else
                local name = GetFactionInfoByID(db.reputation)
                GameTooltip:AddLine(name)
            end
            if db.reputationRank then
                GameTooltip:AddDoubleLine(L["Required Rank:"], _G["FACTION_STANDING_LABEL"..db.reputationRank])
            elseif db.friendshipRank then
                GameTooltip:AddDoubleLine(L["Required Rank:"], db.friendshipRank)
            end
        elseif source == addon.Enum.Sources.Renown then
            GameTooltip:AddDoubleLine(GetFactionInfoByID(db.renownFaction), RANK_COLON.." "..db.renownRank)
        elseif (source == addon.Enum.Sources.Achievement) or (source == addon.Enum.Sources.DragonRacingAchievement) or (source == addon.Enum.Sources.PvPSeason) then
            local _, name = GetAchievementInfo(db.achievementID)
            GameTooltip:AddLine(name)
        elseif source == addon.Enum.Sources.Dungeon then
            GameTooltip:AddDoubleLine(db.bossName, C_Map.GetAreaInfo(db.zoneID))
        elseif (source == addon.Enum.Sources.Container) or (source == addon.Enum.Sources.DragonRacingContainer) then
            local name, link = GetItemInfo(db.containerID)
            if link then
                GameTooltip:AddLine(link)
            end
        elseif source == addon.Enum.Sources.Quest then
            GameTooltip:AddLine(C_QuestLog.GetTitleForQuestID(db.sourceQuestID))
        elseif source == addon.Enum.Sources.Inscription then
        elseif source == addon.Enum.Sources.Hunt then
        elseif source == addon.Enum.Sources.Vendor then
            GameTooltip:AddDoubleLine(db.vendorName, C_Map.GetAreaInfo(db.zoneID))
        elseif source == addon.Enum.Sources.Raid then
            GameTooltip:AddLine(db.bossName)
        elseif source == addon.Enum.Sources.Chest then
            if db.zoneID then
                GameTooltip:AddDoubleLine(db.chestName, C_Map.GetAreaInfo(db.zoneID))
            else
                GameTooltip:AddLine(db.chestName)
            end
        elseif source == addon.Enum.Sources.Fyrakk then
            if db.fyrakkType then
                GameTooltip:AddLine(addon.Strings.Fyrakk[db.fyrakkType])
            end
        elseif source == addon.Enum.Sources.WorldEvent then
            if db.worldEventName then
                GameTooltip:AddLine(db.worldEventName)
            end
        elseif source == addon.Enum.Sources.Superbloom then
        elseif source == addon.Enum.Sources.ZoneDrop then
            GameTooltip:AddLine(C_Map.GetAreaInfo(db.zoneID))
        elseif source == addon.Enum.Sources.Other then
            GameTooltip:AddLine(db.otherDescription)
        else
            print(source)
        end
        
        if db.bugged and (not C_QuestLog.IsQuestFlaggedCompleted(db.questID)) then
            GameTooltip:AddLine(L["Bugged"], 1, 0, 0)
        end
        
        GameTooltip:Show()
        addon.journalTooltipShown = true
    end
    
    function ManuscriptsJournalSpellButton_OnExit()
        addon.journalTooltipShown = false
    end
end

function ManuscriptsJournalSpellButton_OnClick(self, button)
	if IsModifiedClick() then
		local _, itemLink = GetItemInfo(self.itemID)
		HandleModifiedItemClick(itemLink)
	end
end

do
	local function OpenCollectedFilterDropDown(self, level)
		if level then
			self:GetParent():OpenCollectedFilterDropDown(level);
		end
	end
	function ManuscriptsJournalCollectedFilterDropDown_OnLoad(self)
		LibDD:UIDropDownMenu_Initialize(self, OpenCollectedFilterDropDown, "MENU");
		ManuscriptsJournal:UpdateResetFiltersButtonVisibility();
	end
end

function ManuscriptsMixin:OnLoad()
    self.searchText = ""

	self.manuscriptEntryFrames = {};
	self.manuscriptHeaderFrames = {};

	self.manuscriptLayoutData = {};

	if not self.numKnownManuscripts then self.numKnownManuscripts = {} end
    if not self.numPossibleManuscripts then self.numPossibleManuscripts = {} end
    for i = 1, NUM_DRAKES do
        if i ~= addon.Enum.Drakes.All then
            local drake = DRAKE_SORT_ORDER[i]
            self.numKnownManuscripts[i] = 0
            self.numPossibleManuscripts[i] = 0
            
            self["mount"..i.."Bar"]:SetScript("OnEnter", function()
                GameTooltip:SetOwner(self["mount"..i.."Bar"], "ANCHOR_BOTTOM")
                GameTooltip:AddLine(addon.Strings.Drakes[drake])
                GameTooltip:Show()
            end)
            
            self["mount"..i.."Bar"]:SetScript("OnLeave", function()
                GameTooltip:Hide()
            end)
        end
    end
    
    self.tabName = L["ADDON_NAME"]
    
    self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
    
    addon.ParentMixin.OnLoad(self)
end

function ManuscriptsMixin:OnManuscriptsUpdated(unitTarget, castGUID, spellID)
	if unitTarget ~= "player" then return end
    if not addon.manuscriptSpellIDs[spellID] then return end
    C_Timer.After(2, function() self:FullRefreshIfVisible() end)
end

function ManuscriptsMixin:OnKeybinding()
    LibStub('SecureTabs-2.0'):Select(ManuscriptsJournal.Tab)
end

function ManuscriptsMixin:FullRefreshIfVisible()
	self.needsDataRebuilt = true;
	self:RefreshViewIfVisible();
end

function ManuscriptsMixin:RefreshViewIfVisible()
	if self:IsVisible() then
		self:RefreshView();
	else
		self.needsRefresh = true;
	end
end

function ManuscriptsMixin:RebuildLayoutData()
	if not self.needsDataRebuilt then
		return;
	end
	self.needsDataRebuilt = false;

	self.manuscriptLayoutData = {};

    for i = 1, NUM_DRAKES do
        self.numKnownManuscripts[i] = 0
        self.numPossibleManuscripts[i] = 0
    end

	local equipBuckets = self:SortManuscriptsIntoEquipmentBuckets();
	self:SortEquipBucketsIntoPages(equipBuckets);
	self.PagingFrame:SetMaxPages(math.max(#self.manuscriptLayoutData, 1));
end

function ManuscriptsMixin:SortManuscriptsIntoEquipmentBuckets()
	-- Sort them into equipment buckets
	local equipBuckets = {};
    
    for _, manuscriptData in pairs(addon.db) do
        local collected = C_QuestLog.IsQuestFlaggedCompleted(manuscriptData.questID)
        
        local include = false
        if collected and collectedManuscriptFilter then include = true end
        if manuscriptData.source and (not collected) and (not manuscriptData.unobtainable) and uncollectedManuscriptFilter then include = true end
        if (not collected) and unusableManuscriptFilter and ((not manuscriptData.source) or manuscriptData.unobtainable) then include = true end
        
        if include and (self.searchText ~= "") then
            include = false
            local name = GetItemInfo(manuscriptData.itemID)
            local source = addon.Strings.Sources[manuscriptData.source]
            
            if name and string.lower(name):find(string.lower(self.searchText)) then
                include = true
            elseif source and string.lower(source):find(string.lower(self.searchText)) then
                include = true
            elseif manuscriptData.rareNames then
                for _, name in pairs(manuscriptData.rareNames) do
                    if string.lower(name):find(string.lower(self.searchText)) then
                        include = true
                    end
                end
            end
        end
        
        if include and (not GetManuscriptSourceFilter(manuscriptData.source)) then
            include = false
        end
        
        if include then
    		local itemID = manuscriptData.itemID
    		
            local category = manuscriptData.category
    		if category then
    			if not equipBuckets[category] then
    				equipBuckets[category] = {}
    			end

    			table.insert(equipBuckets[category], itemID)

                if collected then
                    self.numKnownManuscripts[category] = self.numKnownManuscripts[category] + 1
    			end
    			self.numPossibleManuscripts[category] = self.numPossibleManuscripts[category] + 1
    		end
        end
	end

	return equipBuckets;
end

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

function ManuscriptsMixin:SortEquipBucketsIntoPages(equipBuckets)
	if not next(equipBuckets) then
		return;
	end

	local currentPage = {};
	local pageHeight = VIEW_MODE_FULL_PAGE_HEIGHT
	local heightLeft = pageHeight;
	local widthLeft = PAGE_WIDTH;

	for _, category in ipairs(DRAKE_SORT_ORDER) do
		local equipBucket = equipBuckets[category];

		if equipBucket then
    		if heightLeft < HEADER_HEIGHT + BUTTON_PADDING_Y + BUTTON_HEIGHT then
    			-- Not enough room to add the upcoming header for this bucket, move to next page
    			table.insert(self.manuscriptLayoutData, currentPage);
    			heightLeft = pageHeight;
    			currentPage = {};
    		end

    		-- Add header
    		table.insert(currentPage, addon.Strings.Drakes[category])
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
						table.insert(self.manuscriptLayoutData, currentPage);

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

	table.insert(self.manuscriptLayoutData, currentPage);
end

function ManuscriptsMixin:LayoutCurrentPage()
	local pageLayoutData = self.manuscriptLayoutData[self.PagingFrame:GetCurrentPage()];

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
				local header = self:AcquireFrame(self.manuscriptHeaderFrames, numHeadersInUse, "FRAME", "ManuscriptHeaderTemplate");
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
				local entry = self:AcquireFrame(self.manuscriptEntryFrames, numEntriesInUse, "CHECKBUTTON", "ManuscriptSpellButtonTemplate");
				entry.itemID = layoutData;

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

	addon.ActivatePooledFrames(self.manuscriptEntryFrames, numEntriesInUse);
	addon.ActivatePooledFrames(self.manuscriptHeaderFrames, numHeadersInUse);
end

function ManuscriptsMixin:UpdateProgressBar()
	if #DRAKE_SORT_ORDER < 2 then
        local drake = DRAKE_SORT_ORDER[1]
        
        local _, maxProgress = self.progressBar:GetMinMaxValues()
        local currentProgress = self.progressBar:GetValue() + self.numKnownManuscripts[drake] - self["mount"..selectedBarID.."Bar"]:GetValue()
        self.progressBar:SetValue(currentProgress)
        self.progressBar.text:SetFormattedText(L["MANUSCRIPTS_PROGRESS_FORMAT"], currentProgress, maxProgress)
        
        _, maxProgress = self["mount"..selectedBarID.."Bar"]:GetMinMaxValues()
        self["mount"..selectedBarID.."Bar"]:SetValue(self.numKnownManuscripts[drake])
        self["mount"..selectedBarID.."Bar"].text:SetFormattedText(L["MANUSCRIPTS_PROGRESS_FORMAT"], self.numKnownManuscripts[drake], maxProgress)
        
        return
    end

    local maxProgress, currentProgress = 0, 0
    
    for i = 1, NUM_DRAKES-1 do
        local drake = DRAKE_SORT_ORDER[i]
        maxProgress = maxProgress + self.numPossibleManuscripts[drake]
        currentProgress = currentProgress + self.numKnownManuscripts[drake]
        self["mount"..i.."Bar"]:SetMinMaxValues(0, self.numPossibleManuscripts[drake])
        self["mount"..i.."Bar"]:SetValue(self.numKnownManuscripts[drake])
        self["mount"..i.."Bar"].text:SetFormattedText(L["MANUSCRIPTS_PROGRESS_FORMAT"], self.numKnownManuscripts[drake], self.numPossibleManuscripts[drake])
    end
	self.progressBar:SetMinMaxValues(0, maxProgress);
	self.progressBar:SetValue(currentProgress);
	self.progressBar.text:SetFormattedText(L["MANUSCRIPTS_PROGRESS_FORMAT"], currentProgress, maxProgress);
end

function ManuscriptsMixin:SetCollectedManuscriptFilter(checked)
    assert(type(checked) == "boolean")
	collectedManuscriptFilter = checked
    ManuscriptsJournalFiltersDB.collected = checked
	self:FullRefreshIfVisible();
end

function ManuscriptsMixin:GetCollectedManuscriptFilter()
    return GetCollectedManuscriptFilter()
end

function ManuscriptsMixin:SetUncollectedManuscriptFilter(checked)
    assert(type(checked) == "boolean")
    uncollectedManuscriptFilter = checked
    ManuscriptsJournalFiltersDB.uncollected = checked
	self:FullRefreshIfVisible();
end

function ManuscriptsMixin:SetUnusableManuscriptFilter(checked)
    assert(type(checked) == "boolean")
    unusableManuscriptFilter = checked
    ManuscriptsJournalFiltersDB.unusable = checked
    self:FullRefreshIfVisible()
end

function ManuscriptsMixin:SetSourceChecked(source, checked)
	if self:IsSourceChecked(source) ~= checked then
		SetManuscriptSourceFilter(source, checked);

		self:FullRefreshIfVisible();
	end
end

function ManuscriptsMixin:IsSourceChecked(source)
	return GetManuscriptSourceFilter(source)
end

function ManuscriptsMixin:SetAllSourcesChecked(checked)
	SetAllSourceFilters(checked)

	self:FullRefreshIfVisible();
	LibDD:UIDropDownMenu_Refresh(self.filterDropDown, L_UIDROPDOWNMENU_MENU_VALUE, L_UIDROPDOWNMENU_MENU_LEVEL);
end

function ManuscriptsMixin:ResetFilters()
	SetDefaultFilters()
	self.FilterButton.ResetButton:Hide();

	self:FullRefreshIfVisible();
end

function ManuscriptsMixin:UpdateResetFiltersButtonVisibility()
    RunNextFrame(function()
        self.FilterButton.ResetButton:SetShown(not IsUsingDefaultFilters());
    end)
end

function ManuscriptsMixin:OpenCollectedFilterDropDown(level)
	local filterSystem = {
		onUpdate = function() self:UpdateResetFiltersButtonVisibility() end,
		filters = {
			{ type = FilterComponent.Checkbox, text = COLLECTED, set = function(value) ManuscriptsJournal:SetCollectedManuscriptFilter(value) end, isSet = GetCollectedManuscriptFilter },
			{ type = FilterComponent.Checkbox, text = NOT_COLLECTED, set = function(value) ManuscriptsJournal:SetUncollectedManuscriptFilter(value) end, isSet = GetUncollectedManuscriptFilter },
            { type = FilterComponent.Checkbox, text = MOUNT_JOURNAL_FILTER_UNUSABLE, set = function(value) ManuscriptsJournal:SetUnusableManuscriptFilter(value) end, isSet = GetUnusableManuscriptFilter },
			{ type = FilterComponent.Submenu, text = SOURCES, value = 1, childrenInfo = {
				filters = {
					{ type = FilterComponent.TextButton, 
					  text = CHECK_ALL,
					  set = function() self:SetAllSourcesChecked(true);	end, 
					},
					{ type = FilterComponent.TextButton,
					  text = UNCHECK_ALL,
					  set = function() self:SetAllSourcesChecked(false); end, 
					},
					{ type = FilterComponent.DynamicFilterSet,
					  buttonType = FilterComponent.Checkbox, 
					  set = function(filter, value)	self:SetSourceChecked(filter, value); end,
					  isSet = function(source) return self:IsSourceChecked(source); end,
					  numFilters = GetNumSources,
					  nameFunction = GetSourceName,
					},
				},
			},
		},
		}
	};

	addon.FilterDropDownSystem.Initialize(self, filterSystem, level);
end

function ManuscriptsJournalSearchBox_OnTextChanged(self)
	SearchBoxTemplate_OnTextChanged(self);
	self:GetParent().searchText = self:GetText()
	ManuscriptsJournal:FullRefreshIfVisible();
end

function ManuscriptsJournalProgressBar_OnClick(self, barID)
    DRAKE_SORT_ORDER = {
        addon.Enum.Drakes.WindingSlitherdrake,
        addon.Enum.Drakes.RenewedProtoDrake,
        addon.Enum.Drakes.WindborneVelocidrake,
        addon.Enum.Drakes.HighlandDrake,
        addon.Enum.Drakes.CliffsideWylderdrake,
        addon.Enum.Drakes.GrottoNetherwingDrake,
        addon.Enum.Drakes.FlourishingWhimsydrake,
        addon.Enum.Drakes.All,
    }
    
    if barID ~= 0 then
        DRAKE_SORT_ORDER = {
            DRAKE_SORT_ORDER[barID]
        }
    end
    
    selectedBarID = barID
    ManuscriptsJournal:FullRefreshIfVisible()
end

EventUtil.ContinueOnAddOnLoaded(addonName, function()
    local loaded, finished = IsAddOnLoaded(addonName)
    if not finished then return end
    
    if not ManuscriptsJournalFiltersDB then ManuscriptsJournalFiltersDB = {} end
    
    if ManuscriptsJournalFiltersDB.collected == nil then ManuscriptsJournalFiltersDB.collected = true end
    collectedManuscriptFilter = ManuscriptsJournalFiltersDB.collected
    
    if ManuscriptsJournalFiltersDB.uncollected == nil then ManuscriptsJournalFiltersDB.uncollected = true end
    uncollectedManuscriptFilter = ManuscriptsJournalFiltersDB.uncollected

    if ManuscriptsJournalFiltersDB.unusable == nil then ManuscriptsJournalFiltersDB.unusable = false end
    unusableManuscriptFilter = ManuscriptsJournalFiltersDB.unusable

    if ManuscriptsJournalFiltersDB.sourceFilter == nil then ManuscriptsJournalFiltersDB.sourceFilter = {} end
    sourceFilter = ManuscriptsJournalFiltersDB.sourceFilter
end)
