return {
	["Tasks"] = "Tasks",
	["Task informations"] = "Task informations",
	["TASK_MISSION_NAME"] = function(context)
		return T(":name:", { name = context.task.name })
	end,
	["TASK_MISSION_DESCRIPTION"] = function(context)
		local player = context.player
		local task = context.task

		local storage = task.storage
		local name = task.name
		local requiredKills = task.requiredKills
		local currentKills = player:getStorageValue(storage)
		return T(":name: killed: :currentKills:/:requiredKills:.", {
			name = name,
			currentKills = currentKills,
			requiredKills = requiredKills,
		})
	end,
	["FIGHT_WITH_TASK_BOSS_MISSION_NAME"] = function(context)
		return T("Fight with :bossName:", { bossName = context.task.bossName })
	end,
	["FIGHT_WITH_TASK_BOSS_MISSION_DESCRIPTION"] = function(context)
		local bossLocationDescription = context.player:Localizer(LOCALIZER_TASK_BOSS_LOCATIONS):Get(context.task.name)
		return bossLocationDescription
	end,
	["DAILY_TASK_MISSION_NAME"] = function(context)
		local dailyTask = context.dailyTask
		local name = dailyTask.name
		return T("Hunting of :name:", { name = name })
	end,
	["DAILY_TASK_PAMPHLET_DESCRIPTION"] = function(context)
		local dailyTask = GetDailyTaskByStorage(context.aid)
		context.dailyTask = dailyTask
		return context.player:Localizer(context.questId):Context(context):Get("DAILY_TASK_MISSION_DESCRIPTION")
	end,
	["DAILY_TASK_MISSION_DESCRIPTION"] = function(context)
		local player = context.player
		local dailyTask = context.dailyTask
		local name = dailyTask.name
		local currentKills = player:getStorageValue(dailyTask.storage)
		local requiredKills = dailyTask.requiredKills
		local requiredItems = dailyTask.items
		local dailyTaskDescription = T("Daily task for :name:!\n\n", { name = name })
		dailyTaskDescription = dailyTaskDescription
			.. T("You have killed :currentKills:/:requiredKills: :name:.", {
				name = name,
				currentKills = currentKills,
				requiredKills = requiredKills,
			})
		if requiredItems then
			dailyTaskDescription = dailyTaskDescription
				.. "\n\nYou will also need to bring the following creature products to the Mayor:\n"
			for _, item in pairs(requiredItems) do
				local id = item.id
				local itemName = ItemType(id):getName()
				local count = item.count
				dailyTaskDescription = dailyTaskDescription
					.. T(":count: :itemName:\n", {
						count = count,
						itemName = itemName,
					})
			end
		end
		dailyTaskDescription = dailyTaskDescription
			.. T("\nYou will get :money: gold and :tibiaCoins: store coins!", {
				money = dailyTask.money,
				tibiaCoins = dailyTask.tibiaCoins,
			})

		return dailyTaskDescription
	end,
	["QUEST_MISION_COMPLETE_SUFFIX"] = " (complete)",
	["Daily task"] = "Daily task",
	["Daily tasks information"] = "Daily tasks information",
	["Arena"] = "Arena",
	["First arena"] = "First arena",
	["Kill:\nFrostfur\nBloodpaw\nBovinus\nAchad\nColerian the Barbarian\nThe Hairy One\nAxeitus Headbanger\nRocky\nCursed Gladiator\nOrcus the Cruel"] = "Kill:\nFrostfur\nBloodpaw\nBovinus\nAchad\nColerian the Barbarian\nThe Hairy One\nAxeitus Headbanger\nRocky\nCursed Gladiator\nOrcus the Cruel",
	["Second arena"] = "Second arena",
	["Kill:\nAvalanche\nKreebosh the Exile\nThe Dark Dancer\nThe Hag\nSlim\nGrimgor Guteater\nDrasilla\nSpirit of Earth\nSpirit of Water\nSpirit of Fire"] = "Kill:\nAvalanche\nKreebosh the Exile\nThe Dark Dancer\nThe Hag\nSlim\nGrimgor Guteater\nDrasilla\nSpirit of Earth\nSpirit of Water\nSpirit of Fire",
	["Third arena"] = "Third arena",
	["Kill:\nWebster\nDarakan the Executioner\nNorgle Glacierbeard\nThe Pit Lord\nSvoren the Mad\nThe Masked Marauder\nGnorre Chyllson\nFallen Mooh'Tah Master Ghar\nDeathbringer\nThe Obliverator"] = "Kill:\nWebster\nDarakan the Executioner\nNorgle Glacierbeard\nThe Pit Lord\nSvoren the Mad\nThe Masked Marauder\nGnorre Chyllson\nFallen Mooh'Tah Master Ghar\nDeathbringer\nThe Obliverator",
	["Fourth arena"] = "Fourth arena",
	["Arena, extreme level."] = "Arena, extreme level.",
	["Firestarter"] = "Firestarter",
	["Mission 1: Fiery Beginnings"] = "Mission 1: Fiery Beginnings",
	["Hymel asked you to burn down the herbs he left on his house on north side of MikroTown."] = "Hymel asked you to burn down the herbs he left on his house on north side of MikroTown.",
	["You burnt the herbs, now talk again with Hymel."] = "You burnt the herbs, now talk again with Hymel.",
	["Hymel gave you an incendiary firebug. From now on you can buy more firebugs from him."] = "Hymel gave you an incendiary firebug. From now on you can buy more firebugs from him.",
	["Mission 2: Little Treat"] = "Mission 2: Little Treat",
	["Hymel want to mischief the local guards, by setting an old tree on fire. You can find it near their resting camp."] = "Hymel want to mischief the local guards, by setting an old tree on fire. You can find it near their resting camp.",
	["You did it, the guards didn't even notice, go back and see Hymel."] = "You did it, the guards didn't even notice, go back and see Hymel.",
	["In return for your help, Hymel gave you the staff of a real reefer."] = "In return for your help, Hymel gave you the staff of a real reefer.",
	["Mission 3: How High"] = "Mission 3: How High",
	["Hymel told you about how he and his mates once sowed 5 mysterious herbs all around MirkoTown. Unfortunately he doesn't remember where exactly they did sow them. They look like usual red flowers. Find them and set them ablaze with firebug."] = "Hymel told you about how he and his mates once sowed 5 mysterious herbs all around MirkoTown. Unfortunately he doesn't remember where exactly they did sow them. They look like usual red flowers. Find them and set them ablaze with firebug.",
	["The smell of weed is now around the whole city, you managed to burn all the flowers."] = "The smell of weed is now around the whole city, you managed to burn all the flowers.",
	["Hymel made you a true pyromaniac and gave you his arsonist weapon."] = "Hymel made you a true pyromaniac and gave you his arsonist weapon.",
	["The Way of a Druid"] = "The Way of a Druid",
	["The Council of Druids"] = "The Council of Druids",
	["You met one of the druids, if you helped him, he would tell you about the Council."] = "You met one of the druids, if you helped him, he would tell you about the Council.",
	["You helped the first druid. This is the beginning of your journey to become one of them. Find the remaining druid, and provide them with your help."] = "You helped the first druid. This is the beginning of your journey to become one of them. Find the remaining druid, and provide them with your help.",
	["The Mother Nature is watching, and she is cherishing as you helped two of the druids."] = "The Mother Nature is watching, and she is cherishing as you helped two of the druids.",
	["Your efforts induced The Mother Nature let you gather water from well at the great tree."] = "Your efforts induced The Mother Nature let you gather water from well at the great tree.",
	["You drew water from well at the sacred tree. Now try to find the next druid."] = "You drew water from well at the sacred tree. Now try to find the next druid.",
	["Your kindness goes a long way, you helped four druids so far."] = "Your kindness goes a long way, you helped four druids so far.",
	["You helped all the druids, and you have been introduced to their Council. Now you can harvest a blossom of the Griffinclaw plant, which grows inside a great tree."] = "You helped all the druids, and you have been introduced to their Council. Now you can harvest a blossom of the Griffinclaw plant, which grows inside a great tree.",
	["Deer Season"] = "Deer Season",
	["Radaghast asked you to burn down the hunters' stock of wood. This should prove to help a lot of animals to survive during the hunting season."] = "Radaghast asked you to burn down the hunters' stock of wood. This should prove to help a lot of animals to survive during the hunting season.",
	["You managed to burn down the stock of wood in the hunters' village. Make haste and tell about this to Radaghast."] = "You managed to burn down the stock of wood in the hunters' village. Make haste and tell about this to Radaghast.",
	["Radaghast handed you a slingshot for your help, also he erranded you to help other druids from the council he told you about."] = "Radaghast handed you a slingshot for your help, also he erranded you to help other druids from the council he told you about.",
	["Taken: Benek"] = "Taken: Benek",
	["Estep is Wailing since orcs taken his Wolf companion."] = "Estep is Wailing since orcs taken his Wolf companion.",
	["The wolf has been freed, deliver a good message to Estep."] = "The wolf has been freed, deliver a good message to Estep.",
	["Estep handed over this knife in his gratitude."] = "Estep handed over this knife in his gratitude.",
	["Rude eviction"] = "Rude eviction",
	["SandNigger asked you to help him reclaim his secret spell."] = "SandNigger asked you to help him reclaim his secret spell.",
	["You managed to find and combust the spell, come back to Sandnigger."] = "You managed to find and combust the spell, come back to Sandnigger.",
	["For your kind deed, you have been granted The Lion Amulet."] = "For your kind deed, you have been granted The Lion Amulet.",
	["The secret ingredient"] = "The secret ingredient",
	["Mundral asked you to get the medicine for his sick pet. You can ask Ornuld for it."] = "Mundral asked you to get the medicine for his sick pet. You can ask Ornuld for it.",
	["Turn out that Mundral belongs to the Druid Council. He put in a good word to his druid friends and he gifted you with bamboo leaves."] = "Turn out that Mundral belongs to the Druid Council. He put in a good word to his druid friends and he gifted you with bamboo leaves.",
	["The Ornuld's medicine"] = "The Ornuld's medicine",
	["Ornuld wishes to have a one wyrm egg. If you manage to do this favor, he will reward you with the medicine."] = "Ornuld wishes to have a one wyrm egg. If you manage to do this favor, he will reward you with the medicine.",
	["You found the wyrm's egg, hand it to Ornuld."] = "You found the wyrm's egg, hand it to Ornuld.",
	["Ornuld gave you the medicine in exchange for the wyrm's egg."] = "Ornuld gave you the medicine in exchange for the wyrm's egg.",
	["The Singing Crystal"] = "The Singing Crystal",
	["Malfurion is in need of an ice crystal fragment for his experiment."] = "Malfurion is in need of an ice crystal fragment for his experiment.",
	["You managed to gather a bunch of crystal, go back to Malfurion."] = "You managed to gather a bunch of crystal, go back to Malfurion.",
	["For your help, Malfurion gave you a gift."] = "For your help, Malfurion gave you a gift.",
	["Ariel's Friend"] = "Ariel's Friend",
	["Helping the Ariel"] = "Helping the Ariel",
	["Ariel asked you to bring him his friend's favorite flower. Namely it is the Heaven Blossom. Some elves keep it in their pouch."] = "Ariel asked you to bring him his friend's favorite flower. Namely it is the Heaven Blossom. Some elves keep it in their pouch.",
	["Ariel asked you to pay respect to his friend by laying these flowers on his grave. It is located on a nearby hill. If you do that, he will tell you his story."] = "Ariel asked you to pay respect to his friend by laying these flowers on his grave. It is located on a nearby hill. If you do that, he will tell you his story.",
	["You put the flowers on Ariel's friend's grave, now come back to Ariel."] = "You put the flowers on Ariel's friend's grave, now come back to Ariel.",
	["Ariel endowed you with a bow and a few minor gifts. He is now ready to tell you his story, whenever you ask him to do so."] = "Ariel endowed you with a bow and a few minor gifts. He is now ready to tell you his story, whenever you ask him to do so.",
	["Yalahari Quest"] = "Yalahari Quest",
	["Mission 1: Love is in the air"] = "Mission 1: Love is in the air",
	["Ariel asked you to hand over a party invitation to Madame Malkin."] = "Ariel asked you to hand over a party invitation to Madame Malkin.",
	["Madame refused Ariel's request to go out with him. Tell him this bad news."] = "Madame refused Ariel's request to go out with him. Tell him this bad news.",
	["Perhaps Ariel's friend, Old Postman, knows a way to influence Madame Malkin."] = "Perhaps Ariel's friend, Old Postman, knows a way to influence Madame Malkin.",
	["Old Postman had a disgraceful idea to steal an elixir of love. He told you to fill this vial he gave you. You can probably find supplies of love elixir at Alchemists' quarters, north of MirkoTown."] = "Old Postman had a disgraceful idea to steal an elixir of love. He told you to fill this vial he gave you. You can probably find supplies of love elixir at Alchemists' quarters, north of MirkoTown.",
	["Success! You filled the vial with an elixir. Go back to the postman and ask him for further directions."] = "Success! You filled the vial with an elixir. Go back to the postman and ask him for further directions.",
	["Old Postman mentioned that in order for the elixir to properly work, you need to dilute Ariel's string of hair in it. After you do this, bring the elixir to Madame Malkin."] = "Old Postman mentioned that in order for the elixir to properly work, you need to dilute Ariel's string of hair in it. After you do this, bring the elixir to Madame Malkin.",
	["Madame Malkin chugged the elixir which will make her love Ariel. Talk to her again after some time and mention Ariel's."] = "Madame Malkin chugged the elixir which will make her love Ariel. Talk to her again after some time and mention Ariel's.",
	["Turns out that the “wine” worked as intended. Tell Ariel about it."] = "Turns out that the “wine” worked as intended. Tell Ariel about it.",
	["Ariel rejoices to know about Madame's feelings. He also revealed the secret Yalaharian greeting to you: Aloha. You can visit Gertrdue or Konmuld now."] = "Ariel rejoices to know about Madame's feelings. He also revealed the secret Yalaharian greeting to you: Aloha. You can visit Gertrdue or Konmuld now.",
	["Mission 2: A morbid Liquor"] = "Mission 2: A morbid Liquor",
	["Find an immensely strong vodka in the lizard headquarters, and bring it to Gertruda."] = "Find an immensely strong vodka in the lizard headquarters, and bring it to Gertruda.",
	["In exchange for your help with finding the beverage, Gertruda is willing to help you with preparing concoctions and special rodenticides."] = "In exchange for your help with finding the beverage, Gertruda is willing to help you with preparing concoctions and special rodenticides.",
	["After treating Konmuld with vodka, he agreed to talk with you."] = "After treating Konmuld with vodka, he agreed to talk with you.",
	["Mission 3: Prelude to Thaumaturgy"] = "Mission 3: Prelude to Thaumaturgy",
	["Konmuld asked you to bring him a virgin's soul. You can ask Grave Digger for help with your mission."] = "Konmuld asked you to bring him a virgin's soul. You can ask Grave Digger for help with your mission.",
	["Grave Digger said that there are no remaining virgins left, however, you can dig up a virgin's soul from a grave."] = "Grave Digger said that there are no remaining virgins left, however, you can dig up a virgin's soul from a grave.",
	["You managed to get a virgin's soul. Now go see Konmuld."] = "You managed to get a virgin's soul. Now go see Konmuld.",
	["Konmuld offered you to choose one of the Yalahari set pieces to keep for yourself."] = "Konmuld offered you to choose one of the Yalahari set pieces to keep for yourself.",
	["In his gratitude, Konmuld gave you one of his old Yalahari set pieces."] = "In his gratitude, Konmuld gave you one of his old Yalahari set pieces.",
	["The First Steps"] = "The First Steps",
	["Research"] = "Research",
	["Find Commissioner Fisher and ask for a mission."] = "Find Commissioner Fisher and ask for a mission.",
	["Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 0/10."] = "Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 0/10.",
	["Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 1/10."] = "Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 1/10.",
	["Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 2/10."] = "Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 2/10.",
	["Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 3/10."] = "Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 3/10.",
	["Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 4/10."] = "Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 4/10.",
	["Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 5/10."] = "Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 5/10.",
	["Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 6/10."] = "Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 6/10.",
	["Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 7/10."] = "Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 7/10.",
	["Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 8/10."] = "Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 8/10.",
	["Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 9/10."] = "Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 9/10.",
	["Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 10/10."] = "Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 10/10.",
	["Wood Delivery"] = "Wood Delivery",
	["Go to Knurowo's port and find out what happened to the wood delivery."] = "Go to Knurowo's port and find out what happened to the wood delivery.",
	["Woody is sure that the wood was shipped on a caravan leaving Knurowo. He asked you to investigate this."] = "Woody is sure that the wood was shipped on a caravan leaving Knurowo. He asked you to investigate this.",
	["Tell Ryba that Narro and his mafia stole all of the wood delivery."] = "Tell Ryba that Waski and his mafia stole all of the wood delivery.",
	["Commissioner Fisher ordered you to recover the stolen wood, but he also warned you about the Narro's mafia."] = "Commissioner Fisher ordered you to recover the stolen wood, but he also warned you about the Waski's mafia.",
	["Narro gave up, and he is going to let Officer Ryba take the wood back. Report back to Ryba."] = "Waski gave up, and he is going to let Officer Ryba take the wood back. Report back to Ryba.",
	["Your merits earned you a special reward. Officer Ryba sent you to Trollsky, where you can receive your reward."] = "Your merits earned you a special reward. Officer Ryba sent you to Trollsky, where you can receive your reward.",
	["To Carry the Pigs"] = "To Carry the Pigs",
	["To be like the Schwarzenegger"] = "To be like the Schwarzenegger",
	["Collect these items for me: 5 orc tooth, 5 carrion worm fangs, and 1 vampire teeth."] = "Collect these items for me: 5 orc tooth, 5 carrion worm fangs, and 1 vampire teeth.",
	["Arni glanced at these teeth, and asked you to find someone who can make them into necklace."] = "Arni glanced at these teeth, and asked you to find someone who can make them into necklace.",
	["Madame Malkin gladly made this necklace for Arni."] = "Madame Malkin gladly made this necklace for Arni.",
	["In exchange for the teeth necklace, Arni gave u his old armour and a ring."] = "In exchange for the teeth necklace, Arni gave u his old armour and a ring.",
	["Half turn Kick"] = "Half turn Kick",
	["Cordell Walker is suspecting bandits of commissioning illegal transactions in their encampment."] = "Cordell Walker is suspecting bandits of commissioning illegal transactions in their encampment.",
	["He was right. Now go to the Price Kebab and ask Shivganesh for translation."] = "He was right. Now go to the Price Kebab and ask Shivganesh for translation.",
	["It wasn't hard at all for Shivganesh. Take the list and translation back to Cordell Walker."] = "It wasn't hard at all for Shivganesh. Take the list and translation back to Cordell Walker.",
	["You have received MirkoTown guard hat for your help."] = "You have received MirkoTown guard hat for your help.",
	["A Balanced Diet"] = "A Balanced Diet",
	["Collect 1 slimming carrot for fat Mirek."] = "Collect 1 slimming carrot for fat Mirek.",
	["The carrot was dogshit, and u received chocolate slush in for your effort."] = "The carrot was dogshit, and u received chocolate slush in for your effort.",
	["Kitz's Dominando"] = "Kitz's Dominando",
	["Arrange a special bow from elf adobe."] = "Arrange a special bow from elf adobe.",
	["You have received the item from Legolas. Go give it to Kitz."] = "You have received the item from Legolas. Go give it to Kitz.",
	["Turns out elvish bow sucks. Kitz now wishes to rook the elves. In return for your efforts you received his old bow."] = "Turns out elvish bow sucks. Kitz now wishes to rook the elves. In return for your efforts you received his old bow.",
	["Ocellatus Xddd"] = "Ocellatus Xddd",
	["Tickets"] = "Tickets",
	["Recover the match tickets whose have been stolen from Ocellatus."] = "Recover the match tickets whose have been stolen from Ocellatus.",
	["You found the Tickets in a bandits tent."] = "You found the Tickets in a bandits tent.",
	["You gave tickets back to Ocellatus."] = "You gave tickets back to Ocellatus.",
	["Ocellatus asks you to bring him specific food. Ask Pewter for help."] = "Ocellatus asks you to bring him specific food. Ask Piotrek for help.",
	["U brang food to Ocellatus. In his gratitude, he gave you outfit and let you sail his boat."] = "U brang food to Ocellatus. In his gratitude, he gave you outfit and let you sail his boat.",
	["Demon Oak"] = "Demon Oak",
	["You have made your way into the den of Demon Oak. Try to find someone who will tell you more about it."] = "You have made your way into the den of Demon Oak. Try to find someone who will tell you more about it.",
	["Oldrak gave you information regarding Demon Oak. He can bless an axe if you bring him one. The blessed axe should help you fight the Oak."] = "Oldrak gave you information regarding Demon Oak. He can bless an axe if you bring him one. The blessed axe should help you fight the Oak.",
	["You defeated the Demon Oak! Report to Oldrak."] = "You defeated the Demon Oak! Report to Oldrak.",
	["You reported to Oldrak about your victory. You have been rewarded for your efforts: Oldrak told you a secret about the way to the Elvish treasury."] = "You reported to Oldrak about your victory. You have been rewarded for your efforts: Oldrak told you a secret about the way to the Elvish treasury.",
	["Local Support"] = "Local Support",
	["Freaking Rats"] = "Freaking Rats",
	["Walmart wishes she knew how to repel rats. Find out where Gertruda lives. She should know how to craft a rat poison."] = "Walmart wishes she knew how to repel rats. Find out where Gertruda lives. She should know how to craft a rat poison.",
	["Gertruda asked you to bring her one mouldy cheese."] = "Gertruda asked you to bring her one mouldy cheese.",
	["Cheese is now poisonous. Bring it to Walmart, so she can repel the rats."] = "Cheese is now poisonous. Bring it to Walmart, so she can repel the rats.",
	["Walmart didn't have time to make use of the poisonous cheese, but she already gave you your reward: Carrot cake and a minor gift."] = "Walmart didn't have time to make use of the poisonous cheese, but she already gave you your reward: Carrot cake and a minor gift.",
	["Cheap Recycling"] = "Cheap Recycling",
	["Malkin asked you to bring her 1 piece of cloth of every color."] = "Malkin asked you to bring her 1 piece of cloth of every color.",
	["Madame Malkin is grateful for your effort, and since now you can exchange mystic turbans, red robe, and green tunic for corresponding pieces of cloth."] = "Madame Malkin is grateful for your effort, and since now you can exchange mystic turbans, red robe, and green tunic for corresponding pieces of cloth.",
	["Broken Orb"] = "Broken Orb",
	["Gypsy needs a new Crystal ball. Bring it to him, and he will reward you abundantly."] = "Gypsy needs a new Crystal ball. Bring it to him, and he will reward you abundantly.",
	["The crystal ball wasn't perfect, but Gypsy is fine with it. Since now he will also let you exchange red gem to ring of healing."] = "The crystal ball wasn't perfect, but Gypsy is fine with it. Since now he will also let you exchange red gem to ring of healing.",
	["Biodegradable"] = "Biodegradable",
	["Old postman asked you to find a package. You know that this cargo was supposed to arrive by water from the west."] = "Old postman asked you to find a package. You know that this cargo was supposed to arrive by water from the west.",
	["You found the package for Old Postman. Return to him and give it to him."] = "You found the package for Old Postman. Return to him and give it to him.",
	["You received a reward from Old Postman in exchange for helping locate the overdue shipment. He mentioned that you can also deliver Zanet's Box to Old Anon."] = "You received a reward from Old Postman in exchange for helping locate the overdue shipment. He mentioned that you can also deliver Zanet's Box to Old Anon.",
	["You took the box from Old Postman, which you should deliver to Old Anon."] = "You took the box from Old Postman, which you should deliver to Old Anon.",
	["The Silence of the Lambs"] = "The Silence of the Lambs",
	["The test of Strength"] = "The test of Strength",
	["Lecter asked you for 5 vampire teeth."] = "Lecter asked you for 5 vampire teeth.",
	["In exchange for your help, Lecter bestowed you with his old soul-extraction tool."] = "In exchange for your help, Lecter bestowed you with his old soul-extraction tool.",
	["Fashionista clothes"] = "Fashionista clothes",
	["Lecter asked you to bring him 20 leathers of every kind."] = "Lecter asked you to bring him 20 leathers of every kind.",
	["For your help you have been taught how to skin human carcass."] = "For your help you have been taught how to skin human carcass.",
	["Lecter's recipe"] = "Lecter's recipe",
	["Lecter wants you to hoard 15 human hearts and 20 human livers. He needs them for his cannibals party."] = "Lecter wants you to hoard 15 human hearts and 20 human livers. He needs them for his cannibals party.",
	["In exchange for this favor you have been introduced to the cannibal club. You also received their outfits."] = "In exchange for this favor you have been introduced to the cannibal club. You also received their outfits.",
	["Hearts collected"] = "Hearts collected",
	["Hearts collected Status"] = function(context)
		return string.format("Amount of hearts collected: %d / 15", context.player:getStorageValue(11074))
	end,
	["Livers collected"] = "Livers collected",
	["Livers collected Status"] = function(context)
		return string.format("Amount of livers collected: %d / 20", context.player:getStorageValue(11075))
	end,
	["Unwanted Guests"] = "Unwanted Guests",
	["Damned Barbarians"] = "Damned Barbarians",
	["Bring Brutetamers Staff and Fur Boots to Dziadek Mroz."] = "Bring Brutetamers Staff and Fur Boots to Dziadek Mroz.",
	["The Inquisition"] = "The Inquisition",
	["Mission 1: Interrogation"] = "Mission 1: Interrogation",
	["Your mission is to investigate the 5 guards regarding the Heretic behavior. Tim, Kulag, Grof, Miles and Walter are their names. If you do well you see a holy sprite on you."] = "Your mission is to investigate the 5 guards regarding the Heretic behavior. Tim, Kulag, Grof, Miles and Walter are their names. If you do well you see a holy sprite on you.",
	["You investigated 1 of 5 guards."] = "You investigated 1 of 5 guards.",
	["You investigated 2 of 5 guards."] = "You investigated 2 of 5 guards.",
	["You investigated 3 of 5 guards."] = "You investigated 3 of 5 guards.",
	["You investigated 4 of 5 guards."] = "You investigated 4 of 5 guards.",
	["You investigated 5 of 5 guards. Get back to Sybir and report your mission to Henricus."] = "You investigated 5 of 5 guards. Get back to Sybir and report your mission to Henricus.",
	["You investigated all guards."] = "You investigated all guards.",
	["Mission 2: Eclipse"] = "Mission 2: Eclipse",
	["Henricus tells you to get The Witches' Grimoire, he sends you to Mirko Town where you can find to the witches' swamps. Use the vial of holy water that he gives you on the big cauldron and open the chest hidden in some witch hut, then bring the witches' grimoire to Henricus."] = "Henricus tells you to get The Witches' Grimoire, he sends you to Mirko Town where you can find to the witches' swamps. Use the vial of holy water that he gives you on the big cauldron and open the chest hidden in some witch hut, then bring the witches' grimoire to Henricus.",
	["Find The Witches' Grimoire and bring it to Henricus."] = "Find The Witches' Grimoire and bring it to Henricus.",
	["You already brought The Witches' Grimoire to Henricus."] = "You already brought The Witches' Grimoire to Henricus.",
	["Mission 3: Vampire Hunt"] = "Mission 3: Vampire Hunt",
	["Henricus wants you to find the Dwarfish Vampire Hunter, Storkus, located deep in dwarven mines. It's a good idea to bring your 20 Vampire Dusts with you to save some time."] = "Henricus wants you to find the Dwarfish Vampire Hunter, Storkus, located deep in dwarven mines. It's a good idea to bring your 20 Vampire Dusts with you to save some time.",
	["Go back to Storkus and ask for a mission."] = "Go back to Storkus and ask for a mission.",
	["Now Storkus wants you to kill a vampire lord, The Count. The Count is located deep under the forgotten cemetery near the hunter camp. To summon The Count, you must use the coffin in the center of the room. Kill him and bring The Ring of the Count to Storkus."] = "Now Storkus wants you to kill a vampire lord, The Count. The Count is located deep under the forgotten cemetery near the hunter camp. To summon The Count, you must use the coffin in the center of the room. Kill him and bring The Ring of the Count to Storkus.",
	["Kill The Count and bring his ring to Storkus, and then ask for a mission."] = "Kill The Count and bring his ring to Storkus, and then ask for a mission.",
	["Return to Henricus and tell him that you've finished your job here."] = "Return to Henricus and tell him that you've finished your job here.",
	["Get back to Sybir and report your mission to Henricus."] = "Get back to Sybir and report your mission to Henricus.",
	["Mission 4: The Haunted Ruin"] = "Mission 4: The Haunted Ruin",
	["Henricus will give you a Special Flask (vial of holy water). You can find some abandoned pirate ruins near hero village in the jungle. Use this vial of holy water on some spot in the haunted ruin to drive out the evil being."] = "Henricus will give you a Special Flask (vial of holy water). You can find some abandoned pirate ruins near hero village in the jungle. Use this vial of holy water on some spot in the haunted ruin to drive out the evil being.",
	["Kill the Pirate Ghost and get back to Sybir and report your mission to Henricus."] = "Kill the Pirate Ghost and get back to Sybir and report your mission to Henricus.",
	["You already cleaned the abandoned and haunted place, ask Henricus for a new mission."] = "You already cleaned the abandoned and haunted place, ask Henricus for a new mission.",
	["Mission 5: Essential Gathering"] = "Mission 5: Essential Gathering",
	["Henricus wants 20 Demonic Essences as proof of your accomplishments."] = "Henricus wants 20 Demonic Essences as proof of your accomplishments.",
	["Now ask Henricus for an outfit to get the Demon Hunter Outfit."] = "Now ask Henricus for an outfit to get the Demon Hunter Outfit.",
	["You got the Demon Hunter Outfit! Ask Henricus for a mission to unlock more addons."] = "You got the Demon Hunter Outfit! Ask Henricus for a mission to unlock more addons.",
	["Mission 6: The Demon Ungreez"] = "Mission 6: The Demon Ungreez",
	["Henricus wants you to kill a demon called Ungreez. Head to the desert demon lair and go down a few levels."] = "Henricus wants you to kill a demon called Ungreez. Head to the desert demon lair and go down a few levels.",
	["You killed Ungreez, report your mission to Henricus."] = "You killed Ungreez, report your mission to Henricus.",
	["You got the first addon of Demon Hunter Outfit! Ask Henricus for a mission to unlock more addons."] = "You got the first addon of Demon Hunter Outfit! Ask Henricus for a mission to unlock more addons.",
	["Mission 7: The Shadow Nexus"] = "Mission 7: The Shadow Nexus",
	["Your mission is to go to the Demon Forge and slay seven of The Ruthless Seven Minions. The Demon Forge is located in the Sybir, somewhere in hidden cultist ruins."] = "Your mission is to go to the Demon Forge and slay seven of The Ruthless Seven Minions. The Demon Forge is located in the Sybir, somewhere in hidden cultist ruins.",
	["You destroyed the shadow nexus! Get back to Henricus and report your mission."] = "You destroyed the shadow nexus! Get back to Henricus and report your mission.",
	["Now ask Henricus for an outfit. He will give you the 2nd addon of the Demon Hunter Outfits."] = "Now ask Henricus for an outfit. He will give you the 2nd addon of the Demon Hunter Outfits.",
	["You got the second addon of Demon Hunter Outfit! Go now to the reward room and choose one wisely!"] = "You got the second addon of Demon Hunter Outfit! Go now to the reward room and choose one wisely!",
	["You have completed The Inquisition Quest!"] = "You have completed The Inquisition Quest!",
	["Bigfoot's Burden"] = "Bigfoot's Burden",
	["Reputation points"] = "Reputation points",
	["Current reputation points"] = function(context)
		return string.format(
			"Currently You have %d reputation points.",
			math.max(context.player:getStorageValue(921), 0)
		)
	end,
	["Daily Minor: Crystal Keeper"] = "Daily Minor: Crystal Keeper",
	["Daily Minor: Crystal Keeper Status"] = function(context)
		return string.format(
			"Use the repair crystal to repair five damaged blue crystal in the crystal caves. Damaged crystals will not glow. %d/5",
			math.max(context.player:getStorageValue(932), 0)
		)
	end,
	["Daily Minor: Raiders of the lost Spark"] = "Daily Minor: Raiders of the lost Spark",
	["Daily Minor: Raiders of the lost Spark Status"] = function(context)
		return string.format(
			"Kill Crystal Crushers and use discharger item on the corpse to collect their charges. Gather 7 charges and report back. %d/7",
			math.max(context.player:getStorageValue(934), 0)
		)
	end,
	["Daily Minor Plus: Exterminators"] = "Daily Minor Plus: Exterminators",
	["Daily Minor Plus: Exterminators Status"] = function(context)
		return string.format(
			"Kill 10 of the wigglers for the gnomes. Then report back to the gnomes. %d/10",
			math.max(context.player:getStorageValue(937), 0)
		)
	end,
	["Daily Minor Plus: Mushroom Digger"] = "Daily Minor Plus: Mushroom Digger",
	["Daily Minor Plus: Mushroom Digger Status"] = function(context)
		return string.format(
			"Find a truffle sniffing pig and lure it around. Occasionally it will unearth some truffles. Use the baby pig on the truffles to feed it 3 times. Then report back to the gnomes. %d/3",
			math.max(context.player:getStorageValue(940), 0)
		)
	end,
	["Daily Major Advanced: Spores"] = "Daily Major Advanced: Spores",
	["Gather spores in the correct order. Your spore gathering list will display the next color you have to look for."] = "Gather spores in the correct order. Your spore gathering list will display the next color you have to look for.",
	["Daily Major Advanced: Yet Another Grinding"] = "Daily Major Advanced: Yet Another Grinding",
	["Gather a grindstone from the lava area and report back."] = "Gather a grindstone from the lava area and report back.",
	["Daily Major: Matchmaker"] = "Daily Major: Matchmaker",
	["You have to enter the crystal caves and find a crystal that is fitting the crystal you got from the gnomes. Use the crystal on one of the bigger red crystal in the caves to bond them."] = "You have to enter the crystal caves and find a crystal that is fitting the crystal you got from the gnomes. Use the crystal on one of the bigger red crystal in the caves to bond them.",
	["Daily Major: The Tinker's Bell"] = "Daily Major: The Tinker's Bell",
	["Daily Major: The Tinker's Bell Status"] = function(context)
		return string.format(
			"Use the harmonic bell on the mad golems in the golem workshop so that they will automatically be teleported to the gnomish workshops. Then report back to the gnomes. %d/4.",
			math.max(context.player:getStorageValue(946), 0)
		)
	end,
	["The Ape City"] = "The Ape City",
	["Hairycles Missions"] = "Hairycles Missions",
	["Find whisper moss in the dworc settlement and bring it back to Hairycles."] = "Find whisper moss in the dworc settlement and bring it back to Hairycles.",
	["You have completed the first mission. Hairycles was happy about the whisper moss you gave to him. He might have another mission for you."] = "You have completed the first mission. Hairycles was happy about the whisper moss you gave to him. He might have another mission for you.",
	["Hairycles asked you to bring him cough syrup from a human settlement. A healer might know more about this medicine."] = "Hairycles asked you to bring him cough syrup from a human settlement. A healer might know more about this medicine.",
	["You have completed the second mission. Hairycles was happy about the cough syrup you gave to him. He might have another mission for you."] = "You have completed the second mission. Hairycles was happy about the cough syrup you gave to him. He might have another mission for you.",
	["Hairycles asked you to bring him a magical scroll from the lizard settlement."] = "Hairycles asked you to bring him a magical scroll from the lizard settlement.",
	["You have completed the third mission. Hairycles appreciated that you brought the scroll to him and will try to read it. Maybe he has another mission for you later."] = "You have completed the third mission. Hairycles appreciated that you brought the scroll to him and will try to read it. Maybe he has another mission for you later.",
	["Since Hairycles was not able to read the scroll you brought him, he asked you to visit a tomb northwest from Hurghada. Proceed in this tomb until you find an obelisk between red stones and read it."] = "Since Hairycles was not able to read the scroll you brought him, he asked you to visit a tomb northwest from Hurghada. Proceed in this tomb until you find an obelisk between red stones and read it.",
	["You have completed the fourth mission. Hairycles read your mind and can now translate the lizard scroll. He might have another mission for you."] = "You have completed the fourth mission. Hairycles read your mind and can now translate the lizard scroll. He might have another mission for you.",
	["Hairycles wants to create a life charm for the ape people. He needs a hydra egg since it has strong regenerating powers."] = "Hairycles wants to create a life charm for the ape people. He needs a hydra egg since it has strong regenerating powers.",
	["You have completed the fifth mission. Hairycles attempts to create a might charm for the protection of the ape people. He might have another mission for you later."] = "You have completed the fifth mission. Hairycles attempts to create a might charm for the protection of the ape people. He might have another mission for you later.",
	["Hairycles need a witches' cap mushroom which is supposed to grow on swamp inhabited by Beholders."] = "Hairycles need a witches' cap mushroom which is supposed to grow on swamp inhabited by Beholders.",
	["You have completed the sixth mission. You brought the witches' cap mushroom back to Hairycles. He might have another mission for you."] = "You have completed the sixth mission. You brought the witches' cap mushroom back to Hairycles. He might have another mission for you.",
	["Hairycles read that the Lizards are planning to summon the Demon Lizards to help regain their former temple. Perhaps the premature lighting of their firecamp will thwart their plans."] = "Hairycles read that the Lizards are planning to summon the Demon Lizards to help regain their former temple. Perhaps the premature lighting of their firecamp will thwart their plans.",
	["You have completed the seventh mission. You found a way to prevent the Lizards from opening the hellish gates. Hairycles might have another mission for you."] = "You have completed the seventh mission. You found a way to prevent the Lizards from opening the hellish gates. Hairycles might have another mission for you.",
	["The apes now need a symbol of their faith. Find a hair of the giant, holy ape and bring it back. It may be located in caves inhabited by Behemoths."] = "The apes now need a symbol of their faith. Find a hair of the giant, holy ape and bring it back. It may be located in caves inhabited by Behemoths.",
	["You completed the eighth mission. Hairycles gladly accepted the hair of the ape god which you brought him. He told you to have one final mission for you."] = "You completed the eighth mission. Hairycles gladly accepted the hair of the ape god which you brought him. He told you to have one final mission for you.",
	["Go into the deepest catacombs under Banuta and destroy the monument of the snake god with the hammer that Hairycles gave to you."] = "Go into the deepest catacombs under Banuta and destroy the monument of the snake god with the hammer that Hairycles gave to you.",
	["You successfully destroyed the monument of the snake god. As reward, you can buy sacred statues from Hairycles. If you haven't done so yet, you should also ask him for a shaman outfit."] = "You successfully destroyed the monument of the snake god. As reward, you can buy sacred statues from Hairycles. If you haven't done so yet, you should also ask him for a shaman outfit.",
	["The Dream Courts"] = "The Dream Courts",
	["Find and talk to Vanys in order to help him. He stays in Summer Court in the huge forest located far south from Mirko Town."] = "Find and talk to Vanys in order to help him. He stays in Summer Court in the huge forest located far south from Mirko Town.",
	["Vanys gave you a dream talisman that you'll need to empower eight ward stones located around the world. Ward stone locations you were told about are: mountains of Pirate Island, bonebast coast in the desert, water elemental cave beneath Kongo, depths of Seacrest Serpent lair, west coast of Sybir and Barbarian camp, Nightmare Island, Buried Cathedral beneath Karaiby."] = "Vanys gave you a dream talisman that you'll need to empower eight ward stones located around the world. Ward stone locations you were told about are: mountains of Pirate Island, bonebast coast in the desert, water elemental cave beneath Kongo, depths of Seacrest Serpent lair, west coast of Sybir and Barbarian camp, Nightmare Island, Buried Cathedral beneath Karaiby.",
	["Vanys let you enter the dream labyrinth. Find a way to enter the Nightmare Beast's lair and defeat him. Elven Parchment from Vanys chest may help you."] = "Vanys let you enter the dream labyrinth. Find a way to enter the Nightmare Beast's lair and defeat him. Elven Parchment from Vanys chest may help you.",
	["You have defeated The Nightmare Beast. Talk about this to Vanys."] = "You have defeated The Nightmare Beast. Talk about this to Vanys.",
	["Vanys gifted you with a traditional dream warrior outfit."] = "Vanys gifted you with a traditional dream warrior outfit.",
	["Helping of Stricken Soul"] = "Helping of Stricken Soul",
	["Restore connection and open this nexus to access the buried cathedral. You need to find a way to pass the entrance in the cellar."] = "Restore connection and open this nexus to access the buried cathedral. You need to find a way to pass the entrance in the cellar.",
	["You successfully passed the cellar entrance. Find a way to restore the portal to the buried cathedral."] = "You successfully passed the cellar entrance. Find a way to restore the portal to the buried cathedral.",
	["You restored a portal and successfully entered the buried cathedral. Try to find and defeat the Faceless Bane. You'll need to gain some knowledge in order to enter her nest. Maybe there are some documents around..."] = "You restored a portal and successfully entered the buried cathedral. Try to find and defeat the Faceless Bane. You'll need to gain some knowledge in order to enter her nest. Maybe there are some documents around...",
	["You successfully defeated the Faceless Bane."] = "You successfully defeated the Faceless Bane.",
	["Empowered Wardstones"] = "Empowered Wardstones",
	["Empowered Wardstones Status"] = function(context)
		return string.format("Empowered Wardstones: %d / 8.", (math.max(context.player:getStorageValue(12209), 0)))
	end,
	["Readed documents"] = "Readed documents",
	["Readed documents Status"] = function(context)
		return string.format("Readed documents: %d / 4", (math.max(context.player:getStorageValue(12214), 0)))
	end,
	["Liquid Black"] = "Liquid Black",
	["Visitor"] = "Visitor",
	["You have found notes and coordinates. Try to find out what they are for."] = "You have found notes and coordinates. Try to find out what they are for.",
	["You got teleported to Mezamir by a strange teleporter. Ask him about this machine."] = "You got teleported to Mezamir by a strange teleporter. Ask him about this machine.",
	["Mezamir let you dive into the place he tried to discover years ago. Find a large staircase heading underwater on Pirate Island and find out what's below."] = "Mezamir let you dive into the place he tried to discover years ago. Find a large staircase heading underwater on Pirate Island and find out what's below.",
	["You have found a shortcut to the deeplings' underwater base."] = "You have found a shortcut to the deeplings' underwater base.",
	["IKEA for the BOLD"] = "IKEA for the BOLD",
	["The Stocktaking"] = "The Stocktaking",
	["Commissioner Fisher has mentioned that Komor needs help."] = "Commissioner Fisher has mentioned that Komor needs help.",
	["Komor needs help dealing with the disappearing furniture from his warehouse."] = "Komor needs help dealing with the disappearing furniture from his warehouse.",
	["Komor let you ask Gypsy if he knows anything about the theft of the furniture."] = "Komor let you ask Gypsy if he knows anything about the theft of the furniture.",
	["Try to find the thief; he's possibly hiding in the sewers."] = "Try to find the thief; he's possibly hiding in the sewers.",
	["You found the thief, but he managed to get away. Try to look around his hideout."] = "You found the thief, but he managed to get away. Try to look around his hideout.",
	["You found a list of stolen items; the thief has apparently stolen more than just furniture. Go to Komor and give him the list."] = "You found a list of stolen items; the thief has apparently stolen more than just furniture. Go to Komor and give him the list.",
	["You helped Komor and got rewarded for that. You have started the new mission 'Needle in a Haystack'."] = "You helped Komor and got rewarded for that. You have started the new mission 'Needle in a Haystack'.",
	["Needle in a Haystack"] = "Needle in a Haystack",
	["You helped Komor find his stolen furniture. Get your reward from the floor above if you haven't already. Visit Komor again to find out what he found on the list."] = "You helped Komor find his stolen furniture. Get your reward from the floor above if you haven't already. Visit Komor again to find out what he found on the list.",
	["Komor asked you to consult Commissioner Fisher about the thief."] = "Komor asked you to consult Commissioner Fisher about the thief.",
	["Fish asked you to track down the thief. Perhaps someone from nearby saw where he ran away?"] = "Fish asked you to track down the thief. Perhaps someone from nearby saw where he ran away?",
	["Find the bandit camp and see if they have anything to do with it."] = "Find the bandit camp and see if they have anything to do with it.",
	["Ask the bandit leader about the furniture thief."] = "Ask the bandit leader about the furniture thief.",
	["Everything indicates that the thief is trying to smuggle items and hide in the steppes. The bandit leader suggested where you should go now."] = "Everything indicates that the thief is trying to smuggle items and hide in the steppes. The bandit leader suggested where you should go now.",
	["You have defeated the Lumberjack Domino, look around his hiding place."] = "You have defeated the Lumberjack Domino, look around his hiding place.",
	["From now on, you can use his boat. Report to Commissioner Fisher."] = "From now on, you can use his boat. Report to Commissioner Fisher.",
	["You finished the plot of Lumberjack Domino, from now on you can sail his boat from the bandit camp to the south of the steppes."] = "You finished the plot of Lumberjack Domino, from now on you can sail his boat from the bandit camp to the south of the steppes.",
	-- Settled down Fishmonger
	["Settled down Fishmonger"] = "Settled down Fishmonger",
	["Stagnation"] = "Stagnation",
	["Anon's Father is waiting for his order."] = "Anon's Father is waiting for his order.",
	["You helped Anon's father recover his long-awaited package. Ask him for new mission now."] = "You helped Anon's father recover his long-awaited package. Ask him for new mission now.",
	["Milksop"] = "Milksop",
	["Anon's Father needs help finding some old junk he carried with him for fishing. Search all boats, piers, and swamps around Mirko Town for any found items."] = "Anon's Father needs help finding some old junk he carried with him for fishing. Search all boats, piers, and swamps around Mirko Town for any found items.",
	["You helped Anon's Father collect his lost tools."] = "You helped Anon's Father collect his lost tools.",
	["Stew for Trouble"] = "Stew for Trouble",
	["Anon's Father received his table in a deplorable state, ask how you can improve his mood."] = "Anon's Father received his table in a deplorable state, ask how you can improve his mood.",
	["Anon's Father reacted strongly to the fact that someone destroyed his little table. Bring some of his favorite dishes, and he might calm down. Anon's Father mentioned that he loves Rotworm Stew."] = "Anon's Father reacted strongly to the fact that someone destroyed his little table. Bring some of his favorite dishes, and he might calm down. Anon's Father mentioned that he loves Rotworm Stew.",
	["You helped Anon's Father with all the troubles. Now, go to his son for your reward."] = "You helped Anon's Father with all the troubles. Now, go to his son for your reward.",
	["You have received a reward from the Fisherman Son. You gained the ability to purchase Shimmer Swimmer."] = "You have received a reward from the Fisherman Son. You gained the ability to purchase Shimmer Swimmer.",
}
