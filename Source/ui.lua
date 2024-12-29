local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")
local FilterComponent = addon.FilterComponent

-- adapted from Blizzard_Collections\Blizzard_HeirloomCollection

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

local class = select(2, UnitClass("player"))

local ParentMixin = {}
addon.ParentMixin = ParentMixin

ParentMixin.collectedFilter = true
ParentMixin.uncollectedFilter = true
ParentMixin.unusableFilter = false
ParentMixin.sourceFilter = {}

function ParentMixin:SetSourceFilter(source, checked)
    self.sourceFilter[source] = checked
end

function ParentMixin:GetSourceFilter(source)
    if source == nil then
        -- treat 'nil' as 'true' for initial values
        return (self.sourceFilter[addon.Enum.Sources.Unknown] ~= false)
    end
    if self.sourceFilter[source] == nil then
        return true
    end
    return self.sourceFilter[source]
end

function ParentMixin:SetAllSourceFilters(checked)
    for i = 1, 99 do
        self.sourceFilter[i] = checked
    end
end

function ParentMixin:SetDefaultFilters()
    self.collectedFilter = true
    self.uncollectedFilter = true
    self.unusableFilter = false
    
    local db = self:GetFilterDB()
    db.collected = true
    db.uncollected = true
    db.unusable = false
    
    self:SetAllSourceFilters(true)
end

function ParentMixin:IsUsingDefaultFilters()
    if not (self.collectedFilter and self.uncollectedFilter and (not self.unusableFilter)) then return false end
    
    for i = 1, 99 do
        if self.sourceFilter[i] == false then
             return false
        end
    end
    return true
end

function ParentMixin:GetCollectedFilter()
    return self.collectedFilter
end

function ParentMixin:GetUncollectedFilter()
    return self.uncollectedFilter
end

function ParentMixin:GetUnusableFilter()
    return unusableFilter
end

function ParentMixin:SetCollectedFilter(checked)
    assert(type(checked) == "boolean")
	self.collectedFilter = checked
    self:GetFilterDB().collected = checked
	self:FullRefreshIfVisible();
end

function ParentMixin:SetUncollectedFilter(checked)
    assert(type(checked) == "boolean")
    self.uncollectedFilter = checked
    self.GetFilterDB().uncollected = checked
	self:FullRefreshIfVisible();
end

function ParentMixin:SetUnusableFilter(checked)
    assert(type(checked) == "boolean")
    self.unusableFilter = checked
    self.GetFilterDB().unusable = checked
    self:FullRefreshIfVisible()
end

function ParentMixin:SetSourceChecked(source, checked)
	if self:IsSourceChecked(source) ~= checked then
		self:SetSourceFilter(source, checked);

		self:FullRefreshIfVisible();
	end
end

function ParentMixin:IsSourceChecked(source)
	return self:GetSourceFilter(source)
end

function ParentMixin:SetAllSourcesChecked(checked)
	self:SetAllSourceFilters(checked)

	self:FullRefreshIfVisible();
	LibDD:UIDropDownMenu_Refresh(self.filterDropDown, L_UIDROPDOWNMENU_MENU_VALUE, L_UIDROPDOWNMENU_MENU_LEVEL);
end

function ParentMixin:ResetFilters()
	self:SetDefaultFilters()
	self.FilterButton.ResetButton:Hide();

	self:FullRefreshIfVisible();
end

function ParentMixin:UpdateResetFiltersButtonVisibility()
    RunNextFrame(function()
        self.FilterButton.ResetButton:SetShown(not self:IsUsingDefaultFilters());
    end)
end

function ParentMixin:OpenCollectedFilterDropDown(level)
	local filterSystem = {
		onUpdate = function() self:UpdateResetFiltersButtonVisibility() end,
		filters = {
			{ type = FilterComponent.Checkbox, text = COLLECTED, set = function(value) self:SetCollectedFilter(value) end, isSet = function() return self:GetCollectedFilter() end },
			{ type = FilterComponent.Checkbox, text = NOT_COLLECTED, set = function(value) self:SetUncollectedFilter(value) end, isSet = function() return self:GetUncollectedFilter() end },
            { type = FilterComponent.Checkbox, text = MOUNT_JOURNAL_FILTER_UNUSABLE, set = function(value) self:SetUnusableFilter(value) end, isSet = function() return self:GetUnusableFilter() end },
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
					  numFilters = function() return self:GetNumSources() end,
					  nameFunction = function(index) return self:GetSourceName(index) end,
					},
				},
			},
		},
		}
	};

	addon.FilterDropDownSystem.Initialize(self, filterSystem, level);
