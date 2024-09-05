reward = {
	[4043] = { id_goblet = 5807, text = "wykonanie pierwszej areny.", rewardPosition = Position(6925, 616, 7) },
	[4044] = { id_goblet = 5806, text = "wykonanie drugiej areny.", rewardPosition = Position(6925, 609, 7) },
	[4045] = { id_goblet = 5805, text = "wykonanie ostatniej areny.", rewardPosition = Position(6925, 602, 7) },
}

local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if player:getStorageValue(item.uid) > 0 then
		return true
	end
	local rewardItem = Game.createItem(reward[item.uid].id_goblet, 1, reward[item.uid].rewardPosition)
	if rewardItem then
		rewardItem:setDescription(string.format("Dla " .. creature:getName() .. " za " .. reward[item.uid].text))
		rewardItem:setText("No niezle, bedzie do CV!")
	end
	creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
	player:setStorageValue(item.uid, 1)

	return true
end

movement:type("stepin")
movement:uid(4043, 4044, 4045)
movement:register()
