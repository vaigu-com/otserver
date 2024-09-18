local config = {
	["ground"] = "A magical force brought you back to the solid ground.",
	["closed"] = "Aurnor has prevented you from using this path.",
}

local path = MoveEvent()

function path.onStepIn(player, item, toPosition, fromPosition)
	if not player:isPlayer() then
		return false
	end

	local storageVal = player:getStorageValue(Storage.AssassinsCreedSquurvaali.Questline)
	local playerMount = player:getOutfit().lookMount
	if storageVal < 14 or playerMount ~= 689 then
		player:teleportTo(fromPosition)
		player:getPosition():sendMagicEffect(CONST_ME_STUN)
		player:say(player:Localizer(Storage.AssassinsCreedSquurvaali.Questline):Get(config["ground"]), TALKTYPE_MONSTER_SAY)
		return false
	end
	if storageVal > 14 then
		player:teleportTo(fromPosition)
		player:getPosition():sendMagicEffect(CONST_ME_STUN)
		player:say(player:Localizer(Storage.AssassinsCreedSquurvaali.Questline):Get(config["closed"]), TALKTYPE_MONSTER_SAY)
		return false
	end
	return true
end

path:aid(Storage.AssassinsCreedSquurvaali.HeavenPath)
path:register()

local lastTile = MoveEvent()
function lastTile.onStepIn(player, item, toPosition, fromPosition)
	if not player:isPlayer() then
		return false
	end
	player:teleportTo(Position(5745, 801, 4), true)
	return true
end
lastTile:aid(Storage.AssassinsCreedSquurvaali.HeavenLastTile)
lastTile:register()
