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
local locale = GetLocale();
local lang = locale:sub(1,2);
if lang == "es" then
    L.RANK_FORMAT = "Mundo #%s  Región #%s  Reino #%s";
    L.SETTINGS_GENERAL = "General";
    L.SETTINGS_TOOLTIPS = "Descripciones";
    L.ShareAlts_Setting = "Compartir alters con otros jugadores";
    L.ShareAlts_Tooltip = "Permitirá que otros jugadores vean tu información de Data for Azeroth cuando juegues con un alter. Esto podría permitirles averiguar quién es tu personaje principal.";
    L.HideScore_Setting = "Ocultar puntuación";
    L.HideScore_Tooltip = "Oculta la puntuación de finalización en la descripción de Data for Azeroth.";
    L.HideMax_Setting = "Ocultar máximo";
    L.HideMax_Tooltip = "Oculta la puntuación máxima posible en la descripción de Data for Azeroth.";
    L.HidePercent_Setting = "Ocultar porcentaje";
    L.HidePercent_Tooltip = "Oculta el porcentaje en la descripción de Data for Azeroth.";
    L.HideRank_Setting = "Ocultar clasificaciones";
    L.HideRank_Tooltip = "Oculta las clasificaciones Mundo/Región/Reino en la descripción de Data for Azeroth.";
elseif lang == "de" then
    L.RANK_FORMAT = "Welt #%s  Region #%s  Server #%s";
    L.SETTINGS_GENERAL = "Allgemein";
    L.SETTINGS_TOOLTIPS = "Tooltips";
    L.ShareAlts_Setting = "Alts mit anderen Spielern teilen";
    L.ShareAlts_Tooltip = "Ermöglicht anderen Spielern, deine Data-for-Azeroth-Informationen zu sehen, wenn du einen Alt spielst. Dies könnte ihnen ermöglichen, herauszufinden, wer dein Hauptcharakter ist.";
    L.HideScore_Setting = "Wertung verbergen";
    L.HideScore_Tooltip = "Verbirgt die gesamtwertung im Data for Azeroth Tooltip.";
    L.HideMax_Setting = "Maximum verbergen";
    L.HideMax_Tooltip = "Verbirgt die maximal mögliche gesamtwertung im Data for Azeroth Tooltip.";
    L.HidePercent_Setting = "Prozent verbergen";
    L.HidePercent_Tooltip = "Verbirgt den Prozentsatz im Data for Azeroth Tooltip.";
    L.HideRank_Setting = "Ranglisten verbergen";
    L.HideRank_Tooltip = "Verbirgt die Welt-/Region-/Server-Ranglisten im Data for Azeroth Tooltip.";
elseif lang == "fr" then
    L.RANK_FORMAT = "Monde #%s  Région #%s  Royaume #%s";
    L.SETTINGS_GENERAL = "Général";
    L.SETTINGS_TOOLTIPS = "Infobulles";
    L.ShareAlts_Setting = "Partager les rerolls avec d'autres joueurs";
    L.ShareAlts_Tooltip = "Permettre à d'autres joueurs de voir vos informations Data for Azeroth lorsque vous jouez un reroll. Cela pourrait leur permettre de découvrir qui est votre personnage principal.";
    L.HideScore_Setting = "Masquer le score";
    L.HideScore_Tooltip = "Masque le score de complétion dans l'infobulle Data for Azeroth.";
    L.HideMax_Setting = "Masquer le maximum";
    L.HideMax_Tooltip = "Masque le score de complétion maximal possible dans l'infobulle Data for Azeroth.";
    L.HidePercent_Setting = "Masquer le pourcentage";
    L.HidePercent_Tooltip = "Masque le pourcentage dans l'infobulle Data for Azeroth.";
    L.HideRank_Setting = "Masquer les classements";
    L.HideRank_Tooltip = "Masque les classements Monde/Région/Royaume dans l'infobulle Data for Azeroth.";
elseif lang == "it" then
    L.RANK_FORMAT = "Mondo #%s  Regione #%s  Regno #%s";
    L.SETTINGS_GENERAL = "Generale";
    L.SETTINGS_TOOLTIPS = "Suggerimenti";
    L.ShareAlts_Setting = "Condividi Alt con altri giocatori";
    L.ShareAlts_Tooltip = "Permetterà agli altri giocatori di vedere le tue informazioni Data for Azeroth quando giochi con un alt. Questo potrebbe permettere loro di capire chi è il tuo personaggio principale.";
    L.HideScore_Setting = "Nascondi punteggio";
    L.HideScore_Tooltip = "Nasconde il punteggio di completamento nel suggerimento Data for Azeroth.";
    L.HideMax_Setting = "Nascondi massimo";
    L.HideMax_Tooltip = "Nasconde il punteggio massimo possibile nel suggerimento Data for Azeroth.";
    L.HidePercent_Setting = "Nascondi percentuale";
    L.HidePercent_Tooltip = "Nasconde la percentuale nel suggerimento Data for Azeroth.";
    L.HideRank_Setting = "Nascondi classifiche";
    L.HideRank_Tooltip = "Nasconde le classifiche Mondo/Regione/Reame nel suggerimento Data for Azeroth.";
