do
	-- Localize functions to reduce direct workload on functions
	local floor = math.floor
	local abs = math.abs
	local min, max = math.min, math.max
	local sqrt = math.sqrt
	local cos = math.cos
	local pi = math.pi
	local random = math.random
	
	local tostring = tostring
	local BASEDIGITS = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz&!" -- Used for base conversion
	
	local insert = table.insert
	local concat = table.concat
	
	--- Rounds a number to the nearest integer.
	-- For numbers will decimal digit under 0.5, it will floor that number, 
	-- and for numbers over 0.5 it will ceil that number.
	-- @param n The number to round
	-- @return `Number` The number rounded.
	math.round = function(number)
		return floor(number + 0.5)
	end
	
	--- Restrict the given input between two limits.
	-- @param number The number to restrict
	-- @param lower The lower limit
	-- @param higher The higher limit
	-- @return `Number` The number between the specified range.
	math.restrict = function(number, lower, higher)
		return max(lower, min(number, higher))
	end
	
	--- Returns the distance between two points on a cartesian plane.
	-- @param ax The horizontal coordinate of the first point
	-- @param ay The vertical coordinate of the first point
	-- @param bx The horizontal coordinate of the second point
	-- @param by The vertical coordinate of the second point
	-- @return `Number` The distance between both points.
	math.pythag = function(ax, ay, bx, by)
		return sqrt((bx - ax)^2 + (by - ay)^2)
	end
	
	--- Returns the absolute difference between two numbers.
	-- @param a The first number
	-- @param b The second number
	-- @return `Number` The absolute difference.
	math.udist = function(a, b)
		return abs(a - b)
	end
	
	--- Rounds a number to the specified level of precision.
	-- The precision is the amount of decimal points after the integer part.
	-- @param number The number to correct precision
	-- @param precision The decimal digits of precision that this number will have
	-- @return `Number` The number with the corrected precision.
	math.precision = function(number, precision)
		local elevator = 10^precision
		
		return floor(number * elevator) / elevator
	end
	
	--- Converts a number to a string representation in another base.
	-- The base can be as lower as 2 or as higher as 64, otherwise it returns nil.
	-- @param number The number to convert
	-- @param base The base to convert this number to
	-- @return `String` The number converted to the specified base.
	math.tobase = function(number, base)
		base = base or 10
		if base < 2 or base > 64 then return end
		number = floor(number)
		
		if base == 10 then
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
			insert(composition, 1, digits:sub(digit, digit))
		until number == 0

		return sign .. concat(composition, "")
	end
	
	local STRDIGITS = {}
	for i = 1, #BASEDIGITS do
		STRDIGITS[BASEDIGITS:sub(i, i)] = i - 1
	end
	
	--- Converts a string to a number, if possible.
	-- The base can be as lower as 2 or as higher as 64, otherwise it returns nil.
	-- When bases are equal or lower than 36, it uses the native Lua `tonumber` method.
	-- @param str The string to convert
	-- @param base The base to convert this string to number
	-- @return `String` The string converted to number from the specified base.
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
	
	--- Interpolates two points with a cosine curve.
	-- @param a First Point
	-- @param b Second point
	-- @param s Curve size
	-- @return `Number` Resultant point with value interpolated through cosine function.
	math.cosint = function(a, b, s)
		local f = (1 - cos(s * pi)) * 0.5
		
		return (a * (1 - f)) + (b * f)
	end
	
	--- Generates a Height Map based on the current `randomseed`.
	-- @param amplitude How tall can a wave be
	-- @param waveLenght How wide will a wave be
	-- @param width How large should the height map be
	-- @return `Table` An array that contains each point of the height map.
	local cosint = math.cosint
	math.heightMap = function(amplitude, waveLenght, width)
		local heightMap = {}
		local a, b = random(), random()
		
		local x, y = 0, 0
		
		while x < width do
			if x % waveLenght == 0 then
				a = b
				b = random()
				y = a * amplitude
			else
				y = cosint(a, b, (x % waveLenght) / waveLenght) * amplitude
			end
			
			heightMap[x + 1] = y
			
			x = x + 1
		end
		
		return heightMap
	end
end