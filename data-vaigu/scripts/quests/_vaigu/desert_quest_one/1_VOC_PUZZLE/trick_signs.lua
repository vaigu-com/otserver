	:Script(function(storageToRequiredState)
local goodNames = { "Eustachy Wiertara", "Fifonz Kuciapa", "Sierotka Marysia", "Miroslaw z Ankharu" }
local badNames = { "Wojciech Szpara", "Edward Tatarata", "Bogdan Boner", "Anna Niewypchnieta", "Jan Pawel Drugi" }

DesertQuestOneVocTrickSign = function(context)
	local player = context.player

	local translatedMessage = player:Localizer(Storage.DesertQuestOne.Questline):Get("You can safely exit to the surface. \n\n~")
	local randIndex = math.random(1, #badNames)
	local randomTrickster = badNames[randIndex]
	return translatedMessage .. randomTrickster
end
DesertQuestOneVocGoodSign = function(context)
	local player = context.player

	local translatedMessage = player:Localizer(Storage.DesertQuestOne.Questline):Get("You can safely exit to the surface. \n\n~")
	local randIndex = math.random(1, #goodNames)
	local randomHelper = goodNames[randIndex]
	return translatedMessage .. randomHelper
end
end)
