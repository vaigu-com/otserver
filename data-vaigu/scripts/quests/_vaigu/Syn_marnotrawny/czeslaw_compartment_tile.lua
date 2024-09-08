local nextState = {
	[Storage.SynMarnotrawny.Questline] = 1,
	[Storage.SynMarnotrawny.Mission01] = 1,
}

local requiredCzeslawQuestState = 8

local mainGateTile = MoveEvent()
function mainGateTile.onStepIn(player, item, toPosition, fromPosition)
	local czeslawQuestState = player:getStorageValue(Storage.CzeslawKrasnolud.Questline)
	if czeslawQuestState < requiredCzeslawQuestState then
		return
	end

	local synMarnotrawnyState = player:getStorageValue(Storage.SynMarnotrawny.Questline)
	if synMarnotrawnyState > 0 then
		return
	end

	player:UpdateStorages(nextState)
end
mainGateTile:aid(Storage.SynMarnotrawny.TileBeforeCzeslawCompartment)
mainGateTile:register()
