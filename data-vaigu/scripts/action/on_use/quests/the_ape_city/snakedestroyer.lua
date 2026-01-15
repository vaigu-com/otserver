local allowedLizardHeadIds = {
	[2080] = true,
	[2081] = true,
	[2082] = true,
	[2083] = true,

	[2084] = true,
	[2085] = true,
	[2086] = true,
	[2087] = true,
}

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not allowedLizardHeadIds[target:getId()] then
		return false
	end

	if player:getStorageValueByKey(Storage.TheApeCity.QuestProgress) > 17 then
		return false
	end

	player:setStorageValueByKey(Storage.TheApeCity.SnakeDestroyer, 1)
	item:remove()
	toPosition:sendMagicEffect(CONST_ME_FIREAREA)
	return true
end
action:id(4835)
action:register()
