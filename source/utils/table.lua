do
	local type = type
	
	table.extract = function(t, e)
		for k, v in next, t do
			if v == e then
				return table.extract(t, k)
			end
		end
	end
	
	table.copy = function(t)
		if type(t) == "table" then
			local ut = {}
			for k, v in next, t do
				ut[k] = table.copy(v)
			end
			
			setmetatable(ut, getmetatable(t))
			
			return ut
		else
			return t
		end
	end
	
	table.inherit = function(t, ex)
		local it
		if type(t) == "table" then
			it = table.copy(t)
		else
			it = {}
		end
		
		for k, v in next, ex do
			if type(v) == "table" then
				it[k] = table.inherit(it[k], v)
			else
				it[k] = v
			end
		end
		
		return it
	end
	
	table.find = function(t, e)
		for k, v in next, t do
			if v == e then
				return k, v
			end
		end
	end

	table.kfind = function(t, key, e)
		for k, v in next, t do
			if v[key] == e then
				return k, v
			end
		end
	end
	
	table.random = function(t)
		return t[math.random(#t)]
	end
	
	table.keys = function(t)
		local array = {}
		
		for k, v in next, t do
			array[#array + 1] = k
		end
		
		return array
	end
	
	table.tostring = function(value, tb, seen)
		tb = tb or 0
		if tb > 8 then return end
		
		local tv = type(value)
		if tv == "table" then
			seen = seen or {}
						
			local args = {}
			local kk, vv
			local p1 = tb + 1
			for k, v in next, value do
				kk = table.tostring(k, p1)
				if not seen[v] then
					if type(v) == "table" then
						seen[v] = true
						vv = table.tostring(v, p1, seen)
					else
						vv = table.tostring(v, tb + 1, seen)
					end
					
					args[#args + 1] = ("%s%s"):format(("\t"):rep(p1), ("[%s] = %s"):format(kk, vv))
				end
			end
			
			table.sort(args, function(a, b)
				local ca, cb 
				
				for i = 1, math.min(#a, #b) do
					ca = a:byte(i)
					cb = b:byte(i)
					
					if ca > cb then
						return false
					elseif ca < cb then
						return true
					end
				end
				
				return false
			end)
			args = table.concat(args, ",\n")
			
			return ("{\n%s\n%s}"):format(args, ("\t"):rep(tb))
		elseif tv == "string" then
			return ('"%s"'):format(value)
		else
			return tostring(value)
		end
	end
	
	table.print = function(t)
		print(table.tostring(t, 0))
	end	
end