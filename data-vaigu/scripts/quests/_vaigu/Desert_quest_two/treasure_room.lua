local fromHubToQuestPortal = MoveEvent()
function fromHubToQuestPortal.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end
	local puzzlesCompleted, puzzlesCount = GetDQ2completedPuzzleCount(player)
	if puzzlesCompleted < puzzlesCount then
		player:teleportTo(fromPosition)
		local errorString = player:Localizer(Storage.DesertQuestTwo.Questline):Get("You need to complete all the puzzle challenges first. Your current progress: ")
		local finalString = errorString .. puzzlesCompleted .. "/" .. puzzlesCount
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, finalString)
		return
	end

	local treasureRoomPos = DESERT_QUEST_TWO_ANCHOR:Moved(13, -71, 0)
	player:teleportTo(treasureRoomPos)
	treasureRoomPos:sendMagicEffect(CONST_ME_TELEPORT)

	return true
end
fromHubToQuestPortal:aid(Storage.DesertQuestTwo.RewardRoomTp)
fromHubToQuestPortal:type("stepin")
fromHubToQuestPortal:register()
