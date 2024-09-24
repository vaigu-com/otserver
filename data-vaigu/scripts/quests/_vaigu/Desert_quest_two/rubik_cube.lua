	:Script(function(storageToRequiredState)
local cubeMapPositions = {
	top = {
		[1] = RUBIKS_CUBE_ANCHOR:Moved(0, 0, 0),
		[2] = RUBIKS_CUBE_ANCHOR:Moved(1, 0, 0),
		[3] = RUBIKS_CUBE_ANCHOR:Moved(2, 0, 0),
		[4] = RUBIKS_CUBE_ANCHOR:Moved(0, 1, 0),
		[5] = RUBIKS_CUBE_ANCHOR:Moved(1, 1, 0),
		[6] = RUBIKS_CUBE_ANCHOR:Moved(2, 1, 0),
		[7] = RUBIKS_CUBE_ANCHOR:Moved(0, 2, 0),
		[8] = RUBIKS_CUBE_ANCHOR:Moved(1, 2, 0),
		[9] = RUBIKS_CUBE_ANCHOR:Moved(2, 2, 0),
	},
	bottom = {
		[1] = RUBIKS_CUBE_ANCHOR:Moved(3, 3, 3),
		[2] = RUBIKS_CUBE_ANCHOR:Moved(4, 3, 3),
		[3] = RUBIKS_CUBE_ANCHOR:Moved(5, 3, 3),
		[4] = RUBIKS_CUBE_ANCHOR:Moved(3, 4, 3),
		[5] = RUBIKS_CUBE_ANCHOR:Moved(4, 4, 3),
		[6] = RUBIKS_CUBE_ANCHOR:Moved(5, 4, 3),
		[7] = RUBIKS_CUBE_ANCHOR:Moved(3, 5, 3),
		[8] = RUBIKS_CUBE_ANCHOR:Moved(4, 5, 3),
		[9] = RUBIKS_CUBE_ANCHOR:Moved(5, 5, 3),
	},
	back = {
		[1] = RUBIKS_CUBE_ANCHOR:Moved(2, -1, 1),
		[2] = RUBIKS_CUBE_ANCHOR:Moved(1, -1, 1),
		[3] = RUBIKS_CUBE_ANCHOR:Moved(0, -1, 1),
		[4] = RUBIKS_CUBE_ANCHOR:Moved(2, -1, 2),
		[5] = RUBIKS_CUBE_ANCHOR:Moved(1, -1, 2),
		[6] = RUBIKS_CUBE_ANCHOR:Moved(0, -1, 2),
		[7] = RUBIKS_CUBE_ANCHOR:Moved(2, -1, 3),
		[8] = RUBIKS_CUBE_ANCHOR:Moved(1, -1, 3),
		[9] = RUBIKS_CUBE_ANCHOR:Moved(0, -1, 3),
	},
	front = {
		[1] = RUBIKS_CUBE_ANCHOR:Moved(0, 2, 1),
		[2] = RUBIKS_CUBE_ANCHOR:Moved(1, 2, 1),
		[3] = RUBIKS_CUBE_ANCHOR:Moved(2, 2, 1),
		[4] = RUBIKS_CUBE_ANCHOR:Moved(0, 2, 2),
		[5] = RUBIKS_CUBE_ANCHOR:Moved(1, 2, 2),
		[6] = RUBIKS_CUBE_ANCHOR:Moved(2, 2, 2),
		[7] = RUBIKS_CUBE_ANCHOR:Moved(0, 2, 3),
		[8] = RUBIKS_CUBE_ANCHOR:Moved(1, 2, 3),
		[9] = RUBIKS_CUBE_ANCHOR:Moved(2, 2, 3),
	},
	left = {
		[1] = RUBIKS_CUBE_ANCHOR:Moved(-1, 0, 1),
		[2] = RUBIKS_CUBE_ANCHOR:Moved(-1, 1, 1),
		[3] = RUBIKS_CUBE_ANCHOR:Moved(-1, 2, 1),
		[4] = RUBIKS_CUBE_ANCHOR:Moved(-1, 0, 2),
		[5] = RUBIKS_CUBE_ANCHOR:Moved(-1, 1, 2),
		[6] = RUBIKS_CUBE_ANCHOR:Moved(-1, 2, 2),
		[7] = RUBIKS_CUBE_ANCHOR:Moved(-1, 0, 3),
		[8] = RUBIKS_CUBE_ANCHOR:Moved(-1, 1, 3),
		[9] = RUBIKS_CUBE_ANCHOR:Moved(-1, 2, 3),
	},
	right = {
		[1] = RUBIKS_CUBE_ANCHOR:Moved(2, 2, 1),
		[2] = RUBIKS_CUBE_ANCHOR:Moved(2, 1, 1),
		[3] = RUBIKS_CUBE_ANCHOR:Moved(2, 0, 1),
		[4] = RUBIKS_CUBE_ANCHOR:Moved(2, 2, 2),
		[5] = RUBIKS_CUBE_ANCHOR:Moved(2, 1, 2),
		[6] = RUBIKS_CUBE_ANCHOR:Moved(2, 0, 2),
		[7] = RUBIKS_CUBE_ANCHOR:Moved(2, 2, 3),
		[8] = RUBIKS_CUBE_ANCHOR:Moved(2, 1, 3),
		[9] = RUBIKS_CUBE_ANCHOR:Moved(2, 0, 3),
	},
}

local currentCubeFaceState = {
	top = {
		[1] = 0,
		[2] = 0,
		[3] = 0,
		[4] = 0,
		[5] = 0,
		[6] = 0,
		[7] = 0,
		[8] = 0,
		[9] = 0,
	},
	bottom = {
		[1] = 1,
		[2] = 1,
		[3] = 1,
		[4] = 1,
		[5] = 1,
		[6] = 1,
		[7] = 1,
		[8] = 1,
		[9] = 1,
	},
	left = {
		[1] = 2,
		[2] = 2,
		[3] = 2,
		[4] = 2,
		[5] = 2,
		[6] = 2,
		[7] = 2,
		[8] = 2,
		[9] = 2,
	},
	right = {
		[1] = 3,
		[2] = 3,
		[3] = 3,
		[4] = 3,
		[5] = 3,
		[6] = 3,
		[7] = 3,
		[8] = 3,
		[9] = 3,
	},
	front = {
		[1] = 4,
		[2] = 4,
		[3] = 4,
		[4] = 4,
		[5] = 4,
		[6] = 4,
		[7] = 4,
		[8] = 4,
		[9] = 4,
	},
	back = {
		[1] = 5,
		[2] = 5,
		[3] = 5,
		[4] = 5,
		[5] = 5,
		[6] = 5,
		[7] = 5,
		[8] = 5,
		[9] = 5,
	},
}

local faceTransferArray = {
	horizontal = {
		front = {
			sourceTiles = { 4, 5, 6 },
			destTiles = { 4, 5, 6 },
			destFace = "right",
		},
		right = {
			sourceTiles = { 4, 5, 6 },
			destTiles = { 4, 5, 6 },
			destFace = "back",
		},
		back = {
			sourceTiles = { 4, 5, 6 },
			destTiles = { 4, 5, 6 },
			destFace = "left",
		},
		left = {
			sourceTiles = { 4, 5, 6 },
			destTiles = { 4, 5, 6 },
			destFace = "front",
		},
	},
	verticalParallel = {
		top = {
			sourceTiles = { 4, 5, 6 },
			destTiles = { 2, 5, 8 },
			destFace = "right",
		},
		right = {
			sourceTiles = { 2, 5, 8 },
			destTiles = { 6, 5, 4 },
			destFace = "bottom",
		},
		bottom = {
			sourceTiles = { 4, 5, 6 },
			destTiles = { 2, 5, 8 },
			destFace = "left",
		},
		left = {
			sourceTiles = { 2, 5, 8 },
			destTiles = { 6, 5, 4 },
			destFace = "top",
		},
	},
	verticalPerpendicular = {
		top = {
			sourceTiles = { 2, 5, 8 },
			destTiles = { 8, 5, 2 },
			destFace = "back",
		},
		back = {
			sourceTiles = { 2, 5, 8 },
			destTiles = { 2, 5, 8 },
			destFace = "bottom",
		},
		bottom = {
			sourceTiles = { 2, 5, 8 },
			destTiles = { 8, 5, 2 },
			destFace = "front",
		},
		front = {
			sourceTiles = { 2, 5, 8 },
			destTiles = { 2, 5, 8 },
			destFace = "top",
		},
	},
	top = {
		left = {
			sourceTiles = { 1, 2, 3 },
			destTiles = { 1, 2, 3 },
			destFace = "front",
		},
		front = {
			sourceTiles = { 1, 2, 3 },
			destTiles = { 1, 2, 3 },
			destFace = "right",
		},
		right = {
			sourceTiles = { 1, 2, 3 },
			destTiles = { 1, 2, 3 },
			destFace = "back",
		},
		back = {
			sourceTiles = { 1, 2, 3 },
			destTiles = { 1, 2, 3 },
			destFace = "left",
		},
	},
	bottom = {
		left = {
			sourceTiles = { 7, 8, 9 },
			destTiles = { 7, 8, 9 },
			destFace = "front",
		},
		front = {
			sourceTiles = { 7, 8, 9 },
			destTiles = { 7, 8, 9 },
			destFace = "right",
		},
		right = {
			sourceTiles = { 7, 8, 9 },
			destTiles = { 7, 8, 9 },
			destFace = "back",
		},
		back = {
			sourceTiles = { 7, 8, 9 },
			destTiles = { 7, 8, 9 },
			destFace = "left",
		},
	},
	left = {
		top = {
			sourceTiles = { 1, 4, 7 },
			destTiles = { 9, 6, 3 },
			destFace = "back",
		},
		back = {
			sourceTiles = { 3, 6, 9 },
			destTiles = { 1, 4, 7 },
			destFace = "bottom",
		},
		bottom = {
			sourceTiles = { 1, 4, 7 },
			destTiles = { 7, 4, 1 },
			destFace = "front",
		},
		front = {
			sourceTiles = { 1, 4, 7 },
			destTiles = { 1, 4, 7 },
			destFace = "top",
		},
	},
	right = {
		top = {
			sourceTiles = { 3, 6, 9 },
			destTiles = { 7, 4, 1 },
			destFace = "back",
		},
		back = {
			sourceTiles = { 1, 4, 7 },
			destTiles = { 3, 6, 9 },
			destFace = "bottom",
		},
		bottom = {
			sourceTiles = { 3, 6, 9 },
			destTiles = { 9, 6, 3 },
			destFace = "front",
		},
		front = {
			sourceTiles = { 3, 6, 9 },
			destTiles = { 3, 6, 9 },
			destFace = "top",
		},
	},
	front = {
		top = {
			sourceTiles = { 7, 8, 9 },
			destTiles = { 1, 4, 7 },
			destFace = "right",
		},
		right = {
			sourceTiles = { 1, 4, 7 },
			destTiles = { 9, 8, 7 },
			destFace = "bottom",
		},
		bottom = {
			sourceTiles = { 7, 8, 9 },
			destTiles = { 3, 6, 9 },
			destFace = "left",
		},
		left = {
			sourceTiles = { 3, 6, 9 },
			destTiles = { 9, 8, 7 },
			destFace = "top",
		},
	},
	back = {
		top = {
			sourceTiles = { 1, 2, 3 },
			destTiles = { 3, 6, 9 },
			destFace = "right",
		},
		right = {
			sourceTiles = { 3, 6, 9 },
			destTiles = { 3, 2, 1 },
			destFace = "bottom",
		},
		bottom = {
			sourceTiles = { 1, 2, 3 },
			destTiles = { 1, 4, 7 },
			destFace = "left",
		},
		left = {
			sourceTiles = { 1, 4, 7 },
			destTiles = { 3, 2, 1 },
			destFace = "top",
		},
	},
}

local selfContaintedTransferArray = {
	top = {
		[1] = 3,
		[3] = 9,
		[7] = 1,
		[9] = 7,
		[2] = 6,
		[6] = 8,
		[8] = 4,
		[4] = 2,
	},
	front = {
		[3] = 1,
		[9] = 3,
		[1] = 7,
		[7] = 9,
		[6] = 2,
		[8] = 6,
		[4] = 8,
		[2] = 4,
	},
	right = {
		[3] = 1,
		[9] = 3,
		[1] = 7,
		[7] = 9,
		[6] = 2,
		[8] = 6,
		[4] = 8,
		[2] = 4,
	},
	left = {
		[1] = 3,
		[3] = 9,
		[7] = 1,
		[9] = 7,
		[2] = 6,
		[6] = 8,
		[8] = 4,
		[4] = 2,
	},
	back = {
		--1-7-9-3
		[1] = 3,
		[3] = 9,
		[7] = 1,
		[9] = 7,
		[2] = 6,
		[6] = 8,
		[8] = 4,
		[4] = 2,
	},
	bottom = {
		[1] = 3,
		[3] = 9,
		[7] = 1,
		[9] = 7,
		[2] = 6,
		[6] = 8,
		[8] = 4,
		[4] = 2,
	},
}

local function rotateSelfContained(cube, faceName)
	local rotated = Deepcopied(cube)
	for fromTile, toTile in pairs(selfContaintedTransferArray[faceName] or {}) do
		rotated[faceName][fromTile] = cube[faceName][toTile]
	end

	return rotated
end

local function rotateCube(faceName)
	local temp = Deepcopied(currentCubeFaceState)

	local allFacesConfig = faceTransferArray[faceName]
	for sourceFace, content in pairs(allFacesConfig) do
		local destFace = content.destFace
		local sourcePositions = content.sourceTiles
		local desitnationPositions = content.destTiles

		for i = 1, 3 do
			temp[destFace][desitnationPositions[i]] = currentCubeFaceState[sourceFace][sourcePositions[i]]
		end
	end
	currentCubeFaceState = temp
	temp = Deepcopied(currentCubeFaceState)
	temp = rotateSelfContained(temp, faceName)
	currentCubeFaceState = temp
end

local function removeCubeFromMap()
	for _, face in pairs(cubeMapPositions) do
		for _, pos in pairs(face) do
			local tile = Tile(pos)
			if tile then
				local items = tile:getItems()
				for _, item in pairs(items) do
					item:remove()
				end
			end
		end
	end
end

local tileValueAndPlaneToId = {
	horizontal = {
		[0] = 936,
		[1] = 8230,
		[2] = 13437,
		[3] = 8085,
		[4] = 25339,
		[5] = 21261,
	},
	verticalPerpendicular = {
		[0] = 33097,
		[1] = 1356,
		[2] = 6739,
		[3] = 15914,
		[4] = 10981,
		[5] = 21229,
	},
	verticalPerallel = {
		[0] = 33098,
		[1] = 1357,
		[2] = 6740,
		[3] = 15918,
		[4] = 10982,
		[5] = 21224,
	},
}

local faceToPlane = {
	top = "horizontal",
	bottom = "horizontal",
	front = "verticalPerallel",
	back = "verticalPerallel",
	left = "verticalPerpendicular",
	right = "verticalPerpendicular",
}

local function getFacePlane(faceName)
	return faceToPlane[faceName]
end

local function renderCubeOnMap()
	for faceName, face in pairs(currentCubeFaceState) do
		for currentTileId, value in pairs(face) do
			local pos = cubeMapPositions[faceName][currentTileId]
			local id = tileValueAndPlaneToId[getFacePlane(faceName)][value]
			Game.createItem(id, 1, pos)
		end
	end
end

local leverAidToFaceName = {
	[Storage.DesertQuestTwo.Puzzles.RubiksCube.Back] = "back",
	[Storage.DesertQuestTwo.Puzzles.RubiksCube.Xaxis] = "verticalParallel",
	[Storage.DesertQuestTwo.Puzzles.RubiksCube.Front] = "front",

	[Storage.DesertQuestTwo.Puzzles.RubiksCube.Right] = "right",
	[Storage.DesertQuestTwo.Puzzles.RubiksCube.Yaxis] = "verticalPerpendicular",
	[Storage.DesertQuestTwo.Puzzles.RubiksCube.Left] = "left",

	[Storage.DesertQuestTwo.Puzzles.RubiksCube.Bottom] = "bottom",
	[Storage.DesertQuestTwo.Puzzles.RubiksCube.Zaxis] = "horizontal",
	[Storage.DesertQuestTwo.Puzzles.RubiksCube.Top] = "top",
}

local function scrambleCube()
	local low, high = FindMinMaxKey(leverAidToFaceName)
	for _ = 1, 30 do
		local aid = math.random(low, high)
		local faceName = leverAidToFaceName[aid]
		rotateCube(faceName)
	end
end

function InitializeDQ2RubiksCube()
	removeCubeFromMap()
	scrambleCube()
	renderCubeOnMap()
end

local function cubeIsCompleted()
	for _, face in pairs(currentCubeFaceState) do
		local firstId = face[1]
		for _, id in pairs(face) do
			if firstId ~= id then
				return false
			end
		end
	end
	return true
end

local lever = Action()
function lever.onUse(creature, item, _, _, _, _)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	local faceName = leverAidToFaceName[item:getActionId()]
	rotateCube(faceName)

	if cubeIsCompleted() then
		TrySpawnDQ2progressChest("RubiksCube")
	end
	removeCubeFromMap()
	renderCubeOnMap()
	return false
end

for _, value in pairs(Storage.DesertQuestTwo.Puzzles.RubiksCube) do
	lever:aid(value)
end
lever:register()
end)
