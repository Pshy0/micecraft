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
	
	table.tostring = function(value, tb)
		local tv = type(value)
		if tv == "table" then
			tb = tb or 0			
			local args = {}
			local vv
			
			for k, v in next, value do
				if type(v) == "table" and tostring(k):match("^__") then
					vv = "{...}"
				else
					vv = table.tostring(v, tb + 1)
				end
				
				args[#args + 1] = ("%s%s"):format(("\t"):rep(tb + 1), ("[%s] = %s"):format(k, vv))
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
	
end