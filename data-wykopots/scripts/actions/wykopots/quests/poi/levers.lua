local stonePositions = {
	Position(6153, 1898, 12),
	Position(6154, 1898, 12),
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid ~= 2772 then
		return false
	end

	local leverCount = getGlobalStorageValue(GlobalStorage.PoiLeverCount)
	if item.uid > 2049 and item.uid < 2065 then
		local number = item.uid - 2049
		if leverCount < 0 then
			setGlobalStorageValue(GlobalStorage.PoiLeverCount, 1)
		else
			setGlobalStorageValue(GlobalStorage.PoiLeverCount, leverCount + 1)
		end
		player:say(getGlobalStorageValue(GlobalStorage.PoiLeverCount) .. "/15", TALKTYPE_MONSTER_SAY)
		player:addExperience(10000, true)
	elseif item.uid == 2065 then
		if leverCount ~= 15 then
			player:say("Nie mozesz ruszyc... jeszcze nie.", TALKTYPE_MONSTER_SAY)
			return true
		end

		local stone
		for i = 1, #stonePositions do
			stone = Tile(stonePositions[i]):getItemById(1791)
			if stone then
				stone:remove()
				stonePositions[i]:sendMagicEffect(CONST_ME_EXPLOSIONAREA)
			end
		end
	end
	item:remove()
	return true
end

for uniqueRange = 2050, 2065 do
	action:uid(uniqueRange)
end
action:register()
