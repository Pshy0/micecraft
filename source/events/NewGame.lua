Module:on("NewGame", function()
	for playerName, player in next, Room.playerList do
		player:init()
	end
end)