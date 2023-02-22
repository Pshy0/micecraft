--- Retrieves the Chunk object from which the Block belongs to
-- @name Block:getChunk
-- @return `Chunk` The chunk object
function Block:getChunk()
	return World:getChunk(self.chunkX, self.chunkY, "matrix")
end

do
--- Retrieves a list with the blocks adjacent to the Block.
-- @name Block:getBlocksAround
-- @param String:shape The shape to retrieve the blocks {cross: only adjacents, square: adjacents + edges}
-- @param Boolean:include Whether the Block itself should be included in the list.
-- @return `Table` An array with the adjacent blocks (in no particular order)
	local ti = function(t, v)
		t[#t + 1] = v
	end
	function Block:getBlocksAround(shape, include)
		local world = World
		local blocks = {}
		if include then ti(blocks, self) end
		
		if shape == "cross" then
			ti(blocks, world:getBlock(self.x - 1, self.y, "matrix"))
			ti(blocks, world:getBlock(self.x, self.y - 1, "matrix"))
			ti(blocks, world:getBlock(self.x + 1, self.y, "matrix"))
			ti(blocks, world:getBlock(self.x, self.y + 1, "matrix"))
		elseif shape == "corner" then
			ti(blocks, world:getBlock(self.x-1, self.y-1, "matrix"))
			ti(blocks, world:getBlock(self.x+1, self.y-1, "matrix"))
			ti(blocks, world:getBlock(self.x-1, self.y+1, "matrix"))
			ti(blocks, world:getBlock(self.x+1, self.y+1, "matrix"))
		elseif shape == "square" then
			for y = -1, 1 do
				for x = -1, 1 do
					if not (x == 0 and y == 0) then
						ti(blocks, world:getBlock(self.x + x, self.y + y, "matrix"))
					end
				end
			end
		end
		
		return blocks
	end
end


--- Interface for handling when a block state gets updated.
-- @name Block:updateEvent
-- @param Boolean:update Whether the blocks around should be updated (method: `Block:onUpdate`)
-- @param Boolean:updatePhysics Whether the physics of the World should be updated
function Block:updateEvent(update, updatePhysics)
	do
		local blocks = self:getBlocksAround("cross", false)
		local segmentList = {
			[self.segmentId] = true
		}
		if update ~= false then
			for position, block in next, blocks do
				if block.chunkId == self.chunkId then
					segmentList[block.segmentId] = true
				end
				block:onUpdate(self)
			end
		end
		
		if updatePhysics ~= false then
			local xBlocks = self:getBlocksAround("corner", false)
			for position, block in next, xBlocks do
				if block.chunkId == self.chunkId then
					segmentList[block.segmentId] = true
				end
			end
			
			self:getChunk():refreshPhysics(World.physicsMode, segmentList, true, {
					xStart=self.x, 
					xEnd = self.x, 
					yStart=self.y, 
					yEnd=self.y, 
					category=self.category
				}
			)
		end
	end
end

do
	
	--- Spreads particles from the Block.
	-- @name Block:spreadParticles
	-- @return `Boolean` Whether the particles were successfully spreaded or not
	local displayParticle = tfm.exec.displayParticle
	local random = math.random
	function Block:spreadParticles()
		local par = self.particles
		local pcount = #par
		
		if pcount > 0 then
			local amount = random(6, 11)
			local tw = (2*self.width) / 3
			local th = (2*self.height) / 3
		
			local xc, yc = self.dxc, self.dyc
			
			local xt, xf, xv, yv
			
			for i = 1, amount do
				xt = random(tw)
				xf = random(2) == 1 and -1 or 1
				xv = (random(40,60) / 10) * xf * REFERENCE_SCALE_X
				yv = -0.2 * REFERENCE_SCALE_Y
				displayParticle(
					par[random(pcount)],
					xc + (xt * xf),
					yc + random(-th, th),
					xv, yv,
					-xv/10, -yv/10
				)
			end
			
			return true
		end
		
		return false
	end
	
	-- To do: Particles should spread differently according to a specified 'mode'
end

do
	--- Plays the specified sound for the Block.
	-- A block can have different types of sounds according to the event that happens to them.
	-- @name Block:playSound
	-- @param String:soundKey The key that identifies the event. If it doesn't exist, it will default to a regular sound.
	-- @param Player:player The player that should hear this sound, if nil, applies to everyone.
	-- @return `Boolean` Whether the sound was successfully played or not
	local playSound = tfm.exec.playSound
	function Block:playSound(soundKey, player)
		-- pc - bc
		if self.sound then
			local sound = self.sound[soundKey] or self.sound.default
			playSound(
				sound, 100,
				player and (player.x - self.dxc) * REFERECE_SCALE_X or self.dxc,
				player and (player.y - self.dyc) * REFERECE_SCALE_Y or self.dyc,
				player and player.name or nil
			)
			
			return true
		end
		
		return false
	end
end