end

function ParentMixin:GetNumSources()
    return #addon.Strings.Sources
end

function ParentMixin:GetSourceName(index)
    return addon.Strings.Sources[index]
end

function ParentMixin:HideHeirloomsExtras()
    HeirloomsJournal.ClassDropdown:Hide()
    HeirloomsJournal.progressBar:Hide()
    HeirloomsJournal.SearchBox:Hide()
    HeirloomsJournal.FilterDropdown:Hide()
end

function ParentMixin:ShowHeirloomsExtras()
    HeirloomsJournal.ClassDropdown:Show()
    HeirloomsJournal.progressBar:Show()
    HeirloomsJournal.SearchBox:Show()
    HeirloomsJournal.FilterDropdown:Show()
end

-- Overload in child mixins that use categories
function ParentMixin:GetNumCategories()
    return 1
end

-- Overload in child mixins that use categories
function ParentMixin:GetAllCategory()
    return
end

function ParentMixin:GetSortOrder()
    return {1}
end

local tab
local selectedTab = 1
function ParentMixin:OnLoad()
    if self.usesSearch then
        self.searchText = ""
    end

    self.entryFrames = {};
	self.headerFrames = {};
	self.layoutData = {};
    
    if not self.numKnownEntries then self.numKnownEntries = {} end
    if not self.numPossibleEntries then self.numPossibleEntries = {} end
    
    local sortOrder = self:GetSortOrder()
    for i = 1, self:GetNumCategories() do
        if i ~= self:GetAllCategory() then
            self.numKnownEntries[i] = 0
            self.numPossibleEntries[i] = 0
            
            if self.usesBars then
                local drake = sortOrder[i]
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
    end
    
    self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    
	self:FullRefreshIfVisible();
    if self ~= ManuscriptsJournal then return end
    
    local function runOutOfCombat()
        ManuscriptsJournalInsecureTabButton = LibStub('SecureTabs-2.0'):Add(CollectionsJournal, self, self.tabName)
        tab = ManuscriptsJournalInsecureTabButton
        local secureTabButton = CreateFrame("Button", nil, CollectionsJournal, "SecureActionButtonTemplate")
        secureTabButton:SetAttribute("type", "click")
        secureTabButton:SetAttribute("clickbutton", CollectionsJournalTab4)
        secureTabButton:SetPoint("TOPLEFT", tab, "TOPLEFT")
        secureTabButton:SetPoint("BOTTOMRIGHT", tab, "BOTTOMRIGHT")
        secureTabButton:RegisterForClicks("AnyDown")
        
        secureTabButton:HookScript("OnClick", function()
            tab:Click()
            if selectedTab ~= ManuscriptsSkillLineManuscriptsTab:GetID() then
                ManuscriptsJournal:Hide()
            end
        end)
        tab:SetPassThroughButtons("LeftButton")
        tab.Enable = nop
        tab.Disable = nop
        
        tab.OnSelect = function()
            tab.LeftHighlight:Hide()
            tab.MiddleHighlight:Hide()
            tab.RightHighlight:Hide()
            tab:SetHighlightLocked(true)
            
            CollectionsJournalTitleText:SetText(self.tabName)
            self:HideHeirloomsExtras()
            
            ManuscriptsSideTabsFrame:Show()
            for _, tab in pairs(self:GetAllTabs()) do
                tab:SetChecked(selectedTab == tab:GetID())
            end
            
            if (selectedTab == 2) and (class == "DRUID") then
                ShapeshiftsJournal:Show()
                ShapeshiftsJournal:EnableMouse(true)
            elseif selectedTab == 3 then
                SoulshapesJournal:Show()
                SoulshapesJournal:EnableMouse(true)
            elseif (selectedTab == 4) and (class == "SHAMAN") then
                HexTomesJournal:Show()
                HexTomesJournal:EnableMouse(true)
            elseif (selectedTab == 5) and (class == "MAGE") then
                PolymorphsJournal:Show()
                PolymorphsJournal:EnableMouse(true)
            elseif (selectedTab == 6) and (class == "WARLOCK") then
                GrimoiresJournal:Show()
                GrimoiresJournal:EnableMouse(true)
            elseif (selectedTab == 7) and (class == "HUNTER") then
                TameTomesJournal:Show()
                TameTomesJournal:EnableMouse(true)
            elseif selectedTab == 8 then
                DirigibleJournal:Show()
                DirigibleJournal:EnableMouse(true)
            end
        end
        tab.OnDeselect = function()
            tab.LeftHighlight:Show()
            tab.MiddleHighlight:Show()
            tab.RightHighlight:Show()
            tab:SetHighlightLocked(false)
            
            local selectedTabID = CollectionsJournal_GetTab(CollectionsJournal)
            CollectionsJournalTitleText:SetText(_G["CollectionsJournalTab"..selectedTabID]:GetText())
            self:ShowHeirloomsExtras()
            ManuscriptsSideTabsFrame:Hide()
            ShapeshiftsJournal:Hide()
            SoulshapesJournal:Hide()
            HexTomesJournal:Hide()
            PolymorphsJournal:Hide()
            GrimoiresJournal:Hide()
            TameTomesJournal:Hide()
            DirigibleJournal:Hide()
        end
        self.Tab = tab
        
        RunNextFrame(function()
            if InCombatLockdown() then
                EventUtil.RegisterOnceFrameEventAndCallback("PLAYER_REGEN_ENABLED", function()
                    for _, panel in pairs(self:GetAllPanels()) do
                        panel:SetPassThroughButtons("LeftButton")
                    end
                end)
                return
            end
            for _, panel in pairs(self:GetAllPanels()) do
                panel:SetPassThroughButtons("LeftButton")
            end
        end)
    end
    
    if InCombatLockdown() then
        EventUtil.RegisterOnceFrameEventAndCallback("PLAYER_REGEN_ENABLED", runOutOfCombat)
        return
    end
    runOutOfCombat()
    
    RunNextFrame(function()
        ManuscriptsSkillLineManuscriptsTab.tooltip = self.tabName
        ManuscriptsSkillLineDruidTab.tooltip = ShapeshiftsJournal.tabName
        ManuscriptsSkillLineSoulshapesTab.tooltip = SoulshapesJournal.tabName
        ManuscriptsSkillLineShamanTab.tooltip = HexTomesJournal.tabName
        ManuscriptsSkillLineMageTab.tooltip = PolymorphsJournal.tabName
        ManuscriptsSkillLineWarlockTab.tooltip = GrimoiresJournal.tabName
        ManuscriptsSkillLineHunterTab.tooltip = TameTomesJournal.tabName
        ManuscriptsSkillLineDirigibleTab.tooltip = DirigibleJournal.tabName
        
        ManuscriptsSkillLineManuscriptsTab:SetNormalTexture(254288)
        ManuscriptsSkillLineDruidTab:SetNormalTexture(136036)
        ManuscriptsSkillLineSoulshapesTab:SetNormalTexture(C_Spell.GetSpellTexture(310143))
        ManuscriptsSkillLineShamanTab:SetNormalTexture(C_Spell.GetSpellTexture(51514))
        ManuscriptsSkillLineMageTab:SetNormalTexture(C_Spell.GetSpellTexture(118))
        ManuscriptsSkillLineWarlockTab:SetNormalTexture(C_Spell.GetSpellTexture(688))
        ManuscriptsSkillLineHunterTab:SetNormalTexture(C_Spell.GetSpellTexture(1515))
        ManuscriptsSkillLineDirigibleTab:SetNormalTexture(6029241)
        
        ManuscriptsSkillLineManuscriptsTab:Show()
        
        if class == "DRUID" then
            ManuscriptsSkillLineDruidTab:Show()
            ManuscriptsSkillLineSoulshapesTab:SetPoint("TOPLEFT", ManuscriptsSkillLineDruidTab, "BOTTOMLEFT", 0, -17)
        elseif class == "SHAMAN" then
            ManuscriptsSkillLineShamanTab:Show()
            ManuscriptsSkillLineSoulshapesTab:SetPoint("TOPLEFT", ManuscriptsSkillLineShamanTab, "BOTTOMLEFT", 0, -17)
        elseif class == "MAGE" then
            ManuscriptsSkillLineMageTab:Show()
            ManuscriptsSkillLineSoulshapesTab:SetPoint("TOPLEFT", ManuscriptsSkillLineMageTab, "BOTTOMLEFT", 0, -17)
        elseif class == "WARLOCK" then
            ManuscriptsSkillLineWarlockTab:Show()
            ManuscriptsSkillLineSoulshapesTab:SetPoint("TOPLEFT", ManuscriptsSkillLineWarlockTab, "BOTTOMLEFT", 0, -17)
        elseif class == "HUNTER" then
            ManuscriptsSkillLineHunterTab:Show()
            ManuscriptsSkillLineSoulshapesTab:SetPoint("TOPLEFT", ManuscriptsSkillLineHunterTab, "BOTTOMLEFT", 0, -17)
        end
        
        if C_Covenants.GetActiveCovenantID() == 3 then
            ManuscriptsSkillLineSoulshapesTab:Show()
        end
        
        ManuscriptsSkillLineDirigibleTab:Show()
        
        local tabs = self:GetAllTabs()
        local filteredTabs = {}
        for _, tab in ipairs(tabs) do
            if tab:IsShown() then
                table.insert(filteredTabs, tab)
            end
        end
        table.sort(filteredTabs, function(a, b)
            return a:GetID() < b:GetID()
        end)
        filteredTabs[1]:SetPoint("TOPLEFT", ManuscriptsSideTabsFrame, "TOPRIGHT", 0, -36)
        for i, tab in ipairs(filteredTabs) do
            if i > 1 then
                tab:SetPoint("TOPLEFT", filteredTabs[i-1], "BOTTOMLEFT", 0, -17)
            end
        end
    end)
