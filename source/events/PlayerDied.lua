Module:on("PlayerDied", function(playerName)
	local player = Room.playerList[playerName]
	
	if player then
		tfm.exec.respawnPlayer(playerName)
	end
end)