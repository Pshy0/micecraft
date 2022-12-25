World.blocks = {}
World.chunks = {}

function World:initBlocks()
	local width, height = Env:getWorldBlocks()
	local blockId = 0
	
	local blockMatrix = self.blocks
	
	for y = 1, height do
		blockMatrix[y] = {}
		for x = 1, width do
			blockId = blockId + 1
			blockMatrix[y][x] = blockId -- Block.new (blockId)
		end
	end
end

function World:initChunks()
	local widthLim, heightLim = Env:getWorldChunks()
	local width, height = Env:getChunkDimensions()
	local chunkId = 0
	
	for y = 1, heightLim do
		self.chunks[y] = {}
		for x = 1, widthLim do
			chunkId = chunkId + 1
			self.chunks[y][x] = chunkId -- Chunk.new (chunkId, (x - 1) * width, (y - 1) * height)
		end
	end
end

function World:init()
	
	self:initBlocks()
	self:initChunks()
end