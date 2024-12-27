local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")

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

ManuscriptsMixin = CreateFromMixins(addon.ParentMixin)

function ManuscriptsMixin:GetFilterDB()
    return ManuscriptsJournalFiltersDB
end

function ManuscriptsMixin:GetNumCategories()
    return NUM_DRAKES
end

function ManuscriptsMixin:GetAllCategory()
    return addon.Enum.Drakes.All
end

function ManuscriptsMixin:GetSortOrder()
    return DRAKE_SORT_ORDER
end

function ManuscriptsMixin:GetCategoryStrings()
    return addon.Strings.Drakes
end

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
        
        local db = self.layoutData
        if db.itemID then
            GameTooltip:SetItemByID(db.itemID)
        elseif db.spellID then
            GameTooltip:SetSpellByID(db.spellID)
        elseif db.artifactID then
            local artifactAppearanceSetID, artifactAppearanceID, appearanceName, displayIndex, unlocked, failureDescription, uiCameraID, altHandCameraID, swatchColorR, swatchColorG, swatchColorB, modelOpacity, modelSaturation, obtainable = C_ArtifactUI.GetAppearanceInfoByID(db.artifactID)
            GameTooltip:AddLine(failureDescription)
            GameTooltip:Show()
            return
        elseif db.name then
            local name = db.name
            if type(name) == "function" then
                name = name()
            end
            GameTooltip:AddLine(name)
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
                    local name = C_Reputation.GetFactionDataByID(reputationID).name
                    table.insert(reputations, name)
                end
                add(reputations)
            else
                local name = C_Reputation.GetFactionDataByID(db.reputation).name
                GameTooltip:AddLine(name)
            end
            if db.reputationRank then
                GameTooltip:AddDoubleLine(L["Required Rank:"], _G["FACTION_STANDING_LABEL"..db.reputationRank])
            elseif db.friendshipRank then
                GameTooltip:AddDoubleLine(L["Required Rank:"], db.friendshipRank)
            end
        elseif source == addon.Enum.Sources.Renown then
            GameTooltip:AddDoubleLine(C_Reputation.GetFactionDataByID(db.renownFaction).name, RANK_COLON.." "..db.renownRank)
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
            if db.zoneID then
                GameTooltip:AddDoubleLine(db.bossName, C_Map.GetAreaInfo(db.zoneID))
            else
                GameTooltip:AddLine(db.bossName)
            end
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
            local other = db.otherDescription
            if type(other) == "function" then
                other = other()
            end
            GameTooltip:AddLine(other)
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
		self:GetParent():UpdateResetFiltersButtonVisibility();
	end
end

function ManuscriptsMixin:OnLoad()
    self.tabName = L["ADDON_NAME"]
    
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

function ManuscriptsMixin:GetEntryDB()
    return addon.db
end

function ManuscriptsMixin:UpdateProgressBar()
	if #DRAKE_SORT_ORDER < 2 then
        local drake = DRAKE_SORT_ORDER[1]
        
        local _, maxProgress = self.progressBar:GetMinMaxValues()
        local currentProgress = self.progressBar:GetValue() + self.numKnownEntries[drake] - self["mount"..selectedBarID.."Bar"]:GetValue()
        self.progressBar:SetValue(currentProgress)
        self.progressBar.text:SetFormattedText(L["MANUSCRIPTS_PROGRESS_FORMAT"], currentProgress, maxProgress)
        
        _, maxProgress = self["mount"..selectedBarID.."Bar"]:GetMinMaxValues()
        self["mount"..selectedBarID.."Bar"]:SetValue(self.numKnownEntries[drake])
        self["mount"..selectedBarID.."Bar"].text:SetFormattedText(L["MANUSCRIPTS_PROGRESS_FORMAT"], self.numKnownEntries[drake], maxProgress)
        
        return
    end

    local maxProgress, currentProgress = 0, 0
    
    for i = 1, NUM_DRAKES-1 do
        local drake = DRAKE_SORT_ORDER[i]
        maxProgress = maxProgress + self.numPossibleEntries[drake]
        currentProgress = currentProgress + self.numKnownEntries[drake]
        self["mount"..i.."Bar"]:SetMinMaxValues(0, self.numPossibleEntries[drake])
        self["mount"..i.."Bar"]:SetValue(self.numKnownEntries[drake])
        self["mount"..i.."Bar"].text:SetFormattedText(L["MANUSCRIPTS_PROGRESS_FORMAT"], self.numKnownEntries[drake], self.numPossibleEntries[drake])
    end
	self.progressBar:SetMinMaxValues(0, maxProgress);
	self.progressBar:SetValue(currentProgress);
	self.progressBar.text:SetFormattedText(L["MANUSCRIPTS_PROGRESS_FORMAT"], currentProgress, maxProgress);
end

function ManuscriptsJournalSearchBox_OnTextChanged(self)
	SearchBoxTemplate_OnTextChanged(self);
	self:GetParent().searchText = self:GetText()
	self:GetParent():FullRefreshIfVisible();
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
    local loaded, finished = C_AddOns.IsAddOnLoaded(addonName)
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
