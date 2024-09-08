local numberStrings = {
	[1] = "first",
	[2] = "second",
	[3] = "third",
	[4] = "fourth",
	[5] = "fifth",
	[6] = "sixth",
	[7] = "seventh",
	[8] = "eighth",
	[9] = "ninth",
	[10] = "tenth",
	[11] = "eleventh",
	[12] = "twelfth",
	[13] = "thirteenth",
	[14] = "fourteenth",
}

return {
	["DESCRIBE_CURRENT_DISH"] = function(context)
		local player = context.player
		local state = player:getStorageValue(Storage.TopChef.Questline)
		local dishData = COOKING_INGREDIENT_DATA[state]
		local dishName = dishData.dishName
		local currentDishNumber = numberStrings[state]

		local translatedMessage = T("The :currentDishNumber: dish we are going to prepare together is called {:dishName:}. Bring me the following ingredients and I'll show you how it's done.", {
			dishName = dishName,
			currentDishNumber = currentDishNumber,
		})
		translatedMessage = translatedMessage .. IngredientsToString(dishData)
		return translatedMessage
	end,
	["TOP_CHEF_MISSION_DESCRIPTION"] = function(context)
		local player = context.player
		local state = player:getStorageValue(Storage.TopChef.Questline)
		if state == 15 then
			return "You finished all dish recipes suggested by Pewter. Ask him for the next steps."
		end
		if state == 16 then
			return "Pewter gave you a copy of his two cookbooks. You can make any recipe now."
		end

		local dishData = COOKING_INGREDIENT_DATA[state]
		local ingredientsString = IngredientsToString(dishData)
		local dishName = dishData.dishName

		local translatedMessage = ""
		if state == 1 then
			translatedMessage = T("You became Pewter assistant. He will teach you to cook like a Top Chef. First dish is gonna be ':dishName:'.", { dishName = dishName })
		else
			local finishedDishNumber = numberStrings[state - 1]
			local currentDishNumber = numberStrings[state]
			translatedMessage = T("You have finished the :finishedDishNumber: dish. The :currentDishNumber: dish you will cook is ':dishName:'", {
				dishName = dishName,
				finishedDishNumber = finishedDishNumber,
				currentDishNumber = currentDishNumber,
			})
		end
		translatedMessage = translatedMessage .. T(" Bring the following ingredients::ingredientsString:", { ingredientsString = ingredientsString })
		return translatedMessage
	end,
	["HAVE_YOU_PREPARED_INGREDIENTS_FOR_CURRENT_DISH"] = function(context)
		local player = context.player
		local state = player:getStorageValue(Storage.TopChef.Questline)
		local dishData = COOKING_INGREDIENT_DATA[state]
		local dishName = dishData.dishName
		return T("Have you prepared the ingredients for the :dishName:?", { dishName = dishName })
	end,
	["Hope you will come again, |PLAYERNAME|"] = "Hope you will come again, |PLAYERNAME|",
	["Just tell me any dish name from the recipe books."] = "Just tell me any dish name from the recipe books.",
	["Hello, welcome to my {kitchen} again, |PLAYERNAME|! Did you visit me again to be taught cooking skills by the best chef around? Ask me for a {recipe} if you wish to continue your training."] = "Hello, welcome to my {kitchen} again, |PLAYERNAME|! Did you visit me again to be taught cooking skills by the best chef around? Ask me for a {recipe} if you wish to continue your training.",
	["Hello, welcome to my {kitchen} again, |PLAYERNAME|! Now that you are a professional chef, what dish would you like to prepare now?"] = "Hello, welcome to my {kitchen} again, |PLAYERNAME|! Now that you are a professional chef, what dish would you like to prepare now?",
	["My friend from this village can provide you wih it."] = "My friend from this village can provide you wih it.",
	["You have to squeeze a coconut to extract its milk."] = "You have to squeeze a coconut to extract its milk.",
	["Namir will sell you an empty mead horn. For the actual mead, i heard that ogres like the taste of it and they store it in barrels."] = "Namir will sell you an empty mead horn. For the actual mead, i heard that ogres like the taste of it and they store it in barrels.",
	["You can sometimes find it in hydra nests. One location i know are the waterfalls in the jungle where lot of crocodiles reside."] = "You can sometimes find it in hydra nests. One location i know are the waterfalls in the jungle where lot of crocodiles reside.",
	["My friend Namir can prepare those for you."] = "My friend Namir can prepare those for you.",
	["Every professional chef writes their own book with their best recipes."] = "Every professional chef writes their own book with their best recipes.",
	["Hello and welcome to my {kitchen}. What are you looking for, |PLAYERNAME|? Perhaps this beautiful aroma lured you there?"] = "Hello and welcome to my {kitchen}. What are you looking for, |PLAYERNAME|? Perhaps this beautiful aroma lured you there?",
	["I cooking and experimenting with new dishes. I work at an Italian restaurant as a head chef, where i devote myself to this passion.\nI love sharing my {recipes}, so i invite you to experiment abit under my supervision. "] = "I cooking and experimenting with new dishes. I work at an Italian restaurant as a head chef, where i devote myself to this passion.\nI love sharing my {recipes}, so i invite you to experiment abit under my supervision. ",
	["Are you intereseted? Well, no doubt, you can't buy they anywhere. However I can guide you become a cooking pro. Do you sign up for this?"] = "Are you intereseted? Well, no doubt, you can't buy they anywhere. However I can guide you become a cooking pro. Do you sign up for this?",
	["Well, you look promising. Ask me for a {recipe}, and i will try to provide you with all necessary infomration. Some ingredients are tougher to find than others, so you might wanna ask me about where to find them."] = "Well, you look promising. Ask me for a {recipe}, and i will try to provide you with all necessary infomration. Some ingredients are tougher to find than others, so you might wanna ask me about where to find them.",
	["Have you prepared the ingredients for the current dish?"] = "Have you prepared the ingredients for the current dish?",
	["Lets begin then!\nA sprinkle of this.. Mince that.. Add this..\nHere it is!\nI think it was all clear. There is your dish! Ask me for {recipe} if you are ready to prepare the next dish."] = "Lets begin then!\nA sprinkle of this.. Mince that.. Add this..\nHere it is!\nI think it was all clear. There is your dish! Ask me for {recipe} if you are ready to prepare the next dish.",
	["Make sure you have all the required ingredients."] = "Make sure you have all the required ingredients.",
	["You dont have either cap or bags slots for this dish."] = "You dont have either cap or bags slots for this dish.",
	["Come back when you are ready."] = "Come back when you are ready.",
	["Congratulations, you finished my training program. These are my books on cooking. Please, take them."] = "Congratulations, you finished my training program. These are my books on cooking. Please, take them.",
	["Do you have all the necessary ingredients?"] = "Do you have all the necessary ingredients?",
	["Lets begin then!\nBit of this.. Mince that.. Add this..\nHere it is!\nI think it was all clear. There is your dish!"] = "Lets begin then!\nBit of this.. Mince that.. Add this..\nHere it is!\nI think it was all clear. There is your dish!",
}
