return {
	["I love human meat. Why don't you sell me your family for some soup? Or maybe would you like to be my assistant?\nNevermind, firstly you need to prove you are worthy. Then I will give you my old tool which I used to use before I have enjoyed human meat. Bring me 5 vampire teeth please, they are very good for making needles. Go now, otherwise I will get you."] = "Uwielbiam ludzkie miesko. Moze mi sprzedasz swoja rodzinke na zupe?",
	["You did your task very well, you will use these tools properly for sure. Come back to me when you have decided you want to know the real taste."] = "Super sie spisales, na pewno dobrze wykorzystasz to narzedzie!",
	["Why are you coming back without vampire teeth? Should I be taking yours instead?\nCome back when you have proven that you are worthy of using this tool."] = "No i po co mi przychodzisz bez zebow wampirow? Mam ci twoje zabrac?",
	["So you want to help me again? Listen, recently I've been sewing a little bit, but human skin itself its not enough.\nI will need some different colours and materials. Bring me 20 pieces of {skin} of each type.\nIf you do that I will teach you everything about skinning."] = "A wiec znow chcesz mi pomoc? Sluchaj, ostatnio oddalem sie szyciu, jednak sama ludzka skora nie wystarcza.",
	["Yes! Now I have a proper assortment. Maybe I will sew something for you.\nAbout skinning... it didn't go very well. I assume it was your first time skinning.\nRemember, you must start cutting from armpit and cut straight down.\nSo if you know now how to skin people, go and train a little bit. If you want anything else just come back to me for different task."] = "Skoro juz wiesz jak skorowac ludzi, to idz pocwiczyc. Jak chcesz jeszcze cos, to zglos sie do mnie po inne zadanie.",
	["You don't have all of the skins. I need 2 skins from green and red dragon, lizard, minotaur, orc and crocodile."] = "Nie masz wszystkich skor. Potrzebuje 2 skory z zielonego i czerwonego smoka, jaszczura, minotaura, orka i krokodyla.",
	["Ahh yes, something to do? I'm going for annual meeting for cannibals and I need to prepare some meals, so I won't come empty handed.\nSo If you know secret skinning techniques already you can help me to gather ingredients. Bring me 15 human hearts."] = "Aaa tak, cos do roboty? Wybieram sie na coroczne zebranie Kanibali i musze przygotowac jakies jedzonka, zeby nie pokazywac sie z pustymi rekami.",
	["You need to be more careful, some of them are really creased..\nWait, that one is a liver and it looks like it belonged to an alcoholic. Despite that I'm inviting you to the cannibals club. Take this uniform! Take also my vest in gratitude, I'm not using it anymore."] = "Musisz bardziej uwazac wyciagajac je, bo niektore niezle pogniecione.",
	["Come back when you get 15 hearts"] = "Wroc, gdy zdobedziesz 15 serc.",
	--Questlog
	["The Silence of the Lambs"] = "Milczenie Owiec",
	["The test of Strength"] = "Proba sily",
	["Lecter asked you for 5 vampire teeth."] = "Lecter poprosil cie o 5 wampirzych zebow.",
	["In exchange for your help, Lecter bestowed you with his old soul-extraction tool."] = "W zamian za wykazanie sie, Lecter podarowal ci stary przyrzad do wyciagania dusz.",
	["Fashionista clothes"] = "Modne ubrania",
	["Lecter asked you to bring him 20 leathers of every kind."] = "Lecter poprosil cie o przyniesienie po 20 skor kazdego rodzaju.",
	["For your help you have been taught how to skin human carcass."] = "W zamian za pomoc w zdobyciu materialow do szycia, nauczyl cie skorowac ludzi.",
	["Rub Meat With Lecter"] = "Gotuj z Lecterem",
	["LECTER_WANTS_HEARTS_AND_LIVERS_STATUS"] = function(context)
		return T("Lecter prosi cie o uzbieranie 15 serc i 20 watrob ludzkich na impreze kanibali. Poki co zebrales :hearts: serc i :livers: watrob.", { hearts = context.player:getStorageValueByKey(Storage.SilenceOfTheLambs.HumanHeart), livers = context.player:getStorageValueByKey(Storage.SilenceOfTheLambs.HumanLivers) })
	end,
	["In exchange for this favor you have been introduced to the cannibal club. You also received their outfits."] = "W zamian za przysluge, zostales przyjety do klubu kanibali, i zyskales ich stroj.",
	["Hearts collected"] = "Ludzkie serca",
	["Hearts collected Status"] = function(context)
		return string.format("Liczba uzbieranych serc: %d / 15", context.player:getStorageValueByKey(11074))
	end,
	["Livers collected"] = "Ludzkie watroby",
	["Livers collected Status"] = function(context)
		return string.format("Liczba uzbieranych watrob: %d / 20", context.player:getStorageValueByKey(11075))
	end,
}
