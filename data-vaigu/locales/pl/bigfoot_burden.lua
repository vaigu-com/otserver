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
	["You may enter the first warzone without using a mission crystal."] = "You may enter the first warzone without using a mission crystal.",
	["Deliver the Deathstrike's snippet to gnomission to enter the first warzone for free."] = "Deliver the Deathstrike's snippet to gnomission to enter the first warzone for free.",
	["You have been g-rayed. It has been an ... unexpected experience. Now you are ready for your \near examination. Walk up to doctor Gnomedix and wait for him to finish your ear examination."] = "You have been g-rayed. It has been an ... unexpected experience. Now you are ready for your \near examination. Walk up to doctor Gnomedix and wait for him to finish your ear examination.",
	["You passed the ear examination. Well, at least most of you did. \nNow talk to Gnomaticus about your next test. "] = "You passed the ear examination. Well, at least most of you did. \nNow talk to Gnomaticus about your next test. ",
	["Deliver the Gnomevil's hat to gnomission to enter the second warzone for free."] = "Deliver the Gnomevil's hat to gnomission to enter the second warzone for free.",
	["You may enter the second warzone without using a mission crystal."] = "You may enter the second warzone without using a mission crystal.",
	["You may enter the third warzone without using a mission crystal."] = "You may enter the third warzone without using a mission crystal.",
	["Deliver the Abyssador's lash to gnomission to enter the third warzone for free."] = "Deliver the Abyssador's lash to gnomission to enter the third warzone for free.",
	["Enter the lower chamber for your endurance test. Reach the teleporter north of the hall."] = "Enter the lower chamber for your endurance test. Reach the teleporter north of the hall.",
	["You have passed the endurance test. Report back to Gnomewart."] = "You have passed the endurance test. Report back to Gnomewart.",
	["You passed the endurance test and are ready to talk to Gnomelvis about your soul melody."] = "You passed the endurance test and are ready to talk to Gnomelvis about your soul melody.",
	["Pass Gnomerik's test by answering his questions. \nIf you fail to get a high enough score drink a mushroom beer and start again."] = "Pass Gnomerik's test by answering his questions. \nIf you fail to get a high enough score drink a mushroom beer and start again.",
	["Find your personal soul melody by trial and error. \nCreate the complete soul melody of seven notes and then report to Gnomelvis. Red notes indicate a failure."] = "Find your personal soul melody by trial and error. \nCreate the complete soul melody of seven notes and then report to Gnomelvis. Red notes indicate a failure.",
	["You found your very own soul melody. You should talk to Gnomelvis about it!"] = "You found your very own soul melody. You should talk to Gnomelvis about it!",
	["You have passed the gnomish psychology test and can proceed to the medical exam. \nTalk to Gnomespector about your next examination."] = "You have passed the gnomish psychology test and can proceed to the medical exam. \nTalk to Gnomespector about your next examination.",
	["Recruitment: Ear Examination"] = "Recruitment: Ear Examination",
	["Recruitment: Gnomish Warfare"] = "Recruitment: Gnomish Warfare",
	["Recruitment: Endurance Test"] = "Recruitment: Endurance Test",
	["Recruitment: Soul Melody"] = "Recruitment: Soul Melody",
	["Recruitment"] = "Recruitment",
	["Gnomish War Hero (Warzone 1)"] = "Gnomish War Hero (Warzone 1)",
	["Looking for Gnomerik"] = "Looking for Gnomerik",
	["Gnomish War Hero (Warzone 3)"] = "Gnomish War Hero (Warzone 3)",
	["A New Recruit"] = "A New Recruit",
	["Gnomish War Hero (Warzone 2)"] = "Gnomish War Hero (Warzone 2)",
	["Recruitment: A Test in Gnomology"] = "Recruitment: A Test in Gnomology",
	["Recruitment: Medical Examination"] = "Recruitment: Medical Examination",
}
