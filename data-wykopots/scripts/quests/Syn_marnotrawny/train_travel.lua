local travelTimeSeconds = 20
local aidToDest = {
	[Storage.SynMarnotrawny.TrainDestinations.ToHurghada] = Position(6461, 1125, 14),
	[Storage.SynMarnotrawny.TrainDestinations.ToJanuszex] = Position(7550, 962, 13),
}
local aidToName = {
	[Storage.SynMarnotrawny.TrainDestinations.ToHurghada] = "Hurghada",
	[Storage.SynMarnotrawny.TrainDestinations.ToJanuszex] = "Januszex",
}

local confirmChoice = function(player, button, choice)
	if not choice then
		return true
	end
	if player:getPosition():DistanceTo(aidToDest[choice.aid], true) < 100 then
		return true
	end

	player:teleportTo(JANUSZEX_MOVING_TRAIN_ANCHOR)
	player:say(player:Localizer(Storage.SynMarnotrawny.Questline):Get("TrainMovingTo") .. choice.text, TALKTYPE_MONSTER_SAY)
	addEvent(function()
		if player then
			player:teleportTo(aidToDest[choice.aid])
		end
	end, travelTimeSeconds * 1000)
end

local function hasUnlockedDestination(player, aid)
	return player:getStorageValue(aid) == 1
end

local updateStorages = {
	[Storage.SynMarnotrawny.Questline] = 3,
	[Storage.SynMarnotrawny.Mission01] = 3,
	[Storage.SynMarnotrawny.Mission02] = 1,
}

local trainTravel = Action()
function trainTravel.onUse(player, item, toPosition, fromPosition)
	if not player:isPlayer() then
		return false
	end

	if player:getStorageValue(Storage.SynMarnotrawny.MetroAccess) == -1 then
		return true
	end

	if player:getStorageValue(Storage.SynMarnotrawny.Questline) == 2 then
		player:UpdateStorages(updateStorages)
	end

	player:ClearConditions()

	local title = player:Localizer(Storage.SynMarnotrawny.Questline):Get("ShipTitle")
	local message = player:Localizer(Storage.SynMarnotrawny.Questline):Get("ShipMessage")
	local window = ModalWindow({ title = title, message = message })

	for aid in pairs(aidToDest) do
		if hasUnlockedDestination(player, aid) then
			local text = aidToName[aid]
			--local transaltedText = TryGetTranslatedString(player, Storage.PerIustitiaAdAstra.Questline, aidToName[aid])
			local choice = window:addChoice(text)
			choice.aid = aid
		end
	end

	window:addButton(player:Localizer(Storage.SynMarnotrawny.Questline):Get("ShipOk"), confirmChoice)
	window:sendToPlayer(player)
	return true
end

trainTravel:aid(Storage.SynMarnotrawny.Train.SelectDestination)
trainTravel:register()
