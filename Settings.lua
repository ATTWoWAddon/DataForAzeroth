local appName, app = ...;
local L = app.L;

local function CreateCheckbox(category, variable)
    local text = L[variable .. "_Setting"];
    local tooltip = L[variable .. "_Tooltip"];
    local setting = Settings.RegisterAddOnSetting(category, "DFA_S_" .. variable, variable, DFA_SETTINGS, Settings.VarType.Boolean, text, false);
    Settings.CreateCheckbox(category, setting, tooltip);
end

local function CreateSettings()
    local category, layout = Settings.RegisterVerticalLayoutCategory("Data for Azeroth");

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L.SETTINGS_GENERAL));
    CreateCheckbox(category, "ShareAlts");

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L.SETTINGS_TOOLTIPS));
    CreateCheckbox(category, "HideScore");
    CreateCheckbox(category, "HideMax");
    CreateCheckbox(category, "HidePercent");
    CreateCheckbox(category, "HideRank");

    Settings.RegisterAddOnCategory(category);
end

app:OnEvent("PLAYER_LOGIN", function()
    if not DFA_SETTINGS then DFA_SETTINGS = {} end
    CreateSettings();
end)