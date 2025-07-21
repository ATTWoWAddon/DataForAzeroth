local appName, app = ...;
app.CHARACTER_DATA = {};

local frame = CreateFrame("Frame");
frame:RegisterEvent("PLAYER_LOGIN");
frame:SetScript("OnEvent", function(self, event, ...)
    -- Determines the player's region and loads that data
    local region = GetCVar('portal');
    local fn = app["Load" .. region];
    if fn then
        print("Data for Azeroth: Loading data for " .. region);
        fn();
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
