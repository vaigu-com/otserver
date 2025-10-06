local function generateBurstArrowCombat(area)
	local combat = Combat()
	combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
	combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONAREA)
	combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_BURSTARROW)
	combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
	combat:setFormula(COMBAT_FORMULA_SKILL, 0, 0, 1, 0)
	combat:setParameter(COMBAT_PARAM_IMPACTSOUND, SOUND_EFFECT_TYPE_BURST_ARROW_EFFECT)
	combat:setParameter(COMBAT_PARAM_CASTSOUND, SOUND_EFFECT_TYPE_DIST_ATK_BOW)
	combat:setArea(area)
	return combat
end

local areaSmall = createCombatArea(AREA_SQUARE1X1)
local areaMedium = createCombatArea(AREA_CIRCLE2X2)
local areaBig = createCombatArea(AREA_CIRCLE3X3)
local areaVeryBig = createCombatArea(AREA_CIRCLE5X5V2)

local combatSmall = generateBurstArrowCombat(areaSmall)
local combatMedium = generateBurstArrowCombat(areaMedium)
local combatBig = generateBurstArrowCombat(areaBig)
local combatVeryBig = generateBurstArrowCombat(areaVeryBig)

local function getCombatBySkill(skill)
	if skill < 70 then
		return combatSmall
	end

	if skill >= 70 and skill < 100 then
		return combatMedium
	end

	if skill >= 100 and skill < 150 then
		return combatBig
	end

	if skill >= 150 then
		return combatVeryBig
	end

	return combatSmall
end

local burstArrow = Weapon(WEAPON_AMMO)

burstArrow.onUseWeapon = function(player, variant)
	if player:getSkull() == SKULL_BLACK then
		return false
	end

	return getCombatBySkill(player:getEffectiveSkillLevel(SKILL_DISTANCE)):execute(player, variant)
end

burstArrow:id(3449)
burstArrow:attack(27)
burstArrow:action("removecount")
burstArrow:ammoType("arrow")
burstArrow:shootType(CONST_ANI_BURSTARROW)
burstArrow:maxHitChance(100)
burstArrow:register()
