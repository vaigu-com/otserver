return {
	--Questlog
	["The Dream Courts"] = "The Dream Courts",
	["Find and talk to Vanys in order to help him. He stays in Summer Court in the huge forest located far south from Mirko Town."] = "Find and talk to Vanys in order to help him. He stays in Summer Court in the huge forest located far south from Mirko Town.",
	["Vanys gave you a dream talisman that you'll need to empower eight ward stones located around the world. Ward stone locations you were told about are: mountains of Pirate Island, bonebast coast in the desert, water elemental cave beneath Kongo, depths of Seacrest Serpent lair, west coast of Sybir and Barbarian camp, Nightmare Island, Buried Cathedral beneath Karaiby."] = "Vanys gave you a dream talisman that you'll need to empower eight ward stones located around the world. Ward stone locations you were told about are: mountains of Pirate Island, bonebast coast in the desert, water elemental cave beneath Kongo, depths of Seacrest Serpent lair, west coast of Sybir and Barbarian camp, Nightmare Island, Buried Cathedral beneath Karaiby.",
	["Vanys let you enter the dream labyrinth. Find a way to enter the Nightmare Beast's lair and defeat him. Elven Parchment from Vanys chest may help you."] = "Vanys let you enter the dream labyrinth. Find a way to enter the Nightmare Beast's lair and defeat him. Elven Parchment from Vanys chest may help you.",
	["You have defeated The Nightmare Beast. Talk about this to Vanys."] = "You have defeated The Nightmare Beast. Talk about this to Vanys.",
	["Vanys gifted you with a traditional dream warrior outfit."] = "Vanys gifted you with a traditional dream warrior outfit.",
	["Helping of Stricken Soul"] = "Helping of Stricken Soul",
	["Restore connection and open this nexus to access the buried cathedral. You need to find a way to pass the entrance in the cellar."] = "Restore connection and open this nexus to access the buried cathedral. You need to find a way to pass the entrance in the cellar.",
	["You successfully passed the cellar entrance. Find a way to restore the portal to the buried cathedral."] = "You successfully passed the cellar entrance. Find a way to restore the portal to the buried cathedral.",
	["You restored a portal and successfully entered the buried cathedral. Try to find and defeat the Faceless Bane. You'll need to gain some knowledge in order to enter her nest. Maybe there are some documents around..."] = "You restored a portal and successfully entered the buried cathedral. Try to find and defeat the Faceless Bane. You'll need to gain some knowledge in order to enter her nest. Maybe there are some documents around...",
	["You successfully defeated the Faceless Bane."] = "You successfully defeated the Faceless Bane.",
	["Empowered Wardstones"] = "Empowered Wardstones",
	["Empowered Wardstones Status"] = function(context)
		return string.format("Empowered Wardstones: %d / 8.", (math.max(context.player:getStorageValueByKey(12209), 0)))
	end,
	["Documents Read"] = "Documents Read",
	["Documents Read Status"] = function(context)
		return string.format("Documents Read: %d / 4", (math.max(context.player:getStorageValueByKey(12214), 0)))
	end,
}
