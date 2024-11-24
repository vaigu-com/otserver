local quest = Quest("resting_here")
quest
	:Storage(function()
		Storage.ImRestingHere = {
			Mission01 = NextStorage(),
			Coffin = NextStorage(),
			LastWill = NextStorage(),
			Corpse = NextStorage(),
		}
	end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Im Resting Here",
			startStorageId = Storage.ImRestingHere.Localizer,
			startStorageValue = 1,
			missions = {
				[1] = {
					name = "A Work to Screw up",
					storageId = Storage.ImRestingHere.Mission01,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 4,
					states = {
						[1] = "Grave digger gave you a special crowbar. Try to find a use for it.",
						[2] = "You found some kind of last will. Try to find the item mentioned in it.",
						[3] = "You found a document that indicates that four people broke into the labyrinth. At least two of them are no longer alive. Try to find one of the survivors.",
						[4] = "You found out what happened to one of the survivors.",
					},
				},
			},
		}
	end)
	:Mission()
	:State(QUEST_NOT_STARTED)
	:Dialog("Grave Digger", {
		[{ "mission", "misja" }] = {
			text = "Lately, the well-known businessman Bildo Debicki was buried in the southern cemetery. To honor his passing, I've decided to do something good for the residents of this city and introduce a promotion on {crowbars}. This conversation does not constitute incitement to a crime under the criminal code. The price of one such item is 10 gold pieces.",
		},
		[{ "lom", "lomy", "crowbar", "crowbars" }] = {
			text = "You want to buy special crowbar? It will cost you 10gp. If you were to pry open a lid (like the lid of a can), just click on it. No need to use crowbar - hence its called special.",
		},
		[{ "yes", "tak" }] = {
			text = "Here you are.",
			nextState = {
				[Storage.ImRestingHere.Mission01] = 1,
				[Storage.ImRestingHere.Coffin] = 1,
			},
			requiredMoney = 10,
			textNoRequiredMoney = "What?! Its only 10gps.",
		},
	})
	:State()
	:Script(function(missionState)
		local coffinMessages = {
			[1] = "The lid of this coffin won't move at all.",
			[2] = "Doubling your efforts, you managed to move the lid a bit.",
			[3] = "Having noticed nearby crobar, you put it in cracks in the wood and try to pry it, but the very fragment of wood was rotten and broke off.",
			[4] = "You relocate crowbar to another crevice nad using all you strength, you broke off the lid.",
		}

		local updateStorages = {
			[Storage.ImRestingHere.Mission01] = 2,
		}

		local crowbar = Action()
		function crowbar.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			local targetId = item:getId()
			if targetId == 2476 or targetId == 2477 then
				local translatedError = player:Localizer(Storage.ImRestingHere.Localizer):Get("It wont move without special crowbar.")
				player:say(translatedError, TALKTYPE_MONSTER_SAY)
			end

			if not player:HasExactMissionState(missionState) then
				return true
			end

			local coffinState = player:getStorageValue(Storage.ImRestingHere.Coffin)
			if coffinState > #coffinMessages then
				if player:TryTradeInItems({ SPOCZYWAJACY_TUTAJ_KEY_ITEMS.crowbar }, { SPOCZYWAJACY_TUTAJ_KEY_ITEMS.lastWill }) then
					player:UpdateStorages(updateStorages)
				end
				return
			end

			local message = coffinMessages[coffinState]
			local translatedMessage = player:Localizer(Storage.ImRestingHere.Localizer):Get(message)
			player:say(translatedMessage, TALKTYPE_MONSTER_SAY)
			player:setStorageValue(Storage.ImRestingHere.Coffin, coffinState + 1)
			return true
		end

		crowbar:aid(Storage.ImRestingHere.Coffin)
		crowbar:register()
	end)
	:Script(function(missionState)
		local updateStorages = {
			[Storage.ImRestingHere.Mission01] = 3,
		}

		local coffin = Action()

		function coffin.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			local storageVal = player:getStorageValue(Storage.ImRestingHere.Mission01)
			if storageVal ~= 2 then
				return false
			end
			if player:TryAddItems({ SPOCZYWAJACY_TUTAJ_KEY_ITEMS.torch, SPOCZYWAJACY_TUTAJ_KEY_ITEMS.contract }) then
				player:UpdateStorages(updateStorages)
				player:addOutfit(574)
				player:addOutfit(575)
				player:AddExperienceWithAnnouncement(30000)
				player:getPosition():sendMagicEffect(CONST_ME_STUN)
			end
			return false
		end

		coffin:aid(Storage.ImRestingHere.Corpse)
		coffin:register()
	end)
