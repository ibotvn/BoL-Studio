--[[
	Version: 1.0
	Updated: October 23, 2015
	Thread Link: []
]]

class("_PacketManager")

function _PacketManager:__init()
	self.Callbacks = {Send = {}, Receive = {}}
	self.CurrentID = {Send = 0, Receive = 0}

	AddSendPacketCallback(function(p) self:OnSendPacket(p) end)
	AddRecvPacketCallback2(function(p) self:OnRecvPacket(p) end)
end

function _PacketManager:AddSendPacketCallback(func)
	self.CurrentID.Send = self.CurrentID.Send + 1
	self.Callbacks.Send[self.CurrentID.Send] = func
	return self.CurrentID.Send
end

function _PacketManager:RemoveSendPacketCallback(ID)
	self.Callbacks.Send[ID] = nil
end

function _PacketManager:AddRecvPacketCallback(func)
	self.CurrentID.Receive = self.CurrentID.Receive + 1
	self.Callbacks.Receive[self.CurrentID.Receive] = func
	return self.CurrentID.Receive
end

function _PacketManager:RemoveRecvPacketCallback(ID)
	self.Callbacks.Receive[ID] = nil
end

function _PacketManager:OnSendPacket(p)
	for i=1, self.CurrentID.Send do
		local func = self.Callbacks.Send[i]
		if func then
			func(p)
		end
	end
end

function _PacketManager:OnRecvPacket(p)
	for i=1, self.CurrentID.Receive do
		local func = self.Callbacks.Receive[i]
		if func then
			func(p)
		end
	end
end

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

local PACKETMANAGER = _PacketManager()
local Packet, table, string, tostring = Packet, table, string, tostring

class("PacketInspector")

function PacketInspector:__init()
	self.ip = "127.0.0.1"
	self.port = 1337

	self.socket = require("socket")
	self.tcp = self.socket.tcp()

	self.tcp:settimeout(0)
	self.tcp:connect(self.ip, self.port)

	self.Filters = {Send = function() return true end, Receive = function() return true end}

	PrintChat("Packet Inspector: Connected to [" .. self.ip .. ":" .. self.port .. "]")
end

function PacketInspector:Write(msg)
	self.tcp:send(msg)
end

function PacketInspector:_WriteDebug(msg)
	self:Write("Debug:nil:nil:DEBUG:nil:" .. tostring(msg))
end

function PacketInspector:StartLog(logSend, logRecv)
	if logSend then
		if self.SendID then
			PACKETMANAGER:RemoveSendPacketCallback(self.SendID)
		end
		self.SendID = PACKETMANAGER:AddSendPacketCallback(
			function(p)
				if self.Filters.Send(p) then
					self:Write(table.concat({
						"Sent:",
						tostring(p.dwArg1),
						":",
						tostring(p.dwArg2),
						":",
						string.format("0x%02X", p.header),
						":",
						string.format("0x%02X", p.vTable),
						":",
						Packet(p):getRawHexString(),
					}))
				end
			end
		)
	end

	if logRecv then
		if self.RecvID then
			PACKETMANAGER:RemoveRecvPacketCallback(self.RecvID)
		end
		self.RecvID = PACKETMANAGER:AddRecvPacketCallback(
			function(p)
				if self.Filters.Receive(p) then
					self:Write(table.concat({
						"Received:",
						tostring(p.dwArg1),
						":",
						tostring(p.dwArg2),
						":",
						string.format("0x%02X", p.header),
						":",
						string.format("0x%02X", p.vTable),
						":",
						Packet(p):getRawHexString(),
					}))
				end
			end
		)
	end
end

function PacketInspector:StopLog(logSend, logRecv)
	if logSend and self.SendID then
		PACKETMANAGER:RemoveSendPacketCallback(self.SendID)
	end

	if logRecv and self.RecvID then
		PACKETMANAGER:RemoveRecvPacketCallback(self.RecvID)
	end
end

function PacketInspector:Close()
	self:StopLog(true, true)
	self.tcp:close()
	self.tcp = nil
end

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

local function toHex(str)
	return string.format("%02X ", str)
end

function Encode1Hex(val)
	local p = CLoLPacket(0)
	p:Encode1(val)
	p.pos = p.pos - 1

	return toHex(p:Decode1())
end

function Encode2Hex(val)
	local p = CLoLPacket(0)
	p:Encode2(val)
	p.pos = p.pos - 2

	return table.concat({toHex(p:Decode1()), toHex(p:Decode1())})
end

function Encode4Hex(val)
	local p = CLoLPacket(0)
    p:Encode4(val)
    p.pos = p.pos - 4

    return table.concat({toHex(p:Decode1()), toHex(p:Decode1()), toHex(p:Decode1()), toHex(p:Decode1())})
end

function EncodeFHex(myFloat)
    local p = CLoLPacket(0)
    p:EncodeF(myFloat)
    p.pos = p.pos - 4

    return table.concat({toHex(p:Decode1()), toHex(p:Decode1()), toHex(p:Decode1()), toHex(p:Decode1())})
end

--<3 Feez