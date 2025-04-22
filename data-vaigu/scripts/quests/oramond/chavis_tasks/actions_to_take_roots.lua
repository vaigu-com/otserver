local function revertRoot(position, itemId, transformId)
	local item = Tile(position):getItemById(itemId)
	if item then
		item:transform(transformId)
	end
end

local toTakeRoots = Action()
function toTakeRoots.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local rand = math.random(1, 100)
	if item.itemid == 21104 then
		if rand <= 50 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You successfully harvest some juicy roots.")
			player:AddCustomItem({id = 21291, count = 1})
			item:transform(item.itemid + 2)
			addEvent(revertRoot, 120000, toPosition, 21106, 21104)
			toPosition:sendMagicEffect(CONST_ME_GREEN_RINGS)
<<<<<<<< HEAD:data-vaigu/scripts/quests/oramond/chavis_tasks/actions_to_take_roots.lua
			if player:getStorageValueByKey(Storage.Oramond.QuestLine) <= 0 then
				player:setStorageValueByKey(Storage.Oramond.QuestLine, 1)
			end
			if player:getStorageValueByKey(Storage.Oramond.MissionToTakeRoots) <= 0 then
				player:setStorageValueByKey(Storage.Oramond.MissionToTakeRoots, 1)
			end
			player:setStorageValueByKey(Storage.Oramond.HarvestedRootCount, player:getStorageValueByKey(Storage.Oramond.HarvestedRootCount) > 0 and player:getStorageValueByKey(Storage.Oramond.HarvestedRootCount) + 1 or 1)
========
			if player:getStorageValue(Storage.Quest.U10_50.OramondQuest.QuestLine) <= 0 then
				player:setStorageValue(Storage.Quest.U10_50.OramondQuest.QuestLine, 1)
			end
			if player:getStorageValue(Storage.Quest.U10_50.OramondQuest.ToTakeRoots.Mission) <= 0 then
				player:setStorageValue(Storage.Quest.U10_50.OramondQuest.ToTakeRoots.Mission, 1)
			end
			player:setStorageValue(Storage.Quest.U10_50.OramondQuest.ToTakeRoots.Count, player:getStorageValue(Storage.Quest.U10_50.OramondQuest.ToTakeRoots.Count) > 0 and player:getStorageValue(Storage.Quest.U10_50.OramondQuest.ToTakeRoots.Count) + 1 or 1)
>>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a:data-otservbr-global/scripts/quests/oramond/to_take_roots/actions_to_take_roots.lua
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your harvesting attempt destroyed more of the juicy roots than you could salvage.")
			item:transform(item.itemid + 2)
			addEvent(revertRoot, 120000, toPosition, 21106, 21104)
			toPosition:sendMagicEffect(CONST_ME_GREEN_RINGS)
		end
	elseif item.itemid == 21105 then
		if rand <= 50 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You successfully harvest some juicy roots.")
			player:AddCustomItem({id = 21291, count = 1})
			item:transform(item.itemid + 2)
			addEvent(revertRoot, 120000, toPosition, 21107, 21105)
			toPosition:sendMagicEffect(CONST_ME_GREEN_RINGS)
<<<<<<<< HEAD:data-vaigu/scripts/quests/oramond/chavis_tasks/actions_to_take_roots.lua
			if player:getStorageValueByKey(Storage.Oramond.QuestLine) <= 0 then
				player:setStorageValueByKey(Storage.Oramond.QuestLine, 1)
			end
			if player:getStorageValueByKey(Storage.Oramond.MissionToTakeRoots) <= 0 then
				player:setStorageValueByKey(Storage.Oramond.MissionToTakeRoots, 1)
			end
			player:setStorageValueByKey(Storage.Oramond.HarvestedRootCount, player:getStorageValueByKey(Storage.Oramond.HarvestedRootCount) > 0 and player:getStorageValueByKey(Storage.Oramond.HarvestedRootCount) + 1 or 1)
========
			if player:getStorageValue(Storage.Quest.U10_50.OramondQuest.QuestLine) <= 0 then
				player:setStorageValue(Storage.Quest.U10_50.OramondQuest.QuestLine, 1)
			end
			if player:getStorageValue(Storage.Quest.U10_50.OramondQuest.ToTakeRoots.Mission) <= 0 then
				player:setStorageValue(Storage.Quest.U10_50.OramondQuest.ToTakeRoots.Mission, 1)
			end
			player:setStorageValue(Storage.Quest.U10_50.OramondQuest.ToTakeRoots.Count, player:getStorageValue(Storage.Quest.U10_50.OramondQuest.ToTakeRoots.Count) > 0 and player:getStorageValue(Storage.Quest.U10_50.OramondQuest.ToTakeRoots.Count) + 1 or 1)
>>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a:data-otservbr-global/scripts/quests/oramond/to_take_roots/actions_to_take_roots.lua
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your harvesting attempt destroyed more of the juicy roots than you could salvage.")
			item:transform(item.itemid + 2)
			addEvent(revertRoot, 120000, toPosition, 21107, 21105)
			toPosition:sendMagicEffect(CONST_ME_GREEN_RINGS)
		end
	elseif item.itemid == 21106 or item.itemid == 21107 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This root has already been harvested, nothing to gain here.")
	end
	return true
end

toTakeRoots:id(21104, 21105, 21106, 21107)
toTakeRoots:register()
