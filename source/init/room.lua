function Room:init()
	local this = tfm.get.room
	
	self.language = this.language
	self.isTribe = this.isTribeHouse
	self.fullName = this.name
	self.isPrivate = (this.name:sub(1, 1) == "@") or this.passwordProtected--this.name:match("^@")
	
	self.args = {}
	do
		for arg in self.fullName:gmatch("[^%d%s]+") do
			table.insert(self.args, arg)
		end
		
		table.remove(self.args, 1)
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

function Room:newPlayer(playerName)
	if not self:hasPlayer(playerName) then
		self.playerList[playerName] = Player.new(playerName)
		
		self:getPlayer(playerName):loadData()
		
		self.activePlayers = self.activePlayers + 1
	end
end

function Room:playerLeft(playerName)
	if self:hasPlayer(playerName) then
		self:getPlayer(playerName):saveData()	
		
		self.playerList[playerName] = nil
		
		self.activePlayers = self.activePlayers - 1
	end
end