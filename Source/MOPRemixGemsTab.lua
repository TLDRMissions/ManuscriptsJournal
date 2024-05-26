local addonName, addon = ...

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")

MOPRemixGemsMixin = CreateFromMixins(addon.ParentMixin)

local GEM_SORT_ORDER = {
    addon.Enum.MOPRemixGemType.Meta,
    addon.Enum.MOPRemixGemType.Cogwheel,
    addon.Enum.MOPRemixGemType.Tinker,
    addon.Enum.MOPRemixGemType.Prismatic,
}

-- from BLizzard_ItemSocketingUI.lua
local GEM_TYPE_INFO =	{	Yellow = {textureKit="yellow", r=0.97, g=0.82, b=0.29},
							Red = {textureKit="red", r=1, g=0.47, b=0.47},
							Blue = {textureKit="blue", r=0.47, g=0.67, b=1},
							Hydraulic = {textureKit="hydraulic", r=1, g=1, b=1},
							Cogwheel = {textureKit="cogwheel", r=1, g=1, b=1},
							Meta = {textureKit="meta", r=1, g=1, b=1},
							Prismatic = {textureKit="prismatic", r=1, g=1, b=1},
							PunchcardRed = {textureKit="punchcard-red", r=1, g=0.47, b=0.47},
							PunchcardYellow = {textureKit="punchcard-yellow", r=0.97, g=0.82, b=0.29},
							PunchcardBlue = {textureKit="punchcard-blue", r=0.47, g=0.67, b=1},
							Domination = {textureKit="domination", r=1, g=1, b=1},
							Cypher = {textureKit="meta", r=1, g=1, b=1},
							Tinker = {textureKit="punchcard-red", r=1, g=0.47, b=0.47},
							Primordial = {textureKit="meta", r=1, g=1, b=1},
						};

local function restoreCJ()
    if not CollectionsJournal:IsVisible() then
        ToggleCollectionsJournal()
        CollectionsJournalTitleText:SetText(MOPRemixGemsJournal.tabName)
    end
end

local function suppressSocketInfoUpdate()
    UIParent:UnregisterEvent("SOCKET_INFO_UPDATE")
    if ItemSocketingFrame then
        ItemSocketingFrame:UnregisterEvent("SOCKET_INFO_UPDATE")
    end
end

local function restoreSocketInfoUpdate()
    UIParent:RegisterEvent("SOCKET_INFO_UPDATE")
    if ItemSocketingFrame then
        ItemSocketingFrame:RegisterEvent("SOCKET_INFO_UPDATE")
    end
end

local tinkerSlots = {"SHOULDERSLOT", "WRISTSLOT", "HANDSSLOT", "WAISTSLOT"}
local currentlySelectedTinkerSlot = 1
local function selectNextTinkerSlot()
    for attempts = 1, #tinkerSlots do
        currentlySelectedTinkerSlot = currentlySelectedTinkerSlot + 1
        local slotName = tinkerSlots[currentlySelectedTinkerSlot]
        if not slotName then
            currentlySelectedTinkerSlot = 1
            slotName = tinkerSlots[currentlySelectedTinkerSlot]
        end
        if GetInventoryItemID("player", GetInventorySlotInfo(slotName)) then
            return GetInventorySlotInfo(slotName)
        end
    end
    return nil
end

local prismaticSlots = {"CHESTSLOT", "LEGSSLOT", "NECKSLOT", "FINGER0SLOT", "FINGER1SLOT", "TRINKET0SLOT", "TRINKET1SLOT"}
local currentlySelectedPrismaticSlot = 1
local function selectNextPrismaticSlot()
    for attempts = 1, #prismaticSlots do
        currentlySelectedPrismaticSlot = currentlySelectedPrismaticSlot + 1
        local slotName = prismaticSlots[currentlySelectedPrismaticSlot]
        if not slotName then
            currentlySelectedPrismaticSlot = 1
            slotName = prismaticSlots[currentlySelectedPrismaticSlot]
        end
        if GetInventoryItemID("player", GetInventorySlotInfo(slotName)) then
            return GetInventorySlotInfo(slotName)
        end
    end
    return nil
end

