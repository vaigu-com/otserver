Storage.LinkedChest = {
	Annihilator = {},
	FirstArena = {},
	SecondArena = {},
	ThirdArena = {},
	PitsOfInferno = {},
	Inquisition = {},
	OrcFortress = {},
	DemonOak = {},
	DwarvenLegs = {},
}

local chests = {
	[Storage.LinkedChest.Annihilator] = {
		nextState = {
			[Storage.LinkedChest.Annihilator] = MISSION_FINISHED,
			[Storage.Finished.Annihilator] = MISSION_FINISHED,
		},
	},
	[Storage.LinkedChest.FirstArena] = {
		nextState = {
			[Storage.LinkedChest.FirstArena] = MISSION_FINISHED,
			[Storage.Finished.FirstArena] = MISSION_FINISHED,
		},
	},
	[Storage.LinkedChest.SecondArena] = {
		nextState = {
			[Storage.LinkedChest.SecondArena] = MISSION_FINISHED,
			[Storage.Finished.SecondArena] = MISSION_FINISHED,
		},
	},
	[Storage.LinkedChest.ThirdArena] = {
		nextState = {
			[Storage.LinkedChest.ThirdArena] = MISSION_FINISHED,
			[Storage.Finished.ThirdArena] = MISSION_FINISHED,
		},
	},
	[Storage.LinkedChest.PitsOfInferno] = {
		nextState = {
			[Storage.LinkedChest.PitsOfInferno] = MISSION_FINISHED,
			[Storage.Finished.PitsOfInferno] = MISSION_FINISHED,
		},
	},
	[Storage.LinkedChest.Inquisition] = {
		nextState = {
			[Storage.LinkedChest.Inquisition] = MISSION_FINISHED,
		},
	},
	[Storage.LinkedChest.OrcFortress] = {
		nextState = {
			[Storage.LinkedChest.OrcFortress] = MISSION_FINISHED,
			[Storage.Finished.OrcFortress] = MISSION_FINISHED,
		},
	},
	[Storage.LinkedChest.DemonOak] = {
		nextState = {
			[Storage.LinkedChest.DemonOak] = MISSION_FINISHED,
			[Storage.Finished.DemonOak] = MISSION_FINISHED,
			[Storage.DemonOak.Mission01] = MISSION_FINISHED,
		},
	},
	[Storage.LinkedChest.DwarvenLegs] = {
		nextState = {
			[Storage.LinkedChest.DwarvenLegs] = MISSION_FINISHED,
			[Storage.Finished.DwarvenLegs] = MISSION_FINISHED,
		},
	},
}

local linked = Action()
function linked.onUse(player, chestItemEx, fromPosition, target, toPosition, isHotkey)
	local key = chestItemEx:getKey()
	if player:getStorageValueByKey(key) == MISSION_FINISHED then
		SendChestIsEmpty(player, chestItemEx:getId())
		return DONT_OPEN_CONTAINER_ON_USE
	end

	local rewards = ExtractChestContent(chestItemEx)
	local chestStorageData = chests[chestItemEx:getKey()]
	if not chestStorageData then
		return DONT_OPEN_CONTAINER_ON_USE
	end

	if player:TryAddItems(rewards) then
		player:NextState(chestStorageData.nextState)
		player:getPosition():sendMagicEffect(CONST_ME_STUN)
	end
	return DONT_OPEN_CONTAINER_ON_USE
end
for _, key in pairs(Storage.LinkedChest) do
	linked:key(key)
end
linked:register()
