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
	self.chunkHeight = chunkWidth or 16
	
	self.chunkSize = self.chunkWidth * self.chunkHeight
	
	self.chunkPixelWidth = self.chunkWidth * self.blockWidth
	self.chunkPixelHeight = self.chunkHeight * self.blockHeight
	
	-- World
	
	self.chunkRows = worldChunkRows or self.chunkRows
	self.chunkLines = worldChunkLines or self.chunkLines
	
	self.worldSize = (self.chunkRows * self.chunkLines) * self.chunkSize
	
	self.pixelWidth = math.min(BOX2D_MAX_SIZE, self.blockWidth * (self.chunkWidth * self.chunkRows))
	self.pixelHeight = math.min(BOX2D_MAX_SIZE, self.blockHeight * (self.chunkHeight * self.chunkLines))
	
	self.horizontalOffset = math.min(horizontalOffset, BOX2D_MAX_SIZE - self.pixelWidth)
	self.verticalOffset = math.min(verticalOffset, BOX2D_MAX_SIZE - self.pixelHeight)
	
	self.leftEdge = self.horizontalOffset
	self.rightEdge = self.horizontalOffset + self.pixelWidth
	
	self.upperEdge = self.verticalOffset
	self.lowerEdge = self.verticalOffset + self.pixelHeight
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

function World:getBlocks()
	return self.chunkRows * self.chunkWidth, self.chunkLines * self.chunkHeight
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