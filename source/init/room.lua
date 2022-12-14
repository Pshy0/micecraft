function Room:init()
	local this = tfm.get.room
	
	self.language = this.language
	self.isTribe = this.isTribeHouse
	self.fullName = this.name
	self.isPrivate = this.name:match("^@")
	
	self.args = {}
	do
		for arg in self.fullName:gmatch("[^%d%s]") do
			table.insert(self.args, arg)
		end
		
		table.remove(self.args, 1)
	end
	
	self.totalPlayers = 0
	self.activePlayers = 0
	self.bannedPlayers = 0
	
	
	self.playerList = {}
	for playerName, playerData in next, this.playerList do
		self:newPlayer(playerName)
	end
end

function Room:newPlayer(playerName)
	if not self.playerList[playerName] then
		self.playerList[playerName] = Player.new(playerName)
		
		self.activePlayers = self.activePlayers + 1
	end
end

function Room:playerLeft(playerName)
	if self.playerList[playerName] then
		self.playerList[playerName] = nil
		
		self.activePlayers = self.activePlayers - 1
	end
end