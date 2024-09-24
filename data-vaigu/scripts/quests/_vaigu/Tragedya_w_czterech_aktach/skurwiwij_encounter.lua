	:Script(function(storageToRequiredState)
	:EncounterFight(function()
local pylonFlam = "pylonFlam"
local pylonVis = "pylonVis"
local pylons = {
	[pylonFlam] = { power = 0, pos = SKURWIWIJ_ANCHOR:Moved(9, 2, 0), verticalTextureId = 5066, horizontalTextureId = 5064, name = pylonFlam, magicEffect = CONST_ME_FIREAREA },
	[pylonVis] = { power = 0, pos = SKURWIWIJ_ANCHOR:Moved(9, 12, 0), verticalTextureId = 5069, horizontalTextureId = 5068, name = pylonVis, magicEffect = CONST_ME_ENERGYHIT },
}

local function resetPylons()
	for _, pylonData in pairs(pylons) do
		pylonData.power = 0
	end
end

local encounter = Encounter("skurwiwij-lair", {
	timeToSpawnMonsters = "1000ms",
	bossName = "Skurwiwij",
	bossPosition = SKURWIWIJ_ANCHOR:Moved(6, 6, 0),
	zoneArea = {
		SKURWIWIJ_ANCHOR:Moved(0, 0, 0),
		SKURWIWIJ_ANCHOR:Moved(21, 17, 0),
	},
})

function encounter:onReset()
	encounter:removeMonsters()
end

function encounter:beforeStart()
	resetPylons()
	self.pylons = pylons
	self.lastPylon = self.pylons[pylonFlam]
	self.explosionsCount = 0
	self.baseExplosionDamage = 200
	self.damagePerConsecutiveExplosion = 50
end

encounter:addSpawnMonsters({
	{
		name = encounter.bossName,
		positions = {
			encounter.bossPosition,
		},
		spawn = function(monster)
			encounter.skurwiwij = monster
		end,
	},
})

encounter:addRemoveMonsters()
encounter:startOnEnter()
encounter:register()

local channelPowerInterval = 400
local empowerPylons = GlobalEvent("encounter.skurwiwij-lair.empower-pylons")
function empowerPylons.onThink()
	if not encounter:isActive() then
		return true
	end
	if not encounter.skurwiwij then
		return true
	end

	local skurwiwijPos = encounter.skurwiwij:getPosition()
	local closestPylon = {}
	local closestPylonDistance = 999
	for pylonName, pylonData in pairs(pylons) do
		local distance = pylonData.pos:EuclideanDistance(skurwiwijPos)
		if distance <= closestPylonDistance then
			closestPylonDistance = distance
			closestPylon = pylonData
		end
	end

	if encounter.lastPylon ~= closestPylon then
		TriggerPylonExplosion(encounter.lastPylon)
		encounter.lastPylon = closestPylon
		closestPylon.power = closestPylon.power + 1
	end
	closestPylon.pos:DrawLine(encounter.skurwiwij:getPosition(), closestPylon.verticalTextureId, closestPylon.horizontalTextureId, channelPowerInterval)

	return true
end
empowerPylons:interval(channelPowerInterval)
empowerPylons:register()

local function tryDamagePlayer(pos, damage)
	local tile = Tile(pos)
	if not tile then
		return
	end
	local creature = tile:getTopCreature()
	if not creature then
		return
	end
	if creature:isPlayer() or creature:getMaster() then
		doTargetCombatHealth(0, creature, COMBAT_PHYSICALDAMAGE, -damage, -damage, CONST_ME_NONE)
	end
end

local function drawDamagingSqm(pos, damage, magicEffect)
	pos:sendMagicEffect(magicEffect)
	tryDamagePlayer(pos, damage)
end

local function drawDamagingSqms(pos, x, y, damage, magicEffect)
	drawDamagingSqm(pos:Moved(0 + x, 0 + y, 0), damage, magicEffect)
	drawDamagingSqm(pos:Moved(0 + y, 0 + x, 0), damage, magicEffect)
	drawDamagingSqm(pos:Moved(0 - y, 0 + x, 0), damage, magicEffect)
	drawDamagingSqm(pos:Moved(0 - x, 0 + y, 0), damage, magicEffect)
	drawDamagingSqm(pos:Moved(0 - x, 0 - y, 0), damage, magicEffect)
	drawDamagingSqm(pos:Moved(0 - y, 0 - x, 0), damage, magicEffect)
	drawDamagingSqm(pos:Moved(0 + y, 0 - x, 0), damage, magicEffect)
	drawDamagingSqm(pos:Moved(0 + x, 0 - y, 0), damage, magicEffect)
end

local function drawDamagingRing(radius, centerPos, damage, magicEffect)
	local x = radius
	local y = 0
	local decision = 1 - x
	while y <= x do
		drawDamagingSqms(centerPos, x, y, damage, magicEffect)
		y = y + 1
		if decision <= 0 then
			decision = decision + 2 * y + 1
		else
			x = x - 1
			decision = decision + 2 * (y - x) + 1
		end
	end
end

local pylonExplosionMaxRadius = 13
local pylonExplosionsInterval = 500
local function drawPylonExplosion(i, pos, damage, magicEffect)
	if i > pylonExplosionMaxRadius then
		return
	end
	drawDamagingRing(i, pos, damage, magicEffect)
	i = i + 1
	addEvent(function()
		drawPylonExplosion(i, pos, damage, magicEffect)
	end, pylonExplosionsInterval)
end

function TriggerPylonExplosion(pylon)
	local damage = encounter.baseExplosionDamage + encounter.damagePerConsecutiveExplosion * encounter.explosionsCount
	if pylon.power < 25 then
		damage = damage * 2
	end
	pylon.power = 0

	drawPylonExplosion(0, pylon.pos, damage, pylon.magicEffect)
	encounter.explosionsCount = encounter.explosionsCount + 1
end
end)
end)
