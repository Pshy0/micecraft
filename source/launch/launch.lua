function Module:start()
	Room:init()
	
	local mode = self:setMode(Room.mode)
	mode:init(World)
	
	World:init()
	
	tfm.exec.disableAfkDeath(true)
	tfm.exec.disableAutoNewGame(true)
	tfm.exec.disableAutoScore(true)
	tfm.exec.disableAutoShaman(true)
	tfm.exec.disableAutoTimeLeft(true)
	tfm.exec.disablePhysicalConsumables(true)
	
	mode:run()
	
	do
		local spawn = World:getSpawn()
		local width, height = World:getMapPixelDimensions()
		tfm.exec.newGame(xmlLoad:format(width, height, spawn.dx, spawn.dy))
	end
end


Module:start()