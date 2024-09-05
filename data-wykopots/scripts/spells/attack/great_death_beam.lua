local function formulaFunction(player, level, maglevel)
	local min = (level / 5) + (maglevel * 5.5)
	local max = (level / 5) + (maglevel * 9)
	return -min, -max
end

function onGetFormulaValues(player, level, maglevel)
	return formulaFunction(player, level, maglevel)
end

function onGetFormulaValues2(player, level, maglevel)
	return formulaFunction(player, level, maglevel)
end

function onGetFormulaValues3(player, level, maglevel)
	return formulaFunction(player, level, maglevel)
end

local function createCombat(area, combatFunc)
	local initCombat = Combat()
	initCombat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, combatFunc)
	initCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
	initCombat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
	initCombat:setArea(createCombatArea(area))
	return initCombat
end

local combat = createCombat(AREA_BEAM6, "onGetFormulaValues")
local combat2 = createCombat(AREA_BEAM7, "onGetFormulaValues2")
local combat3 = createCombat(AREA_BEAM8, "onGetFormulaValues3")

local spell = Spell("instant")

local exhaust = {}
function spell.onCastSpell(creature, var)
	if not creature or not creature:isPlayer() then
		return false
	end

	local grade = creature:upgradeSpellsWOD("Great Death Beam")
	if grade == WHEEL_GRADE_NONE then
		creature:sendCancelMessage("You cannot cast this spell")
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	local cooldown = { 10, 8, 6 }
	var.runeName = "Beam Mastery"
	local executed = false

	local combat = { combat, combat2, combat3 }

	executed = combat[grade]:execute(creature, var)

	if executed then
		local condition = Condition(CONDITION_SPELLCOOLDOWN, CONDITIONID_DEFAULT, 260)
		local executedCooldown = cooldown[grade]
		if executedCooldown ~= nil then
			condition:setTicks((executedCooldown * 1000))
		end
		creature:addCondition(condition)
		return true
	end
	return false
end

spell:group("attack")
spell:id(260)
spell:name("Great Death Beam")
spell:words("exevo max mort")
spell:level(1)
spell:mana(140)
spell:isPremium(false)
spell:needDirection(true)
spell:blockWalls(true)
spell:cooldown(1000) -- Cooldown is calculated on the casting
spell:groupCooldown(2 * 1000)
spell:needLearn(true)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
