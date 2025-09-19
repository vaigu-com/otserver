local scope = Scope("TrainingRoom")
local wholeRoomZoneScope = scope:Get("WholeRoom")

local pseudoQuest = Quest(LOCALIZERS.NONE)
pseudoQuest
	:NoQuestlog()
	:Storage(function()
		Storage.TrainingRoom = {
			TeleportToInside = {},
			TeleportToOutside = {},
			LastEnterFromPos = {},
		}
	end)
	:Script(function()
		local trainingAttackSpeedReduction = 0.6
		local wholeRoomZone = Zone(wholeRoomZoneScope)
		local trainRoomSetup = GlobalEvent("TrainRoomSetup")
		function trainRoomSetup.onStartup()
			local zoneEvents = ZoneEvent(wholeRoomZone)
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
	end)
	:Script(function()
		local teleportToInside = MoveEvent()
		local playerSpawnPosition = Position(5818, 1511, 10)
		function teleportToInside.onStepIn(creature, item, position, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return
			end

			player:setStorageValueByKey(Storage.TrainingRoom.LastEnterFromPos, fromPosition)
			player:teleportTo(playerSpawnPosition)
			player:setDirection(DIRECTION_EAST)
			return true
		end
		teleportToInside:type("stepin")
		teleportToInside:key(Storage.TrainingRoom.TeleportToInside)
		teleportToInside:register()

		local teleportToOutside = MoveEvent()
		function teleportToOutside.onStepIn(creature, item, position, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return
			end

			player:teleportToStoredOrTemple(Storage.TrainingRoom.LastEnterFromPos, false)
			player:setDirection(DIRECTION_WEST)
			return true
		end
		teleportToOutside:type("stepin")
		teleportToOutside:key(Storage.TrainingRoom.TeleportToOutside)
		teleportToOutside:register()
	end)
	:Register()
