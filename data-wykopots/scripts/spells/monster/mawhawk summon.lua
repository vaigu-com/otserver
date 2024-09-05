local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_NONE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_BLOCKHIT)

local area = createCombatArea(AREA_CIRCLE1X1)
setCombatArea(combat, area)

local maxsummons = 4

local spell = Spell("instant")

function spell.onCastSpell(cid, var)
	doCreatureSay(cid, "Watch my maws!", TALKTYPE_ORANGE_1)
	local summoncount = getCreatureSummons(cid)
	if #summoncount < 4 then
		for i = 1, maxsummons - #summoncount do
			local mid = doSummonCreature("Guzzlemaw", getCreaturePosition(cid))
			if mid == false then
				return false
			end
			doConvinceCreature(cid, mid)
		end
	end
	return doCombat(cid, combat, var)
end

spell:name("mawhawk summon")
spell:words(NextSpellId())
spell:isAggressive(false)
spell:blockWalls(true)
spell:needTarget(false)
spell:needLearn(true)
spell:register()
