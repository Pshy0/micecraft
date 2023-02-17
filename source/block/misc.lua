function Block:getChunk()
	return World:getChunk(self.chunkX, self.chunkY, "matrix")
end

function Block:getBlocksAround(gtype, include)
	local blocks = {}
	if gtype == "cross" then
		for y = -1, 1 do
			if (y ~= 0) or include then
				blocks[#blocks + 1] = World:getBlock(self.x, self.y + y, "matrix")
			end
		end
		
		blocks[#blocks + 1] = World:getBlock(self.x - 1, self.y, "matrix")
		blocks[#blocks + 1] = World:getBlock(self.x + 1, self.y, "matrix")
	elseif gtype == "square" then
		for y = -1, 1 do
			for x = -1, 1 do
				if not (x == 0 and y == 0) or include then
					blocks[#blocks + 1] = World:getBlock(self.x + x, self.y + y, "matrix")
				end
			end
		end
	end
	
	return blocks
end

function Block:updateEvent(update, updatePhysics)
	do
		local blocks = self:getBlocksAround("cross", false)
			
		if update ~= false then
			for block in next, blocks do
				block:onUpdate(self)
			end
		end
		
		if updatePhysics ~= false then
			self:getChunk():refreshSegmentList(blocks)
		end
	end
end

do
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
		end
	end
end

do
	local playSound = tfm.exec.playSound
	function Block:playSound(soundKey, player)
		-- pc - bc
		if self.sound then
			local sound = self.sound[soundKey] or self.sound.default
			playSound(
				sound, 100,
				(player.x - self.dxc) * REFERECE_SCALE_X,
				(player.y - self.dyc) * REFERECE_SCALE_Y,
				player.name
			)
		end
	end
end