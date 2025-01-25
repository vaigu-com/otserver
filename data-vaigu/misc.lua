function randomPairs(tbl)
	local keys = {}
	for key in pairs(tbl) do
		table.insert(keys, key)
	end

	for i = #keys, 2, -1 do
		local j = math.random(i)
		keys[i], keys[j] = keys[j], keys[i]
	end

	local i = 0
	return function()
		i = i + 1
		if i <= #keys then
			return keys[i], tbl[keys[i]]
		end
	end
end
