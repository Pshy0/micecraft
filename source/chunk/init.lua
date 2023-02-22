--- Creates a new Chunk object.
-- A chunk can hold information about blocks and items within a certain range, as well as
-- collision information and other stuff.
-- @name Chunk:new
-- @param Int:uniqueId The unique identifier of the Chunk
-- @param Int:x The horizontal position of the Chunk in the World matrix
-- @param Int:y The vertical position of the Chunk in the World matrix
-- @param Int:width The width of the Chunk, in blocks
-- @param Int:height The height of the Chunk, in blocks
-- @param Int:xFact The left position of the first block that corresponds to this chunk in the World matrix
-- @param Int:yFact The top position of the same block
-- @param Int:dx The horizontal position of the Chunk, in pixels
-- @param Int:dy The vertical position of the Chunk, in pixels
-- @param Int:biome An identifier of the biome that corresponds to this Chunk
-- @return `Chunk` A new Chunk object.
function Chunk:new(uniqueId, x, y, width, height, xFact, yFact, dx, dy, biome)
	local blockWidth, blockHeight = World:getBlockDimensions()
	local this = setmetatable({
		uniqueId = uniqueId,
		uniqueIdBlock = (uniqueId - 1) * (width * height),
		x = x, -- X in Chunk Matrix
		y = y, -- Y in Chunk Matrix
		
		width = width,
		height = height,
		blockWidth = blockWidth,
		blockHeight = blockHeight,
		
		dx = dx,
		dy = dy,
		
		xf = xFact, -- X Start
		yf = yFact, -- Y Start
		
		xb = xFact + (width - 1), -- X Boundary
		yb = yFact + (height - 1), -- Y Boundary
		
		collidesTo = {},
		collisionActive = false,
		collisionTimer = -1,
		
		displaysTo = {},
		displayActive = false,
		displayTimer=  -1,
		
		segments = {},
		items = {},
		debugImageId = -1
	}, self)

	this.__index = self
	
	local matrix = World.blocks
	
	local counter = 0
	for y = this.yf, this.yb do
		for x = this.xf, this.xb do
			counter = counter + 1
			matrix[y][x]:setRelativeCoordinates(
				(this.xf - x) + 1, (this.yf - y) + 1,
				counter,
				this.x, this.y,
				uniqueId
			)
		end
	end
	
	return this
end