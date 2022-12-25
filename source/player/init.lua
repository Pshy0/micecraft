function Player.new(playerName)
	local self = setmetatable({}, Player)
	local this = tfm.get.room.playerList[playerName]
	
	self.name = playerName
	
	self.language = this.language
	
	self.x = 0
	self.y = 0
	self.vx = 0
	self.vy = 0
	
	self.isMoving = false
	self.isJumping = false
	self.isFacingRight = true
	
	self.isAlive = false
	self.isBanned = false
	
	self.keys = {}
	
	self.dataFile = ""
	self.awaitingData = false
	
	return self
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

function Player:assertValidity() -- TO do
	return not self.isBanned
end