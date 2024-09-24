	:Script(function(storageToRequiredState)
local coffinMessages = {
	[0] = "The lid of this coffin won't move at all.",
	[1] = "Doubling your efforts, you managed to move the lid a bit.",
	[2] = "Having noticed nearby crobar, you put it in cracks in the wood and try to pry it, but the very fragment of wood was rotten and broke off.",
	[3] = "You relocate crowbar to another crevice nad using all you strength, you broke off the lid.",
}

local updateStorages = {
	[Storage.ImRestingHere.Mission01] = 2,
}

local crowbar = Action()
function crowbar.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local missionState = player:getStorageValue(Storage.ImRestingHere.Mission01)
	if missionState < 1 then
		local translatedError =
			player:Localizer(Storage.ImRestingHere.Localizer):Get("It wont move without special crowbar.")
		player:say(translatedError, TALKTYPE_MONSTER_SAY)
		return false
	end

	if missionState > 1 then
		return false
	end

	local coffinState = player:getStorageValue(Storage.ImRestingHere.Coffin)
	local message = coffinMessages[coffinState]
	if message then
		local translatedMessage = player:Localizer(Storage.ImRestingHere.Localizer):Get(message)
		player:say(translatedMessage, TALKTYPE_MONSTER_SAY)
		return true
	end

	if player:TryTradeInItems({ SPOCZYWAJACY_TUTAJ_KEY_ITEMS.crowbar }, { SPOCZYWAJACY_TUTAJ_KEY_ITEMS.lastWill }) then
		player:UpdateStorages(updateStorages)
	end
end

crowbar:aid(Storage.ImRestingHere.Coffin)
crowbar:register()
end)
