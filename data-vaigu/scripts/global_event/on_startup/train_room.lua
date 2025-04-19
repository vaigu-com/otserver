local trainingAttackSpeedReduction = 0.6
local trainRoomSetup = GlobalEvent("TrainRoomSetup")
function trainRoomSetup.onStartup()
	local zone = Zone("TrainingRoom")
	local zoneEvents = ZoneEvent(zone)
	function zoneEvents.afterEnter(zone, creature)
		local player = creature:getPlayer()
		if not player then
			return true
		end

		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Sweaty vapors of the training room hinder your agility. Your attack speed was reduced by 60%.")
		player:setAttackSpeed(player:getVocation():getAttackSpeed() * 1 / (1 - trainingAttackSpeedReduction))
	end
	function zoneEvents.afterLeave(zone, creature)
		local player = creature:getPlayer()
		if not player then
			return
		end

		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Sweaty vapors of the training room leave your body. Your attack speed is back to normal.")
		player:setAttackSpeed(player:getVocation():getAttackSpeed())
	end
	zoneEvents:register()
end
trainRoomSetup:register()
