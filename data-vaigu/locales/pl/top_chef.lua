local numberStrings = {
	[1] = "Pierwsze",
	[2] = "Drugie",
	[3] = "Trzecie",
	[4] = "Czwarte",
	[5] = "Piate",
	[6] = "Szoste",
	[7] = "Siodme",
	[8] = "Osme",
	[9] = "Dziewiate",
	[10] = "Dziesiate",
	[11] = "Jedenaste",
	[12] = "Dwunaste",
	[13] = "Trzynaste",
	[14] = "Czternaste",
}

return {
	["Top Chef"] = "Mistrz Kuchni",
	["DESCRIBE_CURRENT_DISH"] = function(context)
		local player = context.player
		local state = player:getStorageValueByKey(Storage.TopChef.Mission01)
		local dishData = COOKING_INGREDIENT_DATA[state]
		if not dishData then
			return
		end
		local dishName = dishData.dishName
		local currentDishNumber = numberStrings[state]

		local translatedMessage = T(":currentDishNumber: danie, ktore wspolnie przyzadzimy, nazywa sie {:dishName:}. Przynies mi nastepujace skladniki, a pokaze ci jak je {przyrzadzic}.", {
			dishName = dishName,
			currentDishNumber = currentDishNumber,
		})
		translatedMessage = translatedMessage .. IngredientsToString(dishData)
		return translatedMessage
	end,
	["TOP_CHEF_COURSE_DESCRIPTION"] = function(context)
		local player = context.player
		local state = player:getStorageValueByKey(Storage.TopChef.Mission01)

		local dishData = COOKING_INGREDIENT_DATA[state]
		if not dishData then
			return
		end

		local ingredientsString = IngredientsToString(dishData)
		local dishName = dishData.dishName

		local firstPart = ""
		if state == 1 then
			firstPart = "Zostales mlodszym asystentem kucharza Piotrka. Nauczy on cie jak gotowac jak Top Chef."
		else
			local finishedDishNumber = numberStrings[state - 1]
			firstPart = T("Udalo ci sie przyrzadzic :finishedDishNumber: danie.", {
				finishedDishNumber = finishedDishNumber,
			})
		end

		local currentDishNumber = numberStrings[state]
		local translatedMessage = T(":firstPart: :currentDishNumber: danie, ktore masz przygotowac to ':dishName:'. Przynies nastepujace skladniki::ingredientsString:", {
			firstPart = firstPart,
			currentDishNumber = currentDishNumber,
			dishName = dishName,
			ingredientsString = ingredientsString,
		})
		return translatedMessage
	end,
	["HAVE_YOU_PREPARED_INGREDIENTS_FOR_CURRENT_DISH"] = function(context)
		local player = context.player
		local state = player:getStorageValueByKey(Storage.TopChef.Mission01)
		local dishData = COOKING_INGREDIENT_DATA[state]
		if not dishData then
			return
		end
		local dishName = dishData.dishName
		return T("Czy przeniosles wszystkie skladniki potrzene do :dishName:?", { dishName = dishName })
	end,
	["Hope you will come again, |PLAYERNAME|"] = "Mam nadzieje, ze jeszcze do mnie wrocisz, |PLAYERNAME|",
	["Just tell me any dish name from the recipe books."] = "Po prostu powiedz mi nazwe dowolnego dania z ksiazek kucharskich.",
	["Hello, welcome to my {kitchen} again, |PLAYERNAME|! Did you visit me again to be taught cooking skills by the best chef around? Ask me for a {recipe} if you wish to continue your training."] = "Witaj ponownie w mojej {kuchni}, |PLAYERNAME|! Czy odwiedziles mnie ponownie, aby nauczyc sie gotowania od najlepszego szefa kuchni? Popros mnie o {przepis}, jesli chcesz kontynuowac swoje szkolenie.",
	["Hello, welcome to my {kitchen} again, |PLAYERNAME|! Now that you are a professional chef, what dish would you like to prepare now?"] = "Witaj ponownie w mojej {kuchni}, |PLAYERNAME|! Teraz, jako profesjonalny kucharz, jakie danie chcialbys teraz przygotowac?",
	["My friend from this village can provide you wih it."] = "Moj przyjaciel z naszej wioski ma tego zapas.",
	["You have to squeeze a coconut to extract its milk."] = "Musisz wycisnac kokos, aby uzyskac mleko.",
	["Namir will sell you an empty mead horn. For the actual mead, i heard that ogres like the taste of it and they store it in barrels."] = "Namir sprzeda ci pusty rog na miod pitny. Jesli chodzi o sam miod, slyszalem, ze ogry lubia jego smak i przechowuja go w beczkach.",
	["You can sometimes find it in hydra nests. One location i know are the waterfalls in the jungle where lot of crocodiles reside."] = "Mozesz czasem znalezc to w gniazdach hydr. Jednym z takich miejsc sa wodospady w dzungli, gdzie zyje wiele krokodyli.",
	["My friend Namir can prepare those for you."] = "Moj przyjaciel Namir moze je dla ciebie przygotowac.",
	["Every professional chef writes their own book with their best recipes."] = "Kazdy profesjonalny kucharz pisze wlasna ksiazke ze swoimi najwybitniejszymis przepisami.",
	["Hello and welcome to my {kitchen}. What are you looking for, |PLAYERNAME|? Perhaps this beautiful aroma lured you there?"] = "Witaj w mojej {kuchni}. Czego szukasz, |PLAYERNAME|? Moze zwabil cie ten piekny aromat?",
	["Im cooking and experimenting with new dishes. I work at an Italian restaurant as a head chef, where i devote myself to this passion.\nI love sharing my {recipes}, so i invite you to experiment abit under my supervision. "] = "Gotuje i eksperymentuje z nowymi daniami. Pracuje jako szef kuchni we wloskiej restauracji, gdzie oddaje sie tej pasji.\nUwielbiam dzielic sie moimi {przepisami}, wiec zapraszam cie do eksperymentowania pod moim nadzorem.",
	["Are you intereseted? Well, no doubt, you can't buy they anywhere. However I can guide you become a cooking pro. Do you {sign} up for this?"] = "Jestes zainteresowany? Coz, nie ma watpliwosci, ze nie kupisz ich nigdzie. Jednak moge cie poprowadzic, bys stal sie mistrzem gotowania. Czy {piszesz} sie na to?",
	["Well, you look promising. Ask me for a {recipe}, and i will try to provide you with all necessary infomration. Some ingredients are tougher to find than others, so you might wanna ask me about where to find them."] = "Coz, wygladasz obiecujaco. Popros mnie o {przepis}, a postaram sie dostarczyc ci wszystkie niezbedne informacje. Niektore skladniki sa trudniejsze do znalezienia niz inne, wiec mozesz zapytac mnie, gdzie je znalezc.",
	["Have you prepared the ingredients for the current dish?"] = "Czy przygotowales skladniki do biezacego dania?",
	["Lets begin then!\nA sprinkle of this.. Mince that.. Add this..\nHere it is!\nI think it was all clear. There is your dish! Ask me for {recipe} if you are ready to prepare the next dish."] = "Zaczynajmy!\nSzczypta tego... Posiekaj to... Dodaj tamto...\nGotowe!\nMysle, ze wszystko bylo jasne. Oto twoje danie! Popros mnie o {przepis}, jesli jestes gotow przygotowac kolejne.",
	["Make sure you have all the required ingredients."] = "Upewnij sie, ze masz wszystkie wymagane skladniki.",
	["You dont have either cap or bags slots for this dish."] = "Nie masz miejsca w torbie na to danie, badz nie jestes w stanie go udzwignac.",
	["Come back when you are ready."] = "Wroc, gdy bedziesz gotowy.",
	["Congratulations, you finished my training program. These are my books on cooking. Please, take them."] = "Gratulacje, ukonczyles moj program szkoleniowy. To sa moje ksiazki o gotowaniu. Prosze, wez je.",
	["Do you have all the necessary ingredients?"] = "Czy masz wszystkie niezbedne skladniki?",
	["Lets begin then!\nBit of this.. Mince that.. Add this..\nHere it is!\nI think it was all clear. There is your dish!"] = "Zaczynajmy!\nTroche tego... Posiekaj tamto... Dodaj to...\nGotowe!\nMysle, ze wszystko bylo jasne. Oto twoje danie!",
	["You finished the cooking course. Ask Pewter for your next directions."] = "Zakonczyles program treningowy z zakresu gotowania. Zapytaj Piotrka o dalsze kroki.",
	["Pewter provided you with his cookbooks and you can craft any food now."] = "Piotrek podarowal ci swoja ksiazke kucharska, dzieki ktorej mozesz gotowac dowolna potrawe.",
}
