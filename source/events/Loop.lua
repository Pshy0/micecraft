do
	local next = next
	local room = tfm.get.room
	Module:on("Loop", function(elapsedTime, remainingTime)
		Module:setCycle()
			
		if elapsedTime >= 500 then
			local tfmPlayerList = room.playerList
			for playerName, player in next, Room.playerList do
				player:updateInformation()
				player:setClock(500, true, true)
			end
		end
	end)
end

Module:on("Loop", function(elapsedTime, remainingTime)
	Tick:handle()
end)

Module:on("Loop", function(elapsedTime, remainingTime)
	Timer:handle()
end)

