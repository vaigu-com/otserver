local promotionScrolls = {
	[43946] = { name = "abridged", points = 3, itemName = "abridged promotion scroll" },
	[43947] = { name = "basic", points = 5, itemName = "basic promotion scroll" },
	[43948] = { name = "revised", points = 9, itemName = "revised promotion scroll" },
	[43949] = { name = "extended", points = 13, itemName = "extended promotion scroll" },
	[43950] = { name = "advanced", points = 20, itemName = "advanced promotion scroll" },
}

local scroll = Action()

function scroll.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getLevel() < 51 then
		player:sendTextMessage(MESSAGE_LOOK, "Only a hero of level 51 or above can decipher this scroll.")
		return true
	end

	local scrollKV = player:kv():scoped("wheel-of-destiny")
	local currentPoints = scrollKV:get("scroll-points")
	if not currentPoints or currentPoints < 0 then
		currentPoints = 0
	end
  
  local scrollData = promotionScrolls[item:getId()]
	local addedPoints = scrollData.points

	scrollKV:set("scroll-points", currentPoints + addedPoints)
	player:sendTextMessage(MESSAGE_LOOK, T("You have gained :points: promotion points for the Wheel of Destiny by deciphering the :name:. You now have a total of :total: points.", { points = addedPoints, name = scrollData.itemName, total = currentPoints + addedPoints }))
	item:remove(1)
	return true
end

for id in pairs(promotionScrolls) do
	scroll:id(id)
end

scroll:register()
