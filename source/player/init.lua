function Player:new(playerName)
	local info = tfm.get.room.playerList[playerName]
	
	local this = setmetatable({
		name = playerName,
		
		language = info.language,
		
		x = 0,
		y = 0,
		
		vx = 0,
		vy = 0,
		
		isMoving = false,
		isJumping = false,
		isFacingRight = true,
		
		isAlive = false,
		isBanned = false,
		
		keys = {}
		
		dataFile = "",
		awaitingData = false
	}, self)

	this.__index = self
	
	return this
end

function Player:init()
	local this = tfm.get.room.playerList[self.name]
	
	self.isMoving = false
	self.isJumping = false
	self.isFacingRight = true
	
	self.isAlive = not this.isDead
	self.isActive = false
	
	if self:assertValidity() then
		if not self.isAlive then
			tfm.exec.respawnPlayer(self.name)
			self.isActive = true
		end
	else
		self.isActive = false
		tfm.exec.killPlayer(self.name)
	end
end

function Player:assertValidity() -- To Do
	return not self.isBanned
end