end

hooksecurefunc("CollectionsJournal_SetTab", function(self, tabID)
    if (tabID ~= CollectionsJournalTab4:GetID()) and not tContains(ParentMixin:GetAllPanels(), self.Tabs[tabID or 1].frame) then
        ManuscriptsSideTabsFrame:Hide()
        for _, journal in pairs(ParentMixin:GetAllPanels()) do
            journal:Hide()
        end
        ParentMixin:ShowHeirloomsExtras()
        
        if tab then
            tab.LeftHighlight:Show()
            tab.MiddleHighlight:Show()
            tab.RightHighlight:Show()
            tab:SetHighlightLocked(false)
        end
    end
end)

function ParentMixin:AcquireFrame(framePool, numInUse, frameType, template)
	if not framePool[numInUse] then
		framePool[numInUse] = CreateFrame(frameType, nil, self.iconsFrame, template);
	end
	return framePool[numInUse];
end

function ParentMixin:FullRefreshIfVisible()
	self.needsDataRebuilt = true;
	self:RefreshViewIfVisible();
end

function ParentMixin:RefreshViewIfVisible()
	if self:IsVisible() then
		self:RefreshView();
	else
		self.needsRefresh = true;
	end
end

function ParentMixin:RefreshView()
	self.needsRefresh = false;

	self:RebuildLayoutData();

	self:LayoutCurrentPage();

	if self.UpdateProgressBar then
        self:UpdateProgressBar()
    end
