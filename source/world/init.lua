function World:generateNewMapData()
	local width, height = self:getBlocks()
	
	local pre = self.pre
	
	for y = 1, height do
		pre[y] = {}
		for x = 1, width do
			pre[y][x] = {type=0, tangible=false}
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
	local width, height = self:getBlocks()
	
	local pm = self.physicsMap
	local pre = self.pre
	
	for y = 1, height do
		pm[y] = {}
		for x = 1, width do
			pm[y][x] = 0
		end
	end
end

function World:initBlocks()
	local width, height = self:getBlocks()
	local blockId = 0
	
	local blocks = self.blocks
	local pre = self.pre
	local pm = self.physicsMap
	
	local bw, bh = self:getBlockDimensions()
	local ox, oy = self:getEdges()
	
	local temp
	
	for y = 1, height do
		blocks[y] = {}
		for x = 1, width do
			blockId = blockId + 1
			
			temp = pre[y][x]
			
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
			
			self.chunks[y][x]:getCollisions("rectangle_detailed")
		end
	end
end

function World:init()	
	local mode = Module:getMode()
	
	self:generateNewMapData()
	
	mode:setWorld(self)
	
	self:initPhysics()
	self:initBlocks()
	self:initChunks()
end