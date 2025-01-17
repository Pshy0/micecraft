--- Creates a new Block object.
-- @name Block:new
-- @param Int:uniqueId The unique ID of the Block in the World
-- @param Int:type The Block type. Data will be consulted on **blockMetadata** to apply for this object
-- @param Boolean:foreground Whether the Block should be in the foreground layer or not
-- @param Int:worldX Horizontal position of the Block in the World matrix
-- @param Int:worldY Vertical position of the Block in the World matrix
-- @param Int:displayX Horizontal position of the Block in Transformice's map
-- @param Int:displayY Vertical position of the Block in Transformice's map
-- @param Int:width Width of the block in pixels
-- @param Int:height Height of the block in pixels
-- @return `Block` The Block object
function Block:new(uniqueId, type, foreground, worldX, worldY, displayX, displayY, width, height)
	
	local meta = blockMetadata:get(type)
	
	local this = setmetatable({ -- Define this way to save some table acceses.
		uniqueId = uniqueId,
		chunkId = 0,
		segmentId = -1,
		
		type = type,
		category = foreground and meta.category or 0,
		
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
		
		dx = displayX,
		dy = displayY,
		dxc = 0,
		dyc = 0,
		
		width = width,
		height = height,
		
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
		setDefaultDisplay = self.setDefaultDisplay,
		
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
	
	this:setDefaultDisplay()
	
	return this, this.category
end

do
	local void = function() end
	
	--- Sets the Block to a **void** state.
	-- @name Block:setVoid
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
		Tick:removeTask(self.eventTimer)
		self.eventTimer = -1
		
		self.onCreate = void
		self.onPlacement = void
		self.onDestroy = void
		self.onInteract = void
		self.onHit = void
		self.onDamage = void
		self.onContact = void
		self.onUpdate = void
		
		World.physicsMap[self.y][self.x] = 0
	end
end

--- Sets the Block relative coordinates to its chunk.
-- @name Block:setRelativeCoordinates
-- @param Int:xInChunk The horizontal position of the Block in its Chunk
-- @param Int:yInChunk The vertical position of the Block in its Chunk
-- @param Int:idInChunk The unique identifier of the Block in its Chunk 
-- @param Int:chunkX The horizontal position of the Chunk in the World
-- @param Int:chunkY The vertical position of the Chunk in the World
-- @param Int:chunkId The unique identifier of the Chunk in the World
function Block:setRelativeCoordinates(xInChunk, yInChunk, idInChunk, chunkX, chunkY, chunkId)
	self.cx = xInChunk or 0
	self.cy = yInChunk or 0
	self.chunkUniqueId = idInChunk
	
	self.chunkX = chunkX
	self.chunkY = chunkY
	self.chunkId = chunkId
	
	self.dxc = self.dx + (self.width / 2)
	self.dyc = self.dy + (self.height / 2)
end

-- REFERENCE FOR METHODS (also failsafe in case it is NIL for some reason)

function Block:onCreate() -- Declare as `onCreate = function(self)`.
	print("Block has been created.")
end

function Block:onPlacement(player) -- Declare as `onPlacement = function(self, player)`.
	print("Block has been placed by " .. player.name .. ".")
end

function Block:onDestroy() -- Declare as `onDestroy = function(self)`.
	print("Block has been destroyed.")
end

function Block:onInteract(player) -- Declare as `onInteract = function(self, player)`.
	print(player.name .. " interacted with a block.")
end

function Block:onHit(player) -- Declare as `onHit = function(self, player)`.
	print("Block has been hit by " .. player.name .. ".")
end

function Block:onDamage(amount, player) -- Declare as `onDamage = function(self, amount, player)`.
	print("Block has been damaged.")
end

function Block:onContact(player) -- Declare as `onContact = function(self, player)`.
	print("Block has been contacted by " .. player.name .. ".")
end

function Block:onUpdate(block) -- Declare as `onUpdate = function(self, block)`.
	print("Block has been updated by another block.")
end