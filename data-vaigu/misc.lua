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

-- Days since start
DAYS_SINCE_START = 0
local resultId = db.storeQuery("SELECT DATEDIFF( CURDATE(), DATE(`value`) ) - IF(TIME(NOW()) < '05:00:00', 1, 0) AS days_since_start FROM `server_config` WHERE `server_config`.`config` = 'start_date'")
if resultId then
	DAYS_SINCE_START = Result.getNumber(resultId, "days_since_start")
	logger.info("Day since start: " .. DAYS_SINCE_START)
end	
