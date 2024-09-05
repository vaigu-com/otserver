local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_NONE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_NONE)

local area = createCombatArea(AREA_CIRCLE3X3)
setCombatArea(combat, area)

local maxsummons = 2

local spell = Spell("instant")

function spell.onCastSpell(cid, var)
	local summoncount = getCreatureSummons(cid)
	if #summoncount < 2 then
		for i = 1, maxsummons - #summoncount do
			local mid = doSummonCreature("Ice Golem", getCreaturePosition(cid))
			if mid == false then
				return false
			end
			doConvinceCreature(cid, mid)
		end
	end
	return doCombat(cid, combat, var)
end

spell:name("hirintror summon")
spell:words(NextSpellId())
spell:isAggressive(false)
spell:blockWalls(true)
spell:needTarget(false)
spell:needLearn(true)
spell:register()
