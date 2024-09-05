local bosses = {
	["jaul"] = { status = 2, storage = Storage.DeeplingBosses.Jaul, centerPosition = Position(6893, 995, 11), fromPosition = Position(6910, 1009, 11) },
	["tanjis"] = { status = 3, storage = Storage.DeeplingBosses.Tanjis, centerPosition = Position(6893, 995, 11), fromPosition = Position(6998, 988, 11) },
	["obujos"] = { status = 4, storage = Storage.DeeplingBosses.Obujos, centerPosition = Position(6784, 991, 9), fromPosition = Position(6791, 974, 9) },
}

function clearDeeplingBossRoom(centerPosition, rangeX, rangeY, exitPosition)
	local spectators, spectator = Game.getSpectators(centerPosition, false, true, 10, 10)
	for i = 1, #spectators do
		spectator = spectators[i]
		if spectator:isPlayer() then
			if spectator:getStorageValue(Storage.DeeplingBosses.DailyDeeplingKill) == 1 then
				spectator:teleportTo(exitPosition)
				exitPosition:sendMagicEffect(CONST_ME_TELEPORT)
			end
		end
	end
end

local deeplingBosses = CreatureEvent("DeeplingBossDeath")
function deeplingBosses.onDeath(creature)
	local targetMonster = creature:getMonster()
	if not targetMonster or targetMonster:getMaster() then
		return true
	end

	local bossName = targetMonster:getName()
	local bossConfig = bosses[bossName:lower()]
	if not bossConfig then
		return true
	end

	onDeathForDamagingPlayers(creature, function(creature, player)
		if player:getStorageValue(Storage.DeeplingBosses.DeeplingStatus) < bossConfig.status then
			player:setStorageValue(Storage.DeeplingBosses.DeeplingStatus, bossConfig.status)
		end
		player:setStorageValue(bossConfig.storage, 1)
		player:setStorageValue(Storage.DeeplingBosses.DailyDeeplingKill, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Masz 5 minut na opuszczenie pokoju.")
	end)
	addEvent(clearDeeplingBossRoom, 60 * 5 * 1000, bossConfig.centerPosition, 15, 15, bossConfig.fromPosition) --1 min
end

deeplingBosses:register()
