local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

-- adapted from Blizzard_Collections\Blizzard_HeirloomCollection

addon.ParentMixin = {}
local ParentMixin = addon.ParentMixin

local tab
local selectedTab = 1
function ParentMixin:OnLoad()
	self:FullRefreshIfVisible();
    if self ~= ManuscriptsJournal then return end
    
    tab = LibStub('SecureTabs-2.0'):Add(CollectionsJournal, self, self.tabName)

    tab.OnSelect = function()
        if not InCombatLockdown() then
            CollectionsJournal_SetTab(CollectionsJournal, CollectionsJournalTab4:GetID())
        end
        CollectionsJournalTitleText:SetText(self.tabName)
        HeirloomsJournalClassDropDown:Hide()
        HeirloomsJournal.progressBar:Hide()
        HeirloomsJournal.SearchBox:Hide()
        HeirloomsJournal.FilterButton:Hide()
        
        ManuscriptsSideTabsFrame:Show()
        ManuscriptsSkillLineTab1:SetChecked(selectedTab == 1)
        ManuscriptsSkillLineTab2:SetChecked(selectedTab == 2)
        ManuscriptsSkillLineTab3:SetChecked(selectedTab == 3)
        ManuscriptsSkillLineTab1:Show()
        ManuscriptsSkillLineTab3:Show()
        
        if select(2, UnitClass("player")) == "DRUID" then
            ManuscriptsSkillLineTab2:Show()
        end
        
        if selectedTab == 2 then
            RunNextFrame(function()
                ManuscriptsJournal:Hide()
            end)
            ShapeshiftsJournal:Show()
            ShapeshiftsJournal:EnableMouse(true)
        elseif selectedTab == 3 then
            RunNextFrame(function()
                ManuscriptsJournal:Hide()
            end)
            SoulshapesJournal:Show()
            SoulshapesJournal:EnableMouse(true)
        end
    end
    tab.OnDeselect = function()
        HeirloomsJournalClassDropDown:Show()
        HeirloomsJournal.progressBar:Show()
        HeirloomsJournal.SearchBox:Show()
        HeirloomsJournal.FilterButton:Show()
        ManuscriptsSideTabsFrame:Hide()
        ShapeshiftsJournal:Hide()
        SoulshapesJournal:Hide()
    end
    self.Tab = tab
    
    RunNextFrame(function()
        ManuscriptsSkillLineTab1.tooltip = self.tabName
        ManuscriptsSkillLineTab2.tooltip = ShapeshiftsJournal.tabName
        ManuscriptsSkillLineTab3.tooltip = SoulshapesJournal.tabName
        ManuscriptsSkillLineTab1:SetNormalTexture(254288)
        ManuscriptsSkillLineTab2:SetNormalTexture(136036)
        ManuscriptsSkillLineTab3:SetNormalTexture(GetSpellTexture(310143))
    end)
end

hooksecurefunc("CollectionsJournal_SetTab", function(self, tabID)
    if tabID ~= CollectionsJournalTab4:GetID() then
        ShapeshiftsJournal:Hide()
        ManuscriptsSideTabsFrame:Hide()
        SoulshapesJournal:Hide()
    end
end)

function ParentMixin:AcquireFrame(framePool, numInUse, frameType, template)
	if not framePool[numInUse] then
		framePool[numInUse] = CreateFrame(frameType, nil, self.iconsFrame, template);
	end
	return framePool[numInUse];
end

function ParentMixin:RefreshView()
	self.needsRefresh = false;

	self:RebuildLayoutData();

	self:LayoutCurrentPage();

	if self.UpdateProgressBar then
        self:UpdateProgressBar()
    end
end

function ParentMixin:UpdateButton(button)
    if button.itemID then
    	local data = addon.itemIDToDB[button.itemID]
        local item = Item:CreateFromItemID(button.itemID)

        item:ContinueOnItemLoad(function()
        	local name = item:GetItemName() 
        	local itemTexture = item:GetItemIcon()
            
            button.iconTexture:SetTexture(itemTexture);
        	button.iconTextureUncollected:SetTexture(itemTexture);
        	button.iconTextureUncollected:SetDesaturated(true);

        	button.name:SetText(name);

        	button.name:ClearAllPoints();
        	button.name:SetPoint("LEFT", button, "RIGHT", 9, 3);

        	if C_QuestLog.IsQuestFlaggedCompleted(data.questID) then
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
        end)
    elseif button.soulshapeData then
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

function ParentMixin:OnPageChanged(userAction)
	PlaySound(SOUNDKIT.IG_ABILITY_PAGE_TURN);
	if userAction then
		self:RefreshViewIfVisible();
	end
end

function ParentMixin:OnManuscriptsUpdated()
end

EventUtil.ContinueOnAddOnLoaded(addonName, function()
    local loaded, finished = IsAddOnLoaded(addonName)
    if not finished then return end
    
    -- defaults
    if not ManuscriptsJournalFiltersDB then ManuscriptsJournalFiltersDB = {} end
    
    if ManuscriptsJournalFiltersDB.collected == nil then ManuscriptsJournalFiltersDB.collected = true end
    collectedManuscriptFilter = ManuscriptsJournalFiltersDB.collected
    
    if ManuscriptsJournalFiltersDB.uncollected == nil then ManuscriptsJournalFiltersDB.uncollected = true end
    uncollectedManuscriptFilter = ManuscriptsJournalFiltersDB.uncollected

    if ManuscriptsJournalFiltersDB.unusable == nil then ManuscriptsJournalFiltersDB.unusable = false end
    unusableManuscriptFilter = ManuscriptsJournalFiltersDB.unusable

    if ManuscriptsJournalFiltersDB.sourceFilter == nil then ManuscriptsJournalFiltersDB.sourceFilter = {} end
    sourceFilter = ManuscriptsJournalFiltersDB.sourceFilter
    
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

function ManuscriptSkillLineTab_OnClick(self)
    if self == ManuscriptsSkillLineTab1 then
        ShapeshiftsJournal:Hide()
        SoulshapesJournal:Hide()
        ManuscriptsJournal:Show()
        self:SetChecked(true)
        ManuscriptsSkillLineTab2:SetChecked(false)
        ManuscriptsSkillLineTab3:SetChecked(false)
        selectedTab = 1
    elseif self == ManuscriptsSkillLineTab2 then
        ShapeshiftsJournal:Show()
        ShapeshiftsJournal:SetFrameLevel(CollectionsJournal:GetFrameLevel() + 20)
        ManuscriptsJournal:Hide()
        SoulshapesJournal:Hide()
        self:SetChecked(true)
        ManuscriptsSkillLineTab1:SetChecked(false)
        ManuscriptsSkillLineTab3:SetChecked(false)
        ShapeshiftsJournal:EnableMouse(true)
        selectedTab = 2
    elseif self == ManuscriptsSkillLineTab3 then
        SoulshapesJournal:Show()
        SoulshapesJournal:SetFrameLevel(CollectionsJournal:GetFrameLevel() + 20)
        ShapeshiftsJournal:Hide()
        ManuscriptsJournal:Hide()
        self:SetChecked(true)
        ManuscriptsSkillLineTab1:SetChecked(false)
        ManuscriptsSkillLineTab2:SetChecked(false)
        SoulshapesJournal:EnableMouse(true)
        selectedTab = 3
    end
end
