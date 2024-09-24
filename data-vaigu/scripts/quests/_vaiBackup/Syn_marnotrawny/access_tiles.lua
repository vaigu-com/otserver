local errorMessage = "You don't have permission to go there. Talk to Overseer Henry of Januszex to be granted an entry."
local function tryEnterAccessTile(actionid, player, fromPosition)
	if not player:isPlayer() then
		return
	end

	if player:getStorageValue(actionid) == -1 then
		local transaltedMessage = player:Localizer(Storage.ProdigalSon.Questline):Get(errorMessage)
		player:sendTextMessage(MESSAGE_INFO_DESCR, transaltedMessage)
		player:teleportTo(fromPosition, true)
	end

	return true
end

local mainGateTile = MoveEvent()
function mainGateTile.onStepIn(player, item, toPosition, fromPosition)
	tryEnterAccessTile(Storage.ProdigalSon.MainGateAccess, player, fromPosition)
end
mainGateTile:aid(Storage.ProdigalSon.MainGateAccess)
mainGateTile:register()

local northMinesTile = MoveEvent()
function northMinesTile.onStepIn(player, item, toPosition, fromPosition)
	tryEnterAccessTile(Storage.ProdigalSon.NorthMinesAccess, player, fromPosition)
end
northMinesTile:aid(Storage.ProdigalSon.NorthMinesAccess)
northMinesTile:register()
