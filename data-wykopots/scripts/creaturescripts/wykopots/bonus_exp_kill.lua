local function addPlayerBonusExperience(player, baseExp)
	local playerSpecificExpRate = getRateFromTable(experienceStages, player:getLevel(), configManager.getNumber(configKeys.RATE_EXPERIENCE))
	local finalExp = baseExp * playerSpecificExpRate
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received " .. finalExp .. " bonus experience!")
	player:addExperience(finalExp)
end

local bonusExpKill = CreatureEvent("BonusExpKill")
function bonusExpKill.onKill(player, killedMonster)
	if killedMonster:isPlayer() or killedMonster:getMaster() then
		return true
	end

	local targetMonster = killedMonster:getMonster()
	if not targetMonster then
		return true
	end

	local baseBonusExp = BonusExpByMonsterId(targetMonster)
	if baseBonusExp <= 0 then
		return
	end
	
	local damageMap = targetMonster:getDamageMap()
	local playerCount = TableSize(damageMap)
	local expPerPlayer = math.floor(baseBonusExp / playerCount)

	for playerid in pairs(damageMap) do
		local attackerPlayer = Player(playerid)
		if not attackerPlayer then
			goto continue
		end
		addPlayerBonusExperience(attackerPlayer, expPerPlayer)

		::continue::
	end

	return true
end

bonusExpKill:register()