end

function ParentMixin:RebuildLayoutData()
	if not self.needsDataRebuilt then
		return;
	end
	self.needsDataRebuilt = false;

	self.layoutData = {};

    for i = 1, self:GetNumCategories() do
        self.numKnownEntries[i] = 0
        self.numPossibleEntries[i] = 0
    end

	local equipBuckets = self:SortEntriesIntoEquipmentBuckets();
	self:SortEquipBucketsIntoPages(equipBuckets);
	self.PagingFrame:SetMaxPages(math.max(#self.layoutData, 1));
end

function ParentMixin:SortEntriesIntoEquipmentBuckets()
	-- Sort them into equipment buckets
	local equipBuckets = {};
    
    for _, entryData in pairs(self:GetEntryDB()) do
        local collected = self:IsCollected(entryData)
        
        local include = false
        
        if not self.usesSourceFilter then
            include = true
        else
            if collected and self.collectedFilter then include = true end
            if entryData.source and (not collected) and (not entryData.unobtainable) and self.uncollectedFilter then include = true end
            if (not collected) and self.unusableFilter and ((not entryData.source) or entryData.unobtainable) then include = true end

            if include and (self.searchText ~= "") then
                include = false
                local name = GetItemInfo(entryData.itemID)
                local source = addon.Strings.Sources[entryData.source]
                
                if name and string.lower(name):find(string.lower(self.searchText)) then
                    include = true
                elseif source and string.lower(source):find(string.lower(self.searchText)) then
                    include = true
                elseif entryData.rareNames then
                    for _, name in pairs(entryData.rareNames) do
                        if string.lower(name):find(string.lower(self.searchText)) then
                            include = true
                        end
                    end
                end
            end

            if include and (not self:GetSourceFilter(entryData.source)) then
                include = false
            end
        end
            
        if include then
            local category = entryData.category
            if not category then category = 1 end
  			if not equipBuckets[category] then
  				equipBuckets[category] = {}
  			end

  			table.insert(equipBuckets[category], entryData)

              if collected then
                  self.numKnownEntries[category] = self.numKnownEntries[category] + 1
  			end
  			self.numPossibleEntries[category] = self.numPossibleEntries[category] + 1
        end
	end

	return equipBuckets
end

function ParentMixin:SortEquipBucketsIntoPages(equipBuckets)
	if not next(equipBuckets) then
		return;
	end

	local currentPage = {};
	local pageHeight = VIEW_MODE_FULL_PAGE_HEIGHT
	local heightLeft = pageHeight;
	local widthLeft = PAGE_WIDTH;

	for _, category in ipairs(self:GetSortOrder()) do
		local equipBucket = equipBuckets[category];

		if equipBucket then
    		if self.usesHeader then
                if heightLeft < HEADER_HEIGHT + BUTTON_PADDING_Y + BUTTON_HEIGHT then
        			-- Not enough room to add the upcoming header for this bucket, move to next page
        			table.insert(self.layoutData, currentPage);
        			heightLeft = pageHeight;
        			currentPage = {};
        		end

        		-- Add header
        		table.insert(currentPage, self:GetCategoryStrings()[category])
        		if #currentPage > 1 then
        			heightLeft = heightLeft - ADDITIONAL_HEADER_Y_PADDING - BUTTON_HEIGHT - BUTTON_PADDING_Y;
        		else
        			heightLeft = heightLeft - FIRST_HEADER_Y_PADDING;
        		end

        		widthLeft = PAGE_WIDTH;
        		heightLeft = heightLeft - HEADER_HEIGHT;
            end
            
			-- Add buttons
			for i, data in ipairs(equipBucket) do
				if widthLeft < BUTTON_WIDTH + BUTTON_PADDING_X then
					-- Not enough room for another entry, try going to a new row
					widthLeft = PAGE_WIDTH;

					if heightLeft < BUTTON_HEIGHT + BUTTON_PADDING_Y then
						-- Not enough room for another row of entries, move to next page
						table.insert(self.layoutData, currentPage);

						heightLeft = pageHeight - HEADER_HEIGHT;
						currentPage = {};
					else
						-- Room for another row
						table.insert(currentPage, NEW_ROW_OPCODE);
						heightLeft = heightLeft - BUTTON_HEIGHT - BUTTON_PADDING_Y;
					end
				end

				widthLeft = widthLeft - BUTTON_WIDTH - BUTTON_PADDING_X;
				table.insert(currentPage, data);
			end
		end
	end

	table.insert(self.layoutData, currentPage);
end

function ParentMixin:LayoutCurrentPage()
	local pageLayoutData = self.layoutData[self.PagingFrame:GetCurrentPage()];

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
				local header = self:AcquireFrame(self.headerFrames, numHeadersInUse, "FRAME", "ManuscriptHeaderTemplate");
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
				local entry = self:AcquireFrame(self.entryFrames, numEntriesInUse, "CHECKBUTTON", self.spellButtonTemplate or "ManuscriptSpellButtonTemplate");
				entry.layoutData = layoutData;

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

	addon.ActivatePooledFrames(self.entryFrames, numEntriesInUse);
	addon.ActivatePooledFrames(self.headerFrames, numHeadersInUse);
end

function ParentMixin:IsCollected(data)
    return C_QuestLog.IsQuestFlaggedCompleted(data.questID)
end

function ParentMixin:UpdateButton(button)
    local data, name, texture
    
    local function runLater()
        button.SwatchTexture:Hide()
        
        if texture then
            button.iconTexture:SetTexture(texture);
    	   button.iconTextureUncollected:SetTexture(texture);
        end
    	button.iconTextureUncollected:SetDesaturated(true);

    	button.name:SetText(name);

    	button.name:ClearAllPoints();
    	button.name:SetPoint("LEFT", button, "RIGHT", 9, 3);
        
        if self:IsCollected(data) then
    		if self == ManuscriptsJournal then
                if not ManuscriptsJournal:GetCollectedFilter() then
                    self:FullRefreshIfVisible()
                end
            end
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

    data = button.layoutData
    if data.itemID then
        local item = Item:CreateFromItemID(data.itemID)

        item:ContinueOnItemLoad(function()
        	name = item:GetItemName() 
        	texture = item:GetItemIcon()
            runLater()
        end)
    elseif data.spellID then
        local info = C_Spell.GetSpellInfo(data.spellID)
        name = info.name
        texture = info.iconID
        runLater()
    elseif data.artifactID then
        local artifactAppearanceSetID, artifactAppearanceID, appearanceName, displayIndex, unlocked, failureDescription, uiCameraID, altHandCameraID, swatchColorR, swatchColorG, swatchColorB, modelOpacity, modelSaturation, obtainable = C_ArtifactUI.GetAppearanceInfoByID(data.artifactID)
        
        name = appearanceName
        runLater()
        
        button.iconTexture:Hide()
        button.iconTextureUncollected:Hide()
        button.SwatchTexture:Show()
        
        button.SwatchTexture:SetVertexColor(swatchColorR, swatchColorG, swatchColorB, unlocked and 1.0 or .5)
    elseif data.icon then
        texture = data.icon
        name = data.name
        if type(name) == "function" then
            name = name()
        end
        data = data
        
        runLater()
    end
end

function ParentMixin:OnPageChanged(userAction)
	PlaySound(SOUNDKIT.IG_ABILITY_PAGE_TURN);
	if userAction then
		self:RefreshViewIfVisible();
	end
end

function ParentMixin:OnManuscriptsUpdated()
end

EventUtil.ContinueOnAddOnLoaded(addonName, function()
    local loaded, finished = C_AddOns.IsAddOnLoaded(addonName)
    if not finished then return end
    
    local ticker
    ticker = C_Timer.NewTicker(5, function()
        -- these are sometimes not available yet on login, so lets query them again
        addon.Strings.Sources[13] = C_QuestLog.GetTitleForQuestID(75887)
        addon.Strings.Sources[18] = C_QuestLog.GetTitleForQuestID(78203)
        
        if addon.Strings.Sources[13] and addon.Strings.Sources[18] then
            ticker:Cancel()
        end
    end)
end)

function addon.ActivatePooledFrames(framePool, numEntriesInUse)
	for i = 1, numEntriesInUse do
		framePool[i]:Show();
	end

	for i = numEntriesInUse + 1, #framePool do
		framePool[i]:Hide();
	end
end

local function deselectAndHideAll()
    for _, tab in pairs(ParentMixin:GetAllTabs()) do
        tab:SetChecked(false)
    end
    for _, panel in pairs(ParentMixin:GetAllPanels()) do
        panel:Hide()
    end
end    

function ManuscriptSkillLineTab_OnClick(self)
    deselectAndHideAll()
    selectedTab = self:GetID()
    self:SetChecked(true)
    
    local page = ParentMixin:GetPanelByTab(self)
    page:Show()
    page:SetFrameLevel(CollectionsJournal:GetFrameLevel() + 20)
    page:EnableMouse(true)
end

hooksecurefunc("ToggleCollectionsJournal", function(tab)
    if tab ~= nil then return end
    if not CollectionsJournal then return end
    if not CollectionsJournal:IsShown() then return end
    for _, panel in pairs(ParentMixin:GetAllPanels()) do
        if panel:IsShown() then
            CollectionsJournalTitleText:SetText(ManuscriptsJournal.tabName)
            return
        end
    end
end)

function ParentMixin:GetAllPanels()
    return {ManuscriptsJournal, ShapeshiftsJournal, SoulshapesJournal, HexTomesJournal, PolymorphsJournal, GrimoiresJournal, TameTomesJournal, DirigibleJournal}
end

function ParentMixin:GetAllTabs()
    return {ManuscriptsSkillLineManuscriptsTab, ManuscriptsSkillLineDruidTab, ManuscriptsSkillLineSoulshapesTab, ManuscriptsSkillLineShamanTab, ManuscriptsSkillLineMageTab, ManuscriptsSkillLineWarlockTab, ManuscriptsSkillLineHunterTab, ManuscriptsSkillLineDirigibleTab}
end

function ParentMixin:GetPanelByTab(tab)
    local panels = {
        [ManuscriptsSkillLineManuscriptsTab] = ManuscriptsJournal, 
        [ManuscriptsSkillLineDruidTab] = ShapeshiftsJournal, 
        [ManuscriptsSkillLineSoulshapesTab] = SoulshapesJournal, 
        [ManuscriptsSkillLineShamanTab] = HexTomesJournal, 
        [ManuscriptsSkillLineMageTab] = PolymorphsJournal, 
        [ManuscriptsSkillLineWarlockTab] = GrimoiresJournal,
        [ManuscriptsSkillLineHunterTab] = TameTomesJournal,
        [ManuscriptsSkillLineDirigibleTab] = DirigibleJournal,
    }
    return panels[tab]
end
