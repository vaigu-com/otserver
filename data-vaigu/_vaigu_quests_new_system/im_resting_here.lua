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
	:Script(function(storageToRequiredState)
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
	:Script(function(storageToRequiredState)
		local coffinMessages = {
			[0] = "The lid of this coffin won't move at all.",
			[1] = "Doubling your efforts, you managed to move the lid a bit.",
			[2] = "Having noticed nearby crobar, you put it in cracks in the wood and try to pry it, but the very fragment of wood was rotten and broke off.",
			[3] = "You relocate crowbar to another crevice nad using all you strength, you broke off the lid.",
		}

		local updateStorages = {
			[Storage.ImRestingHere.Mission01] = 2,
		}

		local crowbar = Action()
		function crowbar.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			local missionState = player:getStorageValue(Storage.ImRestingHere.Mission01)
			if missionState < 1 then
				local translatedError =
					player:Localizer(Storage.ImRestingHere.Localizer):Get("It wont move without special crowbar.")
				player:say(translatedError, TALKTYPE_MONSTER_SAY)
				return false
			end

			if missionState > 1 then
				return false
			end

			local coffinState = player:getStorageValue(Storage.ImRestingHere.Coffin)
			local message = coffinMessages[coffinState]
			if message then
				local translatedMessage = player:Localizer(Storage.ImRestingHere.Localizer):Get(message)
				player:say(translatedMessage, TALKTYPE_MONSTER_SAY)
				return true
			end

			if
				player:TryTradeInItems(
					{ SPOCZYWAJACY_TUTAJ_KEY_ITEMS.crowbar },
					{ SPOCZYWAJACY_TUTAJ_KEY_ITEMS.lastWill }
				)
			then
				player:UpdateStorages(updateStorages)
			end
		end

		crowbar:aid(Storage.ImRestingHere.Coffin)
		crowbar:register()
	end)
