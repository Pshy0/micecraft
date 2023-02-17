do
	local type = type
	local tostring = tostring
	local print = print
	local ipairs, pairs, next = ipairs, pairs, next
	local setmetatable = setmetatable
	local getmetatable = getmetatable

	local insert = table.insert
	local remove = table.remove
	local concat = table.concat
	local sort = table.sort
	
	local min = math.min
	local max = math.max
	local random = math.random

	--- Copies a table and all its values recursively.
	-- It avoids keeping references over values.
	-- @name table.copy
	-- @param t The table to copy
	-- @return `Table` The table copied.
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
	
	--- Inhertis all values to a table, from the specified one.
	-- It does not modify the original tables, but copies them, to avoid inconsistencies.
	-- All values to inherit will overwrite values on the target table.
	-- @name table.inherit
	-- @param Table:t The table for which values will be inherited.
	-- @param Table:ex The table to inherit values from.
	-- @return `Table` The new child table, product of the tables provided.
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
	
	--- Searches for a value across a table.
	-- Will return the first index of where it was found, otherwise returns nil.
	-- @name table.find
	-- @param Table:t The table to search the value into.
	-- @param Any:e The element to search into the table.
	-- @return `Any` The key or index where the element was found.
	-- @return `Any` The element specified.
	table.find = function(t, e)
		for k, v in next, t do
			if v == e then
				return k, v
			end
		end
	end
	
	--- Searches for a value, but in a depth of 1 index.
	-- Refer to table.find for more information.
	-- @name table.kfind
	-- @param Table:t The table to search the value into.
	-- @param Any:key The key to search from all elements.
	-- @param Any:e The element to search into the table.
	-- @return `Any` The key or index where the element was found.
	-- @return `Any` The element specified.
	table.kfind = function(t, key, e)
		for k, v in next, t do
			if v[key] == e then
				return k, v
			end
		end
	end
	
	--- Extracts a value from the given table.
	-- @name table.extract
	-- @param Table:t The table to extract the value from
	-- @param Any:e The value to extract from the table
	-- @return `Any` The index were the value was found 
	-- @return `Table` The table 
	table.extract = function(t, e)
		local i = table.find(t, e)
		
		if type(i) == "number" and #t > 0 then
			remove(t, i)
		else
			t[i] = nil
		end
		
		return i, t
	end
	
	--- Returns an array with all the keys/indexes from the given table.
	-- @name table.keys
	-- @param Table:t The table to get keys from
	-- @return `Table` The array with the keys.
	table.keys = function(t)
		local array = {}
		
		for k, v in next, t do
			array[#array + 1] = k
		end
		
		return array
	end
	
	--- Copies all the keys from the table and assigns them the value given.
	-- @name table.copykeys
	-- @param Table:t The table to copy keys from
	-- @param Any:v The value to assign to the keys
	-- @return `Table` The table with the keys.
	table.copykeys = function(t, v)
		local nt = {}
		
		for k in next, t do
			nt[k] = v
		end
		
		return nt
	end
	
	--- Gives the value of a random entry from the table.
	-- If the table is associative it converts the keys to an array and picks one of them randomly.
	-- @name table.random
	-- @param Table:t The table to get the random element from
	-- @param Boolean:associative Wheter the table is associative or numerical
	-- @return `Any` The random value
	-- @return `Any` The index were it was picked from
	table.random = function(t, associative)
		local index
		if associative or #t <= 0 then
			local array = table.keys(t)
			
			index = table.random(array, false)
		else
			index = random(#t)
		end
		
		return t[index], index
	end
	
	--- Converts a table to a string, in a reasonable format.
	-- @name table.tostring
	-- @param Table|Any:value The table to convert to string
	-- @param Int:tb The depth in the table
	-- @param Table:seen A list of tables that have been seen when iterating over the table (useful to avoid table recursion)
	-- @return `String` The value converted to string
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
						vv = table.tostring(v, p1, seen)
					end
					
					args[#args + 1] = ("%s%s"):format(("\t"):rep(p1), ("[%s] = %s"):format(kk, vv))
				end
			end
			
			sort(args, function(a, b)
				local ca, cb 
				
				for i = 1, min(#a, #b) do
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
			args = concat(args, ",\n")
			
			return ("{\n%s\n%s}"):format(args, ("\t"):rep(tb))
		elseif tv == "string" then
			return ('"%s"'):format(value)
		else
			return tostring(value)
		end
	end
	
	--- Prints a table.
	-- @name table.print
	-- @param Table:t The table to print
	table.print = function(t)
		print(table.tostring(t, 0))
	end	
end