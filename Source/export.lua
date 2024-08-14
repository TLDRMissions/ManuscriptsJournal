local addonName, addon = ...

-- This is a LoadOnDemand addon so we shouldn't need to do any ADDON_LOADED event checks
-- But just in case someone changes the TOC or manages to make this load during startup, I'll add a delayed rescan anyway.

local function exportDB()
    ManuscriptsJournalExportDB = {}
    ManuscriptsJournalExportDB.version = C_AddOns.GetAddOnMetadata(addonName, "Version")
    ManuscriptsJournalExportDB.learnedManuscripts = {}

    for _, manuscriptData in pairs(addon.db) do
        ManuscriptsJournalExportDB.learnedManuscripts[manuscriptData.questID] = C_QuestLog.IsQuestFlaggedCompleted(manuscriptData.questID)
    end
end

EventUtil.ContinueOnAddOnLoaded(addonName, function()
    local loaded, finished = C_AddOns.IsAddOnLoaded(addonName)
    if not finished then return end
    
    exportDB()
end)
