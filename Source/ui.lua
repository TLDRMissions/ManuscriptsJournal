local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

-- adapted from Blizzard_Collections\Blizzard_HeirloomCollection

local class = select(2, UnitClass("player"))

addon.ParentMixin = {}
local ParentMixin = addon.ParentMixin

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

local tab
local selectedTab = 1
function ParentMixin:OnLoad()
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
            ParentMixin:HideHeirloomsExtras()
            
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
            ParentMixin:ShowHeirloomsExtras()
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
                    for _, panel in pairs(ParentMixin:GetAllPanels()) do
                        panel:SetPassThroughButtons("LeftButton")
                    end
                end)
                return
            end
            for _, panel in pairs(ParentMixin:GetAllPanels()) do
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
    local data, name, texture
    
    local function runLater()
        button.iconTexture:SetTexture(texture);
    	button.iconTextureUncollected:SetTexture(texture);
    	button.iconTextureUncollected:SetDesaturated(true);

    	button.name:SetText(name);

    	button.name:ClearAllPoints();
    	button.name:SetPoint("LEFT", button, "RIGHT", 9, 3);

        local collected = self:IsCollected(data)
        
        if collected then
    		if self == ManuscriptsJournal then
                if not ManuscriptsJournal:GetCollectedManuscriptFilter() then
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

    if button.itemID then
    	data = addon.itemIDToDB[button.itemID]
        local item = Item:CreateFromItemID(button.itemID)

        item:ContinueOnItemLoad(function()
        	name = item:GetItemName() 
        	texture = item:GetItemIcon()
            runLater()
        end)
    elseif button.spellID then
        data = addon.spellIDToDB[button.spellID]
        local info = C_Spell.GetSpellInfo(button.spellID)
        name = info.name
        texture = info.iconID
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
