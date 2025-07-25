local appName, app = ...;
local L = {}; app.L = L;

-- English Strings
L.DATAFORAZEROTH = "|TInterface/Addons/DataForAzeroth/assets/Logo:0|t Data for Azeroth";
L.RANK_FORMAT = "World #%s Region #%s Realm #%s";

-- Localize the Rank Format string
local locale = GetLocale():sub(3,4):lower();
if locale == "es" then
	L.RANK_FORMAT = "Mundo #%s Región #%s Reino #%s";
elseif locale == "mx" then
	L.RANK_FORMAT = "Mundo #%s Región #%s Reino #%s";
elseif locale == "de" then
	L.RANK_FORMAT = "Welt #%s Region #%s Server #%s";
elseif locale == "fr" then
	L.RANK_FORMAT = "Monde #%s Région #%s Royaume #%s";
elseif locale == "it" then
	L.RANK_FORMAT = "Mondo #%s Regione #%s Regno #%s";
elseif locale == "pt" then
	L.RANK_FORMAT = "Mundo #%s Região #%s Reino #%s";
elseif locale == "ru" then
	L.RANK_FORMAT = "Мир #%s Регион #%s Сервер #%s";
elseif locale == "ko" then
	L.RANK_FORMAT = "월드 #%s 지역 #%s 영역 #%s";
elseif locale == "cn" then
	L.RANK_FORMAT = "世界 #%s 地区 #%s 领域 #%s";
elseif locale == "tw" then
	L.RANK_FORMAT = "世界 #%s 地區 #%s 領域 #%s";
end