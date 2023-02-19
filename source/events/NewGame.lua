Module:on("NewGame", function()
	for playerName, player in next, Room.playerList do
		player:init()
	end
	
	for y = 1, #World.chunks do
		for x = 1, #World.chunks[1] do
			World.chunks[y][x]:setPhysicState(true)
			World.chunks[y][x]:setDisplayState(true)
		end
	end
end)