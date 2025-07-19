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
	return colorStringFormat:format(
		BindComponent(r),
		BindComponent(g),
		BindComponent(b));
end
local function RGBToHSV(r, g, b)
  CS:SetColorRGB(r, g, b);
  local h,s,v = CS:GetColorHSV()
  return {h=h,s=s,v=v}
end

-- Generates a Color Scale between Red and Green with the Blue Completed color for 100%
local colors, red, green, h = app.Colors, RGBToHSV(1,0,0), RGBToHSV(0,1,0);
local ProgressColors = setmetatable({
	[1] = "ff15abff",	-- ATT's 'Completed' Color
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
local function FormatNumericWithCommas(amount)
  local k
  while true do
	amount, k = tostring(amount):gsub("^(-?%d+)(%d%d%d)", '%1,%2')
	if k == 0 then
		break
	end
  end
  return amount
end
local function GetNumberWithZeros(number, desiredLength)
	if desiredLength > 0 then
		local str = tostring(number);
		local length = str:len();
		local pos = str:find("[.]");
		if not pos then
			str = str .. ".";
			for i=desiredLength,1,-1 do
				str = str .. "0";
			end
		else
			local totalExtra = desiredLength - (length - pos);
			for i=totalExtra,1,-1 do
				str = str .. "0";
			end
			if totalExtra < 1 then
				str = str:sub(1, pos + desiredLength);
			end
		end
		return str;
	else
		return tostring(floor(number));
	end
end
local function GetProgressColorText(progress, total)
	if total and total > 0 then
		local percent = min(1, (progress or 0) / total);
		return "|c" .. ProgressColors[percent] .. FormatNumericWithCommas(progress) .. " / " .. FormatNumericWithCommas(total) .. " (" .. GetNumberWithZeros(percent * 100, 2) .. "%)|r";
	end
end
local function GetRankColorText(rank)
	if rank then
		-- This is where you would determine a color based on the rank? (Maybe legendary for Top 10, Purple for Top 250, etc)
		return FormatNumericWithCommas(rank);
	end
	return "??";
end
local function AttachCharacterData(self, guid)
	if guid then
		-- Uncomment for debugging
		-- self:AddDoubleLine("GUID", guid);
		local data = app.CHARACTER_DATA[guid];
		if data then
			self:AddLine(" ");
			self:AddDoubleLine(L.DATAFORAZEROTH, GetProgressColorText(data[1],data[2]));
			self:AddDoubleLine(" ", L.RANK_FORMAT:format(GetRankColorText(data[3])));
		end
	end
end

-- Tooltip API Differences between Modern and Legacy APIs.
if TooltipDataProcessor and select(4, GetBuildInfo()) > 100000 then
	-- 10.0.2
	-- https://wowpedia.fandom.com/wiki/Patch_10.0.2/API_changes#Tooltip_Changes
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
else
	-- Pre-10.0.2 (Legacy)
	local function AttachTooltip(self)
		if CanAttachTooltips() and not self.DataForAzerothProcessing then
			self.DataForAzerothProcessing = true;

			-- Does the tooltip have a target?
			local target = select(2, self:GetUnit());
			if target then AttachCharacterData(self, UnitGUID(target)); end
			
			-- Ensure that the processing state gets removed once the tooltip is cleared
			if not self.DataForAzerothOnTooltipClearedHook then
				pcall(self.HookScript, self, "OnTooltipCleared", ClearTooltip)
				self.DataForAzerothOnTooltipClearedHook = true;
			end
		end
	end
	GameTooltip:HookScript("OnTooltipSetUnit", AttachTooltip);
	GameTooltip:HookScript("OnShow", AttachTooltip);
end