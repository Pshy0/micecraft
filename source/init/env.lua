local env = { -- Default values
	blockSize = 32,
	
	chunkSize = 256, -- width x height
	chunkWidth = 16,
	chunkHeight = 16,
	
	worldChunkLines = 16,
	worldChunkRows = 32,
	worldHeight = 256,
	worldWidth = 512,
	
	worldSize = 2^17,
	
	worldPixelWidth = 2^14,
	worldPixelHeight = 2^13,
	
	worldHorizontalOffset = 0,
	worldVerticalOffset = 0,
	
	worldLeftEdge = 0,
	worldRightEdge = 0,
	worldUpperEdge = 0,
	worldLowerEdge = 0
}

local TEXTURE_SIZE = 32 -- Constant according to assets uploaded. Do not modify !
local REFERENCE_SCALE = 1.0

function env:setVariables(blockSize, chunkWidth, chunkHeight, worldChunkRows, worldChunkLines)
	-- Block
	self.blockSize = blockSize or self.blockSize
	
	REFERENCE_SCALE = self.blockSize / TEXTURE_SIZE
	
	-- Chunk
	
	self.chunkWidth = chunkWidth or self.chunkWidth
	self.chunkHeight = chunkWidth or self.chunkHeight
	
	self.chunkSize = self.chunkWidth * self.chunkHeight
	
	-- World
	
	self.worldChunkRows = worldChunkRows or self.worldChunkRows
	self.worldChunkLines = worldChunkLines or self.worldChunkLines
	
	self.worldSize = (self.worldChunkRows * self.worldChunkLines) * self.chunkSize
	
	self.worldPixelWidth = self.blockSize * (self.chunkWidth * self.worldChunkRows)
	self.worldPixelHeight = self.blockSize * (self.chunkHeight * self.worldChunkLines)
	
	self.worldHorizontalOffset = 0
	self.worldVerticalOffset = 0
	
	self.worldLeftEdge = self.worldHorizontalOffset
	self.worldRightEdge = self.worldHorizontalOffset + self.worldPixelWidth
	
	self.worldUpperEdge = self.worldVerticalOffset
	self.worldLowerEdge = self.worldVerticalOffset + self.worldPixelHeight
	
end

function env:getEdges()
	return self.worldLeftEdge, self.worldRightEdge, self.worldUpperEdge, self.worldLowerEdge
end