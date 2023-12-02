local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")

local collectedSoulshapeFilter = true
local uncollectedSoulshapeFilter = true
local soulshapeSoulshapeFilter = true
local crittershapeSoulshapeFilter = true
local sourceFilter = {}
local availableFilter = {}
local selectedBarID

local function SetSoulshapeSourceFilter(source, checked)
    sourceFilter[source] = checked
end

local function GetSoulshapeSourceFilter(source)
    if source == nil then
        return (sourceFilter[addon.Enum.Sources.Unknown] ~= false) -- treat 'nil' as 'true' for initial values
    end
    if sourceFilter[source] == nil then return true end
    return sourceFilter[source]
end

local function SetAllSourceFilters(checked)
    for i = 1, 99 do
        sourceFilter[i] = checked
    end
end

local function SetAllAvailableFilters(checked)
    for i = 1, 99 do
        availableFilter[i] = checked
    end
end

local function SetDefaultFilters()
    collectedSoulshapeFilter = true
    uncollectedSoulshapeFilter = true
    soulshapeSoulshapeFilter = true
    crittershapeSoulshapeFilter = true
    SoulshapesJournalFiltersDB.collected = true
    SoulshapesJournalFiltersDB.uncollected = true
    SoulshapesJournalFiltersDB.soulshape = true
    SoulshapesJournalFiltersDB.crittershape = true
    SetAllSourceFilters(true)
    SetAllAvailableFilters(true)
end

local function IsUsingDefaultFilters()
    return collectedSoulshapeFilter and uncollectedSoulshapeFilter and soulshapeSoulshapeFilter and crittershapeSoulshapeFilter
end

local function GetCollectedSoulshapeFilter()
    return collectedSoulshapeFilter
end

local function GetUncollectedSoulshapeFilter()
    return uncollectedSoulshapeFilter
end

local function GetSoulshapeSoulshapeFilter()
    return soulshapeSoulshapeFilter
end

local function GetCrittershapeSoulshapeFilter()
    return crittershapeSoulshapeFilter
end

local function GetNumSources()
    return 5
end

local sourceFilterStrings = {
    L["Loot"], L["Quest"], L["Vendor"], L["NPC"], L["World Event"],
}
local function GetSourceName(index)
    return sourceFilterStrings[index]
end

local availableFilterStrings = {
    "9.0", "9.0.5", "9.1", "9.1.5", "9.2",
}

-- adapted from Blizzard_Collections\Blizzard_HeirloomCollection

SoulshapesMixin = CreateFromMixins(addon.ParentMixin)

function SoulshapesJournal_OnShow(self)
	if self.needsRefresh then
		self:RefreshView();
	end
end

function SoulshapesJournal_OnMouseWheel(self, delta)
	self.PagingFrame:OnMouseWheel(delta);
end

