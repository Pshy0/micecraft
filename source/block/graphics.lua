do
	local addImage = tfm.exec.addImage
	
	function Block:display()
		if #self.displayList > 0 then
			local rlist = self.removalList
			
			for index, Sprite in next, self.displayList do
				rlist[index] = addImage(Sprite[1], Sprite[2], Sprite[3], Sprite[4], Sprite[5], Sprite[6], Sprite[7], Sprite[8], 0, 0, false)
			end
			
			return true
		end
		
		return false
	end
end

function Block:addDisplay(imageUrl, targetLayer, displayX, displayY, scaleX, scaleY, rotation, alpha)
	local index = #self.displayList + 1
	
	self.displayList[index] = {
		imageUrl or self.spriteImg,
		targetLayer or (self.foreground and "!5" or "_100"),
		displayX or self.dx,
		displayY or self.dy,
		scaleX or 1.0,
		scaleY or 1.0,
		rotation or 0,
		alpha or 1.0
	}
	
	return index
end

function Block:removeDisplay(displayId)
	return table.remove(self.displayList, displayId)
end

do
	local removeImage = tfm.exec.removeImage
	
	function Block:hide()
		local rlist = self.removalList
		
		if #rlist > 0 then
			for index, identifier in next, rlist do
				removeImage(identifier, false)
			end
			
			rlist = {}
			
			return true
		end
		
		return false
	end
end

function Block:refreshDisplay()
	local hidden = self:hide()
	local displayed = self:display()
	
	return (hidden and displayed)
end