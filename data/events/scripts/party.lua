function Party:onJoin(player)
	local playerUid = player:getGuid()
	addEvent(function(playerFuncUid)
		local playerEvent = Player(playerFuncUid)
		if not playerEvent then
			return
		end
		local party = playerEvent:getParty()
		if not party then
			return
		end
		party:refreshHazard()
	end, 100, playerUid)
	return true
end

function Party:onLeave(player)
	local playerUid = player:getGuid()
	local members = self:getMembers()
	table.insert(members, self:getLeader())
	local memberUids = {}
	for _, member in ipairs(members) do
		if member:getGuid() ~= playerUid then
			table.insert(memberUids, member:getGuid())
		end
	end

	addEvent(function(playerFuncUid, memberUidsTableEvent)
		local playerEvent = Player(playerFuncUid)
		if playerEvent then
			playerEvent:updateHazard()
		end

		for _, memberUid in ipairs(memberUidsTableEvent) do
			local member = Player(memberUid)
			if member then
				local party = member:getParty()
				if party then
					party:refreshHazard()
					return -- Only one player needs to refresh the hazard for the party
				end
			end
		end
	end, 100, playerUid, memberUids)
	return true
end

function Party:onDisband()
	local members = self:getMembers()
	table.insert(members, self:getLeader())
	local memberIds = {}
	for _, member in ipairs(members) do
		if member:getId() ~= playerId then
			table.insert(memberIds, member:getId())
		end
	end
	addEvent(function()
		for _, memberId in ipairs(memberIds) do
			local member = Player(memberId)
			if member then
				member:updateHazard()
			end
		end
	end, 100)
	return true
end

local vocationCountToBonus = {
	[1] = 1.25,
	[2] = 1.35,
	[3] = 1.65,
	[4] = 1.8,
	--[[
	[5] = 2.0,
	[6] = 2.1,
	[7] = 2.2,
	[8] = 2.3,
	[9] = 2.4,
	]]
}

function Party:onShareExperience(exp)
	local distinctVocationsTable = {}
	local partyPlayers = self:getPlayers()

	for _, member in pairs(partyPlayers) do
		local vocationId = member:getVocation():getBase():getId()
		distinctVocationsTable[vocationId] = true
	end

	local distintVocationsCount = TableSize(distinctVocationsTable)
	if distintVocationsCount > 4 then
		distintVocationsCount = 4
	end

	local partyBonusMultiplier = vocationCountToBonus[distintVocationsCount]
	local bonusPerMember = math.ceil(partyBonusMultiplier / (#self:getMembers() + 1))
	return bonusPerMember
end