elseif lang == "pt" then
    L.RANK_FORMAT = "Mundo #%s  Região #%s  Reino #%s";
    L.SETTINGS_GENERAL = "Geral";
    L.SETTINGS_TOOLTIPS = "Dicas";
    L.ShareAlts_Setting = "Compartilhar Alts com outros jogadores";
    L.ShareAlts_Tooltip = "Permitirá que outros jogadores vejam suas informações de Data for Azeroth quando você estiver jogando com um alt. Isso pode permitir que eles descubram quem é seu personagem principal.";
    L.HideScore_Setting = "Ocultar pontuação";
    L.HideScore_Tooltip = "Oculta a pontuação de conclusão na dica de Data for Azeroth.";
    L.HideMax_Setting = "Ocultar máximo";
    L.HideMax_Tooltip = "Oculta a pontuação máxima possível na dica de Data for Azeroth.";
    L.HidePercent_Setting = "Ocultar porcentagem";
    L.HidePercent_Tooltip = "Oculta a porcentagem na dica de Data for Azeroth.";
    L.HideRank_Setting = "Ocultar classificações";
    L.HideRank_Tooltip = "Oculta as classificações Mundo/Região/Reino na dica de Data for Azeroth.";
elseif lang == "ru" then
    L.RANK_FORMAT = "Мир #%s  Регион #%s  Сервер #%s";
    L.SETTINGS_GENERAL = "Общее";
    L.SETTINGS_TOOLTIPS = "Подсказки";
    L.ShareAlts_Setting = "Делиться альтами с другими игроками";
    L.ShareAlts_Tooltip = "Позволит другим игрокам видеть ваши данные Data for Azeroth, когда вы играете на альте. Это может позволить им узнать, кто ваш основной персонаж.";
    L.HideScore_Setting = "Скрыть очки";
    L.HideScore_Tooltip = "Скрывает отображение очков в подсказке Data For Azeroth.";
    L.HideMax_Setting = "Скрыть максимум";
    L.HideMax_Tooltip = "Скрывает максимально возможные очки в подсказке Data For Azeroth.";
    L.HidePercent_Setting = "Скрыть процент";
    L.HidePercent_Tooltip = "Скрывает процент в подсказке Data For Azeroth.";
    L.HideRank_Setting = "Скрыть рейтинги";
    L.HideRank_Tooltip = "Скрывает рейтинги Мир/Регион/Сервер в подсказке Data For Azeroth.";
elseif lang == "ko" then
    L.RANK_FORMAT = "월드 #%s  지역 #%s  영역 #%s";
    L.SETTINGS_GENERAL = "일반";
    L.SETTINGS_TOOLTIPS = "툴팁";
    L.ShareAlts_Setting = "다른 플레이어와 부캐 공유";
    L.ShareAlts_Tooltip = "부캐로 플레이할 때 다른 플레이어가 아제로스를 위한 데이터 정보를 볼 수 있습니다. 이를 통해 메인 캐릭터를 알아낼 수 있습니다.";
    L.HideScore_Setting = "점수 숨기기";
    L.HideScore_Tooltip = "아제로스를 위한 데이터 툴팁에서 완료 점수를 숨깁니다.";
    L.HideMax_Setting = "최대값 숨기기";
    L.HideMax_Tooltip = "아제로스를 위한 데이터 툴팁에서 가능한 최대 완료 점수를 숨깁니다.";
    L.HidePercent_Setting = "퍼센트 숨기기";
    L.HidePercent_Tooltip = "아제로스를 위한 데이터 툴팁에서 퍼센트를 숨깁니다.";
    L.HideRank_Setting = "순위 숨기기";
    L.HideRank_Tooltip = "아제로스를 위한 데이터 툴팁에서 월드/지역/영역 순위를 숨깁니다.";
elseif locale == "zhCN" then
    L.RANK_FORMAT = "世界 #%s  地区 #%s  领域 #%s";
    L.SETTINGS_GENERAL = "常规";
    L.SETTINGS_TOOLTIPS = "提示";
    L.ShareAlts_Setting = "与其他玩家分享小号";
    L.ShareAlts_Tooltip = "当你玩小号时，允许其他玩家查看你的艾泽拉斯数据信息。这可能会让他们知道你的主角色是谁。";
    L.HideScore_Setting = "隐藏分数";
    L.HideScore_Tooltip = "在艾泽拉斯数据提示中隐藏完成分数。";
    L.HideMax_Setting = "隐藏最大值";
    L.HideMax_Tooltip = "在艾泽拉斯数据提示中隐藏最大可能完成分数。";
    L.HidePercent_Setting = "隐藏百分比";
    L.HidePercent_Tooltip = "在艾泽拉斯数据提示中隐藏百分比。";
    L.HideRank_Setting = "隐藏排名";
    L.HideRank_Tooltip = "在艾泽拉斯数据提示中隐藏世界/地区/领域排名。";
elseif locale == "zhTW" then
    L.RANK_FORMAT = "世界 #%s  地區 #%s  領域 #%s";
    L.SETTINGS_GENERAL = "一般";
    L.SETTINGS_TOOLTIPS = "提示";
    L.ShareAlts_Setting = "與其他玩家分享小號";
    L.ShareAlts_Tooltip = "當你玩小號時，允許其他玩家查看你的艾澤拉斯資料資訊。這可能會讓他們知道你的主角色是誰。";
    L.HideScore_Setting = "隱藏分數";
    L.HideScore_Tooltip = "在艾澤拉斯資料提示中隱藏完成分數。";
    L.HideMax_Setting = "隱藏最大值";
    L.HideMax_Tooltip = "在艾澤拉斯資料提示中隱藏最大可能完成分數。";
    L.HidePercent_Setting = "隱藏百分比";
    L.HidePercent_Tooltip = "在艾澤拉斯資料提示中隱藏百分比。";
    L.HideRank_Setting = "隱藏排名";
    L.HideRank_Tooltip = "在艾澤拉斯資料提示中隱藏世界/地區/領域排名。";
end