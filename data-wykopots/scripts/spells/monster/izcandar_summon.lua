local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_NONE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_NONE)

local area = createCombatArea(AREA_CIRCLE2X2)
combat:setArea(area)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	if izcandarSummon < 7 then
		local chance = math.random(1, 2)
		if chance == 1 then
			Game.createMonster("the cold of winter", { x = creature:getPosition().x + math.random(-1, 1), y = creature:getPosition().y + math.random(-1, 1), z = creature:getPosition().z }, false, true)
			izcandarSummon = izcandarSummon + 1
		elseif chance == 2 then
			Game.createMonster("the heat of summer", { x = creature:getPosition().x + math.random(-1, 1), y = creature:getPosition().y + math.random(-1, 1), z = creature:getPosition().z }, false, true)
			izcandarSummon = izcandarSummon + 1
		end
	end

	return combat:execute(creature, var)
end

spell:name("izcandar summon")
spell:words(NextSpellId())
spell:isAggressive(false)
spell:blockWalls(true)
spell:needTarget(false)
spell:needLearn(true)
spell:register()
