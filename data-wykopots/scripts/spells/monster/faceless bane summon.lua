local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_NONE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_NONE)

local area = createCombatArea(AREA_CIRCLE2X2)
combat:setArea(area)

local maxsummons = 3

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local summoncount = creature:getSummons()
	if #summoncount <= 0 then
		local mid = doSummonCreature("Burster Spectre", creature:getPosition())
		local mid2 = doSummonCreature("Ripper Spectre", creature:getPosition())
		local mid3 = doSummonCreature("Gazer Spectre", creature:getPosition())
		if not mid then
			return
		end
		if not mid2 then
			return
		end
		if not mid3 then
			return
		end
		doConvinceCreature(creature, mid)
		doConvinceCreature(creature, mid2)
		doConvinceCreature(creature, mid3)
	elseif #summoncount >= 1 and #summoncount <= 3 then
		for i = 1, maxsummons - #summoncount do
			local chance = math.random(3)
			if chance == 1 then
				local mid = doSummonCreature("Burster Spectre", creature:getPosition())
				if not mid then
					return
				end
				doConvinceCreature(creature, mid)
			elseif chance == 2 then
				local mid = doSummonCreature("Ripper Spectre", creature:getPosition())
				if not mid then
					return
				end
				doConvinceCreature(creature, mid)
			else
				local mid = doSummonCreature("Gazer Spectre", creature:getPosition())
				if not mid then
					return
				end
				doConvinceCreature(creature, mid)
			end
		end
	end
	return combat:execute(creature, var)
end

spell:name("faceless bane summon")
spell:words(NextSpellId())
spell:isAggressive(false)
spell:blockWalls(true)
spell:needTarget(false)
spell:needLearn(true)
spell:register()
