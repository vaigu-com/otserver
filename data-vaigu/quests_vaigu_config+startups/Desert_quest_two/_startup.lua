BANJO_KROLA_SZCZUROW:Script(function(missionState)
local static = {
	{ position = Position(5899, 1573, 9), id = 2772, aid = Storage.DesertQuestTwo.Puzzles.Chess.ClearLever },
}

local puzzles = {
	
}

local rubiksCube = {

}

local expReward = 1

local monsters = {
	{ pos = { 51, -16, 0 }, name = "fast moa" },
}

local desertQuestTwoInit = GlobalEvent("desertQuestTwoInit")
function desertQuestTwoInit.onStartup()
	LoadStartupItems(static)
	LoadStartupItems(rubiksCube, RUBIKS_CUBE_ANCHOR)

	LoadStartupItems(puzzles, DESERT_QUEST_TWO_ANCHOR)
	LoadStartupMonsters(monsters, DESERT_QUEST_TWO_ANCHOR)
	LoadStartupItems(expReward, DESERT_QUEST_TWO_ANCHOR)


end
desertQuestTwoInit:register()
end)
