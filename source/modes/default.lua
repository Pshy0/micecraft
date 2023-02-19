Module:newMode("default", function(this, g)
	function this:init()
		World:setVariables(32, 32, 16, 16, 2, 4, 0, 200)
	end
	
	function this:setWorld(world)
		local l = {}
		for i=1, 64 do
			l[i] = 33
		end
		
		world.pre:setLayer({
			overwrite = true,
			exclusive=true,
			dir = {
				[1] = {type = 1, tangible = true},
				[2] = {type = 2, tangible = true},
				[3] = {type = 3, tangible = true},
				[4] = {type = 4, tangible = true},
				[5] = {type = 5, tangible = true},
				[6] = {type = 20, tangible = true},
			}
		}, l)
	end
	
	function this:run()
		
	end
	
	function this:getSettings()
		
	end
end)