function MOPRemixGemsJournal_OnEvent(self, event, ...)
	if event == "BAG_UPDATE" then
        self:OnManuscriptsUpdated(...)
	end
end

function MOPRemixGemsJournal_OnShow(self)
	CollectionsJournal:SetPortraitToAsset("Interface\\Icons\\INV_10_JewelCrafting_Gem3Primal_Frost_Cut_Blue");

	if self.needsRefresh then
		self:RefreshView();
	end
end

function MOPRemixGemsJournal_OnMouseWheel(self, delta)
	self.PagingFrame:OnMouseWheel(delta);
end

function MOPRemixGemsJournal_UpdateButton(self)
	self:GetParent():GetParent():UpdateButton(self);
end

function MOPRemixGemsMixin:UpdateButton(button)
    addon.ParentMixin.UpdateButton(self, button)
    if ManuscriptsJournalMOPRemixGemsDB.favourites[button.itemID] then
        button.favorite:Show()
    else
        button.favorite:Hide()
    end
end

local throttle = GetTime()
local throttleCache = false
local currentlySwitching = false
function MOPRemixGemsJournalSpellButton_OnEnter(self)
    if currentlySwitching then return end
    local db = addon.itemIDToDB[self.itemID]
    
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    
    if not MOPRemixGemsMixin:IsCollected(db) then
        GameTooltip:SetItemByID(self.itemID)
        GameTooltip:Show()
        return
    end
    
    suppressSocketInfoUpdate()
    
    if db.category == addon.Enum.MOPRemixGemType.Meta then
        if GetTime() - throttle > 2 then
            SocketInventoryItem(1)
            throttleCache = GetExistingSocketInfo(1)
            throttle = GetTime()
            CloseSocketInfo()
        end
        if throttleCache then
            GameTooltip:SetItemByID(self.itemID)
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine("Click to unsocket meta gem from equipped Helm")
        else
            GameTooltip:SetItemByID(self.itemID)
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine("Click to equip to Helm")
        end
    elseif db.category == addon.Enum.MOPRemixGemType.Cogwheel then
        if GetTime() - throttle > 2 then
            SocketInventoryItem(8)
            throttleCache = GetExistingSocketInfo(1)
            throttle = GetTime()
            CloseSocketInfo()
        end
        if throttleCache then
            GameTooltip:SetItemByID(self.itemID)
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine("Click to unsocket cogwheel from equipped Boots")
        else
            GameTooltip:SetItemByID(self.itemID)
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine("Click to equip to Boots")
        end
    elseif db.category == addon.Enum.MOPRemixGemType.Tinker then
        GameTooltip:SetItemByID(self.itemID)
        
        local index = 1
        for _, slotName in ipairs(tinkerSlots) do
            local slotID = GetInventorySlotInfo(slotName)
            local itemID = GetInventoryItemID("player", slotID)
            if itemID then
                local button = MOPRemixGemsJournal["ItemButton"..index]
                local texture = GetInventoryItemTexture("player", slotID)
                button.iconTexture:SetTexture(texture)
                button.iconTexture:Show()
    		    button.iconTextureUncollected:Hide()
                button.slotID = slotID
                button.gemItemID = self.itemID
                if index == 1 then
                    button:SetPoint("TOPRIGHT", self, "BOTTOMLEFT")
                else
                    local previousButton = MOPRemixGemsJournal["ItemButton"..(index-1)]
                    button:SetPoint("TOPLEFT", previousButton, "TOPRIGHT")
                end
                button:Show()
                index = index + 1
            end
        end
        for i = index, 7 do
            local button = MOPRemixGemsJournal["ItemButton"..i]
            button:Hide()
        end
    elseif db.category == addon.Enum.MOPRemixGemType.Prismatic then
        GameTooltip:SetItemByID(self.itemID)
        
        local index = 1
        for _, slotName in ipairs(prismaticSlots) do
            local slotID = GetInventorySlotInfo(slotName)
            local itemID = GetInventoryItemID("player", slotID)
            if itemID then
                local button = MOPRemixGemsJournal["ItemButton"..index]
                local texture = GetInventoryItemTexture("player", slotID)
                button.iconTexture:SetTexture(texture)
                button.iconTexture:Show()
    		    button.iconTextureUncollected:Hide()
                button.slotID = slotID
                button.gemItemID = self.itemID
                if index == 1 then
                    button:SetPoint("TOPRIGHT", self, "BOTTOMLEFT")
                else
                    local previousButton = MOPRemixGemsJournal["ItemButton"..(index-1)]
                    button:SetPoint("TOPLEFT", previousButton, "TOPRIGHT")
                end
                button:Show()
                index = index + 1
            end
        end
        for i = index, 7 do
            local button = MOPRemixGemsJournal["ItemButton"..i]
            button:Hide()
        end
    end
    GameTooltip:Show()
    addon.journalTooltipShown = true
    restoreSocketInfoUpdate()
