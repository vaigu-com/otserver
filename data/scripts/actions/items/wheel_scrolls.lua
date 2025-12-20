local scrollPointsKey = Scope("wheel-of-destiny", "scroll-points")

local promotionScrolls = {
	[43946] = { name = "abridged", points = 3, itemName = "abridged promotion scroll" },
	[43947] = { name = "basic", points = 5, itemName = "basic promotion scroll" },
	[43948] = { name = "revised", points = 10, itemName = "revised promotion scroll" },
	[43949] = { name = "extended", points = 18, itemName = "extended promotion scroll" },
	[43950] = { name = "advanced", points = 30, itemName = "advanced promotion scroll" },
}
for scrollId, scroll in pairs(promotionScrolls) do
	scroll.key = scrollPointsKey:Get(scrollId)
end

local function sumPoints(player)
	local sum = 0
	for _, scroll in pairs(promotionScrolls) do
		local key = scroll.key
		local pointsPerScroll = scroll.points
		local unlockedScrolls = math.max(player:getStorageValueByKey(key), 0)
		local pointsPerScrollId = pointsPerScroll * unlockedScrolls
		sum = sum + pointsPerScrollId
	end
	return sum
end
local scroll = Action()
function scroll.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getLevel() < 51 then
		player:sendTextMessage(MESSAGE_LOOK, "Only a hero of level 51 or above can decipher this scroll.")
		return true
	end

	local scrollData = promotionScrolls[item:getId()]
	local scrollStorage = scrollData.key

	local currentScrollCount = math.max(player:getStorageValueByKey(scrollStorage), 0)
	local nextScrollCount = currentScrollCount + 1
	player:setStorageValueByKey(scrollStorage, nextScrollCount)

	local addedPoints = scrollData.points
	player:sendTextMessage(MESSAGE_LOOK, T("You have deciphered a total of :decipheredCount: :scrollName:s. You have gained :points: promotion points and now have a total of :sum: points.", { points = addedPoints, decipheredCount = nextScrollCount, scrollName = scrollData.itemName, sum = sumPoints(player) }))
	item:remove(1)
	return true
end
for id in pairs(promotionScrolls) do
	scroll:id(id)
end
scroll:register()
