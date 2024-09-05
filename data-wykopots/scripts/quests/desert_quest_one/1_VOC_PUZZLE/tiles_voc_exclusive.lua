local step_tile = MoveEvent()

function step_tile.onStepIn(player, item, toPosition, fromPosition)
	if not player:isPlayer() then
		return false
	end

	local aid = item.actionid

	local msAid = DESERT_QUEST_ONE_VOC_DOORS["ms"]
	local rpAid = DESERT_QUEST_ONE_VOC_DOORS["rp"]
	local edAid = DESERT_QUEST_ONE_VOC_DOORS["ed"]
	local ekAid = DESERT_QUEST_ONE_VOC_DOORS["ek"]

	if (aid == msAid and player:isSorcerer()) or (aid == rpAid and player:isPaladin()) or (aid == edAid and player:isDruid()) or (aid == ekAid and player:isKnight()) then
		return true
	end
	player:teleportTo(fromPosition)
	player:getPosition():sendMagicEffect(CONST_ME_STUN)
	player:sendTextMessage(MESSAGE_FAILURE, "You don't have the required profession.")
	return false
end

for _, value in pairs(Storage.DesertQuestOne.VocTiles) do
	step_tile:aid(value)
end
step_tile:type("stepin")
step_tile:register()
