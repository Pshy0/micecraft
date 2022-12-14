local Room = {}

local Module = {}

function Module:init(apiVersion, tfmVersion)
	local misc = tfm.get.misc
	
	self.apiVersion = apiVersion or misc.apiVersion
	self.tfmVersion = tfmVersion or misc.transformiceVersion
	
	if self.apiVersion ~= misc.apiVersion then
		self:emitWarning(3, "Module API version mismatch")
	end
	
	self.eventList = {}
	self.currentCycle = 0
	self.cycleDuration = {}
	
	self.runtimeLog = {}
	self.currentRuntime = 0
	self.runtimeLimit = 52
	
	self.isPaused = false
end

function Module:emitWarning(severity, message)
	message = message or "unknown"
	severity = severity or 4
	local color = ({"R", "O", "J", "V"})[severity] or "V"
	
	tfm.exec.chatMessage(("<%s>[Warning]<%s> <N>%s</N>"):format(color, color, message))
end

function Module:unload(handled)
	if not handled then
		self:emitWarning(1, "The Module has been unloaded due to an uncatched exception.")
		
		system.newTimer(function(id)
			error("Unhandled exception")
		end, 500, false)
	else
		system.exit()
	end
end

function Module:throwError() -- Exception
	
end


local Event = {}
Event.__index = Event

do
	local nativeEvents = {
		["ChatCommand"] = true,
		["ChatMessage"] = true,
		["ColorPicked"] = true,
		["ContactListener"] = true,
		["EmotePlayed"] = true,
		["FileLoaded"] = true,
		["FileSaved"] = true,
		["Keyboard"] = true,
		["Mouse"] = true,
		["Loop"] = true,
		["NewGame"] = true,
		["NewPlayer"] = true,
		["PlayerDataLoaded"] = true,
		["PlayerDied"] = true,
		["PlayerGetCheese"] = true,
		["PlayerBonusGrabbed"] = true,
		["PlayerLeft"] = true,
		["PlayerVampire"] = true,
		["PlayerWon"] = true,
		["PlayerRespawn"] = true,
		["PlayerMeep"] = true,
		["PopupAnswer"] = true,
		["SummoningCancel"] = true,
		["SummoningEnd"] = true,
		["SummoningStart"] = true,
		["TextAreaCallback"] = true,
		["TalkToNPC"] = true
	}
	function Event.new(eventName)
		local self = setmetatable({}, Event)
		
		self.keyName = eventName
		self.isNative = nativeEvents[eventName]
		self.calls = {}
		
		if self.isNative then
			self.trigger = Event.triggerCount
		else
			self.trigger = Event.triggerUncount
		end
		
		return self
	end
end

function Event:append(callback)
	self.calls[#self.calls + 1] = callback
end

do
	local currentTime = os.time
	
	
	function Event:triggerUncount(...)
		local ok, result
		
		for index, instance in next, self.calls do
			if not Module.isPaused then
				ok, result = pcall(instance, ...)
				
				if not ok then
					return false, result
				end
			end
		end
		
		return true, ":D"
	end
	
	function Event:triggerCount(...)
		local ok, result, startTime
		for index, instance in next, self.calls do
			if not Module.isPaused then
				startTime = currentTime()
				ok, result = pcall(instance, ...)
				
				if ok then
					Module:increaseRuntime(currentTime() - startTime)
				else
					return false, result
				end
			end
		end
		
		return true, ":D"
	end
end

function Module:getEvent(eventName)
	return self.eventList[eventName]
end

function Module:hasEvent(eventName)
	return not not self:getEvent(eventName)
end

function Module:on(eventName, callback)
	local eventFullName = ("event%s"):format(eventName)
	if not self:hasEvent(eventName) then
		self:addEvent(eventName)
		
		_G[eventFullName] = function(...)
			self:trigger(eventName, ...)
		end
	end
	
	self:getEvent(eventName):append(callback)
end

function Module:addEvent(eventName)
	self.eventList[eventName] = Event.new()
end

function Module:trigger(eventName, ...)
	local ok, result = self:getEvent(eventName):trigger(...)
	
	if not ok then
		self:throwError(result)
	end
end

function Module:increaseRuntime(increment)
	self.currentRuntime = self.currentRuntime + increment
	
	if self.currentRuntime >= self.runtimeLimit then
		self:pause()
	end
end

function Module:pause()
	local time = math.max(500, ((self.currentCycle + 1.25) * self.cycleDuration) - currentTime())
	
	self.isPaused = true
	
	-- Pause players and objects
	
	system.newTimer(function(id)
		self:continue()
	end, time, false)
end

function Module:continue()
	self.isPaused = false
	-- trigger appended events
	self:setCycle()
end

function Module:setCycle()
	local lastCycle = self.currentCycle
	
	self.currentCycle = math.ceil(currentTime() / self.cycleDuration)
	
	if self.currentCycle ~= lastCycle then
		self.runtimeLog[lastCycle] = self.currentRuntime
		
		self.currentRuntime = 0
	end
end