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
end

enum.community = { -- Based on Forum codes. Affects on nothing.
	-- Community 0 is just player's community
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
	-- Community 20 is INT, but only Public
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