end

local function hideItemButtonsIfNotMousedOver()
    for i = 1, 7 do
        local button = MOPRemixGemsJournal["ItemButton"..i]
        if button:IsMouseOver() then return end
    end
    for i = 1, 3 do
        local button = MOPRemixGemsJournal["SocketButton"..i]
        if button:IsMouseOver() then return end
    end
    for i = 1, 7 do
        local button = MOPRemixGemsJournal["ItemButton"..i]
        button:Hide()
    end
    for i = 1, 3 do
        local button = MOPRemixGemsJournal["SocketButton"..i]
        button:Hide()
    end
end

local function hideItemButtons()
    for i = 1, 7 do
        local button = MOPRemixGemsJournal["ItemButton"..i]
        button:Hide()
    end
    for i = 1, 3 do
        local button = MOPRemixGemsJournal["SocketButton"..i]
        button:Hide()
    end
end    
    
function MOPRemixGemsJournalSpellButton_OnExit()
    addon.journalTooltipShown = false
    GameTooltip:Hide()
    hideItemButtonsIfNotMousedOver()
end

function MOPRemixGemsJournalItemButton_OnExit(button)
    GameTooltip_Hide()
	ResetCursor()
    hideItemButtonsIfNotMousedOver()
end

local itemButtonThrottle = GetTime()
local itemButtonThrottleCache = false 
function MOPRemixGemsJournalItemButton_OnEnter(button)
    local slotID = button.slotID
    GameTooltip:SetOwner(CollectionsJournal, "ANCHOR_RIGHT")
    GameTooltip:SetInventoryItem("player", button.slotID)
    GameTooltip:Show()
    
    if (GetTime() - itemButtonThrottle > 2) or (itemButtonThrottleCache and (itemButtonThrottleCache.slotID ~= slotID)) then
        suppressSocketInfoUpdate()
        SocketInventoryItem(slotID)
        itemButtonThrottleCache = false
        if GetNumSockets() > 0 then
            itemButtonThrottleCache = {}
            for socketIndex = 1, GetNumSockets() do
                local name, texture = GetExistingSocketInfo(socketIndex)
                itemButtonThrottleCache[socketIndex] = {texture = texture or 0, itemLink = GetExistingSocketLink(socketIndex)}
            end
            itemButtonThrottleCache.slotID = slotID
            itemButtonThrottleCache.gemColor = GetSocketTypes(1)
        end
        itemButtonThrottle = GetTime()
        CloseSocketInfo()
        restoreSocketInfoUpdate()
    end
        
    if itemButtonThrottleCache then
        for i, data in ipairs(itemButtonThrottleCache) do
            local socketButton = MOPRemixGemsJournal["SocketButton"..i]
            socketButton.iconTexture:SetTexture(data.texture)
            socketButton.iconTexture:Show()
            socketButton.iconTextureUncollected:Hide()
            socketButton.slotID = slotID
            socketButton.socketSlotID = i
            socketButton.socketItemLink = data.itemLink
            socketButton.gemItemID = button.gemItemID
            socketButton:SetAttribute("type", "macro")
            if data.texture == 0 then
                socketButton:SetAttribute("macrotext", "")
            else
                socketButton:SetAttribute("macrotext", "/stopmacro [combat]\n/click ItemSocketingSocket"..i)
            end
            socketButton:RegisterForClicks("AnyDown")
            
            local gemColor = itemButtonThrottleCache.gemColor
            local gemInfo = GEM_TYPE_INFO[gemColor]
			SetupTextureKitOnFrame(gemInfo.textureKit, socketButton.Background, "socket-%s-background", TextureKitConstants.DoNotSetVisibility, TextureKitConstants.UseAtlasSize)
            
            if i == 1 then
                socketButton:SetPoint("TOP", button, "BOTTOM")
            else
                local previousButton = MOPRemixGemsJournal["SocketButton"..(i-1)]
                socketButton:SetPoint("TOP", previousButton, "BOTTOM")
            end
            socketButton:Show()
        end
        for i = (#itemButtonThrottleCache+1), 3 do
            MOPRemixGemsJournal["SocketButton"..i]:Hide()
        end
    else
        for i = 1, 3 do
            MOPRemixGemsJournal["SocketButton"..i]:Hide()
        end
    end
end

function MOPRemixGemsJournalSocketButton_OnEnter(button)
    if not button.socketItemLink then return end
    local slotID = button.slotID
    local socketIndex = button.socketSlotID
    
    GameTooltip:SetOwner(CollectionsJournal, "ANCHOR_RIGHT")
    GameTooltip:SetHyperlink(button.socketItemLink)
    GameTooltip:Show()
end

function MOPRemixGemsJournalSocketButton_PreClick(button)
    if InCombatLockdown() then return end
    
    local slotID = button.slotID
    local socketIndex = button.socketSlotID
    local hasGem = button.iconTexture:GetTexture() ~= nil
    
    if hasGem then
        SocketInventoryItem(slotID)
        print(button:GetAttribute("macrotext"))
    end
end
  
function MOPRemixGemsJournalSocketButton_PostClick(button)
    if InCombatLockdown() then return end
    local slotID = button.slotID
    local socketIndex = button.socketSlotID
    local hasGem = button.iconTexture:GetTexture() ~= nil
    local gemItemID = button.gemItemID
    
    if hasGem then
        CloseSocketInfo()
        restoreCJ()
        C_Timer.After(1, function()
            MOPRemixGemsJournal:FullRefreshIfVisible()
        end)
    else
        SocketInventoryItem(slotID)
        for containerIndex = 0, 4 do
            for slotIndex = 1, C_Container.GetContainerNumSlots(containerIndex) do
                if C_Container.GetContainerItemID(containerIndex, slotIndex) == gemItemID then
                    ClearCursor()
                    C_Container.PickupContainerItem(containerIndex, slotIndex)
                    ClickSocketButton(socketIndex)
                    AcceptSockets()
                    CloseSocketInfo()
                    restoreCJ()
                    C_Timer.After(1, function()
                        MOPRemixGemsJournal:FullRefreshIfVisible()
                    end)
                end
            end
        end
    end
    
    hideItemButtons()
end

function MOPRemixGemsMixin:OnLoad()
	self.manuscriptEntryFrames = {};
	self.manuscriptHeaderFrames = {};
	self.manuscriptLayoutData = {};
    if not C_UnitAuras.GetPlayerAuraBySpellID(424143) then return end   
    
    self.tabName = AUCTION_CATEGORY_GEMS
    
    self:RegisterEvent("BAG_UPDATE");
    
    addon.ParentMixin.OnLoad(self)
    
    local function runOutOfCombat()
        MOPRemixGemsJournalInsecureTabButton = LibStub('SecureTabs-2.0'):Add(CollectionsJournal, self, self.tabName)
        local tab = MOPRemixGemsJournalInsecureTabButton
        local secureTabButton = CreateFrame("Button", nil, CollectionsJournal, "SecureActionButtonTemplate")
        secureTabButton:SetAttribute("type", "click")
        secureTabButton:SetAttribute("clickbutton", CollectionsJournalTab4)
        secureTabButton:SetPoint("TOPLEFT", tab, "TOPLEFT")
        secureTabButton:SetPoint("BOTTOMRIGHT", tab, "BOTTOMRIGHT")
        secureTabButton:RegisterForClicks("AnyDown")
        
        secureTabButton:HookScript("OnClick", function()
            tab:Click()
        end)
        tab:SetPassThroughButtons("LeftButton")
        tab.Enable = nop
        tab.Disable = nop
        
        tab.OnSelect = function()
            tab.LeftHighlight:Hide()
            tab.MiddleHighlight:Hide()
            tab.RightHighlight:Hide()
            tab:SetHighlightLocked(true)
            
            RunNextFrame(function()
                CollectionsJournalTitleText:SetText(self.tabName)
                addon.ParentMixin:HideHeirloomsExtras()
            end)
        end
        tab.OnDeselect = function()
            tab.LeftHighlight:Show()
            tab.MiddleHighlight:Show()
            tab.RightHighlight:Show()
            tab:SetHighlightLocked(false)
            
            CollectionsJournalTitleText:SetText(_G["CollectionsJournalTab"..CollectionsJournal_GetTab(CollectionsJournal)]:GetText())
            addon.ParentMixin:ShowHeirloomsExtras()
        end
        self.Tab = tab
    end
    
    if InCombatLockdown() then
        EventUtil.RegisterOnceFrameEventAndCallback("PLAYER_REGEN_ENABLED", runOutOfCombat)
        return
    end
    runOutOfCombat()
end

function MOPRemixGemsMixin:OnManuscriptsUpdated()
    C_Timer.After(2, function() self:FullRefreshIfVisible() end)
end

function MOPRemixGemsMixin:FullRefreshIfVisible()
	self.needsDataRebuilt = true;
	self:RefreshViewIfVisible();
end

function MOPRemixGemsMixin:RefreshViewIfVisible()
	if self:IsVisible() then
		self:RefreshView();
	else
		self.needsRefresh = true;
	end
end

function MOPRemixGemsMixin:RebuildLayoutData()
	if not self.needsDataRebuilt then
		return;
	end
	self.needsDataRebuilt = false;

	self.manuscriptLayoutData = {};

	local equipBuckets = self:SortManuscriptsIntoEquipmentBuckets();
	self:SortEquipBucketsIntoPages(equipBuckets);
	self.PagingFrame:SetMaxPages(math.max(#self.manuscriptLayoutData, 1));
end

local function sortBucket(a, b, category)
    local itemName, itemLink, itemQuality = C_Item.GetItemInfo(a)
    if not itemName then
        C_Timer.After(1, function()
            MOPRemixGemsJournal:FullRefreshIfVisible()
        end)
        return a < b
    end
    local itemName2, itemLink2, itemQuality2 = C_Item.GetItemInfo(b)
    if not itemName2 then
        C_Timer.After(1, function()
            MOPRemixGemsJournal:FullRefreshIfVisible()
        end)
        return a < b
    end
    
    if category == addon.Enum.MOPRemixGemType.Prismatic then
        if itemQuality == itemQuality2 then
            return itemName < itemName2
        end
        return itemQuality > itemQuality2
    else
        return itemName < itemName2
    end
end

function MOPRemixGemsMixin:SortManuscriptsIntoEquipmentBuckets()
	-- Sort them into equipment buckets
	local equipBuckets = {};
    
    for _, data in pairs(addon.MOPRemixGemsDB) do
        local category = data.category
        if not equipBuckets[category] then
            equipBuckets[category] = {}
        end

        table.insert(equipBuckets[category], data.itemID)
	end
    
    for category, bucket in pairs(equipBuckets) do
        table.sort(bucket, function(a, b)
            if ManuscriptsJournalMOPRemixGemsDB.favourites[a] then
                if not ManuscriptsJournalMOPRemixGemsDB.favourites[b] then
                    return true
                else
                    return sortBucket(a, b, category)
                end
            else
                if ManuscriptsJournalMOPRemixGemsDB.favourites[b] then
                    return false
                else
                    return sortBucket(a, b, category)
                end
            end
        end)
    end

	return equipBuckets
end

function MOPRemixGemsMixin:IsCollected(data)
    for containerIndex = 0, 4 do
        for slotIndex = 1, C_Container.GetContainerNumSlots(containerIndex) do
            if C_Container.GetContainerItemID(containerIndex, slotIndex) == data.itemID then
                return true
            end
        end
    end
    return false
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

function MOPRemixGemsMixin:SortEquipBucketsIntoPages(equipBuckets)
	if not next(equipBuckets) then
		return;
	end

	local currentPage = {};
	local pageHeight = VIEW_MODE_FULL_PAGE_HEIGHT
	local heightLeft = pageHeight;
	local widthLeft = PAGE_WIDTH;

	for _, category in ipairs(GEM_SORT_ORDER) do
		local equipBucket = equipBuckets[category];

		if equipBucket then
    		if heightLeft < HEADER_HEIGHT + BUTTON_PADDING_Y + BUTTON_HEIGHT then
    			-- Not enough room to add the upcoming header for this bucket, move to next page
    			table.insert(self.manuscriptLayoutData, currentPage);
    			heightLeft = pageHeight;
    			currentPage = {};
    		end

    		-- Add header
    		table.insert(currentPage, addon.Strings.MOPRemixGemType[category])
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

function MOPRemixGemsMixin:LayoutCurrentPage()
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
				local entry = self:AcquireFrame(self.manuscriptEntryFrames, numEntriesInUse, "CHECKBUTTON", "MOPRemixGemSpellButtonTemplate, InsecureActionButtonTemplate");
				entry.itemID = layoutData;

				if entry:IsVisible() then
					-- If the button was already visible (going to a new page and being reused we have to update the button immediately instead of deferring the update through the OnShown
					self:UpdateButton(entry);
				end
                self:UpdateButtonActions(entry)

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

local buttons = {}
local function disableButtons()
    for button in pairs(buttons) do
        button:Disable()
    end
end
local function enableButtons()
    for button in pairs(buttons) do
        button:Enable()
    end
end

function MOPRemixGemsMixin:UpdateButtonActions(entry)
    if currentlySwitching then return end
    buttons[entry] = true
    suppressSocketInfoUpdate()

    local data = addon.itemIDToDB[entry.itemID]
    entry:SetAttribute("type", "macro")
    entry:RegisterForClicks("AnyDown")
    if data.category == addon.Enum.MOPRemixGemType.Meta then
        if not GetInventoryItemID("player", 1) then return end
        SocketInventoryItem(1)
        if GetExistingSocketInfo(1) then
            entry:SetAttribute("macrotext", "/stopmacro [combat]\n/click [button:1] ItemSocketingSocket1")
            entry:SetScript("PreClick", function(_, button)
                if InCombatLockdown() then return end
                if button == "RightButton" then
                    ManuscriptsJournalMOPRemixGemsDB.favourites[entry.itemID] = not ManuscriptsJournalMOPRemixGemsDB.favourites[entry.itemID]
                    return
                end
                disableButtons()
                local itemID = entry.itemID
                local data = addon.itemIDToDB[itemID]
                if data.category == addon.Enum.MOPRemixGemType.Meta then
                    currentlySwitching = true
                    SocketInventoryItem(1)
                end
            end)
            entry:SetScript("PostClick", function(_, button)
                entry:SetChecked(false)
                if InCombatLockdown() then return end
                if button == "RightButton" then
                    self:FullRefreshIfVisible()
                    return
                end
                CloseSocketInfo()
                restoreCJ()
                suppressSocketInfoUpdate()
                C_Timer.After(1, function()
                    currentlySwitching = false
                    self:FullRefreshIfVisible()
                    enableButtons()
                    CloseSocketInfo()
                    restoreCJ()
                    restoreSocketInfoUpdate()
                end)
            end)
        else
            entry:SetAttribute("macrotext", "")
            entry:SetScript("PreClick", function(_, button)
                if button == "RightButton" then
                    ManuscriptsJournalMOPRemixGemsDB.favourites[entry.itemID] = not ManuscriptsJournalMOPRemixGemsDB.favourites[entry.itemID]
                    return
                end
                disableButtons()
            end)
            entry:SetScript("PostClick", function(_, button)
                entry:SetChecked(false)
                if button == "RightButton" then
                    self:FullRefreshIfVisible()
                    return
                end
                currentlySwitching = true
                for containerIndex = 0, 4 do
                    for slotIndex = 1, C_Container.GetContainerNumSlots(containerIndex) do
                        if C_Container.GetContainerItemID(containerIndex, slotIndex) == entry.itemID then
                            SocketInventoryItem(1)
                            ClearCursor()
                            C_Container.PickupContainerItem(containerIndex, slotIndex)
                            if CursorHasItem() then
                                ClickSocketButton(1)
                                AcceptSockets()
                            end
                            CloseSocketInfo()
                            restoreCJ()
                            suppressSocketInfoUpdate()
                            C_Timer.After(1, function()
                                currentlySwitching = false
                                self:FullRefreshIfVisible()
                                enableButtons()
                                CloseSocketInfo()
                                restoreCJ()
                                restoreSocketInfoUpdate()
                            end)
                            return
                        end
                    end
                end
            end)
        end
    elseif data.category == addon.Enum.MOPRemixGemType.Cogwheel then
        if not GetInventoryItemID("player", 8) then return end
        SocketInventoryItem(8)
        if GetExistingSocketInfo(1) then
            entry:SetAttribute("macrotext", "/stopmacro [combat]\n/click [button:1] ItemSocketingSocket1")
            entry:SetScript("PreClick", function(_, button)
                if InCombatLockdown() then return end
                if button == "RightButton" then
                    ManuscriptsJournalMOPRemixGemsDB.favourites[entry.itemID] = not ManuscriptsJournalMOPRemixGemsDB.favourites[entry.itemID]
                    return
                end
                disableButtons()
                local itemID = entry.itemID
                local data = addon.itemIDToDB[itemID]
                if data.category == addon.Enum.MOPRemixGemType.Cogwheel then
                    currentlySwitching = true
                    SocketInventoryItem(8)
                end
            end)
            entry:SetScript("PostClick", function(_, button)
                entry:SetChecked(false)
                if InCombatLockdown() then return end
                if button == "RightButton" then
                    self:FullRefreshIfVisible()
                    return
                end
                CloseSocketInfo()
                restoreCJ()
                suppressSocketInfoUpdate()
                C_Timer.After(1, function()
                    currentlySwitching = false
                    self:FullRefreshIfVisible()
                    enableButtons()
                    CloseSocketInfo()
                    restoreCJ()
                    restoreSocketInfoUpdate()
                end)
            end)
        else
            entry:SetAttribute("macrotext", "")
            entry:SetScript("PreClick", function(_, button)
                if button == "RightButton" then
                    ManuscriptsJournalMOPRemixGemsDB.favourites[entry.itemID] = not ManuscriptsJournalMOPRemixGemsDB.favourites[entry.itemID]
                    return
                end
                disableButtons()
            end)
            entry:SetScript("PostClick", function(_, button)
                entry:SetChecked(false)
                if button == "RightButton" then
                    self:FullRefreshIfVisible()
                    return
                end
                currentlySwitching = true
                for containerIndex = 0, 4 do
                    for slotIndex = 1, C_Container.GetContainerNumSlots(containerIndex) do
                        if C_Container.GetContainerItemID(containerIndex, slotIndex) == entry.itemID then
                            SocketInventoryItem(8)
                            ClearCursor()
                            C_Container.PickupContainerItem(containerIndex, slotIndex)
                            ClickSocketButton(1)
                            AcceptSockets()
                            CloseSocketInfo()
                            restoreCJ()
                            suppressSocketInfoUpdate()
                            C_Timer.After(1, function()
                                currentlySwitching = false
                                self:FullRefreshIfVisible()
                                enableButtons()
                                CloseSocketInfo()
                                restoreCJ()
                                restoreSocketInfoUpdate()
                            end)
                            return
                        end
                    end
                end
            end)
        end
    else
        entry:SetAttribute("macrotext", "")
        entry:SetScript("PreClick", function(_, button)
            entry:SetChecked(false)
            if button == "RightButton" then
                ManuscriptsJournalMOPRemixGemsDB.favourites[entry.itemID] = not ManuscriptsJournalMOPRemixGemsDB.favourites[entry.itemID]
                self:FullRefreshIfVisible()
            end
        end)
        entry:SetScript("PostClick", nop)
    end
    restoreSocketInfoUpdate()
end

EventUtil.ContinueOnAddOnLoaded(addonName, function()
    local loaded, finished = IsAddOnLoaded(addonName)
    if not finished then return end
    
    if not ManuscriptsJournalMOPRemixGemsDB then ManuscriptsJournalMOPRemixGemsDB = {} end
    
    if not ManuscriptsJournalMOPRemixGemsDB.favourites then ManuscriptsJournalMOPRemixGemsDB.favourites = {} end
end)
