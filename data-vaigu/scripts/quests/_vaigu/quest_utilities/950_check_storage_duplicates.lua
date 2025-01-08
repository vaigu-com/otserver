local storageIdToCountName = {}
local function findDuplicates(value, key)
	if type(value) == "number" then
		local entry = storageIdToCountName[value] or {}
		entry.count = (entry.count or 0) + 1
		entry.keys = entry.keys or {}
		table.insert(entry.keys, key)
		storageIdToCountName[value] = entry
	else
		for k, v in pairs(value) do
			findDuplicates(v, k)
		end
	end
end

local checkDuplicateStoragesStartup = GlobalEvent("CheckDuplicateStoragesStartup")
function checkDuplicateStoragesStartup.onStartup()
	findDuplicates(Storage)
	table.sort(storageIdToCountName, function(a, b)
		return a.count >= b.count
	end)

	for storageId, entry in pairs(storageIdToCountName) do
		local count = entry.count
		if count > 1 then
			logger.warn(T("Duplicate storage found. Id: :storageId:, names:", { storageId = storageId }))
			for _, key in pairs(entry.keys) do
				logger.warn(T("\t:key:", { key = key }))
			end
		end
	end
	return true
end

checkDuplicateStoragesStartup:register()
