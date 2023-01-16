function Mode:new(name, constructor)
	local this = setmetable({
		name = name,
		environment = {},
		constructor = constructor,
		settings = {}
	}, self)

	this.__index = self
	
	return this
end

function Mode:constructor(this, g) -- Default
	return {}  -- ...
end

function Mode:init()
	World:setVariables(32, 32, 16, 16, 8, 8, 0, 200)
end

function Mode:setWorld()
	-- Here you generate your world
end

function Mode:run()
	Module:on("NewPlayer", function(playerName)
		tfm.exec.chatMessage("I'm a default message. Say hi!")
	end)
end