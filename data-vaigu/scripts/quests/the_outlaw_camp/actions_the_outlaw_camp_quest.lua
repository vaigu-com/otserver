-- Bag -> bright sword and red gem
local bagId = 2853
local rewards = {
	{ id = 3295 }, -- bright sword
	{ id = 3039 }, -- red gem
}

local outlawQuest = Action()
function outlawQuest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	for _, reward in ipairs(rewards) do
		local rewardId = reward[1]
		if not player:canGetReward(rewardId, "outlaw") then
			return true
		end
	end

	player:AddItems({
		[bagId] = rewards,
	})
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a bag.")
	player:questKV("outlaw"):set("completed", true)
	player:setStorageValueByKey(Storage.QuestChests.OutlawCamp, 1)

	return true
end

outlawQuest:uid(14091)
outlawQuest:register()
