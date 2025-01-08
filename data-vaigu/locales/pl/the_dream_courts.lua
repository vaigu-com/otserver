return {
	--Questlog
	["The Dream Courts"] = "The Dream Courts",
	["Find and talk to Vanys in order to help him. He stays in Summer Court in the huge forest located far south from Mirko Town."] = "Znajdz i porozmawiaj z Vanysem, aby mu pomoc. Zatrzymuje sie w Letnim Dworze w ogromnym lesie znajdujacym sie daleko na poludnie od Mirko Town.",
	["Vanys gave you a dream talisman that you'll need to empower eight ward stones located around the world. Ward stone locations you were told about are: mountains of Pirate Island, bonebast coast in the desert, water elemental cave beneath Kongo, depths of Seacrest Serpent lair, west coast of Sybir and Barbarian camp, Nightmare Island, Buried Cathedral beneath Karaiby."] = "Vanys dal ci Dream Talisman, ktorym bedziesz musial wzmocnic osiem kamieni rozlokowanych na calym swiecie. Lokacje kamieni strazniczych, o ktorych ci mowiono, to: gory na Wyspie Piratow, wybrzeze Kosciobestii na pustyni, jaskinia Water Elementali pod Kongo, glebiny jaskin Seacrest Serpent, zachodnie wybrzeze Sybiru i oboz barbarzyncow, Wyspa Koszmarow, Zatopiona Katedra pod Karaibami.",
	["Vanys let you enter the dream labyrinth. Find a way to enter the Nightmare Beast's lair and defeat him. Elven Parchment from Vanys chest may help you."] = "Vanys pozwolil ci wejsc do Dream Labirynth. Znajdz sposob, aby wejsc do kryjowki Nightmare Beast i pokonaj ja. Elfi Pergamin z kufra Vanysa moze ci w tym pomoc.",
	["You have defeated The Nightmare Beast. Talk about this to Vanys."] = "Pokonales Bestie Koszmaru. Porozmawiaj o tym z Vanysem.",
	["Vanys gifted you with a traditional dream warrior outfit."] = "Vanys obdarowal cie tradycyjnym strojem wojownika snow.",
	["Helping of Stricken Soul"] = "Pomaganie Strapionej Duszy",
	["Restore connection and open this nexus to access the buried cathedral. You need to find a way to pass the entrance in the cellar."] = "Musisz znalezc sposob, aby przejsc przez wejscie do piwnicy.",
	["You successfully passed the cellar entrance. Find a way to restore the portal to the buried cathedral."] = "Pomyslnie przeszedles przez wejscie do piwnicy. Znajdz sposob, aby przywrocic portal do zapomnianej katedry.",
	["You restored a portal and successfully entered the buried cathedral. Try to find and defeat the Faceless Bane. You'll need to gain some knowledge in order to enter her nest. Maybe there are some documents around..."] = "Przywrociles portal i pomyslnie wszedles do zapomnianej katedry. Sprobuj odnalezc i pokonac Faceless Bane. Musisz posiasc tajna wiedze, aby wejsc do jej gniazda. Moze gdzies sa jakies dokumenty...",
	["You successfully defeated the Faceless Bane."] = "Pomyslnie pokonales Faceless Bane.",
	["Empowered Wardstones"] = "Empowered Wardstones",
	["Empowered Wardstones Status"] = function(context)
		return string.format("Empowered Wardstones: %d / 8.", (math.max(context.player:getStorageValueByKey(12209), 0)))
	end,
	["Documents Read"] = "Odczytane dokumenty",
	["Documents Read Status"] = function(context)
		return string.format("Documents Read: %d / 4", (math.max(context.player:getStorageValueByKey(12214), 0)))
	end,
}
