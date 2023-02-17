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
		category = 1, -- The physics category the block belongs to. Different restitution and friction will be applied according to the category
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
		-- Note 2: onCreate will not trigger when a block tile is created.
		
		onInteract = void, -- Triggers when an entity tries to interact with this block
		
		onHit = void, -- Triggers when a block has been hit
		onDamage = void, -- Triggers when a block has been damaged
		-- Note: While both methods could act as the same almost all times, onHit
		-- will always trigger when an entity cause it and before the actual damage
		-- happens, while onDamage will trigger after the damage is applied, however,
		-- if the block is destroyed because of a Hit, then onDamage will not trigger.
		-- onHit only triggers with entities, onDamage does always.
		
		onContact = void, -- Triggers when a Player makes contact with the Block (only works on foreground layer)
		
		onUpdate = void -- Triggers when a Block nearby has suffered an update of its properties
	})
end

blockMetadata:newTemplate("Dirt", {
	name = "dirt",
	
	drop = 1,
	durability = 14,
	hardness = 0,
	
	sprite = "17dd4af277b.png",
	
	translucent = false,
	
	interactable = false,
	color = 0x866042,
	onUpdate = function(self, block)
		if block.y < self.y then
			if block.type ~= 0 then
				if not (self.foreground and not block.foreground) then
					if not block.translucent then
						return false
					end
				end
			end
		end
		
		local grassifyTime = math.random(3000, 8000)
		self.eventTimer = Timer.new(grassifyTime, false, function()
			self:create(2, self.foreground, true, true, false) -- Create a grass block
		end)
	
		return true
	end
})

blockMetadata:newTemplate("Grass", "Dirt", {
	name = "grass",
	
	sprite = "17dd4b0a359.png",
	
	drop = 1,
	durability = 18,
	
	color = 0x44AA44,
	
	onUpdate = function(self, block)
		if block.y < self.y then
			if block.type ~= 0 then
				if not (self.foreground and not block.foreground) then
					if not block.translucent then
						local dirtifyTime = math.random(3000, 8000)
						self.eventTimer = Timer.new(dirtifyTime, false, function()
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

blockMetadata:newTemplate("Stone", {
	name = "stone",
	
	drop = 0, -- To define
	
	glow = 0,
	translucent = false,
	sprite = "17dd4b6935c.png",
	
	durability = 34,
	hardness = 1,
	
	placeable = true,
	interactable = false,
	color = 0xA0A0A0,
	particles = {4}
})

blockMetadata:newTemplate("Ore", "Stone", {
	name = "default_ore",
	sprite = "17dd4b39b5c.png",
	durability = 42,
	particles = {3, 4},
	glow = 0,
	onHit = function(self, entity)
		-- Emit particles
	end
})

blockMetadata:set(1, "Dirt") -- dirt
blockMetadata:set(2, "Grass") -- grass
blockMetadata:set(3, "Grass", {name="snowed_grass", sprite="17dd4aedb5d.png"}) -- snowed grass
blockMetadata:set(4, "Dirt", {name="dirtcelium", sprite="17dd4ae8f5b.png"}) -- dirtcelium
blockMetadata:set(5, "Grass", {name="mycelium", sprite="17dd4b1875c.png"}) -- mycelium

blockMetadata:set(20, "Stone") -- regular stone

blockMetadata:set(30, "Ore", {name="coal_ore", sprite="17dd4b26b5d.png"})
blockMetadata:set(31, "Ore", {name="iron_ore", sprite="17dd4b39b5c.png", durability=48, hardness=2, particles={3,2,1}})
blockMetadata:set(32, "Ore", {name="gold_ore", sprite="17dd4b34f5a.png", durability=48, hardness=2, particles={2,3,11,24}})