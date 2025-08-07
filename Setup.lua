local appName, app = ...;
app.CHARACTER_DATA = {};
app.ALTS = {};

-- helper code for event handlers
local frame = CreateFrame("Frame");
local handlers = {};

function app:OnEvent(event, fn)
    if not handlers[event] then
        handlers[event] = {};
        frame:RegisterEvent(event);
    end

    table.insert(handlers[event], fn);
end

frame:SetScript("OnEvent", function(self, event, ...)
    if handlers[event] then
        for _, handler in ipairs(handlers[event]) do
            handler(...)
        end
    end
end)

-- initialization
app:OnEvent("PLAYER_LOGIN", function(...)
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
