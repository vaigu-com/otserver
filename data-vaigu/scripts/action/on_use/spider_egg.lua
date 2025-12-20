local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local roll, effect = math.random(1, 100), CONST_ME_TELEPORT
	if (roll >= 50) and (roll < 83) then
		Game.createMonster("Spider", fromPosition, false, false)
		item:transform(211)
		item:decay()
	elseif (roll >= 83) and (roll < 97) then
		Game.createMonster("Poison Spider", fromPosition, false, false)
		item:transform(211)
		item:decay()
	elseif roll == 100 then
		player:AddCustomItem({ id = 5879, count = 1 })
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
