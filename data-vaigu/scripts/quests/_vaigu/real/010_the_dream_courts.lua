local quest = Quest(LOCALIZERS.TheApeCity)

quest
	:Storage(function() end)
	:Questlog(function(localizer)
		table.insert(Quests, {
			name = "The Dream Courts",
			localizer = localizer,
			missions ={
				{
					name = "The Dream Courts",
					storage = 12200,
					description = "Find and talk to Vanys in order to help him. He stays in Summer Court in the huge forest located far south from Mirko Town.",
					endValue = 5,
					states = {
						[1] = "Vanys gave you a dream talisman that you'll need to empower eight ward stones located around the world. Ward stone locations you were told about are: mountains of Pirate Island, bonebast coast in the desert, water elemental cave beneath Kongo, depths of Seacrest Serpent lair, west coast of Sybir and Barbarian camp, Nightmare Island, Buried Cathedral beneath Karaiby.",
						[2] = "Vanys let you enter the dream labyrinth. Find a way to enter the Nightmare Beast's lair and defeat him. Elven Parchment from Vanys chest may help you.",
						[3] = "You have defeated The Nightmare Beast. Talk about this to Vanys.",
						[4] = "Vanys gifted you with a traditional dream warrior outfit.",
					},
				},
				{
					name = "Helping of Stricken Soul",
					storage = 12232,
					description = "Restore connection and open this nexus to access the buried cathedral. You need to find a way to pass the entrance in the cellar.",
					endValue = 4,
					states = {
						[1] = "You successfully passed the cellar entrance. Find a way to restore the portal to the buried cathedral.",
						[2] = "You restored a portal and successfully entered the buried cathedral. Try to find and defeat the Faceless Bane. You'll need to gain some knowledge in order to enter her nest. Maybe there are some documents around...",
						[3] = "You successfully defeated the Faceless Bane.",
					},
				},
				{
					name = "Empowered Wardstones",
					storage = 12209,
					endValue = 8,
					description = "Empowered Wardstones",
				},
				{
					name = "Documents Read",
					storage = 12214,
					endValue = 4,
					description = "Documents Read",
				},
			},
		})
	end)
	:Register()
