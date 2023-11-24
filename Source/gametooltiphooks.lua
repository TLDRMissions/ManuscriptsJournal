local addonName, addon = ...

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tooltip, data)
    if (tooltip ~= GameTooltip) and (tooltip ~= ItemRefTooltip) then return end
    if addon.journalTooltipShown then return end
    
    local db = addon.itemIDToDB[data.id]
    if not db then return end
    
    if db.source == addon.Enum.Sources.Inscription then
        if db.questID then
            if C_QuestLog.IsQuestFlaggedCompleted(db.questID) then
                tooltip:AddLine("|cFFFF0000"..ERR_COSMETIC_KNOWN.."|r")
            end
        end
    end
end)
