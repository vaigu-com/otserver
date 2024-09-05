local conditionExhaust = Condition(CONDITION_EXHAUST_COMBAT, CONDITIONID_DEFAULT)
conditionExhaust:setParameter(CONDITION_PARAM_SUBID, DEFAULT_CONDITION_COMBAT_SUB_ID)
conditionExhaust:setParameter(CONDITION_PARAM_TICKS, 4 * 1000)

local voc = { 3, 7 }

local area = createCombatArea({
	{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
	{ 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
})

local combat = Combat()
combat:setArea(area)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYHIT)

local minDamage = 4000
local maxDamage = 8000

function onTargetTile(boss, pos)
	local tile = pos:getTile()
	if not tile then
		return true
	end

	local creatures = tile:getCreatures()

	if creatures then
		for _, creature in ipairs(creatures) do
			if creature ~= boss then
				local player = creature:getPlayer()
				if not player or isInArray(voc, player:getVocation():getId()) then
					doTargetCombatHealth(boss, creature, COMBAT_DEATHDAMAGE, -minDamage, -maxDamage, CONST_ME_NONE)
				end
			end
		end
	end

	return true
end

combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local function delayedCastSpell(cid, variant)
	local creature = Creature(cid)
	if not creature then
		return
	end

	creature:say("DIE!", TALKTYPE_ORANGE_1)
	return combat:execute(creature, Variant(creature:getPosition()))
end

--select a player with this vocation
local function selectVocTarget(boss)
	local bossPosition = boss:getPosition()
	local creatures = boss:getTargetList()

	local lowestDist = 1000
	local lowestDistPlayer

	if creatures then
		for _, creature in ipairs(creatures) do
			local player = creature:getPlayer()
			if player and isInArray(voc, player:getVocation():getId()) then
				local playerPosition = player:getPosition()
				local tmpDist = bossPosition:getDistance(playerPosition)
				if lowestDist > tmpDist then
					lowestDist = tmpDist
					lowestDistPlayer = player
				end
			end
		end
	end

	if lowestDistPlayer then
		boss:setTarget(lowestDistPlayer)
		boss:setFollowCreature(lowestDistPlayer)
		if not boss:getTarget() then
			boss:searchTarget()
		end
	end
end

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	if not creature:getCondition(CONDITION_EXHAUST_COMBAT, CONDITIONID_DEFAULT, DEFAULT_CONDITION_COMBAT_SUB_ID) then
		creature:addCondition(conditionExhaust)
		selectVocTarget(creature)
		creature:say("All PALADINS must DIE!", TALKTYPE_ORANGE_1)
		SpellAddEvent(delayedCastSpell, 4000, creature:getId(), variant)
	end

	return true
end

spell:name("prince drazzak paladin")
spell:words(NextSpellId())
spell:isAggressive(true)
spell:blockWalls(true)
spell:needTarget(true)
spell:needLearn(true)
spell:register()
