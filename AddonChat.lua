local appName, app = ...;

C_ChatInfo.RegisterAddonMessagePrefix("DFA");

local function split(text)
    local result = {};
    for word in string.gmatch(text, "([^ ]+)") do
        table.insert(result, word);
    end
    return result;
end

local frame = CreateFrame("Frame");
frame:RegisterEvent("CHAT_MSG_ADDON");
frame:SetScript("OnEvent", function(self, event, prefix, text, channel, sender, target, ...)
    if prefix ~= "DFA" then return end

    local words = split(text);
    if words[1] == "IAM" then
        -- IAM <MAIN-GUID> <ALT-GUID>
        -- another player's GUID was provided, add it to the alts lookup table
        app.ALTS[words[3]] = words[2];

        -- attempt to refresh the current tooltip
        local _, unit = GameTooltip:GetUnit()
        if unit then GameTooltip:SetUnit(unit) end
    elseif words[1] == "WHO" then
        -- our GUID was requested, only respond if enabled
        if DFA_MAIN and DFA_SETTINGS.ShareAlts then
            C_ChatInfo.SendAddonMessage("DFA", "IAM " .. DFA_MAIN .. " " .. UnitGUID("player"), "WHISPER", sender);
        end
    end
end)