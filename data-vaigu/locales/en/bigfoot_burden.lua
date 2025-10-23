return {
	--Questlog
	["Bigfoot's Burden"] = "Bigfoot's Burden",
	["Reputation points"] = "Reputation points",
	["Current reputation points"] = function(context)
		return string.format("Currently You have %d reputation points.", math.max(context.player:getStorageValueByKey(Storage.BigfootsBurden.Rank), 0))
	end,
	["Daily Minor: Crystal Keeper"] = "Daily Minor: Crystal Keeper",
	["Daily Minor: Crystal Keeper Status"] = function(context)
		return string.format("Use the repair crystal to repair five damaged blue crystal in the crystal caves. Damaged crystals will not glow. %d/5", math.max(context.player:getStorageValueByKey(Storage.BigfootsBurden.RepairedCrystalCount), 0))
	end,
	["Daily Minor: Raiders of the lost Spark"] = "Daily Minor: Raiders of the lost Spark",
	["Daily Minor: Raiders of the lost Spark Status"] = function(context)
		return string.format("Kill Crystal Crushers and use discharger item on the corpse to collect their charges. Gather 7 charges and report back. %d/7", math.max(context.player:getStorageValueByKey(Storage.BigfootsBurden.ExtractedCount), 0))
	end,
	["Daily Minor Plus: Exterminators"] = "Daily Minor Plus: Exterminators",
	["Daily Minor Plus: Exterminators Status"] = function(context)
		return string.format("Kill 10 of the wigglers for the gnomes. Then report back to the gnomes. %d/10", math.max(context.player:getStorageValueByKey(Storage.BigfootsBurden.ExterminatedCount), 0))
	end,
	["Daily Minor Plus: Mushroom Digger"] = "Daily Minor Plus: Mushroom Digger",
	["Daily Minor Plus: Mushroom Digger Status"] = function(context)
		return string.format("Find a truffle sniffing pig and lure it around. Occasionally it will unearth some truffles. Use the baby pig on the truffles to feed it 3 times. Then report back to the gnomes. %d/3", math.max(context.player:getStorageValueByKey(Storage.BigfootsBurden.MushroomCount), 0))
	end,
	["Daily Major Advanced: Spores"] = "Daily Major Advanced: Spores",
	["Gather spores in the correct order. Your spore gathering list will display the next color you have to look for."] = "Gather spores in the correct order. Your spore gathering list will display the next color you have to look for.",
	["Daily Major Advanced: Yet Another Grinding"] = "Daily Major Advanced: Yet Another Grinding",
	["Gather a grindstone from the lava area and report back."] = "Gather a grindstone from the lava area and report back.",
	["Daily Major: Matchmaker"] = "Daily Major: Matchmaker",
	["You have to enter the crystal caves and find a crystal that is fitting the crystal you got from the gnomes. Use the crystal on one of the bigger red crystal in the caves to bond them."] = "You have to enter the crystal caves and find a crystal that is fitting the crystal you got from the gnomes. Use the crystal on one of the bigger red crystal in the caves to bond them.",
	["Daily Major: The Tinker's Bell"] = "Daily Major: The Tinker's Bell",
	["Daily Major: The Tinker's Bell Status"] = function(context)
		return string.format("Use the harmonic bell on the mad golems in the golem workshop so that they will automatically be teleported to the gnomish workshops. Then report back to the gnomes. %d/4.", math.max(context.player:getStorageValueByKey(Storage.BigfootsBurden.GolemCount), 0))
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
