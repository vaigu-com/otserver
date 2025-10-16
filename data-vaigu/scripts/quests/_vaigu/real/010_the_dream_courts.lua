local quest = Quest(LOCALIZERS.TheDreamCourts)

quest
	:Storage(function() end)
	:Constant(function()
		QuestConstants.TheDreamCourts = {
			UnlockableWardstones = {
				Storage.Quest.U12_00.TheDreamCourts.WardStones.Knurow,
				Storage.Quest.U12_00.TheDreamCourts.WardStones.Desolation,
				Storage.Quest.U12_00.TheDreamCourts.WardStones.Syberia,
				Storage.Quest.U12_00.TheDreamCourts.WardStones.Caribbean,
				Storage.Quest.U12_00.TheDreamCourts.WardStones.OgreVillage,
				Storage.Quest.U12_00.TheDreamCourts.WardStones.BonebeastIsthmus,
				Storage.Quest.U12_00.TheDreamCourts.WardStones.DemonSkeletonCave,
				Storage.Quest.U12_00.TheDreamCourts.WardStones.PirateIsland,
			},
		}
		QuestKeyItems.TheDreamCourts = {
			DreamTalismanUntradeable = {
				id = ItemId.DREAM_TALISMAN,
				key = Storage.Quest.U12_00.TheDreamCourts.DreamTalisman,
			},
			DreamTalismanTradeable = {
				id = ItemId.DREAM_TALISMAN,
			},
		}
	end)
	:Questlog(function(localizer)
		table.insert(Questlog, {
			name = "The Dream Courts",
			localizer = localizer,
			missions = {
				{
					name = "The Dream Courts",
					storage = Storage.Quest.U12_00.TheDreamCourts.WardStones.Questline,
					states = {
						[1] = "Court legate asked you to charge eight wardstones that will weaken the Nightmare Beast. Look at your dream talisman to see which wardtones you already visited.",
						[2] = "You must kill the Nightmare Beast.",
						[3] = "By defeating the dreadful Nightmare Beast you did the Winter Court and the Summer Court alike a great favor. From now on, the dream elves will regard you as a friend.",
					},
				},
				{
					name = "Haunted House",
					storage = Storage.Quest.U12_00.TheDreamCourts.HauntedHouse.Questline,
					states = {
						[1] = "A tormented soul trusted you with the secret of this house. Reveal a hidden portal within!",
						[2] = "You have gained an access to the deepest mysteries of the dream courts. You can now activate ward stone and fight Faceless Bane.",
					},
				},
				{
					name = "The Keys",
					storage = Storage.Quest.U12_00.TheDreamCourts.TheSevenKeys.Questline,
					endValue = 2,
					states = {
						[1] = "Find all keys to unlock the Dream Doors.",
						[2] = "You found the keys to unlock the Dream Doors in the Labyrinth of Summer's and Winter's Dreams.",
					},
				},
			},
		})
	end)
	:Script(function()
		local lookEvent = Look()
		function lookEvent.onLook(player, item)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, player:Localizer(LOCALIZERS.TheDreamCourts):Get("DREAM_TALISMAN_STATUS"))
			return DONT_SHOW_ONLOOK
		end
		lookEvent:key(Storage.Quest.U12_00.TheDreamCourts.DreamTalisman)
		lookEvent:register()

		local unlitToLit = {
			[29336] = 29337,
			[29334] = 29335,
		}
		local function lightUpStoneTemporarily(item)
			local unlitId = item:getId()
			local litId = unlitToLit[unlitId]
			item:transform(litId)
			addEvent(function()
				item:transform(unlitId)
			end, 5000)
		end
		local actions_dreamTalisman = Action()
		function actions_dreamTalisman.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			local key = target:getKey()
			if player:getStorageValueByKey(key) == ACCESS_GRANTED then
				return
			end
			player:setStorageValueByKey(key, ACCESS_GRANTED)
			local currentCount = math.max(0, player:getStorageValueByKey(Storage.Quest.U12_00.TheDreamCourts.WardStones.Count))
			player:setStorageValueByKey(Storage.Quest.U12_00.TheDreamCourts.WardStones.Count, currentCount + 1)
			lightUpStoneTemporarily(target)
			return true
		end
		actions_dreamTalisman:key(Storage.Quest.U12_00.TheDreamCourts.DreamTalisman)
		actions_dreamTalisman:register()
	end)
	:Register()
