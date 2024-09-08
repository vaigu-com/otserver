local config = {
	[39511] = {
		fromPosition = Position(6041, 1957, 14),
		toPosition = Position(6041, 1956, 14),
	},
	[39512] = {
		teleportPlayer = true,
		fromPosition = Position(6041, 1956, 14),
		toPosition = Position(6041, 1957, 14),
	},
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local useItem = config[item.actionid]
	if not useItem then
		return true
	end

	if useItem.teleportPlayer then
		player:teleportTo(Position(6014, 1957, 13))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:say("Magiczna uroda, hahaha!", TALKTYPE_MONSTER_SAY)
	end

	local tapestry = Tile(useItem.fromPosition):getItemById(6433)
	if tapestry then
		tapestry:moveTo(useItem.toPosition)
	end
	return true
end

action:aid(39511, 39512)
action:register()
