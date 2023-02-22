function World:initPhysics(width, height)
	local pm = self.physicsMap
	
	for y = 1, height do
		pm[y] = {}
		for x = 1, width do
			pm[y][x] = 0
		end
	end
end

function World:initBlocks(width, height)
	local blockId = 0
	
	local blocks = self.blocks
	local field = Field
	local pm = self.physicsMap
	
	local bw, bh = self:getBlockDimensions()
	local ox, oy = self:getEdges()
	
	local temp
	
	for y = 1, height do
		blocks[y] = {}
		for x = 1, width do
			blockId = blockId + 1
			
			temp = field[y][x]
			
			blocks[y][x], pm[y][x] = Block:new(
				blockId,
				temp.type, temp.tangible,
				x, y,
				ox + ((x-1) * bw), oy + ((y-1) * bh),
				bw, bh
			)
		end
	end
end

function World:initChunks()
	local widthLim, heightLim = self:getChunks()
	local width, height = self:getChunkDimensions()
	local xoff, yoff = self:getOffsets()
	local xp, yp = self:getChunkPixelDimensions()
	local chunkId = 0
	
	for y = 1, heightLim do
		self.chunks[y] = {}
		for x = 1, widthLim do
			chunkId = chunkId + 1
			self.chunks[y][x] = Chunk:new(
				chunkId, 
				x, y, 
				width, height, 
				((x-1) * width) + 1, ((y-1) * height) + 1,
				xoff + ((x - 1) * xp), yoff + ((y-1) * yp),
				1
			)
			
			self.chunks[y][x]:getCollisions(self.physicsMode)
			self.chunkLookup[chunkId] = {x=x, y=y}
		end
	end
end

function World:init()
	self:setPhysicsMode()
	local mode = Module:getMode()
	
	local width, height = self:getBlocks()
	Field:generateNew(width, height)
	
	mode:setWorld(Field)
	
	self:initPhysics(width, height)
	self:initBlocks(width, height)
	self:initChunks()
end