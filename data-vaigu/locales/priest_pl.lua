return {
	["Hello, you need some help? Check {services} that I offer..."] = "Witaj, potrzebujesz pomocy? Przysluguje mi wykonywanie kaplanskich {uslug}.",
	["You are in the MirkoTown temple. If you wish, I can {bless} you, {heal}, {promote} and {mark} most important civilians of this city on your map.\nYou can also get a {marriage} here."] = "Znajdujesz sie w swiatyni miasta. Jezeli chcesz, moge {uleczyc} Twoje rany, {poblogoslawic} Cie, {awansowac} lub {zaznaczyc} na mapie najwazniejszych NPC. ...\nPrzeprowadzam takze obrzed zawarcia {malzenstwa}.",
	["I marked few points of interest on your map."] = "Prosze bardzo. Zagladnij do mnie za jakis czas, mozliwe ze pojawia sie nowi NPC.",
	["Thank you."] = "Dzieki Ci za ofiare. Idz w pokoju i badz blogoslawiony.",
	["You have been blessed already."] = "Juz Cie poblogoslawilem. Odezwij sie, gdy stracisz moja moc.",
	["You have been healed."] = "Zostales uzdrowiony.",
	["BLESS_PRICE_TEXT"] = function(context)
		local player = context.player
		local finalString = T("Blogoslawienstwo dla ciebie kosztuje :blessPrice: zlota (na nowy konfesjonal!) i chroni Cie przed utrata ekwipunku, jak i zmniejsza kare za smierc. Czy chcesz, abym Cie poblogoslawil?", {
			blessPrice = getBlessingsCost(player:getLevel()) * 5,
		})
		return finalString
	end,
	["BLESS_INSUFFICIENT_MONEY"] = function(context)
		local player = context.player
		local finalString = T("Wybacz, ale abym Cie poblogoslawil musisz wpierw zlozyc ofiare na tace... skromne :blessPrice: sztuk zlota.", {
			blessPrice = getBlessingsCost(player:getLevel()) * 5,
		})
		return finalString
	end,
	["PROMOTION_INSUFFICIENT_MONEY"] = function()
		local finalString = T("Musisz miec :price: zlota na awans!", { price = PROMOTION_PRICE })
		return finalString
	end,
	["You need at least 20 level to get promoted!"] = "Musisz miec minimum 20 poziom!",
	["PROMOTION_TEXT"] = function()
		local finalString = T("Jestes pewny, ze chcesz otrzymac promocje? Kosztowac cie to bedzie :price: zlota.", { price = PROMOTION_PRICE })
		return finalString
	end,
	["NO_PROPOSAL_RESPONSE"] = function(context)
		local finalString = T("{:spouse:} dalej nie odpowiada na oswiadczyny. Czy chcesz je {anulowac}?", {
			spouse = getPlayerNameById(getPlayerSpouse(context.player:getGuid())),
		})
		return finalString
	end,
	["INITIATE_PROPOSAL"] = function(context)
		local finalString = T("Fantastycznie. Teraz musimy poczekac i zobaczyc, czy {:spouse:} zaakceptuje Twoja propozycje. Pamietaj, ze w kazdej chwili mozesz ja {anulowac}.", {
			spouse = getPlayerNameById(getPlayerSpouse(context.player:getGuid())),
		})
		return finalString
	end,
	["You are already promoted!"] = "Przeciez juz masz promocje!",
	["Just ask me to get a {wedding} ceremony!"] = "Aby wziac {slub}, powiedz wprost!",
	["At least one of you doens't have their wedding ring or wedding outfit box."] = "Przynajmniej jedno z was nie ma pierscionka albo stroju. Sa one wymagane, aby wziac slub.",
	["Would you like to get married? Make sure you have a {wedding ring} and the {wedding outfit box} with you."] = "Aby wziac slub, musisz posiadac trzy rzeczy: partnera, oczywiscie, oraz odpowiedni {stroj} oraz {pierscionek}. Czy jestes gotowy? ({tak} / {nie})",
	["You are married already. Do you want to get a {divorce} now?"] = "Widze ten pierscionek na palcu. Co Cie tu sprowadza? Czyzby {rozwod}?",
	["My chronicles suggest that you are married already. Do you want to get a {divorce} now?"] = "Z moich kronik wynika, ze jestes w zwiazku malzenskim. Co Cie tu sprowadza? Czyzby {rozwod}?",
	["Thats great! So you want to {marry} someone?"] = "Aaach, to swietnie! Czyli chcesz kogos {poslubic}?",
	["And who would you like to marry?"] = "To swietnie. Kogo chcesz poslubic?",
	["You can buy wedding ring from local jewellery store, and wedding outfit box from Michael Dumplings clothing store."] = "",
	["That person is already married"] = "Przykro mi. Ta osoba jest juz w zwiazku.",
	["That person is someone else's fiance/fiancee."] = "Przykro mi. Ta osoba jest juz z kim zareczona.",
	["I dont think thats the correct name."] = "Raczej nie te imie miales na mysli.",
	["Thats not funny.."] = "Stulejo, badz powazna.",
	["That's fine."] = "W porzadku. Wroc jak wszystko skompletujesz.",
	["You need to get {wedding ring} and {wedding outfit box} first. Then we can continue."] = "Najpierw musisz miec {stroj} i {pierscionek}. Dopiero wtedy mozemy przejsc do konkretow!",
	["Since both young souls are willing to marry - get ready. Let me know if you are willing to start the {celebration}."] = "W zwiazku z tym, ze wola jest obustronna - przygotujcie sie. A gdy bedziecie gotowi, zawolajcie mnie, a {ceremonia} sie rozpocznie!",
	["Is your soulmate and friends here with you for the celebration?"] = "A wiec mozemy zaczynac. Czy swiadkowie i goscie sa na miejscu? ({tak} / {nie})",
	["Then go bring them here!"] = "W takim razie po co mnie wolasz?! Sciagnij ich tu!",
	["Good, let's {begin} then!"] = "Pieknie! {Rozpocznijmy}, dajcie tylko znak.",
	["MARRIAGE_TROPHY_DESC"] = function(context)
		local finalString = T("To trofeum nalezy do :player:, nadane przez Ks. Natanka, za zawarcie zwiazku malzenskiego.", { player = context.player:getName() })
		return finalString
	end,
	["MARRIAGE_RING_DESC"] = function(context)
		local finalString = T(":player: & :spouse:, dopoki tagi na Wykopie nie zostana naprawione, od :date:", {
			player = context.player:getName(),
			spouse = getPlayerNameById(getPlayerSpouse(context.player:getGuid())),
			date = os.date("%B %d, %Y."),
		})
		return finalString
	end,
	["CONFIRM_DIVORCE"] = function(context)
		local finalString = T("A wiec chcesz rozwiesc sie z {:spouse:}?", {
			spouse = getPlayerNameById(getPlayerSpouse(context.player:getGuid())),
		})
		return finalString
	end,
	["I'm very happy with your decision."] = "To dobrze. Gardze rozwodami.",
	["You are not married to anyone."] = "Nie masz malzonka, wiec nie mozesz sie rozwiesc. Smiesznie, nie?",
	["Well. I hope you wont regret it."] = "W porzadku. Nie jestescie juz razem. Jestem pewny, twoj partner ciezko to przezyje.",
	["You are not proposed to anyone."] = "Nie oswiadczyles sie nikomu.",
	["I won't be doing anything about that then."] = "Okej, w takim razie nic nie zmieniamy.",
	["It's cancelled."] = "OK. Twoje oswiadczyny zostaly anulowane.",
	["Are sure you want to cancel your proposal?"] = "Czy na pewno chcesz zrezygnowac z oswiadczyn?",
	["Your partner did not accept your proposal yet."] = "Twoj partner nie przyjal twojej propozycji oswiadczyn, przynajmniej narazie.",
	["MARRIAGE_TALKTYPE_SAY_TEXT"] = function(context)
		return T(
			"Kochane Mirki i Mirabelki, zebralismy sie dzis, aby uczcic zawarcie zwiazku malzenskiego pomiedzy :player: i :spouse:.\nPoprzez podroze, rozmowy i gre zrozumieli, ze czas wyjsc z #tfwnogf i #tfwnobf, najwyzsza pora odwinac stulejke i zaczac grac na powaznie.\nW zwiazku z tym dzisiaj zostana polaczeni wiezami malzenstwa, a wiec pozostana solidarni w huncie, w pekowaniu, w biedzie i w rollbackach serwera.\n*szepczac cos o #nocnazmiana i #neuropa, wyciaga dlon z pierscionkami ku\n:player:* Wez te grawerowane pierscienie, a jeden przekaz swojej drugiej, Mirkowej polowce.\nMozesz zaplusowac swojego oficjalnego, Mirkowego #rozowypasek.",
			{
				player = context.player:getName(),
				spouse = getPlayerNameById(getPlayerSpouse(context.player:getGuid())),
			}
		)
	end,
}
