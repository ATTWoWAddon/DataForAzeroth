local appName, app = ...;
local L = {}; app.L = L;

-- English Strings
L.DATAFORAZEROTH = "|TInterface/Addons/DataForAzeroth/assets/Logo:0|t Data for Azeroth";
L.RANK_FORMAT = "World #%s  Region #%s  Realm #%s";

L.SETTINGS_GENERAL = "General";
L.SETTINGS_TOOLTIPS = "Tooltips";

L.ShareAlts_Setting = "Share Alts With Other Players";
L.ShareAlts_Tooltip = "Will allow other players to see your Data for Azeroth information when you are playing an alt. This could potentially allow them to figure out who your main character is.";

L.HideScore_Setting = "Hide Score";
L.HideScore_Tooltip = "Hides the Completion Score in the Data for Azeroth tooltip.";

L.HideMax_Setting = "Hide Max";
L.HideMax_Tooltip = "Hides the maximum possible Completion Score in the Data for Azeroth tooltip.";

L.HidePercent_Setting = "Hide Percent";
L.HidePercent_Tooltip = "Hides the percentage in the Data for Azeroth tooltip.";

L.HideRank_Setting = "Hide Rankings";
L.HideRank_Tooltip = "Hides the World/Region/Realm rankings in the Data for Azeroth tooltip.";

-- Localized Strings
local locale = GetLocale():sub(3,4):lower();
if locale == "es" then
    L.RANK_FORMAT = "Mundo #%s  Región #%s  Reino #%s";
elseif locale == "mx" then
    L.RANK_FORMAT = "Mundo #%s  Región #%s  Reino #%s";
elseif locale == "de" then
    L.RANK_FORMAT = "Welt #%s  Region #%s  Server #%s";
elseif locale == "fr" then
    L.RANK_FORMAT = "Monde #%s  Région #%s  Royaume #%s";
elseif locale == "it" then
    L.RANK_FORMAT = "Mondo #%s  Regione #%s  Regno #%s";
elseif locale == "pt" then
    L.RANK_FORMAT = "Mundo #%s  Região #%s  Reino #%s";
elseif locale == "ru" then
    L.RANK_FORMAT = "Мир #%s  Регион #%s  Сервер #%s";
elseif locale == "ko" then
    L.RANK_FORMAT = "월드 #%s  지역 #%s  영역 #%s";
elseif locale == "cn" then
    L.RANK_FORMAT = "世界 #%s  地区 #%s  领域 #%s";
elseif locale == "tw" then
    L.RANK_FORMAT = "世界 #%s  地區 #%s  領域 #%s";
end