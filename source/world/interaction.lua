do
	local ceil = math.ceil
	function World:getBlock(x, y, ctype)
		local fx, fy -- Fixed Positions
		
		if ctype == "matrix" then
			fx, fy = x, y
		elseif ctype == "map" then
			local ox, oy = self:getEdges()
			local bx, by = self:getBlockDimensions()
			
			x = x - ox
			y = y - oy
			
			fx = ceil(x / bx)
			fy = ceil(y / by)
		end
		
		if self.blocks[fy] then
			return self.blocks[fy][fx]
		end
	end
	
	function World:getChunk(x, y, ctype)
		local fx, fy -- Fixed Positions
		
		if ctype == "matrix" then
			fx = x
			fy = y
		elseif y  == "uniqueId" then
			local info = self.chunkLookup[x]
			fx = info.x
			fy = info.y
		elseif ctype == "map" then
			local ox, oy = self:getEdges()
			local cx, cy = self:getChunkPixelDimensions()
			
			fx = ceil((x - ox) / cx)
			fy = ceil((y - oy) / cy)
		elseif ctype == "block" then
			local cx, cy = self:getChunkDimensions()
			
			fx = ceil(x / cx)
			fy = ceil(y / cy)
		end
		
		if self.chunks[fy] then
			return self.chunks[fy][fx]
		end
	end
end

function World:setPhysicsMode(physicsMode)
	self.physicsMode = physicsMode or self.physicsMode or "rectangle_detailed"
end