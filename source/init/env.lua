local BOX2D_MAX_SIZE = 32767 -- Constant according to game limitations. Do not modify!
local TEXTURE_SIZE = 32 -- Constant according to assets uploaded. Do not modify !
local REFERENCE_SCALE = 1.0
local REFERENCE_SCALE_X = 1.0
local REFERENCE_SCALE_Y = 1.0

local Env = { -- Default values
	blockSize = 32,
	blockHeight = 32,
	blockWidth = 32,
	
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
	worldLowerEdge = 0,
	
	limWorldBlockWidth = math.floor(BOX2D_MAX_SIZE / 32), -- Develop further
	limWorldBlockHeight = math.floor(BOX2D_MAX_SIZE / 32)
}

function Env:setVariables(blockSize, chunkWidth, chunkHeight, worldChunkRows, worldChunkLines)
	-- Block
	self.blockSize = blockSize or self.blockSize
	self.blockWidth = self.blockSize
	self.blockHeight = self.blockSize
	
	REFERENCE_SCALE = self.blockSize / TEXTURE_SIZE
	REFERENCE_SCALE_X = self.blockWidth / TEXTURE_SIZE
	REFERENCE_SCALE_Y = self.blockHeight / TEXTURE_SIZE
	
	-- Chunk
	
	self.chunkWidth = chunkWidth or self.chunkWidth
	self.chunkHeight = chunkWidth or self.chunkHeight
	
	self.chunkSize = self.chunkWidth * self.chunkHeight
	
	-- World
	
	self.worldChunkRows = worldChunkRows or self.worldChunkRows
	self.worldChunkLines = worldChunkLines or self.worldChunkLines
	
	self.worldSize = (self.worldChunkRows * self.worldChunkLines) * self.chunkSize
	
	self.worldPixelWidth = math.min(BOX2D_MAX_SIZE, self.blockWidth * (self.chunkWidth * self.worldChunkRows))
	self.worldPixelHeight = math.min(BOX2D_MAX_SIZE, self.blockHeight * (self.chunkHeight * self.worldChunkLines))
	
	self.worldHorizontalOffset = math.min(0, BOX2D_MAX_SIZE - self.worldPixelWidth)
	self.worldVerticalOffset = math.min(0, BOX2D_MAX_SIZE - self.worldPixelHeight)
	
	self.worldLeftEdge = self.worldHorizontalOffset
	self.worldRightEdge = self.worldHorizontalOffset + self.worldPixelWidth
	
	self.worldUpperEdge = self.worldVerticalOffset
	self.worldLowerEdge = self.worldVerticalOffset + self.worldPixelHeight
	
end

function Env:getBlockDimensions()
	return self.blockWidth, self.blockHeight, self.blockSize
end

function Env:getChunkDimensions()
	return self.chunkWidth, self.chunkHeight, self.chunkSize
end

function Env:getWorldBlocks()
	return self.worldChunkRows * self.chunkWidth, self.worldChunkLines * self.chunkHeight
end

function Env:getWorldChunks()
	return self.worldChunkRows, self.worldChunkLines
end

function Env:getEdges()
	return self.worldLeftEdge, self.worldRightEdge, self.worldUpperEdge, self.worldLowerEdge
end