local name = "Fat Myrrus"
local outfit = {
	lookType = 251,
	lookHead = 114,
	lookBody = 88,
	lookLegs = 88,
	lookFeet = 88,
	lookAddons = 0,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Haha tak na prawde nie jestem gruby!" },
	{ text = "I tak na prawde nie mam na imie Mirek!" },
	{ text = "Sprzedam info za opla pisac pw" },
	{ text = "Jak mnie denerwuja te limity na wpisy ehh" },
	{ text = "W moim sercu tylko guwnowpis!" },
}
local customDialogs = {
	[{ GREET }] = {
		text = "Hello |PLAYERNAME|. I can tell you {informations} about whats behind the gates. You can also take some {mission} from me. By the way: im an expert at WoW raids, and I might be able to help you with dangerous {encounters} of this world.",
	},
	[WALKAWAY] = { text = "SoldierWalkaway" },
	[{ "informacja", "information", "informations" }] = {
		text = "Far to the west there is small village called Knurowo. You need to be aware of elves and bandits if you want to go there. To the south west there is main farm of our town, and some hills inhabited by amazons and goblins to the north.",
	},
	[{ "goldblum" }] = {
		text = "Goldblum is a very cunning one. He likes to play the riddles game. If he asks you about the valuation of structured bonds, say exactly these words: {It depends on the current level of the stock market index, stock price, commodity price, currency exchange rate, or other market indicator that serves as their underlying instrument}",
	},
	[{
		"It depends on the current level of the stock market index, stock price, commodity price, currency exchange rate, or other market indicator that serves as their underlying instrument",
		"Od aktualnego poziomu indeksu gieldowego, kursu akcji, ceny surowca, kursu waluty lub innego wskaznika rynkowego, ktory stanowi ich instrument bazowy",
	}] = { text = "Yeah, you got it!" },
}
local context = {
	name = name,
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
