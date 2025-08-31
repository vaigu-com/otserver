--dialogs are in old system
local quest = Quest(LOCALIZERS.LiquidBlack)

quest
	:Storage(function()
		Storage.LiquidBlack = {
			Visitor = {},
			ShortcutAccess = {},
			ShortcutToOutside = {},
			ShortcutToInside = {},
		}
		QuestState.LiquidBlack = {
			FindUseForCoordinates = 1,
			TalkToMezamir = 2,
			MezamirLetYouUseShortcut = 3,
		}
	end)
	:Constant(function() end)
	:Questlog(function(localizer)
		table.insert(Quests, {
			name = "Liquid Black",
			localizer = localizer,
			missions = {
				{
					name = "Visitor",
					storage = Storage.LiquidBlack.Visitor,
					states = {
						[QuestState.LiquidBlack.FindUseForCoordinates] = "You have found notes and coordinates. Try to find out what they are for.",
						[QuestState.LiquidBlack.TalkToMezamir] = "You got teleported to Mezamir by a strange teleporter. Ask him about this machine.",
						[QuestState.LiquidBlack.MezamirLetYouUseShortcut] = "Mezamir let you dive into the place he tried to discover years ago. Find a large staircase heading underwater on Pirate Island and find out what's below.",
						[MISSION_FINISHED] = "You have found a shortcut to the deeplings' underwater base.",
					},
				},
			},
		})
	end)
	:Script(function()
		local insidePos = Position(33452, 31282, 14)
		local shortcutToInside = MoveEvent()
		function shortcutToInside.onStepIn(creature, item, fromPosition, target, toPosition, isHotkey)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			if player:getStorageValueByKey(Storage.LiquidBlack.ShortcutAccess) ~= ACCESS_GRANTED then
				return true
			end

			player:teleportTo(insidePos)
			return true
		end
		shortcutToInside:type("stepin")
		shortcutToInside:key(Storage.LiquidBlack.ShortcutToInside)
		shortcutToInside:register()

		local outsidePos = Position(6777, 2548, 4)
		local shortcutToOutside = MoveEvent()
		function shortcutToOutside.onStepIn(creature, item, fromPosition, target, toPosition, isHotkey)
			local player = creature:getPlayer()
			if not player then
				return true
			end

			if player:getStorageValueByKey(Storage.LiquidBlack.ShortcutAccess) ~= ACCESS_GRANTED then
				return true
			end

			player:teleportTo(outsidePos)
			return true
		end
		shortcutToOutside:type("stepin")
		shortcutToOutside:key(Storage.LiquidBlack.ShortcutToOutside)
		shortcutToOutside:register()
	end)
	:Register()
