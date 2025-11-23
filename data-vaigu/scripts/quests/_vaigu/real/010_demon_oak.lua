local quest = Quest(LOCALIZERS.DemonOak)
local topics = {
	confirmBuyingAxe = 1,
}

quest
	:Storage(function()
		Storage.DemonOak = {
			Mission01 = {},
			Squares = {},
			KilledOak = {},

			AxeBlowsBird = {},
			AxeBlowsLeft = {},
			AxeBlowsRight = {},
			AxeBlowsFace = {},
		}
		QuestState.DemonOak = {
			Mission01 = {
				ReportEnteringToOldrak = 1,
				EnchantAxeAtOldrak_KillOak = 2,
				ReportOakKillToOldrak = 3,
				FindRewardChest = 4,
			},
		}
	end)
	:Constant(function()
		DEMON_OAK_POSITION = Position(6101, 1072, 7)
		DEMON_OAK_KICK_POSITION = Position(6101, 1061, 7)
		DEMON_OAK_ENTER_POSITION = Position(6101, 1068, 7)
		DEMON_OAK_REWARDROOM_POSITION = Position(6093, 1876, 8)

		QuestRewards.OutfitsAddons.DemonOak = {
			Demon3 = {
				{ outfitId = 542, addons = 3 },
				{ outfitId = 541, addons = 3 },
			},
		}
	end)
	:Questlog(function(localizer)
		table.insert(Questlog, {
			name = "Demon Oak",
			localizer = localizer,
			missions = {
				{
					name = "Demon Oak",
					storage = Storage.DemonOak.Mission01,
					states = {
						[QuestState.DemonOak.Mission01.ReportEnteringToOldrak] = "You have made your way into the den of Demon Oak. Try to find someone who will tell you more about it.",
						[QuestState.DemonOak.Mission01.EnchantAxeAtOldrak_KillOak] = "Oldrak gave you information regarding Demon Oak. He can bless an axe if you bring him one. The blessed axe should help you fight the Oak.",
						[QuestState.DemonOak.Mission01.ReportOakKillToOldrak] = "You defeated the Demon Oak! Report to Oldrak.",
						[QuestState.DemonOak.Mission01.FindRewardChest] = "You reported to Oldrak about your victory. You have been rewarded for your efforts: Oldrak told you a secret about the way to the Elvish treasury.",
						[MISSION_FINISHED] = "You found and took your reward for defeating The Demon Oak.",
					},
				},
			},
		})
	end)
	:Mission(Storage.DemonOak.Mission01)
	:State(function()
		return ANY_STATE,
			QuestFactory.Script(function()
				local questArea = {
					Position(6091, 1066, 7), --{x = 6091, y = 1066, z = 7}
					Position(6110, 1078, 7), --{x = 6110, y = 1078, z = 7}
				}

				local sounds = {
					"Release me and you will be rewarded greatefully!",
					"What is this? Demon Legs lying here? Someone might have lost them!",
					"I'm trapped, come here and free me fast!!",
					"I can bring your beloved back from the dead, just release me!",
					"What a nice shiny golden armor. Come to me and you can have it!",
					"Find a way in here and release me! Pleeeease hurry!",
					"You can have my demon set, if you help me get out of here!",
				}

				local globalevent = GlobalEvent("DemonOakVoices")
				function globalevent.onThink(...)
					local spectators, spectator = Game.getSpectators(DEMON_OAK_POSITION, false, true, 0, 15, 0, 15)
					local sound = sounds[math.random(#sounds)]
					for i = 1, #spectators do
						spectator = spectators[i]
						if isInRange(spectator:getPosition(), questArea[1], questArea[2]) then
							return true
						end

						spectator:say(sound, TALKTYPE_MONSTER_YELL, false, 0, DEMON_OAK_POSITION)
					end
					return true
				end

				globalevent:interval(10 * 60 * 1000) --10min
				globalevent:register()
			end)
	end)
	:State(function()
		return QuestState.DemonOak.Mission01.ReportEnteringToOldrak,
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
	end)
	:State(function()
		return QuestState.DemonOak.Mission01.EnchantAxeAtOldrak_KillOak,
			QuestFactory.Dialog("Oldrak", {
				[{ "mission", "demon oak", "misja", "demoniczny dab" }] = {
					text = "You better don't return here until you've defeated the Demon Oak. Perhaps you lost your {axe}?",
				},
				[{ "axe", "topor", "hallowed axe" }] = {
					text = "Ahh, you've got an axe. Very good. I can make a hallowed axe out of it. It will cost you... er... a donation of 1,000 gold. Alright?",
					nextTopic = topics.confirmBuyingAxe,
				},
				[{ "yes", "tak", "alright" }] = {
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

					if player:getStorageValueByKey(Storage.DemonOak.KilledOak) == 1 then
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

					local missionState = player:getStorageValueByKey(Storage.DemonOak.Mission01)
					if missionState == MISSION_NOT_STARTED then
						if player:getItemCount(9388) > 0 and #Game.getSpectators(DEMON_OAK_POSITION, false, true, 9, 9, 6, 6) == 0 then
							player:teleportTo(DEMON_OAK_ENTER_POSITION)
							player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
							player:setStorageValueByKey(Storage.DemonOak.Mission01, QuestState.DemonOak.Mission01.ReportEnteringToOldrak)
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
						totalProgress = totalProgress + math.max(0, player:getStorageValueByKey(v))
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
						player:setStorageValueByKey(Storage.DemonOak.Mission01, QuestState.DemonOak.Mission01.ReportOakKillToOldrak)
						player:setStorageValueByKey(Storage.DemonOak.KilledOak, 1)
						return true
					end

					local cStorage = config.storages[target.itemid]
					local progress = math.max(player:getStorageValueByKey(cStorage), 1)
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
					player:setStorageValueByKey(cStorage, progress + 1)
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
	end)
	:State(function()
		return QuestState.DemonOak.Mission01.ReportOakKillToOldrak,
			QuestFactory.Dialog("Oldrak", {
				[{ "mission", "demon oak", "misja", "demoniczny dab" }] = {
					text = "You chopped down the demon oak?!? Unbelievable!! Let's hope it doesn't come back. As long as evil is still existent in the soil of the plains, it won't be over. Still, the demons suffered a setback, that's for sure. ...\n\nFor your brave action, I tell you a secret which has been kept for many many years. There is an old cemetery in the south east from elvish court, far south from Mirko Town. There should be a grave with the name 'Grdhor Faelyn' somewhere. ...\n\nSomeone can gain the treasure hidden in there. I'm sure this 'someone' is you. Good luck in finding it!",
					nextState = {
						[Storage.DemonOak.Mission01] = QuestState.DemonOak.Mission01.FindRewardChest,
					},
					outfitRewards = QuestRewards.OutfitsAddons.DemonOak.Demon3,
				},
			})
	end)
	:State(function()
		return QuestState.DemonOak.Mission01.FindRewardChest,
			QuestFactory.Script(function(missionState)
				local gravestone = Action()
				function gravestone.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if player:isPzLocked() then
						return false
					end

					if player:getStorageValueByKey(Storage.DemonOak.Mission01) == QuestState.DemonOak.Mission01.FindRewardChest then
						player:teleportTo(DEMON_OAK_REWARDROOM_POSITION)
						DEMON_OAK_REWARDROOM_POSITION:sendMagicEffect(CONST_ME_TELEPORT)
						return true
					end
				end
				gravestone:uid(9007)
				gravestone:register()
			end)
	end)
	:Register()
