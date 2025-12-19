return {
	["YOU_INVESTIGATED_N_GUARDS__REPORT_TO_HENRICUS"] = function(context)
		local player = context.player
		local visitedCount = 0
		for _, storage in pairs(QuestConstants.TheInquisition.GuardsVisitedStorages) do
			if player:getStorageValueByKey(storage) == ACCESS_GRANTED then
				visitedCount = visitedCount + 1
			end
		end
		if visitedCount < QuestConstants.TheInquisition.GuardsCount then
			return T("You visited :visitedCount: of :maxCount: guards so far.", { visitedCount = visitedCount, maxCount = QuestConstants.TheInquisition.GuardsCount })
		elseif visitedCount == QuestConstants.TheInquisition.GuardsCount then
			return "You visited all guards. Report to Henricus."
		end
	end,
	--Questlog
	["The Inquisition"] = "The Inquisition",
	["Mission 1: Interrogation"] = "Mission 1: Interrogation",
	["Your mission is to investigate the 5 guards regarding the Heretic behavior. Tim, Kulag, Grof, Miles and Walter are their names. If you do well you see a holy sprite on you."] = "Your mission is to investigate the 5 guards regarding the Heretic behavior. Tim, Kulag, Grof, Miles and Walter are their names. If you do well you see a holy sprite on you.",
	["You investigated 1 of 5 guards."] = "You investigated 1 of 5 guards.",
	["You investigated 2 of 5 guards."] = "You investigated 2 of 5 guards.",
	["You investigated 3 of 5 guards."] = "You investigated 3 of 5 guards.",
	["You investigated 4 of 5 guards."] = "You investigated 4 of 5 guards.",
	["You investigated 5 of 5 guards. Get back to Sybir and report your mission to Henricus."] = "You investigated 5 of 5 guards. Get back to Sybir and report your mission to Henricus.",
	["You investigated all guards."] = "You investigated all guards.",
	["Mission 2: Eclipse"] = "Mission 2: Eclipse",
	["Henricus tells you to get The Witches' Grimoire, he sends you to Mirko Town where you can find to the witches' swamps. Use the vial of holy water that he gives you on the big cauldron and open the chest hidden in some witch hut, then bring the witches' grimoire to Henricus."] = "Henricus tells you to get The Witches' Grimoire, he sends you to Mirko Town where you can find to the witches' swamps. Use the vial of holy water that he gives you on the big cauldron and open the chest hidden in some witch hut, then bring the witches' grimoire to Henricus.",
	["Find The Witches' Grimoire and bring it to Henricus."] = "Find The Witches' Grimoire and bring it to Henricus.",
	["You already brought The Witches' Grimoire to Henricus."] = "You already brought The Witches' Grimoire to Henricus.",
	["Mission 3: Vampire Hunt"] = "Mission 3: Vampire Hunt",
	["Henricus wants you to find the Dwarfish Vampire Hunter, Storkus, located deep in dwarven mines. It's a good idea to bring your 20 Vampire Dusts with you to save some time."] = "Henricus wants you to find the Dwarfish Vampire Hunter, Storkus, located deep in dwarven mines. It's a good idea to bring your 20 Vampire Dusts with you to save some time.",
	["Go back to Storkus and ask for a mission."] = "Go back to Storkus and ask for a mission.",
	["Now Storkus wants you to kill a vampire lord, The Count. The Count is located deep under the forgotten cemetery near the hunter camp. To summon The Count, you must use the coffin in the center of the room. Kill him and bring The Ring of the Count to Storkus."] = "Now Storkus wants you to kill a vampire lord, The Count. The Count is located deep under the forgotten cemetery near the hunter camp. To summon The Count, you must use the coffin in the center of the room. Kill him and bring The Ring of the Count to Storkus.",
	["Kill The Count and bring his ring to Storkus, and then ask for a mission."] = "Kill The Count and bring his ring to Storkus, and then ask for a mission.",
	["Return to Storkus and tell him that you've finished your job here."] = "Return to Storkus and tell him that you've finished your job here.",
	["Get back to Sybir and report your mission to Henricus."] = "Get back to Sybir and report your mission to Henricus.",
	["Mission 4: The Haunted Ruin"] = "Mission 4: The Haunted Ruin",
	["Henricus will give you a Special Flask (vial of holy water). You can find some abandoned pirate ruins near hero village in the jungle. Use this vial of holy water on some spot in the haunted ruin to drive out the evil being."] = "Henricus will give you a Special Flask (vial of holy water). You can find some abandoned pirate ruins near hero village in the jungle. Use this vial of holy water on some spot in the haunted ruin to drive out the evil being.",
	["Kill the Pirate Ghost and get back to Sybir and report your mission to Henricus."] = "Kill the Pirate Ghost and get back to Sybir and report your mission to Henricus.",
	["You already cleaned the abandoned and haunted place, ask Henricus for a new mission."] = "You already cleaned the abandoned and haunted place, ask Henricus for a new mission.",
	["Mission 5: Essential Gathering"] = "Mission 5: Essential Gathering",
	["Henricus wants 20 Demonic Essences as proof of your accomplishments."] = "Henricus wants 20 Demonic Essences as proof of your accomplishments.",
	["Now ask Henricus for an outfit to get the Demon Hunter Outfit."] = "Now ask Henricus for an outfit to get the Demon Hunter Outfit.",
	["You got the Demon Hunter Outfit! Ask Henricus for a mission to unlock more addons."] = "You got the Demon Hunter Outfit! Ask Henricus for a mission to unlock more addons.",
	["Mission 6: The Demon Ungreez"] = "Mission 6: The Demon Ungreez",
	["Henricus wants you to kill a demon called Ungreez. Head to the desert demon lair and go down a few levels."] = "Henricus wants you to kill a demon called Ungreez. Head to the desert demon lair and go down a few levels.",
	["You killed Ungreez, report your mission to Henricus."] = "You killed Ungreez, report your mission to Henricus.",
	["You got the first addon of Demon Hunter Outfit! Ask Henricus for a mission to unlock more addons."] = "You got the first addon of Demon Hunter Outfit! Ask Henricus for a mission to unlock more addons.",
	["Mission 7: The Shadow Nexus"] = "Mission 7: The Shadow Nexus",
	["Your mission is to go to the Demon Forge and slay seven of The Ruthless Seven Minions. The Demon Forge is located in the Sybir, somewhere in hidden cultist ruins."] = "Your mission is to go to the Demon Forge and slay seven of The Ruthless Seven Minions. The Demon Forge is located in the Sybir, somewhere in hidden cultist ruins.",
	["You destroyed the shadow nexus! Get back to Henricus and report your mission."] = "You destroyed the shadow nexus! Get back to Henricus and report your mission.",
	["Now ask Henricus for an outfit. He will give you the 2nd addon of the Demon Hunter Outfits."] = "Now ask Henricus for an outfit. He will give you the 2nd addon of the Demon Hunter Outfits.",
	["You got the second addon of Demon Hunter Outfit! Go now to the reward room and choose one wisely!"] = "You got the second addon of Demon Hunter Outfit! Go now to the reward room and choose one wisely!",
	["You have completed The Inquisition Quest!"] = "You have completed The Inquisition Quest!",
}
