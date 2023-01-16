do
	local void = function() end
	blockMetadata = MetaData:newMetaData({
		name = "null", -- Block Name, used for translations
		
		drop = 0, -- When broken, identifier of what it drops
		
		glow = 0, -- Light emission (none = 0; max: 15)
		translucent = false, -- If it is translucent (has different alpha values) [blocks with non-quadratic/irregular shapes have this property too]
		
		shadow = "17e2d5113f3.png", -- Sprite for shawdow [black]
		lightning = "1817dc55c70.png", -- Sprite for lightning [white]
		sprite = "17e1315385d.png", -- Regular sprite
		
		durability = 24, -- How durable is this block against hits
		
		hardness = 1, -- How complex is the structure of the block. The more complex, higher order tools will be needed to break it
		
		placeable = true, -- If an entity should be able to place this block
		
		particles = {}, -- Particles that this block should emit when destroyed
		interactable = false, -- if it's possible to interact with this block (relevant for method onInteract), BOOLEAN (false) or NUMBER (TRUE), number denotes distance. Use block distance
		
		color = 0xFFFFFF, -- Misc
		restricted = false, -- If players shouldn't be able to hold this block
		fixedId = 0, -- Misc
		
		onCreate = void, -- Triggers when this block is created in the World
		onPlacement = void, -- Triggers when this block is placed by an entity
		onDestroy = void, -- Triggers when this block is destroyed
		-- Note: Generally, onCreate and onPlacement might act as the same, however,
		-- onCreate is always triggered first, and onPlacement is triggered after the
		-- actual creation. onPlacement will only be triggered by ENTITIES.
		
		onInteract = void, -- Triggers when an entity tries to interact with this block
		
		onHit = void, -- Triggers when a block has been hit
		onDamage = void, -- Triggers when a block has been damaged
		-- Note: While both methods could act as the same almost all times, onHit
		-- will always trigger when an entity cause it and before the actual damage
		-- happens, while onDamage will trigger after the damage is applied, however,
		--if the block is destroyed because of a Hit, then onDamage will not trigger.
		-- onHit only triggers with entities, onDamage does always.
		
		onContact = void, -- Triggers when a Player makes contact with the Block (only works on foreground layer)
		
		onUpdate = void -- Triggers when a Block nearby has suffered an update of its properties
	})
end

blockMetadata:newTemplate("Dirt", {
	name = "dirt",
	
	drop = 1,
	durability = 14,
	
	translucent = false,
	
	interactable = false,
	color = 0x866042,
	onUpdate = function(self, block)
		local goAhead
		
		if block.y < self.y then
			if block.type ~= 0 then
				if not (self.foreground and not block.foreground) then
					if not block.translucent then
						return false
					end
				end
			end
		end
		
		self.eventTimer = Timer.new(math.random(3000, 8000), false, function()
			self:create(2, self.foreground, true, true, false)
		end)
	
		return true
	end
})

blockMetadata:newTemplate("Grass", "Dirt", {
	name = "grass",
	drop = 1,
	durability = 18,
	color = 0x44AA44
	onUpdate = function(self, block)
		
		if block.y < self.y then
			if block.type ~= 0 then
				if not (self.foreground and not block.foreground) then
					if not block.translucent then
						self.eventTimer = Timer.new(math.random(3000, 8000), false, function()
							self:create(1, self.foreground, true, true, false) -- Create a dirt block
						end)
					
						return true
					end
				end
			end
		end
		
		return false
	end
})