﻿--[[
Name: FishLib-1.0
Maintainers: Sutorix <sutorix@hotmail.com>
Description: A library with common routines used by Fishing Buddy and Fishing Ace.
Copyright (c) by Bob Schumaker
Licensed under a Creative Commons "Attribution Non-Commercial Share Alike" License
--]]

local MAJOR_VERSION = "LibFishing-1.0"
local MINOR_VERSION = 90000 + tonumber(("$Rev: 503 $"):match("%d+"))

if not LibStub then error(MAJOR_VERSION .. " requires LibStub") end

local FishLib, oldLib = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not FishLib then
	return
end

local Crayon = LibStub("LibCrayon-3.0");
local BL = LibStub("LibBabble-Zone-3.0"):GetBaseLookupTable();
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local BZR = LibStub("LibBabble-Zone-3.0"):GetReverseLookupTable();
local LT = LibStub("LibTourist-3.0");
local BSL = LibStub("LibBabble-SubZone-3.0"):GetBaseLookupTable();
local BSZ = LibStub("LibBabble-SubZone-3.0"):GetLookupTable();
local BSZR = LibStub("LibBabble-SubZone-3.0"):GetReverseLookupTable();

FishLib.UNKNOWN = "UNKNOWN";

local WOW = {};
function FishLib:WOWVersion()
	return WOW.major, WOW.minor, WOW.dot;
end

if ( GetBuildInfo ) then
	local v, b, d = GetBuildInfo();
	WOW.build = b;
	WOW.date = d;
	local s,e,maj,min,dot = string.find(v, "(%d+).(%d+).(%d+)");
	WOW.major = tonumber(maj);
	WOW.minor = tonumber(min);
	WOW.dot = tonumber(dot);
else
	WOW.major = 1;
	WOW.minor = 9;
	WOW.dot = 0;
end

function FishLib:GetFishingSkillInfo()
	local _, _, _, fishing, _, _ = GetProfessions();
	if ( fishing ) then
		local name, _, _, _, _, _, _ = GetProfessionInfo(fishing);
		-- is this always the same as PROFESSIONS_FISHING?
		return true, name;
	end
	return false, PROFESSIONS_FISHING;
end

-- get our current fishing skill level
function GetCurrentSkill(self)
	local _, _, _, fishing, _, _ = GetProfessions();
	if (fishing) then
		local name, _, rank, skillmax, _, _, _, mods = GetProfessionInfo(fishing);
		local _, lure = FishLib:GetPoleBonus();
		return rank, mods, skillmax, lure;
	end
	return 0, 0, 0;
end
FishLib.GetCurrentSkill = GetCurrentSkill;

-- Lure library
local FISHINGLURES = {
	{	["id"] = 34832,
		["n"] = "Captain Rumsey's Lager",			     -- 10 for 3 mins
		["b"] = 10,
		["s"] = 1,
		["d"] = 3,
		["u"] = 1,
	},
	{	["id"] = 6529,
		["n"] = "Shiny Bauble",							  -- 25 for 10 mins
		["b"] = 25,
		["s"] = 1,
		["d"] = 10,
	},
	{	["id"] = 6811,
		["n"] = "Aquadynamic Fish Lens",				  -- 50 for 10 mins
		["b"] = 50,
		["s"] = 50,
		["d"] = 10,
	},
	{	["id"] = 6530,
		["n"] = "Nightcrawlers",						  -- 50 for 10 mins
		["b"] = 50,
		["s"] = 50,
		["d"] = 10,
	},
	{	["id"] = 33820,
		["n"] = "Weather-Beaten Fishing Hat",		  -- 75 for 10 minutes
		["b"] = 75,
		["s"] = 1,
		["d"] = 10,
		["w"] = true,
	},
	{	["id"] = 7307,
		["n"] = "Flesh Eating Worm",					  -- 75 for 10 mins
		["b"] = 75,
		["s"] = 100,
		["d"] = 10,
	},
	{	["id"] = 6532,
		["n"] = "Bright Baubles",						  -- 75 for 10 mins
		["b"] = 75,
		["s"] = 100,
		["d"] = 10,
	},
	{	["id"] = 34861,
		["n"] = "Sharpened Fish Hook",				  -- 100 for 10 minutes
		["b"] = 100,
		["s"] = 100,
		["d"] = 10,
	},
	{	["id"] = 6533,
		["n"] = "Aquadynamic Fish Attractor",		  -- 100 for 10 minutes
		["b"] = 100,
		["s"] = 100,
		["d"] = 10,
	},
	{	["id"] = 62673,
		["n"] = "Feathered Lure",					  -- 100 for 10 minutes
		["b"] = 100,
		["s"] = 100,
		["d"] = 10,
	},
	{	["id"] = 46006,
		["n"] = "Glow Worm",							  -- 100 for 60 minutes
		["b"] = 100,
		["s"] = 100,
		["d"] = 60,
	},
	{	["id"] = 68049,
		["n"] = "Heat-Treated Spinning Lure",		  -- 150 for 5 minutes
		["b"] = 150,
		["s"] = 250,
		["d"] = 5,
	},
	{	["id"] = 67404,
		["n"] = "Glass Fishing Bobber",				  -- ???
		["b"] = 15,
		["s"] = 1,
		["d"] = 10,
	},
}

-- sort ascending bonus and ascending time
-- we may have to treat "Heat-Treated Spinning Lure" differently someday
table.sort(FISHINGLURES,
	function(a,b)
		if ( a.b == b.b ) then
			return a.d < b.d;
		else
			return a.b < b.b;
		end
	end);

function FishLib:GetLureTable()
	return FISHINGLURES;
end

function FishLib:IsWorn(itemid)
	for slot=1,19 do
		local link = GetInventoryItemLink("player", slot);
		if ( link ) then
			local _, id, _ = self:SplitFishLink(link);
			if ( itemid == id ) then
				return true;
			end
		end
	end
	-- return nil
end

local useinventory = {};
local lureinventory = {};
function UpdateLureInventory()
	local rawskill, _, _, _ = GetCurrentSkill();

	useinventory  = {};
	lureinventory	= {};
	for _,lure in ipairs(FISHINGLURES) do
		local id = lure.id;
		local count = GetItemCount(id);
		-- does this lure have to be "worn"
		if ( count > 0 ) then
			if ( lure.u ) then
				tinsert(useinventory, lure);
			elseif ( lure.s <= rawskill ) then
				if ( not lure.w or FishLib:IsWorn(id)) then
					tinsert(lureinventory, lure);
				end
			end
			-- get the name so we can check enchants
			lure.n,_,_,_,_,_,_,_,_,_ = GetItemInfo(id);
		end
	end
	return lureinventory, useinventory;
 end
