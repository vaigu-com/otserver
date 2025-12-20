local teleportSpawnPosition = Position(33104, 31909, 10)
local deathstrikeSpawnPosition = Position(33108, 31966, 10)

local spawnLock = SpawnLocks.BigfootsBurden.Warzone1

local addsSpawnArea = Area(Position(33088, 31897, 10), Position(33100, 31916, 10))
local creatures = {
	"humongous fungus",
	"hideous fungus",
}
local firstWaveDelay = 1
local lastWaveDelay = 6
local addsPerWave = 10

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if spawnLock:IsSet() then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You cannot use this crystal now.")
		return
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The crystal is morphing..")

	for delay = firstWaveDelay, lastWaveDelay do
		for _ = 1, addsPerWave do
			local creatureName = table.random(creatures)
			local pos = addsSpawnArea:RandomPosition()
			addEvent(doSummonCreature, delay * 20 * 1000, creatureName, pos)
			addEvent(doSendMagicEffect, delay * 20 * 1000, pos, CONST_ME_TELEPORT)
		end
	end

	spawnLock:Set(Game.createMonster("Deathstrike", deathstrikeSpawnPosition))

	addEvent(function()
		local tp = Game.createItem(1949, 1, teleportSpawnPosition)
		tp:setActionId(45701)
		spawnLock.onReset = function()
			tp:remove()
		end
		spawnLock.onSet = function() end
	end, lastWaveDelay * 20 * 1000 + 3000)

	return true
end
action:uid(3143)
action:register()
