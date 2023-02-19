Module:on("Mouse", function(playerName, x, y)
	local block = World:getBlock(x, y, "map")
	
	if block and block.type ~= 0 then
		block:destroy(true, true, true)
		--block:create(20, true, true, true, true)
	end
end)