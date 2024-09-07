local talkaction = TalkAction("!faq")

function talkaction.onSay(player, words, param)
	local text = "Najczesciej zadawane pytania:"
		.. "\n"
		.. "\n 1. Gdzie promocja/Natanek?"
		.. "\n - Na pietrze w temple, koszt 15k"
		.. "\n"
		.. "\n 2. Gdzie taski?"
		.. "\n - Poludnie od depo, npc Tropiciel Wielki"
		.. "\n"
		.. "\n 3. Gdzie trening?"
		.. "\n - Statuy offline pierwszy budynek poludniowy zachod od temple"
		.. "\n - Kukla do exercise weapon w depo"
		.. "\n"
		.. "\n 4. Gdzie Komisarz Ryba?"
		.. "\n - Poludniowo zachodnia czesc miasta, prawo od stawu"
		.. "\n"
		.. "\n 5. Gdzie boss rotwormow?"
		.. "\n - Kanaly po wschodniej czesci miasta, poziom -2"
		.. "\n"
		.. "\n 6. Jak ustawic autoloot?"
		.. "\n - Ctrl + ppm na plecak - Manage Loot Containers, celowniczkiem wybierasz plecak do ktorego ma zbierac. Aby nie zbieralo danego itemu to ppm i 'Add to Loot List'."

	local engtext = "Frequently asked questions:"
		.. "\n"
		.. "\n 1. Where can I buy promotion?"
		.. "\n - First floor in MirkoTowns temple, cost 15k"
		.. "\n"
		.. "\n 2. Where can I get tasks?"
		.. "\n - South of depot, npc Tropiciel Wielki"
		.. "\n"
		.. "\n 3. Where can I train?"
		.. "\n - Offline training statues are in first building south west of temple"
		.. "\n - Exercise training dummy in depot"
		.. "\n"
		.. "\n 4. Where is Commissioner Fisher?"
		.. "\n - South west part of MirkoTown, east of small pond"
		.. "\n"
		.. "\n 5. Where is rotworm task boss?"
		.. "\n - Sewers in eastern part of MirkoTown, floor -2"
		.. "\n"
		.. "\n 6. How to use autoloot?"
		.. "\n - Ctrl + RMB on backpack - Manage Loot Containers, select container you want to collect items into with crosshair. If you dont want to collect certain item - RMB and 'Add to Loot List'."

	if getPlayerLanguage(player) == "PL" then
		player:showTextDialog(8707, text)
	else
		player:showTextDialog(8707, engtext)
	end
	return false
end

talkaction:separator(" ")
talkaction:groupType("normal")
talkaction:register()
