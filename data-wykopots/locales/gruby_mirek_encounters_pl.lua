return {
	["Kraken"] = "Walka zaczyna sie od tego, ze dowodca druzyny dostrzega w lunecie, ze wlasnie zaatakowal was kraken!\nJego macki proboja zniszczyc poklad statku. Zablokujcie je swoim cialem, a wasza lajba przezyje dluzej.\nW tym samym czasie mozecie atakowac niektore z jego macek. To oslabi go pozniej.\nGdy ilsoc macek atakuajcych poklad bedzie niepolicznalna, wasz statek zamieni sie w dryfujace deski. Kraken wynurzy wtedy swa glowe, a wy bedziecie mogli stawic mu czola.",
	["Zul Szczurow"] = "Zul Szczurow nic nie moze. Niezpieczni natomiast sa jego pacholki - Zule Zulow.\nZul Zulow ma malo zycia, ale przy smierci rzywoluje dwie kopie samego siebie. Badz ostrozny, gdyz ich bardzo latwo jest ich namnozyc.\nPowod, dla ktorego mozesz chciec jednak czasem zabic jednego z nich jest fakt, ze im wiecej czasu minelo od ostatniej smierci Zula Zulow tym wiecej obrazen zadaja inni Zule.",
	["HF-P/X"] = "W tej walce glownym zagrozeniem beda passaty wypuszcane losowo z bram.\nPassaty sa bardzo niezpieczne, gdyz potraca kazdego, kto bedzie stal na ich drodze. Uzyj ich, aby szybciej zabic HF-P/X, lecz uwazaj, zeby samemu nie wpasc pod kola!",
	["Krol Krypty"] = "Jego najwieksza moca jest zwiekszanie sily atakow przy atakowaniu wciaz tego samego celu. Powinniscie zmieniac sie co jakis czas.\nCo kilka sekund krol wyczarowuje bombe, ktora zadaje ogromne obrazenia wszystkim na arenie. Zeby temu zapobiec, stancie przy samej bombie - wtedy obrazenia zostana rownomiernie rozdzielone miedzy osoby blisko bomby.\nKrol przywoluje tez szkieletory, ktore wybuchaja przy smierci - uwazajcie na to!",
	["Pol"] = "Czarne i biale kratki zadaja coraz wiecej obrazen, im dluzej na nich stoisz. Zeby wyzerowac te obrazenia, musisz zejsc z danego koloru na kilka sekund.\nPol potrafi przywolywac mroczne ataki w ksztalcie plusa. Badz czujny i natychmiast ich unikaj!",
	["Skurwiwij"] = "Skurwiwij pobiera moc z najblizszej kolumny. Aby zresetowac moc dla kolejnej kolumny, musisz przeprowadzic bossa do drugiej kolumny.\nPrzy zmienie kolumny, poprzednia kolumna wybucha i za kazdym wybuchem obrazenia sa coraz wieksze, wiec nie rob tego za czesto.",
	["Ruk'ca Maw"] = "Poczatek walki jest bardzo trudny. Ruk'ca jest glodna i sprobuje zjesc wszystko co sie rusza. Doprowadz ja do klatek, aby zjadla mala foczke. To ja uspokoi... na pewien czas. Lepiej sie pospiesz, bo z wraz z glodem rosnie jej furia.\nProwadz ja do konca jaskini, gdzie znajdzies krysztaly soli, na ktore jest uczulony.",
	["LIST_ENCOUNTERS"] = function(context)
		local finalString = ""
		finalString = finalString .. "Zapytaj mnie o jakas walke, a podziele sie z toba wiedza. Oto walki, ktore znam:"
		local playerLanguage = getPlayerLanguage(context.player)
		for name, desc in pairs(TRANSLATION_TABLES[playerLanguage][Storage.GrubyMirekEncounters]) do
			if type(desc) == "string" then
				finalString = finalString .. "\n{" .. name .. "}"
			end
		end
		return finalString
	end,
	["ENCOUNTER_DESCRIPTION"] = function(context)
		local message = context.msg
		local playerLanguage = getPlayerLanguage(context.player)
		for name, desc in pairs(TRANSLATION_TABLES[playerLanguage][Storage.GrubyMirekEncounters]) do
			if type(desc) == "string" and name:lower() == message:lower() then
				return desc
			end
		end
		return "Nie mam informacji na temat tej walki."
	end,
}
