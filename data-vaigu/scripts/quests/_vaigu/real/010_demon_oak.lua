local quest = Quest(LOCALIZERS.DemonOak)
local topics = {
	confirmBuyingAxe = 1,
}

quest
	:Storage(function()
		Storage.DemonOak = {
			Mission01 = 1012,
			Squares = 1013,
			KilledOak = 1014,

			AxeBlowsBird = 1015,
			AxeBlowsLeft = 1016,
			AxeBlowsRight = 1017,
			AxeBlowsFace = 1018,
		}
		QuestState.DemonOak = {
			Mission01 = {
				EnteredOak_ReportToOldrak = 1,
				EnchantAxeAtOldrak_KillOak = 2,
				KilledOak_Report_ToOldrak = 3,
				FindRewardChest = 4,
			},
		}
	end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Demon Oak",
			missions = {
				[Storage.DemonOak.Mission01] = {
					name = "Demon Oak",
					states = {
						[QuestState.DemonOak.Mission01.EnteredOak_ReportToOldrak] = "You have made your way into the den of Demon Oak. Try to find someone who will tell you more about it.",
						[QuestState.DemonOak.Mission01.EnchantAxeAtOldrak_KillOak] = "Oldrak gave you information regarding Demon Oak. He can bless an axe if you bring him one. The blessed axe should help you fight the Oak.",
						[QuestState.DemonOak.Mission01.KilledOak_Report_ToOldrak] = "You defeated the Demon Oak! Report to Oldrak.",
						[QuestState.DemonOak.Mission01.FindRewardChest] = "You reported to Oldrak about your victory. You have been rewarded for your efforts: Oldrak told you a secret about the way to the Elvish treasury.",
						[MISSION_FINISHED] = "You found and took your reward for defeating The Demon Oak.",
					},
				},
			},
		}
	end)
	:Mission(Storage.DemonOak.Mission01)
