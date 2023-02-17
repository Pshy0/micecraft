Module:newMode("default", function(this, g)
	function this:init()
		World:setVariables(32, 32, 16, 16, 4, 4, 0, 200)
	end
	
	function this:setWorld(world)
		local l = {}
		for i=1, 64 do
			l[i] = 32
		end
		
		world:preSetLayer({
			overwrite = true,
			exclusive=true,
			dir = {
				[1] = {type = 1, tangible = true}
			}
		}, l)
	end
	
	function this:run()
		
	end
	
	function this:getSettings()
		
	end
end)