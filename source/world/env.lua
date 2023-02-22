function World:setVariables(blockWidth, blockHeight, chunkWidth, chunkHeight, worldChunkRows, worldChunkLines, horizontalOffset, verticalOffset)
	-- Block
	self.blockWidth = blockWidth or 32
	self.blockHeight = blockHeight or 32
	self.blockSize = self.blockWidth + ((self.blockWidth - self.blockHeight) / 2)
	
	REFERENCE_SCALE = self.blockSize / TEXTURE_SIZE
	REFERENCE_SCALE_X = self.blockWidth / TEXTURE_SIZE
	REFERENCE_SCALE_Y = self.blockHeight / TEXTURE_SIZE
	
	-- Chunk
	
	self.chunkWidth = chunkWidth or 16
	self.chunkHeight = chunkHeight or 16
	
	self.chunkSize = self.chunkWidth * self.chunkHeight
	
	self.chunkPixelWidth = self.chunkWidth * self.blockWidth
	self.chunkPixelHeight = self.chunkHeight * self.blockHeight
	
	-- World
	
	self.chunkRows = worldChunkRows or self.chunkRows
	self.chunkLines = worldChunkLines or self.chunkLines
	
	self.totalChunks = self.chunkRows * self.chunkLines
	
	self.totalBlockWidth = self.chunkRows * self.chunkWidth
	self.totalBlockHeight = self.chunkLines * self.chunkHeight
	
	self.totalBlocks = self.totalChunks * self.chunkSize
	
	self.pixelWidth = math.min(BOX2D_MAX_SIZE, self.blockWidth * (self.chunkWidth * self.chunkRows))
	self.pixelHeight = math.min(BOX2D_MAX_SIZE, self.blockHeight * (self.chunkHeight * self.chunkLines))
	
	self.horizontalOffset = math.min(horizontalOffset*2, (BOX2D_MAX_SIZE - self.pixelWidth) / 2)
	self.verticalOffset = math.min(verticalOffset, (BOX2D_MAX_SIZE - self.pixelHeight) / 2)
	
	self.leftEdge = self.horizontalOffset
	self.rightEdge = (2 * self.horizontalOffset) + self.pixelWidth
	
	self.upperEdge = self.verticalOffset
	self.lowerEdge = (2 * self.verticalOffset) + self.pixelHeight
	
	self:setCounter("chunks_collide", 0, false)
	self:setCounter("chunks_display", 0, false)
	self:setCounter("chunks_item", 0, false)
end

function World:getBlockDimensions()
	return self.blockWidth, self.blockHeight, self.blockSize
end

function World:getChunkDimensions()
	return self.chunkWidth, self.chunkHeight, self.chunkSize
end

function World:getChunkPixelDimensions()
	return self.chunkPixelWidth, self.chunkPixelHeight
end

function World:getPixelDimensions()
	return self.pixelWidth, self.pixelHeight
end

function World:getMapPixelDimensions()
	return self.rightEdge, self.lowerEdge
end

function World:getBlocks()
	return self.totalBlockWidth, self.totalBlockHeight
end

function World:getChunks()
	return self.chunkRows, self.chunkLines
end

function World:getOffsets()
	return self.horizontalOffset, self.verticalOffset
end

function World:getEdges()
	return self.leftEdge, self.upperEdge, self.rightEdge, self.lowerEdge
end

-- -- -- --

function World:setForces(gravity, wind)
	self.gravityForce = gravity or 10.0
	self.windForce = wind or 0.0
	
	return self.gravityForce, self.windForce
end

function World:setCounter(counterName, value, add)
	value = value or 0
	if not self.counter[counterName] then
		self.counter[counterName] = 0
	end
	
	if add then
		self.counter[counterName] = self.counter[counterName] + value
	else
		self.counter[counterName] = value or 0
	end
end

function World:getSpawn()
	local x = math.ceil(self.totalBlockWidth / 2)
	local block 
	for y = #self.blocks, 1, -1 do
		block = self.blocks[y][x]		
		if block.type == 0 then
			self.spawnPoint = {
				x = x,
				y = y,
				dx = block.dxc,
				dy = block.dyc
			}
			
			break
		end
	end
	
	local under = self:getBlock(self.spawnPoint.x, self.spawnPoint.y + 1, "matrix")
	
	if under then
		--under:create("bedrock")
	end
	
	return self.spawnPoint
end