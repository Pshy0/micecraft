function Block:create(type, foreground, display, update, updatePhysics)
	if type == 0 then
		self:setVoid()
	else
		local meta = blockMetadata:get(type)
		
		self.timestamp = os.time()
		
		if self.eventTimer then
			self.eventTimer = Timer.remove(self.eventTimer)
		end
		
		do
			self.type = type
			self.category = foreground and meta.category or 0
			
			self.drop = meta.drop
			
			self.foreground = foreground
			self.tangible = foreground
			
			self.damage = 0
			self.damagePhase = 0
			self.durability = meta.durabiliy
			self.hardness = meta.hardness
			
			self.glow = meta.glow
			self.translucent = meta.translucent
			
			self.sprite = meta.sprite
			self.shadow = meta.shadow
			self.lighting  = meta.lighting
			
			self.onCreate = meta.onCreate
			self.onPlacement = meta.onPlacement
			self.onDestroy = meta.onDestroy
			self.onInteract = meta.onInteract
			self.onHit = meta.onHit
			self.onDamage = meta.onDamage
			self.onContact = meta.onContact
			self.onUpdate = meta.onUpdate
		end
		
		World.physicsMap[self.y][self.x] = self.category
		
		self:removeAllDisplays()
		self:setDefaultDisplay()

		if display then
			self:refreshDisplay()
		end
		
		self:updateEvent(update, updatePhysics)
	end
end

function Block:destroy(display, update, updatePhysics)
	if self.type ~= 0 then
		self.timestamp = currentTime()
		
		self:onDestroy()
		
		self:removeAllDisplays()
		
		self.category = 0
		World.physicsMap[self.y][self.x] = 0
		if self.foreground then			
			self.foreground = false
			self.damage = 0
			
			self:setDefaultDisplay()
		else
			self:setVoid()
		end
		
		if display then
			self:refreshDisplay()
		end
		
		self:updateEvent(update, updatePhysics)
	end
end

do
	local restrict = math.restrict
	local ceil = math.ceil
	
	local damage_sprites = {
		"17dd4b6df60.png", -- 1
		"17dd4b72b5d.png", -- 2
		"17dd4b7775d.png", -- 3
		"17dd4b7c35f.png", -- 4
		"17dd4b80f5e.png", -- 5
		"17dd4b85b5f.png", -- 6
		"17dd4b8a75e.png", -- 7
		"17dd4b8f35f.png", -- 8
		"17dd4b93f5e.png", -- 9
		"17dd4b98b5d.png" -- 10
	}
	
	function Block:setDamageLevel(amount, add, display, update, updatePhysics)
		if self.type ~= 0 then
			local fx = (add and self.damage + amount or amount)
			
			self.damage = restrict(fx, 0, self.durability)
			
			self.damagePhase = ceil((self.damage * 10) / self.durability)
			
			local damageDisplay = self:getDisplay(2)
			
			if self.damage >= self.durability then
				self:destroy(display, update, updatePhysics)
				
				if fx > self.durability then
					self:setDamageLevel(fx - self.durability, true, display, update, updatePhysics)
				end
				
				return false
			else
				if self.damagePhase > 0 then
					local image = damage_sprites[self.damagePhase]
					
					self:addDisplay("damage", 2, image, nil, self.dx, self.dy, nil, nil, 0, 1.0)
					
					if display then
						self:refreshDisplayAt(2)
					end
				else
					self:removeDisplay(2, true)
				end
			end
			
			return true
		end
		
		return false
	end
end

function Block:damage(amount, add, display, update, updatePhysics, player)
	if self.type ~= 0 then
		self:onHit(player)
		
		local success = self:setDamageLevel(amount, add, display, update, updatePhysics)
	
		if success then
			self:onDamage(amount, player)
		end
	
		return success
	end
	
	return false
end

function Block:repair(amount, add, display, update, updatePhysics)
	if self.type ~= 0 then
		return self:setDamageLevel(-amount, add, display, update, updatePhysics)
	end
	
	return false
end

do
	local dist = math.udist
	function Block:interact(player)
		if self.interactable then
			local x, y = self:getPixelCenter()
			
			local xd = dist(player.x, x)
			local yd = dist(player.y, y)
			
			local xr = (self.interactable * width)
			local yr = (self.interactable * height)
			
			if xd <= xr and yd <= yr then
				self:onInteract(player)
			end
		end
	end
end