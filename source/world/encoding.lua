function World:decodeMatrix(raw)
	local height, width = self:getBlocks()
	
	local matrix = {{}}
	
	local x, y = 1, 0
	local type, repeats, tangible
	
	for line in raw:gmatch("%S+") do
		y = y + 1
		matrix[y] = {}
		for order, status in line:gmatch("([%w|&!]-)([%+%-])") do -- Match for "A|B+" (block [A] repeats for [B] times) or "A-" (just block [A])
			tangible = (status == "+")
			if order:find("|", 1, true) then
				type, repeats = order:match("^([%w&!]-)|([%w&!]-)$")
				
				type = math.tonumber(type, 64)
				repeats = math.tonumber(repeats, 64)
				
				for xi = x, x + repeats do
					x = xi
					
					matrix[y][xi] = {type = type, tangible = tangible}
				end
			else
				type = math.tonumber(order, 64)
				
				matrix[y][x] = {type = type, tangible = tangible}
			end
			
			x = x + 1
		end
	end
	
	return matrix
end

function World:encodeMatrix(matrix)
	local tc = {}
	
	local width, height = #matrix[1], #matrix
	
	local tile = false
	local x
	local eqcount = 0
	for y = 1, height do
		tc[y] = {}
		
		x = 1
		
		while x <= width do
			tile = matrix[y][x]
			eqcount = 1
			for xi = x + 1, width do
				if (matrix[y][xi].type == tile.type) and (matrix[y][xi].tangible == tile.tangible) then
					eqcount = eqcount + 1
					x = xi
				else
					break
				end
			end
			
			if eqcount > 1 then
				table.insert(tc[y], ("%s|%s%s"):format(math.tobase(tile.type, 64), math.tobase(eqcount, 64), tile.tangible and "+" or "-"))
			else
				table.insert(tc[y], ("%s%s"):format(math.tobase(tile.type, 64), tile.tangible and "+" or "-"))
			end
			
			x = x + 1
		end
		
		tc[y] = table.concat(tc[y], "")
	end
	
	tc = table.concat(tc, " ")
end