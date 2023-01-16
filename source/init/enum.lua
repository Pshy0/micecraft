enum.community = { -- Based on Forum codes. Affects on nothing.
	-- Community 0 is just current player community
	["xx"] = 1,
	["int"] = 1, -- International  (all of them)
	["fr"] = 2, -- French
	["ru"] = 3, -- Russian
	["br"] = 4, -- Brazilian
	["es"] = 5, -- Spanish
	["cn"] = 6, -- Chinese
	["tr"] = 7, -- Turkish
	["sk"] = 8, -- Scandinavian (need to check code)
	["pl"] = 9, -- Polish
	["hu"] = 10, -- Hungary
	["nl"] = 11, -- Netherlands
	["ro"] = 12, -- Romania
	["id"] = 13, -- Indonesia
	["de"] = 14, -- Deutschland (Germany)
	["en"] = 15, -- English
	["ar"] = 16, -- Arabian
	["ph"] = 17, -- Phillipines / Tagalog (need to check code)
	["lt"] = 18, -- Lituanian
	["jp"] = 19,
	-- Community 20 is INT, but only Public INT
	["fi"] = 21, -- Finnish
	["cz"] = 22, -- Czech
	["sl"] = 23, -- Probably Slovakia (need to check code)
	["ct"] = 24, -- Probably Croatia (need to check code)
	["bg"] = 25, -- Bulgaria (unluckily, couldn't find code)
	["lv"] = 26, -- Letonian
	["he"] = 27, -- Hebrew
	["it"] = 28, -- Italian
	["et"] = 29, -- Estonian
	["az"] = 30, -- Azerbaiyan
	["pt"] = 31 -- Portuguese (had BR flag, but `technically` they're different communities)
}

enum.category = {
	sand = 1,
	dirt = 2,
	weak = 3,
	wood = 4,
	rock = 5,
	wool = 6,
	crystal = 7,
	water = 8,
	lava = 9
}

enum.physics = {
	rectangle = 1, -- Searches for the biggest rectangle
	line = 2, -- Searches vertically, for the largest set of blocks within the same line
	row = 3, -- Same as line, but horizontally
	rectangle_detailed = 4, -- Takes into account block's categories
	line_detailed = 5, -- ^
	row_detailed = 6, -- ^
	individual = 10 -- Each block has its individual collision (not recommended)
}

do
	local associate = function(t)
		local it = {}
		
		for k, v in next, t do
			it[k] = v
			it[v] = k
		end
		
		t = it
		
		return t
	end
	
	enum.community = associate(enum.community)
	enum.category = associate(enum.category)
	enum.physics = associate(enum.physics)
end