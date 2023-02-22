do
	local atan2 = math.atan2
	local sin = math.sin
	local cos = math.cos
	Module:on("ContactListener", function(playerName, groundId, ci)
		local player = Room.playerList[playerName]
		
		if player then
			local angle = atan2(
				ci.contactY - ci.playerY,
				ci.contactX - ci.playerX
			)
			
			local block = World:getBlock(
				ci.contactX + (cos(angle) * 5),
				ci.contactY + (sin(angle) * 5),
				"map"
			)
			
			if block then
				block:onContact(player)
				tfm.exec.removeImage(tfm.exec.addImage(
					"1817dc55c70.png",
					"!9999",
					block.dx, block.dy,
					nil,
					REFERENCE_SCALE_X, REFERENCE_SCALE_Y,
					0, 1.0, 
					0, 0,
					false
				), true)
			end
		end
	end)
end