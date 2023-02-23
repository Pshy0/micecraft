function Player:updatePosition(x, y, vx, vy)
	local world = World
	
	self.x = x or self.x
	self.y = y or self.y
	
	self.vx = vx or self.vx
	self.vy = vy or self.vy
	
	self.bx = (self.x - world.horizontalOffset) / world.blockWidth
	self.by = (self.y - world.verticalOffset) / world.blockHeight
end

do
	function Player:updateInformation(x, y, vx, vy, facingRight)
		local info = tfm.get.room.playerList[self.name] or {}
		local k = self.keys
		
		self:updatePosition(
			x or info.x,
			y or info.y,
			vx or info.vx,
			vy or info.vy
		)
		
		self.isJumping = info.isJumping
		
		self:updateDirection(facingRight, k[0] or k[2] or info.isJumping)
	end
	
	function Player:updateDirection(facingRight, moving)
		local facingUpdated, movingUpdated
		if facingRight ~= nil then
			self.isFacingRight = facingRight
			facingUpdated = true
		end
		
		if moving ~= nil then
			self.isMoving = moving
			movingUpdated = true
		end
		
		if facingUpdated or movingUpdated then
			-- self:adjustItemHeld()
		end
	end
	
	function Player:updateChunkArea()
		local world = World
		local chunk = world:getChunk(self.bx, self.by, "block")
		
		if chunk then
			if chunk.uniqueId ~= self.currentChunk then
				self.lastChunk = chunk.uniqueId
			end
			
			self:queueNearChunks(chunk, true)
			
			self.currentChunk = chunk.uniqueId
		end
	end
	
	function Player:setClock(time, add, runEvents)
		time = time or (add and 500 or self.internalTime)
		self.internalTime = (add and self.internalTime + time or time)

		if runEvents then
			if self.internalTime % 1000 == 0 then
				if self.internalTime % 2000 == 0 then -- Every 2 seconds
					self:updateChunkArea()
				end
				
				
			end
			
			if self.showDebugInfo then
				self:setDebugInformation(true)
			end
		end
	end
end