local function CostFormatter(cost)
    if not (type(cost) == "table" and #cost > 0) then
        cost = { cost }
    end
    local rendered = {}
    for _, currency in ipairs(cost) do
        if currency.custom then
            table.insert(rendered, (currency.amount and currency.amount or "") .. currency.custom)
        elseif currency.gold then
            table.insert(rendered, GetCoinTextureString(currency.gold * 10000))
        else
            local info = C_CurrencyInfo.GetBasicCurrencyInfo(currency.id, currency.amount)
            table.insert(rendered, info.displayAmount .. "|T" .. info.icon .. ":0|t")
        end
    end
    return table.concat(rendered, " ")
end

local function FactionFormatter(faction)
    local name
    if faction.id then
        name = GetFactionInfoByID(faction.id)
    else
        name = faction.name
    end
    if faction.level then
        local genderSuffix = UnitSex("player") == 3 and "_FEMALE" or ""
        local levelString = _G["FACTION_STANDING_LABEL" .. faction.level .. genderSuffix]
        return string.format("%s - %s", name, levelString)
    end
end

function SoulshapesJournalSpellButton_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");

	self.UpdateTooltip = SoulshapesJournalSpellButton_OnEnter;
    
    local db = self.soulshapeData
    
    if db.loot then
        GameTooltip:AddLine("|cffffd100"..L["Loot"]..":|r "..db.loot)
    end
    if db.quest then
        GameTooltip:AddLine("|cffffd100"..L["Quest"]..":|r "..db.quest)
    end
    if db.campaignQuest then
        GameTooltip:AddLine("|cffffd100"..L["Quest"]..":|r ".."|A:quest-campaign-available:12:12|a" .. db.campaignQuest)
    end
    if db.campaign then
        GameTooltip:AddLine("|cffffd100"..L["Campaign"]..":|r "..db.campaign)
    end
    if db.worldEvent then
        GameTooltip:AddLine("|cffffd100"..L["World Event"]..":|r "..db.worldEvent)
    end
    if db.worldQuest then
        GameTooltip:AddLine("|cffffd100"..L["World Quest"]..":|r "..db.worldQuest)
    end
    if db.npc then
        GameTooltip:AddLine("|cffffd100"..L["NPC"]..":|r "..db.npc)
    end
    if db.profession then
        GameTooltip:AddLine("|cffffd100"..L["Profession"]..":|r "..db.profession)
    end
    if db.region then
        GameTooltip:AddLine("|cffffd100"..L["Region"]..":|r "..db.region)
    end
    if db.cost then
        GameTooltip:AddLine("|cffffd100"..L["Cost"]..":|r "..CostFormatter(db.cost))
    end
    if db.faction then
        GameTooltip:AddLine("|cffffd100"..L["Faction"]..":|r "..FactionFormatter(db.faction))
    end
    if db.vendor then
        local vendor = db.vendor
        if type(vendor) == "table" and #vendor > 0 then
            for _, entry in ipairs(vendor) do
                GameTooltip:AddLine("|cffffd100"..L["Vendor"]..":|r "..entry.name)
                if vendor.region then
                    GameTooltip:AddLine("|cffffd100"..L["Region"]..":|r "..entry.region)
                end
                if vendor.cost then
                    GameTooltip:AddLine("|cffffd100"..L["Cost"]..":|r "..CostFormatter(entry.cost))
                end
            end
        else
            GameTooltip:AddLine("|cffffd100"..L["Vendor"]..":|r "..vendor.name)
            if vendor.region then
                GameTooltip:AddLine("|cffffd100"..L["Region"]..":|r "..vendor.region)
            end
            if vendor.cost then
                GameTooltip:AddLine("|cffffd100"..L["Cost"]..":|r "..CostFormatter(vendor.cost))
            end
        end
    end
    if db.covenantFeature then
        GameTooltip:AddLine("|cffffd100"..L["Covenant Feature"]..":|r "..db.covenantFeature)
    end
    if db.difficulty then
        if type(db.difficulty) == "table" and #db.difficulty > 0 then
            GameTooltip:AddLine("|cffffd100"..L["Difficulty"]..":|r "..table.concat(db.difficulty, ", "))
        else
            GameTooltip:AddLine("|cffffd100"..L["Difficulty"]..":|r "..db.difficulty)
        end
    end
    if db.renown then
        GameTooltip:AddLine("|cffffd100"..L["Renown"]..":|r "..db.renown)
    end
    if db.spell then
        GameTooltip:AddLine("|cffffd100"..L["Spell"]..":|r "..db.spell)
    end
    
    if db.guide then
        local guide = db.guide
        if type(guide) == "table" and guide.text and guide.args and type(guide.args) == "table" and #guide.args > 0 then
            GameTooltip:AddLine(string.format(guide.text, unpack(guide.args)), 1, 1, 1, true)
        else
            GameTooltip:AddLine(guide, 1, 1, 1, true)
        end
    end
    
    GameTooltip:Show()
end

function SoulshapesJournalSpellButton_OnClick(self, button)
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
	function SoulshapesJournalCollectedFilterDropDown_OnLoad(self)
		UIDropDownMenu_Initialize(self, OpenCollectedFilterDropDown, "MENU");
		SoulshapesJournal:UpdateResetFiltersButtonVisibility();
	end
end

function SoulshapesMixin:OnLoad()
    self.searchText = ""

	self.soulshapeEntryFrames = {};
	self.soulshapeHeaderFrames = {};

	self.soulshapeLayoutData = {};

    self.numKnownSoulshapes = 0
    self.numPossibleSoulshapes = 0
    
    self.tabName = L["TAB_TITLE"]
    
    addon.ParentMixin.OnLoad(self)
end

function SoulshapesMixin:FullRefreshIfVisible()
	self.needsDataRebuilt = true;
	self:RefreshViewIfVisible();
end

function SoulshapesMixin:RefreshViewIfVisible()
	if self:IsVisible() then
		self:RefreshView();
	else
		self.needsRefresh = true;
	end
end

function SoulshapesMixin:RebuildLayoutData()
	if not self.needsDataRebuilt then
		return;
	end
	self.needsDataRebuilt = false;

	self.soulshapeLayoutData = {};

    self.numKnownSoulshapes = 0
    self.numPossibleSoulshapes = 0

	local equipBuckets = self:SortSoulshapesIntoEquipmentBuckets();
	self:SortEquipBucketsIntoPages(equipBuckets);
	self.PagingFrame:SetMaxPages(math.max(#self.soulshapeLayoutData, 1));
end

function SoulshapesMixin:SortSoulshapesIntoEquipmentBuckets()
	-- Sort them into equipment buckets
	local equipBuckets = {};
    
    for _, soulshapeData in pairs(addon.soulshapeDB) do
        local collected = (not soulshapeData.questID) or C_QuestLog.IsQuestFlaggedCompleted(soulshapeData.questID)
        
        local include = false
        if collected and collectedSoulshapeFilter then include = true end
        if (not collected) and uncollectedSoulshapeFilter then include = true end
        
        if include then
            include = false
            if (not soulshapeData.critter) and soulshapeSoulshapeFilter then include = true end
            if soulshapeData.critter and crittershapeSoulshapeFilter then include = true end
        end
        
        if include and (self.searchText ~= "") then
            include = false
            if soulshapeData.name and string.lower(soulshapeData.name):find(string.lower(self.searchText)) then
                include = true
            end
        end
        
        if include then
            if soulshapeData.loot and not GetSoulshapeSourceFilter(1) then
                include = false
            elseif soulshapeData.quest and not GetSoulshapeSourceFilter(2) then
                include = false
            elseif soulshapeData.vendor and not GetSoulshapeSourceFilter(3) then
                include = false
            elseif soulshapeData.npc and not GetSoulshapeSourceFilter(4) then
                include = false
            elseif soulshapeData.worldEvent and not GetSoulshapeSourceFilter(5) then
                include = false
            end
        end
        
        if include then
			if not equipBuckets[1] then
				equipBuckets[1] = {}
			end

			table.insert(equipBuckets[1], soulshapeData)

            if collected then
                self.numKnownSoulshapes = self.numKnownSoulshapes + 1
			end
			self.numPossibleSoulshapes = self.numPossibleSoulshapes + 1
        end
	end

	return equipBuckets;
end

-- Each soulshape button entry dimension
local BUTTON_WIDTH = 208;
local BUTTON_HEIGHT = 50;

-- Padding around each soulshape button
local BUTTON_PADDING_X = 0;
local BUTTON_PADDING_Y = 16;

-- The total height of a soulshape header
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

function SoulshapesMixin:SortEquipBucketsIntoPages(equipBuckets)
	if not next(equipBuckets) then
		return;
	end

	local currentPage = {};
	local pageHeight = VIEW_MODE_FULL_PAGE_HEIGHT
	local heightLeft = pageHeight;
	local widthLeft = PAGE_WIDTH;

	local equipBucket = equipBuckets[1];

	if equipBucket then
		-- Add buttons
		for i, soulshapeData in ipairs(equipBucket) do
			if widthLeft < BUTTON_WIDTH + BUTTON_PADDING_X then
				-- Not enough room for another entry, try going to a new row
				widthLeft = PAGE_WIDTH;

				if heightLeft < BUTTON_HEIGHT + BUTTON_PADDING_Y then
					-- Not enough room for another row of entries, move to next page
					table.insert(self.soulshapeLayoutData, currentPage);

					heightLeft = pageHeight - HEADER_HEIGHT;
					currentPage = {};
				else
					-- Room for another row
					table.insert(currentPage, NEW_ROW_OPCODE);
					heightLeft = heightLeft - BUTTON_HEIGHT - BUTTON_PADDING_Y;
				end
			end

			widthLeft = widthLeft - BUTTON_WIDTH - BUTTON_PADDING_X;
			table.insert(currentPage, soulshapeData);
		end
	end

	table.insert(self.soulshapeLayoutData, currentPage);
end

function SoulshapesMixin:LayoutCurrentPage()
	local pageLayoutData = self.soulshapeLayoutData[self.PagingFrame:GetCurrentPage()];

	local numEntriesInUse = 0;

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
			else
				-- Entry
				numEntriesInUse = numEntriesInUse + 1;
				local entry = self:AcquireFrame(self.soulshapeEntryFrames, numEntriesInUse, "CHECKBUTTON", "SoulshapeSpellButtonTemplate");
				entry.soulshapeData = layoutData;

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

	addon.ActivatePooledFrames(self.soulshapeEntryFrames, numEntriesInUse);
end

function SoulshapesMixin:UpdateProgressBar()
	self.progressBar:SetMinMaxValues(0, self.numPossibleSoulshapes);
	self.progressBar:SetValue(self.numKnownSoulshapes);
	self.progressBar.text:SetFormattedText(L["MANUSCRIPTS_PROGRESS_FORMAT"], self.numKnownSoulshapes, self.numPossibleSoulshapes);
end

function SoulshapesMixin:SetCollectedSoulshapeFilter(checked)
    assert(type(checked) == "boolean")
	collectedSoulshapeFilter = checked
    SoulshapesJournalFiltersDB.collected = checked
	self:FullRefreshIfVisible();
end

function SoulshapesMixin:SetUncollectedSoulshapeFilter(checked)
    assert(type(checked) == "boolean")
    uncollectedSoulshapeFilter = checked
    SoulshapesJournalFiltersDB.uncollected = checked
	self:FullRefreshIfVisible();
end

function SoulshapesMixin:SetSoulshapeSoulshapeFilter(checked)
    assert(type(checked) == "boolean")
    soulshapeSoulshapeFilter = checked
    SoulshapesJournalFiltersDB.soulshape = checked
    self:FullRefreshIfVisible()
end

function SoulshapesMixin:SetCrittershapeSoulshapeFilter(checked)
    assert(type(checked) == "boolean")
    crittershapeSoulshapeFilter = checked
    SoulshapesJournalFiltersDB.crittershape = checked
    self:FullRefreshIfVisible()
end

function SoulshapesMixin:SetSourceChecked(source, checked)
	if self:IsSourceChecked(source) ~= checked then
		SetSoulshapeSourceFilter(source, checked);

		self:FullRefreshIfVisible();
	end
end

function SoulshapesMixin:IsSourceChecked(source)
	return GetSoulshapeSourceFilter(source)
end

function SoulshapesMixin:SetAllSourcesChecked(checked)
	SetAllSourceFilters(checked)

	self:FullRefreshIfVisible();
	LibDD:UIDropDownMenu_Refresh(self.filterDropDown, L_UIDROPDOWNMENU_MENU_VALUE, L_UIDROPDOWNMENU_MENU_LEVEL);
end

function SoulshapesMixin:ResetFilters()
	SetDefaultFilters()
	self.FilterButton.ResetButton:Hide();

	self:FullRefreshIfVisible();
end

function SoulshapesMixin:UpdateResetFiltersButtonVisibility()
	self.FilterButton.ResetButton:SetShown(not IsUsingDefaultFilters());
end

function SoulshapesMixin:OpenCollectedFilterDropDown(level)
	local filterSystem = {
		onUpdate = function() self:UpdateResetFiltersButtonVisibility() end,
		filters = {
			{ type = FilterComponent.Checkbox, text = COLLECTED, set = function(value) SoulshapesJournal:SetCollectedSoulshapeFilter(value) end, isSet = GetCollectedSoulshapeFilter },
			{ type = FilterComponent.Checkbox, text = NOT_COLLECTED, set = function(value) SoulshapesJournal:SetUncollectedSoulshapeFilter(value) end, isSet = GetUncollectedSoulshapeFilter },
            
            { type = FilterComponent.Checkbox, text = L["Soulshape"], set = function(value) SoulshapesJournal:SetSoulshapeSoulshapeFilter(value) end, isSet = GetSoulshapeSoulshapeFilter },
            { type = FilterComponent.Checkbox, text = L["Crittershape"], set = function(value) SoulshapesJournal:SetCrittershapeSoulshapeFilter(value) end, isSet = GetCrittershapeSoulshapeFilter },
			
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

function SoulshapesJournalSearchBox_OnTextChanged(self)
	SearchBoxTemplate_OnTextChanged(self);
	self:GetParent().searchText = self:GetText()
	SoulshapesJournal:FullRefreshIfVisible();
end

function SoulshapesJournalProgressBar_OnClick(self, barID)
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
    SoulshapesJournal:FullRefreshIfVisible()
end

function SoulshapesMixin:UpdateButton(button)
    if button.soulshapeData then
        local data = button.soulshapeData
        button.iconTexture:SetTexture(data.icon)
        button.iconTextureUncollected:SetTexture(data.icon)
        button.iconTextureUncollected:SetDesaturated(true)
        
        button.name:SetText(data.name)
        
        button.name:ClearAllPoints()
        button.name:SetPoint("LEFT", button, "RIGHT", 9, 3)
        
        if (not data.questID) or C_QuestLog.IsQuestFlaggedCompleted(data.questID) then
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

EventUtil.ContinueOnAddOnLoaded(addonName, function()
    local loaded, finished = IsAddOnLoaded(addonName)
    if not finished then return end
    
    if not SoulshapesJournalFiltersDB then SoulshapesJournalFiltersDB = {} end
    
    if SoulshapesJournalFiltersDB.collected == nil then SoulshapesJournalFiltersDB.collected = true end
    collectedSoulshapeFilter = SoulshapesJournalFiltersDB.collected
    
    if SoulshapesJournalFiltersDB.uncollected == nil then SoulshapesJournalFiltersDB.uncollected = true end
    uncollectedSoulshapeFilter = SoulshapesJournalFiltersDB.uncollected

    if SoulshapesJournalFiltersDB.soulshape == nil then SoulshapesJournalFiltersDB.soulshape = true end
    soulshapeSoulshapeFilter = SoulshapesJournalFiltersDB.soulshape

    if SoulshapesJournalFiltersDB.crittershape == nil then SoulshapesJournalFiltersDB.crittershape = true end
    crittershapeSoulshapeFilter = SoulshapesJournalFiltersDB.crittershape
end)
