local internalNpcName = "GM Romek"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 144,
	lookHead = 59,
	lookBody = 115,
	lookLegs = 58,
	lookFeet = 97,
	lookAddons = 0,
}

npcConfig.flags = { floorchange = false }

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

local dialogues = {
	[LOCALIZER_UNIVERSAL] = {
		[{ "exercise" }] = { text = "Ok", rewards = { ExerciseWeaponBox(50) } },
	},
	[Storage.KrolSzczurowHub.Questline] = {
		[{ min = 0, max = TableSize(Storage.KrolSzczurowHub.Items) }] = {
			[{ "artifact", "artefakt" }] = {
				text = "Ancient artifacts of the first King of Rats. I'll keep them for the darkest hour. If you've found any artifact, just tell me which one. If it's legit, I'll unlock one of the pipes for you.",
			},
			[{ "librum vortex" }] = {
				text = "Book of rat spells. It will surely come in handy.",
				requiredItems = { KROL_SZCZUROW_HUB_KEY_ITEMS.librumVortex },
				nextState = {
					[Storage.KrolSzczurowHub.Portals.SweatyCyclops] = 1,
				},
			},
			[{ "zonobijka", "wifebeater", "vestments" }] = {
				text = "It looks like an ordinary shirt, but it provides the bearer with immunity to mail from the Domestic Violence Monitoring Center.",
				requiredItems = { KROL_SZCZUROW_HUB_KEY_ITEMS.wifebeater },
				nextState = { [Storage.KrolSzczurowHub.Portals.Djinns] = 1 },
			},
			[{ "ytong" }] = {
				text = "It is said that this item can bend time itself. Metal part can bend itself, so there is only time missing.",
				requiredItems = { KROL_SZCZUROW_HUB_KEY_ITEMS.ytong },
				nextState = { [Storage.KrolSzczurowHub.Portals.NorthKongo] = 1 },
			},
			[{ "bottomless", "bud light", "bezdenny", "harnas" }] = {
				text = "Do you think your Wu-Dka sword can defeat me?",
				requiredItems = { KROL_SZCZUROW_HUB_KEY_ITEMS.bottomless },
				nextState = { [Storage.KrolSzczurowHub.Portals.Werebadgers] = 1 },
			},
			[{ "bribeslippers", "kapcie", "kapcie przekupstwa" }] = {
				text = "Now that i see them myself, they remind me of some other slippers... can't really put my finger on it though.",
				requiredItems = { KROL_SZCZUROW_HUB_KEY_ITEMS.bribeslippers },
				nextState = { [Storage.KrolSzczurowHub.Portals.VampireCity] = 1 },
			},
			[{ "antigone", "antygona" }] = {
				text = "A reliable source of good ol' knowledge on justice.",
				requiredItems = { KROL_SZCZUROW_HUB_KEY_ITEMS.antigone },
				nextState = { [Storage.KrolSzczurowHub.Portals.Asuras] = 1 },
			},
			[{ "cultivator", "kultywator" }] = {
				text = "Strapping this to your belt will allow you to farm up to 1000 thousands of gold per hour, but only in dead games. It isn't very useful, is it?",
				requiredItems = { KROL_SZCZUROW_HUB_KEY_ITEMS.cultivator },
				nextState = { [Storage.KrolSzczurowHub.Portals.HurghadaEast] = 1 },
			},
		},
	},
	[Storage.TeatrTaniejSensacji.Questline] = {
		[1] = {
			[{ GREET }] = { text = "*Muttering*" },
			[{ ANY_MESSAGE }] = {
				text = "O tempora, {o mores}! What do you want from me?",
			},
			[{ "o mores" }] = {
				text = "Maybe the punishment was appropriate for my actions. Nevertheless, I don't want to return to society; not as Tomek. Here, in Ratland, nobody knows me. By the way, what was all that fuss about the King of Rats? Anyway, it doesn't matter because I will become the King of Rats. Propane, butane, I have a cunning plan. I'll have to impress the rats to be crowned as their new monarch. Maybe you'd like to help me?",
			},
			[{ "yes", "tak" }] = {
				text = "This will be your first task: find something that rats crave the most - cheese. But it can't be just any cheese from under someone's foreskin or parmesan growing under fingernails. These rats have access to the latest cheeses, and they won't be impressed. To satisfy them, you'll have to find the legendary matured cheese with flowers. It's possible that the pirates have such cheese. It's probably well hidden. Their hideout is on the southern shore of Hurghada.",
				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 2,
					[Storage.TeatrTaniejSensacji.Mission01] = 2,
				},
			},
		},
		[2] = {
			[{ "yes", "tak" }] = {
				text = "Thanks for the cheese. Your further help might be... helpful in my future reign. If you want, I can appoint you as my {assistant}.",
				requiredItems = { TEATR_TANIEJ_SENSACJI_KEY_ITEMS["cheese"] },
				textNoRequiredItems = "Return when you've obtained the special cheese.",
				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 3,
					[Storage.TeatrTaniejSensacji.Mission02] = 1,
					[Storage.TeatrTaniejSensacji.Mission01] = 3,
				},
			},
			[{ "no", "nie" }] = "Return when you've obtained the special cheese.",
			[{ GREET }] = {
				text = "Hello, |PLAYERNAME|. Do you have the special cheese I asked for?",
			},
		},
		[3] = {
			[{ GREET }] = {
				text = "If you want to become my assistant, you must pass the ratometer test. Are you ready?",
			},
			[{ "yes", "tak", "pomocnika", "assistant" }] = {
				text = "Who is the King of Rats, and what is his power?",
				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 4,
					[Storage.TeatrTaniejSensacji.Mission02] = 2,
				},
			},
		},
		[4] = {
			[{ "kurator", "kustosz", "custodian", "curator" }] = {
				text = "I appoint you as a rat that there are many! Come back in some time, and I'll surely find a responsible task for you.",
				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 5,
					[Storage.TeatrTaniejSensacji.Mission03] = 1,
					[Storage.TeatrTaniejSensacji.Mission02] = 3,
				},
			},
			[{ GREET }] = {
				text = "If you want to become my assistant, you must pass the ratometer test. Are you ready?",
			},
			[{ "yes", "tak" }] = "Who is the King of Rats, and what is his power?",
			[{ "vortex stinker", "wir smierdzielu" }] = "Now, the next question: The King of Rats is a ruler who is aggressive but ...?",
			[{ "just", "sprawiedliwym" }] = "You're doing well. Now it's time for the third and final task. Translate 'Custodian' to Polish.",
		},
		[5] = {
			[{ "mission", "misja" }] = {
				text = "Find my eternal enemy, tormentor, and oppressor, even though children in Africa are starving: Ms. Pitca, and arrange a Brazilian elevator for her. From the latest memes I read, she was heading towards Siberia. She seems to have her mother's intelligence, so you shouldn't have trouble dealing with her.",

				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 6,
					[Storage.TeatrTaniejSensacji.Mission03] = 2,
				},
			},
		},
		[6] = {
			[{ GREET }] = {
				text = "Ms. Pitca is somewhere in Siberia. She might have tried to schmooze with the Business Giants.",
			},
		},
		[7] = {
			[{ GREET }] = { text = "Hello. Have you completed the task yet?" },
			[{ "yes", "tak" }] = {
				text = "Ignavia corpus habetat labor firmat.",
				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 8,
					[Storage.TeatrTaniejSensacji.Mission04] = 1,
					[Storage.TeatrTaniejSensacji.Mission03] = 4,
				},
				rewards = { ExerciseWeaponBox(200) },
			},
		},
		[8] = {
			[{ GREET }] = { text = "Aaaaa!!!" },
			[{ "mission", "misja" }] = {
				text = "What have you done? Brain-dead oppressor, tyrant, penguin of Madagascar, smarty pants, brainless killer, scoundrel. Oh no, it's me. I made a magical vow with Ms. Pitca. If I ever mention Ms. Pitca to anyone, I'll age a hundred times faster than a regular person. I think I have no more than a few months left to live. Here's the battle mission: I want you to try to remove this curse from me. Maybe the grave digger can help me at a costly but fair price.",
				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 9,
					[Storage.TeatrTaniejSensacji.Mission04] = 2,
				},
			},
		},
		[9] = {
			[{ GREET }] = {
				text = "It's you again? If you're looking for the grave digger, you'll find him in Mirko. He runs his office supply store there.",
			},
		},
		[10] = {
			[{ GREET }] = {
				text = "So, do you have what Grave Digger talked about?",
			},
			[{ "mission", "misja", "yes", "tak" }] = {
				text = "Thanks, I'll check the effect of this book right away. Here's your reward.",
				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 11,
					[Storage.TeatrTaniejSensacji.Mission05] = 1,
					[Storage.TeatrTaniejSensacji.Mission04] = 4,
				},
				rewards = { ExerciseWeaponBox(200) },
			},
		},
		[11] = {
			[{ "mission", "misja" }] = {
				text = "I'm planning a party soon, and I need some catering. We can't rely on Ms. Pitca's services anymore, so I thought about ordering kebabs. Go to Shivganesh and ask him about the possibility of organizing a kebab set.",
				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 12,
					[Storage.TeatrTaniejSensacji.Mission05] = 2,
				},
			},
		},
		[12] = {
			[{ GREET }] = {
				text = "Shivganesh has his bar right by the docks of Hurghada. The town is tiny, so you should be able to find it easily.",
			},
		},
		[13] = {
			[{ GREET }] = {
				text = "Shivganesh has his bar right by the docks of Hurghada. The town is tiny, so you should be able to find it easily.",
			},
		},
		[14] = {
			[{ "mission", "misja" }] = {
				text = "Thanks for your help. Here's your reward.",
				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 15,
					[Storage.TeatrTaniejSensacji.Mission06] = 1,
					[Storage.TeatrTaniejSensacji.Mission05] = 5,
				},
				rewards = { ExerciseWeaponBox(200) },
			},
		},
		[15] = {
			[{ "mission", "misja" }] = {
				text = "My missing son Kitz is trying to reconnect. Unfortunately, it wasn't easy to shoo him off. The ingrate has been taking alimony all his life, and now that he's of age, he has to earn his own living. A thief will steal anything that's not nailed to the ground. He's trying to find me to leech off me. No way. You need to get him involved in a camp, preferably a concentration camp. First, go to Arni, who deals with organizing trips.",
				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 16,
					[Storage.TeatrTaniejSensacji.Mission06] = 2,
				},
			},
		},
		[16] = {
			[{ "mission", "misja" }] = {
				text = "Arni guards the south gate of the mirkocity.",
			},
		},
		[17] = {
			[{ "mission", "misja" }] = {
				text = "My son is on the watch at the eastern gate.",
			},
		},
		[18] = {
			[{ GREET }] = { text = "So, did you manage to complete my {mission}?" },
			[{ "mission", "misja", "misje" }] = {
				text = "Thanks, finally, that scoundrel got what he deserved.",
				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 19,
					[Storage.TeatrTaniejSensacji.Mission07] = 1,
					[Storage.TeatrTaniejSensacji.Mission06] = 5,
				},
			},
		},
		[19] = {
			[{ "mission", "misja" }] = {
				text = "Listen, lad. I heard that the previous King of Rats, Robercik, has returned from his delegation. The stupid rats forgot that he used to be king, and when he tried to enter my kingdom, they kicked him out. I think he might have sneaked in somewhere, and now he's waiting for an opportunity to harm me. Injustice comes back like a boomerang.",
				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 20,
					[Storage.TeatrTaniejSensacji.Mission07] = 2,
				},
			},
		},
		[20] = { [{ GREET }] = { text = "I don't know where he could be..." } },
		[21] = {
			[{ "mission", "misja" }] = {
				text = "Thanks, here's your reward. Robercik won't cause any more trouble.",
				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 22,
					[Storage.TeatrTaniejSensacji.Mission08] = 1,
					[Storage.TeatrTaniejSensacji.Mission07] = 4,
				},
				rewards = { ExerciseWeaponBox(200) },
			},
		},
		[22] = {
			[{ "mission", "misja" }] = {
				text = "I'm currently raising funds for an artistic bohemia. Come back when I'm closing or donate a symbolic {amount}. How about 100 platinum coins?",
				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 23,
					[Storage.TeatrTaniejSensacji.Mission08] = 2,
				},
			},
		},
		[23] = {
			[{ GREET }] = {
				text = "I'm currently raising funds for an artistic bohemia. Come back when I'm closing or donate a symbolic {amount}. How about 100 platinum coins?",
			},
			[{ "mission", "misja", "kwote" }] = {
				text = "Ytong is Ytong.",
				requiredItems = { { id = 3035, count = 100 } },
				textNoRequiredItems = "Then come back when I finish the fundraiser. The organization of the festival alone was worth at least 8 coronas extra.",
				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 24,
					[Storage.TeatrTaniejSensacji.Mission08] = 3,
				},
				specialActionsOnSuccess = {
					{
						action = SPECIAL_ACTIONS_UNIVERSAL.endDialogue,
					},
				},
			},
		},
		[24] = {
			[{ GREET }] = {
				text = "After the festival, an Wolfy's old man came to me. Inspired by art, he decided to break free from family violence and handed me his {wifebeater}.",
			},
			[{ "mission", "misja", "zonobijke", "wifebeater" }] = {
				text = "I'll be closing soon. Come back for another mission later.",
				rewards = { KROL_SZCZUROW_HUB_KEY_ITEMS.wifebeater },
				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 25,
					[Storage.TeatrTaniejSensacji.Mission09] = 1,
					[Storage.TeatrTaniejSensacji.Mission08] = 4,
				},
			},
		},
		[25] = {
			[{ "mission", "misja" }] = {
				text = "I'm setting up a new minecraft server shortly. We're starting on Friday.",
				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 26,
					[Storage.TeatrTaniejSensacji.Mission09] = 2,
				},
			},
		},
		[26] = {
			[{ GREET }] = {
				text = "The start is getting closer. I hope this time we can last more than a week.",
			},
		},
		[27] = {
			[{ "mission", "misja" }] = {
				text = "That damn bald drunkard again. He's ruining my reputation.",
				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 28,
					[Storage.TeatrTaniejSensacji.Mission10] = 1,
					[Storage.TeatrTaniejSensacji.Mission09] = 4,
				},
			},
		},
		[28] = {
			[{ "mission", "misja" }] = {
				text = "I have a simple job for you. Go to the southern Orc Fortess and read the map of their leader to find out where Brazil is located.",
				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 29,
					[Storage.TeatrTaniejSensacji.Mission10] = 2,
				},
			},
		},
		[29] = {
			[{ GREET }] = {
				text = "These discussions will eventually drive me to the grave. The fortress is south of Mirkotown.",
			},
		},
		[30] = {
			[{ "mission", "misja" }] = {
				text = "Haha, yes! Finally, I know where that emigrant is. Are you ready for a new mission?",
				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 31,
					[Storage.TeatrTaniejSensacji.Mission11] = 1,
					[Storage.TeatrTaniejSensacji.Mission10] = 4,
				},
			},
		},
		[31] = {
			[{ "mission", "misja", "yes", "tak" }] = {
				text = "Pack your stuff in the car - we're going on a trip. You need to go to the Brazilian Ratland and defeat their king. Juerdo Titsgo is DDoSing my server, so players can't donate NFTs for an unjust but lucrative cause.",
				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 32,
					[Storage.TeatrTaniejSensacji.Mission11] = 2,
				},
			},
		},
		[32] = {
			[{ GREET }] = {
				text = "Juerdo Titsgo is very short. He might hide somewhere when he sees you. His children, on the other hand, are huge mutants.",
			},
			[{ "mission" }] = {
				text = "Juerdo Titsgo is very short. He might hide somewhere when he sees you. His children, on the other hand, are huge mutants.",
			},
		},
		[33] = {
			[{ "mission", "misja" }] = {
				text = "Thanks for your help. The DDoS attacks have stopped. Here's your reward.",
				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 34,
					[Storage.TeatrTaniejSensacji.Mission12] = 1,
					[Storage.TeatrTaniejSensacji.Mission11] = 4,
				},
				rewards = { ExerciseWeaponBox(400) },
			},
		},
		[34] = {
			[{ "trial", "probe" }] = {
				text = "",
				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 35,
					[Storage.TeatrTaniejSensacji.Mission12] = 2,
				},
				spawnMonstersOnSuccess = {
					["Corym Charlatan"] = 2,
					["Corym Skirmisher"] = 2,
				},
				specialActionsOnSuccess = {
					{
						action = SPECIAL_ACTIONS_UNIVERSAL.endDialogue,
					},
				},
			},
			[{ "mission", "misja" }] = {
				text = "Here's the final stage of initiation. If The chorus of januses is to judge our justice, then who judged them? Or is it just an illusion to cut us off from our human form and commit the ultimate embarrassment? I have to prove my loyalty to justice and commit genocide. You must help me commit genocide on my own faithful. It's fair and just. Ask about the {trial} if you're ready.",
			},
		},
		[35] = {
			[{ "mission", "misja" }] = {
				text = "Here's your reward. Come back to me sometime. For now, I think I'll take a break.",
				nextState = {
					[Storage.TeatrTaniejSensacji.Questline] = 36,
					[Storage.TeatrTaniejSensacji.Mission12] = 3,
					[Storage.Finished.TeatrTaniejSensacji] = 1,
					[Storage.KrolSzczurowHub.Portals.SweatyCyclops] = 1,
					[Storage.BezpieczenstwoIHigienaPracy.Questline] = 0,
					[Storage.BezpieczenstwoIHigienaPracy.Mission01] = 0,
				},
				rewards = { ExerciseWeaponBox(400) },
			},
		},
	},
	[Storage.BezpieczenstwoIHigienaPracy.Questline] = {
		[0] = {
			[{ "mission" }] = {
				text = "Thank you for your help with the last task. I have now achieved justice on the level of a true Rat King. Therefore, I think I am worthy of entrusting you with a new task. Go to Turdstin, a member of the MGTOW clan. Anticipating your question: yes, he is disabled. However, it's possible that he knows how to locate the Rat of Kings.",
				nextState = {
					[Storage.BezpieczenstwoIHigienaPracy.Questline] = 1,
					[Storage.BezpieczenstwoIHigienaPracy.Mission01] = 1,
				},
			},
		},
		[1] = {
			[{ "mission" }] = {
				text = "Turdstin znajduje sie na poludniowej plazy Mirkotown.",
			},
		},
		[15] = {
			[{ "mission" }] = {
				text = "Thank you for your help with the task and for the information from the Rat of Kings. Come back to me after some time, and I will tell you about the fate of someone close to me who wanted to defeat HF-P/X. Although his motivations were somewhat unusual.",
				nextState = {
					[Storage.BezpieczenstwoIHigienaPracy.Questline] = 16,
					[Storage.BezpieczenstwoIHigienaPracy.Mission06] = 5,
					[Storage.TrzejSramaciISmok.Questline] = 0,
				},
				rewards = { ExerciseWeaponBox(1337) },
			},
		},
	},
	[Storage.TrzejSramaciISmok.Questline] = {
		[0] = {
			[{ "mission" }] = {
				text = "Shireajevo, year two thousand fifteen. Or was it {sixteenth}? Hmm, not sure...",
			},
			[{ "szesnasty", "sixteenth" }] = {
				text = "I remember now: it was the Year of Linux. Bambalf came to visit my father, Bilbeus. The wizard, as he entered the main room, said to my father, who was sprawled on the couch: 'Have you heard of an android so rich it sleeps on Passats?' and then sat down next to him. My {father} denied it and with unprecedented curiosity, added that they should sit down. Since they were already sitting, I assumed they wanted to sit over vodka that was there on the table.",
			},
			[{ "ojca", "father" }] = {
				text = "Another time, my father invited Bambalf's hunting buddies. Apparently, they were already familiar with the story, as when the Wizard finally arrived, he didn't have to retell it from the beginning. Bambalf explained to my father that these friends were actually the unknown culprits behind the collapse of the state-owned farms around the Brzezinka Mountain. He also mentioned their sarmatian roots and their supposed inheritance from an android sleeping on Passats. Later, they discussed some work agreement and a plan to take over a legitimate inheritance. I don't remember much of it because I was young and didn't understand all the words. Then they drank vodka, and they set off on a {journey}.",
			},
			[{ "droge", "journey" }] = {
				text = "From my father's {letters}, I learned that while traveling, they were accompanied by music. He wrote that the melody and vocals came from behind the screen, whatever that means. On the seventh day of the journey, when they decided to set up camp and go to sleep, something unexpected happened. Three sopranist Januses started singing: 'Memento mori es grande finali. Burn their bodies in our dark rally' and then they broke the fourth wall. While revealing their vile faces and they captured the adventurers. Then, fat Janus the Baritone (a hater of all changes, like compulsory zipper merging), turned the tide of action. While simultaneously addressing all the heroes of all times in all of the universe's history, he uttered these words: 'PRICKS' fat Janus the baritone roasted the vile sopranists in the embers of Polish hatred, and then he returned to Olympus. With his departure, Gruby Janusz left behind a map of Poland's roads. Since then, I haven't heard any mention of the Janus choir.",
			},
			[{ "listow", "letters" }] = {
				text = "From the most {recent} letters, I learned that they fought with mutts, homeless people, and other abominations in the hundred-mile forest. That was still within the borders of our Voivodeship. They reached the northern edge of the familiar territory, and just by the scent of the air, they knew that in this part of the country, people lived at least as well as the homeless in Hurghada. Being abroad, they were invited to a dinner (out of pity) by a camel farm owner. Then, they went to bed, I don't know where.",
			},
			[{ "aktualnych", "recent" }] = {
				text = "Three months have passed since the last letter, and I used to receive them at monthly intervals. That's why I got worried about their current condition. I can't leave my kingdom, but if you're determined, I can help you find them. Let me know when you're {ready}. In the meantime, I'll try to estimate their last location and possible direction.",
			},
			[{ "ready", "gotowy" }] = {
				text = "I've placed their possible location in your quest log. Good luck. And as for the Janusz choir... aside from that people. I can lend you my scroll with various poems. Oh, and one more thing. Based on my estimates, the company may have passed near Goldblum's burrow. He's known for posing very difficult riddles, and failing to solve them ends, the very least, badly. You might want to go to someone who's escaped his clutches before - Far Myrrus.",
				nextState = {
					[Storage.TrzejSramaciISmok.Questline] = 1,
					[Storage.TrzejSramaciISmok.Mission01] = 1,
					[Storage.TrzejSramaciISmok.Mission02] = 1,
				},
			},
		},
		[1] = {
			[{ "goldbluma", "goldblum", "mission" }] = {
				text = "Seriusly, talk to Far Myrrus about Goldblum.",
			},
		},
		[24] = {
			[{ "mission" }] = {
				text = "I have bad news. The stress level of the Rat of Kings reached the maximum possible value upon hearing about the Passat wreckage. Rats, unlike humans, react differently to such circumstances. Their reaction is self-destruction of the organism and tearing the soul into billions of smaller rat souls and Schrodinger's souls, each existing and not existing at the same time. The only way to bring him back to life is to find all the Schrödinger's souls and separate them from the real rat ones. Leave this problem to me, as I need you for another {task}.",
				nextState = {
					[Storage.TrzejSramaciISmok.Questline] = 25,
					[Storage.TrzejSramaciISmok.Mission09] = 4,
					[Storage.Finished.Sramaci] = 1,
					[Storage.TragedyaWCzterechAktach.Questline] = 1,
					[Storage.TragedyaWCzterechAktach.Mission01] = 1,
				},
			},
		},
	},
	[Storage.TragedyaWCzterechAktach.Questline] = {
		[1] = {
			[{ "mission", "zadanie" }] = {
				text = "Before I forget - the reward for the previous task: {axe}, {sword}, {mace}, {bow}, {rod}, {wand} (exercise weapon).",
			},
			[{ "axe", "sword", "mace", "bow", "rod", "wand" }] = {
				text = "Ehh... before I tell you what's next, we need to deal with the HF-P/X insurance agent. You probably know him - they call him Turdstin.",
				nextState = {
					[Storage.TragedyaWCzterechAktach.Questline] = 2,
					[Storage.TragedyaWCzterechAktach.Mission01] = 2,
				},
				rewards = { ExerciseWeaponBox(3000) },
			},
		},
		[2] = {
			[{ "mission" }] = {
				text = "Turdstin lives in the slums, Mirko. His life professions include homelessness, MGTOW, collecting cans, and being an insurance agent.",
			},
		},
		[3] = {
			[{ "mission" }] = {
				text = "Well, hes just the smartest person in the world. Okay, let's not waste any more time. After HF-P/X's death, a time-delayed mechanism was activated, which opened a portal to the past. Now immigrants are flooding in from everywhere. Go to the portal in Knurow and head to the Knurow of the past. Find someone there who will help you with the task of stopping the influx of immigrants.",
				nextState = {
					[Storage.TragedyaWCzterechAktach.Questline] = 4,
					[Storage.TragedyaWCzterechAktach.Mission01] = 4,
					[Storage.TragedyaWCzterechAktach.Mission02] = 1,
					[Storage.TragedyaWCzterechAktach.RetroKnurowoAccess] = 1,
				},
			},
		},
		[4] = {
			[{ "mission" }] = {
				text = "I told you to use the portal in Knurow, although I don't remember exactly where it was located. Something tells me it was somewhere along the shore...",
			},
		},
		[8] = {
			[{ "mission" }] = {
				text = "So, it's Rat Bum. Hmm, but in the memes, it said that Rat Bum can't do anything. I know his origin. I would like to tell you where to find him, but currently, he is protected by a narrative armor. So, I suggest you go get some beer at Lewiatan now.",
				nextState = {
					[Storage.TragedyaWCzterechAktach.Questline] = 9,
					[Storage.TragedyaWCzterechAktach.Mission02] = 6,
					[Storage.TragedyaWCzterechAktach.Mission03] = 1,
					[Storage.TragedyaWCzterechAktach.KrakenAccess] = 1,
				},
			},
		},
		[9] = {
			[{ "mission" }] = {
				text = "If you don't know where to find the nearest Lewiatan, ask Krzysztof Kolumb.",
			},
		},
		[10] = {
			[{ "mission" }] = {
				text = "But I wasn't talking about some monster, just that shop on the corner. During that time, I went to Walmart to get heineken because I couldn't wait for you. Now, back to the point. I recalled this old story: people from the northeast whisper about certain {slippers} that Rat Bum nibbled on. They say he tried to steal them from his Master, who, under the influence of slippers, descended into the abyss of corruption. The prophecy was funded by the Ministry of State Security of the People's Republic of China.",
			},
			[{ "slippers", "kapciach" }] = {
				text = "Rumors have it that after the death of the aforementioned ruler, the slippers were buried with him. However, it is unknown where this burial place is. As I mentioned, all rumors about the origin of the slippers started with the inhabitants of the northern lands. I think it could be Rats collaborating with banshees. Search the corridors of their base. If you manage to find these slippers, based on the tooth pattern that bit the front part of the boot, we will find a matching profile on onlyfangs.com.",
				nextState = {
					[Storage.TragedyaWCzterechAktach.Questline] = 11,
					[Storage.TragedyaWCzterechAktach.Mission03] = 3,
					[Storage.TragedyaWCzterechAktach.Mission04] = 1,
				},
			},
		},
		[11] = { [{ "mission" }] = { text = "Look out in the eastern Kongo." } },
		[12] = {
			[{ "mission" }] = {
				text = "Did you find anything about slippers owner?",
			},
			[{
				"oltarz weza",
				"oltarz",
				"waz",
				"weza",
				"frog cult",
				"frog",
				"cult",
			}] = {
				text = "Try to search in the underground ruins in the Kongo. This place was inhabited long ago by medusas, hydras, and other writhing creatures, and it is overgrown with foul flora. An ideal place for an altar for serpentine gods.",
				nextState = {
					[Storage.TragedyaWCzterechAktach.Questline] = 13,
					[Storage.TragedyaWCzterechAktach.Mission04] = 3,
					[Storage.TragedyaWCzterechAktach.Mission05] = 1,
					[Storage.TragedyaWCzterechAktach.SkurwiwijAccess] = 1,
					[Storage.TragedyaWCzterechAktach.SkurwiwijDoor] = 1,
				},
			},
			[{ ANY_MESSAGE }] = {
				text = "Your eyes will open when mine have already closed itselves",
			},
		},
		[13] = {
			[{ "mission" }] = {
				text = "Ruins are located in the northern part of Kongo",
			},
		},
		[14] = {
			[{ "mission" }] = {
				text = "Grazhena Core? Hmm... My mother Xena once belonged to a rural housewives club. Ask her if she knows more about this object. She is the leader of the feminists. Maybe you've already met her.",
				requiredItems = {
					TRAGEDYA_W_CZTERECH_AKTACH_KEY_ITEMS["GRAZYNA_CORE"],
				},
				removeRequiredItems = false,
				textNoRequiredItems = "Skurwiwij had Grazhenacore, and you lost it? Come back when you find your lost item.",
				nextState = {
					[Storage.TragedyaWCzterechAktach.Questline] = 15,
					[Storage.TragedyaWCzterechAktach.Mission05] = 3,
					[Storage.TragedyaWCzterechAktach.Mission06] = 1,
				},
			},
		},
		[18] = {
			[{ "mission" }] = {
				text = "Thanks for your help. Here's your reward for completing the task: {axe}, {sword}, {mace}, {bow}, {rod}, {wand} (exercise weapon).",
			},
			[{ "axe", "sword", "mace", "bow", "rod", "wand" }] = {
				text = "If you have a moment, go to the summit of the highest mountain in the Caribbean. You might find someone there whom you once knew.",
				nextState = {
					[Storage.TragedyaWCzterechAktach.Questline] = 19,
					[Storage.TragedyaWCzterechAktach.Mission06] = 5,
					[Storage.Finished.Tragedya] = 1,
					[Storage.PerIustitiaAdAstra.Questline] = 1,
					[Storage.PerIustitiaAdAstra.Mission01] = 1,
					[Storage.TragedyaWCzterechAktach.GrazhenaDoor] = -1,
				},
				rewards = { ExerciseWeaponBox(3500) },
			},
		},
	},
	[Storage.PerIustitiaAdAstra.Questline] = {
		[1] = { [{ ANY_MESSAGE }] = { text = "As i said, go to the Karaiby." } },
	},
	[Storage.BigKlamoty.Questline] = {
		[1] = { [{ "mission" }] = { text = "To be continued..." } },
	},
	[Storage.SpojrzenieTysiacaYtongow.Questline] = {
		[1] = {
			[{ "mission" }] = {
				text = "Pozwol ze przedstawie Ci pewna opowiesc. O tym nie bylo na historii w podstawowce ani w gimbazie. Kondominium rosyjsko-niemieckie pod zydowsko-amerykanskim zarzadem powierniczym. Wigilia, rok 1980, po obiedzie. Mlody Marceliusz czekal, az mikolaj przybedzie z prezentami. Wlasciwie to Marceliusz mial juz wtedy 14 lat, wiec wiedzial, ze mikolaj nie {istnieje}.",
			},
			[{ "real", "istnieje" }] = {
				text = "Jednak to nie przeszkadzalo mu w kultywowaniu tradycji. Mijaly kwadranse, a pozniej godziny. Niestesty zaden mikolaj, ani rodzice, ani nawet dziadkowie nie polozyli prezentenow pod choinka - nie spielnialy sie jego oczekiwania. W koncu Marceliusz zapytal mame: “Nadszedl czas odplaty stara poczwaro, gdzie moje prezenty?”. Jego matka (kobieta w pelni wladz umyslowych) {odpowiedziala} mu: “Marceliusz ciemiezco! czemu Ty nas tak dreczysz? Czego Ty od nas chcesz?”.",
			},
			[{ "told", "odpowiedziala" }] = {
				text = "Tak jest, Marceliusz zyl w komunistycznej Polsce. Tego dnia poprzysiagl sobie co nastepuje: “Trzy razy ponownie rozpierdole caly komunizm zanim kogut zapieje”. Pomyslal, ze powinien dokonac w zyciu czegos waznego - zajmie sie wsparciem interpunkcyjnym Polski. Tak jest, to on usunal sierp i kowaldo, i w zamian postawil los Polski pod znakiem {zapytania}.",
			},
			[{ "question", "zapytania" }] = {
				text = "Z biegiem czasu Marceliusz stawal sie coraz bardziej prominentym obywatelem, a jego imie wciaz ulegalo skroceniu (wzgledy optymalizacyjne). Najpierw bylo Marceus, potem Marcel... W ktoryms momencie osiagnal poziom sprawiedliwosci pozwalajacy mu na zrzucenie ludzkiej powloki... Wtedy tez najprawdopodobniej zle moce wystapily z cienia, i pod ich wplywem zmienil sie w Krola Jaszczurow. Od tamtego czasu jego imie uleglo maksymalnemu skroceniu... domylasz sie pewnie jak sie teraz nazywa.",
			},
			[{ "mark", "zuckerberg", "mark zuckerberg" }] = {
				text = "Aktualnie Mark Zuckerberg przebywa na swoim statku-gwiezdzie i proboje zawladnac umyslami ludzi poprzez Janusz-Verse TM, teraz z googlami VR Pro Max + za jedyne 79.99 USD! Cholera, dlaczego powiedzialem to ostatnie... Smrod jego kontrolujacej mozgi prezencji rozsiewa sie az tutaj. Dodatkowo, jego siedziby broni cala flota kosmicznych statkow, wiec zeby go pokonac bedziesz potrzebowac co najmniej legionu zgranych mysliwcow.",
				nextState = {
					[Storage.SpojrzenieTysiacaYtongow.Questline] = 2,
					[Storage.SpojrzenieTysiacaYtongow.Mission01] = 2,
				},
			},
		},
		[2] = { [{ "mission" }] = {} },
	},
	[Storage.SprawiedliwyWobecNarodow.Questline] = {
		[1] = {
			[{ "mission" }] = {
				text = 'Jedna rzecz nie daje mi spokoju. Gdy szczur Krol Szczurow sie w Janusza Gwiezdnego, to zaczal od slow "Halo, Pjoter, slychac mnie?". Czy pomylilo mu sie cos i myslal, ze rozmawia z Petrusem gnebicielem? Dziwna sprawa. Udaj sie do wiezy petrusa gnebiciela i sproboj znalezc jego powiazania ze szczurem krolow.',
				nextState = {
					[Storage.SprawiedliwyWobecNarodow.Questline] = 2,
					[Storage.SprawiedliwyWobecNarodow.Mission01] = 2,
				},
			},
		},
		-- [2] znajdujemy dziennik petrusa
		[3] = {
			[{ "mission" }] = {
				text = "Jesli to co pisal Petrus to prawda, to pozostaje jedno pytanie. Jakiego koloru byl nadgarstek szczura krolow, gdy ostatni raz go widziales?",
			},
			[{ ANY_MESSAGE }] = { text = "W takim razie nie ma sie czym martwic." },
			[{ "red", "czerwony" }] = {
				text = "Dlaczego to sa zawsze ci czerwoni.. Wyglada na to, ze to nie jest prawdziwy szczur krolow, tylko Marahin. Wyslal cie zabic petrusa gnebiciela, gdyz ten wiedzial zbyt duzo. Potem pomogl ci zniszczyc HF-P/X, aby otworzyc portal do przeszlosci. Mam nadzieje ze te runy ze swiatyni nie sluzyly do odpieczerowywania czegos innego.. Mysle, ze szczur krolow wiedzial gdzie otworzy sie portal, i tylko czekal az HF-P/X umrze. Wtedy tez wskoczyl do srodka i cofnal sie w przeszlosc, gdzie sprzedawal ludziom ccki na allegro. Po jakims czasie wrocil do terazniejszosci, a my nie odczulismy tego, gdyz nasz czas plynie tysiace razy krocej, niz u kogos, kto cofnal sie w czasie. Udaj sie teraz do retro Knurowa i sproboj znalezc kogos, kto kupowal od niego ccki. Byc moze powie o nim cos wiecej.",
				nextState = {
					[Storage.SprawiedliwyWobecNarodow.Questline] = 4,
					[Storage.SprawiedliwyWobecNarodow.Mission01] = 4,
				},
			},
		},
		-- [4] gadamy z X w retro mirko (domek na zachodzie). X mowi, ze jezeli chcemy wiecej informacji o Marahinie, to mamy poszuka w bibliotece pod temple. X przekupil kiedys natanka, aby ten wyjawik mu sposob bedzie do katakumb. Musimy uzyc mechanizmu w zagarku z kukulka, w bardzo konkretny sposob. Musisz wciskac kukulke w odpowiednich momentach: najpierw wcisnij dwa razy, gdy jest godzina parzysta, nastepnie raz, gdy jest nieparzysta, nastepnie znow dwa razy gdy jest parzysta, i na koniec wcisnij, gdy reszta z dzielenia aktualnej minuty podniesionej do potegi przez liczbe o jeden wieksza od tej minuty wyniesie 2. Jesli to wykonasz, to przejdz w lewy dolny rog pokoju, i sproboj zgasic lampe. Wtedy mechanizm ukarze schody.
		-- [5] znajdujemy archiwum z X, a w nim dokument w jezyku jaszczuroludzi
		-- [6] rozmawiamy z gerturda, ktora tlumaczy nam dokument
		[7] = {
			[{ "mission" }] = {
				text = "Tak, to ostatecznie potwierdza, ze Marahin podszywal sie pod Szczura Krolow, a pozniej udawal, ze zmienil sie w janusza gwiezdnego. Pamietasz jak wyslal cie na planete Hugo Bossa? Mysle, ze robil wtedy cos wymagajacego dyskrecji, dlatego wyslal cie tak daleko. Chwila.. przeciez Krol Jaszczurow wspominal cos o Hoecruxach. Byc moze Marahin zajmowal sie tworzeniem ich w tym czasie?",
			},
		},
	},
}

local function greetCallback(npc, creature, type, message)
	InitializeResponses(creature, dialogues, npcHandler, npc)
	return true
end

local function creatureSayCallback(npc, creature, type, msg)
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end
	return TryResolveConversation(creature, msg, dialogues, npcHandler, npc)
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
