local systemOn = true
local executionProbability = 3600 -- avg 1 every 2h
local exploMinutes = 5 -- time after which demon will explode
local secAmount = 5 -- amount of seconds counted before explosion
local explodeTime = exploMinutes * 60

-- Calculate avg frequency
local averageFrequencyPerHour = (3600 / 2) / executionProbability

-- Explosion func
local function explode(position)
	local tile = Tile(position)
	if not tile then
		return false
	end

	for i = -1, 1 do
		for j = -1, 1 do
			local effectPosition = Position(position.x + i, position.y + j, position.z)
			effectPosition:sendMagicEffect(CONST_ME_FIREAREA)
			local tile = Tile(effectPosition)
			local topCreature = tile:getTopCreature()
			if topCreature and topCreature:isPlayer() then
				topCreature:addHealth(-66666, COMBAT_UNDEFINEDDAMAGE)
			end
		end
	end
end

-- Revert demon to training dummy
local function exploAndRevert(creature)
	local creature = Creature(creature)
	if not creature then
		return false
	end

	local position = creature:getPosition()
	position:sendMagicEffect(CONST_ME_POFF)
	creature:remove()
	explode(position)

	Game.createMonster("Training Dummy", position, true, true)
end

-- Counting down minutes
local function countdownEvent(creature, countdown)
	local creature = Creature(creature)
	if not creature then
		return false
	end

	local minuteText = countdown > 1 and " MINUTES" or " MINUTE"

	creature:say("YOU HAVE " .. countdown .. minuteText .. " TO RUN AWAY OR YOULL DIE!", TALKTYPE_MONSTER_SAY)
	countdown = countdown - 1

	addEvent(countdownEvent, 60 * 1000, creature:getId(), countdown)
end

-- Counting down last seconds
local function countdownSeconds(creature, countdown)
	local creature = Creature(creature)
	if not creature then
		return false
	end

	creature:getPosition():sendMagicEffect(CONST_ME_HITBYFIRE)
	creature:say(countdown .. "!", TALKTYPE_MONSTER_SAY)
	countdown = countdown - 1

	addEvent(countdownSeconds, 1 * 1000, creature:getId(), countdown)
end

local dummyTransform = CreatureEvent("DummyTransform")
function dummyTransform.onThink(creature)
	if systemOn == false then
		return false
	end

	if creature:getName():lower() ~= "training dummy" then
		return true
	end

	local rand = math.random(1, executionProbability)
	if rand == 1 then
		local position = creature:getPosition()
		position:sendMagicEffect(CONST_ME_POFF)
		creature:remove()

		local demon = Game.createMonster("Dummy Demon", position, true, true)
		addEvent(exploAndRevert, explodeTime * 1000, demon:getId())
		addEvent(countdownSeconds, (explodeTime * 1000) - (secAmount * 1000), demon:getId(), secAmount)
		countdownEvent(demon:getId(), exploMinutes)
	end
end

dummyTransform:register()
