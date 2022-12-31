local LOCAL_EPOCH = os.time()

local bit32, coroutine, math, os, string, table = _G.bit32, _G.coroutine, _G.math, _G.os, _G.string, _G.table
local debug, system, tfm, ui = _G.debug, _G.system, _G.tfm, _G.ui

local next, pcall, tonumber, tostring, type, setmetatable = _G.next, _G.pcall, _G.tonumber, _G.tostring, _G.type, _G.setmetatable
local currentTime = os.time

if tfm.get.room.name:lower():match("village") then
	system.exit()
end

math.randomseed(os.time())

-- We don't want globals in our code. They pollute the global environment,
-- are prone to cause memory leaks on the Lua VM, make debugging harder,
-- and increases unnecesarily the table acceses. Only Transformice events
-- should be globals, because that's the only way we can receive callbacks.
setmetatable(_G, {
	__newindex = function(self, k, v)
		if k:match("^event.+") then -- It's an Event (duh)
			rawset(_G, k, v)
		else -- Not an Event. Bad global !!
			error(("NO GLOBALS ALLOWED !! Bad global: %q >:("):format(tostring(k)), 2)
		end
	end
})
--		ALT:	'<C><P Ca="" H="%d" L="%d" /><Z><S></S><D><T X="%d" Y="%d" D="" /></D><O /></Z></C>'
local xmlLoad = '<C><P Ca="" H="%d" L="%d" /><Z><S></S><D><DS X="%d" Y="%d" /></D><O /></Z></C>'

local Module = {}
local Room = {}

local Modes = {}
local Mode = {}

local enum = {}

local Block = {}
local Chunk = {}
local World = {}

local Player = {}

local ticks = 0