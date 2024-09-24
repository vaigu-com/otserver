	:Script(function(storageToRequiredState)
local conditions = {
	CONDITION_POISON, --utori pox
	CONDITION_FIRE, --utori flam
	CONDITION_ENERGY, --utori vis

	CONDITION_BLEEDING, --utori kor
	CONDITION_HASTE, --utani hur
	CONDITION_INVISIBLE, --utana vid/stealth ring

	CONDITION_MANASHIELD, --utamo vita/ering
	CONDITION_INFIGHT, -- any attack spell
	CONDITION_DRUNK, -- drink beer

	CONDITION_DROWN, -- special chest
	CONDITION_MUTED, -- spam
	CONDITION_FREEZING, -- special chest

	CONDITION_DAZZLED, --utori san
	CONDITION_CURSED, --utori mort
}

function Player:CountConditions()
	local counter = 0

	for _, condition in pairs(conditions) do
		if self:hasCondition(condition) then
			counter = counter + 1
		end
	end

	if not self:hasCondition(CONDITION_REGENERATION) then
		counter = counter + 1
	end
	return counter
end

local idToCreatureName = {
	[7575] = "Cipociamkacz",
	[7568] = "PatriotaPL",
	[7574] = "CalaNapszut",
}

local skull = Action()

local spawnstates = {
	[7575] = 0,
	[7568] = 0,
	[7574] = 0,
}

local requiredCount = #conditions - 1

function skull.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local id = item:getId()
	if spawnstates[id] == 1 then
		return false
	end

	local conditionsCount = player:CountConditions()
	if conditionsCount >= requiredCount then
		for _, condition in pairs(conditions) do
			player:removeCondition(condition)
		end
		spawnstates[id] = 1
		Game.createMonster(idToCreatureName[id], player:getPosition(), true, true)
	end
	return false
end

skull:aid(Storage.PathOfTheUndead.GuardianSkull)
skull:register()
end)
