function Modes:init()
	self.list = {}
	
	self.currentMode = "main"
end

function Modes:newMode(modeName, initf)
	local this = Mode.new(modeName, initf)
	
	self.list[modeName] = this
	
	return self.list[modeName]
end

function Modes:getMode(modeName)
	return self.list[modeName] or self.list.main
end

function Modes:setMode(modeName)
	local mode = self:getMode(modeName)
	
	self.currentMode = mode.name
end

function Mode.new(modeName, initf)
	local self = setmetatable({
		name = modeName
	})

	self.config = initf(self)
	
	return self
end

-- default functions