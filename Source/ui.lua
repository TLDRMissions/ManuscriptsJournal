local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

-- adapted from Blizzard_Collections\Blizzard_HeirloomCollection

local class = select(2, UnitClass("player"))

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
        ManuscriptsSkillLineManuscriptsTab:SetChecked(selectedTab == 1)
        ManuscriptsSkillLineDruidTab:SetChecked(selectedTab == 2)
        ManuscriptsSkillLineSoulshapesTab:SetChecked(selectedTab == 3)
        ManuscriptsSkillLineShamanTab:SetChecked(selectedTab == 4)
        ManuscriptsSkillLineMageTab:SetChecked(selectedTab == 5)
        
        if (selectedTab == 2) and (class == "DRUID") then
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
        elseif (selectedTab == 4) and (class == "SHAMAN") then
            RunNextFrame(function()
                ManuscriptsJournal:Hide()
            end)
            HexTomesJournal:Show()
            HexTomesJournal:EnableMouse(true)
        elseif (selectedTab == 5) and (class == "MAGE") then
            RunNextFrame(function()
                ManuscriptsJournal:Hide()
            end)
            PolymorphsJournal:Show()
            PolymorphsJournal:EnableMouse(true)
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
        HexTomesJournal:Hide()
        PolymorphsJournal:Hide()
    end
    self.Tab = tab
    
    RunNextFrame(function()
        ManuscriptsSkillLineManuscriptsTab.tooltip = self.tabName
        ManuscriptsSkillLineDruidTab.tooltip = ShapeshiftsJournal.tabName
        ManuscriptsSkillLineSoulshapesTab.tooltip = SoulshapesJournal.tabName
        ManuscriptsSkillLineShamanTab.tooltip = HexTomesJournal.tabName
        ManuscriptsSkillLineMageTab.tooltip = PolymorphsJournal.tabName
        
        ManuscriptsSkillLineManuscriptsTab:SetNormalTexture(254288)
        ManuscriptsSkillLineDruidTab:SetNormalTexture(136036)
        ManuscriptsSkillLineSoulshapesTab:SetNormalTexture(GetSpellTexture(310143))
        ManuscriptsSkillLineShamanTab:SetNormalTexture(GetSpellTexture(51514))
        ManuscriptsSkillLineMageTab:SetNormalTexture(GetSpellTexture(118))
        
        if class == "DRUID" then
            ManuscriptsSkillLineManuscriptsTab:Show()
            ManuscriptsSkillLineDruidTab:Show()
            ManuscriptsSkillLineSoulshapesTab:SetPoint("TOPLEFT", ManuscriptsSkillLineDruidTab, "BOTTOMLEFT", 0, -17)
        elseif class == "SHAMAN" then
            ManuscriptsSkillLineManuscriptsTab:Show()
            ManuscriptsSkillLineShamanTab:Show()
            ManuscriptsSkillLineSoulshapesTab:SetPoint("TOPLEFT", ManuscriptsSkillLineShamanTab, "BOTTOMLEFT", 0, -17)
        elseif class == "MAGE" then
            ManuscriptsSkillLineManuscriptsTab:Show()
            ManuscriptsSkillLineMageTab:Show()
            ManuscriptsSkillLineSoulshapesTab:SetPoint("TOPLEFT", ManuscriptsSkillLineMageTab, "BOTTOMLEFT", 0, -17)
        end
        
        if C_Covenants.GetActiveCovenantID() == 3 then
            ManuscriptsSkillLineManuscriptsTab:Show()
            ManuscriptsSkillLineSoulshapesTab:Show()
        end
    end)
end

hooksecurefunc("CollectionsJournal_SetTab", function(self, tabID)
    if tabID ~= CollectionsJournalTab4:GetID() then
        ShapeshiftsJournal:Hide()
        ManuscriptsSideTabsFrame:Hide()
        SoulshapesJournal:Hide()
        HexTomesJournal:Hide()
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

function ParentMixin:IsCollected(data)
    return C_QuestLog.IsQuestFlaggedCompleted(data.questID)
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

        	local collected = self:IsCollected(data)
            
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
        end)
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

local function deselectAndHideAll()
    ManuscriptsSkillLineManuscriptsTab:SetChecked(false)
    ManuscriptsSkillLineDruidTab:SetChecked(false)
    ManuscriptsSkillLineSoulshapesTab:SetChecked(false)
    ManuscriptsSkillLineShamanTab:SetChecked(false)
    ManuscriptsSkillLineMageTab:SetChecked(false)

    ManuscriptsJournal:Hide()
    ShapeshiftsJournal:Hide()
    SoulshapesJournal:Hide()
    HexTomesJournal:Hide()
    PolymorphsJournal:Hide()
end    

function ManuscriptSkillLineTab_OnClick(self)
    deselectAndHideAll()
    selectedTab = self:GetID()
    self:SetChecked(true)
    
    if self == ManuscriptsSkillLineManuscriptsTab then
        ManuscriptsJournal:Show()
    elseif self == ManuscriptsSkillLineDruidTab then
        ShapeshiftsJournal:Show()
        ShapeshiftsJournal:SetFrameLevel(CollectionsJournal:GetFrameLevel() + 20)
        ShapeshiftsJournal:EnableMouse(true)
    elseif self == ManuscriptsSkillLineSoulshapesTab then
        SoulshapesJournal:Show()
        SoulshapesJournal:SetFrameLevel(CollectionsJournal:GetFrameLevel() + 20)
        SoulshapesJournal:EnableMouse(true)
    elseif self == ManuscriptsSkillLineShamanTab then
        HexTomesJournal:Show()
        HexTomesJournal:SetFrameLevel(CollectionsJournal:GetFrameLevel() + 20)
        HexTomesJournal:EnableMouse(true)
    elseif self == ManuscriptsSkillLineMageTab then
        PolymorphsJournal:Show()
        PolymorphsJournal:SetFrameLevel(CollectionsJournal:GetFrameLevel() + 20)
        PolymorphsJournal:EnableMouse(true)
    end
end
