local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getLevel() >= 30 then
		if player:getStorageValue(Storage.HydraNest) >= os.time() then
			return player:say("Dzis juz je sprawdzilem..", TALKTYPE_MONSTER_SAY)
		end
		local szansa = math.random(100)
		if szansa <= 29 then
			doTargetCombatHealth(0, player, COMBAT_POISONDAMAGE, -60, -150, CONST_ME_HITBYPOISON)
			player:say("Niech to!", TALKTYPE_MONSTER_SAY)
		elseif szansa >= 30 and szansa <= 49 then
			player:addItem(3029, 2) --small sapphire
		elseif szansa >= 50 and szansa <= 69 then
			player:addItem(3032, 2) --small emerald
		elseif szansa >= 70 and szansa <= 79 then
			player:addItem(4839, 1) --hydra egg
		elseif szansa >= 80 then
			player:addItem(7250, 1) --hydra tongue
		end
		player:setStorageValue(Storage.HydraNest, os.time() + 20 * 3600) --20h
		fromPosition:sendMagicEffect(CONST_ME_POFF)
		return true
	else
		player:sendCancelMessage("Musisz posiadac 30 poziom, by uzyc jaja.")
		return true
	end
end

action:uid(9030)
action:register()
