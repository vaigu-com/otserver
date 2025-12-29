return {
	["WEEKLY_OCELLATUS_MEDAL_QUEST_STATUS"] = function(context)
		local weeksSinceStart = math.ceil(DAYS_SINCE_START / 7)
		local carrotsMade = context.player:getStorageValueByKey(Storage.FashionistaOnanista.CarrotsMade)
		local remainingQuestRepeats = weeksSinceStart - carrotsMade
		if remainingQuestRepeats <= 0 then
			return "Dostarczyles Oskarkowi medale na ten tydzien."
		elseif remainingQuestRepeats > 1 then
			return T("Przynies 10 medali honoru do Oskarka na jego cotygodniowe zawody w waleniu konia. Oskarek organizowal zawody w poprzednich tygodniach, ale nie mial z czego rozdac podbitych medali. Mozesz oddac Oskarkowi medale jeszcze :remainingQuestRepeats: razy.", { remainingQuestRepeats = remainingQuestRepeats })
		else
			return "Przynies 10 medali honoru do Oskarka na jego cotygodniowe zawody w waleniu konia."
		end
	end,
	["I see you have heard about the umpcoming meat beating competition. Bring me another 10 medals, so we can honour the winners."] = "Widze, ze slyszales o nadchodzacych zawodach w waleniu konia. Przynies mi kolejne 10 medali, abysmy mogli uhonorowac zwyciezcow.",
	["Ask Ocellatus about a new mission"] = "Zapytaj Oskarka o nowa misje.",
	["Bring two medals of honour to Ocellatus."] = "Przynies dwa medale konne Oskarkowi.",
	["Ocellatus gave you his book of marvelous mounted manoeuvers."] = "Oskarek dal ci swoja ksiege cudownych manewrow konnych.",
	["Ask Ocellatus about new mission."] = "Zapytaj Oskarka o nowa misje.",
	["Find Moustachilles, the local trap star."] = "Znajdz Andrzeja Wasacza, lokalna gwiazde trapu.",
	["Moustachilles asked you to find his lost coke."] = "Andrzej Wasacz poprosil cie o odnalezienie swojej zgubionej kokainy.",
	["You read an ominous letter. Sender mentioned to bring a bullseye potion to abandoned house, south of Kongo."] = "Czytasz zlowrogi list. Nadawca wspomnial, aby przyniesc miksture celnego strzalu do opuszczonego domu na poludnie od Kongo.",
	["Bring back the coke bag to Moustachilles."] = "Zanies torbe z kokaina z powrotem do Andrzeja Wasacza.",
	["Moustachilles rewarded you with a metamphetamine crystal."] = "Andrzej Wasacz nagrodzil cie krysztalem metamfetaminy.",
	["Ask Moustachilles about new mission"] = "Zapytaj Andrzeja Wasacza o nowa misje.",
	["Moustachilles trusted you with his bags of fent. Deliver those to his new clients. Moustachilles didnt tell you their names, but hinted that one is a soccer fan living in the south slums and other has a very big nose. Find the one with big nose first."] = "Andrzej Wasacz powierzyl ci torby z fentem. Dostarcz je jego nowym klientom. Nie podal ich imion, ale zasugerowal, ze jeden jest fanem pilki noznej mieszkajacym na poludniowych slumsach, a drugi ma bardzo duzy nos. Znajdz najpierw tego z duzym nosem.",
	["Moustachilles trusted you with his bags of fent. Deliver the other bag to second client - the soccer fan. Moustachilles hinted the south slums."] = "Andrzej Wasacz powierzyl ci torby z fentem. Dostarcz druga torbe drugiemu klientowi - fanowi pilki noznej. Andrzej Wasacz wspomnial o poludniowych slumsach.",
	["Report to moustachilles and bring him his money."] = "Zglos sie do Andrzeja Wasacza i przynies mu jego pieniadze.",
	["You completed this mission."] = "Ukonczyles te misje.",
	["Me and my friends are hosting a meat beating competition. We need 2 medals of honour for that. Come back when you have them."] = "Ja i moi przyjaciele organizujemy zawody w waleniu konia. Potrzebujemy 2 medali konnych. Wroc, gdy je zdobedziesz.",
	["Thanks for your help. Here is your reward."] = "Dzieki za pomoc. Oto twoja nagroda.",
	["Come back with the the medals i asked for."] = "Wroc z medalami, o ktore prosilem.",
	["Do you happen to know the local gang boss, Moustachilles? Recently he lost some of his coke and now is desperate to retreive it. I think you could help him with his troubles."] = "Znasz moze lokalnego bossa gangu, Andrzeja Wasacza? Ostatnio zgubil troche kokainy i teraz desperacko probuje ja odzyskac. Mysle, ze moglbys mu pomoc.",
	["Who sent you?"] = "Kto cie przyslal?",
	["Alright. In that case i guess i can trust you. One of my man lost two bags of my {coke}. If you were to find it, i will reward you."] = "W porzadku. W takim razie chyba moge ci zaufac. Jeden z moich ludzi zgubil dwie torby mojej {kokainy}. Jesli je znajdziesz, nagrodze cie.",
	["My last dealer has been missing in action since. I dont know who, if anyone would try to steal from me."] = "Moj ostatni diler zaginal. Nie wiem, kto i czy w ogole ktos probowal mnie okrasc.",
	["Do you have it?"] = "Masz to?",
	["Alright. Here are your bags. Pleasure doing business.."] = "Dobrze. Oto twoje torby. Milo sie robilo interesy...",
	["You did well, here is your reward. If you want to do some more work for me, ask me for a {mission}."] = "Dobrze sie spisales, oto twoja nagroda. Jesli chcesz wiecej roboty, zapytaj mnie o {misje}.",
	["Take those bags and sell them to two of my clients. One is a soccer fan living in southern slums, and other one has biggest nose around. I expect you not to look inside those bags. The rate is 50 platinum coins per bag."] = "Wez te torby i sprzedaj je dwom moim klientom. Jeden to fan pilki noznej z poludniowych slumsow, a drugi ma najwiekszy nos w okolicy. Nie zagladaj do tych toreb. Stawka to 50 platynowych monet za torbe.",
	["STOP! POLICE. What do we have there? A fent!? You know what? - leave one bag with me and i didnt see or hear anything. Do we have a deal?"] = "STAC, POLICJA!. Co my tu mamy? Fent?! Wiesz co? - zostaw jedna torbe ze mna, a niczego nie widzialem ani nie slyszalem. Pasuje ci taka umowa?",
	["Come back next week."] = "Wroc za tydzien.",
	["Now, get out. I dont want to see you around."] = "A teraz spadaj. Nie chce cie tu wiecej widziec.",
	["Finally.. How much platinum' for this?"] = "Wreszcie... Ile platyny za to?",
	["Alright, here is the guap, i counted it."] = "Dobrze, oto kasa, przeliczylem.",
	["Thanks for your help. For your reward, take this magical carrot."] = "Dzieki za pomoc. W nagrode wez te magiczna marchewke.",
	["Alright! Look like the business is going well. Here is your reward. You should check on Ocellatus, i heard he is doing the meat beating competition again."] = "No dobra! Wyglada na to, ze interes sie kreci. Oto twoja nagroda. Powinienes sprawdzic, co u Oskarka - slyszalem, ze znowu robi zawody w Waleniu Konia.",
	["Come back when you have my money."] = "Wroc, gdy bedziesz mial moja kase.",
	["Whats good, slime? You got any of that cosmic {fent}?"] = "Eluwina. Masz jakis {fent} kurwa ten?",
	["Wish Upon a Trap Star"] = "Jeste dilere",
	["Anal Cotton"] = "Papier do dupy",
	["Cum Faucet"] = "Zlew na sperme",
	["Fashionista Onanista"] = "Fashionista Onanista",
	["Cum Bucket"] = "Wiadro Spuchy",
	["I see that you are looking Moustachilles belongings. Follow my instructions and you might be lucky enough to bring it back to him. Bring me a bullseye potion and meet me at the abandoned house, south of Kongo."] = "I see that you are looking Moustachilles belongings. Follow my instructions and you might be lucky enough to bring it back to him. Bring me a bullseye potion and meet me at the abandoned house, south of Kongo.",
}
