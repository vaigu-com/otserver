local lowerRoshamuulTrough = Action()

function lowerRoshamuulTrough.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not target or type(target) ~= "userdata" or not target:isItem() then
		return false
	end

	if target:getId() == 20216 then
		item:transform(2873, 0)
		toPosition:sendMagicEffect(10)
<<<<<<<< HEAD:data-vaigu/scripts/quests/lower_roshamuul/actions_trough.lua
		player:setStorageValueByKey(ROSHAMUUL_MORTAR_THROWN, math.max(0, player:getStorageValueByKey(ROSHAMUUL_MORTAR_THROWN)) + 1)
========
		player:setStorageValue(Storage.Quest.U10_30.RoshamuulQuest.Roshamuul_Mortar_Thrown, math.max(0, player:getStorageValue(Storage.Quest.U10_30.RoshamuulQuest.Roshamuul_Mortar_Thrown)) + 1)
>>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a:data-otservbr-global/scripts/quests/roshamuul_quest/actions_trough.lua
	end
	return true
end

lowerRoshamuulTrough:id(20170)
lowerRoshamuulTrough:register()
