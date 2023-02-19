Module:newMode("default", function(this, g)
	function this:init(world)
		world:setVariables(32, 32, 16, 16, 2, 4, 0, 200)
		world:setPhysicsMode("rectangle_detailed")
	end
	
	function this:setWorld(field)
		local l = {32}
		for i=2, 64 do
			l[i] = l[i-1] + (math.random(-1, 1))
		end
		
		field:setLayer({
			overwrite = true,
			exclusive=true,
			dir = {
				[1] = {type = 2, tangible = true},
				[2] = {type = 1, tangible = true},
				[6] = {type = 20, tangible = true},
			}
		}, l)
	end
	
	function this:run()
		
	end
	
	function this:getSettings()
		
	end
end)