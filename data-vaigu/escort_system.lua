local _nextEscortId = 1000
local function nextEscortId()
	_nextEscortId = _nextEscortId + 1
	return _nextEscortId
end

local safeDelaySeconds = 2
---@class EscortData
EscortData = {}
EscortData.__index = EscortData
function EscortData:New(context)
	local newObj = {}
	newObj.escortId = nextEscortId()
	for key, value in pairs(context) do
		newObj[key] = value
	end
	newObj.AfterStart = newObj.AfterStart or function() end

	newObj.timeLimitSeconds = context.timeLimitSeconds or (15 * 60)
	newObj.startAfterSeconds = context.startAfterSeconds or 2
	newObj.destinationPos = context.destinationPos
	newObj.finishMessage = context.finishMessage
	newObj.localizer = context.localizer or LOCALIZERS.Universal
	newObj.proximityToSucceed = context.proximityToSucceed or 5
	newObj.grantQuestCreditRadius = context.grantQuestCreditRadius or 10
	newObj.key = context.key

	newObj.isOngoing = false

	if context.startAfterSeconds < 2 then
		logger.warn(T("[EscortData:New] - you cannot set startAfterSeconds lower than minimal safe delay of :safeDelaySeconds: seconds", { safeDelaySeconds = safeDelaySeconds }))
		context.startAfterSeconds = 2
	end

	setmetatable(newObj, self)
	return newObj
end
setmetatable(EscortData, {
	__call = function(class, ...)
		return class:New(...)
	end,
})
function EscortData:IsOngoing()
	return self.isOngoing
end
function EscortData:SetOngoing(isOngoing)
	self.isOngoing = isOngoing
	return self
end
---@return integer
function EscortData:GetId()
	return self.escortId
end
function EscortData:GetKey()
	return self.key
end
function EscortData:GetLocalizer()
	return self.localizer
end

EscortRegistry = {}
EscortRegistry.__index = EscortRegistry
EscortRegistry.registry = {}
function EscortRegistry:Register(escort)
	self.registry[escort:GetId()] = escort
	self.registry[escort:GetKey() or escort:GetId()] = escort
end
function EscortRegistry:GetById(id)
	return self.registry[id]
end
function EscortRegistry:Get(id)
	return self.registry[id]
end

---@class ActiveEscortRegistry
ActiveEscortRegistry = {}
ActiveEscortRegistry.__index = ActiveEscortRegistry
ActiveEscortRegistry.registry = {}
---@param activeEscort ActiveEscort
---@return ActiveEscortRegistry
function ActiveEscortRegistry:Register(activeEscort)
	self.registry[activeEscort:GetEscortData():GetId()] = activeEscort
	return self
end
function ActiveEscortRegistry:CanRegister(activeEscort)
	if self.registry[activeEscort:GetId()] then
		return false
	end
	return true
end
function ActiveEscortRegistry:GetByEscortData(escort)
	return self.registry[escort:GetId()]
end
function ActiveEscortRegistry:Unregister(activeEscort)
	self.registry[activeEscort:GetId()] = nil
	return self
end

local function monsterIsOneFloorAboveBelow(escorteePos, playerPos)
	if math.abs(escorteePos.z - playerPos.z) == 1 then
		return true
	end
	return false
end

local maxDistance = 7
local function MonsterIsTooFar(escorteePos, playerPos)
	if escorteePos:EuclideanDistance(playerPos) > maxDistance then
		return true
	end
	return false
end

---@class ActiveEscort
---@field private escortData EscortData
ActiveEscort = {}
ActiveEscort.__index = ActiveEscort
function ActiveEscort.New(context, player)
	local newObj = {}
	for key, value in pairs(context) do
		newObj[key] = value
	end

	if not newObj.escortData then
		logger.warn("[ActiveEscort.New] no escortData object provided. Escort cannot be started.")
		return
	end
	if not newObj.player then
		logger.warn("[ActiveEscort.New] no player object provided.")
	end
	if not newObj.npc then
		logger.warn("[ActiveEscort.New] no npc object provided.")
	end

	setmetatable(newObj, ActiveEscort)
	return newObj
end
setmetatable(ActiveEscort, {
	__call = function(_, ...)
		return ActiveEscort.New(...)
	end,
})

---@return EscortData
function ActiveEscort:GetEscortData()
	return self.escortData
end

function ActiveEscort:RespawnNpc()
	return Game.createNpc(self.npcName, self.npcPos)
end

function ActiveEscort:ContinueFollowingPlayer()
	if self.freezeEscortee then
		self.escortee:setFollowCreature(nil)
		return
	end

	local escorteePos = self.escortee:getPosition()
	local playerPos = self.player:getPosition()

	if MonsterIsTooFar(escorteePos, playerPos) then
		self.escortee:setFollowCreature(nil)
		return
	end

	if monsterIsOneFloorAboveBelow(escorteePos, playerPos) then
		self.escortee:teleportTo(playerPos)
		playerPos:sendMagicEffect(CONST_ME_TELEPORT)
		return
	end

	self.escortee:setFollowCreature(self.player)
