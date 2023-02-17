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
		
		xf = xFact, -- X Start
		yf = yFact, -- Y Start
		
		xb = xFact + width, -- X Boundary
		yb = yFact + height, -- Y Boundary
		
		collidesTo = {},
		displaysTo = {},
		segments = {},
		items = {}
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