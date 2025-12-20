local wardstoneKeyToName = {
	[Storage.Quest.U12_00.TheDreamCourts.WardStones.Knurow] = "Poludnie od knurowa",
	[Storage.Quest.U12_00.TheDreamCourts.WardStones.Desolation] = "Desolation near hive",
	[Storage.Quest.U12_00.TheDreamCourts.WardStones.Syberia] = "West Syberia",
	[Storage.Quest.U12_00.TheDreamCourts.WardStones.Caribbean] = "Caribbean",
	[Storage.Quest.U12_00.TheDreamCourts.WardStones.OgreVillage] = "Ogre village",
	[Storage.Quest.U12_00.TheDreamCourts.WardStones.BonebeastIsthmus] = "Bonebeast Isthmus",
	[Storage.Quest.U12_00.TheDreamCourts.WardStones.DemonSkeletonCave] = "Mutated town cave",
	[Storage.Quest.U12_00.TheDreamCourts.WardStones.PirateIsland] = "Pirate island",
}

return {
	["DREAM_TALISMAN_STATUS"] = function(context)
		local player = context.player
		local str = "Udalo ci sie naladowac nastepujace kamienie:"
		for _, key in pairs(QuestConstants.TheDreamCourts.UnlockableWardstones) do
			local status = "-"
			if player:getStorageValueByKey(key) == ACCESS_GRANTED then
				staus = "naladowany!"
			end
			str = str .. T("\n:name:: :status:", { name = wardstoneKeyToName[key], status = status })
		end
		return str
	end,
	--Questlog
	["The Dream Courts"] = "Dwor Snow",
	["Court legate asked you to charge eight wardstones that will weaken the Nightmare Beast. Look at your dream talisman to see which wardtones you already visited."] = "Wyslannik Dworu poprosil cie o naladowanie osmiu kamieni strazniczych, ktore oslabia Bestie Koszmarow. Sprawdz swoj talizman snow, aby zobaczyc, ktore kamienie straznicze juz odwiedziles.",
	["You must kill the Nightmare Beast."] = "Musisz zabic Bestie Koszmarow.",
	["By defeating the dreadful Nightmare Beast you did the Winter Court and the Summer Court alike a great favor. From now on, the dream elves will regard you as a friend."] = "Pokonujac straszliwa Bestie Koszmarow, oddales wielka przysluge zarowno Zimowemu, jak i Letniemu Dworowi. Od tej pory elfy snow beda cie uwazac za przyjaciela.",
	["Haunted House"] = "Nawiedzony Dom",
	["A tormented soul trusted you with the secret of this house. Reveal a hidden portal within!"] = "Udreczona dusza powierzyla ci sekret tego domu. Odkryj ukryty portal!",
	["You have gained an access to the deepest mysteries of the dream courts. You can now activate ward stone and fight Faceless Bane."] = "Zyskales dostep do najglebszych tajemnic dworow snu. Mozesz teraz aktywowac kamien strazniczy i walczyc ze Zmora Beztwarzy.",
	["The Keys"] = "Klucze",
	["Find all keys to unlock the Dream Doors."] = "Znajdz wszystkie klucze, aby otworzyc Wrota Snow.",
	["You found the keys to unlock the Dream Doors in the Labyrinth of Summer's and Winter's Dreams."] = "Znalazles klucze, by otworzyc Wrota Snow w Labiryncie Letnich i Zimowych Snow.",
}
