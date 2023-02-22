
local debugChunk = false
Module:on("Keyboard", function(playerName, key, down, x, y, vx, vy)
	local player = Room.playerList[playerName]
	
	if player then
		player.keys[key] = down
		if key < 4 then -- Movility keys
			local isFacingRight
			if key % 2 == 0 then
				isFacingRight = (key == 2)
			end
			
			player:updateInformation(x, y, vx, vy, isFacingRight)
		end
		
		if key == 32 and down then
			player.showDebugInfo = not player.showDebugInfo
			player:setDebugInformation(player.showDebugInfo)
		end
	end
end)