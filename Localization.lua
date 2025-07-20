local appName, app = ...;
local L = {}; app.L = L;

-- English Strings
L.DATAFORAZEROTH = "|TInterface/Addons/DataForAzeroth/assets/Logo:0|t Data for Azeroth";
L.RANK_FORMAT = "World #%s";

-- Localize the Rank Format string
local locale = GetLocale():sub(3,4):lower();
if locale == "es" then
	L.RANK_FORMAT = "Mundo #%s";
elseif locale == "mx" then
	L.RANK_FORMAT = "Mundo #%s";
elseif locale == "de" then
	L.RANK_FORMAT = "Welt #%s";
elseif locale == "fr" then
	L.RANK_FORMAT = "Monde #%s";
elseif locale == "it" then
	L.RANK_FORMAT = "Mondo #%s";
elseif locale == "pt" then
	L.RANK_FORMAT = "Mundo #%s";
elseif locale == "ru" then
	L.RANK_FORMAT = "Мир #%s";
elseif locale == "ko" then
	L.RANK_FORMAT = "월드 #%s";
elseif locale == "cn" then
	L.RANK_FORMAT = "世界 #%s";
elseif locale == "tw" then
	L.RANK_FORMAT = "世界 #%s";
end