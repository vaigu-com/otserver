local creatureevent = CreatureEvent("WelterEgg")

function creatureevent.onThink(creature, interval)
	addEvent(function(cid)
		local creature = Creature(cid)
		if not creature then
			return
		end
		local pos = creature:getPosition()
		pos:sendMagicEffect(CONST_ME_POISONAREA)
		creature:remove()
		local summon = Game.createMonster("Spawn Of The Welter", pos, false, true)
		if not summon then
			return
		end
		return true
	end, 10000, creature:getId())
end

creatureevent:register()
