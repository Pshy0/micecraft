do
	local floor = math.floor
	local min, max = math.min, math.max
	local sqrt = math.sqrt
	local tostring = tostring
	
	math.round = function(n)
		return floor(n + 0.5)
	end
	
	math.restrict = function(n, l, r)
		return max(l, min(n, r))
	end
	
	math.pythag = function(ax, ay, bx, by)
		return sqrt((bx - ax)^2 + (by - ay)^2)
	end
	
	math.precision = function(number, precision)
		local elevator = 10^precision
		
		return floor(number * elevator) / elevator
	end
	
	local BASEDIGITS = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz&!"
	
	math.tobase = function(number, base)
		number = floor(number)
		
		if not base or base == 10 then
			return tostring(number)
		end
		
		local digits = BASEDIGITS
		local composition = {}
		
		local sign = (number < 0 and "-" or "")
		if sign == "-" then
			number = -number
		end
		
		repeat
			local digit = (number % base) + 1
			number = floor(number / base)
			table.insert(composition, 1, digits:sub(digit, digit))
		until number == 0

		return sign .. table.concat(composition, "")
	end
	
	local STRDIGITS = {}
	for i = 1, #BASEDIGITS do
		STRDIGITS[BASEDIGITS:sub(i, i)] = i - 1
	end
	
	math.tonumber = function(str, base)
		if base <= 36 then
			return tonumber(str, base)
		else
			local number = 0
			local len = #str
			local value
			for i = len, 1, -1 do
				value = STRDIGITS[str:sub(i, i)]
				if (not value) or (value >= base) then
					return nil
				else
					number = number + ((base ^ (len - i)) * value)
				end
			end
			
			return number
		end
	end
end

local tc = {}

--[[

Compression testing

math.randomseed(os.time())
for i=1, 5 do
	local x = 1020
	repeat
		local v = math.random(x)
		tc[#tc + 1] = ("%s|%s%s"):format(math.tobase(math.random(256), 64), math.tobase(v, 64), "+")
		
		x = x - v
	until x <= 0
	
	tc[#tc + 1] = "\n"
end
print(table.concat(tc, ""))
	--"pattern: ([%W|&!]-)([%+%-])"
]]
	