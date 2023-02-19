do
	local Segment = {}
	Segment.__index = Segment
	
	local setmetatable = setmetatable
	local ipairs,next = ipairs, next
	local abs = math.abs
	local min, max = math.min, math.max
	local keys, copykeys = table.keys, table.copykeys
	
	function Segment:new(description, block, chunk)

		local this = setmetatable({
			uniqueId = block.chunkUniqueId,
			presenceId = block.uniqueId,
			chunkId = block.chunkId,
			
			category = block.category,
			
			x = 0,
			xtl = block.dx,
			width = description.width,
			xs = description.xStart,
			xe = description.xEnd,
			
			y = 0,
			ytl = block.dy,
			height = description.height,
			ys = description.yStart,
			ye = description.yEnd,
			
			bw = block.width,
			bh = block.height,
			
			bodydef = {},
			active = false,
		}, self)
		this.__index = self
		
		this:setBlocksState(true)
		this:setBodydef()
		
		return this
	end
	
	local catinfo = {
		[enum.category.default] = {type=14, friction=0.30, restitution=0.20, collides=true}, -- Default
		[enum.category.grains] = {type=14, friction=0.15, restitution=0.00, collides=true}, -- Grains
		[enum.category.wood] = {type=14, friction=0.60, restitution=0.25, collides=true}, -- Wood stuff
		[enum.category.rocks_n_metals] = {type=14, friction=0.40, restitution=0.40, collides=true}, -- Rocks and Metals
		[enum.category.crystals] = {type=14, friction=0.10, restitution=0.20, collides=true}, -- Crystal
		[enum.category.other] = {type=14, friction=0.50, restitution=0.00, collides=true}, -- Others (leaves, wool)
		[enum.category.water] = {type=09, friction=0.00, restitution=0.00, collides=false}, -- Water
		[enum.category.lava] = {type=14, friction=2.00, restitution=5.00, collides=true}, -- Lava
		[enum.category.cobweb] = {type=15, friction=0.00, restitution=0.00, collides=false}, -- Cobweb
		[enum.category.acid]= {type=19, friction=20.0, restitution=0.00, collides=true}, -- Acid
	}
	catinfo.default = 1
	
	function Segment:setBlocksState(own)
		local id = own and self.id or 0
		local bm = World.blocks
		for y = self.ys, self.ye do
			for x = self.xs, self.xe do
				bm[y][x].segmentId = id
			end
		end
	end
	
	function Segment:setBodydef()
		local catdef = catinfo[self.category] or catinfo.default
		
		local w = self.width * self.bw
		local h = self.height * self.bh
		self.bodydef = {
			type = catdef.type,
			
			width = w,
			height = h,
			
			friction = catdef.friction,
			restitution = catdef.restitution,
			
			miceCollision = catdef.collides,
			groundCollision = catdef.collides,
			contactListener = catdef.collides,
			
			foreground = true,
			angle = 0,
			
			dynamic = false
		}
		
		self.x = self.xtl + (w / 2)
		self.y = self.ytl + (h / 2)
	end
	
	local addPhysicObject = tfm.exec.addPhysicObject
	local removePhysicObject = tfm.exec.removePhysicObject
	function Segment:setState(active)
		if active then
			addPhysicObject(self.presenceId, self.x, self.y, self.bodydef)
		else
			removePhysicObject(self.presenceId)
		end
		
		self.state = active
	end
	
	local addImage, removeImage = tfm.exec.addImage, tfm.exec.removeImage
	function Segment:setDebugDisplay(display)
		if self.imageId then
			self.imageId = removeImage(self.imageId, false)
		end
		
		if display then
			self.imageId = addImage(
				"TO DEFINE", 
				"!9999999", 
				self.x, self.y, 
				nil, 
				self.bodydef.width,
				self.bodydef.height,
				0, 0.67,
				0.5, 0.5,
				false
			)
		end
	end
	
	function Segment:reload()
		self:setState(false)
		self:setState(true)
	end
	
	function Segment:free()
		self:setState(false)
		self:setDebugDisplay(false)

		local pm = World.physicsMap
		local bm = World.blocks
		for y = self.ys, self.ye do
			for x = self.xs, self.xe do
				pm[y][x] = abs(pm[y][x])
				bm[y][x].segmentId = 0
			end
		end
		
		return self.xs, self.ys, self.xe, self.ye, self.category
	end
	
	function Chunk:setSegment(description)
		local segmentId = description.block.chunkUniqueId
		
		self.segments[segmentId] = Segment:new(description, description.block, self)
	end
	
	function Chunk:deleteSegment(segmentId)
		local segment = self.segments[segmentId]
		local a, b, c, d, cat
		if segment then
			a, b, c, d, cat = segment:free()
		end
		
		self.segments[segmentId] = nil
		
		return a, b, c, d, cat
	end
	
	function Chunk:getCollisions(mode, xStart, xEnd, yStart, yEnd, cats)
		mode = mode or "rectangle_detailed"
		local method = World.physicsMap[mode]
		
		local seglist = method(World.physicsMap, xStart or self.xf, xEnd or self.xb, yStart or self.yf, yEnd or self.yb, cats)
		
		for _, segment in ipairs(seglist) do
			self:setSegment(segment)
		end
	end
	
	function Chunk:setPhysicState(active, segmentList)
		if segmentList then
			local segment
			for segmentId, _ in next, segmentList do
				segment = self.segments[segmentId]
				if segment then
					segment:setState(active)
				end
			end
		else
			for _, segment in next, self.segments do
				segment:setState(active)
			end
		end
	end
	
	function Chunk:setCollisions(active, targetPlayer)
		if active == nil then
			self:setCollisions(false, nil)
			self:setCollisions(true, nil)
		else
			local goAhead = false
			if targetPlayer and active then
				goAhead = (not self.collidesTo[targetPlayer] == active)
				self.collidesTo[targetPlayer] = active
			else
				goAhead = true
				self.collidesTo = copykeys(Room.presencePlayerList, active)
			end
			
			if goAhead then
				self:setPhysicsState(active)
			end
		end
	end
	
	function Chunk:refreshPhysics(mode, segmentRange, update)
		segmentRange = segmentRange or keys(self.segments)
		local segment
		
		local xs, ys, xe, ye, catlist = self.xb, self.yb, self.xf, self.yf, {}
		
		local a, b, c, d, cat
		
		for _, segmentId in next, segmentRange do
			a, b, c, d, cat = self:deleteSegment(segmentId)
			if cat ~= 0 then
				catlist[cat] = true
			end
			
			xs = min(xs, a)
			ys = min(ys, b)
			xe = max(xe, c)
			ye = max(ye, d)
		end
		
		self:getCollisions(mode, xs, ys, xe, ye, keys(catlist))
		
		if update then
			self:setCollisions(true, nil)
		end
	end
	
	function Chunk:clear()
		local matrix = World.blocks
		for y = self.yf, self.yb do
			for x = self.xf, self.xb do
				matrix[y][x]:setVoid()
			end
		end
		
		for segmentId, segment in next, self.segments do
			segment:free()
		end
		
		self.segments = {}
	end
end