local safeDelaySeconds = 2

Escort = {}
function Escort:New(context)
	local newObj = {}
	self.npc = context.npc
	self.npcName = context.npcName or context.npc:getName()
	self.npcRespawnPos = context.npcRespawnPos or context.npc:getPosition()
	self.player = context.player
	self.escortee = nil
	self.escorteeName = context.escorteeName or context.npcName + " Escort"
	self.timeLimitSeconds = context.timeLimitSeconds or (15 * 60)
	self.startAfterSeconds = context.startAfterSeconds or 2
	self.deadline = os.time() + context.timeLimitSeconds + context.startAfterSeconds
	self.destinationPos = context.destinationPos
	self.finishMessage = context.finishMessage
	self.questlineAid = context.questlineAid or -1
	self.requiredState = context.requiredState or {}
	self.nextState = context.nextState or {}
	self.rewards = context.rewards or {}
	self.expReward = context.expReward or 0
	self.distanceToSucceed = context.distanceToSucceed or 5
	self.grantQuestCreditRadius = context.grantQuestCreditRadius or 10

	if context.startAfterSeconds < 2 then
		logger.debug(T("[Escort:New] - you cannot set startAfterSeconds lower than minimal safe delay of :safeDelaySeconds: seconds", { safeDelaySeconds = safeDelaySeconds }))
		logger.debug(debug.traceback())
		context.startAfterSeconds = 2
	end

	self.__index = self
	setmetatable(newObj, self)
	return newObj
end
setmetatable(Escort, {
	__call = function(class, ...)
		return class:new(...)
	end,
})

local escortRegistrySingleton = nil
EscortRegistry = {}
function EscortRegistry:new()
	if escortRegistrySingleton then
		return escortRegistrySingleton
	end
	local newObj = {}
	self.__index = self
	setmetatable(newObj, self)
	return newObj
end
setmetatable(EscortRegistry, {
	__call = function(class, ...)
		return class:new(...)
	end,
})
escortRegistrySingleton = EscortRegistry()
function EscortRegistry:Register(escort)
	local name = escort.escortee:getName()
	self.states[name] = escort
end

function EscortRegistry:GetState(escortee)
	local name = escortee:getName()
	return self.states[name]
end

function EscortRegistry:Unregister(escort)
	local name = escort.escortee:getName()
	self.states[name] = nil
end

function Escort:RespawnEscorteeNpc()
	return Game.createNpc(self.npcName, self.npcPos)
end

local function monsterIsOnDifferentLevel(escorteePos, playerPos)
	if math.abs(escorteePos.z - playerPos.z) ~= 1 then
		return true
	end
	return false
end

local function MonsterIsTooFar(escorteePos, playerPos)
	if escorteePos:DistanceTo(playerPos, true) > 5 then
		return true
	end
	return false
end

function Escort:ContinueFollowingPlayer()
	local escorteePos = self.escortee:getPosition()
	local playerPos = self.player:getPosition()

	if MonsterIsTooFar(escorteePos, playerPos) then
		self.escortee:setFollowCreature()
		return
	end

	if monsterIsOnDifferentLevel(escorteePos, playerPos) then
		self.escortee:teleportTo(playerPos)
		playerPos:sendMagicEffect(CONST_ME_TELEPORT)
		return
	end

	self.escortee:setFollowCreature(self.player)
end

function Escort:Reset()
	if self.escortee then
		self.escortee:remove()
	end
	self:RespawnEscortNpc()
end

function Escort:EscorteeIsAtDestination()
	if not self.destinationPos then
		return false
	end

	local escorteePos = self.escortee:getPosition()
	local distanceToDestination = escorteePos:DistanceTo(self.destinationPos, true)
	if distanceToDestination > self.distanceToSucceed then
		return false
	end

	return true
end

function Escort:TryGrantCredit(player)
	if not player:HasCorrectStorageValues(self.requiredState) then
		return
	end

	if self.nextState then
		player:UpdateStorages(self.nextState)
	end
	if self.rewards then
		player:AddItems(self.rewards)
	end
	if self.expReward then
		AddExperienceWithAnnouncement(player, self.expReward)
	end
	local translatedThanksmessage = player:Localizer(self.questlineAid):Get(self.finishMessage)
	player:say(translatedThanksmessage, TALKTYPE_MONSTER_SAY, true, player, self.escorteePos)
end

function Escort:TryFinish()
	if not self:EscorteeIsAtDestination() then
		return
	end

	local escorteePos = self.escortee:getPosition()
	local grantQuestCreditRadius = self.grantQuestCreditRadius
	local spectators = Game.getSpectators(escorteePos, false, true, grantQuestCreditRadius, grantQuestCreditRadius)
	for _, player in pairs(spectators) do
		Escort:TryGrantCredit(player)
	end
	self:Reset()
end

function Escort:Loop()
	local canProceed = true

	if os.time() > self.deadline then
		canProceed = false
		local translatedMessage = self.player:Localizer(nil):Get("You failed to complete the rescue in time.")
		self.player:say(translatedMessage, TALKTYPE_MONSTER_SAY)
	end

	if not Creature(self.escortee) then
		canProceed = false
		local translatedMessage = self.player:Localizer(nil):Get("You failed to complete the escort because rescuee died.")
		self.player:say(translatedMessage, TALKTYPE_MONSTER_SAY)
	end

	if not Player(self.player) then
		canProceed = false
	end

	if not canProceed then
		self:Reset()
		return
	end

	self:ContinueFollowingPlayer()
	self:TryFinish()
	addEvent(function()
		self:Loop()
	end, 500)
end

function Escort:Start()
	addEvent(function()
		if not (Player(self.player) and Npc(self.npc)) then
			return
		end

		self.npc:remove()
		local playerPos = self.player:getPosition()
		local escortee = Game.createMonster(self.escorteeName, playerPos)
		if not escortee then
			logger.error(T("[StartEscort] - Couldn't create escort creature :escorteeName: on position :pos:", { escorteeName = self.escorteeName, pos = playerPos:ToString() }))
		end
		self.escortee = escortee
		self:Loop()
	end, self.startAfterSeconds * 1000)
end

function StartEscort(context)
	local escort = Escort:New(context)
	EscortRegistry():Register(escort)
	escort:Start()
end
