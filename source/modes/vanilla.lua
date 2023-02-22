Module:newMode("vanilla", function(this, g)
	function this:init(world)
		world:setVariables(64, 32, 12, 8, 80, 18, 0, 200)
		world:setPhysicsMode("rectangle_detailed")
	end
	
	function this:setWorld(field)
		local heightMap = math.heightMap(32, 24, 960, 80, nil, 144, true)
		
		
		field:setLayer({
			overwrite = true,
			exclusive=true,
			dir = {
				[1] = {type = 2, tangible = true},
				[2] = {type = 1, tangible = true},
				[6] = {type = 20, tangible = true},
			}
		}, heightMap)
	end
	
	function this:run()
		
	end
	
	function this:getSettings()
		
	end
end)