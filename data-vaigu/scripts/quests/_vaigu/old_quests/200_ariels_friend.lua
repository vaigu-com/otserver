local quest = Quest(LOCALIZERS.ArielsFriend)
local elixirId = 33892

quest
	:Storage(function()
		Storage.ArielsFriend = {
			HumbleRequest = {},
			FriendGrave = {},

			LoveIsInTheAir = {},
			HairStrand = {},
			Haybed = {},
			ElixirStand = {},
			LoveElixirRaw = {},
			LoveElixirEnchanted = {},

			KillerLiquor = {},
			LiquorChest = {},
			LiquorItem = {},

			PreludeToThaumaturgy = {},
			GravesSoulChance = {},
			VirginGrave = {},

			RadioFreeHirschberg = {},
			OldRadioContainer = {},
			OldRadioBroken = {},
			OldRadioWorking = {},
			RadioMessageState = {},
			AmeeEscort = {},
			AmeeMap = {},
			HouseTile = {},
			Monument = {},
		}
		QuestState.ArielsFriend = {
			HumbleRequest = {
				PutFlowerOnGrave = 1,
				ReportToAriel = 2,
				AskForNewMission = 3,
			},
			LoveIsInTheAir = {
				HandInvitationToMadame = 1,
				AskPostmanForHelp = 2,
				StealElixir = 3,
				ReportToPostman = 4,
				EnchantElixirWithHair_DrugMadame = 5,
				AskMadameAboutAriel = 6,
				ReportToAriel = 7,
			},
			KillerLiquor = {
				FindVodkaForGertrude = 1,
				BringVodkaToKonmuld = 2,
				AskKonmuldForMission = 3,
			},
			PreludeToThaumaturgy = {
				AskGraveDiggerForhelp = 1,
				DigUpVirginSoul = 2,
				ReportToKonmuld = 3,
				ChooseYalahariPiece = 4,
			},
			RadioFreeHirschberg = {
				FindRadio = 1,
				BringRadioToAriel = 2,
				RepairRadioAtCelebimber = 3,
				ListenToRadio = 4,
				EscortAmee = 5,
				FindHouse = 6,
				FindMonument = 7,
			},
		}
		QuestTopics.ArielsFriend = {
			AcceptFlowerQuest = NextTopic(),
			AcceptLoveQuest = NextTopic(),
			AcceptVodkaQuest = NextTopic(),
			AcceptReward = NextTopic(),
			AcceptStartAmeeEsort = NextTopic(),
			AcceptHandInRadioToAmee = NextTopic(),
		}
	end)
	:Constant(function()
		QuestKeyItems.ArielsFriend = {
			HairStrand = { id = 36809, key = Storage.ArielsFriend.HairStrand, desc = "Ariel's strand of hair. It might prove useful later." },
			LoveElixirRaw = { id = elixirId, key = Storage.ArielsFriend.LoveElixirRaw, desc = "Raw magical elixir. Use with caution!" },
			LoveElixirEnchanted = { id = elixirId, key = Storage.ArielsFriend.LoveElixirEnchanted, desc = "Enchanted magical elixir" },
			LiquorItem = { id = 6106, key = Storage.ArielsFriend.LiquorItem },
			OldRadioBroken = { id = 12813, key = Storage.ArielsFriend.OldRadioBroken, desc = "made in Hirschberg Manufacture LLC" },
			OldRadioWorking = { id = 12813, key = Storage.ArielsFriend.OldRadioWorking, desc = "made in Hirschberg Manufacture LLC" },
			AmeeMap = { id = 22107, key = Storage.ArielsFriend.AmeeMap },
		}
		local ameeEscort = EscortData({
			key = Storage.ArielsFriend.AmeeEscort,
			timeLimitSeconds = 600,
			startAfterSeconds = 2,
			destinationPos = Position(7478, 1163, 4),
			proximityToSucceed = 3,
			requiredState = {
				[Storage.ArielsFriend.RadioFreeHirschberg] = QuestState.ArielsFriend.RadioFreeHirschberg.EscortAmee,
			},
			nextState = {
				[Storage.ArielsFriend.RadioFreeHirschberg] = QuestState.ArielsFriend.RadioFreeHirschberg.FindHouse,
			},
			rewards = {
				QuestKeyItems.ArielsFriend.AmeeMap,
			},
			expReward = 900000,
		})
		EscortRegistry:Register(ameeEscort)

		QuestRewards.OutfitsAddons.ArielsFriend = {
			Yalaharian3 = {
				{ outfitId = 324, addons = 3 },
				{ outfitId = 325, addons = 3 },
			},
			BattleMage0 = {
				{ outfitId = 1069, addons = 0 },
				{ outfitId = 1070, addons = 0 },
			},
		}
	end)
	:Questlog(function(localizer)
		table.insert(Questlog, {
			name = "Ariel's Friend",
			localizer = localizer,
			missions = {
				{
					name = "Mission 1: Humble Request",
					storage = Storage.ArielsFriend.HumbleRequest,
					states = {
						[QuestState.ArielsFriend.HumbleRequest.PutFlowerOnGrave] = "Ariel asked you to pay respect to his friend by laying heaven flowers on their grave. You can find him tombstone located on a nearby hill. Should you succeed, Ariel will reveal his people story.",
						[QuestState.ArielsFriend.HumbleRequest.ReportToAriel] = "You put the flowers on Ariel's friend's grave, now come back to Ariel.",
						[QuestState.ArielsFriend.HumbleRequest.AskForNewMission] = "Ariel endowed you with a bow and a few minor gifts. He is now ready to tell you his story, whenever you ask him to do so.",
						[MISSION_FINISHED] = "You finished this mission.",
					},
				},
				{
					name = "Mission 2: Love is in the air",
					storage = Storage.ArielsFriend.LoveIsInTheAir,
					states = {
						[QuestState.ArielsFriend.LoveIsInTheAir.HandInvitationToMadame] = "Ariel asked you to hand over a party invitation to Madame Malkin.",
						[QuestState.ArielsFriend.LoveIsInTheAir.AskPostmanForHelp] = "Madame Malkin refused Ariel's request to go out with him. Perhaps Ariel's friend, Old Postman, knows a way to influence Madame Malkin.",
						[QuestState.ArielsFriend.LoveIsInTheAir.StealElixir] = "Old Postman had a disgraceful idea to steal an elixir of love. You can probably find supplies of love elixir at Alchemists' quarters, north of MirkoTown.",
						[QuestState.ArielsFriend.LoveIsInTheAir.ReportToPostman] = "Success! You filled the vial with an elixir. Go back to the postman and ask him for further directions.",
						[QuestState.ArielsFriend.LoveIsInTheAir.EnchantElixirWithHair_DrugMadame] = "Old Postman mentioned that in order for the elixir to properly work, you need to dilute Ariel's string of hair in it. After you do this, bring the elixir to Madame Malkin.",
						[QuestState.ArielsFriend.LoveIsInTheAir.AskMadameAboutAriel] = "Madame Malkin chugged the elixir which will make her love Ariel. Talk to her again after some time and mention Ariel.",
						[QuestState.ArielsFriend.LoveIsInTheAir.ReportToAriel] = 'Turns out that the "wine" worked as intended. Tell Ariel about it.',
						[MISSION_FINISHED] = "Ariel rejoices knowing about Madame's feelings. He also revealed the secret Hirschberg greeting to you: Aloha. You can visit Gertrdue or Konmuld now.",
					},
				},
				{
					name = "Mission 3: A Killer Liquor",
					storage = Storage.ArielsFriend.KillerLiquor,
					states = {
						[QuestState.ArielsFriend.KillerLiquor.FindVodkaForGertrude] = "Find an immensely strong vodka in the lizard spiral tower, and bring it to Gertrude.",
						[QuestState.ArielsFriend.KillerLiquor.BringVodkaToKonmuld] = "In exchange for your help with finding the beverage, Gertruda is willing to lead you to konmuld. Look for him in the southern steppes.",
						[QuestState.ArielsFriend.KillerLiquor.AskKonmuldForMission] = "After treating Konmuld with vodka, he agreed to talk with you.",
						[MISSION_FINISHED] = "You finished this mission.",
					},
				},
				{
					name = "Mission 4: Prelude to Thaumaturgy",
					storage = Storage.ArielsFriend.PreludeToThaumaturgy,
					states = {
						[QuestState.ArielsFriend.PreludeToThaumaturgy.AskGraveDiggerForhelp] = "Konmuld asked you to bring him a virgin's soul. You can ask Grave Digger for help with your mission.",
						[QuestState.ArielsFriend.PreludeToThaumaturgy.DigUpVirginSoul] = "Grave Digger said that there are no remaining virgins left, however, you can dig up a virgin's soul from a grave.",
						[QuestState.ArielsFriend.PreludeToThaumaturgy.ReportToKonmuld] = "You managed to get a virgin's soul. Now go see Konmuld.",
						[QuestState.ArielsFriend.PreludeToThaumaturgy.ChooseYalahariPiece] = "Konmuld offered you to choose one of the Yalahari set pieces to keep for yourself.",
						[MISSION_FINISHED] = "In his gratitude, Konmuld gave you one of his old Yalahari set pieces.",
					},
				},
				{
					name = "Mission 5: Radio free Hirschberg",
					storage = Storage.ArielsFriend.RadioFreeHirschberg,
					states = {
						[QuestState.ArielsFriend.RadioFreeHirschberg.FindRadio] = "Konmuld mentioned to search the Retro Knurow for a lost radio of old.",
						[QuestState.ArielsFriend.RadioFreeHirschberg.BringRadioToAriel] = "Bring the radio to Ariel.",
						[QuestState.ArielsFriend.RadioFreeHirschberg.RepairRadioAtCelebimber] = "Ariel told you that Celebimber could have the skills requied to repair the radio. Try to find him in Kongo.",
						[QuestState.ArielsFriend.RadioFreeHirschberg.ListenToRadio] = "Try to listen to radio.",
						[QuestState.ArielsFriend.RadioFreeHirschberg.EscortAmee] = "You gave your radio to 4M-33. Rescue it now. It said that you should escort it to carpet, southwest from here.",
						[QuestState.ArielsFriend.RadioFreeHirschberg.FindHouse] = 'You helped 4M-33 get out. It gave you its map and the password "chamek athra thull zathroth". On its way to carpet it also mentioned that you shall find a monument before which you shall utter this password.',
						[QuestState.ArielsFriend.RadioFreeHirschberg.FindMonument] = "You found the abandoned house 4M-33 mentioned. Try finding the monument it was talking about and say the password before it. You recall password as 'chamek athra thull zathroth'",
						[MISSION_FINISHED] = "You found your way to the secret library.",
					},
				},
			},
		})
	end)
	:Mission(Storage.ArielsFriend.HumbleRequest)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Ariel", {
				[{ "mission", "misja" }] = {
					text = "I've wanted to pick my friend's favourite flowers to put them on his grave for a week now, but I am too busy. Would you help me?",
					nextTopic = QuestTopics.ArielsFriend.AcceptFlowerQuest,
				},
				[{ "yes", "tak" }] = {
					text = "My friend's favorite flower was {heaven blossom}. Please, find one and put it on his grave. I would be very grateful and tell you a {story} if you succeed.",
					requiredTopic = QuestTopics.ArielsFriend.AcceptFlowerQuest,
					nextState = {
						[Storage.ArielsFriend.HumbleRequest] = QuestState.ArielsFriend.HumbleRequest.PutFlowerOnGrave,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ArielsFriend.HumbleRequest.PutFlowerOnGrave,
			QuestFactory.Dialog("Ariel", {
				[{ "mission", "misja", "heaven blossom" }] = {
					text = "Heaven blossom is a rare commodity amongst elves. Please find it and place it on my friend grave that is on top of the hill, northwest from here.",
				},
			}),
			QuestFactory.Script(function(missionState)
				local friendGrave = Action()
				function friendGrave.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:HasExactMissionState(missionState) then
						return false
					end

					if player:TryRemoveItems({ { id = 5921 } }) then
						player:setStorageValueByKey(Storage.ArielsFriend.HumbleRequest, QuestState.ArielsFriend.HumbleRequest.ReportToAriel)
					end
					return true
				end
				friendGrave:key(Storage.ArielsFriend.FriendGrave)
				friendGrave:register()
			end)
	end)
	:State(function()
		return QuestState.ArielsFriend.HumbleRequest.ReportToAriel,
			QuestFactory.Dialog("Ariel", {
				[{ "mission", "misja" }] = {
					text = "Wow! I can feel the flow of positive energy. Even the flowers started to sing from happiness. Thank you for your help, my friend. Here, keep your reward. I can tell you my {story}, if you want.",
					nextState = {
						[Storage.ArielsFriend.HumbleRequest] = QuestState.ArielsFriend.HumbleRequest.AskForNewMission,
					},
					rewards = {
						{ id = 7438 },
						{ id = 3061 },
						{ id = 3048, count = 20 },
						{ id = 3728, count = 5 },
					},
					expReward = 3000,
				},
			})
	end)
	:State(function()
		return QuestState.ArielsFriend.HumbleRequest.AskForNewMission,
			QuestFactory.Dialog("Ariel", {
				[{ "story", "historia", "historie", "mission" }] = {
					text = "Oh, yes. I promised to tell you my story. Well, I come from the legendary town of Hirschberg, which was located on an island. However, the rulers of this town were too greedy and eventually all of our districts rebelled. There was a huge battle that was topped off by an enormous explosion of the bomb invented by the crazy alchemist.\nI survived because I left there as soon as the riots broke out, unfortunately all my family died. Besides me, a few more inhabitants fled. At first we stuck together, but eventually we parted ways. Last time I saw {Gertrude} in the jungle. {Konmuld} on the other hand, he went the wrong way, and decided to devote himself to black magic. I did not know the other survivors, but maybe Gertrude or Konmuld will know where they are. ...\nHowever, I don't know if they will want to talk to you, peopel of Hirschberg are very distrustful of strangers, but I can reveal to you our greeting with which you will surely gain their trust. But first, please help me win my love's heart, will you do it for me?",
					nextTopic = QuestTopics.ArielsFriend.AcceptLoveQuest,
				},
				[{ "yes", "tak" }] = {
					text = "I knew that I can rely on you. Her name is Madame Malkin, she deals with clothes and fabrics. Please, deliver this invitation.. If by any chance she accepts, come back to me. In other case i would like you to visit my friend Old Postman he might have idea better than party invitation.",
					nextState = {
						[Storage.ArielsFriend.HumbleRequest] = MISSION_FINISHED,
						[Storage.ArielsFriend.LoveIsInTheAir] = QuestState.ArielsFriend.LoveIsInTheAir.HandInvitationToMadame,
					},
				},
			}),
			QuestFactory.OnUseDeclarations({
				{
					id = 5499,
					key = Storage.ArielsFriend.Haybed,
					rewards = { QuestKeyItems.ArielsFriend.HairStrand },
					requiredState = {
						[Storage.ArielsFriend.LoveIsInTheAir] = { min = MISSION_STARTED },
					},
				},
			})
	end)
	:State(function()
		return { min = QuestState.ArielsFriend.HumbleRequest.AskForNewMission }, QuestFactory.Dialog("Ariel", {
			[{ "gertrude", "Gertrude" }] = {
				text = "She moved near the lizards' village. They stay out of each other's way though.",
			},
			[{ "konmuld", "Konmuld" }] = {
				text = "He holed up in an abandoned village on steppes. I don't think anyone visits him there.",
			},
		})
	end)
	:Mission(Storage.ArielsFriend.LoveIsInTheAir)
	:State(function()
		return QuestState.ArielsFriend.LoveIsInTheAir.HandInvitationToMadame,
			QuestFactory.Dialog("Madame Malkin", {
				[{ "mission", "ariel", "misja" }] = {
					text = "Ariel? The one who lives in this funny hut in the west? He sent you this time? \nTell him that I'm not going to any party with him.",
					nextState = {
						[Storage.ArielsFriend.LoveIsInTheAir] = QuestState.ArielsFriend.LoveIsInTheAir.AskPostmanForHelp,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ArielsFriend.LoveIsInTheAir.AskPostmanForHelp,
			QuestFactory.Dialog("Ariel", {
				[{ "mission", "misja" }] = {
					text = "I expected that she wouldn't want to go.. I have to convince her in some other way, but I'm out of ideas. Please, visit my friend Old Postman, he's really wise and always have some good ideas.",
				},
			}),
			QuestFactory.Dialog("Old Postman", {
				[{ "eliksir", "madame", "mikstura", "elixir", "milosc", "love", "zaproszenie", "invitation", "potion", "ariel" }] = {
					text = "So Madame Malkin still doesn't want to accept a meeting with Ariel... I have an idea. Ariel won't like it but he doesn't have to know anything. ...\nIn the north of the city, there is a village of alchemists. Apparently, they have a laboratory there in which they created love elixirs. Try to steal it, and I will tell you what's next.",
					nextState = {
						[Storage.ArielsFriend.LoveIsInTheAir] = QuestState.ArielsFriend.LoveIsInTheAir.StealElixir,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ArielsFriend.LoveIsInTheAir.StealElixir, QuestFactory.OnUseDeclarations({
			{
				id = 8998,
				key = Storage.ArielsFriend.ElixirStand,
				rewards = { QuestKeyItems.ArielsFriend.LoveElixirRaw },
				nextState = {
					[Storage.ArielsFriend.LoveIsInTheAir] = QuestState.ArielsFriend.LoveIsInTheAir.ReportToPostman,
				},
			},
		})
	end)
	:State(function()
		return QuestState.ArielsFriend.LoveIsInTheAir.ReportToPostman,
			QuestFactory.Dialog("Old Postman", {
				[{ "eliksir", "madame", "mikstura", "elixir", "milosc", "love" }] = {
					text = "If we have an elixir, we do need to get Ariel's hair to dissolve it in it...\nGo to him and look for his hair in his bed, there must be something. Next, give Madame the love elixir as wine from me.",
					nextState = {
						[Storage.ArielsFriend.LoveIsInTheAir] = QuestState.ArielsFriend.LoveIsInTheAir.EnchantElixirWithHair_DrugMadame,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ArielsFriend.LoveIsInTheAir.EnchantElixirWithHair_DrugMadame,
			QuestFactory.OnUseDeclarations({
				{
					key = Storage.ArielsFriend.HairStrand,
					requiredItems = {
						QuestKeyItems.ArielsFriend.LoveElixirRaw,
						QuestKeyItems.ArielsFriend.HairStrand,
					},
					rewards = {
						QuestKeyItems.ArielsFriend.LoveElixirEnchanted,
					},
					specialActionsOnSuccess = {
						{
							action = SPECIAL_ACTIONS_UNIVERSAL.sendMagicEffectPlayer,
							effect = CONST_ME_SOUND_GREEN,
						},
					},
				},
			}),
			QuestFactory.Dialog("Madame Malkin", {
				[{ "mission", "misja", "wino", "wine", "ariel" }] = {
					text = "Ahh, I love these exotic ones from Old Postman, I'll taste them immediately at the spot.\nArrrgh, disgusting. Tell him that he should never order this one again.",
					requiredItems = {
						QuestKeyItems.ArielsFriend.LoveElixirEnchanted,
					},
					nextState = {
						[Storage.ArielsFriend.LoveIsInTheAir] = QuestState.ArielsFriend.LoveIsInTheAir.AskMadameAboutAriel,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ArielsFriend.LoveIsInTheAir.AskMadameAboutAriel, QuestFactory.Dialog("Madame Malkin", {
			[{ "mission", "misja", "ariel" }] = {
				text = "Party invitation from my lovely Ariel? Of course I will go. Tell him to pick me up at 6pm.",
				nextState = {
					[Storage.ArielsFriend.LoveIsInTheAir] = QuestState.ArielsFriend.LoveIsInTheAir.ReportToAriel,
				},
			},
		})
	end)
	:State(function()
		return QuestState.ArielsFriend.LoveIsInTheAir.ReportToAriel,
			QuestFactory.Dialog("Ariel", {
				[{ "madame", "malkin", "mission", "misja" }] = {
					text = "She agreed? How did you do that? Well, that doesn't matter now, thank you from the bottom of my heart. Here is small gift for you, and as I promissed, our secrest password: Aloha.\nI hope that you'll visit me someday.",
					rewards = {
						{ id = 5922, count = 5 },
						{ id = 3082, count = 50 },
					},
					expReward = 70000,
					nextState = {
						[Storage.ArielsFriend.LoveIsInTheAir] = MISSION_FINISHED,
					},
				},
			})
	end)
	:Mission(Storage.ArielsFriend.KillerLiquor)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Gertrude", {
				[{ "aloha" }] = {
					text = "I see you have met one of our brothers. Welcome to our family then, there are not many of us left in this world.\nIf you want, I can tell you a part of our {story}.",
					nextTopic = QuestTopics.ArielsFriend.AcceptVodkaQuest,
					requiredState = {
						[Storage.ArielsFriend.LoveIsInTheAir] = MISSION_FINISHED,
					},
					textNoRequiredState = "I don't know who told you this password. Go away please.",
				},
				[{ "yes", "tak", "story", "mission", "misja", "historii", "historie", "historia" }] = {
					text = "Can you see the lizard village south to my hut? They have a strange plant that they use to produce vodka most potent. Once, i took two sips of this beverage... i dont remember much after, as i slept for next two days. \nIm now getting ready to visit my friend Konmuld. Hes not very talkative outside of the time he is drunk.\n\nPlease steal some of this liquor from lizards if you want me to continue out story.",
					requiredTopic = QuestTopics.ArielsFriend.AcceptVodkaQuest,
					nextState = {
						[Storage.ArielsFriend.KillerLiquor] = QuestState.ArielsFriend.KillerLiquor.FindVodkaForGertrude,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ArielsFriend.KillerLiquor.FindVodkaForGertrude,
			QuestFactory.Dialog("Gertrude", {
				[{
					"misja",
					"mission",
					"historia",
					"story",
					"historii",
					"butelka",
					"wodka",
				}] = {
					text = "Uuuu, I can smell it through the cork, you did great. I'll tell you how it went.\nI was an apprentice to the great alchemist, the one who, as you probably know, blew up the whole island. But do not trust those who say that he was mad.\nIn fact, he was constructing a mechanism that would enclose the whole island in a force field and force the rulers to surrender. He wanted everyone to live in harmony.\nUnfortunately, the government found out thanks to their spies, and forced him to change his plans. Initially it was supposed to be 2 small bombs, to destroy the strongest districts.\nBut it was not enough for them...  They wanted a bigger bomb, which would destroy the whole island. Now there are only ruins left, but I still believe that one day we will rebuild Hirschberg. You might wanna visit him in the southern steppes.\nIn addition, at the alchemist's I dealt with the creation of various decoctions for everyday problems, if you have a problem and need any effective remedy, I will be here for you.",
					requiredItems = { { id = QuestKeyItems.ArielsFriend.LiquorItem.id, key = QuestKeyItems.ArielsFriend.LiquorItem.key, remove = false } },
					nextState = { [Storage.ArielsFriend.KillerLiquor] = QuestState.ArielsFriend.KillerLiquor.BringVodkaToKonmuld },
					expReward = 150000,
				},
			}),
			QuestFactory.OnUseDeclarations({
				{
					key = Storage.ArielsFriend.LiquorChest,
					rewards = { QuestKeyItems.ArielsFriend.LiquorItem },
					requiredState = {},
				},
			})
	end)
	:State(function()
		return QuestState.ArielsFriend.KillerLiquor.BringVodkaToKonmuld,
			QuestFactory.Dialog("Konmuld", {
				[{ "aloha" }] = {
					text = "Im not in the mood to talk with you.",
				},
				[{ "wodka", "trunek", "vodka", "liquor" }] = {
					text = "Now we can talk! Who bring you there?",
					requiredItems = {
						QuestKeyItems.ArielsFriend.LiquorItem,
					},
					nextState = {
						[Storage.ArielsFriend.KillerLiquor] = QuestState.ArielsFriend.KillerLiquor.AskKonmuldForMission,
						[Storage.ArielsFriend.PreludeToThaumaturgy] = QuestState.ArielsFriend.PreludeToThaumaturgy.AskGraveDiggerForhelp,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ArielsFriend.KillerLiquor.AskKonmuldForMission,
			QuestFactory.Dialog("Konmuld", {
				[{ "aloha" }] = {
					text = "Im not in the mood to talk with you.",
				},
				[{ "mission", "misja", "dusza", "gertruda", "virgin", "soul", "dziewica" }] = {
					text = "I'll tell you what we will do. For a few years I have been studying the art of secret black magic. Still the soul of the virgin is missing.\nI don't know how to get it, but {someone} will know for sure. Try to find out and bring me at least one soul. I'll give you one piece of my old set.",
					nextState = {
						[Storage.ArielsFriend.KillerLiquor] = MISSION_FINISHED,
						[Storage.ArielsFriend.PreludeToThaumaturgy] = QuestState.ArielsFriend.PreludeToThaumaturgy.AskGraveDiggerForhelp,
					},
				},
			})
	end)
	:Mission(Storage.ArielsFriend.PreludeToThaumaturgy)
	:State(function()
		return QuestState.ArielsFriend.PreludeToThaumaturgy.AskGraveDiggerForhelp,
			QuestFactory.Dialog("Grave Digger", {
				[{ "dusze", "dusza", "dusza dziewicy", "soul", "souls", "virgin's soul", "someone" }] = {
					text = "Oh yes, I remember when we were young we used to hunt for virgins. Now these foolish girls are banging left and right. It's hard to find any left.\nBut it is very possible that you can squeeze something out of dead virgins. So the only solution I see is a shovel in my hand and digging {graves}, which is what I like best!",
					nextState = {
						[Storage.ArielsFriend.PreludeToThaumaturgy] = QuestState.ArielsFriend.PreludeToThaumaturgy.DigUpVirginSoul,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ArielsFriend.PreludeToThaumaturgy.DigUpVirginSoul,
			QuestFactory.Dialog("Grave Digger", {
				[{ "dusza", "soul", "graves", "groby" }] = {
					text = "You can surely find graves on cemetery in Mirkotown and also in Knurow. I heard that there is one somewhere to the north of here.",
				},
			}),
			QuestFactory.Script(function(missionState)
				local grave = Action()

				function grave.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:HasExactMissionState(missionState) then
						return false
					end

					local requiredRoll = 100 - (player:getStorageValueByKey(Storage.ArielsFriend.GravesSoulChance) or 0)
					local roll = math.random(1, 100)
					if roll >= requiredRoll then
						Game.createMonster("Ghost", player:getPosition())
						player:setStorageValueByKey(Storage.ArielsFriend.PreludeToThaumaturgy, QuestState.ArielsFriend.PreludeToThaumaturgy.ReportToKonmuld)
					else
						Game.createMonster("Ghoul", player:getPosition())
						player:incrementStorageByKeyClampZero(Storage.ArielsFriend.GravesSoulChance, 10)
					end
					return true
				end

				grave:key(Storage.ArielsFriend.VirginGrave)
				grave:register()
			end)
	end)
	:State(function()
		return QuestState.ArielsFriend.PreludeToThaumaturgy.ReportToKonmuld,
			QuestFactory.Dialog("Konmuld", {
				[{ "mission", "misja", "dusza", "gertruda" }] = {
					text = "GREAT! I will create a virgin from that soul just for myself!\nAs I promised, you can choose one of yalahari pieces: {mask}, {legs} or {armor}. What is your choice?",
					expReward = 75000,
					outfitRewards = QuestRewards.OutfitsAddons.ArielsFriend.Yalaharian3,
					nextState = {
						[Storage.ArielsFriend.PreludeToThaumaturgy] = QuestState.ArielsFriend.PreludeToThaumaturgy.ChooseYalahariPiece,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ArielsFriend.PreludeToThaumaturgy.ChooseYalahariPiece,
			QuestFactory.Dialog("Konmuld", {
				[{ "mission", "misja", "dusza", "gertruda", "yalahari" }] = {
					text = "As I promised, you can choose one of yalahari pieces: {mask}, {legs} or {armor}. What is your choice?",
					nextTopic = QuestTopics.ArielsFriend.AcceptReward,
				},
				[{ "mask", "maska" }] = {
					text = "Heres your reward! I guess i can trust you now. I might have another {mission} for you.",
					rewards = {
						{ id = 8864 },
					},
					nextState = {
						[Storage.ArielsFriend.PreludeToThaumaturgy] = MISSION_FINISHED,
					},
				},
				[{ "legs", "spodnie" }] = {
					text = "Heres your reward! I guess i can trust you now. I might have another {mission} for you.",
					rewards = {
						{ id = 8863 },
					},
					nextState = {
						[Storage.ArielsFriend.PreludeToThaumaturgy] = MISSION_FINISHED,
					},
				},
				[{ "armor" }] = {
					text = "Heres your reward! I guess i can trust you now. I might have another {mission} for you.",
					rewards = {
						{ id = 8862 },
					},
					nextState = {
						[Storage.ArielsFriend.PreludeToThaumaturgy] = MISSION_FINISHED,
					},
				},
			})
	end)
	:Mission(Storage.ArielsFriend.RadioFreeHirschberg)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Konmuld", {
				[{ "mission", "misja", "aloha", "misje" }] = {
					text = "Before we migrated here, Ariel had a grandpa who was an inventor. His magic skills are nothing compared to mine, but his engineering skills were something else.. Long story short: i was in Retro Knurowo - scrapping some valubles with my metal detector - i encountered some weird signals, similar to ones from our radios. Should you find this radio, you should consult Ariel.",
					nextState = {
						[Storage.ArielsFriend.RadioFreeHirschberg] = QuestState.ArielsFriend.RadioFreeHirschberg.FindRadio,
					},
					requiredState = {
						[Storage.ArielsFriend.PreludeToThaumaturgy] = MISSION_FINISHED,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ArielsFriend.RadioFreeHirschberg.FindRadio, QuestFactory.OnUseDeclarations({
			{
				key = Storage.ArielsFriend.OldRadioContainer,
				rewards = {
					QuestKeyItems.ArielsFriend.OldRadioBroken,
				},
				nextState = {
					[Storage.ArielsFriend.RadioFreeHirschberg] = QuestState.ArielsFriend.RadioFreeHirschberg.BringRadioToAriel,
				},
			},
		})
	end)
	:State(function()
		return QuestState.ArielsFriend.RadioFreeHirschberg.BringRadioToAriel,
			QuestFactory.Dialog("Ariel", {
				[{ "radio", "old radio", "stare radio" }] = {
					text = "This radio looks very similar to ones we had back in Hirschberg. I cannot make it {work} again, its just some buzzing.",
				},
				[{ "work", "naprawic" }] = {
					text = "I heard about this elvish engineer who tinkers with things like this one. You can ask him for help. His name is Celebimber. You shall find him in the jungle of Kongo.",
					requiredItems = {
						QuestKeyItems.ArielsFriend.OldRadioBroken,
					},
					rewards = {
						QuestKeyItems.ArielsFriend.OldRadioBroken,
					},
					nextState = {
						[Storage.ArielsFriend.RadioFreeHirschberg] = QuestState.ArielsFriend.RadioFreeHirschberg.RepairRadioAtCelebimber,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ArielsFriend.RadioFreeHirschberg.RepairRadioAtCelebimber,
			QuestFactory.Dialog("Celebimber", {
				[{ "radio", "old radio", "stare radio" }] = {
					text = "Here you go",
					textNoRequiredItems = "Sure, i can repair it.. It seems like its missing its core. Bring me one spark sphere and i will repair it.",
					requiredItems = {
						{ id = 23518 },
						QuestKeyItems.ArielsFriend.OldRadioBroken,
					},
					rewards = {
						QuestKeyItems.ArielsFriend.OldRadioWorking,
					},
					nextState = {
						[Storage.ArielsFriend.RadioFreeHirschberg] = QuestState.ArielsFriend.RadioFreeHirschberg.ListenToRadio,
						[Storage.ArielsFriend.RadioMessageState] = 1,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ArielsFriend.RadioFreeHirschberg.ListenToRadio,
			QuestFactory.Script(function(missionState)
				local destinationPos = Position(7534, 1048, 6)

				local function getDistanceMessage(player)
					local dist = player:getPosition():EuclideanDistance(destinationPos)
					if dist < 50 then
						return "Help me! Im trapped in this dungeon full of Spectres! Somebody help me!"
					elseif dist < 250 then
						return "shhelp shshkshsh sshpectreshhkshk"
					elseif dist < 500 then
						return "shshshei khahkhkr shpesh"
					elseif dist < 1000 then
						return "kshkskksshhhshh"
					else
						return "Complete silence"
					end
				end

				local radioUse = Action()
				function radioUse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					player:say(getDistanceMessage(player), TALKTYPE_ORANGE_1)
					return true
				end
				radioUse:key(Storage.ArielsFriend.OldRadioWorking)
				radioUse:register()
			end),
			QuestFactory.Dialog("4M-33 Mk II", {
				[{ "mission", "misja" }] = {
					text = "I see you heard me through your radio and came to help me. I cannot move, as they removed my core.. altough your {radio} may just be a fine substitute.",
					nextTopic = QuestTopics.ArielsFriend.AcceptHandInRadioToAmee,
				},
				[{ "radio", "radiu" }] = {
					text = "Yes, its working. I can move on my own. You might be wondering how i ended up down there. I was designed to steal the map and password to secret library. I managed to do both of those, but my creator forgot to implement my logic after that. Didnt hear from him ever since. Just escort me to the abandoned flying carpet, south west from here, and i will give those to you. Are you ready to go now?",
					requiredTopic = QuestTopics.ArielsFriend.AcceptHandInRadioToAmee,
					nextTopic = QuestTopics.ArielsFriend.AcceptStartAmeeEsort,
					requiredItems = {
						QuestKeyItems.ArielsFriend.OldRadioWorking,
					},
					nextState = {
						[Storage.ArielsFriend.RadioFreeHirschberg] = QuestState.ArielsFriend.RadioFreeHirschberg.EscortAmee,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ArielsFriend.RadioFreeHirschberg.EscortAmee,
			QuestFactory.Dialog("4M-33 Mk II", {
				[{ "mission", "misja" }] = {
					text = "Can you help me get out of here now?",
					nextTopic = QuestTopics.ArielsFriend.AcceptStartAmeeEsort,
				},
				[{ "yes", "yes" }] = {
					text = "Lets go.",
					requiredTopic = QuestTopics.ArielsFriend.AcceptStartAmeeEsort,
					specialActionsOnSuccess = {
						{
							action = SPECIAL_ACTIONS_UNIVERSAL.startEscort,
							escortData = EscortRegistry:Get(Storage.ArielsFriend.AmeeEscort),
						},
					},
				},
			})
	end)
	:State(function()
		return QuestState.ArielsFriend.RadioFreeHirschberg.FindHouse,
			QuestFactory.Script(function()
				local destination = Position(7661, 1611, 7)
				local map = Action()
				function map.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					local vectorBetween = Vector.BetweenPositions(player:getPosition(), destination)
					local direction = vectorBetween:ToDirectionByAngle()
					local announcement = player:Localizer(LOCALIZERS.Universal):Context({ direction = direction }):Get("GO_IN_DIRECTION")

					doCreatureSay(player, announcement, TALKTYPE_ORANGE_1)
				end
				map:key(Storage.ArielsFriend.AmeeMap)
				map:register()
			end),
			QuestFactory.Script(function(missionState)
				local nextState = {
					[Storage.ArielsFriend.RadioFreeHirschberg] = QuestState.ArielsFriend.RadioFreeHirschberg.FindMonument,
				}

				local tileBeforeHouse = MoveEvent()
				function tileBeforeHouse.onStepIn(player, item, toPosition, fromPosition)
					if not player:isPlayer() then
						return
					end
					if player:HasItems({ QuestKeyItems.ArielsFriend.AmeeMap }) then
						player:RemoveItems({ QuestKeyItems.ArielsFriend.AmeeMap })
						player:getPosition():sendMagicEffect(CONST_ME_HITBYFIRE)
						player:NextState(nextState)
					end
				end
				tileBeforeHouse:key(Storage.ArielsFriend.HouseTile)
				tileBeforeHouse:type("stepin")
				tileBeforeHouse:register()
			end)
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Monument door")
		local monster = {}

		monster.description = "a mountain"
		monster.experience = 0
		monster.outfit = {
			lookType = 305,
			lookHead = 0,
			lookBody = 0,
			lookLegs = 0,
			lookFeet = 0,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 500
		monster.maxHealth = 500
		monster.race = "undead"
		monster.speed = 10
		monster.manaCost = 0

		monster.changeTarget = { interval = 3717, chance = 10 }

		monster.strategiesTarget = { nearest = 70, health = 10, damage = 10, random = 10 }

		monster.flags = {
			summonable = false,
			attackable = true,
			hostile = false,
			convinceable = false,
			pushable = false,
			rewardBoss = false,
			illusionable = false,
			canPushItems = false,
			canPushCreatures = true,
			staticAttackChance = 20,
			targetDistance = 1,
			runHealth = 0,
			healthHidden = true,
			isBlockable = false,
			canWalkOnEnergy = true,
			canWalkOnFire = true,
			canWalkOnPoison = true,
		}

		monster.light = { level = 0, color = 0 }

		monster.voices = { interval = 4999, chance = 10 }

		monster.loot = {}

		monster.attacks = {}

		monster.defenses = { defense = 25, armor = 25 }

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 100 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
			{ type = COMBAT_EARTHDAMAGE, percent = 100 },
			{ type = COMBAT_FIREDAMAGE, percent = 100 },
			{ type = COMBAT_LIFEDRAIN, percent = 100 },
			{ type = COMBAT_MANADRAIN, percent = 100 },
			{ type = COMBAT_DROWNDAMAGE, percent = 100 },
			{ type = COMBAT_ICEDAMAGE, percent = 100 },
			{ type = COMBAT_HOLYDAMAGE, percent = 100 },
			{ type = COMBAT_DEATHDAMAGE, percent = 100 },
		}

		monster.immunities = {
			{ type = "paralyze", condition = true },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = false },
		}

		local insideLibrary = Position(32515, 32537, 12)
		local outsideStandingPosition = Position(7683, 1637, 9)

		mType.onSay = function(listener, talker, type, message)
			local player = talker:getPlayer()
			if not player then
				return
			end

			if isPlayerPzLocked(player) then
				SendPlayerIsPzLocked(player)
				return false
			end

			if player:getPosition() ~= outsideStandingPosition then
				return
			end

			if player:getStorageValueByKey(Storage.ArielsFriend.RadioFreeHirschberg) == QuestState.ArielsFriend.RadioFreeHirschberg.FindMonument then
				player:setStorageValueByKey(Storage.ArielsFriend.RadioFreeHirschberg, MISSION_FINISHED)
				player:AddOutfitsAndAddons(QuestRewards.OutfitsAddons.ArielsFriend.BattleMage0)
			end

			if message:lower() == "chamek athra thull zathroth" then
				player:teleportTo(insideLibrary)
			end
		end

		mType.onSpawn = function(monster)
			monster:setOutfit({ lookTypeEx = 470 })
		end
		mType:register(monster)
	end)
	:Register()
