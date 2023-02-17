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
end
do
	local copykeys = table.copykeys
	function Chunk:setDisplay(active, targetPlayer)
		if active == nil then
				self:setDisplay(false, nil)
				self:setDisplay(true, nil)
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
		end
	end
end