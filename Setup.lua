local appName, app = ...;
app.CHARACTER_DATA = {};
app.ALTS = {};

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
    local myguid = UnitGUID("player");
    if myguid and app.CHARACTER_DATA[myguid:gsub("Player%-", "")] then
        DFA_MAIN = myguid;
    end

    -- setup alts lookup table
    if DFA_MAIN then
        app.ALTS[myguid] = DFA_MAIN;
    end
end)
