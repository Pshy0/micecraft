function World:generateNewMapData()
	local width, height = Env:getWorldBlocks()
	
	local pre = self.pre
	
	for y = 1, height do
		pre[y] = {}
		for x = 1, width do
			pre[y][x] = {0, false}
		end
	end
	
	function pre:assignTemplate(x, y, template)
		if template.type ~= nil then
			self[y][x].type = template.type
		end
		
		if template.tangible ~= nil then
			self[y][x].tangible = template.tangible
		end
	end
end

function World:initPhysics()
	local width, height = Env:getWorldBlocks()
	
	local pm = self.physicsMap
	local pre = self.pre
	
	for y = 1, height do
		pm[y] = {}
		for x = 1, width do
			pm[y][x] = pre[y][x]
		end
	end
end

function World:initBlocks()
	local width, height = Env:getWorldBlocks()
	local blockId = 0
	
	local blocks = self.blocks
	local pre = self.pre
	
	local bw, bh = Env:getBlockDimensions()
	
	
	for y = 1, height do
		blocks[y] = {}
		for x = 1, width do
			blockId = blockId + 1
			blocks[y][x] = Block.new(
				blockId,
				pre[y][x][1], pre[y][x][2],
				x, y,
				(x * bw), (y * bh)
			)
		end
	end
end

function World:initChunks()
	local widthLim, heightLim = Env:getWorldChunks()
	local width, height = Env:getChunkDimensions()
	local xoff, yoff = Env:getWorldOffsets()
	local xp, yp = Env:getChunkPixelDimensions()
	local chunkId = 0
	
	for y = 1, heightLim do
		self.chunks[y] = {}
		for x = 1, widthLim do
			chunkId = chunkId + 1
			self.chunks[y][x] = Chunk.new(chunkId, x, y, width, height, xoff + (x - 1) * width, yoff + (y - 1) * height)
		end
	end
end

function World:init()
	self.pre = {}
	self.blocks = {}
	self.chunks = {}
	self.physicsMap = {}
	
	self:generateNewMapData()
	
	-- Get mode, call init function
	
	self:initPhysics()
	self:initBlocks()
	self:initChunks()
end