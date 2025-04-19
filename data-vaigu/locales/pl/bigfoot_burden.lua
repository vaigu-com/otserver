return {
	--Questlog
	["Bigfoot's Burden"] = "Bigfoot's Burden",
	["Reputation points"] = "Punkty reputacji",
	["Current reputation points"] = function(context)
		return string.format("Posiadasz %d punktow reputacji.", math.max(context.player:getStorageValueByKey(Storage.BigfootsBurden.Rank), 0))
	end,
	["Daily Minor: Crystal Keeper"] = "Dzienne: Naprawca Krysztalow",
	["Daily Minor: Crystal Keeper Status"] = function(context)
		return string.format("Uzyj krysztalu naprawczego, aby naprawic piec uszkodzonych niebieskich krysztalow w jaskiniach krysztalowych. Uszkodzone krysztaly nie beda swiecic. %d/5", math.max(context.player:getStorageValueByKey(Storage.BigfootsBurden.RepairedCrystalCount), 0))
	end,
	["Daily Minor: Raiders of the lost Spark"] = "Dzienne: Lowcy Krysztalow",
	["Daily Minor: Raiders of the lost Spark Status"] = function(context)
		return string.format("Zabij Crystal Crushery i uzyj urzadzenia rozladowujacego na ich cialach, aby zebrac ich ladunki. Zbierz 7 ladunkow i zglos sie z nimi. %d/7", math.max(context.player:getStorageValueByKey(Storage.BigfootsBurden.ExtractedCount), 0))
	end,
	["Daily Minor Plus: Exterminators"] = "Dzienne Plus: Eksterminacje",
	["Daily Minor Plus: Exterminators Status"] = function(context)
		return string.format("Zabij 10 Wigglerow na pomoc gnomom. Nastepnie zglos sie z powrotem. %d/10", math.max(context.player:getStorageValueByKey(Storage.BigfootsBurden.ExterminatedCount), 0))
	end,
	["Daily Minor Plus: Mushroom Digger"] = "Dzienne Plus: Niuchacz Grzybow",
	["Daily Minor Plus: Mushroom Digger Status"] = function(context)
		return string.format("Znajdz i zwab swinie truflowa. Czasem wywachuja swieze trufle. Uzyj mlodego prosiaka na truflach, nakarm go 3 razy. Nastepnie zglos sie do gnomow. %d/3", math.max(context.player:getStorageValueByKey(Storage.BigfootsBurden.MushroomCount), 0))
	end,
	["Daily Major Advanced: Spores"] = "Dzienne Zaawansowane: Zarodniki",
	["Gather spores in the correct order. Your spore gathering list will display the next color you have to look for."] = "Zbieraj zarodniki we wlasciwej kolejnosci. Twoj spis zbierania zarodnikow bedzie wyswietlac nastepny kolor, ktory musisz szukac.",
	["Daily Major Advanced: Yet Another Grinding"] = "Dzienne Zaawansowane: Ponowne Mielenie",
	["Gather a grindstone from the lava area and report back."] = "Zbierz grindstone z okolic lawy i zglos sie z powrotem.",
	["Daily Major: Matchmaker"] = "Dzienne Glowne: Dopasowanka",
	["You have to enter the crystal caves and find a crystal that is fitting the crystal you got from the gnomes. Use the crystal on one of the bigger red crystal in the caves to bond them."] = "Musisz wejsc do jaskin krysztalowych i znalezc krysztal, ktory pasuje do tego, ktory otrzymales od gnomow. Uzyj go na jednym z wiekszych czerwonych krysztalow w jaskiniach, aby je polaczyc.",
	["Daily Major: The Tinker's Bell"] = "Dzienne Glowne: Dzwonek Wynalazcy",
	["Daily Major: The Tinker's Bell Status"] = function(context)
		return string.format("Uzyj harmonicznego dzwonka na oszlalych golemach w warsztacie golemow, dzieki czemu zostana przetransportowani do warsztatow gnomow. Nastepnie zglos sie z powrotem. %d/4.", math.max(context.player:getStorageValueByKey(Storage.BigfootsBurden.GolemCount), 0))
	end,
}
