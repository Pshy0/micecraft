--- Sets the display state of a Chunk.
-- When active, all blocks corresponding to this Chunk will be
-- displayed, otherwise hidden. If active is **nil** then the Chunk
-- will hide and display to reload all displays.
-- @name Chunk:setDisplayState
-- @param Boolean:active Whether it should be active or not
function Chunk:setDisplayState(active)
	local matrix = World.blocks
	if active == nil then
		for y = self.yf, self.yb do
			for x = self.xf, self.xb do
				matrix[y][x]:refreshDisplay()
			end
		end
	else
		if active then
			for y = self.yf, self.yb do
				for x = self.xf, self.xb do
					matrix[y][x]:display()
				end
			end
		else
			for y = self.yf, self.yb do
				for x = self.xf, self.xb do
					matrix[y][x]:hide()
				end
			end
		end
	end
	
	self.displayActive = (active ~= false)
end
do
	
	--- Sets the Display state of a Chunk.
	-- This is just an interface function that manages the interactions between
	-- players and the Chunk, to ensure no innecessary calls for players that had
	-- the Chunk already displayed.
	-- @name Chunk:setDisplay
	-- @param Boolean|Nil:active Sets the Display state. If nil then a reload will be performed for all players
	-- @param String|Nil:targetPlayer The target that asks for the Display. If nil then player check wont be accounted
	-- @return `Boolean` Whether the specified action happened or not
	local copykeys = table.copykeys
	function Chunk:setDisplay(active, targetPlayer)
		if active == nil then
			self:setDisplay(false, nil)
			self:setDisplay(true, nil)
			
			return true
		else
			local goAhead = false
			if targetPlayer and active then
				goAhead = (not self.displaysTo[targetPlayer] == active)
				self.displaysTo[targetPlayer] = active
			else
				goAhead = true
				self.displaysTo = copykeys(Room.presencePlayerList, active)
			end
			
			if goAhead then
				if targetPlayer == nil then
					if active then
						self:setDisplayState(nil)
					else
						self:setDisplayState(false)
					end
				else
					self:setDisplayState(active)
				end
			end
			
			if active then
				self:setUnloadDelay(480, "graphics")
			end
			
			return goAhead
		end
	end
end