local nextState = {
	[Storage.ProdigalSon.Questline] = 1,
	[Storage.ProdigalSon.Mission01] = 1,
}

local requiredCzeslawQuestState = 8

local mainGateTile = MoveEvent()
function mainGateTile.onStepIn(player, item, toPosition, fromPosition)
	local czeslawQuestState = player:getStorageValue(Storage.ChesterTheDwarf.Questline)
	if czeslawQuestState < requiredCzeslawQuestState then
		return
	end

	local synMarnotrawnyState = player:getStorageValue(Storage.ProdigalSon.Questline)
	if synMarnotrawnyState > 0 then
		return
	end

	player:UpdateStorages(nextState)
end
mainGateTile:aid(Storage.ProdigalSon.TileBeforeChesterCompartment)
mainGateTile:register()
