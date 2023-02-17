function Mode:new(name, constructor)
	local this = setmetatable({
		name = name,
		environment = {},
		constructor = constructor,
		settings = {}
	}, self)

	this.__index = this
	
	return this
end

function Mode:constructor(g) -- Default
	-- Here you define the functions init, setWorld, etc
	return {}  -- ...
end

function Mode:init()
	-- Here you init the World and all stuff you need
	World:setVariables(32, 32, 16, 16, 8, 8, 0, 200)
end

function Mode:setWorld()
	-- Here you generate your world
end

function Mode:run()
	-- Start your mode
	Module:on("NewPlayer", function(playerName)
		tfm.exec.chatMessage("I'm a default message. Say hi!")
	end)
end