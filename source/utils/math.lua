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
	
	math.tobase = function(n, b)
		n = floor(n)
		if not b or b==10 then return tostring(n) end
		local dg = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
		local t = {}
		local sign = n < 0 and "-" or ""
		if sign == "-" then n = -n end
		
		repeat
			local d = (n%b)+1
			n = math.floor(n/b)
			table.insert(t, 1, dg:sub(d, d))
		until n == 0

		return sign .. table.concat(t, "")
	end
end