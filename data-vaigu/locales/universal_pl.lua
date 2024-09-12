return {
	["Starter weapons"] = "Bron startowa",
	["Choose your starter weapon:"] = "Wybierz swoja bron startowa:",
	["Fine, i will choose your starter weapon then..."] = "Skoro nie chcesz broni, sam wybiore...",
	["WELCOME_TO_SERVER"] = function()
		return T("Witaj to :serverName:!", { serverName = configManager.getString(configKeys.SERVER_NAME) })
	end,
	["YOUR_LAST_VISIT"] = function(context)
		return T("Twoja ostatnia wizyta byla :lastLogin:.", { lastLogin = os.date("%d-%m-%Y %X", context.player:getLastLoginSaved()) })
	end,
	["Please choose your outfit."] = "Ubierz sie jak Ci sie podoba.",
	["Premade action bars for every vocation are available in options."] = "Domyslne paski ze skillami dla kazdej profesji znajdziesz w opcjach.",
	["LIST_AVAILABLE_COMMANDS"] = "Lista dostepnych komend: !serverinfo - !language - !faq. Reszte znajdziesz pod !commands",
	["You can report ingame bugs using ctrl+z."] = "Bledy w grze zglaszac mozesz poprzez ctrl+z.",
	[ENCOUNTER_ERROR_CODES.SOMEONE_HAS_LOCKOUT] = function(context)
		return T("Ty albo czlonek twojego zespolu nie moze jeszcze wejsc na :encounterName:.", { encounterName = context.encounterName })
	end,
	[ENCOUNTER_ERROR_CODES.YOU_HAVE_LOCKOUT] = function(context)
		return T("Musisz jeszcze odczekac :timeLeftString: aby wejsc na :encounterName:.", { encounterName = context.encounterName, timeLeftString = context.timeLeftString })
	end,
	[ENCOUNTER_ERROR_CODES.SOMEONE_HAS_NO_ACCESS] = function(context)
		return T("Ty albo czlonek twojego zespolu nie ma dostepu na :encounterName:.", { encounterName = context.encounterName })
	end,
	[ENCOUNTER_ERROR_CODES.YOU_HAVE_NO_ACCESS] = function()
		return T("Nie masz dostepu do :encounterName:")
	end,
	[ENCOUNTER_ERROR_CODES.ONLY_PLAYERS] = function()
		return "W tej walce brac moga udzial tylko gracze!"
	end,
	[ENCOUNTER_ERROR_CODES.SOMEONE_INSIDE_ALREADY] = function(context)
		return T("Ktos juz bierze udzial w :encounterName:.", { encounterName = context.encounterName })
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
	["Select"] = "Wybierz",
	["Wyjdz"] = "Wyjdz",
	["Help"] = "Pomoc",
	[GREET] = "Czesc.",
	[WALKAWAY] = "Bywaj.",
	["SoldierWalkaway"] = "Odmeldowuje sie.",
	["Bye..."] = "Pa...",
	[FAREWELL] = "Zegnaj.",
	["Thanks."] = "Dzieki.",
	["INCOMPREHENSIBLE"] = function(context)
		local stringPool = {
			"Musisz mowic wyrazniej.",
			"Nic z tego nie rozumiem.",
			"Mozesz powtorzyc?",
			"Nie wiem co masz na mysli.",
			"Nie wiem o czym mowisz.",
			"Ze co?",
		}
		local finalString = stringPool[math.random(1, #stringPool)]
		return finalString
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
	["Goldblum is a very cunning one. He likes to play the riddles game. If he asks you about the valuation of structured bonds, say exactly these words: {It depends on the current level of the stock market index, stock price, commodity price, currency exchange rate, or other market indicator that serves as their underlying instrument}"] = "Goldblum to bardzo szczwany lis. Jezeli zapyta cie o wycene obliacji strukturyzowanych, powiedz dokladnie te slowa: {Od aktualnego poziomu indeksu gieldowego, kursu akcji, ceny surowca, kursu waluty lub innego wskaznika rynkowego, ktory stanowi ich instrument bazowy}",
	["MinimumLevelToTravel"] = function(context)
		return T("Potrzebujesz co najmniej :minLevel: poziom, abym cie tam wyslal.", { minLevel = context.minLevel })
	end,
	["TravelHelpDialog"] = function(context)
		return T("Mozesz podrozowac miedzy miastami, jesli masz wystarczjaca ilosc pieniedzy. Aktualnie usluga transportu kosztuje :transportCost:. Aktualnie posiadasz :money:.", {
			transportCost = TRANSPORT_COST,
			money = context.player:getMoney(),
		})
	end,
	["ShipWindowTitle"] = "Statek",
	["ShipWindowMessage"] = function(context)
		local finalString = ""
		local freeTravels = context.player:getStorageValue(Storage.FreeTravels)
		if freeTravels > 0 then
			finalString = finalString .. T("Jako nowicjusz masz :freeTravels: darmowe zeglugi.\n", { freeTravels = freeTravels })
		end
		finalString = finalString .. "Gdzie chcialbys poplynac??"
		return finalString
	end,
	["CarpetWindowTitle"] = "Carpet",
	["CarpetWindowMessage"] = function(context)
		local finalString = ""
		local freeTravels = context.player:getStorageValue(Storage.FreeTravels)
		if freeTravels > 0 then
			finalString = finalString .. T("Jako nowicjusz masz :freeTravels: darmowe loty.\n", { freeTravels = freeTravels })
		end
		finalString = finalString .. "Gdzie chcialbys poplynac??"
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
	["West of my hut, the lizards have a field of a strange plant. I don't know exactly what it is, but I know they make a potent vodka out of it\nOnce one of them blew a bottle, I drank 2 sips and slept for the next 2 days... I'm getting ready to go to my friend Konmuld, and if he doesn't drink, he's not very talkative.\nPlease steal from them some of this liquor. Hold this bottle, you can fill it."] = "Na zachod od mojej chaty jaszczury maja pole dziwnej rosliny. Nie wiem do konca co to jest, ale wiem ze robia z tego potezna wodke.\nRaz jednemu wylecial buklak, wypilam 2 lyki i spalam nastepne 2 dni.. Szykuje sie na podroz do mojego przyjaciela {Konmulda}, a on jak sie nie napije, to nie jest zbyt rozmowny.\nWykradnij im prosze troche tego trunku. Trzymaj ta butelke, mozesz do niej napelnic.",
	["I will tell you everything I remember, but I need some help, are you up for it?"] = "Opowiem ci wszystko co pamietam, jednak potrzebuje pewnej pomocy, piszesz sie na to?",
	["Uuuu, I can smell it through the cork, you did great. I'll tell you how it went.\nI was an apprentice to the great alchemist, the one who, as you probably know, blew up the whole island, but do not trust those who say that he was mad.\nIn fact, he was constructing a mechanism that would enclose the whole island in a force field and force the rulers to surrender. He wanted everyone to live in harmony.\nUnfortunately, the government found out thanks to spies, and forced him to change his plans. Initially it was supposed to be 2 small bombs, to destroy the strongest districts.\nBut it was not enough for the rulers, and they wanted a bigger bomb, which finally destroyed the whole island. Now there are only ruins left, but I still believe that one day we will rebuild Yalahar.\nIn addition, at the alchemist I dealt with the creation of various decoctions for everyday problems, if you have a problem and need any effective remedy, I will be here for you."] = "Uuuu, przez korek czuje jej won, swietnie Ci poszlo. Opowiem ci jak to bylo.\nBylam czeladnikiem u wielkiego alchemika, tego ktory pewnie jak juz wiesz wysadzil cala wyspe, ale nie ufaj tym co mowia ze byl szalony.\nTak naprawde konstruowal mechanizm, ktory zamknalby cala wyspe polem silowym i zmusilby rzadzacych do poddania sie. Chcial, aby wszyscy zyli w zgodzie.\nNiestety rzadzacy dowiedzieli sie dzieki szpiegom, i zmusili go do zmiany planow. Poczatkowo mialy to byc 2 male bomby, do stlumienia najsilniejszych dzielnic.\nAle to nie wystarczalo rzadzacym, i zapragneli wiekszej bomby, ktora w ostatecznosci zniszczyla cala wyspe. Teraz zostaly tam tylko ruiny, ale dalej wierze, ze kiedys odbudujemy Yalahar.\nDodatkowo u alchemika zajmowalam sie tworzeniem roznych wywarow na codzienne problemy, jakbys mial problem i potrzebowal jakiegos skutecznego srodka, to bede tu dla ciebie.",
	["Do you need a rat killer? We don't have any left. I will make you a special remedy, but you must bring me one ingredient: moldy cheese\nPerfectly lures rats, I will season it with a special substance that will make them all die in one night."] = "Potrzebujesz srodka na szczury? U nas nie ostal sie ani jeden. Przyrzadze ci specjalny srodek, ale musisz mi przyniesc jeden skladnik: splesnialy ser\nPerfekcyjnie zwabia szczury, zatruje go specjalna substancja przez co wszystkie padna w jedna noc.",
	["What a smell, perfect. In the meantime, I have prepared a decoction. Now we'll inject and it's ready.\nPut it somewhere in the cellar overnight, and in the morning you will see a graveyard."] = "Ale pachnie, idealny. W miedzy czasie przygotowalam wywar. Wstrzykniemy i gotowe.\nPostaw na noc gdzies w piwnicy, a rano ujrzysz cmentarzysko.",
	["Bring me some mouldy cheese."] = "Przynies mi splesnialy ser.",
	["I have already poisoned it for you."] = "Juz ci go zatrulam.",
	["I dont get it."] = "Nie wiem o czym mowisz.",
	["Hi |PLAYERNAME|. You can check my offer, say {trade} if you're down for garden work."] = "Witaj |PLAYERNAME|. Mozemy pohandlowac, jesli jestes zainteresowany florystyka.",
	["He is my brother, nothing more to it."] = "To moj brat, ale nie wiem jakie to ma znaczenie.",
	["Ask Woody about the wood supply."] = "O dostawe spytaj Rasiaka.",
	["Hello, Im Jack Sparrow - Caribbean King! Would you like to {sail} somewhere?"] = "Witaj, jestem Jack Sparrow - wladca Karaibow! Chcesz gdzies {plynac}?",
	["Hello. I can sail you to steppes, Bornholm and island inhabited by quaras. So where you'd like to {sail} to?"] = "",
	["My father is a fishing fanatic. Half of our home filled with fishing rods. Recently he let me use his boat, I can {sail} you to The Mirko City or sell some of those {rods}.. If you are interested in some {stories}, ask me for one."] = "",
	["My father is a fishing fanatic. Half of our home filled with fishing rods. Recently he let me use his boat, I can {sail} you to elf court or sell some of those {rods}.. If you are interested in some {stories}, ask me for one."] = "",
	["When i was still a kid, my father would tell me stories about {mythical} creatures inhabiting the {ocean}. The more stories i heard, the more i wanted to have some of this world in my {house}.\nI would really like to find a giant fish like in the stories. But im a simple man - adventures are not for me. Ehhh, i really wish i could face the legendary {Thul}, perhaps some day.."] = "W dziecinstwie ojciec opowiadal mi o {mitycznych} zwierzetach plywajacych w {Ocean}ie. Tyle sie tego nasluchalem, ze zapragnalem miec kawalek wielkiego swiata w swoim {domku}.\nNa przyklad zlowic ta wielka rybe z wlasnym zaglem na grzbiecie, ktory pomaga jej przemiezac ogrom oceanu.\nAle ja, prosty syn, nie moge ruszyc sie tak daleko. Ajjj, a chcialbym kiedys chociaz zmierzyc sie z tym legendarnym morskim stworem zwanym, {Thul}em!",
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
	["Christopher had this very brilliant idea to capture a woman from the newly discovered island and make her his wife. The consequences of this mistake can be seen in his house till this day."] = "Krzysiek kiedys sobie ubzdural, ze z nowo odkrytej wyspy porwie kobiete. To jaki blad popelnil, moze podziwiac do dzisiaj u siebie w domu.",
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
	["Well, the stone cromlech is on top of the mountain neat Mirko Town's north gate. The second cromlech is in the Misguided Thief village south of Knurow."] = "Spoko, kamienny krag jest na szczycie gory, w ktora wbija sie polnocna brama Mirko. Drugi krag znajduje sie na skalce w wiosce Misguided Thiefow na poludnie od Knurowa.",
	["WILDCARD_COST_QUESTION"] = function(context)
		local preyWildcardPrice = context.player:GetWildcardPrice()
		return T("Za wildcard zaplacic musisz :preyWildcardPrice: zlota. Dzieki niemu uzyskac mozesz korzystniejsze bonusy u wymodlonych kreatur. Ile wildcardow chcial bys zakupic?", { preyWildcardPrice = preyWildcardPrice })
	end,
	["WILDCARD_CHOSEN_COUNT"] = function(context)
		local preyWildcardPrice = context.player:GetWildcardPrice()
		local orderedWildcardsCount = context.npcHandler.topic[context.player:getId()] - 100
		local orderedCardsPrice = preyWildcardPrice * orderedWildcardsCount
		return T("Zdecydowales sie na :orderedWildcardsCount: wildcard. Kosztowac cie to bedzie :orderedCardsPrice: zlota. Jestes pewny zakupu?", {
			orderedWildcardsCount = orderedWildcardsCount,
			orderedCardsPrice = orderedCardsPrice,
		})
	end,
	["Hello |PLAYERNAME|. My offer mainly contains supplies for mages. Im also selling {wildcard}, which will increase your prey powers!"] = "Witaj |PLAYERNAME|. Mozesz zaopatrzyc sie u mnie w przedmioty magiczne. Sprzedaje takze {wildcard}, pomagajacy w modlitwach!",
	["Hi, Im buying all kinds of creature products. Ask me for {trade} to browse through my offer."] = "Witaj. Skupuje szczatki potworow. Zapytaj mnie o {handel}, jesli jestes zainteresowany moja oferta.",
	["You need to tell me the number of wildcards you'd like to buy."] = "Podaj liczbe wildcardow ktore chcesz kupic.",
	["Here are your wildcards!"] = "Prosze, oto twoje wildcardy!",
	["Hello, hello! Hundred percent recommended seller here. Take a look at my offer, say {trade}."] = "Witam witam 100% pozytywnych transakcji, zapraszam do zakupow!",
	["Wood, wood delivery. It was supposed to arrive two days ago. Probably another riots in Knurow that blocked the road."] = "Drewno, drewno, mialo byc juz 2 dni temu, znowu pewnie jakas afera w Knurowie ze nie da sie przejechac.",
	["There is one problem with which you could help me. Some furnitures started to disappear from my storages.\nI know for sure that it wasnt Narro's mafia, because they are using wood for different purposes, they are not interested in my furnitures.\nDo you want to find for me who is responsible for stealing my furnitures?"] = "Jest problem, z ktorym moglbys mi pomoc. Z moich magazynow zaczely znikac gotowe meble.\nWiem, ze to nie sprawka mafii Waskiego, bo oni drewno wykorzystuja do innych celow, i nie interesuja ich moje meble.\nCzy podejmiesz sie odnalezienia delikwenta, ktory kradnie moje meble?",
	["Thanks that you agreed to {help}. I hope that its not another mafia."] = "Dziekuje, ze zgodziles sie mi {pomoc}. Mam nadzieje, ze to nie sprawka kolejnej mafii.",
	["Maybe Gypsy knows something about furnitures thief, people like him sticks together..."] = "Moze Cygan cos wie o zlodzieju mebli, tacy jak on trzymaja sie razem...",
	["Thank you for finding perpetrator. Your reward is upstairs, here is the key to the door.\nMeanwhile I will call to two almighty Mirks, so they will bring my stolen stuff from those undergrounds"] = "Dziekuje za wykrycie sprawcy. Twoja nagroda jest na pietrze, a oto klucz do drzwi na gorze.\nJa tymczasem zadzwonie do dwoch poteznych Mirkow, zeby wyniesli moje skradzione rzeczy z tych podziemi.",
	["I checked the list of stolen items, I saw that he had a ball that Gypsy was looking for. Wait, its not {all}."] = "Przejrzalem liste skradzionych rzeczy, i widze, ze gdzies trzymal kule, ktorej szuka cygan. Czekaj, to nie {wszystko}.",
	["Recent entries on the list suggest that our thief was stealing food and supplies from the orcs of the south.\nGo to Commissioner Fisher please and tell him about it. Also ask him if he knows something about that thief."] = "Ostatnie wpisy na liscie sugeruja, ze nasz zlodziej wykradal wikt i oporzadzenie orkom z poludnia.\nProsze, idz do komisarza Ryby, i opowiedz mu o tym. Spytaj go tez, czy wie cos o tym zlodzieju.",
	["Hello |PLAYERNAME|. As a jewellery store owner i can either craft some valuable gifts or buy your unwated ornaments. Just ask me for {trade}"] = "Jako wlasciciel sklepu z bizuteria moge sporzadzic ladne blyskotki albo kupic od ciebie bizuterie. ktorej juz nie potrzebujesz.",
	["Hello. My offer constists of tools that any cave explorer has to have to get around. Ask me for {trade} if you are interested."] = "Witam. W mojej ofercie znajdziesz narzedzia, bez ktorych zaden poszukiacz przygod nie powinien wychodzic z domu!",
	["I am local postman, ask about {trade} if you want to buy some parcel or letter."] = "Zajmuje sie zarzadzaniem poczta w tym miescie. Byc moze chcesz wyslac list albo nadac paczke?",
	["Hello! You want to {trade}, or repair your worn {soft boots}? I can also exchange your {medicine pouch}."] = "Dzien dobry! Pohandlujemy, a moze naprawie Ci zuzyte {soft boots}? Przebuje takze {medicine pouch}, zglos sie jesli zdobedziesz jakies.",
	["Oh hello! Check out my new recipes, we can {trade} a little."] = "Czesc! Sprawdz moje nowe receptury i skladniki, wpisujac {trade}.",
	["I can exchange your life crystals for a life rings. Is that what youre interested in?"] = "Potrafie wytwarzac pierscienie z {life crystal}, nauczyla mnie tego mama. Czy chcesz, abym przetworzyl twoje krysztaly?",
	["Here you go."] = "Prosze bardzo, oto Twoje buty.",
	["Im sorry, but you dont have such crystal. Only life crystal counts."] = "Sorry, ale nie masz tego krysztalu ze soba. Tylko {life crystal} nadaje sie do wytworzenia tego pierscienia.",
	["Would you like to exchange {worn soft boots}, or {charge} active ones? Cost of both services is 20k of gold."] = "Chcesz zamienic {worn soft boots}, czy {doladowac} jeszcze nie zuzyte? Koszt przywrocenia butow do stanu uzywalnosci to 20k.",
	["Here you are."] = "Prosze bardzo, oto Twoje buty.",
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
	["Are you sure if it works? Thanks for the memory, though. Keep this little gift from me. This {flask} was given te me by Fstab, but in fact i don't have any use for it."] = "Podobno przynosi szczescie, jesli zlapiesz do niej swietlika z magicznego drzewka.",
	["It's alright, I don't need any help."] = "Nie no wszystko w porzadeczku.",
	["Rats are gone, thanks again."] = "Szczury przepedzone, jeszcze raz dzieki.",
	["I heard that it brings you luck, if you catch one of fireflies from magical tree into that."] = "Podobno przynosi szczescie, jesli zlapiesz do niej swietlika z magicznego drzewka.",
	["Hello, I {trade} with fishing equipment, take a look at my offer if you want."] = "No witam, mam do zaoferowania {sprzet wedkarski} oraz skupuje ryby.",
	["Hello hello, |PLAYERNAME| I am Owsiak and I sell some.. protection thing.. Ask about {trade} if you want to see!"] = "Siemano siemanko, |PLAYERNAME| ja jestem Jurek i sprzedaje zabezpieczenie przed zbyt ostrym imprezowaniem! Napisz {trade} to zobaczysz o co mi chodzi!",
}
