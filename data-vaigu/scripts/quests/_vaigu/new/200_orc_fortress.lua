local quest = Quest(LOCALIZERS.NONE)

quest
	:Storage(function()
		Storage.OrcFortress = {
			DoorAccess = {},
			GrantDoorAccess = {},
		}
	end)
	:NoQuestlog()
	:Script(function()
		local circleTile = MoveEvent()
		function circleTile.onStepIn(player, item, toPosition, fromPosition)
			if not player:isPlayer() then
				return false
			end

			player:setStorageValueByKey(Storage.OrcFortress.DoorAccess, ACCESS_GRANTED)
		end
		circleTile:key(Storage.OrcFortress.GrantDoorAccess)
		circleTile:type("stepin")
		circleTile:register()
	end)
	:Register()
