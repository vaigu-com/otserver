Storage.FlamingOrchid = {
	BossRoom = {},
	Cracks = {
		Crack1 = {},
		Crack2 = {},
		Crack3 = {},
		Crack4 = {},
	},
}

local bossRoomStates = {
	cannotBeOpened = -1,
	canBeOpened = 1,
	canBeEntered = 2,
}
local crackStates = {
	notUnlocked = -1,
	unlocked = 1,
}

local crackUse = Action()
function crackUse.onUse(player, crack, fromPosition, target, toPosition, isHotkey)
	local bossRoomState = getStorageValueByKey(Storage.FlamingOrchid)
	if bossRoomState ~= bossRoomStates.canBeOpened then
		doCreatureSay(player, "That was close. I nearly fell down!", TALKTYPE_ORANGE_1)
		return true
	end

	local key = crack:getKey()
	if getStorageValueByKey(key) == crackStates.notUnlocked then
		setStorageValueByKey(key, crackStates.unlocked)
		player:teleportTo(player:getPosition():Moved(0, 0, 1))
	end

	return true
end
for _, key in pairs(Storage.FlamingOrchid.Cracks) do
	crackUse:key(key)
end
crackUse:register()

local flamingOrchidDeath = CreatureEvent("FlamingOrchidDeath")
function flamingOrchidDeath.onDeath(creature)
	setStorageValueByKey(Storage.FlamingOrchid.BossRoom, bossRoomStates.cannotBeOpened)
	for key, value in pairs(Storage.FlamingOrchid.Cracks) do
		setStorageValueByKey(key, crackStates.notUnlocked)
	end
end
flamingOrchidDeath:register()

local doorUse = Action()
function doorUse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local bossRoomState = getStorageValueByKey(Storage.FlamingOrchid)

	local playerPos = player:getPosition()
	local doorPosition = item:getPosition()
	local direction = playerPos:DirectionTo(doorPosition)
	local dest = doorPosition:MovedInDirection(direction, 2)
	if direction == DIRECTION_WEST then
		player:teleportTo(dest)
		return true
	end

	if bossRoomState ~= bossRoomStates.canBeEntered then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The doors are painted with creeping figures that depict, Lich, Destroyer, Fire Elemental and Vampire.")
		return true
	else
		player:teleportTo(dest)
	end

	return true
end
doorUse:key(Storage.FlamingOrchid.BossRoom)
doorUse:register()

local globalevent = GlobalEvent("FlamingOrchidCycle")
function globalevent.onThink(...)
	if getStorageValueByKey(Storage.FlamingOrchid.BossRoom) ~= bossRoomStates.canBeOpened then
		return GLOBAL_EVENT_OK
	end

	Game.createMonster("The Flaming Orchid", Position(6615, 997, 3))
	setStorageValueByKey(Storage.FlamingOrchid.BossRoom, bossRoomStates.canBeOpened)
	return GLOBAL_EVENT_OK
end
globalevent:interval(30 * 60 * 1000) --30min
globalevent:register()
