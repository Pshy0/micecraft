do
	local default_cats = {1, 2, 3, 4, 6}
	local abs = math.abs
	local ipairs = ipairs
	local next = next
	local tk = function(t)
		local nt = {}
		for k, v in ipairs(t) do
			nt[v] = true
		end
		
		return nt
	end
	function World.physicsMap:getSegment(xs, ys, xe, ye, cat)
		return {
			xStart = xs,
			xEnd = xe,
			yStart = ys,
			yEnd = ye,
			height = (ye - ys) + 1,
			width = (xe - xs) + 1,
			category = cat or abs(self[ys][xs]),
			block = World:getBlock(xs, ys, "matrix")
		}
	end
	
	local q = function(t, v)
		t[#t + 1] = v
	end

	function World.physicsMap:individual(xStart, xEnd, yStart, yEnd)
		local list = {}
		for y = yStart, yEnd do
			for x = xStart, xEnd do
				if self[y][x] > 0 then
					q(list, self:getSegment(x, y, x, y, self[y][x]))
					self[y][x] = -self[y][x]
				end
			end
		end
		
		return list
	end
	
	local max = math.max
	local min = math.min
	function World.physicsMap:rectangle(xStart, xEnd, yStart, yEnd)
		local x, y = 0, 0
		local xs, xe, ys, ye
		local matches = 0
		local axisv = 0
		
		local list = {}
		local block 
		
		repeat
			matches = 0
			xe = xEnd
			ye = yEnd
			xs = xStart
			ys = nil
			
			axisv = ye
			x = xs
			while x <= xe do
				y = ys or yStart
				while y <= ye do
					if self[y][x] > 0 then -- Not processed
						if ys then
							if y == yEnd and x == xStart then
								ye = y
							end
						else
							ys = y
							xs = x
						end
						
						matches = matches + 1
						self[y][x] = -self[y][x]
					else -- Processed
						if ys then
							if x == xs then
								ye = y - 1
							else
								xe = x - 1
								
								for i = ys, y - 1 do
									self[i][x] = -self[i][x]
									matches = matches - 1
								end
								
								break
							end
						end
					end
					y = y + 1
				end
				x = x + 1
			end
			
			if matches > 0 then
				q(list, self:getSegment(xs, ys, xe, ye, 1))
			end
			
		until (matches == 0)
		
		return list
	end
	
		function World.physicsMap:rectangle_detailed(xStart, xEnd, yStart, yEnd, catlist)
		local x, y = 0, 0
		local xs, xe, ys, ye
		local matches = 0
		local axisv = 0
		
		catlist = catlist or default_cats
		local list = {}
		local block 
		
		for _, cat in catlist do -- There should be a better way to do this. At the moment I wrote it I couldn't think of one.
			repeat
				matches = 0
				xe = xEnd
				ye = yEnd
				xs = xStart
				ys = nil
				
				axisv = ye
				x = xs
				while x <= xe do
					y = ys or yStart
					while y <= ye do
						if self[y][x] == cat then -- Not processed
							if ys then
								if y == yEnd and x == xStart then
									ye = y
								end
							else
								ys = y
								xs = x
							end
							
							matches = matches + 1
							self[y][x] = -self[y][x]
						else -- Processed
							if ys then
								if x == xs then
									ye = y - 1
								else
									xe = x - 1
									
									for i = ys, y - 1 do
										self[i][x] = -self[i][x]
										matches = matches - 1
									end
									
									break
								end
							end
						end
						y = y + 1
					end
					x = x + 1
				end
				
				if matches > 0 then
					q(list, self:getSegment(xs, ys, xe, ye, cat))
				end
				
			until (matches == 0)
		end
		
		return list
	end
	
	function World.physicsMap:line(xStart, xEnd, yStart, yEnd)
		local list
		
		local match = false
		local ys, ye
		
		for x = xStart, xEnd do
			match = false
			ys = yStart
			ye = yEnd
			for y = yStart, yEnd do
				if self[y][x] > 0 then
					if match then
						ye = y
					else
						ys = y
						match = true
					end
					self[y][x] = -self[y][x]
				else
					if match then
						q(list, self:getSegment(x, ys, x, ye, 1))
						match = false
					end
				end
			end
		end
		
		return list
	end
	
	function World.physicsMap:line_detailed(xStart, xEnd, yStart, yEnd, catlist)
		local list
		catlist = catlist or default_cats
		local cl = tk(catlist)
		
		local match = false
		local ys, ye
		local picked
		
		for x = xStart, xEnd do
			match = false
			ys = yStart
			ye = yEnd
			for y = yStart, yEnd do
				if cl[self[y][x]] and (self[y][x] == match or not match) then
					if match then
						ye = y
					else
						ys = y
						
						match = self[y][x]
					end
					self[y][x] = -self[y][x]
				else
					if match then
						q(list, self:getSegment(x, ys, x, ye, match))
						match = false
					end
				end
			end
		end
		
		return list
	end
	
	function World.physicsMap:row(xStart, xEnd, yStart, yEnd)
		local list
		
		local match = false
		local xs, xe
		
		for y = yStart, yEnd do
			match = false
			xs = xStart
			xe = xEnd
			
			for x = xStart, xEnd do
				if self[y][x] > 0 then
					if match then
						xe = x
					else
						xs = x
						match = true
					end
					self[y][x] = -self[y][x]
				else
					if match then
						q(list, self:getSegment(xs, y, xe, y, 1))
						match = false
					end
				end
			end
		end
		
		return list
	end
	
		function World.physicsMap:row_detailed(xStart, xEnd, yStart, yEnd, catlist)
		local list
		catlist = catlist or default_cats
		local cl = tk(catlist)
		
		local match = false
		local xs, xe
		
		for y = yStart, yEnd do
			match = false
			xs = xStart
			xe = xEnd
			
			for x = xStart, xEnd do
				if self[y][x] > 0 then
					if match and (self[y][x] == match or not match) then
						xe = x
					else
						xs = x
						match = self[y][x]
					end
					self[y][x] = -self[y][x]
				else
					if match then
						q(list, self:getSegment(xs, y, xe, y, match))
						match = false
					end
				end
			end
		end
		
		return list
	end
end