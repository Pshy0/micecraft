local bit32, coroutine, math, os, string, table = _G.bit32, _G.coroutine, _G.math, _G.os, _G.string, _G.table
local debug, system, tfm, ui = _G.debug, _G.system, _G.tfm, _G.ui

local next, pcall, tonumber, tostring, type, setmetatable = _G.next, _G.pcall, _G.tonumber, _G.tostring, _G.type, _G.setmetatable
local currentTime = os.time

if tfm.get.room.name:lower():match("village") then
	system.exit()
end

math.randomseed(os.time())

setmetatable(_G, {
	__newindex = function(self, k, v)
		if not k:find("^event") then
			error(("NO GLOBALS ALLOWED !! Bad global: %s"):format(tostring(k)))
		end
	end
})

local xmlLoad = '<C><P Ca="" H="%d" L="%d" /><Z><S></S><D><DS X="%d" Y="%d" /></D><O /></Z></C>'

local Block = {}
local Chunk = {}
local World = {}

local Player = {}