FishLib.UpdateLureInventory = UpdateLureInventory;

function FishLib:GetLureInventory()
	return lureinventory, useinventory;
end

-- Deal with lures
function FishLib:HasBuff(buffName)
	if ( buffName ) then
		 local name, _, _, _, _, _, _, _, _ = UnitBuff("player", buffName);	  
		 return name ~= nil;
	end
	-- return nil
end

function FishLib:FindNextLure(b, state)
	local n = table.getn(lureinventory);
	for s=state+1,n,1 do
		if ( lureinventory[s] ) then
			local id = lureinventory[s].id;
			local startTime, _, _ = GetItemCooldown(id);
			if ( startTime == 0 ) then
				if ( not b or lureinventory[s].b > b ) then 
					return s, lureinventory[s];
				end
			end
		end
	end
	-- return nil;
end

local function UseThisLure(lure, b, enchant, skill, level)
	if ( lure ) then
		local startTime, _, _ = GetItemCooldown(lure.id);
		-- already check for skill being nil, so that will skip the whole check with level
		-- skill = skill or 0;
		level = level or 0;
		local bonus = lure.b or 0;
		if ( startTime == 0 and (skill and level <= (skill + bonus)) and (bonus > enchant) ) then
			if ( not b or bonus > b ) then 
				return true, bonus;
			end
		end
		return false, bonus;
	end
	return false, 0;
end

