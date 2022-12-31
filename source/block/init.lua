function Block.new(uniqueId, type, foreground, worldX, worldY, displayX, displayY)
	
	local this = blockMetadata[type]
	
	local self = setmetatable({ -- Define this way to save some table acceses.
		uniqueId = uniqueId,
		chunkId = 0,
		
		type = type,
		
		foreground = foreground,
		tangible = foreground,
		
		damage = 0,
		damageLevel = 0,
		durability = this.durability,
		
		
		x = worldX,
		y = worldY,
		
		cx = 0, -- Chunk X
		cy = 0, -- Chunk Y
		
		spriteImg = this.sprite,
		
		dx = displayX,
		dy = displayY,
		displayList = {},
		removalList = {},
		
		hide = Block.hide,
		display = Block.display,
		addDisplay = Block.addDisplay,
		removeDisplay = Block.removeDisplay
	}, Block)

	self:addDisplay(this.sprite)
	
	return self
end

function Block:setRelativeCoordinates(x, y)
	self.cx = x or 0
	self.cy = y or 0
end