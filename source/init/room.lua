function Room:init()
	local this = tfm.get.room
	
	self.mode = nil
	self.worldSeed = 0
	self.language = this.language
	self.isTribe = this.isTribeHouse
	self.fullName = this.name
	self.isPrivate = (this.name:sub(1, 1) == "@") or this.passwordProtected--this.name:match("^@")
	
	self.isFunCorp = false
	
	self.args = {}
	do
		for arg in self.fullName:gmatch("[^%d%s]+") do
			table.insert(self.args, arg)
		end
	
		
		if #self.args >= 1 then
			if self.args[1]:find("#micecraft", 1, true) then
				self.mode = self.args[2] or "vanilla"
			
				if #self.args == 1 then
					self.worldSeed = enum.community
				else
					self.worldSeed = tonumber(self.fullName:match("#micecraft(%d+)")) or os.time()
				end
			else
				if self.isTribe then
					self.mode = self.fullName
					self.isFunCorp = false
				else
					self.isFunCorp = true
					self.mode = "funcorp"
				end
				
				self.worldSeed = 0
			end
		else
			Module:unload()
		end
	end
	
	self.totalPlayers = 0
	self.activePlayers = 0
	self.bannedPlayers = 0
	
	
	self.playerList = {}
	for playerName, playerData in next, this.playerList do
		eventNewPlayer(playerName)
	end
end

function Room:hasPlayer(playerName)
	return not not self.playerList[playerName]
end

function Room:getPlayer(playerName)
	return self.playerList[playerName]
end

do
	local bindMouse = system.bindMouse
	local bindKeyboard = system.bindKeyboard
	local lowerSyncDelay = tfm.exec.lowerSyncDelay
	function Room:newPlayer(playerName)
		if not self:hasPlayer(playerName) then
			self.playerList[playerName] = Player:new(playerName)
			
			self:getPlayer(playerName):loadData()
			
			bindMouse(playerName, true)
			
			for keyId, keyName in next, enum.keys do
				bindKeyboard(playerName, keyId, true, true)
				bindKeyboard(playerName, keyId, false, true)
			end
			
			lowerSyncDelay(playerName)
			
			self.activePlayers = self.activePlayers + 1
		end
		
		Room.presencePlayerList[playerName] = true
	end
end

function Room:playerLeft(playerName)
	if self:hasPlayer(playerName) then
		self:getPlayer(playerName):saveData()	
		
		self.playerList[playerName] = nil
		
		self.activePlayers = self.activePlayers - 1
	end
	
	Room.presencePlayerList[playerName] = nil
end