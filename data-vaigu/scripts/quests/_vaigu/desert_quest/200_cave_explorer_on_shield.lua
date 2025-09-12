local quest = Quest(LOCALIZERS.CaveExplorerOnShield)

quest
	:Storage(function()
		Storage.CaveExplorerOnShield = {
			Mission01 = {},
			Firebug = {},
			GermiChest = {},
			GermIDocument = {},
			AnthonyGate = {},
			Punchcard = {},
			Fireplace = {},
			Frostplace = {},
			GermiCorpse = {},
		}
		QuestState.CaveExplorerOnShield = {
			Mission01 = {
				FindThePage = 1,
				ShowPageToGermi = 2,
				TalkToGermiAboutDoor = 3,
				FindAndHelpEngineer = 4,
				ReportToEngineer = 5,
				ReportToGermi = 6,
			},
		}
		QuestTopics.CaveExplorerOnShield = {
			ConfirmAnthonyIsAlive = NextTopic(),
			AskForPuzzle = NextTopic(),
		}
	end)
	:Constant(function()
		QuestKeyItems.CaveExplorerOnShield = {
			Firebug = {
				id = 5467,
				key = Storage.CaveExplorerOnShield.Firebug,
				desc = "Desert ruins dead adventurer's firebug",
			},
			GermiDocument = {
				id = 2815,
				text = "(Torn page fragment) This damned place is overflowing with traps. Some devilish forces wish my life to meet a demise! Today I nearly slipped into a pit of fire. But there are also a lot of hints placed all over in the strangest of places. Looks like those are addressed to other adventurers like me and Anthony. Some of them don't seem to be created by humans. Don't trust them.",
				key = Storage.CaveExplorerOnShield.GermIDocument,
			},
			Punchcard = {
				id = 4842,
				key = Storage.CaveExplorerOnShield.Punchcard,
				desc = "A punchcard for opening mechanical doors",
			},
		}
	end)
	:Questlog(function(localizer)
		table.insert(Quests, {
			name = "Cave Explorer on Shield",
			localizer = localizer,
			missions = {
				{
					name = "First Mission",
					storage = Storage.CaveExplorerOnShield.Mission01,
					states = {
						[QuestState.CaveExplorerOnShield.Mission01.FindThePage] = "Find the journal page.",
						[QuestState.CaveExplorerOnShield.Mission01.ShowPageToGermi] = "You found the page. Show it to Germi.",
						[QuestState.CaveExplorerOnShield.Mission01.TalkToGermiAboutDoor] = "Talk to Germi to get him to open the door for you.",
						[QuestState.CaveExplorerOnShield.Mission01.FindAndHelpEngineer] = "Find the Engineer's Ghost and help him.",
						[QuestState.CaveExplorerOnShield.Mission01.ReportToEngineer] = "You've opened the gate, return to the Engineer.",
						[QuestState.CaveExplorerOnShield.Mission01.ReportToGermi] = "You greeted the Engineer, return to Germi.",
						[MISSION_FINISHED] = "Mission completed.",
					},
				},
			},
		})
	end)
	:Mission(Storage.CaveExplorerOnShield.Mission01)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.OnUseDeclarations({
				{ id = 4241, key = Storage.CaveExplorerOnShield.GermiCorpse, rewards = { QuestKeyItems.CaveExplorerOnShield.Firebug } },
			}),
			QuestFactory.Script(function(missionState)
				local function movePlayersFromArea(topLeft, downRight, safePos)
					CreatureList():Area(topLeft, downRight):FilterByPlayer():MovedToPos(safePos)
				end

				local topLeft = DESERT_QUEST_ONE_ANCHOR:Moved({ x = -42, y = 55, z = 3 })
				local downRight = DESERT_QUEST_ONE_ANCHOR:Moved({ x = -26, y = 72, z = 3 })
				local passage_pos = DESERT_QUEST_ONE_ANCHOR:Moved({ x = -26, y = 67, z = 3 })
				local portal_pos = DESERT_QUEST_ONE_ANCHOR:Moved({ x = -33, y = 60, z = 3 })

				local litFrostplaceId = 22077
				local function tryUseFrozenFireplace(frostplace)
					local unlitId = frostplace:getId()
					frostplace:transform(litFrostplaceId)

					local tile = Tile(passage_pos)
					if tile:getItemById(2129) then
						tile:getItemById(2129):remove()
					else
						return false
					end

					local start = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_PORTALS[Storage.DesertQuestOne.Portals.IceRoomStart])
					movePlayersFromArea(topLeft, downRight, start)

					local portal = Game.createItem(1949, 1, portal_pos)
					portal:setKey(Storage.DesertQuestOne.Portals.IceRoomReward)

					addEvent(function()
						frostplace:transform(unlitId)
					end, 1000 * 28)

					addEvent(function()
						passage_pos:MoveThings(start)
						movePlayersFromArea(topLeft, downRight, start)
						portal:remove()
						Game.createItem(2129, 1, passage_pos)
					end, 1000 * 30)

					return true
				end

				local ghostName = "Ghost of Germi the Journeyman"
				local ghostPos = DESERT_QUEST_ONE_ANCHOR:Moved({ x = 82, y = 52, z = -2 })
				local floorEffect = 8827
				local litFireplaceId = 22076
				local function tryUseGermiFireplace(fireplace)
					local unlitId = fireplace:getId()
					fireplace:transform(litFireplaceId)

					local npc = Game.createNpc(ghostName, ghostPos)

					local floorEffectItem = Game.createItem(floorEffect, 1, ghostPos)
					floorEffectItem:setUniqueId(1000)

					addEvent(function()
						npc:remove()
						floorEffectItem:remove()
						fireplace:transform(unlitId)
						fireplace:setKey(Storage.CaveExplorerOnShield.Fireplace)
					end, 1000 * 120 * 2)

					return true
				end

				local firebug = Action()
				function firebug.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					local targetKey = target:getKey()
					if targetKey == Storage.CaveExplorerOnShield.Fireplace then
						tryUseGermiFireplace(target)
					elseif targetKey == Storage.CaveExplorerOnShield.Frostplace then
						tryUseFrozenFireplace(target)
					end

					return true
				end

				firebug:key(Storage.CaveExplorerOnShield.Firebug)
				firebug:register()
			end),
			QuestFactory.Dialog("Ghost of Germi the Journeyman", {
				[{ GREET }] = { text = "Ouhhh..." },
				[{ ANY_MESSAGE }] = {
					text = "Who are You?",
					requiredTopic = TOPIC_DEFAULT,
					nextTopic = 1,
				},
				[{ ANY_MESSAGE }] = {
					text = "Aaaaahhhhh... Beat it!",
					requiredTopic = 1,
					nextTopic = 2,
				},
				[{ ANY_MESSAGE }] = {
					text = "Who am I? What is going on? I can't recall anything!",
					requiredTopic = 2,
					nextTopic = 3,
				},
				[{ ANY_MESSAGE }] = {
					text = "I am... Who...? What...? I.. am dead?",
					requiredTopic = 3,
					nextTopic = 4,
				},
				[{ ANY_MESSAGE }] = {
					text = "I was there - searching for something? Some item? I don't remember...",
					requiredTopic = 4,
					nextTopic = 5,
				},
				[{ ANY_MESSAGE }] = {
					text = "We are in some form of camp. It was a camp... of mine! There has to be something that will help me recall. Find something... anything... Tell me who I was... Look around... Find something that belonged to me. Will you help me? Please!",
					requiredTopic = 5,
					nextTopic = 5,
				},
				[{ "yes", "tak" }] = {
					text = "Thank you.. thanks...",
					requiredTopic = 5,
					nextState = {
						[Storage.CaveExplorerOnShield.Mission01] = QuestState.CaveExplorerOnShield.Mission01.FindThePage,
					},
					specialActionsOnSuccess = {
						{
							action = SPECIAL_ACTIONS_UNIVERSAL.sendMagicEffectPlayer,
						},
					},
				},
			})
	end)
	:State(function()
		return QuestState.CaveExplorerOnShield.Mission01.FindThePage,
			QuestFactory.Dialog("Ghost of Germi the Journeyman", { [{ GREET }] = {
				text = "Please come back with something of mine.",
			} }),
			QuestFactory.OnUseDeclarations({
				{
					id = 2484,
					key = Storage.CaveExplorerOnShield.GermiChest,

					nextState = { [Storage.CaveExplorerOnShield.Mission01] = QuestState.CaveExplorerOnShield.Mission01.ShowPageToGermi },
					rewards = { QuestKeyItems.CaveExplorerOnShield.GermiDocument },
				},
			})
	end)
	:State(function()
		return QuestState.CaveExplorerOnShield.Mission01.ShowPageToGermi,
			QuestFactory.Dialog("Ghost of Germi the Journeyman", {
				[{ GREET }] = { text = "Have you found anything yet?" },
				[{ "mission" }] = {
					text = "Have you found anything yet?",
					nextTopic = 0,
				},
				[{ "yes", "tak" }] = {
					text = "What is that... That looks like my writing... I am remembering now... Yes, I remember! I was an adventurer, and our camp was built there. My memories... They are coming back! Do you... also are up to something in this place? You are the first living human being that I encountered after my... death. I have so much to say. Do you want to listen to my {story}?",
					requiredItems = { QuestKeyItems.CaveExplorerOnShield.GermiDocument },
					removeRequiredItems = false,
					textNoRequiredItems = "Please come back with something of mine.",
				},
				[{ "story", "historie" }] = {
					text = "In the past I was an adventurer, down for treasure and fame. Over the years of exploring caves I gained ground in my profession, until.... I and my {team} encountered this dungeon. I would try to talk you out of delving here, but alas I already know you won't listen. At least to listen to what I have for you. I might give you few {directions}.",
					nextState = {
						[Storage.CaveExplorerOnShield.Mission01] = QuestState.CaveExplorerOnShield.Mission01.TalkToGermiAboutDoor,
					},
					specialActionsOnSuccess = {
						{
							action = SPECIAL_ACTIONS_UNIVERSAL.sendMagicEffectPlayer,
						},
					},
				},
				[{ ANY_MESSAGE }] = {
					text = "Please come back with something of mine.",
				},
			})
	end)
	:State(function()
		return QuestState.CaveExplorerOnShield.Mission01.TalkToGermiAboutDoor,
			QuestFactory.Dialog("Ghost of Germi the Journeyman", {
				[{ GREET }] = {
					text = "In the past I was an adventurer, down for treasure and fame. Over the years of exploring caves I gained ground in my profession, until.... I and my {team} encountered this dungeon. I would try to talk you out of delving here, but alas I already know you won't listen. At least to listen to what I have for you. I might give you few {directions}.",
				},
				[{ "towarzyszami", "team" }] = {
					text = "I remember that i didn't come here alone. I was there with  my fellow {team}. If you ever encounter any of them, will you send my regards?.",
				},
				[{ "yes", "tak" }] = { text = "Thanks in advance. I owe you." },
				[{ "wskazowek", "directions" }] = {
					text = "When I wandered those tunnels, I encountered many hints, probably left by other daredevils when they were still alive or... undead. Some of them were scribblings written on letters, book pages or anything that was probably at hand. Some of them were also written on wooden, metal signs and on gravestones. Some of them were really helpful but others... not so much. Their only purpose was to divert us from the correct path. I fear that these signs were left there by something of malicious nature - the {phantasms}. I took my time to study and analyze this place and the hints left there. The results are in my {journal}.",
				},
				[{ "phantasms", "phantasmy" }] = {
					text = "Long time ago, they made their home in one of the surface pyramids. Recently something is attracting them there. Phantasms can understand human language therefore they can forge their own hints and use them to allure adventurers into traps inside this dungeon. Once their victim is dead, they can feast on their souls. Furthermore, thanks to their psychic powers they can control other beings. Have that in mind before you {trust} anyone here.",
				},
				[{ "dzienniku", "journal" }] = {
					text = "Alas, not being able to find the treasures i desire, i started to lose my way inside those tunnels. My journal has been torn away from me, and ripped apart into pieces. Then these pieces were spread, all around the place. I'm sure that there are {pages} from the journal that still remain intact. Please keep an eye out for those - without them you are doomed!",
				},
				[{ "strony", "pages" }] = {
					text = "On these pages I left information about traps, hints and their authors. There are so many hints already and I suspect that phantasms were making even more of them when I was there. Therefore you won't find information on every trap inside, but rather a general view on the other people and hints. Remember not to trust all of those. Only by wielding the information in my journal can you determine whether the information is {truthful} or not. If you are wondering if my journal pages can be manipulated, there is no way they would be able to {forge} my handwriting.",
				},
				[{ "zaufasz", "trust" }] = {
					text = "Certainly you are wondering whether you can trust me. Whether I was already possessed by phantasms. I would like to prove that I'm myself, but I don't know how to achieve it. You have to decide for yourself, whether you trust me or not - the decision is yours. I can only assure you, that soon you will see about me... hope its not gonna be too late for you.",
				},
				[{ "prawdziwa", "truthful" }] = {
					text = "Unfortunately, I've been in an undead ghost state since some time ago and I don't remember most of my research. One person I'm currently sure about being trustworthy is Miroslaw - adventurer of Ankhar. Alas, I can't recall anything else. If you're gonna delve into this dungeon, you will certainly find notes from my journal that will guide you. Now I advised you with all essential information I had and my conscience is clear. Now i can help you with moving through that {passage}.",
				},
				[{ "podrobione", "forged" }] = {
					text = "There is no way that phantasms can forge my journal, because they cannot recreate others' handwriting. This task would prove difficult for a human let alone a phantasm, who are relatively new to the concept of writing. I saw one of my journal pages not that far behind the door. You can read it and confirm how my handwriting looks, so you can know which pages are genuine.",
				},
				[{ "przejsciem", "passage" }] = {
					text = "Me and my friends sealed the one and only entrance to this dungeon, so no more inexperienced adventurers would die here. If you understood all I had to say I can lead you further. Until that, remember to {prepare} first.",
				},
				[{ "przygotowac", "prepare" }] = {
					text = "From the memory fragments that remain in my brain I conclude that you can't go inside alone. You will be needing a sorcerer, knight, druid and paladin. Also, you all should be equipped with those essential items: rope, shovel, red apple, crossbow, sword and spellbook. Without those you will surely be stuck in there for good. If you got those and you came with trustworthy team, ask me for {opening}",
				},
				[{ "otwarcie", "open", "opening" }] = {
					text = "Here you go - this is a punchcard that will start the door mechanism and open them. Be wary! Doors will automatically close if you pass through them. Take your steps cautiously - every step can be your last!",
					rewards = { QuestKeyItems.CaveExplorerOnShield.Punchcard },
					specialActionsOnSuccess = {
						{
							action = SPECIAL_ACTIONS_UNIVERSAL.sendMagicEffectPlayer,
						},
					},
					nextState = {
						[Storage.CaveExplorerOnShield.Mission01] = QuestState.CaveExplorerOnShield.Mission01.FindAndHelpEngineer,
					},
				},
			})
	end)
	:State(function()
		return QuestState.CaveExplorerOnShield.Mission01.FindAndHelpEngineer,
			QuestFactory.Script(function(missionState)
				local punchcard = Action()

				function punchcard.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not target then
						return false
					end
					if item:getKey() and not (item:getKey() == Storage.CaveExplorerOnShield.Punchcard) then
						return false
					end
					if target:getKey() and not (target:getKey() == Storage.CaveExplorerOnShield.Punchcard) then
						return false
					end
					if not (target:getId() == 8342) then
						return false
					end
					if not ItemsArePresentOnPositions(DESERT_QUEST_ONE_PUNCHCARD_DOOR_CLOSED, DESERT_QUEST_ONE_ANCHOR) then
						return false
					end

					local pos = target:getPosition()
					pos.y = pos.y - 1
					pos.x = pos.x + 1

					pos:sendMagicEffect(CONST_ME_SMOKE)
					addEvent(function()
						pos:sendMagicEffect(CONST_ME_SMOKE)
					end, 500 * 1)
					addEvent(function()
						pos:sendMagicEffect(CONST_ME_SMOKE)
					end, 1000 * 1)
					addEvent(function()
						RemoveItems(DESERT_QUEST_ONE_PUNCHCARD_DOOR_CLOSED, DESERT_QUEST_ONE_ANCHOR)
						RemoveItems(DESERT_QUEST_ONE_PUNCHCARD_DOOR_OPEN, DESERT_QUEST_ONE_ANCHOR)
						CreateItems(DESERT_QUEST_ONE_PUNCHCARD_DOOR_OPEN, DESERT_QUEST_ONE_ANCHOR)
					end, 2000 * 1)
					return true
				end

				punchcard:key(Storage.CaveExplorerOnShield.Punchcard)
				punchcard:register()

				local doorPos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_PUNCHCARD_DOOR_CLOSED[1].offPos)
				local safePos = doorPos:Moved(-1, 0, 0)

				local tile = MoveEvent()
				function tile.onStepIn(player, item, toPosition, fromPosition)
					if not ItemsArePresentOnPositions(DESERT_QUEST_ONE_PUNCHCARD_DOOR_OPEN, DESERT_QUEST_ONE_ANCHOR) then
						return false
					end
					if not player:isPlayer() then
						return false
					end
					if item.itemid == QuestKeyItems.CaveExplorerOnShield.Punchcard.id then
						return false
					end
					if not Tile(toPosition):getItemById(355) then
						return false
					end

					local pos = item:getPosition()
					pos.y = pos.y - 1

					pos:sendMagicEffect(CONST_ME_SMOKE)

					addEvent(function()
						doorPos:MoveThings(safePos)
						RemoveItems(DESERT_QUEST_ONE_PUNCHCARD_DOOR_CLOSED, DESERT_QUEST_ONE_ANCHOR)
						RemoveItems(DESERT_QUEST_ONE_PUNCHCARD_DOOR_OPEN, DESERT_QUEST_ONE_ANCHOR)
						CreateItems(DESERT_QUEST_ONE_PUNCHCARD_DOOR_CLOSED, DESERT_QUEST_ONE_ANCHOR)
						ChangeItemsKey(DESERT_QUEST_ONE_PUNCHCARD_DOOR_CLOSED, Storage.CaveExplorerOnShield.Punchcard, DESERT_QUEST_ONE_ANCHOR)
					end, 1000 * 1)
				end

				tile:key(Storage.CaveExplorerOnShield.Punchcard)
				tile:type("stepin")
				tile:register()
			end),
			QuestFactory.Script(function(missionState)
				local anthonyGate = MoveEvent()

				function anthonyGate.onStepIn(creature, item, position, fromPosition)
					local player = creature:getPlayer()
					if not player then
						return true
					end
					if not player:HasExactMissionState(missionState) then
						return
					end

					player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
					player:setStorageValueByKey(Storage.CaveExplorerOnShield.Mission01, QuestState.CaveExplorerOnShield.Mission01.ReportToEngineer)
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, player:Localizer(LOCALIZERS.CaveExplorerOnShield):Get("You succeeded in opening the gate! Talk back to engineer ghost and tell him about your success. Dont worry about closing gates - you can use shortcut door."))
					return true
				end

				anthonyGate:key(Storage.CaveExplorerOnShield.AnthonyGate)
				anthonyGate:type("stepin")
				anthonyGate:register()
			end),
			QuestFactory.Dialog("Ghost of Anthony the Engineer", {
				[{ GREET }] = {
					text = "Do i look alive? What do you think?",
					nextTopic = QuestTopics.CaveExplorerOnShield.ConfirmAnthonyIsAlive,
				},
				[{ "yes", "tak", "zagadka", "puzzle" }] = {
					text = "Look up there! Does that remind you of something? It looks just like a key to me. Can you see that sign near the key bow? I could bet this is where a very important clue could be located. I tried to read it, but it was too far away, and I cannot find a way to reach near it. Wait a second... if I'm dead and I'm a ghost, shouldn't I be able to fly? I don't know. Anyway, come back to me when you succeed in reading the sign, and ask me for {combination}.",
					requiredTopic = QuestTopics.CaveExplorerOnShield.AskForPuzzle,
				},
				[{ "yes", "tak" }] = {
					text = "How come im translucent then?",
					requiredTopic = QuestTopics.CaveExplorerOnShield.ConfirmAnthonyIsAlive,
					specialActionsOnSuccess = {
						{
							action = SPECIAL_ACTIONS_UNIVERSAL.endDialog,
						},
					},
				},
				[{ "no", "nie" }] = {
					text = "So I am dead? Hmm... this explains a lot. No matter! I had something important to do here. Hmm... yes! {Puzzle}! Would you like to help me?",
					requiredTopic = QuestTopics.CaveExplorerOnShield.ConfirmAnthonyIsAlive,
					nextTopic = QuestTopics.CaveExplorerOnShield.AskForPuzzle,
				},
				[{ "combination", "kod" }] = {
					text = "Did you read it? What was written there?",
				},
				[{ "0xb6a", "b6a", "Oxb6a" }] = {
					text = "Hm... this looks like a hexadecimal code. If you convert it to binary, you should end up with 12 characters - the exact same number as the count of key cuts above. What a coincidence... Try to change it to binary and set cuts in the key shaft accordingly. Also, I saw a lever on the upper floor. Check if there are any mechanisms they trigger. If this thing above is a key, then it ought to open something! Should you succeed opening this gate, come back and tell me about it!",
				},
			})
	end)
	:State(function()
		return QuestState.CaveExplorerOnShield.Mission01.ReportToEngineer,
			QuestFactory.Dialog("Ghost of Anthony the Engineer", {
				[{ GREET }] = {
					text = "You were successful! Amazing, you did it, you opened it! Unfortunately, my {team} didn't manage to get that far.",
				},
				[{ "team", "ekipie" }] = {
					text = "Some time ago, me and a company of mine delved here. I didn't manage to make it out alive. I don't know about their fate. What disturbs me the most is why I came into this room alone. Have I gone mad? If you ever encounter someone who was in my team, please send my {regards} to them.",
				},
				[{ "pozdrow", "pozdrowienia", "regards", "mission" }] = {
					text = "What? You encountered Germi and he told you to send his salutations? I understand... he didn't make it either... Please, return to him and tell him about my fate. Tell him that I'm sorry that I left him alone...",
					nextState = {
						[Storage.CaveExplorerOnShield.Mission01] = QuestState.CaveExplorerOnShield.Mission01.ReportToGermi,
					},
				},
			})
	end)
	:State(function()
		return QuestState.CaveExplorerOnShield.Mission01.ReportToGermi,
			QuestFactory.Dialog("Ghost of Germi the Journeyman", {
				[{ GREET }] = {
					text = "Hello again |PLAYERNAME|. Have you visited my friend?",
				},
				[{ "pozdrowienia", "regards", "salutations", "mission", "yes", "tak" }] = {
					text = "So you visited Engineer Anthony? Anthony, yes... that was his name... That means he is as {dead} as me? What a pity. Despite this... you did good. As I promised, here is your reward. This is all my gold that I hoarded during my lifetime. I can't make any other use of it anymore. I fear that a great evil lies beyond the gate Anthony tried to open. Good luck...",
					rewards = { { id = 3035, count = 100 } },
					expReward = 50000,
					requiredItems = {
						QuestKeyItems.CaveExplorerOnShield.Firebug,
						QuestKeyItems.CaveExplorerOnShield.GermiDocument,
					},
					nextState = {
						[Storage.CaveExplorerOnShield.Mission01] = MISSION_FINISHED,
						[Storage.Finished.CaveExplorerOnShield] = MISSION_FINISHED,
					},
				},
			})
	end)
	:State(function()
		return MISSION_FINISHED,
			QuestFactory.Dialog("Ghost of Germi the Journeyman", {
				[{ GREET }] = {
					text = "Hello again |PLAYERNAME|. Do you want to continue our conversation?",
				},
				[{ "mission", "martwy", "dead", "yes", "tak" }] = {
					text = "I'm positive that you are wondering: what was Anthony up to that far from our camp? Well... only now I'm starting to get back my memory. Anthony liked to take matters into own hands, but never did he act so irresponsibly. That night he must have gone to the room with a large key. He must have sneaked out when I was fast asleep. As you know, our camp is separated from the rest of the dungeon with those mechanical doors. Those doors were an Anthony idea - so no unauthorized person can get in. He was probably attacked when he arrived at that room. It could have been the ghouls - cursed remains of past adventurers. He had no chance of resisting their attack given he was there alone... he was eaten alive... poor Anthony. I could not rush to help him, because in the morning... you wouldn't {believe}.",
				},
				[{ "cos", "believe" }] = {
					text = "That morning our camp was instantly overrun by a horde of deadly arachnids. Yes, I remember now... This is how I died... I was bitten to death by dumb maggots! I'm a joke of an adventurer, to die from insects?! They had to be influenced by phantasms. They were the ones to play with Anthony's mind, for sure! They needed us to part ways, so they could deal with us separately. They startled many creatures from nearby caves and hiding places and guided them to our camp. This cave is cursed! Please, don't go further! I already gave you all my gold - you can take all you can find here, but please don't tread further into this dungeon! This place... it does not belong to this world. Phantasms... they are guarding something, I fear that a greater evil lies beyond where you delve so far. Stay here, only death awaits you beyond.",
				},
			})
	end)
	:Register()
