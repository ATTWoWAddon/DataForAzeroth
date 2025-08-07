local appName, app = ...;

C_ChatInfo.RegisterAddonMessagePrefix("DFA");

local function split(text)
    local result = {};
    for word in string.gmatch(text, "([^ ]+)") do
        table.insert(result, word);
    end
    return result;
end

local function announce(channel, to)
    if DFA_MAIN and DFA_SETTINGS.ShareAlts then
        C_ChatInfo.SendAddonMessage("DFA", "IAM " .. DFA_MAIN .. " " .. UnitGUID("player"), channel, to);
    end
end

-- handle incoming messages
app:OnEvent("CHAT_MSG_ADDON", function(prefix, text, channel, sender, target, ...)
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
        -- our GUID was requested
        announce("WHISPER", sender);
    end
end)

-- send messages to party/raid
local function GroupRosterEventHandler()
    if IsInRaid(2) or IsInGroup(2) then
        announce("INSTANCE_CHAT");
    elseif IsInRaid() then
        announce("RAID");
    elseif IsInGroup() then
        announce("PARTY");
    end
end

local timer1;
app:OnEvent("GROUP_ROSTER_UPDATE", function()
    -- debounce the function call
    if timer1 then timer1:Cancel() end
    timer1 = C_Timer.NewTimer(1, GroupRosterEventHandler);
end)

-- send messages to guild
local function GuildRosterEventHandler()
    if IsInGuild() then
        announce("GUILD");
    end
end

local timer2;
app:OnEvent("GUILD_ROSTER_UPDATE", function()
    -- debounce the function call
    if timer2 then timer2:Cancel() end
    timer2 = C_Timer.NewTimer(1, GuildRosterEventHandler);
end)