end

function ActiveEscort:FreezeEscortee()
	self.freezeEscortee = true
end

function ActiveEscort:UnFreezeEscortee()
	self.freezeEscortee = false
end

function ActiveEscort:IsOngoing()
	return self:GetEscortData():IsOngoing()
end

function ActiveEscort:GetId()
	return self:GetEscortData():GetId()
end

function ActiveEscort:GetLocalizer()
	return self:GetEscortData():GetLocalizer()
end

function ActiveEscort:Reset()
	if not self:IsOngoing() then
		return
	end
	self:GetEscortData():SetOngoing(false)
	if self.escortee then
		self.escortee:remove()
	end
	self:RespawnNpc()
	ActiveEscortRegistry:Unregister(self)
end

function ActiveEscort:EscorteeIsAtDestination()
	if not self:GetEscortData().destinationPos then
		return false
	end

	local escorteePos = self.escortee:getPosition()
	local distanceToDestination = escorteePos:EuclideanDistance(self:GetEscortData().destinationPos)
	if distanceToDestination > self:GetEscortData().proximityToSucceed then
		return false
	end

	return true
end

function ActiveEscort:TryGrantCredit(player)
	local resolver = ResolutionContext.FromActiveEscort(self, player)
	resolver:Resolve()
end

function ActiveEscort:TryFinish()
	if not self:EscorteeIsAtDestination() then
		return
	end

	local escorteePos = self.escortee:getPosition()
	local grantQuestCreditRadius = self:GetEscortData().grantQuestCreditRadius
	local spectators = Game.getSpectators(escorteePos, false, true, grantQuestCreditRadius, grantQuestCreditRadius)
	for _, player in pairs(spectators) do
		self:TryGrantCredit(player)
	end

	if self:GetEscortData().finishMessage then
		local translatedThanksmessage = self.player:Localizer(self:GetEscortData().localizer):Get(self:GetEscortData().finishMessage)
		self.player:say(translatedThanksmessage, TALKTYPE_MONSTER_SAY, true, self.player, escorteePos)
	end

	self:Reset()
end

function ActiveEscort:TryRefreshPlayer()
	local refreshedPlayer = Player(self.player:getName())
	if refreshedPlayer then
		self.player = refreshedPlayer
	end
end

function ActiveEscort:Loop()
	local canProceed = true

	if os.time() > self.deadline then
		canProceed = false
		local translatedMessage = self.player:Localizer(LOCALIZERS.Universal):Get("You failed to complete the rescue in time.")
		self.player:say(translatedMessage, TALKTYPE_MONSTER_SAY)
	end

	if not Creature(self.escortee) then
		canProceed = false
		local translatedMessage = self.player:Localizer(LOCALIZERS.Universal):Get("You failed to complete the escort because rescuee died.")
		self.player:say(translatedMessage, TALKTYPE_MONSTER_SAY)
	end

	--This should be impossible
	if not self.player then
		canProceed = false
	end

	self:TryRefreshPlayer()

	if not canProceed then
		self:Reset()
		return
	end

	self:ContinueFollowingPlayer()
	self:TryFinish()
	addEvent(function()
		self:Loop()
	end, 1000)
end

function ActiveEscort:Start()
	self:GetEscortData():SetOngoing(true)
	addEvent(function()
		if not Player(self.player) then
			return
		end
		if not Npc(self.npc) then
			return
		end

		local displayName = self.npc:getName()
		local outfit = self.npc:getOutfit()
		local pos = self.npc:getPosition()

		local escortee = Game.createMonster(BASE_ESCORT_MONSTER_NAME, pos, false, true, nil, displayName)
		self.escortee = escortee

		--hpbar name and onlook name
		escortee:setOutfit(outfit)
		if self:GetEscortData().escorteeIsInvulnerable then
			escortee:setInvulnerable()
		end

		self.npcName = displayName
		self.npcPos = pos
		self.npc:remove()
		if not escortee then
			logger.error(T("[StartEscort] - Couldn't create escort creature on position :pos:", { pos = pos }))
		end
		self.deadline = os.time() + self:GetEscortData().timeLimitSeconds + self:GetEscortData().startAfterSeconds

		self:GetEscortData().AfterStart(self)
		self:Loop()
	end, self:GetEscortData().startAfterSeconds * 1000)
end

function StartEscortOpenWorld(context)
	local escort = ActiveEscort(context, context.player)
	ActiveEscortRegistry():Register(escort)
	escort:Start()
end
