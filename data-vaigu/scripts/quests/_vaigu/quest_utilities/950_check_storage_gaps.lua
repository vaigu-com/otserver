local highestStorage = 20000
local storageToCount = {}
local function findCounts(value, key)
	if type(value) == "number" then
		storageToCount[value] = (storageToCount[value] or 0) + 1
		if value > highestStorage then
			highestStorage = value
		end
	else
		for k, v in pairs(value) do
			findCounts(v, k)
		end
	end
end

local checkDuplicateStoragesStartup = GlobalEvent("CheckStorageGapsStartup")
function checkDuplicateStoragesStartup.onStartup()
	print("CheckDuplicateStoragesStartup")
	findCounts(Storage)
	table.sort(storageToCount, function(a, b)
		return a.count >= b.count
	end)

	print(highestStorage)
	if highestStorage > 65535 then
		highestStorage = 10000
	end
	print(TableSize(storageToCount))
	for i = 1, highestStorage do
		storageToCount[i] = storageToCount[i] or 0
	end

	local gaps = {}
	local nextGap = {}
	local lastCount = -1
	for storageId, count in pairs(storageToCount) do
		if count ~= 0 then
			nextGap.max = nextGap.recent
			nextGap.recent = nil
		end

		if count ~= lastCount and count ~= 0 then
			if nextGap.min and nextGap.max then
				table.insert(gaps, nextGap)
			end
			nextGap = {}
		end

		if count == 0 then
			nextGap.min = nextGap.min or storageId
		end
		nextGap.recent = storageId
	end

	print("min", "max", "size")
	for _, gap in pairs(gaps) do
		print(gap.min, gap.max, gap.max - gap.min + 1)
	end

	return true
end

checkDuplicateStoragesStartup:register()
