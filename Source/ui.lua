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
        for _, tab in pairs(self:GetAllTabs()) do
            tab:SetChecked(selectedTab == tab:GetID())
        end
        
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
        elseif (selectedTab == 6) and (class == "WARLOCK") then
            RunNextFrame(function()
                ManuscriptsJournal:Hide()
            end)
            GrimoiresJournal:Show()
            GrimoiresJournal:EnableMouse(true)
        end
    end
    tab.OnDeselect = function()
        local selectedTabID = CollectionsJournal_GetTab(CollectionsJournal)
        CollectionsJournalTitleText:SetText(_G["CollectionsJournalTab"..selectedTabID]:GetText())
        HeirloomsJournalClassDropDown:Show()
        HeirloomsJournal.progressBar:Show()
        HeirloomsJournal.SearchBox:Show()
        HeirloomsJournal.FilterButton:Show()
        ManuscriptsSideTabsFrame:Hide()
        ShapeshiftsJournal:Hide()
        SoulshapesJournal:Hide()
        HexTomesJournal:Hide()
        PolymorphsJournal:Hide()
        GrimoiresJournal:Hide()
    end
    self.Tab = tab
    
    RunNextFrame(function()
        ManuscriptsSkillLineManuscriptsTab.tooltip = self.tabName
        ManuscriptsSkillLineDruidTab.tooltip = ShapeshiftsJournal.tabName
        ManuscriptsSkillLineSoulshapesTab.tooltip = SoulshapesJournal.tabName
        ManuscriptsSkillLineShamanTab.tooltip = HexTomesJournal.tabName
        ManuscriptsSkillLineMageTab.tooltip = PolymorphsJournal.tabName
        ManuscriptsSkillLineWarlockTab.tooltip = GrimoiresJournal.tabName
        
        ManuscriptsSkillLineManuscriptsTab:SetNormalTexture(254288)
        ManuscriptsSkillLineDruidTab:SetNormalTexture(136036)
        ManuscriptsSkillLineSoulshapesTab:SetNormalTexture(GetSpellTexture(310143))
        ManuscriptsSkillLineShamanTab:SetNormalTexture(GetSpellTexture(51514))
        ManuscriptsSkillLineMageTab:SetNormalTexture(GetSpellTexture(118))
        ManuscriptsSkillLineWarlockTab:SetNormalTexture(GetSpellTexture(688))
        
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
        elseif class == "WARLOCK" then
            ManuscriptsSkillLineManuscriptsTab:Show()
            ManuscriptsSkillLineWarlockTab:Show()
            ManuscriptsSkillLineSoulshapesTab:SetPoint("TOPLEFT", ManuscriptsSkillLineWarlockTab, "BOTTOMLEFT", 0, -17)
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
        PolymorphsJournal:Hide()
        GrimoiresJournal:Hide()
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
    return {ManuscriptsJournal, ShapeshiftsJournal, SoulshapesJournal, HexTomesJournal, PolymorphsJournal, GrimoiresJournal}
end

function ParentMixin:GetAllTabs()
    return {ManuscriptsSkillLineManuscriptsTab, ManuscriptsSkillLineDruidTab, ManuscriptsSkillLineSoulshapesTab, ManuscriptsSkillLineShamanTab, ManuscriptsSkillLineMageTab, ManuscriptsSkillLineWarlockTab}
end

function ParentMixin:GetPanelByTab(tab)
    local panels = {
        [ManuscriptsSkillLineManuscriptsTab] = ManuscriptsJournal, 
        [ManuscriptsSkillLineDruidTab] = ShapeshiftsJournal, 
        [ManuscriptsSkillLineSoulshapesTab] = SoulshapesJournal, 
        [ManuscriptsSkillLineShamanTab] = HexTomesJournal, 
        [ManuscriptsSkillLineMageTab] = PolymorphsJournal, 
        [ManuscriptsSkillLineWarlockTab] = GrimoiresJournal,
    }
    return panels[tab]
end
