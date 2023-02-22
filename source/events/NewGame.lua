Module:on("NewGame", function()
	for playerName, player in next, Room.playerList do
		player:init()
		player:freeze(true, true, 0, 0)
		Tick:newTask(10, false, function()
			player:freeze(false)
		end)
	end
end)