local feroxaDeath = CreatureEvent("feroxaDeath")
function feroxaDeath.onDeath(creature, corpse, deathList)
	local pool = Tile(creature:getPosition()):getItemById(2886)
	if pool then
		pool:remove()
	end
	Game.createMonster("Feroxa5", creature:getPosition(), true, true)
end
feroxaDeath:register()
