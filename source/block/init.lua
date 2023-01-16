function Block:new(uniqueId, type, foreground, worldX, worldY, displayX, displayY)
	
	local meta = blockMetadata:get(type)
	
	local this = setmetatable({ -- Define this way to save some table acceses.
		uniqueId = uniqueId,
		chunkId = 0,
		
		type = type,
		category = meta.category,
		
		timestamp = 0,
		eventTimer = -1,
		
		foreground = foreground,
		tangible = foreground,
		
		glow = meta.glow,
		translucent = meta.translucent,
		
		drop = meta.drop,
		
		damage = 0,
		damageLevel = 0,
		durability = meta.durability,
		hardness = meta.hardness,
		
		act = foreground and -meta.category or 0,
		
		x = worldX,
		y = worldY,
		
		cx = 0, -- Chunk X
		cy = 0, -- Chunk Y
		
		sprite = meta.sprite,
		shadow = meta.shadow,
		lighting = meta.lighting,
		
		dx = displayX,
		dy = displayY,
		displayList = {},
		removalList = {},
		associativeList = {},
		
		hide = self.hide,
		display = self.display,
		addDisplay = self.addDisplay,
		removeDisplay = self.removeDisplay,
		removeAllDisplays = self.removeAllDisplays,
		refreshDisplay = self.refreshDisplay,
		setDefaultDisplay = self.setDefaultDisplay
		
		onCreate = meta.onCreate,
		onPlacement = meta.onPlacement,
		onDestroy = meta.onDestroy,
		onInteract = meta.onInteract,
		onHit = meta.onHit,
		onDamage = meta.onDamage,
		onContact = meta.onContact,
		onUpdate = meta.onUpdate
	}, self)

	this.__index = self
	
	self:setDefaultDisplay()
	
	return this
end

do
	local void = function() end
	
	function Block:setVoid()
		local meta = blockMetadata:get(0)
		
		self.type = 0
		self.foreground = false
		self.tangible = false
		self.category = 0
		
		self:hide()
		self:removeAllDisplays()
		
		self.drop = 0
		
		self.damage = 0
		self.durability = 0
		self.hardness = 0
		
		self.timestamp = 0
		Timer.remove(self.eventTimer)
		self.eventTimer = nil
		
		self.onCreate = void
		self.onPlacement = void
		self.onDestroy = void
		self.onInteract = void
		self.onHit = void
		self.onDamage = void
		self.onContact = void
		self.onUpdate = void
	end
end

function Block:setRelativeCoordinates(x, y, id, CX, CY, CID)
	self.cx = x or 0
	self.cy = y or 0
	self.uniqueId = id
	
	self.chunkX = CX
	self.chunkY = CY
	self.chunkUniqueId = CID
end

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

function Block:getPixelCenter()
	local width, height = World:getBlockDimensions()
	
	return self.dx + (width / 2), self.dy + (height / 2)
end

-- REFERENCE FOR METHODS (also failsafe in case it is NIL for some reason)

function Block:onCreate() -- Declare as `onCreate = function(self)`.
	print("I have been created ^-^")
end

function Block:onPlacement(player) -- Declare as `onPlacement = function(self, player)`.
	print("I have been placed by " .. player.name .. " *-*")
end

function Block:onDestroy() -- Declare as `onDestroy = function(self)`.
	print("I have been destroyed x_x")
end

function Block:onInteract(player) -- Declare as `onInteract = function(self, player)`.
	print(player.name .. " wants to interact with me >///<")
end

function Block:onHit(player) -- Declare as `onHit = function(self, player)`.
	print("I have gotten hit by " .. player.name .. " :'c")
end

function Block:onDamage(amount, player) -- Declare as `onDamage = function(self, amount, player)`.
	print("I have been damaged :C")
end

function Block:onContact(player) -- Declare as `onContact = function(self, player)`.
	print("I have been contacted by " .. player.name .. " o.o")
end

function Block:onUpdate(block) -- Declare as `onUpdate = function(self, block)`.
	print("I have been updated by another block 0_0")
end