:State(
function()
return 
		QuestState.DemonOak.Mission01.EnteredOak_ReportToOldrak,
		QuestFactory.Dialog("Oldrak", {
			[{ "mission", "demon oak", "misja", "demoniczny dab" }] = {
				text = "How do you know? Did you go into the infested area?",
			},
			[{ "yes", "tak" }] = {
				text = "A demon oak?!? <mumbles some blessings> May the gods be on our side. You'll need a {hallowed axe} to harm that tree. Bring me a simple {axe} and I'll prepare it for you.",
				nextState = {
					[Storage.DemonOak.Mission01] = QuestState.DemonOak.Mission01.EnchantAxeAtOldrak_KillOak,
				},
			},
		})

end
):State(
function()
return 
		QuestState.DemonOak.Mission01.EnchantAxeAtOldrak_KillOak,
		QuestFactory.Dialog("Oldrak", {
			[{ "mission", "demon oak", "misja", "demoniczny dab" }] = {
				text = "You better don't return here until you've defeated the Demon Oak. Perhaps you lost your {axe}?",
			},
			[{ "axe", "topor" }] = {
				text = "Ahh, you've got an axe. Very good. I can make a hallowed axe out of it. It will cost you... er... a donation of 1,000 gold. Alright?",
				nextTopic = topics.confirmBuyingAxe,
			},
			[{ "yes", "tak" }] = {
				text = "Let's see....<mumbles a prayer>....here we go. The blessing on this axe will be absorbed by all the demonic energy around here. I presume it will not last very long, so better hurry. Actually, I can refresh the blessing as often as you like.",
				requiredTopic = topics.confirmBuyingAxe,
				requiredMoney = 1000,
				requiredItems = {
					{ id = 3274 },
				},
				textNoRequiredItems = "You dont have an axe.",
				rewards = {
					{ id = 919 },
				},
				specialActionsOnSuccess = {
					{
						action = SPECIAL_ACTIONS_UNIVERSAL.sendMagicEffectNpc,
						effect = CONST_ME_YELLOWENERGY,
					},
				},
			},
			[{ "no", "nie" }] = {
				text = "What a pity! Let me know when you managed to get in there. Maybe I can help you when we know what we are dealing with.",
			},
		}),
		QuestFactory.Script(function(missionState)
			local movement = MoveEvent()

			function movement.onStepIn(creature, item, toPosition, fromPosition)
				local player = creature:getPlayer()
				if not player then
					return true
				end

				if player:getStorageValue(Storage.DemonOak.KilledOak) == 1 then
					player:teleportTo(DEMON_OAK_KICK_POSITION)
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					return true
				end

				if player:getLevel() < 120 then
					player:say("HAHA, NIE JESTES TEGO WART!", TALKTYPE_MONSTER_YELL, false, player, DEMON_OAK_POSITION)
					player:teleportTo(DEMON_OAK_KICK_POSITION)
					player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
					return true
				end

				local missionState = player:getStorageValue(Storage.DemonOak.Mission01)
				if missionState == MISSION_NOT_STARTED then
					if player:getItemCount(9388) > 0 and #Game.getSpectators(DEMON_OAK_POSITION, false, true, 9, 9, 6, 6) == 0 then
						player:teleportTo(DEMON_OAK_ENTER_POSITION)
						player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
						player:setStorageValue(Storage.DemonOak.Mission01, QuestState.DemonOak.Mission01.EnteredOak_ReportToOldrak)
						player:removeItem(9388, 1)

						player:say("OCZEKIWALEM CIE! CHODZ TU A DOSTANIESZ CZEGO CHCIALES!", TALKTYPE_MONSTER_YELL, false, player, DEMON_OAK_POSITION)
					end
					return true
				end
				if missionState == QuestState.DemonOak.Mission01.EnchantAxeAtOldrak_KillOak then
					if #Game.getSpectators(DEMON_OAK_POSITION, false, true, 9, 9, 6, 6) == 0 then
						player:teleportTo(DEMON_OAK_ENTER_POSITION)
						player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)

						player:say("OCZEKIWALEM CIE! CHODZ TU A DOSTANIESZ CZEGO CHCIALES!", TALKTYPE_MONSTER_YELL, false, player, DEMON_OAK_POSITION)
					end
					return
				end

				player:teleportTo(DEMON_OAK_KICK_POSITION)
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				return true
			end

			movement:type("stepin")
			movement:uid(9000)
			movement:register()
		end),
		QuestFactory.Script(function(missionState)
			local config = {
				demonOakIds = { 914, 915, 916, 917 },
				sounds = {
					"MOJE KORZENIE SA OSTRE JAK POEZJA BYWA BRZECHWY ! CZUJESZ TO !?",
					"PRZEKLINAM CIE!",
					"POWSTANCIE MOJE MINIONY, POWSTANCIE Z ZASWIATOW!!!!",
					"AHHHH! TWOJA KREW TYLKO MNIE WZMACNIA!",
					"BIERZ ICH, BIERZ ICH SZARIK!!",
					"NIE UCIEKAJ, I TAK CIE DOPADNE!!!",
					"CZEKA CIE NIEWYOBRAZALNE CIERPIENIE !!",
					"MASZ ZAMIAR PLACIC ZA TEN BOL ?! CZEKA CIE WYSOKI RACHUNEK",
					"ARGG! NIE ZABIJAJCIE !!, NIECH ZDYCHA W MECZARNIACH !!",
				},
				bonebeastChance = 90,
				bonebeastCount = 4,
				waves = 10,
				questArea = {
					fromPosition = { x = 6091, y = 1066, z = 7 },
					toPosition = { x = 6110, y = 1078, z = 7 },
				},
				summonPositions = {
					{ x = 6099, y = 1069, z = 7 },
					{ x = 6097, y = 1070, z = 7 },
					{ x = 6096, y = 1072, z = 7 },
					{ x = 6098, y = 1075, z = 7 },
					{ x = 6101, y = 1075, z = 7 },
					{ x = 6104, y = 1075, z = 7 },
					{ x = 6106, y = 1072, z = 7 },
					{ x = 6104, y = 1069, z = 7 },
				},
				summons = {
					[914] = {
						[5] = { "Braindeath", "Braindeath", "Braindeath", "Bonebeast" },
						[10] = { "Betrayed Wraith", "Betrayed Wraith" },
					},
					[915] = {
						[5] = { "Lich", "Lich", "Lich" },
						[10] = { "Dark Torturer", "Blightwalker" },
					},
					[916] = {
						[5] = { "Banshee", "Banshee", "Banshee" },
						[10] = { "Grim Reaper" },
					},
					[917] = {
						[5] = { "Giant Spider", "Giant Spider", "Lich" },
						[10] = { "Undead Dragon", "Hand of Cursed Fate" },
					},
				},
				storages = {
					[914] = Storage.DemonOak.AxeBlowsBird,
					[915] = Storage.DemonOak.AxeBlowsLeft,
					[916] = Storage.DemonOak.AxeBlowsRight,
					[917] = Storage.DemonOak.AxeBlowsFace,
				},
			}

			local function getRandomSummonPosition()
				return config.summonPositions[math.random(#config.summonPositions)]
			end
			local action = Action()
			function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				if not isInArray(config.demonOakIds, target.itemid) then
					return true
				end

				local totalProgress = 0
				for k, v in pairs(config.storages) do
					totalProgress = totalProgress + math.max(0, player:getStorageValue(v))
				end

				local spectators, hasMonsters = Game.getSpectators(DEMON_OAK_POSITION, false, false, 9, 9, 6, 6), false
				for i = 1, #spectators do
					if spectators[i]:isMonster() then
						hasMonsters = true
						break
					end
				end

				local isDefeated = totalProgress == (#config.demonOakIds * (config.waves + 1))
				if (config.killAllBeforeCut or isDefeated) and hasMonsters then
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Najpierw pokonaj wszystkie potwory.")
					return true
				end

				if isDefeated then
					player:teleportTo(DEMON_OAK_KICK_POSITION)
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Powiedz Oldrakowi o swoim wielkim zwyciestwie przeciw Debowi.")
					player:setStorageValue(Storage.DemonOak.Mission01, QuestState.DemonOak.KilledOak_Report_ToOldrak)
					player:setStorageValue(Storage.DemonOak.KilledOak, 1)
					return true
				end

				local cStorage = config.storages[target.itemid]
				local progress = math.max(player:getStorageValue(cStorage), 1)
				if progress >= config.waves + 1 then
					toPosition:sendMagicEffect(CONST_ME_POFF)
					return true
				end

				local isLastCut = totalProgress == (#config.demonOakIds * (config.waves + 1) - 1)
				local summons = config.summons[target.itemid]
				if summons and summons[progress] then
					-- Summon a single demon on the last hit
					if isLastCut then
						Game.createMonster("Demon", getRandomSummonPosition(), false, true)

						-- Summon normal monsters otherwise
					else
						for i = 1, #summons[progress] do
							Game.createMonster(summons[progress][i], getRandomSummonPosition(), false, true)
						end
					end

					-- if it is not the 5th or 10th there is only a chance to summon bonebeasts
				elseif math.random(100) >= config.bonebeastChance then
					for i = 1, config.bonebeastCount do
						Game.createMonster("Bonebeast", getRandomSummonPosition(), false, true)
					end
				end

				player:say(isLastCut and "JAK TO MOZLIWE?!? MOJ PAN CIE ZNISZCZY!! AHRRGGG!" or config.sounds[math.random(#config.sounds)], TALKTYPE_MONSTER_YELL, false, player, DEMON_OAK_POSITION)
				toPosition:sendMagicEffect(CONST_ME_DRAWBLOOD)
				player:setStorageValue(cStorage, progress + 1)
				player:say("-krrrrak-", TALKTYPE_MONSTER_YELL, false, player, toPosition)
				doTargetCombatHealth(0, player, COMBAT_EARTHDAMAGE, -170, -210, CONST_ME_BIGPLANTS)
				return true
			end
			action:id(919)
			action:register()
		end),
		QuestFactory.Script(function(missionState)
			local movement = MoveEvent()

			function movement.onStepIn(creature, item, toPosition, fromPosition)
				local player = creature:getPlayer()
				if not player then
					return true
				end

				if math.random(24) == 1 then
					doTargetCombatHealth(0, player, COMBAT_EARTHDAMAGE, -270, -310, CONST_ME_BIGPLANTS)
				end
				return true
			end

			movement:type("stepin")
			movement:id(918)
			movement:register()
		end)

end
):State(
function()
return 
		QuestState.DemonOak.Mission01.KilledOak_Report_ToOldrak,
		QuestFactory.Dialog("Oldrak", {
			[{ "mission", "demon oak", "misja", "demoniczny dab" }] = {
				text = "You chopped down the demon oak?!? Unbelievable!! Let's hope it doesn't come back. As long as evil is still existent in the soil of the plains, it won't be over. Still, the demons suffered a setback, that's for sure. ...\n\nFor your brave action, I tell you a secret which has been kept for many many years. There is an old cemetery in the south east from elvish court, far south from Mirko Town. There should be a grave with the name 'Grdhor Faelyn' somewhere. ...\n\nSomeone can gain the treasure hidden in there. I'm sure this 'someone' is you. Good luck in finding it!",
				nextState = {
					[Storage.DemonOak.Mission01] = QuestState.DemonOak.Mission01.FindRewardChest,
				},
				outfitRewards = {
					{ outfitId = 542, addon = 2 },
					{ outfitId = 541, addon = 2 },
				},
			},
		})

end
):State(
function()
return 
		QuestState.DemonOak.Mission01.FindRewardChest,
		QuestFactory.Script(function(missionState)
			local chests = {
				[9008] = { itemid = 3389, count = 1 },
				[9009] = { itemid = 8077, count = 1 },
				[9010] = { itemid = 14768, count = 1 },
				[9011] = { itemid = 14769, count = 1 },
			}

			local action = Action()

			function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				if chests[item.uid] then
					if player:getStorageValue(Storage.DemonOak.Mission01) ~= QuestState.DemonOak.Mission01.FindRewardChest then
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "It's empty.")
						return true
					end

					local chest = chests[item.uid]
					local itemType = ItemType(chest.itemid)
					if itemType then
						local article = itemType:getArticle()
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found " .. (#article > 0 and article .. " " or "") .. itemType:getName() .. ".")
					end

					player:addItem(chest.itemid, chest.count)
					player:setStorageValue(Storage.DemonOak.Mission01, MISSION_FINISHED)
					player:setStorageValue(Storage.Finished.DemonOak, MISSION_FINISHED)
				end

				return true
			end

			action:uid(9008, 9009, 9010, 9011)
			action:register()
		end),
		QuestFactory.Script(function(missionState)
			local action = Action()

			function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				if player:getStorageValue(Storage.DemonOak.Mission01) == QuestState.DemonOak.Mission01.FindRewardChest then
					player:teleportTo(DEMON_OAK_REWARDROOM_POSITION)
					DEMON_OAK_REWARDROOM_POSITION:sendMagicEffect(CONST_ME_TELEPORT)
					return true
				end
			end
			action:uid(9007)
			action:register()
		end)

end
)	:Register()
