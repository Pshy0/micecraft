function Chunk.new(uniqueId, x, y, width, height, xFact, yFact, dx, dy, biome)
	local self = setmetatable({}, Chunk)
	
	self.uniqueId = uniqueId
	
	self.xm = x -- X in Chunk Matrix
	self.ym = y -- Y in Chunk Matrix
	
	self.width = width
	self.height = height
	
	self.xf = xFact -- X Start
	self.yf = yFact -- Y Start
	
	self.xb = xFact + width -- X Boundary
	self.yb = yFact + height -- Y Boundary
	
	local matrix = World.blocks
	
	for y = self.yf, self.yb do
		for x = self.xf, self.xb do
			matrix[y][x]:setRelativeCoordinates((self.xf - x) + 1, (self.yf - y) + 1)
		end
	end
	
	return self
end