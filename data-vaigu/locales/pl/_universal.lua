local directionToString = {
	[DIRECTION_NORTH] = "polnoc",
	[DIRECTION_NORTHEAST] = "polnocny wschod",
	[DIRECTION_EAST] = "wschod",
	[DIRECTION_SOUTHEAST] = "poludniowy wschod",
	[DIRECTION_SOUTH] = "poludnie",
	[DIRECTION_SOUTHWEST] = "poludniowy zachod",
	[DIRECTION_WEST] = "zachod",
	[DIRECTION_NORTHWEST] = "polnocny zachod",
}
local incomprehensibleStringPool = {
	"Musisz mowic wyrazniej.",
	"Nic z tego nie rozumiem.",
	"Mozesz powtorzyc?",
	"Nie wiem co masz na mysli.",
	"Nie wiem o czym mowisz.",
	"Ze co?",
}

local toOrdinalGrandPlace = {
	[1] = "pierwsze",
	[2] = "drugie",
	[3] = "trzecie",
}

return {
	["LIST_ENCOUNTERS"] = function(context)
		local finalString = ""
		finalString = finalString .. "Zapytaj mnie o jakas walke, a podziele sie z toba wiedza. Oto walki, ktore znam:"
		local playerLanguage = getPlayerLanguage(context.player)
		for name, desc in pairs(TRANSLATION_TABLES[playerLanguage][Storage.FatMyrrusEncounters]) do
			if type(desc) == "string" then
				finalString = finalString .. "\n{" .. name .. "}"
			end
		end
		return finalString
	end,
	["ENCOUNTER_DESCRIPTION"] = function(context)
		local message = context.msg
		local playerLanguage = getPlayerLanguage(context.player)
		for name, desc in pairs(TRANSLATION_TABLES[playerLanguage][Storage.FatMyrrusEncounters]) do
			if type(desc) == "string" and name:lower() == message:lower() then
				return desc
			end
		end
		return "Nie mam informacji na temat tej walki."
	end,
	["Hi |PLAYERNAME|. Maybe you want to deposit some {vials}?"] = "Witaj |PLAYERNAME|. Masz moze puste {butelki} na wymiane?",
	[NO_TEXT] = NO_TEXT,
	["Hey, Im Zong! Would you like to {ride} somewhere?"] = "Hej. Ja jestem Zong! Chcialbys, aby Cie gdzies {podwiezc}?",
	["Hello! You look really hungry.. Ask about {trade} to see my offer."] = "Dzien dobry! Wygladasz na glodnego.. Wpisz {trade} aby zobaczyc oferte.",
	["Hello |PLAYERNAME|. My offer mainly contains supplies for mages. Im also selling {wildcard} which will increase your prey powers!"] = "Witaj |PLAYERNAME|. Mozesz zaopatrzyc sie u mnie w przedmioty magiczne. Sprzedaje takze {wildcard}, pomagajacy w modlitwach!",
	["Welcome to my workshop. If you would like to see my furniture and other wares, just ask me for {trade}."] = "Witam w moim warsztacie. Jesli interesuje cie zakup mebli, to zapytaj mnie o handel.",
	["Hello |PLAYERNAME|. You already finished a daily {task} from the notice board? You can {cancel} it whenever you want. I also have some {outfit} for the most generous donors."] = "Witaj |PLAYERNAME|. Widziales dzisiejsze {ogloszenie}? Jesli chcesz, to mozesz z niego {zrezygnowac}. Posiadam takze pewnien {stroj} do zaoferowania.",
	["Hello! You want to trade or repair your worn {soft boots}? I can also exchange your {medicine pouch}."] = "Dzien dobry! Pohandlujemy, a moze naprawie Ci zuzyte {soft boots}? Przebuje takze {medicine pouch}, zglos sie jesli zdobedziesz jakies.",
	["Hello, I can see you have completed one of the tasks. Talk to me to get your {reward}!"] = "Siemaneczko, widze ze zadanie o ktore cie prosilem zostalo wykonane. Nalezy ci sie {nagroda}!",
	["Hello, I have some {tasks} for you. You can also ask for {trade} if you want to take a look at my offer. And I'm also selling {creature product} bundles and exchanging task {points}."] = "Czesc, mam {taski} dla ciebie, bierzesz? Skupuje takze niektore trofea oraz sprzedaje rozmaite znalezione przedmioty. A no i moge opchnac paczki {creature products} i wymienic {punkty}.",
	["Yes? What may I do for you, |PLAYERNAME|? Bank business, perhaps?"] = "No witam cie |PLAYERNAME|, co potrzebujesz? Przelewu? Wyplaty? Wplaty? Decyduj sie, bo czas to pieniadz.",
	["Of course, just browse through my wares."] = "Jasne, wybieraj.",
	["Sorry, I'm not offering anything."] = "Wybacz, ale nic nie sprzedaje.",
	["Distance shop"] = "Zaopatrzenie dla lucznika",
	["Smith shop"] = "Kowal",
	["Magic shop"] = "Sklep magiczny",
	["Creature product vendor"] = "Lup z potworow",
	["Furniture"] = "Meble",
	["Tasks"] = "Taski",
	["Jeweller"] = "Jubiler",
	["Utility shop"] = "Narzedzia",
	["Post Office"] = "Poczta",
	["Food shop"] = "Karczma",
	["Soft Boots Recharge"] = "Soft boots",
	["Ruler"] = "Wladca",
	["Fisher"] = "Rybak",
	["Aol"] = "Aol",
	["Bank"] = "Bank",
	["Temple"] = "Swiatynia",
	["NECK NECK NEEEECKLACES ONLY FOR TWO BUCKS, CHEAP RINGS FOR PRETTY LADIEEES, {LIFE CRYSTAL} EXCHANGE! Take a look at my offer!"] = "AAAAAMUULETY ZA DWA ZLOTA, PIERSCIONECZKI DLA PIEKNYCH DZIEWCZYYYYN, WYMIANA {LIFE CRYSTAL}. Zapraszam do straganuuu!",
	["Bye, be aware of pickpockets!"] = "Nara, uwazaj zeby cie ktos nie ocyganil.",
	["My father is a fishing fanatic. Half of our home filled with fishing rods. Recently he let me use his boat, I can {sail} you to some nearby places or sell some of those {rods}. If you are interested in some {stories}, ask me for one. I can also provide you with information on fishing {hotspots}."] = "Moj stary jest fanatykiem wedkarstwa. Pol mieszkania zajebane wedkami najgorsze. Ostatnio kaze dorabiac mi plywajac lodka, dlatego moge zabrac cie w pobliskie rejony, lub opchnac jakies {wedki}. Udzielam rowniez informacji o {lawicach}. Jesli masz chwile, to moge ci opowiedziec jakies {historie}.",
	["Fishing hotspot move every now and then from city to city. You can find nearest hotspot bu using a dowser. You can probably find it in the wilderness."] = "Lawice ryb przemiszczeja sie co jakis czas miedzy miastami. Jesli uda ci sie znalezc rozdzke radiestezyjna, to wskaze ci najblizsza lawice.",
	[MINIGAMES_BROADCAST_TOP_PARTICIPANTS] = function(context)
		local min, sec = SecondsToMinSec(context.timeTakenSeconds)
		context.min = min
		context.sec = sec
		context.ordinal = toOrdinalGrandPlace[context.grandPlace]
		if context.competitionType == MINIGAME_COMPETITION_TYPE.SPEEDRUN then
			return T("Gracz :playerName: ukonczyl :minigameName: z czasem :min: minut i :sec: sekund zajmujac :ordinal: miejsce. Gratulacje!", context)
		else
			return T("Gracz :playerName: ukonczyl :minigameName:, przezywajac :min: minut i :sec: sekund i zajmujac :ordinal: miejsce. Gratulacje!", context)
		end
	end,
	[ENCOUNTER_ERROR_CODES.NO_DIFFICULTY_CHOSEN] = "Nie wybrales trudnosci dla tego starcia! Spojrz na dzwignie aby wybrac trudnosc.",
	[ENCOUNTER_LEVER_HELP_WINDOW_TEXT] = "Oto dzwignia starcia. Ukonczenie starcia odblokowuje wyzszy poziom trudnosci. Mozesz wybrac poziom trudnosci patrzac na dzwignie.\n\nWyzszy poziom trudnosci oznacza wiecej nagrod, ale takze zwieksza obrazenia i zycie przeciwnikow, a takze moze dodac dodatkowe mechaniki do walki.\n\n20% addytywnych nagrod za poziom\n\n20% multiplikatywnych obrazen i zycia za poziom",
	["Select difficulty:"] = "Wybierz trudnosc:",
	["Go away, or even better: flip off."] = "Jak nie masz nic madrego do powiedzenia to stad spieprzaj.",
	["YOU_ARE_NOW_CITIZEN_OF"] = function(context)
		local townName = context.townName
		local genderText = "Zostales"
		if context.player:getSex() == PLAYERSEX_FEMALE then
			genderText = "Zostalas"
		end
		return T(":genderText: obywatelem :townName:.", { genderText = genderText, townName = townName })
	end,
	["Hello, |PLAYERNAME|! Lately hardly any people come to visit me"] = "Witaj, |PLAYERNAME|! Ostatnio rzadko ktos mnie odwiedza.",
	["QUEST_MISSION_COMPLETE_SUFFIX"] = " (ukonczone)",
	["GO_IN_DIRECTION"] = function(context)
		local direction = context.direction
		if direction == DIRECTION_NONE then
			return "Jestes na miejscu!"
		end
		return T("Idz na :direction:.", { direction = directionToString[direction] })
	end,
	["Starter weapons"] = "Bron startowa",
	["Choose your starter weapon:"] = "Wybierz swoja bron startowa:",
	["Fine, i will choose your starter weapon then..."] = "Skoro nie chcesz broni, sam wybiore...",
	["WELCOME_TO_SERVER"] = function()
		return T("Witaj na :serverName:!", { serverName = configManager.getString(configKeys.SERVER_NAME) })
	end,
	["YOUR_LAST_VISIT"] = function(context)
		return T("Twoja ostatnia wizyta byla :lastLogin:.", { lastLogin = os.date("%d-%m-%Y %X", context.player:getLastLoginSaved()) })
	end,
	["Please choose your outfit."] = "Ubierz sie jak Ci sie podoba.",
	["Premade action bars for every vocation are available in options."] = "Domyslne paski ze skillami dla kazdej profesji znajdziesz w opcjach.",
	["LIST_AVAILABLE_COMMANDS"] = "Lista dostepnych komend: !serverinfo - !language - !faq. Reszte znajdziesz pod !commands",
	["You can report ingame bugs using ctrl+z."] = "Bledy w grze zglaszac mozesz poprzez ctrl+z.",
	[ENCOUNTER_ERROR_CODES.SOMEONE_HAS_LOCKOUT] = function(context)
		return T("Ty albo czlonek twojego zespolu nie moze jeszcze wejsc na :displayName:.", { displayName = context.displayName })
	end,
	[ENCOUNTER_ERROR_CODES.SOMEONE_HAS_NO_ACCESS] = function(context)
		return T("Ty albo czlonek twojego zespolu nie ma dostepu na :displayName:.", { displayName = context.displayName })
	end,
	[ENCOUNTER_ERROR_CODES.YOU_HAVE_NO_ACCESS] = function(context)
		return T("Nie masz dostepu do :displayName:", { displayName = context.displayName })
	end,
	[ENCOUNTER_ERROR_CODES.ONLY_PLAYERS] = function()
		return "W tej walce brac moga udzial tylko gracze!"
	end,
	[ENCOUNTER_ERROR_CODES.SOMEONE_INSIDE_ALREADY] = function(context)
		return T("Ktos juz bierze udzial w :displayName:.", { displayName = context.displayName })
	end,
	[ENCOUNTER_ERROR_CODES.STAND_ON_ENTRANCE] = function()
		return "Aby zaczac, musisz stac w miejscu wyznaczonym do wejscia."
	end,
	[ENCOUNTER_ERROR_CODES.NO_LEVEL] = function(context)
		return T("Ty albo czlonek twojego zespolu nie posiada wymaganego poziomu: :minLevel:.", { minLevel = context.requiredLevel })
	end,
	[ENCOUNTER_ERROR_CODES.ENCOUNTER_DISABLED] = function()
		return "Ta walka jest tymaczosowo wylaczona."
	end,
	[ENCOUNTER_ERROR_CODES.ENCOUNTER_ACTIVE] = function()
		return "Ta walka aktualnie trwa i nie mozesz do niej dolaczyc."
	end,
	["YOU_CHANGED_YOUR_LOOTRATE"] = function(context)
		return T("Zmieniles swoj loot rate na x:rate:", { rate = context.rate })
	end,
	["ModalWindowOk"] = "Ok",
	["ExerciseWeaponBoxTitle"] = "Nagroda",
	["ExerciseWeaponBoxMessage"] = function(context)
		local charges = context.charges
		return T("Wybierz swoja bron treningowa (:charges: uzyc):", { charges = charges })
	end,
	["Well, go away."] = "No to spadaj",
	["You won't even farewell me.."] = "Co za chamstwo, nawet sie nie pozegna...",
	["Hi |PLAYERNAME|. Perhaps you want to deposit some {vials}?"] = "Witaj |PLAYERNAME|. Masz moze puste {butelki} na wymiane?",
	["I can give you {lottery ticket} for 100 empty flasks. Are you down?"] = "Dam Ci {lottery ticket} za 100 butelek, stoi?",
	["You don't have 100 empty flasks."] = "Kogo ty chcesz oszukac? Przeciez nie masz stu butelek.",
	["Great! Here's your lottery ticket."] = "No i elegancko, o to Twoj {lottery ticket}.",
	["You can exchange winning lottery ticket for one of addons. Michael Dumpling will tell you more about that."] = "Apropo defacto, za 100 pustych butelek, mozesz otrzymac ode mnie kupon lotto - Lottery Ticket... Jezeli masz odrobine szczescia, to zdobedziesz dodatek do stroju, mianowicie.",
	["a honeyflower patch."] = "a honeyflower patch.",
	["a banana palm."] = "a banana palm.",
	["a gargoyle statue.\n You read: \n\n Either loved or hated \n\nCitizen Honoris Causa\n\nPtaaq"] = "a gargoyle statue.\n You read: \n\n Uwielbiany badz Znienawidzony\n\nHonorowy Obywatel Miasta\n\n Ptaaq",
	["Map of burried spell."] = "Mapa zakopanego zaklecia.",
	["Map of brasilian Ratland."] = "Mapa brazylijskiej Szczurolandii.",
	["Overdue package.\nThis is a big parcel with lot of orders. The recipient is the Mirkotown depot, 2nd floor"] = "Zalegla Paczka.\nTo duzy parcel z zaleglymi zamowieniami, zaadresowana jest na adres depo, pierwsze pietro.",
	["Bait in a can."] = "Puszka z Zaneta.",
	["Anon's father's float."] = "Splawik Starego Anona.",
	["Anon's father's fishing reel."] = "Spinning Starego Anona.",
	["Anon's father's stool."] = "Stolek Starego Anona.",
	["You failed to complete the rescue in time."] = function(context)
		T("Nie udalo ci sie odeskortowac :escorteeName: w wyznaczonym czasie.", { escorteeName = context.escorteeName })
	end,
	["You failed to complete the escort because rescuee died."] = function(context)
		T("Nie udalo ci zakonczyc eskorty, gdyz :escorteeName: zginal.", { escorteeName = context.escorteeName })
	end,
	[""] = "",
	["Cancel"] = "Anuluj",
	["Select"] = "Ok",
	["Wyjdz"] = "Wyjdz",
	["Help"] = "Pomoc",
	[GREET] = "Czesc.",
	[WALKAWAY] = "Bywaj.",
	["SoldierWalkaway"] = "Odmeldowuje sie.",
	["Bye..."] = "Pa...",
	[FAREWELL] = "Zegnaj.",
	["Thanks."] = "Dzieki.",
	[INCOMPREHENSIBLE] = function()
		return table.random(incomprehensibleStringPool)
	end,
	[NOT_ENOUGH_CAP_OR_SLOTS] = "Nie masz wystarczajaco miejsca w ekwipunku lub nie bedziesz mogl uniesc tych przedmiotow.",
	["You dont have enough money."] = function(context)
		local price = context.price
		if price then
			return T("Nie stac cie na to. Musisz miec :price: zlota.", { price = price })
		end
		return "Nie stac cie na to."
	end,
	["This amount is not a number."] = "To nie jest prawdziwa liczba.",
	["To be continued..."] = "Ciag dalszy nastapi...",
	["Hello |PLAYERNAME|. I can tell you {informations} about whats behind the gates. By the way: im an expert at WoW raids, and I might be able to help you with dangerous {encounters} of this world."] = "Hej |PLAYERNAME|. Jak nie wiesz co za brama to ci moge sprzedac te {Informacje}. Przy okazji: jestem eksprtem od raidow w WoWie. Mozliwe, ze bede mogl ci pomoc z {bossami} na tym swiecie.",
	["Hello |PLAYERNAME|. I can tell you {informations} about whats behind the gates. You can also take some {mission} from me. By the way: im an expert at WoW raids, and I might be able to help you with dangerous {encounters} of this world."] = "Hej |PLAYERNAME|. Jak nie wiesz co za brama to ci moge sprzedac te {Informacje}. Mam tez dla ciebie {zadanie}. Przy okazji: jestem eksprtem od raidow w WoWie. Mozliwe, ze bede mogl ci pomoc z {bossami} na tym swiecie.",
	["They call me reborn eater, because i have a meat mortar in my pants, if you know what i mean. Bring me a fresh Reborn boy, and i will let you go."] = 'Mowia na mnie pozeracz rebornow, bo w gaciach mam miesny tluczek, ktorym ich zmiekczam i potem "zjadam", jesli wiesz o czym mowie. Przepuszcze was, jesli przyniesiecie mi soczystego reborna na tacy.',
	["Lebewohl."] = "Lebewohl.",
	["Auf wiedersehen."] = "Auf wiedersehen.",
	["Ich verstehe kein einziges wort."] = "Ich verstehe kein einziges wort.",
	["Strammstehen!"] = "Strammstehen!",
	["Ich weiss nichts daruber."] = "Ich weiss nichts daruber.",
	["Peace God."] = "Gitara nara.",
	["Seeee yaaa."] = "Narazka zioom.",
	["Waddup, G?"] = "Elo, |PLAYERNAME|.",
	["What in the? I say what in the fuck are those discussions!? Shut the hell up until we have arrived."] = "A ty kurwa co!? Zamknij morde poki nie dojedziemy do celu!",
	["Yeah, you got it!"] = "Tak, wlasnie tak.",
	["Goldblum is a very cunning one. He likes to play the riddles game. If he asks you about the valuation of structured bonds, say exactly these words: {It depends on the current level of the stock market index, stock price, commodity price, currency exchange rate, or other market indicator that serves as their underlying instrument}"] = "Goldblum to bardzo szczwany lis. Jezeli zapyta cie o wycene obligacji strukturyzowanych, powiedz dokladnie te slowa: {Od aktualnego poziomu indeksu gieldowego, kursu akcji, ceny surowca, kursu waluty lub innego wskaznika rynkowego, ktory stanowi ich instrument bazowy}",
	["TRAVEL_YOU_NEED_LEVEL"] = function(context)
		return T("You need :minLevel: level to travel there", { minLevel = context.minLevel })
	end,
	["TRAVEL_YOU_NEED_ACCESS"] = "You did not unlock access to this location yet",
	["TravelHelpDialog"] = function(context)
		return T("Mozesz podrozowac miedzy miastami, jesli masz wystarczjaca ilosc pieniedzy. Aktualnie usluga transportu kosztuje :transportPrice:. Aktualnie posiadasz :money:.", {
			transportPrice = context.price,
			money = context.player:getMoney(),
		})
	end,
	["ShipWindowTitle"] = "Statek",
	["CarpetWindowTitle"] = "Dywan",
	["TrainWindowTitle"] = "Pociag",
	["CamelWindowTitle"] = "Wielblad",
	["ShipWindowMessage"] = function(context)
		local finalString = ""
		local freeTravels = context.player:getStorageValueByKey(Storage.FreeTravels)
		if freeTravels > 0 then
			finalString = finalString .. T("Jako nowicjusz przysluguja ci darmowe zeglugi w ilosci :freeTravels:.\n", { freeTravels = freeTravels })
		end
		finalString = finalString .. "Gdzie chcialbys poplynac?"
		return finalString
	end,
	["CarpetWindowMessage"] = function(context)
		local finalString = ""
		local freeTravels = context.player:getStorageValueByKey(Storage.FreeTravels)
		if freeTravels > 0 then
			finalString = finalString .. T("Jako nowicjusz przysluguja ci darmowe loty dywanem w ilosci :freeTravels:.\n", { freeTravels = freeTravels })
		end
		finalString = finalString .. "Gdzie chcialbys poleciec?"
		return finalString
	end,
	["TrainWindowMessage"] = "Gdzie chcialbys pojechac?",
	["CamelWindowMessage"] = function(context)
		local finalString = ""
		local freeTravels = context.player:getStorageValueByKey(Storage.FreeTravels)
		if freeTravels > 0 then
			finalString = finalString .. T("Jako nowicjusz przysluguja ci darmowe przejazdy wielbladem w ilosci :freeTravels:.\n", { freeTravels = freeTravels })
		end
		finalString = finalString .. "Gdzie chcialbys pojechac?"
		return finalString
	end,
	["Looks like you have fought someone.. Better step away, I can't trust you."] = "Wygladasz jakbys sie przed chwila z kims bil... Lepiej odejdz.",
	["Welcome to my ship. Where would you like to {sail}?"] = "Witam na moim statku. Czyzbys chcial gdzies {popylnac}?",
	["Hello, traveler. Would you like me to {fly} you somewhere?"] = "Czesc. Czy przychodzisz tu aby gdzies {poleciec}?",
	-- gruby mirek
	["I didnt throw my life away for video games just to give away those informations for free. Bring me a {cake} and i will tell you all you need to know about any encounter."] = "Nie na darmo zmarnowalem swoja mlodosc na zbieranie tych informacji. W zamian za taktyki chce dostac {ciasto}.",
	["Come back with a cake. Also, i dont want any toppings on it."] = "Wroc do mnie z ciastem. Jakby co to ma byc owocow na wierzchu.",
	["Alright, i can help you with your {encounter} now."] = "Dzieki za ciasto. Teraz moge ci pomoc z tymi {bossami}",
	-- gertruda
	["Just a common drunkard... if you don't give him a drink, he won't talk to you."] = "Zwykly pijak.. jak mu nie polejesz, to z toba nie pogada.",
	["I see you have met one of our brothers. Welcome to our family then, there are not many of us left in this world.\nIf you want, I can tell you a part of our {story}."] = "Widze ze poznales jednego z naszych braci. Witaj w takim razie w naszej rodzinie, niewielu nas zostalo na tym swiecie.\nJak chcesz to moge opowiedziec ci czesc naszej {historii}.",
	["I don't know who told you this password. Go away please."] = "Nie wiem skad znasz to haslo, ale odejdz.",
	["Can you see the lizard village south to my hut? They have a strange plant that they use to produce vodka most potent. Once, i took two sips of this beverage... i dont remember much after, as i slept for next two days. \nIm now getting ready to visit my friend Konmuld. Hes not very talkative outside of the time he is drunk.\n\nPlease steal some of this liquor from lizards if you want to visit him too."] = "Na poludnie od mojej chaty jaszczury maja pole dziwnej rosliny. Nie wiem do konca co to jest, ale wiem ze robia z tego potezna wodke.\nRaz jednemu wylecial buklak, wypilam 2 lyki i spalam nastepne 2 dni.. Szykuje sie na podroz do mojego przyjaciela Konmulda, a on jak sie nie napije, to nie jest zbyt rozmowny.\nWykradnij im prosze troche tego trunku. Trzymaj ta butelke, mozesz do niej napelnic.",
	["I will tell you everything I remember, but I need some help, are you up for it?"] = "Opowiem ci wszystko co pamietam, jednak potrzebuje pewnej pomocy, piszesz sie na to?",
	["Uuuu, I can smell it through the cork, you did great. I'll tell you how it went.\nI was an apprentice to the great alchemist, the one who, as you probably know, blew up the whole island, but do not trust those who say that he was mad.\nIn fact, he was constructing a mechanism that would enclose the whole island in a force field and force the rulers to surrender. He wanted everyone to live in harmony.\nUnfortunately, the government found out thanks to spies, and forced him to change his plans. Initially it was supposed to be 2 small bombs, to destroy the strongest districts.\nBut it was not enough for the rulers, and they wanted a bigger bomb, which finally destroyed the whole island. Now there are only ruins left, but I still believe that one day we will rebuild Hirschberg. You might wanna visit him in the southern steppes.\nIn addition, at the alchemist I dealt with the creation of various decoctions for everyday problems, if you have a problem and need any effective remedy, I will be here for you."] = "Uuuu, przez korek czuje jej won, swietnie Ci poszlo. Opowiem ci jak to bylo.\nBylam czeladnikiem u wielkiego alchemika, tego ktory pewnie jak juz wiesz wysadzil cala wyspe, ale nie ufaj tym co mowia ze byl szalony.\nTak naprawde konstruowal mechanizm, ktory zamknalby cala wyspe polem silowym i zmusilby rzadzacych do poddania sie. Chcial, aby wszyscy zyli w zgodzie.\nNiestety rzadzacy dowiedzieli sie dzieki szpiegom, i zmusili go do zmiany planow. Poczatkowo mialy to byc 2 male bomby, do stlumienia najsilniejszych dzielnic.\nAle to nie wystarczalo rzadzacym, i zapragneli wiekszej bomby, ktora w ostatecznosci zniszczyla cala wyspe. Teraz zostaly tam tylko ruiny, ale dalej wierze, ze kiedys odbudujemy Yalahar.\nDodatkowo u alchemika zajmowalam sie tworzeniem roznych wywarow na codzienne problemy, jakbys mial problem i potrzebowal jakiegos skutecznego srodka, to bede tu dla ciebie.",
	["Do you need a rat killer? We don't have any left. I will make you a special remedy, but you must bring me one ingredient: moldy cheese\nPerfectly lures rats, I will season it with a special substance that will make them all die in one night."] = "Potrzebujesz srodka na szczury? U nas nie ostal sie ani jeden. Przyrzadze ci specjalny srodek, ale musisz mi przyniesc jeden skladnik: splesnialy ser\nPerfekcyjnie zwabia szczury, zatruje go specjalna substancja przez co wszystkie padna w jedna noc.",
	["What a smell, perfect. In the meantime, I have prepared a decoction. Now we'll inject and it's ready.\nPut it somewhere in the cellar overnight, and in the morning you will see a graveyard."] = "Ale pachnie, idealny. W miedzy czasie przygotowalam wywar. Wstrzykniemy i gotowe.\nPostaw na noc gdzies w piwnicy, a rano ujrzysz cmentarzysko.",
	["Bring me some mouldy cheese."] = "Przynies mi splesnialy ser.",
	["I have already poisoned it for you."] = "Juz ci go zatrulam.",
	["I dont get it."] = "Nie wiem o czym mowisz.",
	["Hi |PLAYERNAME|. You can check my offer, say {trade} if you're down for garden work."] = "Witaj |PLAYERNAME|. Mozemy pohandlowac, jesli jestes zainteresowany florystyka.",
	["He is my brother, nothing more to it."] = "To moj brat, ale nie wiem jakie to ma znaczenie.",
	["Ask Woody about the wood supply."] = "O dostawe spytaj Rasiaka.",
	["Hello, Im Jack Sparrow - Caribbean King! Would you like to {sail} somewhere?"] = "Witaj, jestem Jack Sparrow - wladca Karaibow! Chcesz gdzies {plynac}?",
	["Hello. I can sail you to steppes, Bornholm and island inhabited by quaras. So where you'd like to {sail} to?"] = "Witaj. Wyplywam z polnocy Mirko. Moge zabrac cie na Stepy, Bornholm oraz podwodne tereny zamieszkane przez quary. To gdzie chcesz plynac?",
	["When i was still a kid, my father would tell me stories about {mythical} creatures inhabiting the {ocean}. The more stories i heard, the more i wanted to have some of this world in my {house}.\nI would really like to find a giant fish like in the stories. But im a simple man - adventures are not for me. Ehhh, i really wish i could face the legendary {Thul}, perhaps some day.."] = "W dziecinstwie ojciec opowiadal mi o {mitycznych} zwierzetach plywajacych w oceanie. Tyle sie tego nasluchalem, ze zapragnalem miec kawalek wielkiego swiata w swoim {domku}.\nNa przyklad zlowic ta wielka rybe z wlasnym zaglem na grzbiecie, ktory pomaga jej przemiezac ogrom oceanu.\nAle ja, prosty syn, nie moge ruszyc sie tak daleko. Ajjj, a chcialbym kiedys chociaz zmierzyc sie z tym legendarnym morskim stworem zwanym, {Thul}em!",
	["There is lot of creatures that came from the great unknown. My father friend, Christopher, talked about fish with human-like features or even whole bodies. {Quara}s inhabit the very deeps of the {ocean} near the island where he likes to party while his {red wife} is oblivious.\n Hehe, his ship is visibly damaged by sea serpents. This is his second ship already. {Santa Maria} Mark I was utterly demolished by a giant {Sea Serpent}\nUncle says, that is was Leviathan itself that made attempt on his life, but it was probably just the rum-incuced delirium. Haha, Leviathan, good one. When the end of times come, perhaps he will come."] = "Jest wiele roznych istot, ktore nie wiadomo skad sie wziely. Znajomy mojego ojca, Krzysiek, opowiadal o rybach ksztaltu ludzi. {Quary} zamieszkujace dno {ocean}u przy wyspie, na ktora ucieka przed swoja {czerwona zona} robic imprezki.\nHeh, jego statek ma wiele sladow uderzen przez morskie weze. To juz jego drugi statek. Pierwszy model, {Santa Maria}, zostal doszczednie zniszczony przez olbrzymiego {weza morskiego}.\nWujek twierdzi, ze sam {Leviathan} sie pofatygowal o jego zycie, ale pewnie znowu upil sie rumem. HAHA, Leviathan, dobre. Gdy bedzie koniec swiata to moze sie pojawi.",
	["Giant creatures that look similar to snakes. Their breath can put a sizeable fire away. Lot of wenches in our city love hearing stories about those. Perhaps if i could put my hands on a proof of their demise, i would get laid? Who knows.."] = "Ogromne snejki, ktore swoim oddechem potrafia zamrozic nie jeden pozar. W miescie jest wiele dziewek, ktore uwielbiaja historie o tych wezach. Moze gdybym kiedy zdobyl jakis dowod na zabicie paru, a potem zmyslilbym historie, to mialbym powodzenia u nich? Kto wie...",
	["The biggest one of them all serpents. If i could escape this life, i will face him."] = "Najwiekszy z {morskich wezy}. Gdybym mogl sie stad wyrwac i zmierzyc sie z sama smiercia oko w oko.",
	["Big family of sea creatures. I saw their sketches made by adventurers visiting city marketplace. I saw so many of them, i can now differentiate every {species}. Maybe not with closed eyes, but i roughly know this subject."] = "Wielka rodzina istot morskich. Wiele razy widzialem je na szkicach podroznikow na rynku w Mirko. Hah, tyle o nich slyszalem, ze moge rozroznic wszystkie {rodzaje}. Moze nie z zamknietymi oczami, ale jako tako.",
	["To my knowledge, there is five species. Quara Constrictor, Mantassin, Hydromancer, Pincher, Predator! Ha, i know them all."] = "No wiec jest 5 rodzajow. Quara Constrictor, Mantassin, Hydromancer, Pincher, Predator! Ha, wszystkie znam.",
	["Rumored to be the last one living of the lost underound city that was established ages ago. He is saving his energy, and only comes out when his {Quara} sons are failing. In that case, he comes out from his slumber, and shows no fear."] = "Podobno ostatni przetrwaly zalozyciel podwodnego miasta, ktore zaginelo przed wiekami. Oszczedzajac energie, chcac przedluzyc sobie zycie przed zblizajaca sie staroscia, pojawia sie dopiero gdy w bitwach {Quar} zginie za duzo jego synow. Budzi sie i pokazuje, ze nie straszne mu zadne wyzwanie.",
	["A puddle of water that someone sprinkled salt over."] = "Taka sobie kaluza, do ktorej ktos dosypal soli.",
	["The Water Buffalos love them."] = "Bawoly za nimi przepadaja.",
	["You sometimes find them inside a gooey mass."] = "Mozna je zdobyc wyciskajac gooey mass.",
	["Ask about {trade} if you want to see some. I also have special {mechanical} rod in my offer."] = "Zagadaj o {handel} jesli chcesz jakies zobaczyc. Mam w ofercie kozacka {mechaniczna} wedke.",
	["Really strong designed to swamp use. Its recommeded to use {larvaes} instead of worms. Be aware of {leeches}!"] = "Wytrzymalsza wedka, ktora mozna lowic w bagnach. Najlepiej uzywac {larw} zamiast robakow. Uwazaj na {pijawki}!",
	["Christopher had this very brilliant idea to capture a woman from the newly discovered island and make her his wife. The consequences of this mistake can be seen in his house till this day. At least he has his {marlin} still."] = "Krzysiek kiedys sobie ubzdural, ze z nowo odkrytej wyspy porwie kobiete. To jaki blad popelnil, moze podziwiac do dzisiaj u siebie w domu. Przynajmniej dalej ma swojego {marlina}.",
	["It was my uncle original ship. He used it since his very first adventure. I dont know how i would stand losing such a chunk of my life and its history. Perhaps he will tell you more about it, if you can serve him a full glass of acohol - when sober, hes not talkative."] = "Pierwszy statek mojego wujka. Uzywany do jego pierwszych przygod. Nie wiem co bym zrobil, gdybym to ja stracil kawalek takiej historii w swoim zyciu. Moze on bedzie chcial kiedys przy butelce opowiedziec ci co nieco. Ale uprzedzam, na trzezwo nie jest taki gadatliwy.",
	["I live just in next house."] = "No tutaj obok przeciez mieszkam.",
	-- shop npcs
	["Hello, |PLAYERNAME|. My offers are bows, crossbows and ammunition. If you'd like to see, ask me for a {trade}. I can also exchange your {soul orbs}."] = "Elko, |PLAYERNAME|. Sprzedaje kusze, luki, dzidy i amunicje, ktora skreca w lewa strone. Wymieniam {soul orb}! Zerknij.",
	["I can craft infernal bolts out of {soul orb} for you. I learned that from the Devil himself. Do you want to exchange all of your soul orbs?"] = "Moge wytworzyc diabelskie belty z {soul orb}. Nauki bralem u samego Diabla. Czy chcesz zamienic wszystkie kule duszy?",
	["You're welcome! Use them wisely."] = "Trzymaj! Uzywaj ich rozsadnie!",
	["I can see you don't have them! I can only craft infernal bolts from {soul orb}."] = "Przeciez widze, ze ich nie masz! Moge wytworzyc diabelskie belty tylko z {soul orb}.",
	["Please, don't bother me!"] = "Nie zawracaj mi glowy!",
	["You got your reward already, visit Fstab for a potion supply."] = "Juz dostales jedna nagrode, nie probuj cebulic. A po potiony do Fstaba.",
	["Trollsky sent you there? What you prefer to get, {bolts} or {arrows}?"] = "Trollsy cie przyslal? Co wolisz {belty} czy {strzaly}?",
	["Here are bolts for you. You should visit Fstab for a potion supply."] = "Oto twoje belty, zglos sie jescze do Fstaba po przydzial potionow.",
	["Here are arrows for you. You should visit Fstab for a potion supply."] = "Oto twoje strzaly, zglos sie jescze do Fstaba po przydzial potionow.",
	["Everything is in perfect order, only if you could check what is going on with this wood delivery.. I'm almost out of my stock, I don't want to disappoint my customers."] = "Wszystko w jak najlepszym porzadku, tylko jakbys mogl dowiedziec sie co z drewnem, bo mi sie zapasy koncza, a nie chce zawiesc klientow.",
	["What do you want? Better visit Commissioner Fisher first."] = "Czego ty ode mnie chcesz? Lepiej zamelduj sie u Komisarza Ryby..",
	["Hello, I buy various equipment like armors, weapons, and.. well ask about {trade} to see my whole offer."] = "Witam, skupuje wszelkiego rodzaju miecze, tarcze, zbroje i inne tego typu przedmioty. Wpisz {handel} aby zobaczyc moja oferte.",
	["Well I do need some help. Wood delivery from Knurow is already delayed for two days, and currently I can't check why.."] = "W zasadzie to tak, od jakis 2 dni spoznia sie dostawa drewna z Knurowa, niestety nie moge sie stad ruszyc aby to sprawdzic.",
	["Better visit Commissioner Fisher first."] = "Czego ty ode mnie chcesz? Lepiej zamelduj sie u Komisarza Ryby..",
	["Here is your axe. You should also visit Fstab, he should provide you some supplies."] = "Oto twoj topor, zglos sie tez do Fstaba po przydzial potionow.",
	["Here is your sword. You should also visit Fstab, he should provide you some supplies."] = "Oto twoj miecz, zglos sie tez do Fstaba po przydzial potionow.",
	["Here is your club. You should also visit Fstab, he should provide you some supplies."] = "Oto twoj obuch, zglos sie tez do Fstaba po przydzial potionow.",
	["Here is your spellbook. You should also visit Fstab, he should provide you some supplies."] = "Oto twoja ksiazka, zglos sie tez do Fstaba po przydzial potionow.",
	["Visit Filozofujaca Calka for this reward, and then meet Fstab. He should provide you some supplies."] = "Po ta nagrode zglos sie do Calki, oraz pozniej do Fstaba po przydzial potionow.",
	["You got your reward already."] = "Juz dostales jedna nagrode, nie probuj cebulic. A po potiony do Fstaba.",
	["Yeah! You deserve some reward for helping us. You can choose one from the following:"] = "Aaa, za pomoc w odzyskaniu drewna, oczywiscie. Mam pare rzeczy, powiedz tylko czego potrzebujesz, oto ich lista:",
	["{Axe}, {sword}, {club}, {spellbook}, {bolts} and {arrows}."] = "{Topor}, {miecz}, {obuch}, {ksiazka}, {belty} lub {strzaly}.",
	["Some time ago orcs stole my old red backpack. Maybe you have found it?"] = "Orki zawinely mi plecak, ale nie mam pojecia gdzie sie teraz podziewa. Byla na nim plakietka z moim imieniem, nie napotkales moze na niego?",
	["Thank you very much! This brings back good old memories! Here is reward for you!"] = "Ahh, mialem do niego wielki sentyment. Nalezy ci sie za to porzadna nagroda, prosze, to dla ciebie.",
	["Thats unfortunate."] = "No niestety..",
	["Well, the stone cromlech is on top of the mountain neat Mirko Town's north gate. The second cromlech is somewhere south of Knurow."] = "Spoko, kamienny krag jest na szczycie gory, w ktora wbija sie polnocna brama Mirko. Drugi krag znajduje sie na skalce w wiosce Misguided Thiefow na poludnie od Knurowa.",
	["WILDCARD_COST_QUESTION"] = function(context)
		local preyWildcardPrice = context.player:GetWildcardPrice()
		return T("Za wildcard zaplacic musisz :preyWildcardPrice: zlota. Dzieki niemu uzyskac mozesz korzystniejsze bonusy u wymodlonych kreatur. Ile wildcardow chcial bys zakupic?", { preyWildcardPrice = preyWildcardPrice })
	end,
	["WILDCARD_COUNT_CHOSEN"] = function(context)
		local preyWildcardPrice = context.player:GetWildcardPrice()
		local orderedWildcardsCount = context.npcHandler.topic[context.player:getId()] - 100
		local orderedCardsPrice = preyWildcardPrice * orderedWildcardsCount
		return T("Zdecydowales sie na :orderedWildcardsCount: wildcard. Kosztowac cie to bedzie :orderedCardsPrice: zlota. Jestes pewny zakupu?", {
			orderedWildcardsCount = orderedWildcardsCount,
			orderedCardsPrice = orderedCardsPrice,
		})
	end,
	["Hello |PLAYERNAME|. My offer mainly contains supplies for mages."] = "Witaj |PLAYERNAME|. Mozesz zaopatrzyc sie u mnie w przedmioty magiczne.",
	["Hello |PLAYERNAME|. My offer mainly contains supplies for mages. Im also selling {wildcard}, which will increase your prey powers!"] = "Witaj |PLAYERNAME|. Mozesz zaopatrzyc sie u mnie w przedmioty magiczne. Sprzedaje takze {wildcard}, pomagajacy w modlitwach!",
	["Hi, Im buying all kinds of creature products. Ask me for {trade} to browse through my offer."] = "Witaj. Skupuje szczatki potworow. Zapytaj mnie o {handel}, jesli jestes zainteresowany moja oferta.",
	["You need to tell me the number of wildcards you'd like to buy."] = "Podaj liczbe wildcardow ktore chcesz kupic.",
	["Here are your wildcards!"] = "Prosze, oto twoje wildcardy!",
	["Hello hello, |PLAYERNAME| I am Jurek and I sell some.. protection thing.. Ask about {trade} if you want to see!"] = "Siemano siemanko, |PLAYERNAME| ja jestem Jurek i sprzedaje zabezpieczenie przed zbyt ostrym imprezowaniem! Napisz {trade} to zobaczysz o co mi chodzi!",
	["Hello, hello! Hundred percent recommended seller here. Take a look at my offer, say {trade}."] = "Witam witam 100% pozytywnych transakcji, zapraszam do zakupow!",
	["Hello |PLAYERNAME|. As a jewellery store owner i can either craft some valuable gifts or buy your unwated ornaments. Just ask me for {trade}"] = "Jako wlasciciel sklepu z bizuteria moge sporzadzic ladne blyskotki albo kupic od ciebie bizuterie. ktorej juz nie potrzebujesz.",
	["Hello. My offer constists of tools that any cave explorer has to have to get around. Ask me for {trade} if you are interested."] = "Witam. W mojej ofercie znajdziesz narzedzia, bez ktorych zaden poszukiacz przygod nie powinien wychodzic z domu!",
	["Hello, |PLAYERNAME|. You want to buy parcel, letter, or make a bank transfer? Im here to help you."] = "Uszanowanie, |PLAYERNAME|. Roznosze listy i paczki. Jesli chcesz cos kupic, napisz {trade}.",
	["I am local postman, ask about {trade} if you want to buy some parcel or letter."] = "Zajmuje sie zarzadzaniem poczta w tym miescie. Byc moze chcesz wyslac list albo nadac paczke?",
	["Hello! You want to {trade}, or repair your worn {soft boots}? I can also exchange your {medicine pouch}."] = "Dzien dobry! Pohandlujemy, a moze naprawie Ci zuzyte {soft boots}? Potrzebuje takze {medicine pouch}, zglos sie jesli zdobedziesz jakies.",
	["Oh hello! Check out my new recipes, we can {trade} a little."] = "Czesc! Sprawdz moje nowe receptury i skladniki, wpisujac {trade}.",
	["I can exchange your life crystals for a life rings. Is that what youre interested in?"] = "Potrafie wytwarzac pierscienie z {life crystal}, nauczyla mnie tego mama. Czy chcesz, abym przetworzyl twoje krysztaly?",
	["Here you go."] = "Prosze bardzo.",
	["Im sorry, but you dont have such crystal. Only life crystal counts."] = "Sorry, ale nie masz tego krysztalu ze soba. Tylko {life crystal} nadaje sie do wytworzenia tego pierscienia.",
	["Would you like to exchange {worn soft boots}, or {charge} active ones? Cost of both services is 20k of gold."] = "Chcesz zamienic {worn soft boots}, czy {doladowac} jeszcze nie zuzyte? Koszt przywrocenia butow do stanu uzywalnosci to 20k.",
	["Here you are."] = "Prosze bardzo.",
	["What?! I wont do it for free."] = "Zglupiales? Za darmo ja nie pracuje!",
	["Here are your soft boots."] = "rosze bardzo, oto Twoje buty.",
	["I wont do it for free."] = "Za darmo ja nie pracuje!",
	["Sorry, but you dont have such item. I can only fix {soft boots}."] = "Wybacz, ale nie masz takich butow. Tylko {soft boots} moge naprawic.",
	["You have medicine pouch for me?"] = "Przyniosles dla mnie medicine pouch?",
	["I can give you {belongings of deceased} for your {medicine puch}. Come back if you get one."] = "Wzamian za medicine puch dam ci {belongings of deceased}. Wroc jesli je zdobedziesz.",
	["You dont have that."] = "Nie posiadasz wymaganych przedmiotow.",
	["Better visit Commissioner Fisher first, I cant trust you now."] = "Better visit Commissioner Fisher first, I cant trust you now.",
	["No need, but if you know some way to get rid of {rats} once and for all, tell me."] = "Nie potrzeba, ale jakbys znal jakis sposob na pozbycie sie raz na zawsze {szczurow} to sie do mnie zglos.",
	["I still have rats in the warehouse. I need some poison to get rid of them."] = "Ciagle w magazynie legna mi sie szczury. Potrzebuje jakiejs trutki aby sie ich pozbyc.",
	["Well, I'm waiting for this poison that will help me exterminate the rats."] = "No czekam na te trutke do wytepienia szczurow.",
	["Are you sure it will work? Thanks for your help. Keep this little gift from me. This {flask} was given te me by Fstab, but in fact i don't have any use for it."] = "Podobno przynosi szczescie, jesli zlapiesz do niej swietlika z magicznego drzewka.",
	["It's alright, I don't need any help."] = "Nie no wszystko w porzadeczku.",
	["Rats are gone, thanks again."] = "Szczury przepedzone, jeszcze raz dzieki.",
	["I heard that it brings you luck, if you catch one of fireflies from magical tree into that."] = "Podobno przynosi szczescie, jesli zlapiesz do niej swietlika z magicznego drzewka.",
	["Hello, I {trade} with fishing equipment, take a look at my offer if you want."] = "No witam, mam do zaoferowania {sprzet wedkarski} oraz skupuje ryby.",
	["I can exchange your red gems for a three rings of healing. Is that what youre interested in?"] = "Moge wymienic twoje czerwone krysztaly na trzy ring of healing, zgoda?",
	["Nothing there."] = "Nic tu nie ma.",
	["Hum Humm! Welcume {here} li'l Player."] = "Hum Humm! Witaj w moich {progach}, maly Graczu.",
	["I am {smith}."] = "Ja byc {kowal}.",
	["Working {steel} is my profession. Me too {melts} gold, {iron ore} and {soul orbs}."] = "Praca przy {stal} to moj fach. Ja tez {przetapiac} zloto, {iron ore} i {soul orb}y.",
	["Many kinds of. Some I {forge}. But not ancient steel."] = "Wiele rodzajow jest. Niektore ja {kuje}. Ale nie starozytna stal.",
	["Me can forge equipment back to steel. Like {Za'Ralator}, {Uth'Kean}, {Uth'Lokr}, {Uth'Prta}."] = "Ja moge kuc sprzet z powrotem w stal. Jak {Za'Ralator}, {Uth'Kean}, {Uth'Lokr}, {Uth'Prta}.",
	["Can melt gold ingot for lil' one. You want?"] = "Ja moge przetopic sztabke zlota dla malego. Chcesz?",
	["Very noble. Shiny. Me like. But breaks so fast. Me can make from shiny armour. Lil' one want to trade?"] = "Bardzo szlachetne. Blyszczace. Ja lubic. Ale psuje sie szybko. Ja moge zrobic ze swiecacej zbroi. Maly chce wymienic?",
	["Firy steel it is. Need green ones' breath to melt. Or red even better. Me can make from shield. Lil' one want to trade?"] = "Ognista stal to jest. Potrzeba oddechu zielonych, by stopic. Albo czerwonych, lepiej. Ja moge zrobic z tarczy. Maly chce wymienic?",
	["Good iron is. Me friends use it much for fight. Me can make from weapon. Lil' one want to trade?"] = "Dobre zelazo to jest. Moi przyjaciele duzo uzywac do walki. Ja moge zrobic z broni. Maly chce wymienic?",
	["Hellsteel is. Cursed and evil. Dangerous to work with. Me can make from evil helmet. Lil' one want to trade?"] = "Piekielna stal to jest. Przekleta i zla. Niebezpieczna do roboty. Ja moge zrobic ze zlego helmu. Maly chce wymienic?",
	["Uh. Me can make some nasty lil' bolt from soul orbs. Lil' one want to trade all?"] = "Uh. Ja moge zrobic wredne male belty z {soul orb}ow. Maly chce oddac wszystkie?",
	["Uh. Me can make some gear wheel from iron ores. Lil' one want to trade?"] = "Uh. Ja moge zrobic kolko zebate z {iron ore}. Maly chce wymienic?",
	["whoooosh There!"] = "Prosze bardzo",
	["There is no gold ingot with you."] = "Nie masz sztabki zlota.",
	["You dont have a crown armor!"] = "Ty nie masz koronnego pancerza!",
	["You dont have a devil helmet!"] = "Ty nie masz diabelskiego helmu!",
	["You dont have a giant sword!"] = "Ty nie masz wielkiego miecza!",
	["Lil' one does not have any iron ores."] = "Maly nie ma zadnych {iron ore}.",
	["You dont have soul orbs!"] = "Ty nie masz {soul orbs}!",
	["Cling clang!"] = "Brzdek brzdek!",
	["SERVER_RESTART_NOTIFY"] = function(context)
		return T("[SERWER] Restart za :formattedTime:", { formattedTime = context.formattedTime })
	end,
	["Say {trade} if you want to see my offer."] = "Powiedz {handel} jesli chcesz zobaczyc moja oferte.",
	["Hello |PLAYERNAME|. Its so hot today, youre probably really thirsty. You can buy chilled drinks there or eat some rice."] = "Witaj |PLAYERNAME|. Dzisiaj jest tak goraco, pewnie bardzo chce ci sie pic. Mozesz kupic schlodzone napoje tam albo zjesc troche ryzu.",
	["Ooga Booga, |PLAYERNAME|. I heard you looking for some loud. {Trade} if you need some, playa. If you good then bounce lil nigga, we be tryin' to hustle."] = "Ooga Booga, |PLAYERNAME|. Slyszalem, ze szukasz czegos glosnego, {handel} jesli potrzebujesz, ziomek. Jesli jestes spoko, to spadaj, mali czarni probujemy zarobic.",
	["Hello |PLAYERNAME|. As a jewellery store owner i can either craft some valuable gifts or buy your unwated ornaments. Just ask me for {trade}."] = "Witaj |PLAYERNAME|. Jako wlasciciel sklepu z bizuteria moge stworzyc cenne prezenty albo kupic twoje niechciane ozdoby. Po prostu zapytaj mnie o {handel}.",
	["Hello, im the conductor of this train. Do you need a {ride}?"] = "Witaj, jestem konduktorem tego pociagu. Potrzebujesz aby cie {podwiezc}?",
	["Here you are. There are your soft boots."] = "Prosze bardzo. Oto twoje miekkie buty.",
	["They call me reborn eater, because i have a mortar for reborns in my pants, if you know what i mean. Bring me a fresh Reborn boy, and i will let you go."] = "Nazywaja mnie pozeraczem rebornow, bo mam mozdzierz na reborny w spodniach, jesli wiesz, o co chodzi. Przynies mi swiezego chlopaka Reborna, a pozwole ci odejsc.",
	["As-salamu alaykum, |PLAYERNAME|. You want to buy parcel, letter, or make a bank transfer? Im here to help you."] = "As-salamu alaykum, |PLAYERNAME|. Chcesz kupic paczke, list, albo zrobic przelew bankowy? Jestem tu, by ci pomoc.",
	["You you like me to {sail} you anywhere?"] = "Chcesz gdzies {poplynac}?",
	["Hello. I can help you with acquiring {addons} for your outfits. Are you interested?"] = "Czesc. Moge ci pomoc z uszyciem {dodatkow} do twoich strojow. Jestes zainteresowany?",
	[YOU_NEED_TO_BRING_THE_FOLLOWING_ITEMS] = function(context)
		local requiredItems = context.requiredItems
		local str = "Najpierw przynies mi nastepujace przedmioty:\n" .. RequiredItemNamesCountToString(requiredItems)
		return str
	end,
	["Hello, are you interested in trading some gems? Or perhaps you want to help me with my {outfit} collection?"] = "Hej. Jestes zainteresowany moimi klejnotami? A moze przyszedles tu aby pomoc mi z z moimi nowymi {strojami}?",
	["Hello |PLAYERNAME|. You want {help} with some grinding?"] = "Witam |PLAYERNAME|. Moge ci {pomoc} z mieleniem kamieni?",
	["Y'Hua'Ri"] = "Y'Hua'Ri",
	["If you have some small enchanted sapphires, I can turn them into sapphire {dust} for you."] = "Jesli masz jakies male zaczarowane szafiry, to chetnie ci pomoge w starciu ich na {proch}.",
	["Yeah, yeah. Come back when you have it."] = "Ta jasne. Wroc jak bedziesz go miec.",
	["Yeah, maybe if you had some."] = "Gdybys tylko rzeczywiscie mial troche kamieni..",
	["You dont have a dragon shield!"] = "Nie posiadasz smoczej tarczy!",
	["Greetings, Player! It's good to see you {alive}."] = "Greetings, Player! It's good to see you {alive}.",
	["With the world in {peril}, everyone's life is at stake."] = "With the world in {peril}, everyone's life is at stake.",
	["The actions of Ferumbras and the sinister minions of the {thing} from beyond have shattered the world. The thing is worming its way into our reality and its workings will cause further {damage}."] = "The actions of Ferumbras and the sinister minions of the {thing} from beyond have shattered the world. The thing is worming its way into our reality and its workings will cause further {damage}.",
	["To name it is to give it power. Even to think about it gives it a hold. But it can't be helped and now that it is entering our world it doesn't worsen the matter significantly. ...\nYet, thinking about it might call for its attention and might give it a hold upon you. At least that was the case in the {past}."] = "To name it is to give it power. Even to think about it gives it a hold. But it can't be helped and now that it is entering our world it doesn't worsen the matter significantly. ...\nYet, thinking about it might call for its attention and might give it a hold upon you. At least that was the case in the {past}.",
	["Through history several of those who were too curious became aware of its existence - or better its lack. They were touched and tainted by the knowledge. ...\nIt is assumed that the ancient Yalahari were the first to really grasp at least part of the concept of what it is. This knowledge gave it a tremendous hold over the Yalahari's minds and it even gave it a {name}."] = "Through history several of those who were too curious became aware of its existence - or better its lack. They were touched and tainted by the knowledge. ...\nIt is assumed that the ancient Yalahari were the first to really grasp at least part of the concept of what it is. This knowledge gave it a tremendous hold over the Yalahari's minds and it even gave it a {name}.",
	["Names hold power. The gods called things into existence by naming them. By giving something a name, it becomes more real. Ideas become concepts, feelings become expressible and so on. ...\nIn the case of the thing that wasn't, the name gave it a hold on reality, gave it a glimpse at our world. By naming it, the Yalahari began to understand it, in a twisted way at least. ...\nA knowledge that was twisted in itself and twisted the minds of those who knew. At last, the Yalahari vanished from the world and even the gods don't know their fate for sure. ...\nNow that this thing - which was not meant to be - entered our world, its name might be old news, so to say. However, it's still dangerous and malignant, nothing to be spoken or thought of lightly, especially not by you mortals."] = "Names hold power. The gods called things into existence by naming them. By giving something a name, it becomes more real. Ideas become concepts, feelings become expressible and so on. ...\nIn the case of the thing that wasn't, the name gave it a hold on reality, gave it a glimpse at our world. By naming it, the Yalahari began to understand it, in a twisted way at least. ...\nA knowledge that was twisted in itself and twisted the minds of those who knew. At last, the Yalahari vanished from the world and even the gods don't know their fate for sure. ...\nNow that this thing - which was not meant to be - entered our world, its name might be old news, so to say. However, it's still dangerous and malignant, nothing to be spoken or thought of lightly, especially not by you mortals.",
	["Probably his vain plea for ascension has brought upon him a fate worse than hell."] = "Probably his vain plea for ascension has brought upon him a fate worse than hell.",
	["While the thing becomes more real, it sheds layers of destruction and negligence of reality. Those layers are becoming threats on their own. ...\nThey eat away matter as well as laws of nature. They are threatening the creation as a whole. Even without doing anything more than becoming more and more real, the thing might win by simply undoing creation. This has to be stopped!"] = "While the thing becomes more real, it sheds layers of destruction and negligence of reality. Those layers are becoming threats on their own. ...\nThey eat away matter as well as laws of nature. They are threatening the creation as a whole. Even without doing anything more than becoming more and more real, the thing might win by simply undoing creation. This has to be stopped!",
	["The destruction that comes with that thing shares the intention of its progenitor to become more real. Therefore, the destruction has gathered into something that - under other circumstances - would be called avatars. ...\nSome destructive and unnatural forces have condensed themselves to highly dangerous constructs that are gnawing at existence itself. Even now their workings can be felt. ...\nAll over the world incursions like this one here can be encountered. They eat away matter, sanity and order - sucking them into nothingness. Behind these incursions, on the brink to nothingness and annihilation, the non-avatars are lurking. ...\nTheir most potent incarnation has been named Heart of Destruction. But there are others - less potent but disruptive on their own. The heart gives those mindless forces unity and purpose. ...\nIt unites them to the threat that they are. Every incursion itself it only restricted to time and space. Reality will eventually heal and recover, although not for an unlimited amount of time. ...\nIt is the heart what makes them so dangerous and gives them drive. Under the hunger and anger of the Heart of Destruction, the incursions are more potent and reality is breaking. ...\nTo stop them from devouring reality, the destruction has to be stopped by {destroying} its heart."] = "The destruction that comes with that thing shares the intention of its progenitor to become more real. Therefore, the destruction has gathered into something that - under other circumstances - would be called avatars. ...\nSome destructive and unnatural forces have condensed themselves to highly dangerous constructs that are gnawing at existence itself. Even now their workings can be felt. ...\nAll over the world incursions like this one here can be encountered. They eat away matter, sanity and order - sucking them into nothingness. Behind these incursions, on the brink to nothingness and annihilation, the non-avatars are lurking. ...\nTheir most potent incarnation has been named Heart of Destruction. But there are others - less potent but disruptive on their own. The heart gives those mindless forces unity and purpose. ...\nIt unites them to the threat that they are. Every incursion itself it only restricted to time and space. Reality will eventually heal and recover, although not for an unlimited amount of time. ...\nIt is the heart what makes them so dangerous and gives them drive. Under the hunger and anger of the Heart of Destruction, the incursions are more potent and reality is breaking. ...\nTo stop them from devouring reality, the destruction has to be stopped by {destroying} its heart.",
	["You will notice many incursions throughout the world. They are accompanied by waves of uncreated beings. By killing them, you weaken the incursion which they are part of. Yet, you will get tainted with their disruptive nature. ...\nA person of strong will might resist the taint and even use it to enter the incursions. Beyond them awaits only a thin layer of ... let's call it yet undigested reality in which the non-avatars nest. ...\nEach incursion, aside from similarities, hosts another of those things. All of them are kin to their source, the {Heart of Destruction}. ...\nIf you manage to destroy one of them, a part of its ungodly charge will be passed upon you. Again you might be able to use that to your advantage, though. ...\nIf you manage to slay the different masters of the greater incursions, you'll eventually blend in with their disruptive nature and might venture further into the incursions and challenge the heart itself. ...\nBut even getting to the masters of the incursions will not be an easy task. Each of them will be guarded by some kind of instinctive reaction that will have to be dealt with before you might advance to the incursion's master."] = "You will notice many incursions throughout the world. They are accompanied by waves of uncreated beings. By killing them, you weaken the incursion which they are part of. Yet, you will get tainted with their disruptive nature. ...\nA person of strong will might resist the taint and even use it to enter the incursions. Beyond them awaits only a thin layer of ... let's call it yet undigested reality in which the non-avatars nest. ...\nEach incursion, aside from similarities, hosts another of those things. All of them are kin to their source, the {Heart of Destruction}. ...\nIf you manage to destroy one of them, a part of its ungodly charge will be passed upon you. Again you might be able to use that to your advantage, though. ...\nIf you manage to slay the different masters of the greater incursions, you'll eventually blend in with their disruptive nature and might venture further into the incursions and challenge the heart itself. ...\nBut even getting to the masters of the incursions will not be an easy task. Each of them will be guarded by some kind of instinctive reaction that will have to be dealt with before you might advance to the incursion's master.",
	["One can only call this thing the world devourer. It eats away reality and feeds on the world itself. ...\nThe thing is as unfathomable as the thing that spawned it. It is doubtful that its creation was an act of will. Regardless it is the utmost threat that we face right now. ...\nAs long as the world devourer exists, the healing powers of reality will not suffice to contain the damage caused by the incursions. Likely sooner than later reality and its laws will begin to break. ...\nThe thing itself is nothing anyone has ever encountered yet. Its existence alone is an anathema to creation and is hurting the world. ...\nIt's something between existence and destruction, between force and creature. Its whole existence is a paradox itself and harmful to the world. We have no idea how it works or what are its weaknesses. ...\nIt will take a keen mind to figure this out and a {strong} heart and soul to endure the perils on the way."] = "One can only call this thing the world devourer. It eats away reality and feeds on the world itself. ...\nThe thing is as unfathomable as the thing that spawned it. It is doubtful that its creation was an act of will. Regardless it is the utmost threat that we face right now. ...\nAs long as the world devourer exists, the healing powers of reality will not suffice to contain the damage caused by the incursions. Likely sooner than later reality and its laws will begin to break. ...\nThe thing itself is nothing anyone has ever encountered yet. Its existence alone is an anathema to creation and is hurting the world. ...\nIt's something between existence and destruction, between force and creature. Its whole existence is a paradox itself and harmful to the world. We have no idea how it works or what are its weaknesses. ...\nIt will take a keen mind to figure this out and a {strong} heart and soul to endure the perils on the way.",
	["Your future is still not written because the forces of uncreation are still tearing on reality. For the sake of your world, please hurry! \n"] = "Your future is still not written because the forces of uncreation are still tearing on reality. For the sake of your world, please hurry! \n",
}
