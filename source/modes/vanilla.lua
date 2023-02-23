Module:newMode("vanilla", function(this, g)
	function this:init(world)
		world:setVariables(10, 10, 12, 8, 80, 18, 0, 200)
		world:setPhysicsMode("rectangle_detailed")
	end
	
	function this:setWorld(field)
		local width, height = World:getBlocks()
		
		
		local baseMap = math.heightMap(12, 24, width, 80, nil, height, true)
		local barrierLeft = math.heightMap(24, 12, 24, 10, 1, height, true)
		local barrierRight = math.heightMap(24, 12, 24, 10, 1, height, true)
		
		local heightMap
		
		heightMap = math.combineMaps(
			baseMap, barrierLeft,
			"overwrite",
			1, 24,
			0
		)
		heightMap = math.combineMaps(
			heightMap, barrierRight, 
			"overwrite", 
			width - 24, width,
			width - 24
		)
		
		field:setLayer({ -- Dirt layer
			overwrite = true,
			dir = {
				[1] = {type = 2, tangible = true},
				[2] = {type = 1, tangible = true},
				[10] = {type = -1, tangible = false},
			}
		}, heightMap)
		
		
		local stoneOctaves = math.heightMap(6, 6, 960, 3, nil, nil, true)
		local stoneLayerMap = math.combineMaps(heightMap, stoneOctaves, "add")
		field:setLayer({ -- Stone layer
			overwrite = true,
			dir = {
				[1] = {type=20, tangible=true}
			}
		}, stoneLayerMap)
		
	end
	
	function this:run()
		
	end
	
	function this:getSettings()
		
	end
end)