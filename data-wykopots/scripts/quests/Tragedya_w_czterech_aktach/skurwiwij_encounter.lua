SKURWIWIJ_ENCOUNTER_DATA = {
	actionid = Storage.TragedyaWCzterechAktach.SkurwiwijAccess,
	bossName = "Skurwiwij",
	timerStorage = Storage.TragedyaWCzterechAktach.SkurwiwijAccess,
	cooldown = "weekly",

	leverPosition = Position(6576, 557, 9),
	entranceGrid = { topLeft = Position(6577, 557, 9), downRight = Position(6580, 557, 9) },

	bossPos = SKURWIWIJ_ANCHOR:Moved(-6, 0, 0),
	enterPos = SKURWIWIJ_ANCHOR:Moved(0, 0, 0),
	durationMinutes = 10,
	exitTeleportDestination = Position(6582, 557, 9),
	exitTeleportPosition = SKURWIWIJ_ANCHOR:Moved(7, 2, 0),
	exitTeleportActionid = Storage.TragedyaWCzterechAktach.Portals.AfterSkurwiwij,
	corner1 = SKURWIWIJ_ANCHOR:Moved(-11, -8, 0),
	corner2 = SKURWIWIJ_ANCHOR:Moved(16, 12, 0),

	scalingConfig = { hpPerPlayer = 1 },

	requiredStorages = { [Storage.TragedyaWCzterechAktach.SkurwiwijAccess] = 1 },
}
RegisterEncounter(SKURWIWIJ_ENCOUNTER_DATA)

local skurwiwijEncounterSingleton = nil
SkurwiwijEncounter = {}
function SkurwiwijEncounter:new()
	if skurwiwijEncounterSingleton then
		return skurwiwijEncounterSingleton
	end
	local newObj = {}
	self.__index = self
	setmetatable(newObj, self)
	return newObj
end
setmetatable(SkurwiwijEncounter, {
	__call = function(class, ...)
		return class:new(...)
	end,
})
skurwiwijEncounterSingleton = SkurwiwijEncounter()
function SkurwiwijEncounter:Get()
	return self
end

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

local pylonFlam = "pylonFlam"
local pylonVis = "pylonVis"
local pylons = {
	[pylonFlam] = { power = 0, pos = SKURWIWIJ_ANCHOR:Moved(-3, -5, 0), verticalTextureId = 5066, horizontalTextureId = 5064, name = pylonFlam, magicEffect = CONST_ME_FIREAREA },
	[pylonVis] = { power = 0, pos = SKURWIWIJ_ANCHOR:Moved(-3, 5, 0), verticalTextureId = 5069, horizontalTextureId = 5068, name = pylonVis, magicEffect = CONST_ME_ENERGYHIT },
}
local function resetPylons()
	for _, pylonData in pairs(pylons) do
		pylonData.power = 0
	end
end

function SkurwiwijEncounter:Start(encounterContext)
	self.skurwiwij = encounterContext.boss
	resetPylons()
	self.pylons = pylons
	self.lastPylon = self.pylons[pylonFlam]
	self.explosionsCount = 0
	self.baseExplosionDamage = 200
	self.damagePerConsecutiveExplosion = 50
	self:Loop()
end

function SkurwiwijEncounter:TriggerPylonExplosion(pylon)
	local damage = self.baseExplosionDamage + self.damagePerConsecutiveExplosion * self.explosionsCount
	if pylon.power < 25 then
		damage = damage * 2
	end
	pylon.power = 0

	drawPylonExplosion(0, pylon.pos, damage, pylon.magicEffect)
	self.explosionsCount = self.explosionsCount + 1
end

local channelPowerInterval = 400
function SkurwiwijEncounter:ChannelClosestPylon()
	local skurwiwijPos = self.skurwiwij:getPosition()
	local closestPylon = self.pylons[pylonFlam]
	local closestPylonDistance = 999
	for pylonName, pylon in pairs(pylons) do
		local distance = pylon.pos:DistanceTo(skurwiwijPos, true)
		if distance < closestPylonDistance then
			closestPylonDistance = distance
			closestPylon = pylon
		end
	end

	if self.lastPylon ~= closestPylon then
		self:TriggerPylonExplosion(self.lastPylon)
		self.lastPylon = closestPylon
		closestPylon.power = closestPylon.power + 1
	end
	closestPylon.pos:DrawLineTo(self.skurwiwij:getPosition(), closestPylon.verticalTextureId, closestPylon.horizontalTextureId, channelPowerInterval)
end

function SkurwiwijEncounter:Loop()
	addEvent(function()
		self:ChannelClosestPylon()
		self:Loop()
	end, channelPowerInterval)
end

local skurwiwijLever = Action()
function skurwiwijLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local encounterContext = UseEncounterLever(player, item, SKURWIWIJ_ENCOUNTER_DATA)
	if not encounterContext then
		return
	end
	SkurwiwijEncounter:Get():Start(encounterContext)
end

skurwiwijLever:aid(SKURWIWIJ_ENCOUNTER_DATA.actionid)
skurwiwijLever:register()
