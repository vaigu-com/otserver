local rewards = {
	[1300] = 8062,
	[1301] = 8090,
	[1302] = 8053,
	[1303] = 8060,
	[1304] = 8023,
	[1305] = 8096,
	[1306] = 8100,
	[1307] = 8102,
	[1308] = 8026,
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local weight = ItemType(rewards[item.uid]):getWeight()
	if player:getFreeCapacity() < weight then
		player:sendCancelMessage(string.format("Nagroda wazy %.2f oz. Nie zdolasz jej udzwignac.", (weight / 100)))
	else
		if player:getStorageValue(Storage.TheInquisition.Reward) < 1 then
			player:setStorageValue(Storage.TheInquisition.Reward, 1)
			player:setStorageValue(Storage.TheInquisition.Questline, 25)
			player:setStorageValue(Storage.TheInquisition.Mission07, 5) -- The Inquisition Questlog- "Mission 7: The Shadow Nexus"
			player:addItem(rewards[item.uid], 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found " .. ItemType(rewards[item.uid]):getName() .. ".")
			--player:addAchievement('Master of the Nexus')
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The chest is empty.")
		end
	end
	return true
end

for i, _ in pairs(rewards) do
	action:uid(i)
end
action:register()
