function SendChestIsEmpty(player, itemId)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, T("The :itemName: is empty.", { itemName = ItemType(itemId):getName() }))
end

function ChestQuestTryAddItems(player, rewardChest)
	local aid = rewardChest:getActionId()
	local state = CustomItemRegistry():GetState(aid)
	local context = ResolutionContext.FromCustomItemState(state, player)

	if not context:Resolve() then
		if rewardChest:isContainer() then
			SendChestIsEmpty(player, rewardChest:getId())
		end
	end
	return true
end