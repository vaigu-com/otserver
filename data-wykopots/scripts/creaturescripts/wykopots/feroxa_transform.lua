local feroxaTransform = CreatureEvent("FeroxaTransform")
function feroxaTransform.onThink(creature)
	if creature:getName():lower() ~= "feroxa" then
		return true
	end
	if creature:getMaxHealth() == 80000 then
		if creature:getHealth() <= 40000 then
			creature:getPosition():sendMagicEffect(CONST_ME_POFF)
			Game.createMonster("Feroxa2", creature:getPosition(), true, true)
			creature:remove()
		end
	end
	if creature:getMaxHealth() == 40000 then
		if creature:getHealth() <= 20000 then
			creature:getPosition():sendMagicEffect(CONST_ME_POFF)
			local feroxas = {
				[1] = { name = "Feroxa3" },
				[2] = { name = "Feroxa4" },
			}
			Game.createMonster(feroxas[math.random(#feroxas)].name, creature:getPosition(), true, true)
			creature:remove()
		end
	end
end

feroxaTransform:register()

local feroxaDeath = CreatureEvent("feroxaDeath")
function feroxaDeath.onDeath(creature, corpse, deathList)
	local pool = Tile(creature:getPosition()):getItemById(2886)
	if pool then
		pool:remove()
	end
	Game.createMonster("Feroxa5", creature:getPosition(), true, true)
end

feroxaDeath:register()
