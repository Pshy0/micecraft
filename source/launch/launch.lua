function Module:start()
	Room:init()
	
	local mode = self:setMode(Room.mode)
	mode:init()
	
	World:init()
	
	mode:run()
end


Module:start()