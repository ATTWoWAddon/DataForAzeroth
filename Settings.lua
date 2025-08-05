local appName, app = ...;

if not DFA_SETTINGS then
    DFA_SETTINGS = {
        ShareAlts = false,
        HideScore = false,
        HideMax = false,
        HidePercent = false,
        HideRank = false
    };
end

-- TODO build AddOn Options UI
-- everything below is temporary code until then

local available = {
    ShareAlts = 1,
    HideScore = 1,
    HideMax = 1,
    HidePercent = 1,
    HideRank = 1
};

local function split(text)
    local result = {};
    for word in string.gmatch(text, "([^ ]+)") do
        table.insert(result, word);
    end
    return unpack(result);
end

SLASH_DATAFORAZEROTH1 = "/dfa";
SlashCmdList.DATAFORAZEROTH = function(msg)
    local setting, value = split(msg);
    if available[setting] then
        local on = (value == "true");
        DFA_SETTINGS[setting] = on;
        print("Setting", setting, "to", on);
    end

    if msg == "shareon" then
        DFA_SETTINGS.ShareAlts = true;
        print("ShareAlts turned on");
    elseif msg == "shareoff" then
        DFA_SETTINGS.ShareAlts = false;
        print("ShareAlts turned off");
    end
end