function FishLib:FindBestLure(b, state, usedrinks)
	local zone, subzone = self:GetZoneInfo();
	local level = self:GetFishingLevel(zone, subzone);
	if ( level and level > 1 ) then
		local rank, modifier, skillmax, enchant = self:GetCurrentSkill();
		local skill = rank + modifier;
		-- don't need this now, LT has the full values
		-- level = level + 95;		-- for no lost fish
		if ( skill < level ) then
			-- if drinking will work, then we're done
			if ( usedrinks and #useinventory > 0 ) then
				if ( not LastUsed or not self:HasBuff(LastUsed.n) ) then
					local id = useinventory[1].id;
					if ( not self:HasBuff(useinventory[1].n) ) then
						if ( level <= (skill + useinventory[1].b) ) then
							return nil, useinventory[1];
						end
					end
				end
			end
			skill = skill - enchant;
			state = state or 0;
			local checklure;
			local useit, b = 0;
			for s=state+1,#lureinventory,1 do
				checklure = lureinventory[s];
				useit, b = UseThisLure(checklure, b, enchant, skill, level);
				if ( useit and b and b > 0 ) then
					return s, checklure;
				end
			end

			-- if we ran off the end of the table and we had a valid lure, let's use that one
			if ( (not enchant or enchant == 0) and b and (b > 0) and checklure ) then
				return #lureinventory, checklure;
			end
		end
		-- return nil;
	else
		return self:FindNextLure(b, state);
	end
	-- return nil;
end

-- Handle events we care about
local canCreateFrame = false;
local isLooting = false;
local countCatches = false;
local caughtSoFar = 0;

local libfishframe = CreateFrame("Frame");
libfishframe:RegisterEvent("UPDATE_CHAT_WINDOWS");
libfishframe:RegisterEvent("LOOT_OPENED");
libfishframe:RegisterEvent("LOOT_SLOT_CLEARED");
libfishframe:RegisterEvent("LOOT_CLOSED");
libfishframe:RegisterEvent("SKILL_LINES_CHANGED");
libfishframe:RegisterEvent("UNIT_INVENTORY_CHANGED");

libfishframe:SetScript("OnEvent", function(self, event, ...)
	if ( event == "UPDATE_CHAT_WINDOWS" ) then
		canCreateFrame = true;
		self:UnregisterEvent(event);
	elseif ( event == "SKILL_LINES_CHANGED" or event == "UNIT_INVENTORY_CHANGED") then
		UpdateLureInventory();
	elseif (event == "LOOT_OPENED") then
		if ( IsFishingLoot() ) then
			isLooting = true;
			countCatches = true;
		end
	elseif ( event == "LOOT_SLOT_CLEARED" ) then
		if ( countCatches ) then
			caughtSoFar = caughtSoFar + 1;
			-- it only counts as one "catch", regardless of how many things we actually got
			countCatches = false;
		end
	elseif ( event == "LOOT_CLOSED" ) then
		isLooting = false;
		countCatches = false;
	end
end);

local bobber = {};
bobber["enUS"] = "Fishing Bobber";
bobber["esES"] = "Anzuelo";
bobber["esMX"] = "Anzuelo";
bobber["deDE"] = "Schwimmer";
bobber["frFR"] = "Flotteur";
bobber["ruRU"] = "Поплавок";
bobber["zhTW"] = "釣魚浮標";
bobber["zhCN"] = "垂钓水花";

local locale = GetLocale();
if ( bobber[locale] ) then
	FishLib.BOBBER_NAME = bobber[locale];
else
	FishLib.BOBBER_NAME = bobber["enUS"];
end

-- override our choice if you know better
function FishLib:SetBobberName(name)
	self.BOBBER_NAME = name;
end

-- set up a table of slot mappings for looking up item information
local slotinfo = {
	[0] = { name = "AmmoSlot", },
	[1] = { name = "HeadSlot", },
	[2] = { name = "NeckSlot", },
	[3] = { name = "ShoulderSlot", },
	[4] = { name = "ShirtSlot", },
	[5] = { name = "BackSlot", },
	[6] = { name = "ChestSlot", },
	[7] = { name = "WaistSlot", },
	[8] = { name = "LegsSlot", },
	[9] = { name = "FeetSlot", },
	[10] = { name = "WristSlot", },
	[11] = { name = "HandsSlot", },
	[12] = { name = "Finger0Slot", },
	[13] = { name = "Finger1Slot", },
	[14] = { name = "Trinket0Slot", },
	[15] = { name = "Trinket1Slot", },
	[16] = { name = "MainHandSlot", },
	[17] = { name = "SecondaryHandSlot", },
	[18] = { name = "RangedSlot", },
	[19] = { name = "TabardSlot", },
}
for i=0,19,1 do
	local sn = slotinfo[i].name;
	slotinfo[i].id, _ = GetInventorySlotInfo(sn);
end
local mainhand = slotinfo[16].id;

-- A map of item types to locations
local slotmap = {
	["INVTYPE_AMMO"] = { 0 },
	["INVTYPE_HEAD"] = { 1 },
	["INVTYPE_NECK"] = { 2 },
	["INVTYPE_SHOULDER"] = { 3 },
	["INVTYPE_BODY"] = { 4 },
	["INVTYPE_CHEST"] = { 5 },
	["INVTYPE_ROBE"] = { 5 },
	["INVTYPE_CLOAK"] = { 5 },
	["INVTYPE_WAIST"] = { 7 },
	["INVTYPE_LEGS"] = { 8 },
	["INVTYPE_FEET"] = { 9 },
	["INVTYPE_WRIST"] = { 10 },
	["INVTYPE_HAND"] = { 11 },
	["INVTYPE_FINGER"] = { 12,13 },
	["INVTYPE_TRINKET"] = { 14,15 },
	["INVTYPE_WEAPON"] = { 16,17 },
	["INVTYPE_SHIELD"] = { 17 },
	["INVTYPE_2HWEAPON"] = { 16 },
	["INVTYPE_WEAPONMAINHAND"] = { 16 },
	["INVTYPE_WEAPONOFFHAND"] = { 17 },
	["INVTYPE_HOLDABLE"] = { 17 },
	["INVTYPE_RANGED"] = { 18 },
	["INVTYPE_THROWN"] = { 18 },
	["INVTYPE_RANGEDRIGHT"] = { 18 },
	["INVTYPE_RELIC"] = { 18 },
	["INVTYPE_TABARD"] = { 19 },
	["INVTYPE_BAG"] = { 20,21,22,23 },
	["INVTYPE_QUIVER"] = { 20,21,22,23 }, 
	[""] = { },
};

function FishLib:copytable(tab, level)
	local t = {};
	if (tab) then
		level = level or 10000;
		for k,v in pairs(tab) do
			if ( type(v) == "table" and level > 0 ) then
				level = level - 1;
				t[k] = self:copytable(v, level);
			else
				t[k] = v;
			end
		end
	end
	return t;
end

-- count tables that don't have monotonic integer indexes
function FishLib:tablecount(tab)
	local n = 0;
	for k,v in pairs(tab) do
		n = n + 1;
	end
	return n;
end

-- return a printable representation of a value
function FishLib:printable(val)
	if ( val == nil ) then
		return "nil";
	elseif (type(val) == "boolean") then
		return val and "true" or "false";
	else
		return ""..val;
	end
end

-- this changes all the damn time
-- "|c(%x+)|Hitem:(%d+)(:%d+):%d+:%d+:%d+:%d+:[-]?%d+:[-]?%d+:[-]?%d+:[-]?%d+|h%[(.*)%]|h|r"
-- go with a fixed pattern, since sometimes the hyperlink trick appears not to work
local _itempattern = "|c(%x+)|Hitem:([^:]+):([^:]+)[-:%d]+|h%[(.*)%]|h|r"

function FishLib:GetItemPattern()
	if ( not _itempattern ) then
		-- This should work all the time
		self:GetPoleType(); -- force the default pole into the cache
		local _, pat, _, _, _, _, _, _ = GetItemInfo(6256);
		pat = string.gsub(pat, "|c(%x+)|Hitem:(%d+)(:%d+)", "|c(%%x+)|Hitem:(%%d+)(:%%d+)");
		pat = string.gsub(pat, ":[-]?%d+", ":[-]?%%d+");
		_itempattern = string.gsub(pat, "|h%[(.*)%]|h|r", "|h%%[(.*)%%]|h|r");
	end
	return _itempattern;
end

function FishLib:SplitLink(link)
	if ( link ) then
		local _,_, color, id, enchant, name = string.find(link, self:GetItemPattern());
		if ( name ) then
			return color, id..":"..enchant, name, enchant;
		end
	end
end

function FishLib:SplitFishLink(link)
	if ( link ) then
		local _,_, color, id, enchant, name = string.find(link, self:GetItemPattern());
		return color, tonumber(id), name, enchant;
	end
end

function FishLib:GetItemInfo(link)
-- name, link, rarity, itemlevel, minlevel, itemtype
-- subtype, stackcount, equiploc, texture
	local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(link);
	return itemName, itemLink, itemRarity, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemLevel, itemSellPrice;
end

function FishLib:IsLinkableItem(item)
	local link = "item:"..item;
	local n,l,_,_,_,_,_,_ = self:GetItemInfo(link);
	return ( n and l );
end

function FishLib:ChatLink(item, name, color)
	if( item and name and ChatFrameEditBox:IsVisible() ) then
		if ( not color ) then
			color = Crayon.COLOR_HEX_WHITE;
		elseif ( Crayon["COLOR_HEX_"..color] ) then
			color = Crayon["COLOR_HEX_"..color];
		end
		if ( string.len(color) == 6) then
			color = "ff"..color;
		end
		local link = "|c"..color.."|Hitem:"..item.."|h["..name.."]|h|r";
		ChatFrameEditBox:Insert(link);
	end
end

-- code taken from examples on wowwiki
function FishLib:GetFishTooltip(force)
	local tooltip = FishLibTooltip;
	if ( force or not tooltip ) then
		tooltip = CreateFrame("GameTooltip", "FishLibTooltip", nil, "GameTooltipTemplate");
		tooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
-- Allow tooltip SetX() methods to dynamically add new lines based on these
-- I don't think we need it if we use GameTooltipTemplate...
--		  tooltip:AddFontStrings(
--				tooltip:CreateFontString( "$parentTextLeft9", nil, "GameTooltipText" ),
--				tooltip:CreateFontString( "$parentTextRight9", nil, "GameTooltipText" ) )
	end
	-- the owner gets unset sometimes, not sure why
	local owner, anchor = tooltip:GetOwner();
	if (not owner or not anchor) then
		tooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
	end
	return FishLibTooltip;
end

local fp_itemtype = nil;
local fp_subtype = nil;

function FishLib:GetPoleType()
	if ( not fp_itemtype ) then
		_,_,_,_,fp_itemtype,fp_subtype,_,_,_,_ = self:GetItemInfo(6256);
		if ( not fp_itemtype ) then
			-- make sure it's in our cache
			local tooltip = self:GetFishTooltip();
			tooltip:ClearLines();
			tooltip:SetHyperlink("item:6256");
			_,_,_,_,fp_itemtype,fp_subtype,_,_,_,_ = self:GetItemInfo(6256);
		end
	end
	return fp_itemtype, fp_subtype;
end

function FishLib:IsFishingPool(text)
	if ( not text ) then
		text = self:GetTooltipText();
	end
	if ( text ) then
		local check = string.lower(text);
		for _,info in pairs(self.SCHOOLS) do
			local name = string.lower(info.name);
			if ( string.find(check, name) ) then
				return info;
			end
		end
		if ( string.find(check, self.SCHOOL) ) then
			return { name = text, kind = self.SCHOOL_FISH } ;
		end
	end
	-- return nil;
end

function FishLib:IsFishingPole(itemLink)
	if (not itemLink) then
		-- Get the main hand item texture
		itemLink = GetInventoryItemLink("player", mainhand);
	end
	if ( itemLink ) then
		local _,_,_,_,itemtype,subtype,_,_,itemTexture,_ = self:GetItemInfo(itemLink);
		self:GetPoleType();
		if ( not fp_itemtype and itemTexture ) then
			 -- If there is infact an item in the main hand, and it's texture
			 -- that matches the fishing pole texture, then we have a fishing pole
			 itemTexture = string.lower(itemTexture);
			 if ( string.find(itemTexture, "inv_fishingpole") or
					string.find(itemTexture, "fishing_journeymanfisher") ) then
				 local _, id, _ = self:SplitFishLink(itemLink);
				 -- Make sure it's not "Nat Pagle's Fish Terminator"
				 if ( id ~= 19944) then
					 fp_itemtype = itemtype;
					 fp_subtype = subtype;
					 return true;
				 end
			 end
		elseif ( fp_itemtype and fp_subtype ) then
			return (itemtype == fp_itemtype) and (subtype == fp_subtype);
		end
	end
	return false;
end

-- fish tracking skill
function FishLib:GetTrackingID(tex)
	if ( tex ) then
		for id=1,GetNumTrackingTypes() do
			local _, texture, _, _ = GetTrackingInfo(id);
			if ( texture == tex) then
				return id;
			end
		end
	end
	-- return nil;
end

local FINDFISHTEXTURE = "Interface\\Icons\\INV_Misc_Fish_02";
function FishLib:GetFindFishID()
	if ( not self.FindFishID ) then
		self.FindFishID = self:GetTrackingID(FINDFISHTEXTURE);
	end
	return self.FindFishID;
end

-- in case the addon is smarter than us
function FishLib:SetBobberName(name)
	self.BOBBER_NAME = name;
end

function FishLib:GetBobberName()
	return self.BOBBER_NAME;
end

function FishLib:GetTooltipText()
	if ( GameTooltip:IsVisible() ) then
		local text = getglobal("GameTooltipTextLeft1");
		if ( text ) then
			return text:GetText();
		end
	end
	-- return nil;
end

function FishLib:SaveTooltipText()
	self.lastTooltipText = self:GetTooltipText();
	return self.lastTooltipText;
end

function FishLib:GetLastTooltipText()
	return self.lastTooltipText;
end

function FishLib:ClearLastTooltipText()
	self.lastTooltipText = nil;
end

function FishLib:OnFishingBobber()
	if ( GameTooltip:IsVisible() and not UIFrameIsFading(GameTooltip) ) then
		local text = self:GetTooltipText();
		if ( text ) then
			-- let a partial match work (for translations)
			return ( text and string.find(text, self.BOBBER_NAME ) );
		end
	end
	return false;
end

local ACTIONDOUBLEWAIT = 0.4;
local MINACTIONDOUBLECLICK = 0.05;

FishLib.watchBobber = false;
function FishLib:WatchBobber(flag)
	self.watchBobber = flag;
end

-- look for double clicks
function FishLib:CheckForDoubleClick()
	if ( not isLooting and self.lastClickTime ) then
		local pressTime = GetTime();
		local doubleTime = pressTime - self.lastClickTime;
		if ( (doubleTime < ACTIONDOUBLEWAIT) and (doubleTime > MINACTIONDOUBLECLICK) ) then
			if ( not self.watchBobber or not self:OnFishingBobber() ) then
				self.lastClickTime = nil;
				return true;
			end
		end
	end
	self.lastClickTime = GetTime();
	if ( self:OnFishingBobber() ) then
		GameTooltip:Hide();
	end
	return false;
end

function FishLib:ExtendDoubleClick()
	if ( self.lastClickTime ) then
		self.lastClickTime = self.lastClickTime + ACTIONDOUBLEWAIT/2;
	end
end

function FishLib:GetZoneInfo()
	local zone = GetRealZoneText();
	local subzone = GetSubZoneText();
	if ( not zone or zone == "" ) then
		zone = UNKNOWN;
	end
	if ( not subzone or subzone == "" ) then
		subzone = zone;
	end

	-- Hack to fix issues with 4.1 and LibBabbleZone and LibTourist
	if (zone == "City of Ironforge" ) then
		zone = "Ironforge";
	end
	
	return zone, subzone;
end

-- translate zones and subzones
-- need to handle the fact that French uses "Stormwind" instead of "Stormwind City"
function FishLib:GetBaseZone(zname)
	if ( zname == FishLib.UNKNOWN or zname == UNKNOWN ) then
		return FishLib.UNKNOWN;
	end
	
	if (zname and not BL[zname] ) then
		zname = BZR[zname];
	end
	if (not zname) then
		zname = FishLib.UNKNOWN;
	end
	return zname;
end

function FishLib:GetBaseSubZone(sname)
	if ( sname == FishLib.UNKNOWN or sname == UNKNOWN ) then
		return FishLib.UNKNOWN;
	end
	
	if (sname and not BSL[sname] ) then
		sname = BSZR[sname];
	end
	if (not sname) then
		sname = FishLib.UNKNOWN;
	end
	return sname;
end

function FishLib:GetLocZone(zname)
	if ( zname == FishLib.UNKNOWN or zname == UNKNOWN ) then
		return UNKNOWN;
	end

	if (zname and BL[zname]) then
		zname = BZ[zname];
	end
	if (not zname) then
		zname = FishLib.UNKNOWN;
	end
	return zname;
end

function FishLib:GetLocSubZone(sname)
	if ( sname == FishLib.UNKNOWN or sname == UNKNOWN ) then
		return UNKNOWN;
	end

	if (sname and BSL[sname] ) then
		sname = BSZ[sname];
	end
	if (not sname) then
		sname = FishLib.UNKNOWN;
	end
	return sname;
end

local subzoneskills = {
	["Jademir Lake"] = 425,
	["Verdantis River"] = 300,
	["The Forbidding Sea"] = 225,
	["Ruins of Arkkoran"] = 300,
	["The Tainted Forest"] = 25,
	["Ruins of Gilneas"] = 75,
	["The Throne of Flame"] = 1,
	["Forge Camp: Hate"] = 375,	-- Nagrand
	["Lake Sunspring"] = 490,	-- Nagrand
	["Skysong Lake"] = 490,	-- Nagrand
	["Oasis"] = 100,
	["South Seas"] = 300,
	["Lake Everstill"] = 150,
	["Blackwind"] = 500,
	["Ere'Noru"] = 500,
	["Jorune"] = 500,
	["Silmyr"] = 500,
	["Cannon's Inferno"] = 1,
	["Fire Plume Ridge"] = 1,
	["Marshlight Lake"] = 450,
	["Sporewind Lake"] = 450,
	["Serpent Lake"] = 450,
};

function FishLib:GetFishingLevel(zone, subzone)
	subzone = self:GetBaseSubZone(subzone);

	if (subzoneskills[subzone]) then
		return subzoneskills[subzone];
	else
		return LT:GetFishingLevel(zone);
	end
end

-- return a nicely formatted line about the local zone skill and yours
function FishLib:GetFishingSkillLine(join, withzone)
	local part1 = "";
	local part2 = "";
	local skill, mods, skillmax = self:GetCurrentSkill();
	local totskill = skill + mods;
	local zone, subzone = self:GetZoneInfo();
	local level = self:GetFishingLevel(zone, subzone);
	if ( withzone ) then
		part1 = zone.." : "..subzone.. " ";
	end
	if ( level ) then
		 if ( level > 0 ) then
			local perc = totskill/level; -- no get aways
			if (perc > 1.0) then
				perc = 1.0;
			end
			part1 = part1.."|cff"..Crayon:GetThresholdHexColor(perc*perc)..level.." ("..math.floor(perc*perc*100).."%)|r";
		else
			-- need to translate this on our own
			part1 = part1..Crayon:Red(NONE_KEY);
		end
	else
		part1 = part1..Crayon:Red(UNKNOWN);
	end
	-- have some more details if we've got a pole equipped
	if ( self:IsFishingPole() ) then
		part2 = Crayon:Green(skill.."+"..mods).." "..Crayon:Silver("["..totskill.."]");
	end
	if ( join ) then
		if (part1 ~= "" and part2 ~= "" ) then
			part1 = part1..Crayon:White(" | ")..part2;
			part2 = "";
		end
	end
	return part1, part2;
end

-- table taken from El's Anglin' pages
-- More accurate than the previous (skill - 75) / 25 calculation now
local skilltable = {};
tinsert(skilltable, { ["level"] = 115, ["inc"] = 1 });
tinsert(skilltable, { ["level"] = 150, ["inc"] = 2 });
tinsert(skilltable, { ["level"] = 170, ["inc"] = 3 });
tinsert(skilltable, { ["level"] = 190, ["inc"] = 4 });
tinsert(skilltable, { ["level"] = 215, ["inc"] = 5 });
tinsert(skilltable, { ["level"] = 235, ["inc"] = 6 });
tinsert(skilltable, { ["level"] = 260, ["inc"] = 7 });
tinsert(skilltable, { ["level"] = 280, ["inc"] = 8 });
tinsert(skilltable, { ["level"] = 325, ["inc"] = 9 });
tinsert(skilltable, { ["level"] = 365, ["inc"] = 10 });
tinsert(skilltable, { ["level"] = 450, ["inc"] = 11 });
tinsert(skilltable, { ["level"] = 500, ["inc"] = 9 });
tinsert(skilltable, { ["level"] = 525, ["inc"] = 10 });

local newskilluptable = {};
function FishLib:SetSkillupTable(table)
	newskilluptable = table;
end

function FishLib:GetSkillupTable()
	return newskilluptable;
end

-- this would be faster as a binary search, but I'm not sure it matters :-)
function FishLib:CatchesAtSkill(skill)
	for _,chk in ipairs(skilltable) do
		if ( skill < chk.level ) then
			return chk.inc;
		end
	end
	-- return nil;
end

function FishLib:GetSkillUpInfo(lastSkillCheck)
	local skill, mods, skillmax = self:GetCurrentSkill();
	if ( skillmax and skill < skillmax ) then
		local needed = self:CatchesAtSkill(skill);
		if ( needed ) then
			if ( not lastSkillCheck or lastSkillCheck ~= skill ) then
				if ( lastSkillCheck ) then
					if (not newskilluptable[lastSkillCheck]) then
						newskilluptable[lastSkillCheck] = {};
						tinsert(newskilluptable[lastSkillCheck], caughtsofar);
					end
					caughtSoFar = 0;
				end
				lastSkillCheck = skill;
			end
			return lastSkillCheck, caughtSoFar, needed;
		end
	end
	return lastSkillCheck, caughtSoFar, nil;
end

-- we should have some way to believe 
function FishLib:SetCaughtSoFar(value)
	if ( FishingBuddy and FishingBuddy.GetSetting ) then
		caughtSoFar = FishingBuddy.GetSetting("CaughtSoFar") or 0;
	else
		caughtSoFar = value;
	end
end

function FishLib:GetCaughtSoFar()
	return caughtSoFar;
end

-- Find an action bar for fishing, if there is one
local FISHINGTEXTURE = "Interface\\Icons\\Trade_Fishing";
function FishLib:GetFishingActionBarID(force)
	if ( force or not self.ActionBarID ) then
		for slot=1,72 do
			if ( HasAction(slot) and not IsAttackAction(slot) ) then
				local t,_,_ = GetActionInfo(slot);
				if ( t == "spell" ) then
					local tex = GetActionTexture(slot);
					if ( tex and tex == FISHINGTEXTURE ) then
						self.ActionBarID = slot;
						break;
					end
				end
			end
		end
	end
	return self.ActionBarID;
end

-- handle classes of fish
local MissedFishItems = {};
MissedFishItems[45190] = "Driftwood";
MissedFishItems[45200] = "Sickly Fish";
MissedFishItems[45194] = "Tangled Fishing Line";
MissedFishItems[45196] = "Tattered Cloth";
MissedFishItems[45198] = "Weeds";
MissedFishItems[45195] = "Empty Rum Bottle";
MissedFishItems[45199] = "Old Boot";
MissedFishItems[45201] = "Rock";
MissedFishItems[45197] = "Tree Branch";
MissedFishItems[45202] = "Water Snail";
MissedFishItems[45188] = "Withered Kelp";
MissedFishItems[45189] = "Torn Sail";
MissedFishItems[45191] = "Empty Clam";

function FishLib:IsMissedFish(id)
	if ( MissedFishItems[id] ) then
		return true;
	end
	-- return nil;
end

-- utility functions
local function SplitColor(color)
	if ( color ) then
		if ( type(color) == "table" ) then
			for i,c in pairs(color) do
				color[i] = SplitColor(c);
			end
		elseif ( type(color) == "string" ) then
			local a = tonumber(string.sub(color,1,2),16);
			local r = tonumber(string.sub(color,3,4),16);
			local g = tonumber(string.sub(color,5,6),16);
			local b = tonumber(string.sub(color,7,8),16);
			color = { a = a, r = r, g = g, b = b };
		end
	end
	return color;
end

local function AddTooltipLine(l)
	if ( type(l) == "table" ) then
		-- either { t, c } or {{t1, c1}, {t2, c2}}
		if ( type(l[1]) == "table" ) then
			local c1 = SplitColor(l[1][2]) or {};
			local c2 = SplitColor(l[2][2]) or {};
			GameTooltip:AddDoubleLine(l[1][1], l[2][1],
											  c1.r, c1.g, c1.b,
											  c2.r, c2.g, c2.b);
		else
			local c = SplitColor(l[2]) or {};
			GameTooltip:AddLine(l[1], c.r, c.g, c.b, 1);
		end
	else
		GameTooltip:AddLine(l,nil,nil,nil,1);
	end
end

function FishLib:AddTooltip(text, tooltip)
	if ( not tooltip ) then
		tooltip = GameTooltip;
	end
	local c = color or {{}, {}};
	if ( text ) then
		if ( type(text) == "table" ) then
			for _,l in pairs(text) do
				AddTooltipLine(l, tooltip);
			end
		else
			-- AddTooltipLine(text, color);
			tooltip:AddLine(text,nil,nil,nil,1);
		end
	end
end

function FishLib:FindChatWindow(name)
	local frame;
	for i = 1, NUM_CHAT_WINDOWS do
		local frame = getglobal("ChatFrame" .. i);
		if (frame.name == name) then
			return frame, getglobal("ChatFrame" .. i .. "Tab");
		end
	end
	-- return nil, nil;
end

function FishLib:GetChatWindow(name)
	if (canCreateFrame) then
		local frame, frametab = self:FindChatWindow(name);
		if ( frame ) then
			if ( not frametab:IsVisible() ) then
				-- Dock the frame by default
				if ( not frame.oldAlpha ) then
					frame.oldAlpha = frame:GetAlpha() or DEFAULT_CHATFRAME_ALPHA;
				end
				FCF_DockFrame(frame, (#FCFDock_GetChatFrames(GENERAL_CHAT_DOCK)+1), true);
				FCF_FadeInChatFrame(FCFDock_GetSelectedWindow(GENERAL_CHAT_DOCK));
				FCF_DockUpdate();
			end
			return frame, frametab;
		else
			local frame = FCF_OpenNewWindow(name);
			return self:FindChatWindow(name);
		end
	end
	-- if we didn't find our frame, something bad has happened, so
	-- let's just use the default chat frame
	return DEFAULT_CHAT_FRAME, nil;
end

-- Secure action button
function FishLib:CreateSAButton(name, postclick)
	local btn = CreateFrame("Button", name, UIParent, "SecureActionButtonTemplate");
	btn:SetPoint("LEFT", UIParent, "RIGHT", 10000, 0);
	btn:SetFrameStrata("LOW");
	btn:EnableMouse(true);
	btn:RegisterForClicks("RightButtonUp");
	btn:SetScript("PostClick", postclick);
	btn:Hide();
	btn.name = name;

	self.sabutton = btn;

	return btn;
end

function FishLib:InvokeFishing(useaction, btn)
	btn = btn or self.sabutton;
	if ( not btn ) then
		return;
	end
	local _, name = self:GetFishingSkillInfo();
	local findid = self:GetFishingActionBarID();	  
	if ( not useaction or not findid ) then
	  btn:SetAttribute("type", "spell");
	  btn:SetAttribute("spell", name);
	  btn:SetAttribute("action", nil);
	else
	  btn:SetAttribute("type", "action");
	  btn:SetAttribute("action", findid);
	  btn:SetAttribute("spell", nil);
	end
	btn:SetAttribute("item", nil);
	btn:SetAttribute("target-slot", nil);
end

function FishLib:InvokeLuring(id, btn)
	btn = btn or self.sabutton;
	if ( not btn ) then
		return;
	end
	btn:SetAttribute("type", "item");
	btn:SetAttribute("item", "item:"..id);
	btn:SetAttribute("target-slot", mainhand);
	btn:SetAttribute("spell", nil);
	btn:SetAttribute("action", nil);
end

function FishLib:OverrideClick(btn)
	btn = btn or self.sabutton;
	if ( not self.sabutton ) then
		return;
	end
	SetOverrideBindingClick(btn, true, "BUTTON2", btn.name);
end

-- Taken from wowwiki tooltip handling suggestions
local function EnumerateTooltipLines_helper(...)
	local lines = {};
	for i = 1, select("#", ...) do
		local region = select(i, ...)
		if region and region:GetObjectType() == "FontString" then
			local text = region:GetText() -- string or nil
			tinsert(lines, text or "");
		end
	end
	return lines;
end

function FishLib:EnumerateTooltipLines(tooltip)
	 return EnumerateTooltipLines_helper(tooltip:GetRegions())
end

-- Fishing bonus. We used to be able to get the current modifier from
-- the skill API, but now we have to figure it out ourselves
local match;
function FishLib:FishingBonusPoints(item, inv)
	local points = 0;
	if ( item and item ~= "" ) then
		if ( not match ) then
			local _,skillname = self:GetFishingSkillInfo(true);
			match = {};
			match[1] = "%+(%d+) "..skillname;
			match[2] = skillname.." %+(%d+)";
			-- Equip: Fishing skill increased by N.
			match[3] = skillname.."[%a%s]+(%d+)%.";
			if ( GetLocale() == "deDE" ) then
				 match[4] = "+(%d+) Angelfertigkeit";
			end
		end
		local tooltip = self:GetFishTooltip();
		tooltip:ClearLines();
		if (inv) then
			tooltip:SetInventoryItem("player", item);
		else
			local _, id, _ = self:SplitFishLink(item);
			if (not id) then
				item = "item:"..item;
			end
			tooltip:SetHyperlink(item);
		end
		local lines = EnumerateTooltipLines_helper(tooltip:GetRegions())
		for i=1,#lines do
			local bodyslot = lines[i]:gsub("^%s*(.-)%s*$", "%1");
			if (string.len(bodyslot) > 0) then
				for _,pat in ipairs(match) do
					local _,_,bonus = string.find(bodyslot, pat);
					if ( bonus ) then
						points = points + bonus;
					end
				end
			end
		end
	end
	return points;
end

-- if we have a fishing pole, return the bonus from the pole
-- and the bonus from a lure, if any, separately
function FishLib:GetPoleBonus()
	if (self:IsFishingPole()) then
		-- get the total bonus for the pole
		local total = self:FishingBonusPoints(mainhand, true);
		local hmhe,_,_,_,_,_ = GetWeaponEnchantInfo();
		if ( hmhe ) then
			-- IsFishingPole has set mainhand for us
			local itemLink = GetInventoryItemLink("player", mainhand);
			local _, id, _, enchant = self:SplitLink(itemLink);
			-- get the raw value of the pole without any temp enchants
			local pole = self:FishingBonusPoints(id);
			return total, total - pole;
		else
			-- no enchant, all pole
			return total, 0;
		end
	end
	return 0, 0;
end

function FishLib:GetOutfitBonus()
	local bonus = 0;
	-- we can skip the ammo and ranged slots
	for i=1,16,1 do
		bonus = bonus + self:FishingBonusPoints(slotinfo[i].id, 1);
	end
	local pole, lure = self:GetPoleBonus();
	return bonus + pole, lure;
end

-- return a list of the best items we have for a fishing outfit
function FishLib:GetFishingOutfitItems(wearing)
	local ibp = function(link) return FL:FishingBonusPoints(link); end;
	-- find fishing gear
	-- no affinity, check all bags
	local outfit = nil;
	local itemtable = {};
	for invslot=1,17,1 do
		local slotid = slotinfo[invslot].id;
		local slotname = slotinfo[invslot].name;
		local maxb = nil;
		local link;
		-- should we include what we're already wearing?
		if ( wearing ) then
			link = GetInventoryItemLink("player", slotid);
			if ( link ) then
				maxb = self:FishingBonusPoints(link);
				outfit = outfit or {};
				if (maxb > 0) then
					outfit[invslot] = { link=link, slot=slotid };
				end
			end
		end

		-- this only gets items in bags, hence the check above for slots
		wipe(itemtable);
		itemtable = GetInventoryItemsForSlot(slotid, itemtable);

		for location,id in pairs(itemtable) do
			local player, bank, bags, slot, bag = EquipmentManager_UnpackLocation(location);
			if ( bags ) then
				link = GetContainerItemLink(bag, slot);
			else
				link = nil;
			end
			if ( link ) then
				local b = self:FishingBonusPoints(link);
				if (b > 0) then
					if ( not maxb or b > maxb ) then
						maxb = b;
						outfit = outfit or {};
						outfit[slotid] = { link=link, bag=bag, slot=slot, slotname=slotname };
					end
				end
			end
		end
	end
	return outfit;
end

-- Is this item openable?
function FishLib:IsOpenable(item)
	local _, id, _ = self:SplitFishLink(item);
	if (not id) then
		item = "item:"..item;
	end

	local canopen = false;
	local locked = false;
	local tooltip = self:GetFishTooltip();
	tooltip:ClearLines();
	tooltip:SetHyperlink(item);
	local lines = EnumerateTooltipLines_helper(tooltip:GetRegions())
	for i=1,#lines do
		local line = lines[i];
		if ( line == _G.ITEM_OPENABLE ) then
			openable = true;
		elseif ( line == _G.LOCKED ) then
			locked = true;
		end
	end
	return canopen, locked;
end

-- Find out where the player is. Based on code from Astrolabe and wowwiki notes
function FishLib:GetCurrentPlayerPosition()
	local x, y = GetPlayerMapPosition("player");
	-- if the current location is 0,0 we need to call SetMapToCurrentZone()
	if ( x <= 0 and y <= 0 ) then
		-- find out where we are now
		local lC, lZ = GetCurrentMapContinent(), GetCurrentMapZone();
		SetMapToCurrentZone();
		-- if we haven't changed zones yet, the zoom is incorrect
		SetMapZoom(GetCurrentMapContinent());
		x, y = GetPlayerMapPosition("player");
		if ( x <= 0 and y <= 0 ) then
			-- we are in an instance or otherwise off the continent map
			return;
		end
		local C, Z = GetCurrentMapContinent(), GetCurrentMapZone();
		if ( C ~= lC or Z ~= lZ ) then
			SetMapZoom(lC, lZ); --set map zoom back to what it was before
		end
		return C, Z, x, y;
	end
	return GetCurrentMapContinent(), GetCurrentMapZone(), x, y;
end

-- translation support functions
-- replace #KEYWORD# with the value of keyword (which might be a color)
local function FixupThis(target, tag, what)
	if ( type(what) == "table" ) then
		for idx,str in pairs(what) do
			what[idx] = FixupThis(target, tag, str);
		end
		return what;
	elseif ( type(what) == "string" ) then
		local pattern = "#([A-Z0-9_]+)#";
		local s,e,w = string.find(what, pattern);
		while ( w ) do
			if ( type(target[w]) == "string" ) then
				local s1 = strsub(what, 1, s-1);
				local s2 = strsub(what, e+1);
				what = s1..target[w]..s2;
				s,e,w = string.find(what, pattern);
			elseif ( Crayon and Crayon["COLOR_HEX_"..w] ) then
				local s1 = strsub(what, 1, s-1);
				local s2 = strsub(what, e+1);
				what = s1.."ff"..Crayon["COLOR_HEX_"..w]..s2;
				s,e,w = string.find(what, pattern);
			else
				-- stop if we can't find something to replace it with
				w = nil;
			end
		end
		return what;
	end
	-- do nothing
	return what;
end

function FishLib:FixupEntry(constants, tag)
	FixupThis(constants, tag, constants[tag]);
end

local function FixupStrings(target)
	for tag,_ in pairs(target) do
		target[tag] = FixupThis(target, tag, target[tag]);
	end
end

local function FixupBindings(target)
	for tag,str in pairs(target) do		
		if ( string.find(tag, "^BINDING") ) then
			setglobal(tag, target[tag]);
			target[tag] = nil;
		end
	end
end

local missing = {};
local function LoadTranslation(source, lang, target, record)
	local translation = source[lang];
	if ( translation ) then
		for tag,value in pairs(translation) do
			if ( not target[tag] ) then
				target[tag] = value;
				if ( record ) then
					missing[tag] = value;
				end
			end
		end
	end
end

function FishLib:Translate(addon, source, target, forced)
	local locale = forced or GetLocale();
	target.VERSION = GetAddOnMetadata(addon, "Version");
	LoadTranslation(source, locale, target);
	if ( locale ~= "enUS" ) then
		LoadTranslation(source, "enUS", target, forced);
	end
	LoadTranslation(source, "Inject", target);
	FixupStrings(target);
	FixupBindings(target);
	if (forced) then
		return missing;
	end
end

-- Pool types
FishLib.SCHOOL_FISH = 0;
FishLib.SCHOOL_WRECKAGE = 1;
FishLib.SCHOOL_DEBRIS = 2;
FishLib.SCHOOL_WATER = 3;
FishLib.SCHOOL_TASTY = 4;
FishLib.SCHOOL_OIL = 5;
FishLib.SCHOOL_CHURNING = 6;
FishLib.SCHOOL_FLOTSAM = 7;

local FLTrans = {};

function FLTrans:Setup(lang, school, ...)
	self[lang] = {};
	-- as long as string.lower breaks all UTF-8 equally, this should still work
	self[lang].SCHOOL = string.lower(school);
	local n = select("#", ...);
	local schools = {};
	for idx=1,n,2 do
		local name, kind = select(idx, ...);
		tinsert(schools, { name = name, kind = kind });
	end
	self[lang].SCHOOLS = schools;
end

FLTrans:Setup("enUS", "school",
	"Floating Wreckage", FishLib.SCHOOL_WRECKAGE,
	"Patch of Elemental Water", FishLib.SCHOOL_WATER,
	"Floating Debris", FishLib.SCHOOL_DEBRIS,
	"Oil Spill", FishLib.SCHOOL_OIL,
	"Stonescale Eel Swarm", FishLib.SCHOOL_FISH,
	"Muddy Churning Water", FishLib.SCHOOL_CHURNING,
	"Pure Water", FishLib.SCHOOL_WATER,
	"Steam Pump Flotsam", FishLib.SCHOOL_FLOTSAM,
	"School of Tastyfish", FishLib.SCHOOL_TASTY);

FLTrans:Setup("koKR", "떼",
	"표류하는 잔해", FishLib.SCHOOL_WRECKAGE, --	 Floating Wreckage
	"정기가 흐르는 물 웅덩이", FishLib.SCHOOL_WATER, --	 Patch of Elemental Water
	"표류하는 파편", FishLib.SCHOOL_DEBRIS, --  Floating Debris
	"떠다니는 기름", FishLib.SCHOOL_OIL, --  Oil Spill
	"거품이는 진흙탕물", FishLib.SCHOOL_CHURNING, --	Muddy Churning Water
	"깨끗한 물", FishLib.SCHOOL_WATER, --  Pure Water
	"증기 양수기 표류물", FishLib.SCHOOL_FLOTSAM, --	Steam Pump Flotsam
	"맛둥어 떼", FishLib.SCHOOL_TASTY); -- School of Tastyfish

FLTrans:Setup("deDE", "schwarm",
	"Treibende Wrackteile", FishLib.SCHOOL_WRECKAGE, --  Floating Wreckage
	"Stelle mit Elementarwasser", FishLib.SCHOOL_WATER, --  Patch of Elemental Water
	"Schwimmende Trümmer", FishLib.SCHOOL_DEBRIS, --  Floating Debris
	"Ölfleck", FishLib.SCHOOL_OIL,  --	Oil Spill
	"Schlammiges aufgewühltes Gewässer", FishLib.SCHOOL_CHURNING, --	Muddy Churning Water
	"Reines Wasser", FishLib.SCHOOL_WATER, --	 Pure Water
	"Treibgut der Dampfpumpe", FishLib.SCHOOL_FLOTSAM, --	 Steam Pump Flotsam
	"Leckerfischschwarm", FishLib.SCHOOL_TASTY); -- School of Tastyfish

FLTrans:Setup("frFR", "banc",
	"Débris flottants", FishLib.SCHOOL_WRECKAGE, --	 Floating Wreckage
	"Remous d'eau élémentaire", FishLib.SCHOOL_WATER, --	Patch of Elemental Water
	"Débris flottant", FishLib.SCHOOL_DEBRIS, --	 Floating Debris
	"Nappe de pétrole", FishLib.SCHOOL_OIL, --  Oil Spill
	"Eaux troubles et agitées", FishLib.SCHOOL_CHURNING, --	Muddy Churning Water
	"Eau pure", FishLib.SCHOOL_WATER, --  Pure Water
	"Détritus de la pompe à vapeur", FishLib.SCHOOL_FLOTSAM, --	 Steam Pump Flotsam
	"Banc de courbine", FishLib.SCHOOL_TASTY); -- School of Tastyfish

FLTrans:Setup("esES", "banco",
	"Restos de un naufragio", FishLib.SCHOOL_WRECKAGE,	  --	Floating Wreckage
	"Restos flotando", FishLib.SCHOOL_DEBRIS,		--	 Floating Debris
	"Vertido de petr\195\179leo", FishLib.SCHOOL_OIL,	 --  Oil Spill
	"Agua pura", FishLib.SCHOOL_WATER, --	Pure Water
	"Restos flotantes de bomba de vapor", FishLib.SCHOOL_FLOTSAM, --	Steam Pump Flotsam
	"Banco de pezricos", FishLib.SCHOOL_TASTY); -- School of Tastyfish

FLTrans:Setup("zhCN", "鱼群",
	"漂浮的残骸", FishLib.SCHOOL_WRECKAGE, --  Floating Wreckage
	"元素之水", FishLib.SCHOOL_WATER, --	 Patch of Elemental Water
	"漂浮的碎片", FishLib.SCHOOL_DEBRIS, --	Floating Debris
	"油井", FishLib.SCHOOL_OIL, --	Oil Spill
	"石鳞鳗群", FishLib.SCHOOL_FISH, --	Stonescale Eel Swarm
	"混浊的水", FishLib.SCHOOL_CHURNING, --	 Muddy Churning Water
	"纯水", FishLib.SCHOOL_WATER,				 --  Pure Water
	"蒸汽泵废料", FishLib.SCHOOL_FLOTSAM, --	 Steam Pump Flotsam
	"可口鱼", FishLib.SCHOOL_TASTY); -- School of Tastyfish

FLTrans:Setup("zhTW", "群",
	"漂浮的殘骸", FishLib.SCHOOL_WRECKAGE, --  Floating Wreckage
	"元素之水", FishLib.SCHOOL_WATER, --	 Patch of Elemental Water
	"漂浮的碎片", FishLib.SCHOOL_DEBRIS, --	Floating Debris
	"油井", FishLib.SCHOOL_OIL, --	Oil Spill
	"混濁的水", FishLib.SCHOOL_CHURNING, --	 Muddy Churning Water
	"純水", FishLib.SCHOOL_WATER,				 --  Pure Water
	"蒸汽幫浦漂浮殘骸", FishLib.SCHOOL_FLOTSAM,	 --  Steam Pump Flotsam
	"斑點可口魚魚群", FishLib.SCHOOL_TASTY); -- School of Tastyfish

FishLib:Translate("LibFishing", FLTrans, FishLib);
FLTrans = nil;
