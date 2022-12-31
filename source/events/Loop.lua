Module:on("Loop", function(elapsed, remaining)
	ticks = ticks + 1
	
	if (ticks % 40) == 0 then
		Module:setSync()
	end
end)