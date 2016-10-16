local version = "1.01"
local UPDATE_HOST = "raw.github.com"
local UPDATE_PATH = "/gmzopper/BoL/master/PacketLib.lua".."?rand="..math.random(1,10000)
local UPDATE_FILE_PATH = SCRIPT_PATH..GetCurrentEnv().FILE_NAME
local UPDATE_URL = "https://"..UPDATE_HOST..UPDATE_PATH


function CustomPrint(msg) PrintChat("<font color=\"#6699ff\"><b>[PacketLib]</b></font> <font color=\"#FFFFFF\">"..msg..".</font>") end
local ServerData = GetWebResult(UPDATE_HOST, "/gmzopper/BoL/master/version/PacketLib.version")
if ServerData then
	ServerVersion = type(tonumber(ServerData)) == "number" and tonumber(ServerData) or nil
	if ServerVersion then
		if tonumber(version) < ServerVersion then
			CustomPrint("New version available "..ServerVersion)
			CustomPrint("Updating, please don't press F9")
			DelayAction(function() DownloadFile(UPDATE_URL, UPDATE_FILE_PATH, function () _AutoupdaterMsg("Successfully updated. ("..version.." => "..ServerVersion.."), press F9 twice to load the updated version.") end) end, 3)
		else
			CustomPrint("You have got the latest version ("..ServerVersion..")")
		end
	end
else
	CustomPrint("Error downloading version info")
end

class "PacketLib"
function PacketLib:__init()
	self.OnCastCallback = {}
	self.OnLevelUpMySpellCallback = {}
	self.OnGainLevelCallback = {}
	self.OnLevelUpSpellCallback = {}
	self.OnTrinketCallback = {}
	self.OnPurchaseCallback = {}
	self.OnRecallCallback = {}
	
	AddSendPacketCallback(function(p) self:OnSendPacket(p) end)
	AddRecvPacketCallback2(function(p) self:OnRecvPacket(p) end)
	
	CustomPrint("Loaded")
end

function PacketLib:AddCastCallback(f) table.insert(self.OnCastCallback, f) end
function PacketLib:AddLevelUpMySpellCallback(f) table.insert(self.OnLevelUpMySpellCallback, f) end
function PacketLib:AddGainLevelCallback(f) table.insert(self.OnGainLevelCallback, f) end
function PacketLib:AddLevelUpSpellCallback(f) table.insert(self.OnLevelUpMySpellCallback, f) end
function PacketLib:AddTrinketCallback(f) table.insert(self.OnTrinketCallback, f) end
function PacketLib:AddPurchaseCallback(f) table.insert(self.OnPurchaseCallback, f) end
function PacketLib:AddRecallCallback(f) table.insert(self.OnRecallCallback, f) end

function PacketLib:OnCast(spellID, LoLPacket)
	for i, cb in ipairs(self.OnCastCallback) do
		cb(spellID, LoLPacket)
	end
end

function PacketLib:OnLevelUpMySpell(slotID, LoLPacket)
	for i, cb in ipairs(self.OnLevelUpMySpellCallback) do
		cb(slotID, LoLPacket)
	end
end

function PacketLib:OnGainLevel(networkID, LoLPacket)
	for i, cb in ipairs(self.OnLevelUpMySpellCallback) do
		cb(networkID, LoLPacket)
	end
end

function PacketLib:OnLevelUpSpell(networkID, slotID, level, LoLPacket)
	for i, cb in ipairs(self.OnLevelUpSpellCallback) do
		cb(networkID, slotID, level, LoLPacket)
	end
end

function PacketLib:OnTrinket(networkID, LoLPacket)
	for i, cb in ipairs(self.OnTrinketCallback) do
		cb(networkID, LoLPacket)
	end
end

function PacketLib:OnPurchase(networkID, stackCount, itemID, itemType, slotID, LoLPacket)
	for i, cb in ipairs(self.OnPurchaseCallback) do
		cb(networkID, stackCount, itemID, itemType, slotID, LoLPacket)
	end
end

function PacketLib:OnRecall(networkID, LoLPacket)
	for i, cb in ipairs(self.OnRecallCallback) do
		cb(networkID, LoLPacket)
	end
end

function PacketLib:OnSendPacket(p)
	if p.header == 7 then	
		--On Cast
		
		p.pos = 15
		local spellID = p:Decode4()
		
		self:OnCast(spellID, p)
	elseif p.header == 156 then
		--Level Up My Spell
		
		p.pos = 18
		local slotID = p:Decode1() - 170
		
		self:OnLevelUpMySpell(slotID, p)
	end
end

function PacketLib:OnRecvPacket(p)
	if p.header == 9 then
		--On Gain Level		
		p.pos = 2
		local networkID = p:DecodeF()
		
		self:OnGainLevel(networkID, p)
	elseif p.header == 37 then
		--On LevelUpSpell	
		
		p.pos = 2
		local networkID = p:DecodeF()
		
		p.pos = 7
		local slotID = p:Decode1() - 170
		local level = p:Decode1()
		
		if level == 193 then level = 1
		elseif level == 1 then level = 2
		elseif level == 65 then level = 3
		elseif level == 142 then level = 4
		elseif level == 206 then level = 5
		else level = -1 end
		
		self:OnLevelUpSpell(networkID, slotID, level, p)
	elseif p.header == 224 then
		--Occurs when you change/use trinket
		-- Two packets at once if trinket has changed, one packet if it has been used
		
		p.pos = 2
		local networkID = p:DecodeF()
		
		self:OnTrinket(networkID, p)
	elseif p.header == 277 then
		--On Purchase
		
		p.pos = 2
		local networkID = p:DecodeF()
		
		p.pos = 11
		local stackCount = p:Decode1()
		local itemID = p:Decode1()
		local itemType = p:Decode1()
		
		p.pos = 16
		local slotID = p:Decode1()
		
		if stackCount == 185 then stackCount = 1
		elseif stackCount == 147 then stackCount = 2
		elseif stackCount == 228 then stackCount = 3
		elseif stackCount == 2 then stackCount = 4
		elseif stackCount == 61 then stackCount = 5
		else stackCount = -1 end
		
		if slotID == 129 then slotID = ITEM_1
		elseif slotID == 193 then slotID = ITEM_2
		elseif slotID == 1 then slotID = ITEM_3
		elseif slotID == 65 then slotID = ITEM_4
		elseif slotID == 142 then slotID = ITEM_5
		elseif slotID == 206 then slotID = ITEM_6
		else slotID = -1 end
		
		self:OnPurchase(networkID, stackCount, itemID, itemType, slotID, p)
	elseif p.header == 306 then
		--On Recall	
		
		p.pos = 2
		local networkID = p:DecodeF()
		
		self:OnRecall(networkID, p)
	end
end