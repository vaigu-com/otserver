local quest = Quest("assassins_creed_squurvaali")
quest
	:Storage(function()
		Storage.AssassinsCreedSquurvaali = {
			Questline = NextStorage(),
			Mission01 = NextStorage(),
			Mission02 = NextStorage(),
			Mission03 = NextStorage(),
			Mission04 = NextStorage(),
			Mission05 = NextStorage(),
			GhostChair = NextStorage(),
			HeavenPath = NextStorage(),
			HeavenLastTile = NextStorage(),
			Rewards = { CartSilicon = NextStorage() },
			KeyItems = {
				Palette = NextStorage(),
				Flare = NextStorage(),
				Silicon = NextStorage(),
			},
		}
	end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Assassins's Creed: Squurva'ali",
			startStorageId = Storage.AssassinsCreedSquurvaali.Questline,
			startStorageValue = 1,
			missions = {
				[1] = {
					name = "The First Step to Heaven",
					storageId = Storage.AssassinsCreedSquurvaali.Mission01,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 4,
					states = {
						[1] = "You agreed to help the ghost of the princess. Maybe some clergyman in town can help you.",
						[2] = "Father Natanek told you where to find Oldrak. Maybe he can help you.",
						[3] = "Oldrak didn't provide you with a solution, but he mentioned a magical carpet. Return to the princess now.",
						[4] = "You consulted with the ghost of the princess, who suggested you find the nomads' camp.",
					},
				},
				[2] = {
					name = "The Tailor's Touch",
					storageId = Storage.AssassinsCreedSquurvaali.Mission02,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 5,
					states = {
						[1] = "The ghost of the princess suggested asking the nomads for help - after all, the Aladdin stereotype didn't come out of nowhere.",
						[2] = "The nomad craftsman agreed to make a carpet for you. You will need 5 spider silk, a red pillow, and the artist palette that GM Tomek stole.",
						[3] = "Complete the exorcism ritual with Ryan - blame it on Tomek.",
						[4] = "Ryan gave you the palette stolen by Tomek. Now take it to Mareesha and create the carpet. You will need 5 spider silk, a red pillow, and the artist palette that GM Tomek stole.",
						[5] = "You've crafted the carpet with Mareesha. Now return to the ghost and make further plans.",
					},
				},
				[3] = {
					name = "Distant Calling",
					storageId = Storage.AssassinsCreedSquurvaali.Mission03,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 3,
					states = {
						[1] = "You acquired a carpet that doesn't have any special abilities. You can return to the Ghasstly Princess.",
						[2] = "Ghasstly Princess insisted that you go to Wilson Tag for help.",
						[3] = "Wilson Tag said that Djinn can definitely perform miracles like enchanting a carpet.",
					},
				},
				[4] = {
					name = "Djinn's Ordeal",
					storageId = Storage.AssassinsCreedSquurvaali.Mission04,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 5,
					states = {
						[1] = "Wilson Tag directed you to the Djinn, who is located somewhere at the desert.",
						[2] = "The Djinn instructed you on where to find the smugglers' base. Try to find something there that might interest him.",
						[3] = "You found a box of wafers that Djinn mentioned. Return to him and ask for his help with your task.",
						[4] = "Djinn agreed to help with 'enchanting' the carpet. Now find the missing dead weight, and Djinn will do his job.",
						[5] = "You delivered the materials needed for 'enchanting' the carpet to Djinn. From now on, you will be able to fly from the highest mountain in the Caribbean.",
					},
				},
				[5] = {
					name = "The Final Stretch",
					storageId = Storage.AssassinsCreedSquurvaali.Mission05,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 5,
					states = {
						[1] = "Go to the top of the highest mountain in the Caribbean, get on the enchanted carpet, and...",
						[2] = "Standing in front of the cave, ignite the flare given to you by the guardian to help the ghost.",
						[3] = "You ignited the flare in front of the ghost's cave. In the meantime, have a conversation with the ghost.",
						[4] = "At the moment when the undead king of the crypt was about to finish you, an angel arrived who managed to avoid the traps and teleport you to safety. You don't know his or the king of the crypt's fate. Seek advice from Father Natanek.",
						[5] = "Father Natanek informed you about the dire consequences of the King of the Crypt victory.",
					},
				},
			},
		}
	end)
	:Script(function(storageToRequiredState)
		local path = MoveEvent()
		function path.onStepIn(player, item, toPosition, fromPosition)
			if not player:isPlayer() then
				return false
			end

			local storageVal = player:getStorageValue(Storage.AssassinsCreedSquurvaali.Mission05)
			local playerMount = player:getOutfit().lookMount
			if storageVal == 1 and playerMount == 689 then
				return true
			end

			player:teleportTo(fromPosition)
			player:getPosition():sendMagicEffect(CONST_ME_STUN)
			player:say(
				player
					:Localizer(Storage.AssassinsCreedSquurvaali.Localizer)
					:Get("A magical force brought you back to the solid ground."),
				TALKTYPE_MONSTER_SAY
			)
			return false
		end
		path:aid(Storage.AssassinsCreedSquurvaali.HeavenPath)
		path:register()

		local lastTile = MoveEvent()
		function lastTile.onStepIn(player, item, toPosition, fromPosition)
			if not player:isPlayer() then
				return false
			end
			-- ToDo: fix position after new map is added
			player:teleportTo(Position(5745, 801, 4), true)
			return true
		end
		lastTile:aid(Storage.AssassinsCreedSquurvaali.HeavenLastTile)
		lastTile:register()
	end)
	:Script(function(storageToRequiredState)
		local updateStorages = {
			[Storage.AssassinsCreedSquurvaali.Mission05] = 3,
		}

		local config = {
			["stand"] = "You have to be standing just outside the Ghasstly Princess's cave in order to use this flare.",
		}

		local flare = Action()

		function flare.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if item:getId() ~= ASSASSINS_CREED_SKURWOALA_KEY_ITEMS.flare.id then
				return false
			end

			local storageVal = player:getStorageValue(Storage.AssassinsCreedSquurvaali.Mission05)
			if storageVal ~= 2 then
				return false
			end

			local groundAid = Tile(player:getPosition()):getGround():getActionId()
			local itemAid = item:getActionId()
			if groundAid ~= itemAid then
				player:say(
					player:Localizer(Storage.AssassinsCreedSquurvaali.Localizer):Get(config["stand"]),
					TALKTYPE_MONSTER_SAY
				)
				return false
			end

			player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_RED)
			player:UpdateStorages(updateStorages)
			item:remove()
			return true
		end

		flare:aid(Storage.AssassinsCreedSquurvaali.KeyItems.Flare)
		flare:register()
	end)
	:Script(function(storageToRequiredState)
		local princess = { name = "Ghasstly Princess", pos = { x = 5682, y = 1408, z = 7 } }

		local chairIn = MoveEvent()

		function chairIn.onStepIn(player, item, fromPosition, target, toPosition, isHotkey)
			if not player:isPlayer() then
				return false
			end

			local storageVal = player:getStorageValue(Storage.AssassinsCreedSquurvaali.Mission05)

			if storageVal >= 5 then
				return false
			end
			local monster = Tile(princess.pos):getTopCreature()
			if monster then
				return false
			else
				Game.createNpc(princess.name, princess.pos)
			end
		end

		chairIn:aid(Storage.AssassinsCreedSquurvaali.GhostChair)
		chairIn:register()

		local chairOut = MoveEvent()

		function chairOut.onStepOut(player, item, fromPosition, target, toPosition, isHotkey)
			if not player:isPlayer() then
				return false
			end

			local monster = Tile(princess.pos):getTopCreature()
			if monster and not Tile(fromPosition):getTopCreature() then
				monster:remove()
				Position(princess.pos):sendMagicEffect(CONST_ME_TELEPORT)
			end
		end

		chairOut:aid(Storage.AssassinsCreedSquurvaali.GhostChair)
		chairOut:register()
	end)
