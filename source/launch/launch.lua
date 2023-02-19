function Module:start()
	Room:init()
	
	local mode = self:setMode(Room.mode)
	mode:init()
	
	World:init()
	
	mode:run()
	
	local width, height = World:getMapPixelDimensions()
	tfm.exec.newGame(xmlLoad:format(width, height, width/2, height/2))
end


Module:start()