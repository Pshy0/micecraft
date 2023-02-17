function Block:new(uniqueId, type, foreground, worldX, worldY, displayX, displayY, width, height)
	
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
	
	self:setDefaultDisplay()
	
	return this, meta.category
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
		
		World.physicsMap[self.y][self.x] = 0
	end
end

function Block:setRelativeCoordinates(x, y, id, CX, CY, CID)
	self.cx = x or 0
	self.cy = y or 0
	self.chunkUniqueId = id
	
	self.chunkX = CX
	self.chunkY = CY
	self.chunkId = CID
	
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