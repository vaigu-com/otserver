return {
	["WEEKLY_OCELLATUS_MEDAL_QUEST_STATUS"] = function(context)
		local weeksSinceStart = math.ceil(DAYS_SINCE_START / 7)
		local carrotsMade = context.player:getStorageValueByKey(Storage.FashionistaOnanista.CarrotsMade)
		local remainingQuestRepeats = weeksSinceStart - carrotsMade
		if remainingQuestRepeats <= 0 then
			return "You supplied Ocellatus for the week."
		elseif remainingQuestRepeats > 1 then
			return T("Bring 10 medals of honour to Ocellatus for his weekly meat beating competition. He acutally organized competition in the previous weeks, but had no medals to honour the winners. Therefore you can bring him medals a total of :remainingQuestRepeats: times.", { remainingQuestRepeats = remainingQuestRepeats })
		else
			return "Bring 10 medals of honour to Ocellatus for his weekly meat beating competition."
		end
	end,
	["I see you have heard about the umpcoming meat beating competition. Bring me another 10 medals, so we can honour the winners."] = "I see you have heard about the umpcoming meat beating competition. Bring me another 10 medals, so we can honour the winners.",
	["Ask Ocellatus about a new mission"] = "Ask Ocellatus about a new mission",
	["Bring two medals of honour to Ocellatus."] = "Bring two medals of honour to Ocellatus.",
	["Ocellatus gave you his book of marvelous mounted manoeuvers."] = "Ocellatus gave you his book of marvelous mounted manoeuvers.",
	["Ask Ocellatus about new mission."] = "Ask Ocellatus about new mission.",
	["Find Moustachilles, the local trap star."] = "Find Moustachilles, the local trap star.",
	["Moustachilles asked you to find his lost coke."] = "Moustachilles asked you to find his lost coke.",
	["You read an ominous letter. Sender mentioned to bring a bullseye potion to abandoned house, south of Kongo."] = "You read an ominous letter. Sender mentioned to bring a bullseye potion to abandoned house, south of Kongo.",
	["Bring back the coke bag to Moustachilles."] = "Bring back the coke bag to Moustachilles.",
	["Moustachilles rewarded you with a metamphetamine crystal."] = "Moustachilles rewarded you with a metamphetamine crystal.",
	["Ask Moustachilles about new mission"] = "Ask Moustachilles about new mission",
	["Moustachilles trusted you with his bags of fent. Deliver those to his new clients. Moustachilles didnt tell you their names, but hinted that one is a soccer fan living in the south slums and other has a very big nose. Find the one with big nose first."] = "Moustachilles trusted you with his bags of fent. Deliver those to his new clients. Moustachilles didnt tell you their names, but hinted that one is a soccer fan living in the south slums and other has a very big nose. Find the one with big nose first.",
	["Moustachilles trusted you with his bags of fent. Deliver the other bag to second client - the soccer fan. Moustachilles hinted the south slums."] = "Moustachilles trusted you with his bags of fent. Deliver the other bag to second client - the soccer fan. Moustachilles hinted the south slums.",
	["Report to moustachilles and bring him his money."] = "Report to moustachilles and bring him his money.",
	["You completed this mission."] = "You completed this mission.",
	["Me and my friends are hosting a meat beating competition. We need 2 medals of honour for that. Come back when you have them."] = "Me and my friends are hosting a meat beating competition. We need 2 medals of honour for that. Come back when you have them.",
	["Thanks for your help. Here is your reward."] = "Thanks for your help. Here is your reward.",
	["Come back with the the medals i asked for."] = "Come back with the the medals i asked for.",
	["Do you happen to know the local gang boss, Moustachilles? Recently he lost some of his coke and now is desperate to retreive it. I think you could help him with his troubles."] = "Do you happen to know the local gang boss, Moustachilles? Recently he lost some of his coke and now is desperate to retreive it. I think you could help him with his troubles.",
	["Who sent you?"] = "Who sent you?",
	["Alright. In that case i guess i can trust you. One of my man lost two bags of my {coke}. If you were to find it, i will reward you."] = "Alright. In that case i guess i can trust you. One of my man lost two bags of my {coke}. If you were to find it, i will reward you.",
	["My last dealer has been missing in action since. I dont know who, if anyone would try to steal from me."] = "My last dealer has been missing in action since. I dont know who, if anyone would try to steal from me.",
	["Do you have it?"] = "Do you have it?",
	["Alright. Here are your bags. Pleasure doing business.."] = "Alright. Here are your bags. Pleasure doing business..",
	["You did well, here is your reward. If you want to do some more work for me, ask me for a {mission}."] = "You did well, here is your reward. If you want to do some more work for me, ask me for a {mission}.",
	["Take those bags and sell them to two of my clients. One is a soccer fan living in southern slums, and other one has biggest nose around. I expect you not to look inside those bags. The rate is 50 platinum coins per bag."] = "Take those bags and sell them to two of my clients. One is a soccer fan living in southern slums, and other one has biggest nose around. I expect you not to look inside those bags. The rate is 50 platinum coins per bag.",
	["STOP! POLICE. What do we have there? A fent!? You know what? - leave one bag with me and i didnt see or hear anything. Do we have a deal?"] = "STOP! POLICE. What do we have there? A fent!? You know what? - leave one bag with me and i didnt see or hear anything. Do we have a deal?",
	["Come back next week."] = "Come back next week.",
	["Now, get out. I dont want to see you around."] = "Now, get out. I dont want to see you around.",
	["Finally.. How much platinum' for this?"] = "Finally.. How much platinum' for this?",
	["Alright, here is the guap, i counted it."] = "Alright, here is the guap, i counted it.",
	["Thanks for your help. For your reward, take this magical carrot."] = "Thanks for your help. For your reward, take this magical carrot.",
	["Alright! Look like the business is going well. Here is your reward. You should check on Ocellatus, i heard he is doing the meat beating competition again."] = "Alright! Look like the business is going well. Here is your reward. You should check on Ocellatus, i heard he is doing the meat beating competition again.",
	["Come back when you have my money."] = "Come back when you have my money.",
	["Whats good, slime? You got any of that cosmic {fent}?"] = "Whats good, slime? You got any of that cosmic {fent}?",
	["Wish Upon a Trap Star"] = "Wish Upon a Trap Star",
	["Anal Cotton"] = "Anal Cotton",
	["Cum Faucet"] = "Cum Faucet",
	["Fashionista Onanista"] = "Fashionista Onanista",
	["Cum Bucket"] = "Cum Bucket",
	["I see that you are looking Moustachilles belongings. Follow my instructions and you might be lucky enough to bring it back to him. Bring me a bullseye potion and meet me at the abandoned house, south of Kongo."] = "Szukasz towaru Wasacza? Postepuj zgodnie z moimi intrukcjami, a moze go odzyskasz. Przynies mi eliksir bullseye sp. zoo. Spotkajmy sie na poddaszu opuszczonej rudery na poludnie od kongo.",
}
