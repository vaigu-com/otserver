local spheres = {
	[942] = { 3, 7 },
	[946] = { 1, 5 },
	[947] = { 2, 6 },
	[948] = { 4, 8 },
}

local globalTable = {
	[1] = 10009,
	[2] = 10010,
	[3] = 10011,
	[4] = 10012,
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not isInArray({ 844, 845, 844, 845 }, target.itemid) then
		return false
	end

	if not isInRange(toPosition, { x = 6198, y = 980, z = 11 }, { x = 6260, y = 1042, z = 11 }) then --{x = 6198, y = 980, z = 11}{x = 6260, y = 1042, z = 11}
		return false
	end

	if not isInArray(spheres[item.itemid], player:getVocation():getId()) then
		return false
	end

	if isInArray({ 844, 845 }, target.itemid) then
		player:say("Najpierw wlacz maszyne.", TALKTYPE_MONSTER_SAY)
		return true
	end

	toPosition:sendMagicEffect(CONST_ME_PURPLEENERGY)
	Game.setStorageValue(globalTable[player:getVocation():getBase():getId()], 1)
	item:remove(1)
	return true
end
action:id(942, 946, 947, 948)
action:register()
