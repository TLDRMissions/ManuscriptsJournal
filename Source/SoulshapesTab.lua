local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")
local FilterComponent = addon.FilterComponent

SoulshapesMixin = CreateFromMixins(addon.ParentMixin)

SoulshapesMixin.soulshapeFilter = true
SoulshapesMixin.crittershapeFilter = true

function SoulshapesMixin:SetDefaultFilters()
    self.soulshapeFilter = true
    self.crittershapeFilter = true
    
    local db = self:GetFilterDB()
    db.soulshape = true
    db.crittershape = true
    
    addon.ParentMixin.SetDefaultFilters(self)
end

function SoulshapesMixin:IsUsingDefaultFilters()
    if not (self.collectedFilter and self.uncollectedFilter and self.soulshapeFilter and self.crittershapeFilter) then return false end
    
    for i = 1, 99 do
        if not self.sourceFilter[i] then
            return false
        end
    end
    return true
end

function SoulshapesMixin:GetSoulshapeFilter()
    return self.soulshapeFilter
end

function SoulshapesMixin:GetCrittershapeFilter()
    return self.crittershapeFilter
end

function SoulshapesMixin:GetFilterDB()
    return SoulshapesJournalFiltersDB
end

function SoulshapesMixin:GetNumSources()
    return 5
end

local sourceFilterStrings = {
    L["Loot"], L["Quest"], L["Vendor"], L["NPC"], L["World Event"],
}
function SoulshapesMixin:GetSourceName(index)
    return sourceFilterStrings[index]
end

-- adapted from Blizzard_Collections\Blizzard_HeirloomCollection

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
        name = C_Reputation.GetFactionDataByID(faction.id).name
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
    
    local db = self.layoutData
    
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
		LibDD:UIDropDownMenu_Initialize(self, OpenCollectedFilterDropDown, "MENU");
		SoulshapesJournal:UpdateResetFiltersButtonVisibility();
	end
end

function SoulshapesMixin:OnLoad()
    self.tabName = L["TAB_TITLE"]
    
    addon.ParentMixin.OnLoad(self)
end

function SoulshapesMixin:GetEntryDB()
    return addon.soulshapeDB
end

function SoulshapesMixin:IsCollected(data)
    return (not data.questID) or C_QuestLog.IsQuestFlaggedCompleted(data.questID)
end

function SoulshapesMixin:SortEntriesIntoEquipmentBuckets()
	-- Sort them into equipment buckets
	local equipBuckets = {};
    
    for _, soulshapeData in pairs(self:GetEntryDB()) do
        local collected = self:IsCollected(soulshapeData)
        
        local include = false
        if collected and self.collectedFilter then include = true end
        if (not collected) and self.uncollectedFilter then include = true end
        
        if include then
            include = false
            if (not soulshapeData.critter) and self.soulshapeFilter then include = true end
            if soulshapeData.critter and self.crittershapeFilter then include = true end
        end
        
        if include and (self.searchText ~= "") then
            include = false
            if soulshapeData.name and string.lower(soulshapeData.name):find(string.lower(self.searchText)) then
                include = true
            end
        end
        
        if include then
            if soulshapeData.loot and not self:GetSourceFilter(1) then
                include = false
            elseif soulshapeData.quest and not self:GetSourceFilter(2) then
                include = false
            elseif soulshapeData.vendor and not self:GetSourceFilter(3) then
                include = false
            elseif soulshapeData.npc and not self:GetSourceFilter(4) then
                include = false
            elseif soulshapeData.worldEvent and not self:GetSourceFilter(5) then
                include = false
            end
        end
        
        if include then
            local category = 1
  			if not equipBuckets[category] then
  				equipBuckets[category] = {}
  			end

  			table.insert(equipBuckets[category], soulshapeData)

              if collected then
                  self.numKnownEntries[category] = self.numKnownEntries[category] + 1
  			end
  			self.numPossibleEntries[category] = self.numPossibleEntries[category] + 1
        end
	end

	return equipBuckets;
end

function SoulshapesMixin:UpdateProgressBar()
	self.progressBar:SetMinMaxValues(0, self.numPossibleEntries[1]);
	self.progressBar:SetValue(self.numKnownEntries[1]);
	self.progressBar.text:SetFormattedText(L["MANUSCRIPTS_PROGRESS_FORMAT"], self.numKnownEntries[1], self.numPossibleEntries[1]);
end

function SoulshapesMixin:SetSoulshapeFilter(checked)
    assert(type(checked) == "boolean")
    self.soulshapeFilter = checked
    self.GetFilterDB().soulshape = checked
    self:FullRefreshIfVisible()
end

function SoulshapesMixin:SetCrittershapeFilter(checked)
    assert(type(checked) == "boolean")
    self.crittershapeFilter = checked
    self.GetFilterDB().crittershape = checked
    self:FullRefreshIfVisible()
end

function SoulshapesMixin:OpenCollectedFilterDropDown(level)
	local filterSystem = {
		onUpdate = function() self:UpdateResetFiltersButtonVisibility() end,
		filters = {
			{ type = FilterComponent.Checkbox, text = COLLECTED, set = function(value) self:SetCollectedFilter(value) end, isSet = function() return self:GetCollectedFilter() end },
			{ type = FilterComponent.Checkbox, text = NOT_COLLECTED, set = function(value) self:SetUncollectedFilter(value) end, isSet = function() return self:GetUncollectedFilter() end },
            
            { type = FilterComponent.Checkbox, text = L["Soulshape"], set = function(value) self:SetSoulshapeFilter(value) end, isSet = function() return self:GetSoulshapeFilter() end },
            { type = FilterComponent.Checkbox, text = L["Crittershape"], set = function(value) self:SetCrittershapeFilter(value) end, isSet = function() return self:GetCrittershapeFilter() end },
			
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

function SoulshapesJournalSearchBox_OnTextChanged(self)
	SearchBoxTemplate_OnTextChanged(self);
	self:GetParent().searchText = self:GetText()
	SoulshapesJournal:FullRefreshIfVisible();
end

EventUtil.ContinueOnAddOnLoaded(addonName, function()
    local loaded, finished = C_AddOns.IsAddOnLoaded(addonName)
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
