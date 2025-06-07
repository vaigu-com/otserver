local name = "GM Romek"
local outfit = {
	lookType = 144,
	lookHead = 59,
	lookBody = 115,
	lookLegs = 58,
	lookFeet = 97,
	lookAddons = 0,
}
--[[
local unusedDialogs = {
	[Storage.BigKlamoty.Localizer] = {
		[Storage.BigKlamoty.Mission01] = {
			[1] = { [{ "mission" }] = { text = "To be continued..." } },
		},
	},
	[Storage.SpojrzenieTysiacaYtongow.Mission01] = {
		[1] = {
			[{ "mission" }] = {
				text = "Pozwol ze przedstawie Ci pewna opowiesc. O tym nie bylo na historii w podstawowce ani w gimbazie. Kondominium rosyjsko-niemieckie pod zydowsko-amerykanskim zarzadem powierniczym. Wigilia, rok 1980 - po obiedzie. Mlody Marceliusz czekal, az mikolaj przybedzie z prezentami. Wlasciwie to Marceliusz mial juz wtedy 14 lat, wiec wiedzial, ze mikolaj nie {istnieje}.",
			},
			[{ "real", "istnieje" }] = {
				text = "Jednak to nie przeszkadzalo mu w kultywowaniu tradycji. Mijaly kwadranse, a pozniej godziny. Niestesty zaden mikolaj, ani rodzice, ani nawet dziadkowie nie polozyli prezentenow pod choinka - nie spielnialy sie jego oczekiwania. W koncu Marceliusz zapytal mame: \"Nadszedl czas odplaty stara poczwaro, gdzie moje prezenty?\". Jego matka (kobieta w pelni wladz umyslowych) {odpowiedziala} mu: \"Marceliusz ciemiezco! czemu Ty nas tak dreczysz? Czego Ty od nas chcesz?\".",
			},
			[{ "told", "odpowiedziala" }] = {
				text = "Tak jest, Marceliusz zyl w komunistycznej Polsce. Tego dnia poprzysiagl sobie co nastepuje: \"Trzy razy ponownie rozpierdole caly komunizm zanim kogut zapieje\". Pomyslal, ze powinien dokonac w zyciu czegos waznego - zajmie sie wsparciem interpunkcyjnym Polski. Tak jest, to on usunal sierp i kowaldo, i w zamian postawil los Polski pod znakiem {zapytania}.",
			},
			[{ "question", "zapytania" }] = {
				text = "Z biegiem czasu Marceliusz stawal sie coraz bardziej prominentym obywatelem, a jego imie wciaz ulegalo skroceniu (wzgledy optymalizacyjne).",
			},
			[{ "optimization", "optymalizacyjne" }] = {
				text = "Najpierw bylo Marceus, potem Marcel... W ktoryms momencie osiagnal poziom sprawiedliwosci pozwalajacy mu na zrzucenie ludzkiej powloki... Wtedy tez najprawdopodobniej zle moce wystapily z cienia, i pod ich wplywem zmienil sie w Krola Jaszczurow. Od tamtego czasu jego imie uleglo maksymalnemu skroceniu... domylasz sie pewnie jak sie teraz nazywa.",
			},
			[{ "mark", "zuckerberg", "mark zuckerberg" }] = {
				text = "Aktualnie Mark Zuckerberg przebywa na swoim statku-gwiezdzie i proboje zawladnac umyslami ludzi poprzez Janusz-Verse TM, teraz z googlami VR Pro Max + za jedyne 79.99 USD!",
			},
			[{ "just", "jedyne" }] = {
				text = "Cholera, dlaczego powiedzialem to ostatnie... Smrod jego kontrolujacej mozgi prezencji rozsiewa sie az tutaj. Dodatkowo, jego siedziby broni cala flota kosmicznych statkow, wiec zeby go pokonac bedziesz potrzebowac co najmniej legionu zgranych mysliwcow.",
				nextState = {
					[Storage.SpojrzenieTysiacaYtongow.Mission01] = 2,
					[Storage.SpojrzenieTysiacaYtongow.Mission01] = 2,
				},
			},
		},
		[2] = { [{ "mission" }] = {} },
	},
	[Storage.SprawiedliwyWobecNarodow.Mission01] = {
		[1] = {
			[{ "mission" }] = {
				text = 'Od niedawna jedna rzecz nie daje mi spokoju. Gdy szczur Krolow przeobrazil sie w Janusza Gwiezdnego, to zaczal od slow "Halo, Pjoter, slychac mnie?". Czy pomylilo mu sie cos i myslal, ze rozmawia z Petrusem Gnebicielem? Ta sprawa bardzo mnie dziwi. Udaj sie do wiezy petrusa gnebiciela i sproboj znalezc cos wiecej na ten temat.',
				nextState = {
					[Storage.SprawiedliwyWobecNarodow.Mission01] = 2,
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
				text = 'Dlaczego to sa zawsze ci czerwoni.. Wyglada na to, ze to nie jest prawdziwy szczur krolow. Wyslal cie zabic petrusa gnebiciela, gdyz ten wiedzial zbyt duzo. Potem pomogl ci zniszczyc HF-P/X, aby otworzyc portal do przeszlosci. Mam nadzieje ze te runy ze swiatyni nie sluzyly do odpieczerowywania czegos innego.. Mysle, ze "szczur krolow" wiedzial gdzie otworzy sie portal, i tylko czekal az HF-P/X umrze. Wtedy tez wskoczyl do srodka i cofnal sie w przeszlosc, gdzie sprzedawal ludziom ccki na allegro. Po jakims czasie wrocil do terazniejszosci, a my nie odczulismy tego, gdyz nasz czas plynie tysiace razy krocej, niz u kogos, kto cofnal sie w czasie. Udaj sie teraz do retro Knurowa i sproboj znalezc kogos, kto kupowal od niego ccki. Byc moze dowiemy sie kim byl ten oszust.',
				nextState = {
					[Storage.SprawiedliwyWobecNarodow.Mission01] = 4,
					[Storage.SprawiedliwyWobecNarodow.Mission01] = 4,
				},
			},
		},
		-- [4] gadamy z X w retro mirko (domek na zachodzie). X mowi, ze jezeli chcemy wiecej informacji o oszuscie, to mamy poszukac w bibliotece pod temple. X przekupil kiedys natanka, aby ten wyjawil mu sposob wejscia do katakumb. Musimy uzyc mechanizmu w zagarku z kukulka, w bardzo konkretny sposob. Musisz wciskac kukulke w odpowiednich momentach: najpierw wcisnij dwa razy, gdy jest godzina parzysta, nastepnie raz, gdy jest nieparzysta, nastepnie znow dwa razy gdy jest parzysta. Na koniec wez aktualna minute, podnies do kwadratu, podziel przez liczbe o jeden wieksza od aktualnej minuty. Jesli reszta z tego dzielenia jest rowna 1, wcisnij przycisk. Jesli to wykonasz, to przejdz w lewy dolny rog pokoju, i sproboj zgasic lampe. Wtedy mechanizm otworzy pod toba dziure i wpadniesz do katkumb.
		-- [5] znajdujemy archiwum z X, a w nim dokument w jezyku jaszczuroludzi
		-- [6] rozmawiamy z gerturda, ktora tlumaczy nam dokument. Dokument mowi o pol-bogu ktory stworzyl niegdys 7 hoecruxow. Musimy je wszystkie zniszczyc
		
		Marmelade jar of strawberries / Marmolada truskawkowa
			Allergen of the Titans / Alergen Tytanow
			Rose of Winds / Roza wiatrow
			Article of times / Artykul czasu
			Hemoglobin of last mohican / Hemoglobina ostatniego Mohikanina
			Instrument of havoc / Instrument spustoszenia
			Number of madness / Numer do diabla
			
		-- UNUSED: Tak, to ostatecznie potwierdza, ze ktos podszywal sie pod Szczura Krolow, a pozniej udawal, ze zmienil sie w Janusza Gwiezdnego. Pamietasz jak wyslal cie na planete Hugo Bossa? Mysle, ze robil wtedy cos wymagajacego dyskrecji, dlatego wyslal cie tak daleko. Chwila.. przeciez Krol Jaszczurow wspominal cos o Hoecruxach. Byc moze zajmowal sie tworzeniem ich w tym czasie?
		[7] = {
			[{ "" }] = {
				text = "",
			},
		},
	},
}
]]

local context = {
	name = name,
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
