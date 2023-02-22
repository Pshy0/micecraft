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
	ui.addTextArea(
		0,
		("<font color='#FFFFFF'><p align='right'>%d"):format(Tick.current),
		nil,
		595, 25,
		200, 0,
		0x0, 0x0,
		1.0, true
	)
end)

Module:on("Loop", function(elapsedTime, remainingTime)
	Timer:handle()
end)

