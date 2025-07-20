local appName, app = ...;
app.CHARACTER_DATA = {};

local frame = CreateFrame("Frame");
frame:RegisterEvent("PLAYER_LOGIN");
frame:SetScript("OnEvent", function(self, event, ...)
    -- Determines the player's region and loads that data
    -- TODO Ideally we can load correct region on demand, rather than loading all and erasing what we don't need
    local region = GetCVar('portal');
    if app["DATA_" .. region] then
        print("Data for Azeroth: Loading data for " .. region);

        app.CHARACTER_DATA = app["DATA_" .. region];

        app.DATA_US = nil;
        app.DATA_EU = nil;
        app.DATA_TW = nil;
        app.DATA_KR = nil;
    else
        -- TODO what should we do if the CVar doesn't work right?
        print("Data for Azeroth: Could not find player's region " .. region);
    end

    -- If the current character is found, track it as main in a saved variable
    app.GUID = UnitGUID("player");
    if app.GUID and app.CHARACTER_DATA[app.GUID:gsub("Player%-", "")] then
        DFA_MAIN = app.GUID;
    end

    -- if saved variable exists, then cache player's own data
    if DFA_MAIN then
        app.PLAYER_DATA = app.CHARACTER_DATA[DFA_MAIN:gsub("Player%-", "")];
    end
end)
