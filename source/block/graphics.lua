do
	local type = type
	function Block:getDisplay(index)
		local numeric, str
		if type(index) == "string" then
			numeric = self.associativeList[index]
			str = index
		else
			numeric = index
			str = self.associativeList[index]
		end
		
		return self.displayList[numeric], numeric, str
	end
end

do
	local addImage = tfm.exec.addImage
	
	function Block:display()
		if self.displayList then
			local rlist = self.removalList
			local rindex
			for index, sprite in next, self.displayList do
				if sprite.active then
					rindex = #rlist + 1
					
					rlist[rindex] = addImage(
						sprite[1], sprite[2],
						sprite[3], sprite[4],
						nil,
						sprite[5], sprite[6],
						sprite[7], sprite[8],
						0, 0,
						false
					)
					
					sprite.removeIndex = rindex
				end
			end
			
			return true
		end
		
		return false
	end
end

do	
	local addImage = tfm.exec.addImage
	local tinsert = table.insert
	function Block:addDisplay(name, order, imageUrl, targetLayer, displayX, displayY, scaleX, scaleY, rotation, alpha, show)
		self.associativeList[order] = name
		self.associativeList[name] = order
		
		self.displayList[order] = {
			imageUrl or self.sprite,
			targetLayer or (self.foreground and "!5" or "_100"),
			displayX or self.dx,
			displayY or self.dy,
			scaleX or REFERENCE_SCALE_X,
			scaleY or REFERENCE_SCALE_Y,
			rotation or 0,
			alpha or 1.0
		}
		
		if show then
			local sprite = self.displayList[order]
			
			tinsert(self.removalList, addImage(
				sprite[1], sprite[2],
				sprite[3], sprite[4],
				nil,
				sprite[5], sprite[6],
				sprite[7], sprite[8],
				0, 0,
				false
			))
			
			sprite.removeIndex = #self.removalList
		end
		
		return order, name
	end
end

do
	local type
	local removeImage = tfm.exec.removeImage
	function Block:removeDisplay(index, hide)
		local sprite, num, str = self:getDisplay(index)
		
		if hide then
			removeImage(self.removalList[sprite.removeIndex], false)
		end
		
		self.displayList[num] = nil
		self.associativeList[num] = nil
		self.associativeList[str] = nil
	end
	
	function Block:removeAllDisplays()
		self.displayList = {}
		self:initDisplay()
	end
end

do
	local removeImage = tfm.exec.removeImage
	
	function Block:hide()
		local rlist = self.removalList
		
		if #rlist > 0 then
			for i = 1, #rlist do
				rlist[i] = removeImage(rlist[i], false)
			end
			
			return true
		end
		
		return false
	end
end

do
	
	local addImage = tfm.exec.addImage
	local removeImage = tfm.exec.removeImage
	
	function Block:refreshDisplay(index)
		if index then
			local sprite = self:getDisplay(index)
			if sprite then
				removeImage(
					self.removalList[sprite.removeIndex],
					false
				)
				
				self.removalList[sprite.removeIndex] = addImage(
					sprite[1], sprite[2],
					sprite[3], sprite[4],
					nil,
					sprite[5], sprite[6],
					sprite[7], sprite[8],
					0, 0,
					false
				)
			end
		else
			local hidden = self:hide()
			local displayed = self:display()
			
			return (hidden and displayed)
		end
	end
end

function Block:setDefaultDisplay()
	if self.type ~= 0 then
		self:addDisplay("main", 1, self.sprite, nil, self.dx, self.d, REFERENCE_SCALE_X, REFERENCE_SCALE_Y, 0, 1.0)
		
		if not self.foreground then
			self:addDisplay("shadow", 3, self.shadow, nil, self.dx, self.dy, REFERENCE_SCALE_X, REFERENCE_SCALE_Y, 0, 0.33)
		end
	end
end