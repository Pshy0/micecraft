do
	local movePlayer = tfm.exec.movePlayer
	
	function Player:move(xPosition, yPosition, positionOffset, xSpeed, ySpeed, speedOffset)
		xPosition = xPosition or 0
		yPosition = yPosition or 0
		positionOffset = positionOffset or false
		xSpeed = xSpeed or 0
		ySpeed = ySpeed or 0
		speedOffset = speedOffset or false
		
		movePlayer(
			self.name, 
			xPosition, yPosition, 
			positionOffset, 
			xSpeed, ySpeed, 
			speedOffset
		)
		
		self:updatePosition(
			positionOffset and self.x + xPosition or xPosition,
			positionOffset and self.y + yPosition or yPosition,
			speedOffset and self.vx + xSpeed or xSpeed,
			speedOffset and self.vy + ySpeed or ySpeed
		)
	end
	
	local setPlayerGravityScale = tfm.exec.setPlayerGravityScale
	local freezePlayer = tfm.exec.freezePlayer
	
	function Player:freeze(active, show, gravity, wind)
		if active then
			setPlayerGravityScale(self.name, gravity, wind)
			self:move(0, 0, true, 0, 0, not (gravity or wind))
		else
			setPlayerGravityScale(self.name, 1.0, 1.0)
		end
		
		freezePlayer(self.name, active, show)
		
		self.isFrozen = (not not active)
	end
	
	local next = next

	function Player:queueNearChunks(origin, include)
		origin = origin or World:getChunk(self.bx, self.by, "block")
		local chunkList = origin:getChunksAround("special", true)
		
		for _, chunk in next, chunkList do
			chunk:setCollisions(true, self.name)
			chunk:setDisplay(true, self.name)
		end
	end
end

do
	local left = table.concat({
		"Player %s (%s)", -- playerName + playerType [SOURIS, NORMAL, STAFF]
		"XY: %d / %d", -- X and Y,
		"B: %d / %d", -- Block X and Block Y,
		"C: %d &lt; %d", -- Current and previous Chunk
		"A: [%s] (x axis)", -- Facing direction
		"Bm: [%d] %s", -- Biome ID and name
		"W: ?"
	}, "\n")

	local right = table.concat({
		"Micecraft %s (%s/%s)", -- 2(version) + gameMode
		"T: %d / %d (%d)", -- currentTick + halted + timeSinceLastTick
		"C: %d / %d / %d", -- Chunks with: collision active, graphics active, items active
		"Q: %d", -- Chunks in queue
		"E: %d", -- Number of total entities,
		"P: %d / %d / %d", -- Players currently playing, total players, unique players
		"",
		"GF: %f / %f", -- Gravity Forces (gravity/wind)
		"M: %d / %d (t%d)", -- chunks in X, Y, AND in total
		"m: %d / %d (t%d)", -- same but for blocks
		"",
 		"API: v%s / m%s", -- Module API version (currrent & module)
		"TFM: v%s / m%s", -- Transformice version	""		""
		"R: %d / %d / 60 ms", -- Current Runtime in usage, runtime for triping, max runtime		
	}, "\n")
	function Player:setDebugInformation(show)
		local f = ("<font face='Consolas,Lucida Console,Monospace' color='#FFFFFF'><p align='%s'>%s")
		if show then
			ui.addTextArea(2448,
				f:format("left", left:format(
					self.name, (self.name:match("^*") and "SOURIS" or "NORMAL"),
					self.x, self.y,
					self.bx, self.by,
					self.currentChunk, self.lastChunk,
					self.isFacingRight and "&gt;" or "&lt;",
					0, "null"
				)),
				self.name,
				2, 80,
				200, 350,
				0x0, 0x0,
				1.0, true
			)
			ui.addTextArea(2449,
				f:format("right", right:format(
					Module.version:match("^[^-]+"), Module.version, Module.subMode,
					Tick.current, Tick.halted, Tick.lastTick, 
					World.counter.chunks_collide, World.counter.chunks_display, World.counter.chunks_item or 0,
					#ChunkQueue.stack,
					0,
					table.count(Room.playerList), table.count(Room.presencePlayerList), tonumber(tfm.get.room.uniquePlayers) or 0,
					World.gravityForce, World.windForce,
					World.chunkRows, World.chunkLines, World.totalChunks,
					World.totalBlockWidth, World.totalBlockHeight, World.totalBlocks,
					tfm.get.misc.apiVersion, Module.apiVersion,
					tfm.get.misc.transformiceVersion, Module.tfmVersion,
					Module.currentRuntime, Module.runtimeLimit
				)),
				self.name,
				597, 25,
				200, 350,
				0x0, 0x0,
				1.0, true
			)
		else
			ui.removeTextArea(2448, self.name)
			ui.removeTextArea(2449, self.name)
		end
	end
end