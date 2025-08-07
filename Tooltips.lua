local appName, app = ...;
local L = app.L;

-- Globals Cache
local floor, max, min, pcall, select, tonumber, tostring
    = floor, max, min, pcall, select, tonumber, tostring;

-- Module locals
-- This part was taken from AllTheThings with Crieve's permission
local CS = CreateFrame("ColorSelect", nil, app.frame);
CS:Hide();

-- This returns values between 0 and 1, not 0 and 255!
-- Color AARRGGBB values used throughout ATT
local colorStringFormat = "ff%02x%02x%02x";
local function BindComponent(c)
    -- Binds a color component value (0 and 1) to (0 and 255) instead.
    return min(255, max(0, (c or 0) * 255));
end
local function HexToARGB(hex)
    return tonumber("0x"..hex:sub(1,2)) / 255, tonumber("0x"..hex:sub(3,4)) / 255, tonumber("0x"..hex:sub(5,6)) / 255, tonumber("0x"..hex:sub(7,8)) / 255;
end
local function RGBToHex(r, g, b)
    return colorStringFormat:format(BindComponent(r), BindComponent(g), BindComponent(b));
end
local function RGBToHSV(r, g, b)
    CS:SetColorRGB(r, g, b);
    local h,s,v = CS:GetColorHSV()
    return {h=h,s=s,v=v}
end

-- Generates a Color Scale between Red and Green with the Blue Completed color for 100%
local colors, red, green, h = app.Colors, RGBToHSV(1,0,0), RGBToHSV(0,1,0);
local ProgressColors = setmetatable({
    [1] = "ff15abff",    -- ATT's 'Completed' Color
}, {
    __index = function(t, p)
        p = tonumber(p);
        -- anything over 100% will just be 100% color
        if p > 1 then return t[1]; end
        -- anything somehow under 0 will just be 0
        if p < 0 then return t[0]; end
        if abs(red.h - green.h) > 180 then
            local angle = (360 - abs(red.h - green.h)) * p;
            if red.h < green.h then
                h = floor(red.h - angle);
                if h < 0 then h = 360 + h end
            else
                h = floor(red.h + angle);
                if h > 360 then h = h - 360 end
            end
        else
            h = floor(red.h-(red.h-green.h)*p)
        end
        CS:SetColorHSV(h, red.s-(red.s-green.s)*p, red.v-(red.v-green.v)*p);
        local r,g,b = CS:GetColorRGB();
        local color = RGBToHex(r, g, b);
        t[p] = color;
        return color;
    end
});

local function CanAttachTooltips()
    return true;
end
local function ClearTooltip(self)
    self.DataForAzerothProcessing = nil;
end
local function GetProgressColorText(progress, total)
    if total and total > 0 then
        local percent = min(1, (progress or 0) / total);

        local strmax, strpercent = "", "";
        if not DFA_SETTINGS.HideMax then strmax = " / " .. BreakUpLargeNumbers(total) end
        if not DFA_SETTINGS.HidePercent then strpercent = " (" .. string.format("%.2f", 100 * percent) .. "%)" end

        return "|c" .. ProgressColors[percent] .. BreakUpLargeNumbers(progress) .. strmax .. strpercent .. "|r";
    end
end
local function GetRankColorText(rank)
    if rank then
        -- This is where you would determine a color based on the rank? (Maybe legendary for Top 10, Purple for Top 250, etc)
        return BreakUpLargeNumbers(rank);
    end
    return "??";
end
local function AttachCharacterData(self, guid)
    if guid then
        -- Uncomment for debugging
        -- self:AddDoubleLine("GUID", guid);
        guid = app.ALTS[guid] or guid; -- lookup main character's GUID, if it exists
        local data = app.CHARACTER_DATA[guid:gsub("Player%-", "")];
        if data then
            -- we have data, so add it to the tooltip
            self:AddLine(" ");
            self:AddLine(L.DATAFORAZEROTH);
            if not DFA_SETTINGS.HideScore then
                self:AddLine(GetProgressColorText(data[1],app.MAX_SCORE));
            end
            if not DFA_SETTINGS.HideRank then
                self:AddLine(L.RANK_FORMAT:format(GetRankColorText(data[2]), GetRankColorText(data[3]), GetRankColorText(data[5])));
            end
        elseif app.ALTS[guid] == nil then
            -- the target could be on an alt, whisper them ONCE to get their GUID
            -- won't get a response if they don't have the addon or are hiding alts
            local _, _, _, _, _, name, realm = GetPlayerInfoByGUID(guid);
            if name and name ~= "" then
                if realm and realm ~= "" then name = name .. "-" .. realm end

                app.ALTS[guid] = false; -- prevents future whispers
                --C_ChatInfo.SendAddonMessage("DFA", "WHO", "WHISPER", name); -- broken in 11.2?
            end
        end
    end
end

local TooltipUtil = TooltipUtil;
local function AttachTooltip(self, ttdata)
    if CanAttachTooltips() and not self.DataForAzerothProcessing then
        self.DataForAzerothProcessing = true;
        AttachCharacterData(self, select(3, TooltipUtil.GetDisplayedUnit(self)));
        
        -- Ensure that the processing state gets removed once the tooltip is cleared
        if not self.DataForAzerothOnTooltipClearedHook then
            pcall(self.HookScript, self, "OnTooltipCleared", ClearTooltip)
            self.DataForAzerothOnTooltipClearedHook = true;
        end
    end
end

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, AttachTooltip);

-- Adds custom tooltip lines to each guild roster member in the Communities Frame
local function AddGuildRosterTooltip()
    local scrollTarget = CommunitiesFrame
        and CommunitiesFrame.MemberList
        and CommunitiesFrame.MemberList.ScrollBox
        and CommunitiesFrame.MemberList.ScrollBox.ScrollTarget
    if not scrollTarget then return end

    for _, button in ipairs({ scrollTarget:GetChildren() }) do
        if button and not button.tooltipHooked then
            button:HookScript("OnEnter", function(self)
                local memberInfo = self.GetMemberInfo and self:GetMemberInfo()
                if not memberInfo then return end

                local guid = memberInfo.guid
                if guid then
                    AttachCharacterData(GameTooltip, guid)
                end

                GameTooltip:Show()
            end)

            button.tooltipHooked = true
        end
    end
end

-- Checks if the currently selected community tab is the guild tab
local function IsCurrentTabGuild()
    local selectedClubId = CommunitiesFrame and CommunitiesFrame:GetSelectedClubId()
    if not selectedClubId then return false end

    local clubInfo = C_Club.GetClubInfo(selectedClubId)
    return clubInfo and clubInfo.clubType == Enum.ClubType.Guild
end

-- Event handler for guild roster changes
local function GuildRosterEventHandler()
    if CommunitiesFrame and CommunitiesFrame:IsShown() and IsCurrentTabGuild() then
        AddGuildRosterTooltip()
    end
end

-- Sets up event hooks to add tooltips when appropriate
app:OnEvent("PLAYER_ENTERING_WORLD", GuildRosterEventHandler);
app:OnEvent("GUILD_ROSTER_UPDATE", GuildRosterEventHandler);