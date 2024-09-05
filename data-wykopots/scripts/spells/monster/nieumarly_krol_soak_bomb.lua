local config = nil
local langToConfig = {
	["PL"] = {
		textOnPlacement = "Krol krypty wyczarowal bombe! Zasloncie ja swoim cialem, zeby nie wysadzila calej platformy! Macie 10 sekund.",
	},
	["EN"] = {
		textOnPlacement = "The Undead King conjured a bomb! Cover it with your bodies, so it doesnt annihilate the platform! You have 10 seconds.",
	},
}

local totalDamage = 5000

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_NONE)

local area = createCombatArea(AREA_BEAM1)
combat:setArea(area)

local function sendPositionsWarning(topLeft, downRight, magicEffect)
	IterateBetweenPositions(topLeft, downRight, function(context)
		local pos = context.pos
		pos:sendMagicEffect(magicEffect)
	end)
end

local function damageAllPlayers(topLeft, downRight)
	IterateBetweenPositions(topLeft, downRight, function(context)
		local pos = context.pos
		local tile = Tile(pos)
		if not tile then
			return
		end
		local creature = tile:getTopCreature()
		if not creature then
			return
		end
		doTargetCombatHealth(0, creature, COMBAT_FIREDAMAGE, totalDamage, totalDamage, CONST_ME_NONE)
	end)
end

local unsoakedExplosionRadius = 22
local explosionDelay = 10000
local soakRadius = 1

local function trySplitDamageBetweenPlayers(topLeft, downRight)
	if topLeft:PlayerCountBetween(downRight) > 0 then
		sendPositionsWarning(topLeft, downRight, CONST_ME_FIREAREA)
		local creatures = topLeft:PlayersBetween(downRight):Get()
		local splitdmg = totalDamage / #creatures
		for _, value in pairs(creatures) do
			doTargetCombatHealth(0, value, COMBAT_FIREDAMAGE, splitdmg, splitdmg, CONST_ME_NONE)
		end
		return true
	end
	return false
end

local function getBombTarget(cid)
	local creatures = {}
	local spectators = getSpectators(getCreaturePosition(cid), 7, 5, false)
	if not spectators then
		return nil
	end
	for _, id in pairs(spectators) do
		if id ~= cid then
			creatures[#creatures + 1] = id
		end
	end

	local target
	for _, creature in pairs(creatures) do
		local temp = nil
		temp = Player(creature)
		if temp and temp:isPlayer() and not temp:isKnight() then
			target = temp
			break
		end
	end

	return target
end

local function sendPlacementWarning(topLeft, downRight, target)
	config = GetConfigByPlayer(target, langToConfig)
	target:say(config.textOnPlacement, TALKTYPE_MONSTER_SAY)
	sendPositionsWarning(topLeft, downRight, CONST_ME_FIREAREA)
end

local function sendWarningsBeforeExplosion(topLeft, downRight)
	for i = 1, 3 do
		addEvent(function()
			sendPositionsWarning(topLeft, downRight, CONST_ME_HITBYFIRE)
		end, explosionDelay - i * 650)
	end
end

local function getNewBombPosition(target)
	local targetPos = target:getPosition()
	local topLeft, downRight = targetPos:GetBoundariesByRadius(1)
	local newPos = IterateBetweenPositions(topLeft, downRight, function(context)
		if context.pos:IsPathable() then
			return context.pos
		end
	end, { stopCondition = STOP_CONDITIONS.isNotNull })
	return Position(newPos)
end

local function placeBomb(pos)
	local bomb = Game.createItem(23486, 1, pos)
	bomb:setUniqueId(1000)
	return bomb
end

local function createBombTextures(soakTopLeft, soakDownRight, centerPos)
	local textures = {}
	IterateBetweenPositions(soakTopLeft, soakDownRight, function(context)
		local pos = context.pos
		textures[#textures + 1] = Game.createItem(23483, 1, pos)
	end)
	textures[#textures + 1] = placeBomb(centerPos)
	return textures
end

local function removeBombTextures(textures)
	for _, texture in pairs(textures) do
		texture:remove()
	end
end

local bombTimerSeconds = 10

local spell = Spell("instant")
function spell.onCastSpell(cid, var)
	local target = getBombTarget(cid)
	if not target then
		return
	end

	local pos = getNewBombPosition(target)
	if not pos then
		return
	end

	local soakTopLeft, soakDownRight = pos:GetBoundariesByRadius(soakRadius)
	local arenaTopLeft, arenaDownRight = pos:GetBoundariesByRadius(unsoakedExplosionRadius)

	local bombTextures = createBombTextures(soakTopLeft, soakDownRight, pos)
	addEvent(function()
		removeBombTextures(bombTextures)
	end, bombTimerSeconds * 1000)

	sendPlacementWarning(soakTopLeft, soakDownRight, target)
	sendWarningsBeforeExplosion(soakTopLeft, soakDownRight)
	Game.startCountdown(pos, bombTimerSeconds)

	addEvent(function()
		if trySplitDamageBetweenPlayers(soakTopLeft, soakDownRight) then
			return
		else
			damageAllPlayers(arenaTopLeft, arenaDownRight)
			sendPositionsWarning(arenaTopLeft, arenaDownRight, CONST_ME_FIREAREA)
			return
		end
	end, explosionDelay)
	return true
end

spell:name("nieumarly krol soak bomb")
spell:words(NextSpellId())
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:needDirection(true)
spell:register()
