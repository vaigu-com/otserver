return {
	["Tasks"] = "Taski",
	["Task informations"] = "Informacje o taskach",
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
		return T("Zabitych :name:: :currentKills:/:requiredKills:.", {
			name = name,
			currentKills = currentKills,
			requiredKills = requiredKills,
		})
	end,
	["FIGHT_WITH_TASK_BOSS_MISSION_NAME"] = function(context)
		return T("Walka z :bossName:", { bossName = context.task.bossName })
	end,
	["FIGHT_WITH_TASK_BOSS_MISSION_DESCRIPTION"] = function(context)
		local bossLocationDescription = context.player:Localizer(LOCALIZER_TASK_BOSS_LOCATIONS):Get(context.task.name)
		return bossLocationDescription
	end,
	["DAILY_TASK_MISSION_NAME"] = function(context)
		local dailyTask = context.dailyTask
		local name = dailyTask.name
		return T("Dzisiejsze zadanie na :name:", { name = name })
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
		local dailyTaskDescription = T("Dzisiejsze zadanie na :name:!\n\n", { name = name })
		dailyTaskDescription = dailyTaskDescription
			.. T("Zabiles :currentKills:/:requiredKills: :name:.", {
				name = name,
				currentKills = currentKills,
				requiredKills = requiredKills,
			})
		if requiredItems then
			dailyTaskDescription = dailyTaskDescription
				.. "\n\nBedziesz rowniez musial przyniesc nastepujace przemdioty do Pani Burmistrz:\n"
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
			.. T("\nZaplata w wyokosci :money: zlota oraz :tibiaCoins: coinow!", {
				money = dailyTask.money,
				tibiaCoins = dailyTask.tibiaCoins,
			})

		return dailyTaskDescription
	end,
	["QUEST_MISION_COMPLETE_SUFFIX"] = " (ukonczone)",
	["Daily task"] = "Dzisiejsze zadanie",
	["Daily tasks information"] = "Informacje o dzisiejszch zadaniach",
	["Arena"] = "Arena",
	["First arena"] = "Pierwsza arena",
	["Kill:\nFrostfur\nBloodpaw\nBovinus\nAchad\nColerian the Barbarian\nThe Hairy One\nAxeitus Headbanger\nRocky\nCursed Gladiator\nOrcus the Cruel"] = "Zabij:\nFrostfur\nBloodpaw\nBovinus\nAchad\nColerian the Barbarian\nThe Hairy One\nAxeitus Headbanger\nRocky\nCursed Gladiator\nOrcus the Cruel",
	["Second arena"] = "Druga arena",
	["Kill:\nAvalanche\nKreebosh the Exile\nThe Dark Dancer\nThe Hag\nSlim\nGrimgor Guteater\nDrasilla\nSpirit of Earth\nSpirit of Water\nSpirit of Fire"] = "Zabij:\nAvalanche\nKreebosh the Exile\nThe Dark Dancer\nThe Hag\nSlim\nGrimgor Guteater\nDrasilla\nSpirit of Earth\nSpirit of Water\nSpirit of Fire",
	["Third arena"] = "Trzecia arena",
	["Kill:\nWebster\nDarakan the Executioner\nNorgle Glacierbeard\nThe Pit Lord\nSvoren the Mad\nThe Masked Marauder\nGnorre Chyllson\nFallen Mooh'Tah Master Ghar\nDeathbringer\nThe Obliverator"] = "Zabij:\nWebster\nDarakan the Executioner\nNorgle Glacierbeard\nThe Pit Lord\nSvoren the Mad\nThe Masked Marauder\nGnorre Chyllson\nFallen Mooh'Tah Master Ghar\nDeathbringer\nThe Obliverator",
	["Fourth arena"] = "Czwarta arena",
	["Arena, extreme level."] = "Arena, poziom ekstremalny.",
	["Firestarter"] = "Firestarter",
	["Mission 1: Fiery Beginnings"] = "Misja 1: Ogniste Poczatki",
	["Hymel asked you to burn down the herbs he left on his house on north side of MikroTown."] = "Hymel poprosil cie o spalenie ziola, ktore zostalo w jego chacie na polnocy miasta.",
	["You burnt the herbs, now talk again with Hymel."] = "Ziolo poszlo z dymem, powiedz to Hymelowi.",
	["Hymel gave you an incendiary firebug. From now on you can buy more firebugs from him."] = "Hymel zostawil Ci zapalniczke, ktora od teraz mozesz od niego kupic.",
	["Mission 2: Little Treat"] = "Misja 2: Maly Psikus",
	["Hymel want to mischief the local guards, by setting an old tree on fire. You can find it near their resting camp."] = "Hymel pomyslal, ze straznicy sie wkurza jak podpalisz konar drzewa w ich miejscowce.",
	["You did it, the guards didn't even notice, go back and see Hymel."] = "Udalo sie, straznicy cie nie pojmali, zamelduj o tym.",
	["In return for your help, Hymel gave you the staff of a real reefer."] = "W zamian za pomoc, Hymel wreczyl ci laske prawdziwego jaracza.",
	["Mission 3: How High"] = "Misja 3: Najarane miasto",
	["Hymel told you about how he and his mates once sowed 5 mysterious herbs all around MirkoTown. Unfortunately he doesn't remember where exactly they did sow them. They look like usual red flowers. Find them and set them ablaze with firebug."] = "Hymel opowiedzial ci o tym, jak kiedys z ziomkami zasiali 5 mocnych ziol, niestety nie pamieta gdzie, a wygladaja jak zwykle czerwone kwiatki. Odnajdz je i spal.",
	["The smell of weed is now around the whole city, you managed to burn all the flowers."] = "Cale miasto jest na haju, udalo ci sie spalic wszystkie kwiaty.",
	["Hymel made you a true pyromaniac and gave you his arsonist weapon."] = "Hymel zrobil z ciebie prawdziwego piromana oraz dal Ci swoja bron podpalacza.",
	["The Way of a Druid"] = "Sciezka Druida",
	["The Council of Druids"] = "Krag Druidow",
	["You met one of the druids, if you helped him, he would tell you about the Council."] = "Spotkales jednego z Druidow, jesli mu pomozesz, to napewno opowie ci o swoim kregu.",
	["You helped the first druid. This is the beginning of your journey to become one of them. Find the remaining druid, and provide them with your help."] = "Pomogles pierwszemu z Druidow, to twoj poczatek drogi do zostania jednym z nich. Odnajdz pozostalych druidow, i okaz im nalezyta pomoc.",
	["The Mother Nature is watching, and she is cherishing as you helped two of the druids."] = "Matka natura wszystko obserwuje, cieszy ja to, ze pomogles juz dwom druidom.",
	["Your efforts induced The Mother Nature let you gather water from well at the great tree."] = "Za swoje zaslugi u druidow Matka natura pozwolila Ci zaczerpnac wody ze studni w wielkim drzewie.",
	["You drew water from well at the sacred tree. Now try to find the next druid."] = "Zaczerpnales wody ze studni w swietym drzewie. Postaraj sie odnalezc i pomoc kolejnemu z Druidow.",
	["Your kindness goes a long way, you helped four druids so far."] = "Swoja dobrocia znacznie przysluzyles sie Naturze. Pomogles juz czterem druidom.",
	["You helped all the druids, and you have been introduced to their Council. Now you can harvest a blossom of the Griffinclaw plant, which grows inside a great tree."] = "Pomogles wszystkim druidom, i zostales przyjety do ich kregu. Mozesz zebrac kwiat rosliny Griffinclaw, ktora rosnie w wielkim drzewie.",
	["Deer Season"] = "Sezon na jelenie",
	["Radaghast asked you to burn down the hunters' stock of wood. This should prove to help a lot of animals to survive during the hunting season."] = "Radagast poprosil, zeby spalic zapas drewna, ktory uzbierali Hunterzy. To pozwoli przetrwac duzej ilosci zwierzat w trakcie sezonu polowania.",
	["You managed to burn down the stock of wood in the hunters' village. Make haste and tell about this to Radaghast."] = "Udalo ci sie podpalic zapasy drewna w wiosce Hunterow, jak najszybciej przekaz ta wiadomosc Radagastowi.",
	["Radaghast handed you a slingshot for your help, also he erranded you to help other druids from the council he told you about."] = "W zamian za pomoc Radagast przekazal ci Slingshot, oraz zlecil pomoc pozostalym Druidom, o ktorych kregu ci opowiedzial.",
	["Taken: Benek"] = "Porwany Benek",
	["Estep is Wailing since orcs taken his Wolf companion."] = "Estep jest zrozpaczony tym, ze orki porwaly jego wilka.",
	["The wolf has been freed, deliver a good message to Estep."] = "Wilk zostal uwolniony, przekaz te wiadomsoc Estepowi.",
	["Estep handed over this knife in his gratitude."] = "Estep zostawil ci noz w podziece.",
	["Rude eviction"] = "Nagla eksmisja",
	["SandNigger asked you to help him reclaim his secret spell."] = "SandNigger poprosil cie o to, zebys pomogl mu odzyskac jego tajny czar.",
	["You managed to find and combust the spell, come back to Sandnigger."] = "Udalo ci sie znalezc i spalic czar, wroc do SandNiggera.",
	["For your kind deed, you have been granted The Lion Amulet."] = "Za dobry uczynek dla pustynnego druida dostales lwi amulet.",
	["The secret ingredient"] = "Tajny skladnik",
	["Mundral asked you to get the medicine for his sick pet. You can ask Ornuld for it."] = "Mundral prosi cie o zdobycie lekarstwa od Ornulda dla jego chorego zwierzaka.",
	["Turn out that Mundral belongs to the Druid Council. He put in a good word to his druid friends and he gifted you with bamboo leaves."] = "Mundral okazal sie nalezec do kregu druidow i szepnal o tobie dobre slowo w zamian i podarowal ci liscie bambusowe.",
	["The Ornuld's medicine"] = "Lekarstwo od Ornulda",
	["Ornuld wishes to have a one wyrm egg. If you manage to do this favor, he will reward you with the medicine."] = "Ornuld zazyczyl sobie jajo wyrmy, za ktore przekaze ci lekarstwo.",
	["You found the wyrm's egg, hand it to Ornuld."] = "Zdobyles jajo wyrmy, przekaz je Ornuldowi.",
	["Ornuld gave you the medicine in exchange for the wyrm's egg."] = "Ornuld przekazal ci lekarstwo wzamian za jajo Wyrmy.",
	["The Singing Crystal"] = "Blyszczacy krysztal",
	["Malfurion is in need of an ice crystal fragment for his experiment."] = "Malfurion potrzebuje kawalki lodowego krysztalu do swojego eksperymentu.",
	["You managed to gather a bunch of crystal, go back to Malfurion."] = "Masz juz troche krysztalu, wroc z nim do Malfuriona.",
	["For your help, Malfurion gave you a gift."] = "Za pomoc Malfurion dal ci podarunek.",
	["Ariel's Friend"] = "Przyjaciel Ariela",
	["Helping the Ariel"] = "Pomoc dla Ariela",
	["Ariel asked you to bring him his friend's favorite flower. Namely it is the Heaven Blossom. Some elves keep it in their pouch."] = "Ariel poprosil cie o przyniesienie mu ulubionego kwiata jego przyjaciela, czyli heaven blossom. Czasami elfy nosza je przy sobie.",
	["Ariel asked you to pay respect to his friend by laying these flowers on his grave. It is located on a nearby hill. If you do that, he will tell you his story."] = "Ariel poprosil cie o zlozenie ich na grobie jego przyjaciela, ktory znajduje sie na pobliskim wzgorzu. W zamian obiecal ci opowiedzenie jego historii.",
	["You put the flowers on Ariel's friend's grave, now come back to Ariel."] = "Udalo ci sie zlozyc kwiaty na grobie, przekaz ta wiesc Arielowi.",
	["Ariel endowed you with a bow and a few minor gifts. He is now ready to tell you his story, whenever you ask him to do so."] = "Ariel odwdzieczyl sie za pomoc elfickim lukiem, kilkoma upominkami, oraz obietnica opowiedzenia swojej historii, jesli go o to poprosisz.",
	["Yalahari Quest"] = "Yalahari Quest",
	["Mission 1: Love is in the air"] = "Misja 1: Milosc Ariela",
	["Ariel asked you to hand over a party invitation to Madame Malkin."] = "Ariel poprosil cie o przekazanie zaproszenia na impreze dla Madame Malkin, sprzedawczyni z MirkoTown.",
	["Madame refused Ariel's request to go out with him. Tell him this bad news."] = "Madame nie zgodzila sie pojsc na impreze z Arielem, przekaz mu ta wiadomosc.",
	["Perhaps Ariel's friend, Old Postman, knows a way to influence Madame Malkin."] = "Podobno przyjaciel Ariela, Old Postman moze wiedziec jak zaradzic na ta sytuacje.",
	["Old Postman had a disgraceful idea to steal an elixir of love. He told you to fill this vial he gave you. You can probably find supplies of love elixir at Alchemists' quarters, north of MirkoTown."] = "Old postman wpadl na niecny plan wykradniecia eliksiru milosci, ktory wywarzyli alchemicy na polnocy od MirkoTown, dal ci fiolke, w ktora moze udac ci sie napelnic troche eliksiru.",
	["Success! You filled the vial with an elixir. Go back to the postman and ask him for further directions."] = "Udalo ci sie napelnic fiolke eliksirem, wroc do postmana po dalsze wskazowki.",
	["Old Postman mentioned that in order for the elixir to properly work, you need to dilute Ariel's string of hair in it. After you do this, bring the elixir to Madame Malkin."] = "Old Postman wspomnial, ze aby mikstura zdzialala, potrzeba w niej rozpuscic wlos Ariela, na pewno znajdzesz jakis w jego chacie. Pozniej przekaz eliksir Madame Malkin.",
	["Madame Malkin chugged the elixir which will make her love Ariel. Talk to her again after some time and mention Ariel's."] = "Madame Malkin wypila eliksir, dzieki ktoremu pokocha Ariela. Odwiedz ja za jakis czas, i wspomnij o nim.",
	["Turns out that the “wine” worked as intended. Tell Ariel about it."] = "Wino najwidoczniej zadzialalo, przekaz wiesci Arielowi.",
	["Ariel rejoices to know about Madame's feelings. He also revealed the secret Yalaharian greeting to you: Aloha. You can visit Gertrdue or Konmuld now."] = "Ariel ucieszyl sie, i podal ci tajemne haslo powitalne Yalaharian: Aloha. Mozesz teraz odwiedzic Gertrude lub Konmulda.",
	["Mission 2: A morbid Liquor"] = "Misja 2: Zabojczy trunek",
	["Find an immensely strong vodka in the lizard headquarters, and bring it to Gertruda."] = "Znajdz mega mocna wodke w siedzibie jaszczurow i przynies butelke do Gertrudy.",
	["In exchange for your help with finding the beverage, Gertruda is willing to help you with preparing concoctions and special rodenticides."] = "W zamian za trunek Gertruda zaoferowala ci pomoc w przyrzadzaniu wywarow i specjalnych srodkow. Mozesz taksze sam odwiedzic Konmulda, i poczestowac go wodka.",
	["After treating Konmuld with vodka, he agreed to talk with you."] = "Po poczestowaniu wodka Konmuld zgodzil sie z toba porozmawiac.",
	["Mission 3: Prelude to Thaumaturgy"] = "Misja 3: Wstep do czarnej magii",
	["Konmuld asked you to bring him a virgin's soul. You can ask Grave Digger for help with your mission."] = "Konmuld nakazal ci przyniesienie duszy dziewicy. Informacji zasiegnij u grabarza w Mirko Town.",
	["Grave Digger said that there are no remaining virgins left, however, you can dig up a virgin's soul from a grave."] = "Grave Digger powiedzial, ze prawdziwych dziewic juz nie ma, ale jest szansa na wykopanie duszy z grobu.",
	["You managed to get a virgin's soul. Now go see Konmuld."] = "Udalo ci sie zdobyc dusze dziewicy, przekaz to Konmuldowi.",
	["Konmuld offered you to choose one of the Yalahari set pieces to keep for yourself."] = "Konmuld pozwolil ci wybrac jedna z czesci legendarnego stroju Yalahari.",
	["In his gratitude, Konmuld gave you one of his old Yalahari set pieces."] = "Konmuld w podziece przekazal ci jedna czesc ze swojego dawnego stroju Yalahari.",
	["The First Steps"] = "Trudne Poczatki",
	["Research"] = "Rozeznanie",
	["Find Commissioner Fisher and ask for a mission."] = "Idz do komisarza Ryby i zapytaj o misje.",
	["Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 0/10."] = "Przejdz sie po glownych sprzedawcach w MirkoTown i zobacz czy nie potrzebuja pomocy, po czym zamelduj o tym Komisarzowi. Odwiedzeni sprzedawcy: 0/10.",
	["Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 1/10."] = "Przejdz sie po glownych sprzedawcach w MirkoTown i zobacz czy nie potrzebuja pomocy, po czym zamelduj o tym Komisarzowi. Odwiedzeni sprzedawcy: 1/10.",
	["Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 2/10."] = "Przejdz sie po glownych sprzedawcach w MirkoTown i zobacz czy nie potrzebuja pomocy, po czym zamelduj o tym Komisarzowi. Odwiedzeni sprzedawcy: 2/10.",
	["Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 3/10."] = "Przejdz sie po glownych sprzedawcach w MirkoTown i zobacz czy nie potrzebuja pomocy, po czym zamelduj o tym Komisarzowi. Odwiedzeni sprzedawcy: 3/10.",
	["Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 4/10."] = "Przejdz sie po glownych sprzedawcach w MirkoTown i zobacz czy nie potrzebuja pomocy, po czym zamelduj o tym Komisarzowi. Odwiedzeni sprzedawcy: 4/10.",
	["Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 5/10."] = "Przejdz sie po glownych sprzedawcach w MirkoTown i zobacz czy nie potrzebuja pomocy, po czym zamelduj o tym Komisarzowi. Odwiedzeni sprzedawcy: 5/10.",
	["Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 6/10."] = "Przejdz sie po glownych sprzedawcach w MirkoTown i zobacz czy nie potrzebuja pomocy, po czym zamelduj o tym Komisarzowi. Odwiedzeni sprzedawcy: 6/10.",
	["Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 7/10."] = "Przejdz sie po glownych sprzedawcach w MirkoTown i zobacz czy nie potrzebuja pomocy, po czym zamelduj o tym Komisarzowi. Odwiedzeni sprzedawcy: 7/10.",
	["Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 8/10."] = "Przejdz sie po glownych sprzedawcach w MirkoTown i zobacz czy nie potrzebuja pomocy, po czym zamelduj o tym Komisarzowi. Odwiedzeni sprzedawcy: 8/10.",
	["Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 9/10."] = "Przejdz sie po glownych sprzedawcach w MirkoTown i zobacz czy nie potrzebuja pomocy, po czym zamelduj o tym Komisarzowi. Odwiedzeni sprzedawcy: 9/10.",
	["Visit main dealers in MirkoTown and ask if they need any help. Then report it back to Commissioner Fisher. Dealers met: 10/10."] = "Przejdz sie po glownych sprzedawcach w MirkoTown i zobacz czy nie potrzebuja pomocy, po czym zamelduj o tym Komisarzowi. Odwiedzeni sprzedawcy: 10/10.",
	["Wood Delivery"] = "Dostawa Drewna",
	["Go to Knurowo's port and find out what happened to the wood delivery."] = "Idz do knurowskiego portu dowiedziec sie co z dostawa drewna.",
	["Woody is sure that the wood was shipped on a caravan leaving Knurowo. He asked you to investigate this."] = "Rasiak jest pewny, ze drewno zostalo wyslane karawana, poprosil cie o zbadanie sprawy.",
	["Tell Ryba that Narro and his mafia stole all of the wood delivery."] = "Przekaz Komisarzowi Rybie, ze Waski i jego mafia zabrali drewno.",
	["Commissioner Fisher ordered you to recover the stolen wood, but he also warned you about the Narro's mafia."] = "Komisarz nakazal ci odzyskanie drewna, lecz ostrzegal przed mafia Waskiego.",
	["Narro gave up, and he is going to let Officer Ryba take the wood back. Report back to Ryba."] = "Waski sie poddal i pozwoli Komisarzowi zabrac drewno, przekaz mu te dobre wiesci.",
	["Your merits earned you a special reward. Officer Ryba sent you to Trollsky, where you can receive your reward."] = "Komisarz za dobrze wykonane zadanie wyslal cie do trollskyiego po nagrode.",
	["To Carry the Pigs"] = "Na pomoc Bagietom",
	["To be like the Schwarzenegger"] = "Byc jak Schwarzenegger",
	["Collect these items for me: 5 orc tooth, 5 carrion worm fangs, and 1 vampire teeth."] = "Zbierz dla arniego 5 zebow orka, 5 zebow rotworma oraz zab wampira.",
	["Arni glanced at these teeth, and asked you to find someone who can make them into necklace."] = "Arni obejrzal zeby, ale poprosil cie zebys znalazl kogos, kto zrobi z nich naszyjnik.",
	["Madame Malkin gladly made this necklace for Arni."] = "Madame Malkin z checia wykonala naszyjnik dla Arniego.",
	["In exchange for the teeth necklace, Arni gave u his old armour and a ring."] = "Arni w zamian dal ci swoj stary pancerz oraz pierscionek.",
	["Half turn Kick"] = "Kopniak z polobrotu",
	["Cordell Walker is suspecting bandits of commissioning illegal transactions in their encampment."] = "Walker ma podejrzenia, ze gdzies w wiosce bandytow sa krecone nielegalne deale.",
	["He was right. Now go to the Price Kebab and ask Shivganesh for translation."] = "Mial racje. Idz do Prince Kebab i przetlumacz List.",
	["It wasn't hard at all for Shivganesh. Take the list and translation back to Cordell Walker."] = "Wcale nie bylo to takie trudne dla Shivganesha, odnies przetlumaczony list do Walkera.",
	["You have received MirkoTown guard hat for your help."] = "W zamian za pomoc dostales Kapelusz straznika MirkoTown.",
	["A Balanced Diet"] = "Dieta Grubego Mirka",
	["Collect 1 slimming carrot for fat Mirek."] = "Znajdz odchudzajaca marchewke dla Grubego Mirka.",
	["The carrot was dogshit, and u received chocolate slush in for your effort."] = "Marchewka byla chujowa, ale dostales czekoladowa papke w zamian.",
	["Kitz's Dominando"] = "Dominando Kitza",
	["Arrange a special bow from elf adobe."] = "Zalatw specjalny luk z siedziby elfow.",
	["You have received the item from Legolas. Go give it to Kitz."] = "Otrzymales luk od Legolasa, przekaz go Kitzowi.",
	["Turns out elvish bow sucks. Kitz now wishes to rook the elves. In return for your efforts you received his old bow."] = "Luk okazal sie chujowy, wiec Kitz pragnie zrobic Dominando elfom. W zamian jednak dal ci jego wlasny luk.",
	["Ocellatus Xddd"] = "OskareK Xddd",
	["Tickets"] = "Bilety",
	["Recover the match tickets whose have been stolen from Ocellatus."] = "Odzyskaj bilety na mecz, ktore zostaly skradzione Oskarkowi.",
	["You found the Tickets in a bandits tent."] = "Znalazles bilety w namiocie bandytow.",
	["You gave tickets back to Ocellatus."] = "Oddales bilety, i zwrociles je Oskarkowi.",
	["Ocellatus asks you to bring him specific food. Ask Pewter for help."] = "Zostales poproszony o zarcie, porozmawiaj z Piotrkiem, jesli bedziesz mial problem.",
	["U brang food to Ocellatus. In his gratitude, he gave you outfit and let you sail his boat."] = "Przyniosles zarcie Oskarkowi, za co podarowal ci stroj, i pozwolil plywac swoja lodka.",
	["Demon Oak"] = "Demoniczny Dab",
	["You have made your way into the den of Demon Oak. Try to find someone who will tell you more about it."] = "Wdrales sie do leza Demonicznego Debu. Sprobuj odnalezc kogos, kto przekaze ci o nim wiecej informacji.",
	["Oldrak gave you information regarding Demon Oak. He can bless an axe if you bring him one. The blessed axe should help you fight the Oak."] = "Oldrak przekazal ci informacje o Demonicznym Debie. Poprosil cie o przyniesienie mu topora, ktory po poblogoslawieniu pomoze w pokonaniu debu.",
	["You defeated the Demon Oak! Report to Oldrak."] = "Pokonales Demoniczny Dab! Przekaz te informacje Oldrakowi.",
	["You reported to Oldrak about your victory. You have been rewarded for your efforts: Oldrak told you a secret about the way to the Elvish treasury."] = "Przekazales Oldrakowi wiesc o pokonaniu Debu. W zamian wyjawil ci sekret dotyczacy Elfickiego skarbca.",
	["Local Support"] = "Pomoc Miejscowym",
	["Freaking Rats"] = "Przeklete Szczury",
	["Walmart wishes she knew how to repel rats. Find out where Gertruda lives. She should know how to craft a rat poison."] = "Biedronka pragnie przepedzic szczury. Odnajdz Gertrude, ktora potrafi przyzadzac skuteczna trutke.",
	["Gertruda asked you to bring her one mouldy cheese."] = "Gertruda poprosila cie o dostarczenie splesnialego sera, na ktory zaaplikuje trucizne.",
	["Cheese is now poisonous. Bring it to Walmart, so she can repel the rats."] = "Ser jest juz zatruty, zanies go Biedronce, by mogla przepedzic szczury.",
	["Walmart didn't have time to make use of the poisonous cheese, but she already gave you your reward: Carrot cake and a minor gift."] = "Biedronka jeszcze nie przetestowala trutki, jednak w zamian dostales ciato marchewkowe oraz upominek.",
	["Cheap Recycling"] = "Tani Recykling",
	["Malkin asked you to bring her 1 piece of cloth of every color."] = "Malkin poprosila cie o przyniesienie jej po 1 kawalku tkaniny z kazdego koloru.",
	["Madame Malkin is grateful for your effort, and since now you can exchange mystic turbans, red robe, and green tunic for corresponding pieces of cloth."] = "W podziece mozesz wymieniac u Madame Malkin mystic turbany, red robe oraz green tunic na kolorowe tkaniny.",
	["Broken Orb"] = "Zniszczona Kula",
	["Gypsy needs a new Crystal ball. Bring it to him, and he will reward you abundantly."] = "Cygan pragnie aby przyniesc mu kule wrozbiarska, ktora godnie zastapi poprzednia.",
	["The crystal ball wasn't perfect, but Gypsy is fine with it. Since now he will also let you exchange red gem to ring of healing."] = "Choc kula nie byla idealna, Cygan jest zadowolony i pozwoli ci wymieniac red gem na ring of healing.",
	["Biodegradable"] = "Biodegradowalny",
	["Old postman asked you to find a package. You know that this cargo was supposed to arrive by water from the west."] = "Old postman poprosil Cie o znalezienie paczki. Wiesz, ze ten ladunek mial otrzymac droga wodna ze strony zachodniej.",
	["You found the package for Old Postman. Return to him and give it to him."] = "Znalazles paczke Old Postamana. Wroc teraz do niego i mu ja wrecz.",
	["You received a reward from Old Postman in exchange for helping locate the overdue shipment. He mentioned that you can also deliver Zanet's Box to Old Anon."] = "Otrzymales nagrode od Old Postmana w zamian za pomoc z odnalezieniem zaleglej przesylki. Wspomnial, ze mozesz odniesc Puszke z Zaneta do Starego Anona.",
	["You took the box from Old Postman, which you should deliver to Old Anon."] = "Wziales od Old Postmana puszke, ktora powiniennes odniesc do Starego Anona.",
	["The Silence of the Lambs"] = "Milczenie Owiec",
	["The test of Strength"] = "Proba sily",
	["Lecter asked you for 5 vampire teeth."] = "Lecter poprosil cie o 5 wampirzych zebow.",
	["In exchange for your help, Lecter bestowed you with his old soul-extraction tool."] = "W zamian za wykazanie sie, Lecter podarowal ci stary przyrzad do wyciagania dusz.",
	["Fashionista clothes"] = "Modne ubrania",
	["Lecter asked you to bring him 20 leathers of every kind."] = "Lecter poprosil cie o przyniesienie po 20 skor kazdego rodzaju.",
	["For your help you have been taught how to skin human carcass."] = "W zamian za pomoc w zdobyciu materialow do szycia, nauczyl cie skorowac ludzi.",
	["Lecter's recipe"] = "Gotuj z Lecterem",
	["Lecter wants you to hoard 15 human hearts and 20 human livers. He needs them for his cannibals party."] = "Lecter prosi cie o uzbieranie 15 serc i 20 watrob ludzkich na impreze kanibali.",
	["In exchange for this favor you have been introduced to the cannibal club. You also received their outfits."] = "W zamian za przysluge, zostales przyjety do klubu kanibali, i zyskales ich stroj.",
	["Hearts collected"] = "Ludzkie serca",
	["Hearts collected Status"] = function(context)
		return string.format("Liczba uzbieranych serc: %d / 15", context.player:getStorageValue(11074))
	end,
	["Livers collected"] = "Ludzkie watroby",
	["Livers collected Status"] = function(context)
		return string.format("Liczba uzbieranych watrob: %d / 20", context.player:getStorageValue(11075))
	end,
	["Unwanted Guests"] = "Nieproszeni Goscie",
	["Damned Barbarians"] = "Zasrani Barbarzyncy",
	["Bring Brutetamers Staff and Fur Boots to Dziadek Mroz."] = "Przynies dziadkowi Brutetamers Staff oraz Fur Boots, na dowod pokonania barbarzyncow.",
	["The Inquisition"] = "The Inquisition",
	["Mission 1: Interrogation"] = "Misja 1: Przesluchanie",
	["Your mission is to investigate the 5 guards regarding the Heretic behavior. Tim, Kulag, Grof, Miles and Walter are their names. If you do well you see a holy sprite on you."] = "Twoim zadaniem jest przesluchanie 5 straznikow w zwiazku z ich heretyckim zachowaniem. Ich imiona to Tim, Kulag, Grof, Miles i Walter. Jesli to wykonasz, zobaczysz na sobie swietego ducha.",
	["You investigated 1 of 5 guards."] = "Przesluchano 1 z 5 straznikow.",
	["You investigated 2 of 5 guards."] = "Przesluchano 2 z 5 straznikow.",
	["You investigated 3 of 5 guards."] = "Przesluchano 3 z 5 straznikow.",
	["You investigated 4 of 5 guards."] = "Przesluchano 4 z 5 straznikow.",
	["You investigated 5 of 5 guards. Get back to Sybir and report your mission to Henricus."] = "Przesluchano 5 z 5 straznikow. Wroc na Sybir i zglos swoja misje Henricusowi.",
	["You investigated all guards."] = "Przesluchano wszystkich straznikow.",
	["Mission 2: Eclipse"] = "Misja 2: Zacmienie",
	["Henricus tells you to get The Witches' Grimoire, he sends you to Mirko Town where you can find to the witches' swamps. Use the vial of holy water that he gives you on the big cauldron and open the chest hidden in some witch hut, then bring the witches' grimoire to Henricus."] = "Henricus kaze ci zdobyc The Witches' Grimoire, wysyla cie do Mirko Town, gdzie znajdziesz bagna czarownic. Uzyj fiolki swietej wody na duzym kotle i otworz skrzynie ukryta w chacie czarownicy, a nastepnie przynies The Witches' Grimoire Henricusowi.",
	["Find The Witches' Grimoire and bring it to Henricus."] = "Znajdz The Witches' Grimoire i przynies ja Henricusowi.",
	["You already brought The Witches' Grimoire to Henricus."] = "Juz przyniosles The Witches' Grimoire Henricusowi.",
	["Mission 3: Vampire Hunt"] = "Misja 3: Polowanie na Wampiry",
	["Henricus wants you to find the Dwarfish Vampire Hunter, Storkus, located deep in dwarven mines. It's a good idea to bring your 20 Vampire Dusts with you to save some time."] = "Henricus chce, abys znalazl Krasnoludzkiego Lowce Wampirow, Storkusa, ktory znajduje sie gleboko w kopalniach. Dobrym pomyslem jest zabranie ze soba 20 Vampire Dust, aby zaoszczedzic troche czasu.",
	["Go back to Storkus and ask for a mission."] = "Wroc do Storkusa i popros o misje.",
	["Now Storkus wants you to kill a vampire lord, The Count. The Count is located deep under the forgotten cemetery near the hunter camp. To summon The Count, you must use the coffin in the center of the room. Kill him and bring The Ring of the Count to Storkus."] = "Teraz Storkus chce, abys zabil Wampirzego Lorda - The Count. The Count znajduje sie gleboko pod zapomnianym cmentarzem niedaleko obozu hunterow. Aby przywolac The Count, musisz uzyc trumny na srodku pomieszczenia. Zabij go i przynies Ring of the Count Storkusowi.",
	["Kill The Count and bring his ring to Storkus, and then ask for a mission."] = "Zabij The Count i przynies Storkusowi jego pierscien, a nastepnie popros o misje.",
	["Return to Henricus and tell him that you've finished your job here."] = "Wroc do Henricusa i powiedz mu, ze skonczyles robote.",
	["Get back to Sybir and report your mission to Henricus."] = "Wroc na Sybir i zareportuj misje Henricusowi.",
	["Mission 4: The Haunted Ruin"] = "Misja 4: Nawiedzony Zamek",
	["Henricus will give you a Special Flask (vial of holy water). You can find some abandoned pirate ruins near hero village in the jungle. Use this vial of holy water on some spot in the haunted ruin to drive out the evil being."] = "Henricus da ci Special Flask. Znajdz opuszczone ruiny piratow niedaleko wioski Herosow w dzungli. Uzyj tej fiolki swietej wody w nawiedzonej ruinie, aby wygonic zlego ducha.",
	["Kill the Pirate Ghost and get back to Sybir and report your mission to Henricus."] = "Zabij Ducha Piratow i wroc na Sybir, aby zglosic swoja misje Henricusowi.",
	["You already cleaned the abandoned and haunted place, ask Henricus for a new mission."] = "Juz oczysciles nawiedzone miejsce. Popros Henricusa o nowa misje.",
	["Mission 5: Essential Gathering"] = "Misja 5: Zbieranie Skladnikow",
	["Henricus wants 20 Demonic Essences as proof of your accomplishments."] = "Henricus chce 20 Demonic Essence jako dowod twoich osiagniec.",
	["Now ask Henricus for an outfit to get the Demon Hunter Outfit."] = "Popros Henricusa o stroj, aby zdobyc Stroj Lowcy Demonow.",
	["You got the Demon Hunter Outfit! Ask Henricus for a mission to unlock more addons."] = "Zdobyles Stroj Lowcy Demonow! Popros Henricusa o misje, aby odblokowac wiecej dodatkow.",
	["Mission 6: The Demon Ungreez"] = "Misja 6: Demon Ungreez",
	["Henricus wants you to kill a demon called Ungreez. Head to the desert demon lair and go down a few levels."] = "Henricus chce, abys zabil demona o nazwie Ungreez. Udaj sie do jaskini demonow na pustyni i zejdz kilka poziomow w dol.",
	["You killed Ungreez, report your mission to Henricus."] = "Zabiles Ungreeza, zglos swoja misje Henricusowi.",
	["You got the first addon of Demon Hunter Outfit! Ask Henricus for a mission to unlock more addons."] = "Zdobyles pierwszy dodatek do Stroj Lowcy Demonow! Popros Henricusa o misje, aby odblokowac wiecej dodatkow.",
	["Mission 7: The Shadow Nexus"] = "Misja 7: Cienisty Nexus",
	["Your mission is to go to the Demon Forge and slay seven of The Ruthless Seven Minions. The Demon Forge is located in the Sybir, somewhere in hidden cultist ruins."] = "Twoim zadaniem jest udac sie do Kuzni Demonow i zabic siedmiu Siedmiu Bezlitosnych Poplecznikow. Kuznia Demonow znajduje sie w Sybirze, gdzies w ukrytych ruinach kultystow.",
	["You destroyed the shadow nexus! Get back to Henricus and report your mission."] = "Zniszczyles Shadow Nexus! Wroc teraz do Henricusa i zareportuj wykonanie misji.",
	["Now ask Henricus for an outfit. He will give you the 2nd addon of the Demon Hunter Outfits."] = "Popros Henricusa o stroj. Dostaneisz drugi dodatek do Lowcy Demonow.",
	["You got the second addon of Demon Hunter Outfit! Go now to the reward room and choose one wisely!"] = "Dostales drugi dodatek do Lowcy Demonow! Teraz udaj sie do pokoju z nagrodami i wybierz madrze!",
	["You have completed The Inquisition Quest!"] = "Ukonczyles Inquisition Quest!",
	["Bigfoot's Burden"] = "Bigfoot's Burden",
	["Reputation points"] = "Punkty reputacji",
	["Current reputation points"] = function(context)
		return string.format("Posiadasz %d punktow reputacji.", math.max(context.player:getStorageValue(921), 0))
	end,
	["Daily Minor: Crystal Keeper"] = "Dzienne: Naprawca Krysztalow",
	["Daily Minor: Crystal Keeper Status"] = function(context)
		return string.format(
			"Uzyj krysztalu naprawczego, aby naprawic piec uszkodzonych niebieskich krysztalow w jaskiniach krysztalowych. Uszkodzone krysztaly nie beda swiecic. %d/5",
			math.max(context.player:getStorageValue(932), 0)
		)
	end,
	["Daily Minor: Raiders of the lost Spark"] = "Dzienne: Lowcy Krysztalow",
	["Daily Minor: Raiders of the lost Spark Status"] = function(context)
		return string.format(
			"Zabij Crystal Crushery i uzyj urzadzenia rozladowujacego na ich cialach, aby zebrac ich ladunki. Zbierz 7 ladunkow i zglos sie z nimi. %d/7",
			math.max(context.player:getStorageValue(934), 0)
		)
	end,
	["Daily Minor Plus: Exterminators"] = "Dzienne Plus: Eksterminacje",
	["Daily Minor Plus: Exterminators Status"] = function(context)
		return string.format(
			"Zabij 10 Wigglerow na pomoc gnomom. Nastepnie zglos sie z powrotem. %d/10",
			math.max(context.player:getStorageValue(937), 0)
		)
	end,
	["Daily Minor Plus: Mushroom Digger"] = "Dzienne Plus: Niuchacz Grzybow",
	["Daily Minor Plus: Mushroom Digger Status"] = function(context)
		return string.format(
			"Znajdz i zwab swinie truflowa. Czasem wywachuja swieze trufle. Uzyj mlodego prosiaka na truflach, nakarm go 3 razy. Nastepnie zglos sie do gnomow. %d/3",
			math.max(context.player:getStorageValue(940), 0)
		)
	end,
	["Daily Major Advanced: Spores"] = "Dzienne Zaawansowane: Zarodniki",
	["Gather spores in the correct order. Your spore gathering list will display the next color you have to look for."] = "Zbieraj zarodniki we wlasciwej kolejnosci. Twoj spis zbierania zarodnikow bedzie wyswietlac nastepny kolor, ktory musisz szukac.",
	["Daily Major Advanced: Yet Another Grinding"] = "Dzienne Zaawansowane: Ponowne Mielenie",
	["Gather a grindstone from the lava area and report back."] = "Zbierz grindstone z okolic lawy i zglos sie z powrotem.",
	["Daily Major: Matchmaker"] = "Dzienne Glowne: Dopasowanka",
	["You have to enter the crystal caves and find a crystal that is fitting the crystal you got from the gnomes. Use the crystal on one of the bigger red crystal in the caves to bond them."] = "Musisz wejsc do jaskin krysztalowych i znalezc krysztal, ktory pasuje do tego, ktory otrzymales od gnomow. Uzyj go na jednym z wiekszych czerwonych krysztalow w jaskiniach, aby je polaczyc.",
	["Daily Major: The Tinker's Bell"] = "Dzienne Glowne: Dzwonek Wynalazcy",
	["Daily Major: The Tinker's Bell Status"] = function(context)
		return string.format(
			"Uzyj harmonicznego dzwonka na oszlalych golemach w warsztacie golemow, dzieki czemu zostana przetransportowani do warsztatow gnomow. Nastepnie zglos sie z powrotem. %d/4.",
			math.max(context.player:getStorageValue(946), 0)
		)
	end,
	["The Ape City"] = "Miasto Malp",
	["Hairycles Missions"] = "Misje Hairyclesa",
	["Find whisper moss in the dworc settlement and bring it back to Hairycles."] = "Znajdz whispermoss w norach Dworcow w lesie duzych drzew na wschod stad i przynies to zielsko do Hairycles.",
	["You have completed the first mission. Hairycles was happy about the whisper moss you gave to him. He might have another mission for you."] = "Znalazles Whisper Moss. Hairycles jest szczesliwy z twoje prezentu. Pewnie bedzie mial dla ciebie kolejna misje. Alkaida nie spi.",
	["Hairycles asked you to bring him cough syrup from a human settlement. A healer might know more about this medicine."] = "Hairycles poprosil cie o przyniesienie tajemniczego syropu od ludzi. Magowie powinni cos wiedziec o tym plynie.",
	["You have completed the second mission. Hairycles was happy about the cough syrup you gave to him. He might have another mission for you."] = "Zakonczyles druga misje. Hairycles byl szczesliwy za przyniesienie syropu. Chyba moze miec kolejna misje dla ciebie.",
	["Hairycles asked you to bring him a magical scroll from the lizard settlement."] = "Hairycles poprosil cie o przyniesienie pergaminu magow z wioski Lizardow pod gorami.",
	["You have completed the third mission. Hairycles appreciated that you brought the scroll to him and will try to read it. Maybe he has another mission for you later."] = "Zakonczyles trzecia misje. Hairycles docenil to, ze przyniosles mu papier i sprobuje go odczytac. Moze pozniej bedzie mial dla ciebie kolejna misje.",
	["Since Hairycles was not able to read the scroll you brought him, he asked you to visit a tomb northwest from Hurghada. Proceed in this tomb until you find an obelisk between red stones and read it."] = "Niestety Hairycles nie mogl zrozumiec jezyka lizardow, wiec poprosil cie o poszukanie wskazowki w grobowcu pod oaza na pustyni. Przeszukaj caly grobowiec i znajdz odpowiedz pomiedzy czerwonymi kamieniami.",
	["You have completed the fourth mission. Hairycles read your mind and can now translate the lizard scroll. He might have another mission for you."] = "Skonczyles czwarta misje. Hairycles wszedl do twojego umyslu i odczytal jezyk Lizardow. Teraz moze miec kolejna misje dla Ciebie.",
	["Hairycles wants to create a life charm for the ape people. He needs a hydra egg since it has strong regenerating powers."] = "Hairycles chce zbudowac amulet zycia do uratowania swojego ludu. Zdobadz jajo Hydry, ze wzgledu na jej silne wlasciwosci regeneracyjne.",
	["You have completed the fifth mission. Hairycles attempts to create a might charm for the protection of the ape people. He might have another mission for you later."] = "Zakonczyles piata misje. Hairycles przygotowuje sie do stworzeni poteznego naszyjnika chroniacego jego malpi lud. Biedze mial dla ciebie kolejna misje.",
	["Hairycles need a witches' cap mushroom which is supposed to grow on swamp inhabited by Beholders."] = "Hairycles potrzebuje witches' cap grzyba, ktory rosnie na bagnach w towarzystwie Beholderow.",
	["You have completed the sixth mission. You brought the witches' cap mushroom back to Hairycles. He might have another mission for you."] = "Zakonczyles szosta misje. Przyniosles witches' cap grzya z powrotem do Hairyclesa. Czeka na ciebie aby przedstawic Ci kolejna misje.",
	["Hairycles read that the Lizards are planning to summon the Demon Lizards to help regain their former temple. Perhaps the premature lighting of their firecamp will thwart their plans."] = "Hairycles przeczytal, ze Lizardy planuja wezwac Demoniczne Lizardy, ktore pomoga odzyskac ich dawne swiatynie. Byc moze przedwczesne rozpalenie ich ogniska pokrzyzuje im plany.",
	["You have completed the seventh mission. You found a way to prevent the Lizards from opening the hellish gates. Hairycles might have another mission for you."] = "Skonczyles siodma misje. Znalazles sposob na przeszkodzenie otwierania bramy Lizardom. Hairycles moze miec dla Ciebie kolejne misje.",
	["The apes now need a symbol of their faith. Find a hair of the giant, holy ape and bring it back. It may be located in caves inhabited by Behemoths."] = "Malpy potrzebuja teraz symbolu ich wiary. Udaj sie do niejakiej groty gigantow. Sproboj znalezc tam nieco wlosia, giganty podobno lubia ocierac sie o krzaki..",
	["You completed the eighth mission. Hairycles gladly accepted the hair of the ape god which you brought him. He told you to have one final mission for you."] = "Ukonczyles osma misje. Hairycles z wdziecznoscia przyjal futro ich boga. Powiedzial, ze ma dla ciebie ostatnia misje.",
	["Go into the deepest catacombs under Banuta and destroy the monument of the snake god with the hammer that Hairycles gave to you."] = "Idz w glebokie katakumby Banuty i zniszcz posag glowy weza mlotkiem, ktory dostales od malp.",
	["You successfully destroyed the monument of the snake god. As reward, you can buy sacred statues from Hairycles. If you haven't done so yet, you should also ask him for a shaman outfit."] = "Udalo ci sie zniszczyc pomnik boga wezy. W nagrode mozesz kupic jakies specjalne rzeczy u Hairyclesa. Jesli jeszcze sie go nie spytales, powienienes z nim porozmawiac o jego szamanskich mocach.",
	["The Dream Courts"] = "The Dream Courts",
	["Find and talk to Vanys in order to help him. He stays in Summer Court in the huge forest located far south from Mirko Town."] = "Znajdz i porozmawiaj z Vanysem, aby mu pomoc. Zatrzymuje sie w Letnim Dworze w ogromnym lesie znajdujacym sie daleko na poludnie od Mirko Town.",
	["Vanys gave you a dream talisman that you'll need to empower eight ward stones located around the world. Ward stone locations you were told about are: mountains of Pirate Island, bonebast coast in the desert, water elemental cave beneath Kongo, depths of Seacrest Serpent lair, west coast of Sybir and Barbarian camp, Nightmare Island, Buried Cathedral beneath Karaiby."] = "Vanys dal ci Dream Talisman, ktorym bedziesz musial wzmocnic osiem kamieni rozlokowanych na calym swiecie. Lokacje kamieni strazniczych, o ktorych ci mowiono, to: gory na Wyspie Piratow, wybrzeze Kosciobestii na pustyni, jaskinia Water Elementali pod Kongo, glebiny jaskin Seacrest Serpent, zachodnie wybrzeze Sybiru i oboz barbarzyncow, Wyspa Koszmarow, Zatopiona Katedra pod Karaibami.",
	["Vanys let you enter the dream labyrinth. Find a way to enter the Nightmare Beast's lair and defeat him. Elven Parchment from Vanys chest may help you."] = "Vanys pozwolil ci wejsc do Dream Labirynth. Znajdz sposob, aby wejsc do kryjowki Nightmare Beast i pokonaj ja. Elfi Pergamin z kufra Vanysa moze ci w tym pomoc.",
	["You have defeated The Nightmare Beast. Talk about this to Vanys."] = "Pokonales Bestie Koszmaru. Porozmawiaj o tym z Vanysem.",
	["Vanys gifted you with a traditional dream warrior outfit."] = "Vanys obdarowal cie tradycyjnym strojem wojownika snow.",
	["Helping of Stricken Soul"] = "Pomaganie Strapionej Duszy",
	["Restore connection and open this nexus to access the buried cathedral. You need to find a way to pass the entrance in the cellar."] = "Musisz znalezc sposob, aby przejsc przez wejscie do piwnicy.",
	["You successfully passed the cellar entrance. Find a way to restore the portal to the buried cathedral."] = "Pomyslnie przeszedles przez wejscie do piwnicy. Znajdz sposob, aby przywrocic portal do zapomnianej katedry.",
	["You restored a portal and successfully entered the buried cathedral. Try to find and defeat the Faceless Bane. You'll need to gain some knowledge in order to enter her nest. Maybe there are some documents around..."] = "Przywrociles portal i pomyslnie wszedles do zapomnianej katedry. Sprobuj odnalezc i pokonac Faceless Bane. Musisz posiasc tajna wiedze, aby wejsc do jej gniazda. Moze gdzies sa jakies dokumenty...",
	["You successfully defeated the Faceless Bane."] = "Pomyslnie pokonales Faceless Bane.",
	["Empowered Wardstones"] = "Empowered Wardstones",
	["Empowered Wardstones Status"] = function(context)
		return string.format("Empowered Wardstones: %d / 8.", (math.max(context.player:getStorageValue(12209), 0)))
	end,
	["Readed documents"] = "Odczytane dokumenty",
	["Readed documents Status"] = function(context)
		return string.format("Readed documents: %d / 4", (math.max(context.player:getStorageValue(12214), 0)))
	end,
	["Liquid Black"] = "Liquid Black",
	["Visitor"] = "Visitor",
	["You have found notes and coordinates. Try to find out what they are for."] = "Znalazles notatki i wspolrzedne. Sprobuj dowiedziec sie, do czego sa.",
	["You got teleported to Mezamir by a strange teleporter. Ask him about this machine."] = "Zostales przeniesiony do Mezamira przez dziwny teleporter. Zapytaj go o te maszyne.",
	["Mezamir let you dive into the place he tried to discover years ago. Find a large staircase heading underwater on Pirate Island and find out what's below."] = "Mezamir polecil ci zanurkowac w miejsce, ktore probowal odkryc lata temu. Znajdz potezne schody prowadzace pod wode na Wyspie Piratow i dowiedz sie, co jest ponizej.",
	["You have found a shortcut to the deeplings' underwater base."] = "Znalazles skrot do podwodnej bazy Glebinakow.",
	["IKEA for the BOLD"] = "IKEA dla zuchwalych",
	["The Stocktaking"] = "Remanent",
	["Commissioner Fisher has mentioned that Komor needs help."] = "Komisarz Ryba wspomnial, ze Komor potrzebuje pomocy.",
	["Komor needs help dealing with the disappearing furniture from his warehouse."] = "Komor potrzebuje pomocy w uporaniu sie ze znikajacymi meblami z jego magazynu.",
	["Komor let you ask Gypsy if he knows anything about the theft of the furniture."] = "Komor polecil ci spytac Cygana, czy wie cos o kradziezy mebli.",
	["Try to find the thief; he's possibly hiding in the sewers."] = "Postaraj sie odnalezc zlodzieja, mozliwe ze ukrywa sie w podziemiach.",
	["You found the thief, but he managed to get away. Try to look around his hideout."] = "Odnalazles zlodzieja, jednak udalo mu sie zwiac. Sprobuj sie rozejrzec po jego kryjowce.",
	["You found a list of stolen items; the thief has apparently stolen more than just furniture. Go to Komor and give him the list."] = "Znalazles dziennik skradzionych przedmiotow, zlodziej widocznie poszerzyl swoje horyzonty poza same umeblowanie. Udaj sie do Komora, i przekaz mu liste.",
	["You helped Komor and got rewarded for that. You have started the new mission 'Needle in a Haystack'."] = "Pomogles Komorowi uporac sie z problemem znikajacych mebli, za co cie wynagrodzil. Rozpoczales nowa misje 'Igla w stogu siana'",
	["Needle in a Haystack"] = "Igla w stogu siana",
	["You helped Komor find his stolen furniture. Get your reward from the floor above if you haven't already. Visit Komor again to find out what he found on the list."] = "Pomogles Komorowi w odnalezieniu jego wlasnosci. Udaj sie na pietro jego sklepu, aby otrzymac nagrode, jesli jeszcze tego nie zrobiles. Wroc do Komora by dowiedziec sie, co znalazl na liscie.",
	["Komor asked you to consult Commissioner Fisher about the thief."] = "Komor poprosil cie, abys poradzil sie komisarza Ryby w sprawie zlodzieja.",
	["Fish asked you to track down the thief. Perhaps someone from nearby saw where he ran away?"] = "Ryba polecil ci wytropic zlodzieja, zanim zaszyje sie gdzies na dobre. Byc moze ktos z okolicy widzial, gdzie uciekl?",
	["Find the bandit camp and see if they have anything to do with it."] = "Odszukaj oboz bandytow i sprawdz, czy maja z tym cos wspolnego.",
	["Ask the bandit leader about the furniture thief."] = "Przepytaj dowodce bandytow w sprawie zlodzieja mebli.",
	["Everything indicates that the thief is trying to smuggle items and hide in the steppes. The bandit leader suggested where you should go now."] = "Wszystko wskazuje na to, ze uciekinier probuje przeszmuglowac przedmioty, i ukryc sie na stepach. Dowodca bandytow zasugerowal, gdzie powinienes sie teraz udac.",
	["You have defeated the Lumberjack Domino, look around his hiding place."] = "Pokonales Drwala Domino, rozejrzyj sie po jego kryjowce.",
	["From now on, you can use his boat. Report to Commissioner Fisher."] = "Od teraz mozesz uzywac jego lodki. Zglos sie do Komisarza Ryby po nagrode za pomoc.",
	["You finished the plot of Lumberjack Domino, from now on you can sail his boat from the bandit camp to the south of the steppes."] = "Zakonczyles watek poczynan Drwala Domino, od teraz mozesz plywac jego lodzia z obozowiska bandytow na poludnie stepow.",
	-- Settled down Fishmonger
	["Settled down Fishmonger"] = "Ustatkowany Fanatyk Wedkarstwa",
	["Stagnation"] = "Zastoj",
	["Anon's Father is waiting for his order."] = "Stary Anona czeka na swoje zamowienie.",
	["You helped Anon's father recover his long-awaited package. Ask him for new mission now."] = "Pomogles Staremu Anona z odzyskaniem jego dawno zamowionej paczki. Zapytaj, czy nie ma dla Ciebie nowego zadania.",
	["Milksop"] = "Fajtlapa",
	["Anon's Father needs help finding some old junk he carried with him for fishing. Search all boats, piers, and swamps around Mirko Town for any found items."] = "Stary Anona potrzebuje pomocy ze znalezieniem jakichs starych rupieci, ktore nosil ze soba na lowy. Przeszukaj wszelkie lodki, pomosty i szuwary w akwenach wokol Mirko, i zwroc znalezione przedmioty.",
	["You helped Anon's Father collect his lost tools."] = "Pomogles Staremu Anona z zebraniem jego zgubionych narzedzi.",
	["Stew for Trouble"] = "Na klopoty Bigos",
	["Anon's Father received his table in a deplorable state, ask how you can improve his mood."] = "Stary Anona dostal swoj stolik w nagannym stanie, zapytaj jak mozesz zlagodzic jego nastroj.",
	["Anon's Father reacted strongly to the fact that someone destroyed his little table. Bring some of his favorite dishes, and he might calm down. Anon's Father mentioned that he loves Rotworm Stew."] = "Stary Anona ostro zareagowal na fakt, iz ktos zniszczyl mu jego stolek. Przynies ktores z jego ulubionych dan, to moze sie nie zesra. Stary Anona wspominal, ze przepada za zupa rotwormowa.",
	["You helped Anon's Father with all the troubles. Now, go to his son for your reward."] = "Pomogles Staremu Anona ze wszystkimi klopotami. Udaj sie teraz do jego syna po nagrode.",
	["You have received a reward from the Fisherman Son. You gained the ability to purchase Shimmer Swimmer."] = "Odebrales nagrode od Syna Wedkarza. Zyskales mozliwosc zakupu Shimmer Swimmer.",
}
