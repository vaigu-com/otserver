local localizer = Storage.TheaterOfCheapThrills.Localizer
local dialogs = {
	[Storage.TheaterOfCheapThrills.Mission01] = {
		[{ requiredState = State.TheaterOfCheapThrills.Mission01.Start, npcName = "Gm Romek" }] = {
			[{ GREET }] = {
				text = "*Muttering*",
			},
			[{ ANY_MESSAGE }] = {
				text = "O tempora, {o mores}! What do you want from me?",
			},
			[{ "o mores" }] = {
				text = "Maybe the punishment was appropriate for my actions. Nevertheless, I don't want to return to society; not as Tomek. Here, in Ratland, nobody knows me. By the way, what was all that fuss about the King of Rats? Anyway, it doesn't matter because I will become the King of Rats. Propane, butane, I have a cunning plan. I'll have to impress the rats to be crowned as their new monarch. Maybe you'd like to help me?",
			},
			[{ "yes", "tak" }] = {
				text = "This will be your first task: find something that rats crave the most - cheese. But it can't be just any cheese from under someone's foreskin or parmesan growing under fingernails. These rats have access to the latest cheeses, and they won't be impressed. To satisfy them, you'll have to find the legendary matured cheese with flowers. It's possible that the pirates have such cheese. It's probably well hidden. Their hideout is on the southern shore of Hurghada.",
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission01] = 2,
				},
			},
		},
		[{ requiredState = State.TheaterOfCheapThrills.Mission01.FindingCheese, npcName = "Gm Romek" }] = {
			[{ "yes", "tak" }] = {
				text = "Thanks for the cheese. Your further help might be... helpful in my future reign. If you want, I can appoint you as my {assistant}.",
				requiredItems = { TEATR_TANIEJ_SENSACJI_KEY_ITEMS.cheese },
				textNoRequiredItems = "Return when you've obtained the special cheese.",
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission01] = 3,
					[Storage.TheaterOfCheapThrills.Mission02] = 1,
				},
				[{ "no", "nie" }] = { text = "Return when you've obtained the special cheese." },
				[{ GREET }] = {
					text = "Hello, |PLAYERNAME|. Do you have the special cheese I asked for?",
				},
			},
		},
	},
	[Storage.TheaterOfCheapThrills.Mission02] = {
		[1] = {
			[{ GREET }] = {
				text = "If you want to become my assistant, you must pass the ratometer test. Are you ready?",
			},
			[{ "yes", "tak", "pomocnika", "assistant" }] = {
				text = "Who is the King of Rats, and what is his power?",
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission02] = 2,
				},
			},
		},
		[2] = {
			[{ "kurator", "kustosz", "custodian", "curator" }] = {
				text = "I appoint you as a rat that there are many! Come back in some time, and I'll surely find a responsible task for you.",
				nextState = {
					[Storage.TheaterOfCheapThrills.State] = 5,
					[Storage.TheaterOfCheapThrills.Mission03] = 1,
					[Storage.TheaterOfCheapThrills.Mission02] = 3,
				},
			},
			[{ GREET }] = {
				text = "If you want to become my assistant, you must pass the ratometer test. Are you ready?",
			},
			[{ "yes", "tak" }] = { text = "Who is the King of Rats, and what is his power?" },
			[{ "vortex stinker", "wir smierdzielu" }] = {
				text = "Now, the next question: The King of Rats is a ruler who is aggressive but ...?",
			},
			[{ "just", "sprawiedliwym" }] = {
				text = "You're doing well. Now it's time for the third and final task. Translate 'Custodian' to Polish.",
			},
		},
	},
	[Storage.TheaterOfCheapThrills.Mission03] = {
		[1] = {
			[{ "mission", "misja" }] = {
				text = "Find my eternal enemy, tormentor, and oppressor, even though children in Africa are starving: Ms. Pitca, and arrange a Brazilian elevator for her. From the latest memes I read, she was heading towards Siberia. She seems to have her mother's intelligence, so you shouldn't have trouble dealing with her.",
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission03] = 2,
				},
			},
		},
		[2] = {
			[{ GREET }] = {
				text = "Ms. Pitca is somewhere in Siberia. She might have tried to schmooze with the Business Giants.",
			},
		},
		[3] = {
			[{ GREET }] = { text = "Hello. Have you completed the task yet?" },
			[{ "yes", "tak" }] = {
				text = "Ignavia corpus habetat labor firmat.",
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission04] = 1,
					[Storage.TheaterOfCheapThrills.Mission03] = 4,
				},
				rewards = { ExerciseWeaponBox(200) },
			},
		},
	},
	[Storage.TheaterOfCheapThrills.Mission04] = {
		[1] = {
			[{ GREET }] = { text = "Aaaaa!!!" },
			[{ "mission", "misja" }] = {
				text = "What have you done? Brain-dead oppressor, tyrant, penguin of Madagascar, smarty pants, brainless killer, scoundrel. Oh no, it's me. I made a magical vow with Ms. Pitca. If I ever mention Ms. Pitca to anyone, I'll age a hundred times faster than a regular person. I think I have no more than a few months left to live. Here's the battle mission: I want you to try to remove this curse from me. Maybe the grave digger can help me at a costly but fair price.",
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission04] = 2,
				},
			},
		},
		[2] = {
			[{ GREET }] = {
				text = "It's you again? If you're looking for the grave digger, you'll find him in Mirko. He runs his office supply store there.",
			},
		},
		[3] = {
			[{ GREET }] = {
				text = "So, do you have what Grave Digger talked about?",
			},
			[{ "mission", "misja", "yes", "tak" }] = {
				text = "Thanks, I'll check the effect of this book right away. Here's your reward.",
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission05] = 1,
					[Storage.TheaterOfCheapThrills.Mission04] = 4,
				},
				rewards = { ExerciseWeaponBox(200) },
			},
		},
	},
	[Storage.TheaterOfCheapThrills.Mission05] = {
		[1] = {
			[{ "mission", "misja" }] = {
				text = "I'm planning a party soon, and I need some catering. We can't rely on Ms. Pitca's services anymore, so I thought about ordering kebabs. Go to Shivganesh and ask him about the possibility of organizing a kebab set.",
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission05] = 2,
				},
			},
		},
		[2] = {
			[{ GREET }] = {
				text = "Shivganesh has his bar right by the docks of Hurghada. The town is tiny, so you should be able to find it easily.",
			},
		},
		[3] = {
			[{ GREET }] = {
				text = "Shivganesh has his bar right by the docks of Hurghada. The town is tiny, so you should be able to find it easily.",
			},
		},
		[4] = {
			[{ "mission", "misja" }] = {
				text = "Thanks for your help. Here's your reward.",
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission06] = 1,
					[Storage.TheaterOfCheapThrills.Mission05] = 5,
				},
				rewards = { ExerciseWeaponBox(200) },
			},
		},
	},
	[Storage.TheaterOfCheapThrills.Mission06] = {
		[1] = {
			[{ "mission", "misja" }] = {
				text = "My missing son Kitz is trying to reconnect. Unfortunately, it wasn't easy to shoo him off. The ingrate has been taking alimony all his life, and now that he's of age, he has to earn his own living. A thief will steal anything that's not nailed to the ground. He's trying to find me to leech off me. No way. You need to get him involved in a camp, preferably a concentration camp. First, go to Arni, who deals with organizing trips.",
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission06] = 2,
				},
			},
		},
		[2] = {
			[{ "mission", "misja" }] = {
				text = "Arni guards the south gate of the mirkocity.",
			},
		},
		[3] = {
			[{ "mission", "misja" }] = {
				text = "My son is on the watch at the eastern gate.",
			},
		},
		[4] = {
			[{ GREET }] = { text = "So, did you manage to complete my {mission}?" },
			[{ "mission", "misja", "misje" }] = {
				text = "Thanks, finally, that scoundrel got what he deserved.",
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission07] = 1,
					[Storage.TheaterOfCheapThrills.Mission06] = 5,
				},
			},
		},
	},
	[Storage.TheaterOfCheapThrills.Mission07] = {
		[1] = {
			[{ "mission", "misja" }] = {
				text = "Listen, lad. I heard that the previous King of Rats, Robercik, has returned from his delegation. The stupid rats forgot that he used to be king, and when he tried to enter my kingdom, they kicked him out. I think he might have sneaked in somewhere, and now he's waiting for an opportunity to harm me. Injustice comes back like a boomerang.",
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission07] = 2,
				},
			},
		},
		[2] = { [{ GREET }] = { text = "I don't know where he could be..." } },
		[3] = {
			[{ "mission", "misja" }] = {
				text = "Thanks, here's your reward. Robercik won't cause any more trouble.",
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission08] = 1,
					[Storage.TheaterOfCheapThrills.Mission07] = 4,
				},
				rewards = { ExerciseWeaponBox(200) },
			},
		},
	},
	[Storage.TheaterOfCheapThrills.Mission08] = {
		[1] = {
			[{ "mission", "misja" }] = {
				text = "I'm currently raising funds for an artistic bohemia. Come back when I'm closing or donate a symbolic {amount}. How about 100 platinum coins?",
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission08] = 2,
				},
			},
		},
		[2] = {
			[{ GREET }] = {
				text = "I'm currently raising funds for an artistic bohemia. Come back when I'm closing or donate a symbolic {amount}. How about 100 platinum coins?",
			},
			[{ "mission", "misja", "kwote" }] = {
				text = "Ytong is Ytong.",
				requiredItems = { { id = 3035, count = 100 } },
				textNoRequiredItems = "Then come back when I finish the fundraiser. The organization of the festival alone was worth at least 8 coronas extra.",
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission08] = 3,
				},
				specialActionsOnSuccess = {
					{
						action = SPECIAL_ACTIONS_UNIVERSAL.endDialog,
					},
				},
			},
		},
		[3] = {
			[{ GREET }] = {
				text = "After the festival, an Wolfy's old man came to me. Inspired by art, he decided to break free from family violence and handed me his {wifebeater}.",
			},
			[{ "mission", "misja", "zonobijke", "wifebeater" }] = {
				text = "I'll be closing soon. Come back for another mission later.",
				rewards = { KROL_SZCZUROW_HUB_KEY_ITEMS.wifebeater },
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission09] = 1,
					[Storage.TheaterOfCheapThrills.Mission08] = 4,
				},
			},
		},
	},
	[Storage.TheaterOfCheapThrills.Mission09] = {
		[1] = {
			[{ "mission", "misja" }] = {
				text = "I'm setting up a new minecraft server shortly. We're starting on Friday.",
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission09] = 2,
				},
			},
		},
		[2] = {
			[{ GREET }] = {
				text = "The start is getting closer. I hope this time we can last more than a week.",
			},
		},
		[3] = {
			[{ "mission", "misja" }] = {
				text = "That damn bald drunkard again. He's ruining my reputation.",
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission10] = 1,
					[Storage.TheaterOfCheapThrills.Mission09] = 4,
				},
			},
		},
	},
	[Storage.TheaterOfCheapThrills.Mission10] = {
		[1] = {
			[{ "mission", "misja" }] = {
				text = "I have a simple job for you. Go to the southern Orc Fortess and read the map of their leader to find out where Brazil is located.",
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission10] = 2,
				},
			},
		},
		[2] = {
			[{ GREET }] = {
				text = "These discussions will eventually drive me to the grave. The fortress is south of Mirkotown.",
			},
		},
		[3] = {
			[{ "mission", "misja" }] = {
				text = "Haha, yes! Finally, I know where that emigrant is. Are you ready for a new mission?",
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission11] = 1,
					[Storage.TheaterOfCheapThrills.Mission10] = 4,
				},
			},
		},
	},
	[Storage.TheaterOfCheapThrills.Mission11] = {
		[1] = {
			[{ "mission", "misja", "yes", "tak" }] = {
				text = "Pack your stuff in the car - we're going on a trip. You need to go to the Brazilian Ratland and defeat their king. Juerdo Titsgo is DDoSing my server, so players can't donate NFTs for an unjust but lucrative cause.",
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission11] = 2,
				},
			},
		},
		[2] = {
			[{ GREET }] = {
				text = "Juerdo Titsgo is very short. He might hide somewhere when he sees you. His children, on the other hand, are huge mutants.",
			},
			[{ "mission" }] = {
				text = "Juerdo Titsgo is very short. He might hide somewhere when he sees you. His children, on the other hand, are huge mutants.",
			},
		},
		[3] = {
			[{ "mission", "misja" }] = {
				text = "Thanks for your help. The DDoS attacks have stopped. Here's your reward.",
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission12] = 1,
					[Storage.TheaterOfCheapThrills.Mission11] = 4,
				},
				rewards = { ExerciseWeaponBox(400) },
			},
		},
	},
	[Storage.TheaterOfCheapThrills.Mission12] = {
		[1] = {
			[{ "trial", "probe" }] = {
				text = "",
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission12] = 2,
				},
				spawnMonstersOnSuccess = {
					["Corym Charlatan"] = 2,
					["Corym Skirmisher"] = 2,
				},
				specialActionsOnSuccess = {
					{
						action = SPECIAL_ACTIONS_UNIVERSAL.endDialog,
					},
				},
			},
			[{ "mission", "misja" }] = {
				text = "Here's the final stage of the initiation. If The chorus of januses is to judge our justice, then who judged them? Or is it just an illusion to cut us off from our human form and commit the ultimate embarrassment? I have to prove my loyalty to justice and commit genocide. You must help me commit genocide on my own faithful. It's fair and just. Ask about the {trial} if you're ready.",
			},
		},
		[2] = {
			[{ "mission", "misja" }] = {
				text = "Here's your reward. Come back to me sometime. For now, I think I'll take a break.",
				nextState = {
					[Storage.TheaterOfCheapThrills.Mission12] = 3,
					[Storage.Finished.TheaterOfCheapThrills] = 1,
					[Storage.KingOfRatsHQ.Portals.SweatyCyclops] = 1,
					[Storage.SafetyAndOccupationalHygiene.Mission01] = 1,
				},
				rewards = { ExerciseWeaponBox(400) },
			},
		},
	},
}
