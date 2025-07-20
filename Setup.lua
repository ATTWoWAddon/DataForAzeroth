local appName, app = ...;
app.CHARACTER_DATA = {};

-- Determines the player's region and loads that data
-- TODO Ideally we can load correct region on demand, rather than loading all and erasing what we don't need

local frame = CreateFrame("Frame");
frame:RegisterEvent("PLAYER_LOGIN");
frame:SetScript("OnEvent", function(self, event, ...)

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

end)
