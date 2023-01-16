--- Initializes the Module.
-- This function creates the table for the event list, the registers of
-- runtime and may be used to verify various other things. It should
-- only be called on pre-start, because it doesn't check if previous
-- values already exist, and may delete all of them.
function Module:init(apiVersion, tfmVersion)
	
	self.apiVersion = ""
	self.tfmVersion = ""
	self:assertVersion(apiVersion, tfmVersion)
	
	self.eventList = {}
	self.currentCycle = 0
	self.cycleDuration = {}
	
	self.runtimeLog = {}
	self.currentRuntime = 0
	self.runtimeLimit = 52
	
	self.isPaused = false
	
	self.args = {}
end

--- Asserts if API version matches the defined version for this Module.
-- In case it doesn't, a warning will be displayed for players to
-- inform the developer. 
-- @param apiVersion The defined API version that this Module has been updated for.
-- @param tfmVersion The defined TFM version.
-- @return `Boolean` Whether the versions defined match 
function Module:assertVersion(apiVersion, tfmVersion)
	local misc = tfm.get.misc
	
	self.apiVersion = apiVersion or misc.apiVersion
	self.tfmVersion = tfmVersion or misc.transformiceVersion
	
	local apiMatch = (self.apiVersion == misc.apiVersion)
	local tfmMatch = (self.tfmVersion == misc.transformiceVersion)
	
	
	if not apiMatch then
		self:emitWarning(3, "Module API version mismatch")
	end
	
	if not tfmMatch then
		self:emitWarning(4, "Transformice version mismatch")
	end
	
	return (apiMatch and tfmMatch)
end

--- Emits a warning, as a message on chat, with the issue provided.
-- @param severity How severe is the warning. Accepts values from 1 to 4, being 1 the most severe and 4 the least severe.
-- @param message The warning message to display.
function Module:emitWarning(severity, message)
	message = message or "unknown"
	severity = severity or 4
	local color = ({"R", "O", "J", "V"})[severity] or "V"
	
	tfm.exec.chatMessage(("<%s>[Warning]</%s> <N>%s</N>"):format(color, color, message))
end

--- Triggers an exit of the proccess.
-- It should only be called on special situations, as a server restart
-- or a module crash. It will automatically save all the data that
-- needs to be saved, in case the unload is 'handled'.
-- @param handled Wheter the unloading is caused by a handled situation or not.
function Module:unload(handled)
	if handled then
		-- Save Data
	else -- UNHANDLED
		self:emitWarning(1, "The Module has been unloaded due to an uncatched exception.")
	end
	
	system.newTimer(function(id)
		system.exit()
	end, 500, false)
end

function Module:onError(errorMessage, ...)
end

function Module:throwException(fatal, errorMessage, ...) -- To do
	if fatal then
		self:onError(errorMessage, ...)
	else
		self:emitWarning(1, errorMessage)
	end
end


local Event = {}

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
	function Event:new(eventName)
		local this = setmetatable({
			keyName = eventName,
			isNative = nativeEvents[eventName],
			calls = {}
		}, self)

		this.__index = self
		
		if this.isNative then
			this.trigger = Event.triggerCount
		else
			this.trigger = Event.triggerUncount
		end
		
		return this
	end
end

