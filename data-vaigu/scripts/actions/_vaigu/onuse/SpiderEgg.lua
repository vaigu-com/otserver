local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local rand, effect = math.random(1, 100), CONST_ME_TELEPORT
	if (rand >= 50) and (rand < 83) then
		Game.createMonster("Spider", fromPosition, false, false)
		item:transform(211)
		item:decay()
	elseif (rand >= 83) and (rand < 97) then
		Game.createMonster("Poison Spider", fromPosition, false, false)
		item:transform(211)
		item:decay()
	elseif (rand >= 97) and (rand < 99) then
		Game.createMonster("Tarantula", fromPosition, false, false)
		item:transform(211)
		item:decay()
	elseif (rand >= 99) and (rand < 100) then
		Game.createMonster("Giant Spider", fromPosition, false, false)
		item:transform(211)
		item:decay()
	elseif rand == 100 then
		cid:addItem(5879, 1)
		item:transform(211)
		item:decay()
	else
		effect = CONST_ME_POFF
	end

	doSendMagicEffect(fromPosition, effect)
	return true
end

action:id(181)
action:register()
