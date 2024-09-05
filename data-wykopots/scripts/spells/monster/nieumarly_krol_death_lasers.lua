local config = nil
local langToConfig = {
	["PL"] = {
		textCharging = "Ale zaraz wam wywale z laserka! Bzzt bzzt byle jak! ",
	},
	["EN"] = {
		textCharging = "I shall zap you with my beam-inator!",
	},
}
config = langToConfig["EN"]

local smallLaser = Combat()
smallLaser:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
smallLaser:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
local smallArea = createCombatArea(AREA_SIDEBEAMS1)
smallLaser:setArea(smallArea)
smallLaser:setFormula(COMBAT_FORMULA_DAMAGE, -300, 0, -300, 0)

local bigLaser = Combat()
bigLaser:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
bigLaser:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
local bigArea = createCombatArea(AREA_SIDEBEAMS2)
bigLaser:setArea(bigArea)
bigLaser:setFormula(COMBAT_FORMULA_DAMAGE, -300, 0, -300, 0)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local hpPercentage = creature:getHealth() / creature:getMaxHealth()

	local choice = nil
	if hpPercentage >= 0.5 then
		choice = smallLaser
	else
		choice = bigLaser
	end

	local target = Tile(var.pos):getTopCreature()
	if target and target:isPlayer() then
		config = GetConfigByPlayer(target, langToConfig)
	end
	creature:say(config.textCharging, TALKTYPE_MONSTER_SAY)
	local timer = 1500
	local interval = 180

	for _ = 1, 7 do
		addEvent(function()
			doCombat(creature, choice, var)
		end, timer)
		timer = timer + interval
	end
	return true
end

spell:name("nieumarly krol death lasers")
spell:words(NextSpellId())
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:needDirection(true)
spell:register()