function Event:append(callback)
	self.calls[#self.calls + 1] = callback
	
	return #self.calls
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

-- Gets the Event object by the event name provided.
-- @param eventName The name of the Event to get its object from.
-- @return `Event|nil` The Event object, if it exists.
function Module:getEvent(eventName)
	return self.eventList[eventName]
end

-- Tells if an Event has been defined on the module.
-- @param eventName The name of the Event to assert.
-- @return `Boolean` Whether the Event exists or not.
function Module:hasEvent(eventName)
	return not not self:getEvent(eventName)
end

--- Creates a callback to trigger when an Event is emmited.
-- In case the Event exists, it will append the callback to the
-- internal list of the Event, so every callback will be executed
-- on the order it is defined. Otherwise it doesn't exist, an
-- Event object will be created, and the Event will be defined on
-- the Global Space.
-- @param eventName The name of the Event.
-- @param callback The callback to trigger.
-- @return `Boolean` Whether a new Event object was created or not.
-- @return `Number` The position of the callback in the calls list.
function Module:on(eventName, callback)
	local createdNewObject, position
	local eventFullName = ("event%s"):format(eventName)

	if not self:hasEvent(eventName) then
		createdNewObject = self:addEvent(eventName)
		
		_G[eventFullName] = function(...)
			self:trigger(eventName, ...)
		end
	end
	
	position = self:getEvent(eventName):append(callback)
	
	return createdNewObject, position
end

--- Adds an Event listener.
-- It will create the Event object required, with the event name
-- that has been provided.
-- @param eventName The name of the Event to create.
-- @return `Boolean` Whether or not a new Event object has been created.
function Module:addEvent(eventName)
	if not self:hasEvent(eventName) then
		self.eventList[eventName] = Event.new(eventName)
		
		return true
	end
	
	return false
end

do
	local critical = {
		["Loop"] = true,
		["NewGame"] = true,
		["NewPlayer"] = true,
		["PlayerLeft"] = true,
		["PlayerDataLoaded"] = true
 	}
	
	--- Triggers the callbacks of an event emmited.
	-- This function should not be called other than inside a true event
	-- definition. For the sake of performance, it assumes that the event
	-- provided already exists, and thus doesn't check for a nil listener.
	-- @param eventName The event to trigger.
	-- @return `Boolean` Whether the Event triggered without errors.
	function Module:trigger(eventName, ...)
		local ok, result = self:getEvent(eventName):trigger(...)
		
		if not ok then
			local isFatal = not not critical[eventName]
			self:throwException(isFatal, result)
		end
		
		return ok
	end
end

--- Increases the runtime counter of the Module.
-- It will also check if the runtime reaches the limit established for the
-- module, and trigger a `Module Pause` in such case.
-- @param increment The amount of milliseconds to increment into the counter.
-- @return `Boolean` Whether the increment in runtime has caused the Module to pause.
function Module:increaseRuntime(increment)
	self.currentRuntime = self.currentRuntime + increment
	
	if self.currentRuntime >= self.runtimeLimit then
		self:pause()
		
		return true
	end
	
	return false
end

--- Triggers a Module Pause.
-- When it triggers, no events will be listened, and all objects will freeze.
-- This function is automatically called by a runtime check when an event
-- triggers, however, it `should` be safe to call it dinamically.
-- After pausing, the Module will automatically ressume on the next cycle.
-- @return `Number` The time it will take to ressume the Module, in milliseconds.
function Module:pause()
	local time = math.max(500, ((self.currentCycle + 1.25) * self.cycleDuration) - currentTime())
	
	self.isPaused = true
	
	-- Pause players and objects
	
	system.newTimer(function(id)
		self:continue()
	end, time, false)

	return time
end

--- Continues the Module execution.
-- All events ressume listening, as well as players take back their movility.
-- It will check if the Module is already paused, so it is safe to call it
-- without previous checks.
-- @return `Boolean` Whether the Module has been resumed or not.
function Module:continue()
	if self.isPaused then
		self.isPaused = false
		
		-- trigger appended events
		
		self:setCycle()
		
		return true
	end

	return false
end

--- Sets the appropiate Cycle of runtime checking.
-- Whenever a new cycle occurs, the runtime counter will reset,
-- and its fingerprint will log.
-- @return `Number` The current cycle.
function Module:setCycle()
	local lastCycle = self.currentCycle
	
	self.currentCycle = math.ceil(currentTime() / self.cycleDuration)
	
	if self.currentCycle ~= lastCycle then
		self.runtimeLog[lastCycle] = self.currentRuntime
		
		self.currentRuntime = 0
	end
	
	return self.currentCycle
end

function Module:setPercentageCounter()
	
end

function Module:updatePercentage(increment)

end

function Module:getDebugInfo(asText)
	
end

function Module:setSync(playerName) -- Seeks for the player with the lowest latency for syncing.
	if playerName then
		if not Room:hasPlayer(playerName) then
			playerName = nil
		end
	end
	
	if not playerName then
		local candidate, bestLatency = "", math.huge
		
		for playerName, player in next, tfm.get.room.playerList do
			if player.averageLatency <= bestLatency then
				bestLatency = player.averageLatency
				candidate = playerName
			end
		end
		
		playerName = candidate
	end
	
	tfm.exec.setPlayerSync(playerName)
end

function Module:newMode(modeName, constructor)
	self.modeList[modeName] = Mode:new(modeName, constructor)
end

function Module:getMode(modeName)
	modeName = modeName or self.subMode
	return self.modeList[modeName] or self.modeList[modeName:lower()]
end

function Module:hasMode(modeName)
	return not not self:getMode(modeName or "")
end

do
	local rawget = rawget
	local rawset = rawset
	function Module:setMode(modeName)
		local mode = self:getMode(modeName) or self:getMode("default")
		
		if mode then
			mode:constructor({ -- Proxy table
				__index = function(t, k)
					return rawget(mode.environment, k)
				end,
				__newindex = function(t, k, v)
					rawset(mode.environment, k, v)
				end
			})
		
			self.settings = mode:getSettings()
		end
		
		return mode
	end
end