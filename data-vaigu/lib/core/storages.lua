--[[
Reserved player action storage key ranges (const.h)
	It is possible to place the storage in a quest door, so the player who has that storage will go through the door

	Reserved player action storage key ranges (const.h at the source)
	[10000000 - 20000000]
	[1000 - 1500]
	[2001 - 2011]

	Others reserved player action/storages
	[100] = unmovable/untrade/unusable items
	[101] = use pick floor
	[102] = well down action
	[103-120] = others keys action
	[103] = key 0010
	[303] = key 0303
	[1000] = level door. Here 1 must be used followed by the level.
	Example: 1010 = level 10, 1100 = level 100

	Questline = Storage through the Quest
]]
local keyToOldactionid = {}

local scopeSeparator = "-"
function ExtendValues(tab, upperKeysStr)
	if type(tab) ~= "table" then
	else
		for key, value in pairs(tab) do
			if type(value) ~= "table" then
				logger.warn(T("[ExtendValues] final key :key: is not declared as table (value = :value:)", { key = upperKeysStr, value = value }))
			elseif next(value) then
				ExtendValues(value, upperKeysStr .. scopeSeparator .. key)
			else
				tab[key] = upperKeysStr .. scopeSeparator .. key
			end
		end
	end
end

function shizznit(tab, upperKeysStr)
	for key, value in pairs(tab) do
		if type(value) == "number" then
			keyToOldactionid[value] = upperKeysStr .. scopeSeparator .. key
		elseif type(value) == "table" and next(value) then
			shizznit(value, upperKeysStr .. scopeSeparator .. key)
		end
	end
end

function OldKeysToFile(tab, upperKeysStr)
	shizznit(Storage, "Storage")
	local file = io.open("key_to_old_actionid.lua", "w+")
	assert(file)
	local str = "tab = {\n"
	for action, strKey in pairs(keyToOldactionid) do
		str = str .. T(':action:: ":key:",\n', { action = action, key = strKey })
	end
	str = str .. "}"
	file:write(str)
	file:close()
end

local realStorage = {}
Storage = {}

setmetatable(Storage, {
	__index = function(_, k)
		return realStorage[k]
	end,
	__newindex = function(_, k, v)
		if realStorage[k] then
			logger.warn(T("[Storage::__newindex] Storage :k: has already been set to :v:", { k = k, v = tostring(realStorage[k]) }))
		end
		ExtendValues(v, "Storage" .. scopeSeparator .. k)
		if not next(v) then
			v = "Storage" .. scopeSeparator .. k
		end
		rawset(realStorage, k, v)
	end,
})

Storage.DailyRewardShrine = {
	ConsecutiveDaysStreak = {},
	ConsecutiveDaysStreakEndless = {},
	JokersCount = {},
	CollectionTokensCount = {},
	NextCollectTimestamp = {},
	PreviousCollectionTimestamp = {},
	StreakExpiryTimestamp = {},
	StreakExpiryNextNotifyTimestamp = {},
}

-- General storages
-- EmoteSpells Storage cannot be changed, it is set in source code
Storage.WarCooldown = {}
Storage.EmoteSpells = {}

-- Promotion Storage cannot be changed, it is set in source code
Storage.Promotion = {}

-- Reserved in Global.Storage.CombatProtectionStorage = {}
Storage.Factions = {}
-- unused TrainerRoom = {},
-- unused NpcSpawn = {},
Storage.ExerciseDummyExhaust = {}

Storage.TibiaDrome = {
	-- General Upgrades
	BestiaryBetterment = { TimeLeft = {}, LastActivatedAt = {} },
	CharmUpgrade = { TimeLeft = {}, LastActivatedAt = {} },
	KooldownAid = { LastActivatedAt = {} },
	StaminaExtension = { LastActivatedAt = {} },
	StrikeEnhancement = { TimeLeft = {}, LastActivatedAt = {} },
	WealthDuplex = { TimeLeft = {}, LastActivatedAt = {} },
	-- Resilience
	FireResilience = { TimeLeft = {}, LastActivatedAt = {} },
	IceResilience = { TimeLeft = {}, LastActivatedAt = {} },
	EarthResilience = { TimeLeft = {}, LastActivatedAt = {} },
	EnergyResilience = { TimeLeft = {}, LastActivatedAt = {} },
	HolyResilience = { TimeLeft = {}, LastActivatedAt = {} },
	DeathResilience = { TimeLeft = {}, LastActivatedAt = {} },
	PhysicalResilience = { TimeLeft = {}, LastActivatedAt = {} },
	-- Amplifications
	FireAmplification = { TimeLeft = {}, LastActivatedAt = {} },
	IceAmplification = { TimeLeft = {}, LastActivatedAt = {} },
	EarthAmplification = { TimeLeft = {}, LastActivatedAt = {} },
	EnergyAmplification = { TimeLeft = {}, LastActivatedAt = {} },
	HolyAmplification = { TimeLeft = {}, LastActivatedAt = {} },
	DeathAmplification = { TimeLeft = {}, LastActivatedAt = {} },
	PhysicalAmplification = { TimeLeft = {}, LastActivatedAt = {} },
}

Storage.VipSystem = {
	IsVip = {},
	OnlineCoinsGain = {},
	OnlineTokensGain = {},
}

-- Vaigu custom
Storage.Exercisedummy = { exaust = {} }
Storage.VampireHunter = {
	Rank = {},
}
Storage.BigfootsBurden = { -- Reserved 900 - 967
	QuestLine = {},
	QuestLineComplete = {},
	Test = {},
	Shooting = {},

	MelodyTone1 = {},
	MelodyTone2 = {},
	MelodyTone3 = {},
	MelodyTone4 = {},
	MelodyTone5 = {},
	MelodyTone6 = {},
	MelodyTone7 = {},

	MelodyStatus = {},

	Rank = {},

	MissionCrystalKeeper = {},
	CrystalKeeperTimout = {},
	RepairedCrystalCount = {},

	MissionRaidersOfTheLostSpark = {},
	ExtractedCount = {},
	RaidersOfTheLostSparkTimeout = {},

	MissionExterminators = {},
	ExterminatedCount = {},
	ExterminatorsTimeout = {},

	MissionMushroomDigger = {},
	MushroomCount = {},
	MushroomDiggerTimeout = {},

	MissionMatchmaker = {},
	MatchmakerStatus = {},
	MatchmakerTimeout = {},

	MissionTinkersBell = {},
	GolemCount = {},
	TinkerBellTimeout = {},

	MissionSporeGathering = {},
	SporeCount = {},
	SporeGatheringTimeout = {},

	MissionGrindstoneHunt = {},
	GrindstoneStatus = {},
	GrindstoneTimeout = {},

	WarzoneStatus = {},
	Warzone1Access = {},
	Warzone2Access = {},
	Warzone3Access = {},

	Warzone1Reward = {},
	Warzone2Reward = {},
	Warzone3Reward = {},

	Warzone1Cooldown = {},
	Warzone2Cooldown = {},
	Warzone3Cooldown = {},

	Warzone1BossRoom = {},
	Warzone2BossRoom = {},
	Warzone3BossRoom = {},

	DeathstrikeTimer = {},
	GnomevilTimer = {},
	AbyssadorTimer = {},
}
Storage.TibiaTales = {
	RestInHallowedGround = { -- Reserved 3940 - 3957
		Questline = {},
		HolyWater = {},
		Graves = {
			Grave1 = {},
			Grave2 = {},
			Grave3 = {},
			Grave4 = {},
			Grave5 = {},
			Grave6 = {},
			Grave7 = {},
			Grave8 = {},
			Grave9 = {},
			Grave10 = {},
			Grave11 = {},
			Grave12 = {},
			Grave13 = {},
			Grave14 = {},
			Grave15 = {},
			Grave16 = {},
		},
	},
}
Storage.ForgottenKnowledge = { -- Reserved 10132 - 10170
	AccessDeath = {},
	AccessViolet = {},
	AccessEarth = {},
	AccessFire = {},
	AccessIce = {},
	AccessGolden = {},
	AccessLast = {},
	OldDesk = {},
	GirlPicture = {},
	SilverKey = {},
	Phial = {},
	BirdCounter = {},
	PlantCounter = {},
	GoldenServantCounter = {},
	DiamondServantCounter = {},
	AccessPortals = {},
	AccessMachine = {},
	LadyTenebrisTimer = {},
	LadyTenebrisKilled = {},
	LloydTimer = {},
	LloydKilled = {},
	ThornKnightTimer = {},
	ThornKnightKilled = {},
	DragonkingTimer = {},
	DragonkingKilled = {},
	HorrorTimer = {},
	HorrorKilled = {},
	TimeGuardianTimer = {},
	TimeGuardianKilled = {},
	LastLoreTimer = {},
	LastLoreKilled = {},
	BirdCage = {},
	AccessLavaTeleport = {},
	Ivalisse = {},
	Chalice = {},
	Tomes = {},
	BabyDragon = {},
	SpiderWeb = {},
}
Storage.ElementalSphere = { -- Reserved 10200 - 10203
	QuestLine = {},
	BossStorage = {},
	MachineGemCount = {},
	LordSkin = {},
}
Storage.TheApeCity = { -- Reserved 12120 - 12152
	Started = {},
	QuestProgress = {},
	WhisperMoss = {},
	TombWall = {},
	WitchesCapStart = {},
	CampfireMission = {},
	HolyApeHair = {},
	Questline = {}, -- Storage through the Quest
	DworcDoor = {},
	ChorDoor = {},
	ParchmentDecyphering = {},
	FibulaDoor = {},
	WitchesCapSpot = {},
	WitchesCapSpotTimer = {},
	CasksDoor = {},
	Casks = {},
	SnakeDestroyer = {},
	ShamanOutfit = {},
	DeepBanutaDoor = {},
}
Storage.TheDreamCourts = { -- 12200-12300
	QuestLine = {},
	WardStones = {
		Stone1 = {},
		Stone2 = {},
		Stone3 = {},
		Stone4 = {},
		Stone5 = {},
		Stone6 = {},
		Stone7 = {},
		Stone8 = {},
		WardStones = {},
	},
	CathedralWords = {
		Word1 = {},
		Word2 = {},
		Word3 = {},
		Word4 = {},
		CathedralWords = {},
	},
	KilledBosses = {},
	FacelessKilled = {},
	ElvenParchment = {},
	AnatomyBook = {},
	Rosebush = {},
	Recipe = {},
	RosebushPlant = {},
	MinotaurSkull = {},
	OrcSkull = {},
	TrollSkull = {},
	TableDoor = {},
	Painting = {},
	MinotaurSkullUse = {},
	OrcSkullUse = {},
	TrollSkullUse = {},
	AllSkullUsed = {},
	LastDoor = {},
	StrickenMission = {},
	StrickenDoor = {},
	Tukh1 = {},
	Tukh2 = {},
	DoorKeys = {},
	DreamBossTimer = {},
	FacelessTimer = {},
	NightmareBeastTimer = {},
}
Storage.LiquidBlackQuest = { -- Reserved 24000 - 24001
	Questline = {},
	Visitor = {},
}
Storage.DeeplingsWorldChange = { -- Reserved 25000 - 25004
	Questline = {},
	FirstStage = {},
	SecondStage = {},
	ThirdStage = {},
	Crystal = {},
}
Storage.HotCuisineQuest = { -- Reserved 50022 - 50028
	QuestStart = {},
	CurrentDish = {},
	QuestLog = {},
	CookbookDoor = {},
}
Storage.DeeplingBosses = { -- Reserved 50070 - 50080
	Jaul = {},
	Tanjis = {},
	Obujos = {},
	DailyBossLockout = {},
}
Storage.Ferumbras = { -- Reserved 60011 - 60028
	Plagirath48 = {},
	Zamulosh48 = {},
	Mazoran48 = {},
	Razzagorn48 = {},
	Ragiaz48 = {},
	Tarbaz48 = {},
	Shulgrax48 = {},
	FerumbrasMortal48 = {},
	BossCountPlagirath = {},
	BossCountZamulosh = {},
	BossCountMazoran = {},
	BossCountRazzagorn = {},
	BossCountRagiaz = {},
	BossCountTarbaz = {},
	BossCountShulgrax = {},
	Reward = {},
	ShattererEntry = {},
	EssencesBringed = {},
	PlagirathTp = {},
	ZamuloshTp = {},
	MazoranTp = {},
	RazzagornTp = {},
	RagiazTp = {},
	TarbazTp = {},
	ShulgraxTp = {},
	FerumbrasMortalTp = {},
}
Storage.SvargrondArena = { -- Reserved 1100 - 1101, 50140 - 50142, 26300, 27300, 28300, 1103, 1105, 1107, 26100, 27100, 28100
	Arena = {},
	Pit = {},

	QuestLogGreenhorn = {},
	QuestLogScrapper = {},
	QuestLogWarlord = {},

	RewardGreenhorn = {},
	RewardScrapper = {},
	RewardWarlord = {},

	TrophyGreenhorn = {},
	TrophyScrapper = {},
	TrophyWarlord = {},

	-- Reward Doors
	Greenhorn = {},
	Scrapper = {},
	Warlord = {},
}
Storage.QuestChests = { -- Reserved 2212 - 2214, 9172 - 9174, 50033 - 50034
	OldParchment = {},
}
Storage.PitsOfInferno = {
	ShortcutHub = {},
	ShortcutLevers = {},
	Pumin = {},

	WeaponReward = {},

	ThroneInfernatil = {},
	ThroneTafariel = {},
	ThroneVerminor = {},
	ThroneApocalypse = {},
	ThroneBazir = {},
	ThroneAshfalor = {},
	ThronePumin = {},
	OneThrone = {},
}
Storage.TheSecretLibrary = {
	TheOrderOfTheFalcon = {
		OberonTimer = {},
		PreceptorKilled = {},
		GaunderKilled = {},
		DominusKilled = {},
		SoerenKilled = {},
		OberonKilled = {},
	},
}
Storage.Grimvale = {
	-- Reserved storage from 50380 - 50399
	SilverVein = {},
	WereHelmetEnchant = {},
}
-- HeartOfDestruction = {
-- 14320
-- 14321
-- 14322
-- 14323
-- 14324
-- 14325
-- 14329
-- 14330
-- 14331
-- 14332
-- 14333
-- 14334
-- 14335
-- 14336
-- 14337
-- 60814
-- 60828
-- 60835
-- }
-- ====== CUSTOM ======--
-- Krol szczurow
Storage.BigKlamoty = {
	Mission01 = {},
	Mission02 = {},
	Mission03 = {},
	Mission04 = {},
	Mission05 = {},
	Mission06 = {},
}
Storage.SpojrzenieTysiacaYtongow = {
	Mission01 = {},
	Mission02 = {},
	Mission03 = {},
	Mission04 = {},
	Mission05 = {},
	Mission06 = {},
}
Storage.SprawiedliwyWobecNarodow = {
	Mission01 = {},
	Mission02 = {},
	Mission03 = {},
	Mission04 = {},
	Mission05 = {},
	Mission06 = {},
	Cuckoo = {},
	Lamp = {},
}

Storage.FreeTravels = {}
Storage.OldManFrostMammoth = {}
Storage.Fnaf = {
	LeftDoor = {},
	RightDoor = {},
	LeftLight = {},
	RightLight = {},
	ControlPanel = {},
}

Storage.ZombieEvent = { Joined = {} }
Storage.GrimEvent = { Joined = {} }
Storage.LMS = { Joined = {} }
Storage.BombermanEvent = {
	Joined = {},
	bombermanPoints = {},
	bombermanBombRadius = {},
	bombermanPlayerBombs = {},
	bombermanTrackBombs = {},
	bombermanExhaustion = {},
	bombermanSpeedBoost = {},
}
Storage.MeteorEvent = { Joined = {}, meteorSpeedBoost = {}, meteorTimer = {} }

-- isTraining = {},
Storage.OrcKingGreeting = {}

-- 200-279 task ids
Storage.FirstTaskActive = {}
Storage.SecondTaskActive = {}
Storage.FirstTaskDoneTaskActive = {}
Storage.AnyTaskDone = {}

-- 299-304 arena
Storage.HydraEggQuest = {}
Storage.SamsOldBackpack = {}
Storage.dailyDone = {}
Storage.Dragonfetish = {}
Storage.EdronRopeQuest = {}
-- demonKillCounter = {},
-- demonDeathCounter = {},
Storage.wagonTicket = {}
-- 1201-1261 - daily task ids
Storage.AnnihilatorDone = {}
-- dhqchest = {},
-- dhqchest = {},
Storage.EruaranGreeting = {}
-- 5000-5200 quest_chests.lua
Storage.GhostShipQuest = {}
-- 6000-6500 chest uids
-- 9008 - 9031 quest chest oak
Storage.PauperizerKill = {}
-- 10001-10079 taski bossy
-- 10101-10201 taski counter
Storage.ShrimpBake = {}
Storage.ShrimpScript = {}
Storage.GetBless = {}
Storage.Rekompensata = {}
Storage.Shipmodel = {}
-- 20000 ~ 20100 achievements
Storage.IzcandarTimer = {}
Storage.BrokulTimer = {}
Storage.WereBossKill = {}
Storage.FlamingOrchidKilled = {}
Storage.PrinceDrazzakTime = {}
Storage.KroazurTimer = {}
Storage.DailyBossReward = {}
-- arena = {}
-- arena = {}
-- arena = {}
-- arena = {}
Storage.allowWTstorage = {}
Storage.destroLock = {}
Storage.EmoteSpell = {}
Storage.JumpExhaust = {}
Storage.StartHealpot = {}
Storage.madSheepSummon = {}
-- StoreExaust = {},
-- FamiliarSummon = {},
-- FamiliarSummonEvent10 = {},
-- FamiliarSummonEvent60 = {},
Storage.StartManapot = {}
Storage.FreeQuests = {}
Storage.PremiumAccount = {}
Storage.ShrineEntrance = {}

-- events
Storage.bombermanPoints = {}
Storage.bombermanInGame = {}
Storage.bombermanBombRadius = {}
Storage.bombermanPlayerBombs = {}
Storage.bombermanTrackBombs = {}
Storage.bombermanExhaustion = {}
Storage.bombermanSpeedBoost = {}
Storage.spleefInGame = {}
Storage.snowballUse = {}

-- leaderboards
Storage.boardDelay = {}

Storage.overallWins = {}
Storage.meteorWins = {}
Storage.zombieWins = {}
Storage.bombermanWins = {}
Storage.grimWins = {}

Storage.overallMatches = {}
Storage.meteorMatches = {}
Storage.zombieMatches = {}
Storage.bombermanMatches = {}
Storage.grimMatches = {}

Storage.overallPoints = {}
Storage.meteorPoints = {}
Storage.zombiePoints = {}
Storage.grimPoints = {}

Storage.zombieRecord = {}
Storage.meteorRecord = {}
Storage.grimRecord = {}
-- events

Storage.MemoryPath = {
	Joined = {},
	AreaRow = {},
	AreaNumber = {},

	-- pathSpeedBoost = {},
	-- pathTimer = {},
}
Storage.pathmanWins = {}
Storage.pathmanMatches = {}
Storage.pathmanPoints = {}
Storage.pathmanRecord = {}

Storage.CrossRoadJoined = {}
Storage.CrossRoadWins = {}
Storage.CrossRoadMatches = {}
Storage.CrossRoadPoints = {}
Storage.CrossRoadRecord = {}

Storage.StoneRunJoined = {}
Storage.StoneRunWins = {}
Storage.StoneRunMatches = {}
Storage.StoneRunPoints = {}
Storage.StoneRunRecord = {}
Storage.StoneRunSpeedBoost = {}
Storage.StoneRunCheckpoint = {}
Storage.StoneRunCheckpointTime = {}

Storage.BloodHerbQuest = {}
Storage.RentedHorseTimer = {}
Storage.firstMageWeapon = {}
Storage.powerfulImbue = {}
Storage.DeeperBanutaShortcut = {}
Storage.KawillBlessing = {}
Storage.SwampDiggingTimeout = {}
-- free 50144
Storage.HydraNest = {}
Storage.HydraNest2 = {}
Storage.MeadVial = {}
Storage.Seashell = {}
Storage.IcePickIcicle = {}
Storage.MaryzaCookbook = {}
-- combatProtectionStorage = {},
Storage.loginProtection = {}
Storage.expRatex3 = {}
Storage.ForceBaseLoot = {}
Storage.templeScroll = {}
Storage.playerLanguage = {}
Storage.streakLostMsg = {}
Storage.marksSet = {}
Storage.santaPresent = {}
Storage.allowHealthRegen = {}
Storage.allowManaRegen = {}
Storage.GoldenOutfit = {
	Chest = {},
	Boots = {},
	Helmet = {},
	Full = {},
}
Storage.Uniwheel = {}
Storage.Tinlizzard = {}
-- blockMovementStorage = {},
Storage.kdCounterKills = {}
Storage.kdCounterDeaths = {}
-- News quest development
-- These new structure will reserve ranges for each version. Please use accordingly.
-- New storages
Storage.Quest = {
	Key = {
		ID0010 = {},
		ID0808 = {},
		ID0909 = {},
		ID3001 = {},
		ID3002 = {},
		ID3003 = {},
		ID3004 = {},
		ID3005 = {},
		ID3006 = {},
		ID3007 = {},
		ID3008 = {},
		ID3012 = {},
		ID3142 = {},
		ID3301 = {},
		ID3302 = {},
		ID3303 = {},
		ID3304 = {},
		ID3520 = {},
		ID3600 = {},
		ID3610 = {},
		ID3620 = {},
		ID3666 = {},
		ID3667 = {},
		ID3700 = {},
		ID3702 = {},
		ID3800 = {},
		ID3801 = {},
		ID3802 = {},
		ID3899 = {},
		ID3940 = {},
		ID3980 = {},
		ID4055 = {},
		ID4502 = {},
		ID4601 = {},
		ID4603 = {},
		ID5010 = {},
		ID6010 = {},
	},
	-- Start of quests per version
	-- Use the reserved storage keys accordingly
	KeysUpdate = {},
	U5_0 = { -- update 5.0 - Reserved Storages 40000
		DeeperFibulaKey = {},
	},
	PreU6_0 = { -- update pre-6.0 - Reserved Storages 40001 - 40020
		OrnamentedShield = {
			Rewards = {
				OrnamentedShield = {},
			},
		},
	},
	U6_1 = { -- update 6.1 - Reserved Storages 40031 - 40050
		EmperorsCookies = {
			Rewards = {
				Cookies = {},
			},
		},
		OrcFortress = {
			Rewards = {
				KnightAxe = {},
				KnightArmor = {},
				FireSword = {},
			},
		},
		Panpipe = {
			Rewards = {
				Panpipe = {},
			},
		},
	},
	U6_2 = { -- update 6.2 - Reserved Storages 40051 - 40070
		Draconia = {
			Rewards = {
				BagWithWeapons = {},
				BagWithAmulets = {},
			},
		},
	},
	U6_4 = { -- update 6.4 - Reserved Storages 40071 - 40110
		BerserkerTreasure = {
			Rewards = {
				WhitePearls = {},
			},
		},
		DemonHelmet = {
			Rewards = {
				SteelBoots = {},
				DemonHelmet = {},
				DemonShield = {},
			},
		},
		OutlawCampQuest = {},
	},
	U7_1 = { -- update 7.1 - Reserved Storages 40121 - 40140
		DragonTower = {
			Rewards = {
				Backpack1 = {},
				Backpack2 = {},
			},
		},
	},
	U7_2 = { -- update 7.2 - Reserved Storages 40141 - 40200
		Behemoth = {
			Bag = {},
			GuardianHalberd = {},
			DemonShield = {},
			GoldenArmor = {},
		},
		ParchmentRoom = {
			Bag = {},
		},
		TheQueenOfTheBanshees = {
			Reward = {
				StoneSkinAmulet = {},
				StealthRing = {},
				TowerShield = {},
				GiantSword = {},
				BootsOfHaste = {},
				PlatinumCoin = {},
			},
			QuestLine = {},
			FirstSeal = {},
			FirstSealDoor = {},
			SecondSeal = {},
			SecondSealDoor = {},
			ThirdSeal = {},
			ThirdSealDoor = {},
			ThirdSealWarlocks = {},
			FourthSeal = {},
			FourthSealDoor = {},
			FifthSeal = {},
			FifthSealDoor = {},
			FifthSealTile = {},
			SixthSeal = {},
			SixthSealDoor = {},
			LastSeal = {},
			LastSealDoor = {},
			BansheeDoor = {},
			FinalBattle = {},
		},
	},
	U7_24 = { -- update 7.24 - Reserved Storages 40201 - 40350
		FamilyBrooch = {
			Brooch = {},
		},
		MadMageRoom = {
			QuestLine = {},
			APrisoner = {},
		},
		TheAnnihilator = {
			Reward = {},
		},
		TheParadoxTower = {
			QuestLine = {},
			TheFearedHugo = {},
			FirstParadoxAcess = {},
			FavoriteColour = {},
			Mathemagics = {},
			Reward = {
				Egg = {},
				Gold = {},
				Talon = {},
				Wand = {},
			},
		},
		ThePostmanMissions = {
			Mission01 = {},
			Mission02 = {},
			Mission03 = {},
			Mission04 = {},
			Mission05 = {},
			Mission06 = {},
			Mission07 = {},
			Mission08 = {},
			Mission09 = {},
			Mission10 = {},
			Rank = {},
			Door = {},
			TravelCarlin = {},
			TravelEdron = {},
			TravelVenore = {},
			TravelCormaya = {},
			MeasurementsBenjamin = {},
			MeasurementsKroox = {},
			MeasurementsDove = {},
			MeasurementsLiane = {},
			MeasurementsChrystal = {},
			MeasurementsOlrik = {},
		},
		TheWhiteRavenMonastery = {
			QuestLog = {},
			Passage = {},
			Diary = {},
			Door = {},
		},
		VoodooDoll = {},
	},
	U7_3 = { -- update 7.3 - Reserved Storages 40351 - 40400
		TheMedusaQuest = {},
		SerpentineTower = {
			WhitePearl = {},
		},
	},
	U7_4 = { -- update 7.4 - Reserved Storages 40401 - 40600
		TheAncientTombs = {
			DefaultStart = {},
			VashresamunInstruments = {},
			VashresamunsDoor = {},
			MorguthisBlueFlameStorage1 = {},
			MorguthisBlueFlameStorage2 = {},
			MorguthisBlueFlameStorage3 = {},
			MorguthisBlueFlameStorage4 = {},
			MorguthisBlueFlameStorage5 = {},
			MorguthisBlueFlameStorage6 = {},
			MorguthisBlueFlameStorage7 = {},
			OmrucsTreasure = {},
			ThalasTreasure = {},
			DiphtrahsTreasure = {},
			MahrdisTreasure = {},
			VashresamunsTreasure = {},
			MorguthisTreasure = {},
			RahemosTreasure = {},
			ThalasSwitchesGlobalStorage = {},
			DiprathSwitchesGlobalStorage = {},
			AshmunrahSwitchesGlobalStorage = {},
			Diprath_sign1 = {},
			Diprath_sign2 = {},
			Diprath_sign3 = {},
			Diprath_sign4 = {},
			Diprath_sign5 = {},
			Diprath_sign6 = {},
			Diprath_sign7 = {},
			Diprath_sign8 = {},
		},
		DjinnWar = {
			Factions = {},
			-- Reserved storage from 50620 - 50649
			Faction = {
				Greeting = {},
				MaridDoor = {},
				EfreetDoor = {},
			},
			RecievedLamp = {},
			-- Blue djinn
			MaridFaction = {
				Start = {},
				Mission01 = {},
				Mission02 = {},
				RataMari = {},
				Mission03 = {},
				DoorToLamp = {},
				DoorToEfreetTerritory = {},
			},
			-- Green djinn
			EfreetFaction = {
				Start = {},
				Mission01 = {},
				Mission02 = {},
				Mission03 = {},
				DoorToLamp = {},
				DoorToMaridTerritory = {},
			},
		},
	},
	U7_5 = { -- update 7.5 - Reserved Storages 40601 - 40610
		ElephantTusk = {},
		SamsOldBackpack = {
			SamsOldBackpackNpc = {},
			SamsOldBackpackDoor = {},
		},
	},
	U7_6 = { -- update 7.6 - Reserved Storages 40611 - 40760
		HydraEggQuest = {},
		TheApeCity = {
			Started = {},
			Questline = {},
			DworcDoor = {},
			ChorDoor = {},
			ParchmentDecyphering = {},
			FibulaDoor = {},
			WitchesCapSpot = {},
			CasksDoor = {},
			Casks = {},
			HolyApeHair = {},
			SnakeDestroyer = {},
			ShamanOufit = {},
			TheLargeAmphoras1 = {},
			TheLargeAmphoras2 = {},
			TheLargeAmphoras3 = {},
			TheLargeAmphoras4 = {},
			TheLargeAmphorasCooldown = {},
		},
		ExplorerSociety = {
			QuestLine = {},
			SpectralStone = {},
			JoiningTheExplorers = {},
			TheIceDelivery = {},
			TheButterflyHunt = {},
			ThePlantCollection = {},
			TheLizardUrn = {},
			TheBonelordSecret = {},
			TheOrcPowder = {},
			CalassaQuest = {},
			TheMemoryStone = {},
			TheRuneWritings = {},
			TheEctoplasm = {},
			TheSpectralDress = {},
			TheSpectralStone = {},
			TheAstralPortals = {},
			TheIslandofDragons = {},
			TheIceMusic = {},
			BansheeDoor = {},
			BonelordsDoor = {},
			CalassaDoor = {},
			MemoryStoneDoor = {},
			ElvenDoor = {},
			OrcDoor = {},
			ChorurnDoor = {},
			DwacatraDoor = {},
			FamilyBroochDoor = {},
			TheElvenPoetry = {},
			SpectralStoneDoor = {},
			IceMusicDoor = {},
			ExplorerBrooch = {},
			SkullOfRatha = {
				Bag1 = {},
				Bag2 = {},
			},
			GiantSmithHammer = {
				Talon = {},
				Hammer = {},
				GoldCoin = {},
			},
			Books = {
				Cyclops = {},
				Hengis = {},
			},
		},
		OldParchment = {},
		WhisperMoss = {},
	},
	U7_8 = { -- update 7.8 - Reserved Storages 40761 - 41000
		AssassinOutfits = {
			AssassinBaseOutfit = {},
			AssassinFirstAddon = {},
			AssassinSecondAddon = {},
		},
		BarbarianOutfits = {
			BarbarianAddon = {},
			BarbarianAddonWaitTimer = {},
		},
		BeggarOutfits = {
			BeggarOutfit = {},
			BeggarOutfitTimer = {},
			BeggarFirstAddonDoor = {},
			BeggarSecondAddon = {},
			BeggarOutfitTimerAddon = {},
		},
		CitizenOutfitsRook = {
			MissionHatRook = {},
			AddonHatRook = {},
			MissionBackpackRook = {},
			AddonBackpackRook = {},
			AddonBackpackRookTimer = {},
		},
		CitizenOutfits = {
			MissionHat = {},
			AddonHat = {},
			MissionBackpack = {},
			AddonBackpack = {},
			AddonBackpackTimer = {},
		},
		DruidOutfitsRook = {
			DruidBodyAddonRook = {},
		},
		DruidOutfits = {
			DruidHatAddon = {},
			DruidBodyAddon = {},
			DruidAmuletDoor = {},
			GriffinclawFlower = {},
			CeironsWaterskin = {},
			WolfToothChain = {},
		},
		HunterOutfits = {
			HunterMusicSheet01 = {},
			HunterMusicSheet02 = {},
			HunterMusicSheet03 = {},
			HunterMusicSheet04 = {},
			HunterBodyAddon = {},
			HunterHatAddon = {},
			Hunter = {
				AddonGlove = {},
				AddonHat = {},
			},
			ElaneCrossbow = {},
		},
		KnightOutfits = {
			AddonSword = {},
			MissionHelmet = {},
			AddonHelmet = {},
			AddonHelmetTimer = {},
			RamsaysHelmetDoor = {},
			RamsaysHelmetChest = {},
		},
		MageAndSummonerOutfits = {
			AddonWand = {},
			AddonBelt = {},
			MissionHatCloak = {},
			AddonHatCloak = {},
			AddonWandTimer = {},
		},
		MarlinTrophy = {},
		NoblemanOutfits = {
			NoblemanFirstAddon = {},
			NoblemanSecondAddon = {},
		},
		ObsidianKnife = {},
		OrientalOutfits = {
			FirstOrientalAddon = {},
			SecondOrientalAddon = {},
			OrientalDoor = {},
			CoralComb = {},
		},
		PirateOutfits = {
			PirateBaseOutfit = {},
			PirateSabreAddon = {},
			PirateHatAddon = {},
		},
		ShamanOutfits = {
			AddonStaffMask = {},
			MissionStaff = {},
			MissionMask = {},
		},
		FriendsAndTraders = {
			DefaultStart = {},
			TheSweatyCyclops = {},
			TheMermaidMarina = {},
			TheBlessedStake = {},
			TheBlessedStakeWaitTime = {},
		},
		TheShatteredIsles = {
			DefaultStart = {},
			TheGovernorDaughter = {},
			TheErrand = {},
			AccessToMeriana = {},
			APoemForTheMermaid = {},
			ADjinnInLove = {},
			AccessToLagunaIsland = {},
			AccessToGoroma = {},
			Shipwrecked = {},
			DragahsSpellbook = {},
			TheCounterspell = {},
			ReputationInSabrehaven = {},
			RaysMission1 = {},
			RaysMission2 = {},
			RaysMission3 = {},
			RaysMission4 = {},
			AccessToNargor = {},
			TortoiseEggNargorDoor = {},
			TortoiseEggNargorTime = {},
			YavernDoor = {},
			TavernMap1 = {},
			TavernMap2 = {},
			TavernMap3 = {},
		},
		WarriorOutfits = {
			WarriorShoulderAddon = {},
			WarriorSwordAddon = {},
			WarriorShoulderTimer = {},
		},
		WizardOutfits = {},
	},
	U7_9 = { -- update 7.9 - Reserved Storages 41001 - 41150
		DreamersChallenge = {
			LeverNightmare1 = {},
			LeverNightmare2 = {},
			LeverNightmare3 = {},
			LeverBrotherhood1 = {},
			LeverBrotherhood2 = {},
			LeverBrotherhood3 = {},
			TicTac = {},
			BPLongSword = {},
			ChestBook = {},
			ChestsWine = {},
			Chests3SmallDiamond = {},
		},
		NightmareOutfits = {
			Outfits = {},
			Door = {},
			KnightwatchTowerDoor = {},
		},
		BrotherhoodOutfits = {
			Outfits = {},
			Door = {},
		},
		ThePitsOfInferno = {
			ShortcutHubDoor = {},
			ShortcutLeverDoor = {},
			Pumin = {},
			ThroneInfernatil = {},
			ThroneTafariel = {},
			ThroneVerminor = {},
			ThroneApocalypse = {},
			ThroneBazir = {},
			ThroneAshfalor = {},
			ThronePumin = {},
			ChestTible = {},
			CorpseBook = {},
			CorpsePirateBP = {},
			RewardChestBP = {},
			RewardChestPlatinumCoins = {},
			RewardChestFrozenStarlight = {},
			RewardChestStuffed = {},
			RewardChestSoftBoots = {},
			RewardChestStaffAvengerArbalest = {},
		},
	},
	U8_0 = { -- update 8.0 - Reserved Storages 41151 - 41350
		BarbarianArena = {
			Arena = {},
			PitDoor = {},
			QuestLogGreenhorn = {},
			QuestLogScrapper = {},
			QuestLogWarlord = {},
			RewardGreenhorn = {},
			RewardGreenhornWeapons = {},
			RewardGreenhornBP = {},
			RewardGreenhornPresent = {},
			RewardScrapper = {},
			RewardScrapperWeapons = {},
			RewardScrapperBP = {},
			RewardScrapperPresent = {},
			RewardWarlord = {},
			RewardWarlordWeapons = {},
			RewardWarlordBP = {},
			RewardWarlordPresent = {},
			TrophyGreenhorn = {},
			TrophyScrapper = {},
			TrophyWarlord = {},
			GreenhornDoor = {},
			ScrapperDoor = {},
			WarlordDoor = {},
		},
		BarbarianTest = {
			Questline = {},
			Mission01 = {},
			Mission02 = {},
			Mission03 = {},
			MeadTotalSips = {},
			MeadSuccessSips = {},
		},
		FishingBox = {},
		ShardsofAncientWinters = {
			Inukaya = {},
			Tyrsung = {},
			Okolnir = {},
			Helheim = {},
			FormorgarMines = {},
		},
		TheIceIslands = {
			Questline = {},
			Mission01 = {}, -- Befriending the Musher
			Mission02 = {}, -- Nibelor 1: Breaking the Ice
			Mission03 = {}, -- Nibelor 2: Ecological Terrorism
			Mission04 = {}, -- Nibelor 3: Artful Sabotage
			Mission05 = {}, -- Nibelor 4: Berserk Brewery
			Mission06 = {}, -- Nibelor 5: Cure the Dogs
			Mission07 = {}, -- The Secret of Helheim
			Mission08 = {}, -- The Contact
			Mission09 = {}, -- Formorgar Mines 1: The Mission
			Mission10 = {}, -- Formorgar Mines 2: Ghostwhisperer
			Mission11 = {}, -- Formorgar Mines 3: The Secret
			Mission12 = {}, -- Formorgar Mines 4: Retaliation
			PaintSeal = {},
			SulphurLava = {},
			SporesMushroom = {},
			FrostbiteHerb = {},
			FlowerCactus = {},
			FlowerBush = {},
			MemoryCrystal = {},
			Obelisk01 = {},
			Obelisk02 = {},
			Obelisk03 = {},
			Obelisk04 = {},
			yakchalDoor = {},
			HuskyKill = {},
			HuskyKillStatus = {},
			FormorgarMinesDoor = {},
			FormorgarGlacierSkeleton = {},
			FormorgarGlacierChest = {},
			NorsemanOutfit = {},
			NoblemanFirstAddon = {},
			NoblemanSecondAddon = {},
			FormorgarMinesHoistSkeleton = {},
			FormorgarMinesHoistChest = {},
			PickAmount = {},
		},
	},
	U8_1 = { -- update 8.1 - Reserved Storages 41351 - 41650
		KissingAPig = {},
		KosheiTheDeathless = {
			RewardDoor = {},
			KosheiTheDeathlessLegs = {},
			KosheiTheDeathlessGold = {},
			KosheiTheDeathlessPlatinum = {},
			KosheiAmuletPart1 = {},
			KosheiAmuletPart2 = {},
			KosheiAmuletPart3 = {},
			KosheiAmuletPart4 = {},
		},
		RestInHallowedGround = {
			Questline = {},
			HolyWater = {},
			Graves = {
				Grave1 = {},
				Grave2 = {},
				Grave3 = {},
				Grave4 = {},
				Grave5 = {},
				Grave6 = {},
				Grave7 = {},
				Grave8 = {},
				Grave9 = {},
				Grave10 = {},
				Grave11 = {},
				Grave12 = {},
				Grave13 = {},
				Grave14 = {},
				Grave15 = {},
				Grave16 = {},
			},
		},
		SecretService = {
			Quest = {},
			TBIMission01 = {},
			AVINMission01 = {},
			CGBMission01 = {},
			TBIMission02 = {},
			AVINMission02 = {},
			CGBMission02 = {},
			TBIMission03 = {},
			AVINMission03 = {},
			CGBMission03 = {},
			TBIMission04 = {},
			AVINMission04 = {},
			CGBMission04 = {},
			TBIMission05 = {},
			AVINMission05 = {},
			CGBMission05 = {},
			TBIMission06 = {},
			AVINMission06 = {},
			CGBMission06 = {},
			Mission07 = {},
			RottenTree = {},
			AHX17L89 = {},
			FamilySignetRing = {},
			MagicSpellbook = {},
			BuildingPlans = {},
			SuspiciousDocuments = {},
			Book = {},
			RottenHeartOfTree = {},
			LotteryTicket = {},
			PoemScroll = {},
			IntelligenceReports = {},
		},
		StrongPotions = {
			Reward = {},
		},
		TibiaTales = {
			DefaultStart = {},
			UltimateBoozeQuest = {},
			AgainstTheSpiderCult = {},
			AritosTask = {},
			ToAppeaseTheMightyQuest = {},
			IntoTheBonePit = {},
			TheExterminator = {},
			AritosTaskDoor = {},
		},
		TheTravellingTrader = {
			Mission01 = {},
			Mission02 = {},
			Mission03 = {},
			Mission04 = {},
			Mission05 = {},
			Mission06 = {},
			Mission07 = {},
		},
		ToBlindTheEnemy = {
			Questline = {},
			DwarvenShield = {},
			MorningStar = {},
			BP1 = {},
			BP2 = {},
		},
		ToOutfoxAFoxQuest = {
			Questline = {},
			MiningHelmet = {},
		},
		TowerDefenceQuest = {
			Questline = {},
			Door = {},
		},
		WaterfallQuest = {},
		WhatAFoolishQuest = {
			Questline = {},
			Mission1 = {},
			Mission2 = {},
			Mission3 = {},
			Mission4 = {},
			Mission5 = {},
			Mission6 = {},
			Mission7 = {},
			Mission8 = {},
			Mission9 = {},
			Mission10 = {},
			Mission11 = {},
			PieBuying = {},
			PieBoxTimer = {},
			TriangleTowerDoor = {},
			EmperorBeardShave = {},
			JesterOutfit = {},
			WhoopeeCushion = {},
			QueenEloiseCatDoor = {},
			CatBasket = {},
			ScaredCarina = {},
			InflammableSulphur = {},
			SpecialLeaves = {},
			Cigar = {},
			Contract = {},
			CookieDelivery = {
				SimonTheBeggar = {},
				Markwin = {},
				Ariella = {},
				Hairycles = {},
				Djinn = {},
				AvarTar = {},
				OrcKing = {},
				Lorbas = {},
				Wyda = {},
				Hjaern = {},
			},
			OldWornCloth = {},
			LostDisguise = {},
			ScaredKazzan = {},
			MagicalWatch = {},
			BagBookKnife = {},
		},
	},
	U8_2 = { -- update 8.2 - Reserved Storages 41651 - 41900
		ElementalSpheres = {
			QuestLine = {},
			BossStorage = {},
			MachineGemCount = {},
			BossRoom = {},
			KnightBoss = {},
			SorcererBoss = {},
			PaladinBoss = {},
			DruidBoss = {},
			Machine1 = {},
			Machine2 = {},
			Machine3 = {},
			Machine4 = {},
		},
		MachineryOfWar = {},
		TheBeginningQuest = {
			TutorialHintsStorage = {},
			SantiagoNpcGreetStorage = {},
			SantiagoQuestLog = {},
			ZirellaNpcGreetStorage = {},
			ZirellaQuestLog = {},
			CarlosNpcTradeStorage = {},
			CarlosNpcGreetStorage = {},
			CarlosQuestLog = {},
		},
		TheDemonOak = {
			Done = {},
			Progress = {},
			Squares = {},
			AxeBlowsBird = {},
			AxeBlowsLeft = {},
			AxeBlowsRight = {},
			AxeBlowsFace = {},
		},
		TheHuntForTheSeaSerpent = {
			QuestLine = {},
			SuccessSwitch = {},
			Bait = {},
			Direction = {},
			Access = {},
			FishForASerpent = {},
		},
		TheInquisitionQuest = {
			Questline = {},
			Mission01 = {},
			Mission02 = {},
			Mission03 = {},
			Mission04 = {},
			Mission05 = {},
			Mission06 = {},
			Mission07 = {},
			RewardDoor = {},
			GrofGuard = {},
			KulagGuard = {},
			MilesGuard = {},
			TimGuard = {},
			WalterGuard = {},
			StorkusVampiredust = {},
			EnterTeleport = {},
			Reward = {},
			RewardRoomText = {},
			WitchesGrimoire = {},
		},
		TheThievesGuildQuest = {
			Questline = {},
			Mission01 = {},
			Mission02 = {},
			Mission03 = {},
			Mission04 = {},
			Mission05 = {},
			Mission06 = {},
			Mission07 = {},
			Mission08 = {},
			Door = {},
			Reward = {},
			TheatreScript = {},
			RewardOasis = {},
			RewardBook = {},
			GoldenGoblet = {},
			CompromisingLetter = {},
			RewardEnd = {},
			StealFromThieves = {},
		},
		TrollSabotageQuest = {
			Questline = {},
			JumpTimer = {},
		},
		VampireHunterQuest = {
			Rank = {},
			Door = {},
			BloodSkull = {},
		},
		TheMutatedPumpkin = {
			Skinned = {},
		},
	},
	U8_4 = { -- update 8.4 - Reserved Storages 41901 - 42145
		BloodBrothers = {
			QuestLine = {},
			Mission01 = {},
			-- unused GarlicBread = {},
			Mission02 = {},
			Cookies = {
				Serafin = {},
				Lisander = {},
				Ortheus = {},
				Maris = {},
				Armenius = {},
			},
			Mission03 = {},
			Mission04 = {},
			VengothAccess = {},
		},
		InServiceOfYalahar = {
			TheWayToYalahar = {},
			Questline = {},
			Mission01 = {},
			Mission02 = {},
			Mission03 = {},
			Mission04 = {},
			Mission05 = {},
			Mission06 = {},
			Mission07 = {},
			Mission08 = {},
			Mission09 = {},
			Mission10 = {},
			SewerPipe01 = {},
			SewerPipe02 = {},
			SewerPipe03 = {},
			SewerPipe04 = {},
			DiseasedDan = {},
			DiseasedBill = {},
			DiseasedFred = {},
			AlchemistFormula = {},
			BadSide = {},
			GoodSide = {},
			MrWestDoor = {},
			MrWestStatus = {},
			TamerinStatus = {},
			MorikSummon = {},
			QuaraState = {},
			QuaraSplasher = {},
			QuaraSharptooth = {},
			QuaraInky = {},
			MatrixState = {},
			SideDecision = {},
			MatrixReward = {},
			NotesPalimuth = {},
			NotesAzerus = {},
			DoorToAzerus = {},
			DoorToBog = {},
			DoorToLastFight = {},
			DoorToMatrix = {},
			DoorToQuara = {},
			DoorToReward = {},
			LastFight = {},
			WarGolemsMachine1 = {},
			WarGolemsMachine2 = {},
			SearoutesAroundYalahar = {
				TownsCounter = {},
				AbDendriel = {},
				Darashia = {},
				Venore = {},
				Ankrahmun = {},
				PortHope = {},
				Thais = {},
				LibertyBay = {},
				Carlin = {},
			},
		},
		TheHiddenCityOfBeregar = {
			DefaultStart = {},
			WayToBeregar = {},
			OreWagon = {},
			GoingDown = {},
			JusticeForAll = {},
			GearWheel = {},
			SweetAsChocolateCake = {},
			RoyalRescue = {},
			TheGoodGuard = {},
			PythiusTheRotten = {},
			DoorNorthMine = {},
			DoorWestMine = {},
			DoorSouthMine = {},
			BrownMushrooms = {},
			TunnellingGuide = {},
			CorpseGoldIngot = {},
			CorpseSmallTopazes = {},
			CorpseRustedArmor = {},
			PrisonCellKey = {},
			BPTheUndeathStare = {},
			FirewalkerBoots = {},
		},
		TopOfTheCity = {},
	},
	U8_5 = { -- update 8.5 - Reserved Storages 42146 - 42550
		DarashiaDragon = {},
		HotCuisineQuest = {
			QuestStart = {},
			CurrentDish = {},
			QuestLog = {},
			CookbookDoor = {},
			LastInteractionDate2 = {},
			LastInteractionDate3 = {},
			LastInteractionDate4 = {},
			LastInteractionDate5 = {},
			LastInteractionDate6 = {},
			LastInteractionDate7 = {},
			LastInteractionDate8 = {},
			LastInteractionDate9 = {},
			LastInteractionDate10 = {},
			LastInteractionDate11 = {},
			LastInteractionDate12 = {},
			LastInteractionDate13 = {},
			LastInteractionDate14 = {},
			LastInteractionDate15 = {},
		},
		KillingInTheNameOf = {
			LugriNecromancers = {},
			BudrikMinos = {},
			MissionTiquandasRevenge = {},
			MissionDemodras = {},
			BossPoints = {},
			QuestLogEntry = {},
			PawAndFurRank = {},
			GreenDjinnTask = {},
			BlueDjinnTask = {},
			PirateTask = {},
			TrollTask = {},
			GoblinTask = {},
			RotwormTask = {},
			CyclopsTask = {},
			MonsterKillCount = {
				KillCount = {},
				-- Grizzly Adams
				CrocodileCount = {},
				BadgerCount = {},
				TarantulaCount = {},
				CarniphilasCount = {},
				StoneGolemCount = {},
				MammothCount = {},
				GnarlhoundCount = {},
				TerramiteCount = {},
				ApesCount = {},
				ThornbackTortoiseCount = {},
				GargoyleCount = {},
				IceGolemCount = {},
				QuaraScoutsCount = {},
				MutatedRatCount = {},
				AncientScarabCount = {},
				WyvernCount = {},
				LancerBeetleCount = {},
				WailingWidowCount = {},
				KillerCaimanCount = {},
				BonebeastCount = {},
				CrystalSpiderCount = {},
				MutatedTigerCount = {},
				UnderwaterQuarasCount = {},
				GiantSpiderCount = {},
				WerewolveCount = {},
				NightmareCount = {},
				HellspawnCount = {},
				HighClassLizardCount = {},
				StamporCount = {},
				BrimstoneBugCount = {},
				MutatedBatCount = {},
				HydraCount = {},
				SerpentSpawnCount = {},
				MedusaCount = {},
				BehemothCount = {},
				SeaSerpentsCount = {},
				HellhoundCount = {},
				GhastlyDragonCount = {},
				DrakenCount = {},
				DestroyerCount = {},
				UndeadDragonCount = {},
				DemonCount = {},
				-- Others
				GreenDjinnCount = {},
				BlueDjinnCount = {},
				PirateCount = {},
				MinotaurCount = {},
				NecromancerCount = {},
				TrollCount = {},
				GoblinCount = {},
				RotwormCount = {},
				CyclopsCount = {},
			},
			BossKillCount = {
				-- Grizzly Adams
				SnapperCount = {},
				HideCount = {},
				DeathbineCount = {},
				BloodtuskCount = {},
				ShardheadCount = {},
				EsmeraldaCount = {},
				FleshcrawlerCount = {},
				RibstrideCount = {},
				BloodwebCount = {},
				ThulCount = {},
				WidowCount = {},
				HemmingCount = {},
				TormentorCount = {},
				FlamebornCount = {},
				FazzrahCount = {},
				TromphonyteCount = {},
				ScuttlerCount = {},
				PayneCount = {},
				ManyCount = {},
				NoxiousCount = {},
				GorgoCount = {},
				StonecrackerCount = {},
				LeviathanCount = {},
				KerberosCount = {},
				EthershreckCount = {},
				PauperizerCount = {},
				BretzecutionerCount = {},
				ZanakephCount = {},
				TiquandasCount = {},
				DemodrasCount = {},
				-- Others
				NecropharusCount = {},
				FoxCount = {},
				PiratesCount = {},
				MerikhCount = {},
				FahimCount = {},
			},
			AltKillCount = {
				-- Grizzly Adams
				-- Apes
				KongraCount = {},
				MerlkinCount = {},
				SibangCount = {},
				-- Quara Scouts
				QuaraConstrictorScoutCount = {},
				QuaraHydromancerScoutCount = {},
				QuaramMntassinScoutCount = {},
				QuaraPincherScoutCount = {},
				QuaraPredatorScoutCount = {},
				-- Underwater Quara
				QuaraConstrictorCount = {},
				QuaraHydromancerCount = {},
				QuaraMantassinCount = {},
				QuaraPincherCount = {},
				QuaraPredatorCount = {},
				-- Nightmares
				NightmareCount = {},
				NightmareScionCount = {},
				-- High Class Lizards
				LizardChosenCount = {},
				LizardDragonPriestCount = {},
				LizardHighGuardCount = {},
				LizardLegionnaireCount = {},
				LizardZaogunCount = {},
				-- Sea Serpents
				SeaSerpentCount = {},
				YoungSeaSerpentCount = {},
				-- Drakens
				DrakenAbominationCount = {},
				DrakenEliteCount = {},
				DrakenSpellweaverCount = {},
				DrakenWarmasterCount = {},
				-- Others
				-- Minotaurs
				MinotaurCount = {},
				MinotaurGuardCount = {},
				MinotaurMageCount = {},
				MinotaurArcherCount = {},
				-- Necromancers and Priestesses
				NecromancerCount = {},
				PriestessCount = {},
				BloodPriestCount = {},
				BloodHandCount = {},
				ShadowPupilCount = {},
				-- Green Djinns or Efreets
				GreenDjinnCount = {},
				EfreetCount = {},
				-- Blue Djinns or Marids
				BlueDjinnCount = {},
				MaridCount = {},
				-- Pirates
				PirateMarauderCount = {},
				PirateCutthroadCount = {},
				PirateBuccaneerCount = {},
				PirateCorsairCount = {},
				-- Trolls
				TrollCount = {},
				TrollChampionCount = {},
				-- Goblins
				GoblinCount = {},
				GoblinScavengerCount = {},
				GoblinAssassinCount = {},
				-- Rotworms
				RotwormCount = {},
				CarrionWormnCount = {},
				-- Cyclops
				CyclopsCount = {},
				CyclopsDroneCount = {},
				CyclopsSmithCount = {},
			},
		},
		LoneMedusa = {},
		PilgrimageOfAshes = {},
		ShadowsOfYalahar = {},
		TheIsleOfEvil = {},
		TheLightbearer = {},
		TheScatterbrainedSorcerer = {},
		TreasureHunt = {},
	},
	U8_54 = { -- update 8.54 - Reserved Storages 42551 - 42950
		AnUneasyAlliance = {
			Questline = {},
			QuestDoor = {},
		}, -- 42551 - 42600
		ChildrenOfTheRevolution = {
			Questline = {},
			Mission00 = {}, -- Prove Your Worzz!
			Mission01 = {},
			Mission02 = {},
			Mission03 = {},
			Mission04 = {},
			Mission05 = {},
			SpyBuilding01 = {},
			SpyBuilding02 = {},
			SpyBuilding03 = {},
			StrangeSymbols = {},
			teleportAccess = {},
			ChestTomeOfKnowledge1 = {},
			FlaskOfExtraGreasyOil = {},
			ChestTomeOfKnowledge2 = {},
		},
		SeaOfLight = {
			Questline = {},
			Mission1 = {},
			Mission2 = {},
			Mission3 = {},
			StudyTimer = {},
			LostMinesCrystal = {},
		},
		TheNewFrontier = { -- 42701 - 42750
			Questline = {},
			FarmineFirstTravel = {},
			Mission01 = {},
			Mission02 = {
				{},
				Beaver1 = {},
				Beaver2 = {},
				Beaver3 = {},
			},
			Mission03 = {},
			Mission04 = {},
			Mission05 = {
				{},
				KingTibianus = {},
				Leeland = {},
				Angus = {},
				Wyrdin = {},
				Telas = {},
				Humgolf = {},
				LeelandKeyword = {},
				AngusKeyword = {},
				WyrdinKeyword = {},
				TelasKeyword = {},
				HumgolfKeyword = {},
			},
			Mission06 = {},
			Mission07 = {
				{},
				HiddenNote = {},
			},
			Mission08 = {},
			Mission09 = {
				{},
				ArenaDoor = {},
				RewardDoor = {},
			},
			Mission10 = {
				{},
				MagicCarpetDoor = {},
			},
			Reward = {
				Potions = {},
				GoldIngot = {},
				PigBank = {},
			},
			TomeofKnowledge = {},
			ZaoPalaceDoors = {}, -- 10th Tome: Zao Palace
			SnakeHeadTeleport = {}, -- 7th Tome: Snake Head Teleport
			CorruptionHole = {}, -- 8th Tome: Corruption Hole
			ChestTomeOfKnowledge1 = {},
			ChestTomeOfKnowledge2 = {},
		},
		TomesOfKnowledge = {
			OrcCamp = {},
			TheNewFrontier = {},
			UneasyAlliance = {},
			LizardCamp = {},
			TopTower = {},
			MortalCombat = {},
			Hills = {},
			ChildrenoftheRevolution = {},
			Arena = {},
			CobraHead = {},
			OrcRaid = {},
			ZaoPalace = {},
			ChestTomeOfKnowledge1 = {},
			ChestTomeOfKnowledge2 = {},
			ChestTomeOfKnowledge3 = {},
			ChestTomeOfKnowledge4 = {},
		},
		UnnaturalSelection = {
			Questline = {},
			Mission01 = {},
			Mission02 = {},
			Mission03 = {},
			Mission04 = {},
			Mission05 = {},
			Mission06 = {},
			DanceStatus = {},
		}, -- 42781 - 42830
	},
	U8_6 = { -- update 8.6 - Reserved Storages 42951 - 43200
		AFathersBurden = {
			QuestLog = {},
			Progress = {},
			Status = {},
			Sinew = {},
			Wood = {},
			Cloth = {},
			Silk = {},
			Crystal = {},
			Root = {},
			Iron = {},
			Scale = {},
			Corpse = {
				Scale = {},
				Sinew = {},
			},
		},
		AnInterestInBotany = {
			Questline = {},
			ChestDoor = {},
			BotanyAlmanach = {},
		},
		TheSpiritWillGetYou = {},
		WayfarerOutfits = {},
		WrathOfTheEmperor = {
			Questline = {},
			Mission01 = {},
			Mission02 = {},
			Mission03 = {},
			Mission04 = {},
			Mission05 = {},
			Mission06 = {},
			Mission07 = {},
			Mission08 = {},
			Mission09 = {},
			Mission10 = {},
			Mission11 = {},
			Mission12 = {},
			Message = {}, --1068
			GuardcaughtYou = {}, --1062
			ZumtahStatus = {}, --1066
			PrisonReleaseStatus = {}, --1067
			GhostOfAPriest01 = {}, --1070
			GhostOfAPriest02 = {}, --1071
			GhostOfAPriest03 = {}, --1072
			InterdimensionalPotion = {}, --1084
			BossStatus = {}, --1090
			-- unused platinumReward = {},
			-- unused backpackReward = {},
			MainReward = {},
			TeleportAccess = {
				Rebel = {},
				Zlak = {},
				Zizzle = {},
				SleepingDragon = {},
				InnerSanctum = {},
				AwarnessEmperor = {},
				Wote10 = {},
				BossRoom = {},
			},
			Chest100PlatinumCoins = {},
			ChestBag = {},
			ChestItems = {},
			Light01 = {},
			Light02 = {},
			Light03 = {},
			Light04 = {},
			Bosses = {
				Fury = {},
				Wrath = {},
				Scorn = {},
				Spite = {},
			},
		},
	},
	U8_61 = { -- update 8.61 - Reserved Storages 43201 - 43230
		RiseOfDevovorga = {},
	},
	U8_7 = { -- update 8.7 - Reserved Storages 43231 - 43350
		APieceOfCake = {},
		APiratesDeathToMe = {},
		AnnualAutumnVintage = {},
		Bewitched = {},
		DemonsLullaby = {},
		JackFutureQuest = {
			QuestLine = {},
			Furniture01 = {},
			Furniture02 = {},
			Furniture03 = {},
			Furniture04 = {},
			Furniture05 = {},
			Mother = {},
			Sister = {},
			Statue = {},
			LastMissionState = {},
		},
		LastCreepStanding = {},
		ResearchAndDevelopment = {},
		RottinWoodAndTheMarriedMen = {
			Questline = {},
			RottinStart = {},
			Trap = {},
			Corpse = {},
			Time = {},
			Mission03 = {},
			FirstTime = {},
		},
		SpiritHunters = {
			Mission01 = {},
			TombUse = {},
			CharmUse = {},
			NightstalkerUse = {},
			SouleaterUse = {},
			GhostUse = {},
		},
		TheColoursOfMagic = {},
	},
	U9_1 = { --update 9.1 - Reserved Storages 43351 - 43550
		AwashWorldChange = {},
		DemonWarsWorldChange = {},
		ElementalistOutfits = {
			Questline = {},
			Outfit = {},
			Addon1 = {},
			Addon2 = {},
		},
		HorseStationWorldChange = {
			Timer = {},
		},
		LooseEnds = {},
		OverhuntingWorldChange = {},
		SteamshipWorldChange = {},
		SwampFeverWorldChange = {},
		TheMagesTowerWorldChange = {},
		TheMummysCurseWorldChange = {},
		TheRookieGuard = {
			Questline = {},
			Mission01 = {},
			Mission02 = {},
			Mission03 = {},
			Mission04 = {},
			Mission05 = {},
			Mission06 = {},
			Mission07 = {},
			Mission08 = {},
			Mission09 = {},
			Mission10 = {},
			Mission11 = {},
			Mission12 = {},
			StonePileTimer = {},
			Catapults = {},
			RatKills = {},
			PoacherCorpse = {},
			LibraryChest = {},
			TrollChests = {},
			TunnelPillars = {},
			Sarcophagus = {},
			AcademyChest = {},
			KraknaknorkChests = {},
			TutorialDelay = {},
			LibraryDoor = {},
			UnholyCryptDoor = {},
			AcademyDoor = {},
			AcademyChestTimer = {},
			WarWolfDenChest = {},
			UnholyCryptChests = {},
			OrcFortressChests = {},
			Level8Warning = {},
		},
		TheirMastersVoiceWorldChange = {
			CurrentServantWave = {},
			ServantsKilled = {},
			SlimeGobblerTimeout = {},
			SlimeGobblerReceived = {},
		},
		ThornfireWorldChange = {},
		TwistedWatersWorldChange = {},
	},
	U9_4 = { -- update 9.4 - Reserved Storages 43551 - 43750
		BankRobberyMiniWorldChange = {},
		BoredMiniWorldChange = {},
		DeeplingsWorldChange = {},
		DownTheDrainMiniWorldChange = {},
		FireFromTheEarthMiniWorldChange = {},
		HiveBornWorldChange = {},
		InsectoidOutfits = {},
		KingsdayMiniWorldChange = {},
		LiquidBlackQuest = {
			Questline = {},
			Visitor = {},
		},
		LumberjackMiniWorldChange = {},
		NomadsMiniWorldChange = {},
		NoodlesIsGoneMiniWorldChange = {},
		OrientalTraderMiniWorldChange = {},
		RiverRunsDeepMiniWorldChange = {},
		StampedeMiniWorldChange = {},
		ThawingMiniWorldChange = {},
		WarAgainstTheHive = {},
	},
	U9_5 = { -- update 9.5 - Reserved Storages 43751 - 43850
		SpringIntoLife = {},
	},
	U9_60 = { -- update 9.60 - Reserved Storages 43851 - 44000
		BigfootsBurden = {
			QuestLine = {},
			Test = {},
			Shooting = {},
			QuestLineComplete = {},
			MelodyTone1 = {},
			MelodyTone2 = {},
			MelodyTone3 = {},
			MelodyTone4 = {},
			MelodyTone5 = {},
			MelodyTone6 = {},
			MelodyTone7 = {},
			MelodyStatus = {},
			Rank = {},
			MissionCrystalKeeper = {},
			CrystalKeeperTimout = {},
			RepairedCrystalCount = {},
			MissionRaidersOfTheLostSpark = {},
			ExtractedCount = {},
			RaidersOfTheLostSparkTimeout = {},
			MissionExterminators = {},
			ExterminatedCount = {},
			ExterminatorsTimeout = {},
			MissionMushroomDigger = {},
			MushroomCount = {},
			MushroomDiggerTimeout = {},
			MissionMatchmaker = {},
			MatchmakerStatus = {},
			MatchmakerIdNeeded = {},
			MatchmakerTimeout = {},
			MissionTinkersBell = {},
			GolemCount = {},
			TinkerBellTimeout = {},
			MissionSporeGathering = {},
			SporeCount = {},
			SporeGatheringTimeout = {},
			MissionGrindstoneHunt = {},
			GrindstoneStatus = {},
			GrindstoneTimeout = {},
			WarzoneStatus = {},
			Warzone1Access = {},
			Warzone2Access = {},
			Warzone3Access = {},
			Warzone1Reward = {},
			Warzone2Reward = {},
			Warzone3Reward = {},
			BossKills = {},
			DoorGoldenFruits = {},
			GnomedixMsg = {},
			Warzones = {},
			Weeper = {},
			Versperoth = {
				Battle = {},
				Health = {},
			},
			Mouthpiece = {},
		},
		DevovorgasEssenceMiniWorldChange = {},
		SpiderNestMiniWorldChange = {},
		WarpathMiniWorldChange = {},
	},
	U9_80 = { -- update 9.80 - Reserved Storages 44001 - 44100
		AdventurersGuild = {
			Stone = {},
			MagicDoor = {},
			CharosTrav = {},
			FreeStone = {
				Alia = {},
				Amanda = {},
				Brewster = {},
				Isimov = {},
				Kasmir = {},
				Kjesse = {},
				Lorietta = {},
				Maealil = {},
				Quentin = {},
				RockWithASoftSpot = {},
				Tyrias = {},
				Yberius = {},
				Rahkem = {},
			},
			QuestLine = {},
		},
		ChildOfDestiny = {},
		GoblinMerchant = {},
		VenoreDailyTasks = {},
	},
	U10_10 = { -- update 10.10 - Reserved Storages 44101 - 44300
		FuryGatesMiniWorldChange = {},
		HuntingForTokens = {},
		OpticordingSphere = {},
		SmallSapphire = {},
		TheGravediggerOfDrefia = {
			QuestStart = {},
			Mission01 = {},
			Mission02 = {},
			Mission03 = {},
			Mission04 = {},
			Mission05 = {},
			Mission06 = {},
			Mission07 = {},
			Mission08 = {},
			Mission09 = {},
			Mission10 = {},
			Mission11 = {},
			Mission12 = {},
			Mission13 = {},
			Mission14 = {},
			Mission15 = {},
			Mission16 = {},
			Mission17 = {},
			Mission18 = {},
			Mission19 = {},
			Mission20 = {},
			Mission21 = {},
			Mission22 = {},
			Mission23 = {},
			Mission24 = {},
			Mission25 = {},
			Mission26 = {},
			Mission27 = {},
			Mission28 = {},
			Mission29 = {},
			Mission30 = {},
			Mission31 = {},
			Mission32 = {},
			Mission32a = {},
			Mission32b = {},
			Mission33 = {},
			Mission34 = {},
			Mission35 = {},
			Mission36 = {},
			Mission36a = {},
			Mission37 = {},
			Mission38 = {},
			Mission38a = {},
			Mission38b = {},
			Mission38c = {},
			Mission39 = {},
			Mission40 = {},
			Mission41 = {},
			Mission42 = {},
			Mission43 = {},
			Mission44 = {},
			Mission45 = {},
			Mission46 = {},
			Mission47 = {},
			Mission48 = {},
			Mission49 = {},
			Mission50 = {},
			Mission51 = {},
			Mission52 = {},
			Mission53 = {},
			Mission54 = {},
			Mission55 = {},
			Mission56 = {},
			Mission57 = {},
			Mission58 = {},
			Mission59 = {},
			Mission60 = {},
			Mission61 = {},
			Mission62 = {},
			Mission63 = {},
			Mission64 = {},
			Mission65 = {},
			Mission66 = {},
			Mission67 = {},
			Mission68 = {},
			Mission69 = {},
			Mission70 = {},
			Mission71 = {},
			Mission72 = {},
			Mission73 = {},
			Mission74 = {},
			Mission75 = {},
			Mission76 = {},
			Bookcase = {},
			SmallDragonTears1 = {},
			SmallDragonTears2 = {},
			SmallDragonTears3 = {},
		},
		TheRepenters = {},
	},
	U10_20 = { -- update 10.20 - Reserved Storages 44301 - 44400
		SpikeTaskQuest = {
			QuestLine = {},
			Gnomilly = {},
			Gnombold = {
				Points = {},
				Nests = {},
				Fertilise = {},
				Kill = {},
				Charges = {},
			},
			Gnomargery = {
				Points = {},
				Deliver = {},
				Undercover = {},
				Temperature = {},
				Kill = {},
			},
			Spike_Fame_Points = {},
			Spike_Upper_Pacifier_Main = {},
			Spike_Upper_Pacifier_Daily = {},
			Spike_Upper_Mound_Main = {},
			Spike_Upper_Mound_Daily = {},
			Spike_Upper_Track_Main = {},
			Spike_Upper_Track_Daily = {},
			Spike_Upper_Kill_Main = {},
			Spike_Upper_Kill_Daily = {},
			Spike_Middle_Charge_Main = {},
			Spike_Middle_Charge_Daily = {},
			Spike_Middle_Mushroom_Main = {},
			Spike_Middle_Mushroom_Daily = {},
			Spike_Middle_Nest_Main = {},
			Spike_Middle_Nest_Daily = {},
			Spike_Middle_Kill_Main = {},
			Spike_Middle_Kill_Daily = {},
			Spike_Lower_Parcel_Main = {},
			Spike_Lower_Parcel_Daily = {},
			Spike_Lower_Undercover_Main = {},
			Spike_Lower_Undercover_Daily = {},
			Spike_Lower_Lava_Main = {},
			Spike_Lower_Lava_Daily = {},
			Spike_Lower_Kill_Main = {},
			Spike_Lower_Kill_Daily = {},
		},
		SpiritGroundsMiniWorldChange = {},
	},
	U10_30 = { -- update 10.30 - Reserved Storages 44401 - 44500
		DreamWardenOutfits = {},
		RoshamuulQuest = {
			Roshamuul_Mortar_Thrown = {},
			Roshamuul_Killed_Frazzlemaws = {},
			Roshamuul_Killed_Silencers = {},
			Roshamuul_Gold_Record = {},
		},
	},
	U10_37 = { -- update 10.37 - Reserved Storages 44501 - 44550
		TinderBoxQuestChyllfroest = {
			Reward = {},
			Obedience = {},
		},
		ChyllfroestMiniWorldChange = {},
	},
	U10_50 = { -- update 10.50 - Reserved Storages 44551 - 44750
		DarkTrails = {
			Mission01 = {},
			Mission02 = {},
			Mission03 = {},
			Mission04 = {},
			Mission05 = {},
			Mission06 = {},
			Mission07 = {},
			Mission08 = {},
			Mission09 = {},
			Mission10 = {},
			Mission11 = {},
			Mission12 = {},
			Mission13 = {},
			Mission14 = {},
			Mission15 = {},
			Mission16 = {},
			Mission17 = {},
			Mission18 = {},
			Outfit = {},
			DoorQuandon = {},
			DoorHideout = {},
			RewardSmallNotebook = {},
			Reward05GlothAndBelongings = {},
			Reward10GlothAndBelongings = {},
			OramondTaskProbing = {},
		},
		GloothEngineerOutfits = {
			Addon1 = {},
			Addon2 = {},
		},
		OramondQuest = {
			QuestLine = {},
			VotingPoints = {},
			ToTakeRoots = {
				Mission = {},
				Count = {},
				Door = {},
			},
			Probing = {
				Mission = {},
				MonoDetector = {},
			},
			TheAncientSewers = {
				Mission = {},
				Door = {},
			},
			ThePowderOfTheStars = {
				Mission = {},
			},
		},
		Rathleton = {},
	},
	U10_55 = { -- update 10.55 - Reserved Storages 44751 - 44800
		Dawnport = {
			VocationReward = {},
			Questline = {},
			GoMain = {},
			TheLostAmulet = {},
			TheStolenLogBook = {},
			TheRareHerb = {},
			TheDormKey = {},
			StrangeAmulet = {},
			TornLogBook = {},
			HerbFlower = {},
			MorriskTroll = {},
			MorrisTrollCount = {},
			MorrisGoblin = {},
			MorrisGoblinCount = {},
			MorrisMinos = {},
			MorrisMinosCount = {},
		},
		SanctuaryOfTheLizardGod = {
			LegionHelmet = {},
			LizardGodTeleport = {},
		},
	},
	U10_70 = { -- update 10.70 - Reserved Storages 44801 - 44950
		HeroOfRathleton = {},
		LionsRock = {
			Questline = {},
			OuterSanctum = {
				Skeleton = {},
				LionsStrength = {},
				LionsBeauty = {},
				LionsTears = {},
			},
			InnerSanctum = {
				SnakeSign = {},
				LizardSign = {},
				ScorpionSign = {},
				HyenaSign = {},
				Message = {},
			},
			Time = {},
			LionsRockFields = {},
		},
		TheCursedCrystal = {
			Questline = {},
			Oneeyedjoe = {},
			MedusaOil = {},
			Time = {},
			SheetOfPaper = {},
			SmallCrystalBell = {},
		},
		TheFireFeatheredSerpentWorldChange = {},
		TwentyMilesBeneathTheSea = {},
	},
	U10_80 = { -- update 10.80 - Reserved Storages 44951 - 45200
		AsuraPalace = {},
		Cartography101 = {},
		ChakoyaIcebergMiniWorldChange = {},
		GrimvaleMineWorldChange = {},
		GrimvaleQuest = {
			AncientFeudDoors = {},
			AncientFeudShortcut = {},
			SilverVein = {},
			WereHelmetEnchant = {},
		},
		HiveOutpostMiniWorldChange = {},
		JungleCampMiniWorldChange = {},
		NightmareIslesMiniWorldChange = {},
		PoacherCavesMiniWorldChange = {},
		TheGreatDragonHunt = {
			WarriorSkeleton = {},
			DragonCounter = {},
			Achievement = {},
		},
		TheLostBrotherQuest = {},
		TheTaintedSouls = {},
	},
	U10_90 = { -- update 10.90 - Reserved Storages 45201 - 45350
		FerumbrasAscension = {
			RiftRunner = {}, -- Scroll
			Tarbaz = {},
			Razzagorn = {},
			Ragiaz = {},
			Zamulosh = {},
			Shulgrax = {},
			Mazoran = {},
			Plagirath = {},
			Access = {},
			TheShatterer = {},
			ZamuloshTeleports = {},
			BasinCounter = {},
			TheLordOfTheLiceAccess = {},
			FirstDoor = {},
			MonsterDoor = {},
			TarbazDoor = {},
			HabitatsAccess = {},
			HabitatsTimer = {},
			TarbazNotes = {},
			ColorLever = {},
			BoneFluteWall = {},
			BoneFlute = {},
			Ring = {},
			Statue = {},
			Fount = {},
			Vampire = {},
			Flower = {},
			Ring2 = {},
			Bone = {},
			Reward = {},
			TheShattererLever = {},
			TheShattererTimer = {},
			TheLordOfTheLiceTimer = {},
			TarbazTimer = {},
			RagiazTimer = {},
			PlagirathTimer = {},
			RazzagornTimer = {},
			ZamuloshTimer = {},
			MazoranTimer = {},
			ShulgraxTimer = {},
			FerumbrasMortalShellTimer = {},
			ZamuloshSummon = {},
			FerumbrasEssence = {},
			DesperateSoul = {},
			FlowerPuzzleTimer = {},
			Crystals = {
				Crystal1 = {},
				Crystal2 = {},
				Crystal3 = {},
				Crystal4 = {},
				Crystal5 = {},
				Crystal6 = {},
				Crystal7 = {},
				Crystal8 = {},
				AllCrystals = {},
			},
			Habitats = {
				Roshamuul = {},
				Grass = {},
				Mushroom = {},
				Desert = {},
				Venom = {},
				Ice = {},
				Corrupted = {},
				Dimension = {},
				AllHabitats = {},
			},
			Elements = {
				First = {},
				Second = {},
				Third = {},
				Four = {},
				Active = {},
				Done = {},
			},
			TheRiteOfEternalNight = {},
			StoneCoffinsBones = {},
			VampireTeeth = {},
		},
		Krailos = {},
	},
	U10_94 = { -- update 10.94 - Reserved Storages 45351 - 45450
		HeartOfDestruction = {},
	},
	U11_02 = { -- update 11.02 - Reserved Storages 45451 - 45650
		FestiveOutfits = {
			Addon1 = {},
			Addon2 = {},
		},
		TheFirstDragon = {
			Questline = {},
			DragonCounter = {},
			ChestCounter = {},
			SecretsCounter = {},
			GelidrazahAccess = {},
			DesertTile = {},
			StoneSculptureTile = {},
			SuntowerTile = {},
			Horn = {},
			Scale = {},
			Bones = {},
			Tooth = {},
			AccessCave = {},
			SomewhatBeatable = {},
			FirstDragonTimer = {},
			RewardFeather = {},
			RewardMask = {},
			RewardBackpack = {},
			Feathers = {},
		},
		ForgottenKnowledge = {
			AccessDeath = {},
			AccessViolet = {},
			AccessEarth = {},
			AccessFire = {},
			AccessIce = {},
			AccessGolden = {},
			AccessLast = {},
			OldDesk = {},
			GirlPicture = {},
			SilverKey = {},
			Phial = {},
			BirdCounter = {},
			PlantCounter = {},
			GoldenServantCounter = {},
			DiamondServantCounter = {},
			AccessPortals = {},
			AccessMachine = {},
			LadyTenebrisKilled = {},
			LloydKilled = {},
			ThornKnightKilled = {},
			DragonkingKilled = {},
			HorrorKilled = {},
			TimeGuardianKilled = {},
			LastLoreKilled = {},
			BirdCage = {},
			AccessLavaTeleport = {},
			Ivalisse = {},
			Chalice = {},
			Tomes = {},
			BabyDragon = {},
			SpiderWeb = {},
			LloydEvent = {},
			ActiveTree = {},
			MechanismGolden = {},
			MechanismDiamond = {},
			GoldenServant = {},
			DiamondServant = {},
			AstralPowerCounter = {},
			AstralGlyph = {},
		},
	},
	U11_40 = { -- update 11.40 - Reserved Storages 45651 - 45850
		CultsOfTibia = { -- 45651 - 45750
			Questline = {},
			Minotaurs = {
				BossAccessDoor = {},
				JamesfrancisTask = {},
				Mission = {},
				BossTimer = {},
				AccessDoor = {},
			},
			MotA = {
				Mission = {},
				Stone1 = {},
				Stone2 = {},
				Stone3 = {},
				Answer = {},
				QuestionId = {},
				AccessDoorInvestigation = {},
				AccessDoorGareth = {},
				AccessDoorDenominator = {},
			},
			Barkless = {
				Mission = {},
				Sulphur = {},
				Tar = {},
				Ice = {},
				Death = {},
				Objects = {},
				Temp = {},
				BossTimer = {},
				TrialAccessDoor = {},
				TarAccessDoor = {},
				AccessDoor = {},
				BossAccessDoor = {},
				SulphurAccessDoor = {},
			},
			Orcs = {
				Mission = {},
				LookType = {},
				BossTimer = {},
			},
			Life = {
				Mission = {},
				BossTimer = {},
				AccessDoor = {},
			},
			Humans = {
				Mission = {},
				Vaporized = {},
				Decaying = {},
				BossTimer = {},
				WallDecaying = {},
			},
			Misguided = {
				Mission = {},
				Monsters = {},
				Exorcisms = {},
				Time = {},
				BossTimer = {},
				AccessDoor = {},
			},
			FinalBoss = {
				Mission = {},
				BossTimer = {},
				AccessDoor = {},
			},
		},
		ThreatenedDreams = { -- 45751 - 45850
			QuestLine = {},
			Mission01 = {
				{}, -- Troubled Animals
				PoacherChest = {},
				PoacherNotes = {},
				FeathersCount = {},
				Feathers1 = {},
				Feathers2 = {},
				Feathers3 = {},
				Feathers4 = {},
				Feathers5 = {},
			},
			Mission02 = {
				{}, -- Nightmare Intruders
				FrazzlemawsCount = {},
				EnfeebledCount = {},
				KroazurAccess = {},
				KroazurTimer = {},
				KroazurKill = {},
				DarkMoonMirror = {},
				FairiesCounter = {},
				Fairy01 = {},
				Fairy02 = {},
				Fairy03 = {},
				Fairy04 = {},
				Fairy05 = {},
				ChargedMoonMirror = {},
				MoonMirrorPos01 = {},
				MoonMirrorPos02 = {},
				MoonMirrorPos03 = {},
				MoonMirrorPos04 = {},
				MoonMirrorPos05 = {},
				ChargedSunCatcher = {},
				SunCatcherPos01 = {},
				SunCatcherPos02 = {},
				SunCatcherPos03 = {},
				SunCatcherPos04 = {},
				SunCatcherPos05 = {},
				ChargedStarlightVial = {},
				StarlightPos01 = {},
				StarlightPos02 = {},
				StarlightPos03 = {},
				StarlightPos04 = {},
				StarlightPos05 = {},
			},
			Mission03 = {
				{}, -- An Unlikely Couple
				UnlikelyCouple = {},
				PanpipesTimer = {},
				RavenHerbTimer = {},
				DarkSunCatcher = {},
				EmptyStarlightVial = {},
			},
			Mission04 = {
				{},
			},
			Mission05 = {},
		},
	},
	U11_50 = { -- update 11.50 - Reserved Storages 45851 - 46000
		DangerousDepths = {
			Questline = {},
			Dwarves = {
				Points = {},
				Home = {},
				Subterranean = {},
				LostExiles = {},
				Prisoners = {},
				Organisms = {},
				TimeTaskHome = {},
				TimeTaskSubterranean = {},
			},
			Scouts = {
				Points = {},
				Diremaw = {},
				Growth = {},
				DiremawsCount = {},
				GnomishChest = {},
				BarrelCount = {},
				FirstBarrel = {},
				SecondBarrel = {},
				ThirdBarrel = {},
				FourthBarrel = {},
				FifthBarrel = {},
				TimeTaskDiremaws = {},
				TimeTaskGrowth = {},
				Barrel = {},
				BarrelTimer = {},
			},
			Gnomes = {
				Points = {},
				Ordnance = {},
				Measurements = {},
				Charting = {},
				GnomeChartChest = {},
				GnomeChartPaper = {},
				GnomesCount = {},
				CrawlersCount = {},
				LocationA = {},
				LocationB = {},
				LocationC = {},
				LocationD = {},
				LocationE = {},
				LocationCount = {},
				OldGate = {},
				TheGaze = {},
				LostRuin = {},
				Outpost = {},
				Bastion = {},
				BrokenTower = {},
				ChartingCount = {},
				TimeTaskOrdnance = {},
				TimeTaskMeasurements = {},
				TimeTaskCharting = {},
			},
			Access = {
				LavaPumpWarzoneVI = {},
				TimerWarzoneVI = {},
				LavaPumpWarzoneV = {},
				TimerWarzoneV = {},
				LavaPumpWarzoneIV = {},
				TimerWarzoneIV = {},
			},
			Crystals = {
				WarzoneVI = {
					BigCrystal1 = {},
					BigCrystal2 = {},
					MediumCrystal1 = {},
					MediumCrystal2 = {},
					SmallCrystal1 = {},
					SmallCrystal2 = {},
				},
				WarzoneV = {
					BigCrystal1 = {},
					BigCrystal2 = {},
					MediumCrystal1 = {},
					MediumCrystal2 = {},
					SmallCrystal1 = {},
					SmallCrystal2 = {},
				},
				WarzoneIV = {
					BigCrystal1 = {},
					BigCrystal2 = {},
					MediumCrystal1 = {},
					MediumCrystal2 = {},
					SmallCrystal1 = {},
					SmallCrystal2 = {},
				},
			},
			Bosses = {
				TheCountOfTheCore = {},
				TheDukeOfTheDepths = {},
				TheBaronFromBelow = {},
				TheCountOfTheCoreAchiev = {},
				TheDukeOfTheDepthsAchiev = {},
				TheBaronFromBelowAchiev = {},
				LastAchievement = {},
			},
			Geodes = {
				WarzoneVI = {},
				WarzoneV = {},
				WarzoneIV = {},
			},
		},
		HiddenThreats = {
			QuestLine = {},
			RatterDoor = {},
			ServantDoor = {},
			CorymWorksDoor01 = {},
			CorymWorksDoor02 = {},
			CorymWorksDoor03 = {},
			Rewards = {
				metalFile = {},
				keyFragment01 = {},
				keyFragment02 = {},
			},
			CorymRescued01 = {},
			CorymRescued02 = {},
			CorymRescued03 = {},
			CorymRescued04 = {},
			CorymRescued05 = {},
			CorymRescued06 = {},
			CorymRescued07 = {},
			CorymRescued08 = {},
			CorymRescueMission = {},
		},
	},
	U11_80 = { -- update 11.80 - Reserved Storages 46001 - 46300
		TheSecretLibrary = {
			Questlog = {},
			Asuras = {
				Questline = {},
				FlammingOrchid = {},
				SkeletonNotes = {},
				StrandHair = {},
				LotusKey = {},
				EyeKey = {},
				ScribbledNotes = {},
				EbonyPiece = {},
				PeacockBallad = {},
				BlackSkull = {},
				SilverChimes = {},
				DiamondTimer = {},
				BlazingTimer = {},
				DarkTimer = {},
				Fragrance = {},
			},
			FalconBastion = {
				Questline = {},
				KillingBosses = {},
				OberonTimer = {},
				OberonHeal = {},
				LastBossMsgInterval = {},
				OberonSay = {},
				ChestsTimer = {
					Coast = {},
					Island = {},
					ThroneHall = {},
					Shortcut = {},
					LowerBastion = {},
					UndergroundBastion = {},
					Key0909 = {},
				},
				FalconBastionAccess = {},
			},
			Darashia = {
				Questline = {},
				PuzzleSqm = {},
				FirstChest = {},
				SecondChest = {},
				ThirdChest = {},
				FourthChest = {},
				RedColor = {},
				GreenColor = {},
				BlueColor = {},
				ColorPuzzle = {},
				EatenFood = {},
				FirstTotem = {},
				SecondTotem = {},
				ThirdTotem = {},
				FourthTotem = {},
				FifthChest = {},
				ScorpionTimer = {},
			},
			LiquidDeath = {
				Questline = {},
				Statue1 = {},
				Statue2 = {},
				Statue3 = {},
				Statue4 = {},
				Statue5 = {},
				Statue6 = {},
				Statue7 = {},
				Statue8 = {},
				Statue9 = {},
				StatueCount = {},
				BrokulTimer = {},
				BrokulTimerGlobal = {},
			},
			MoTA = {
				Questline = {},
				LeverPermission = {},
				SampleBlood = {},
				BonyRod = {},
				BrokenCompass = {},
				Crystal1 = {},
				Crystal2 = {},
				Crystal3 = {},
				Crystal4 = {},
				Crystal5 = {},
				Crystal6 = {},
				Crystal7 = {},
				Crystal8 = {},
				YellowGem = {},
				GreenGem = {},
				RedGem = {},
				FinalBasin = {},
				SkullSample = {},
				TakenRod = {},
				TrialTimer = {},
				MuseumTimer = {},
			},
			SmallIslands = {
				Questline = {},
				Parchment = {},
				Sapphire = {},
				Shovel = {},
				Fishing = {},
				RaxiasTimer = {},
				BoatStages = {},
				Hawser = {},
				Turtle = {},
			},
			LibraryPermission = {},
			Library = {
				Questline = {},
				MazzinorTimer = {},
				LokathmorTimer = {},
				GhuloshTimer = {},
				GorzindelTimer = {},
				Ghulosh = {},
			},
		},
		BattleMageOutfits = {
			Addon1 = {},
			Addon2 = {},
		},
		DiscovererOutfits = {},
		MeasuringTibia = {},
	},
	U12_00 = { -- update 12.00 - Reserved Storages 46301 - 46600
		TheDreamCourts = {
			Main = {
				Questline = {},
				CourtChest = {},
				TheSummerCourt = {},
				TheWinterCourt = {},
			},
			DreamTalisman = {},
			WardStones = {
				Questline = {},
				Count ={},
				Knurow = {},
				Desolation = {},
				Syberia = {},
				Caribbean = {},
				
				OgreVillage = {},
				BonebeastIsthmus = {},
				DemonSkeletonCave = {},
				PirateIsland = {},
			},
			UnsafeRelease = {
				Questline = {},
				GotAxe = {},
				HasBait = {},
			},
			HauntedHouse = {
				Questline = {},
				SkeletonContainer = {},
				Cellar = {},
				Temple = {},
				Tomb = {},
				IdolCount = {},

				FacelessBaneAccess = {},
				FacelessBaneBook = {},
			},
			BurriedCatedral = {
				FishingRod = {},
				EstatueWord = {},
				BarrelWord = {},
				BedWord = {},
				LakeWord = {},
				WordCount = {},
				SequenceBooks = {},
				FacelessTimer = {},
				FacelessLifes = {},
			},
			TheSevenKeys = {
				Questline = {},
				RoseBush = {},
				MushRoom = {},
				Book = {},
				OrcSkull = {},
				Recipe = {},
				MinotaurSkull = {},
				TrollSkull = {},
				Lock = {},
				DoorMedusa = {},
				DoorInvisible = {},
				Painting = {},
				SequenceSkulls = {},
				Count = {},
				SkullRoom = {},
				OldLockRoom = {}
			},
			DreamScar = {
				Permission = {},
				BossCount = {},
				MaxxeniusTimer = {},
				AlptramunTimer = {},
				PlagueRootTimer = {},
				IzcandarTimer = {},
				MalofurTimer = {},
				NightmareTimer = {},
				LastBossCurse = {},
			},
			BurriedCatedralGlobal = {
				FacelessTiles = {},
				FacelessTimer = {},
			},
			DreamScarGlobal = {
				MaxxeniusTimer = {},
				AlptramunTimer = {},
				PlagueRootTimer = {},
				IzcandarTimer = {},
				MalofurTimer = {},
				AlptramunSummonsKilled = {},
				IzcandarOutfit = {},
				NightmareTimer = {},
				LastBossCurse = {},
			},
			NightmareCurse = {},
			Malofur = {},
		},
	},
	U12_02 = { -- update 12.02 - Reserved Storages 46601 - 46800
		TibiaAnniversary = {},
		WinterlightSolstice = {},
	},
	U12_15 = { -- update 12.15.8659 - Reserved Storages 46801 - 46850
		GoldenOutfits = {},
	},
	U12_20 = { -- update 12.20 - Reserved Storages 46851 - 47000
		GraveDanger = {
			Questline = {},
			Stage = {},
			Cobra = {},
			GaffirKilled = {},
			CustodianKilled = {},
			QuaidKilled = {},
			ScarlettKilled = {},
			FireWall = {},
			Graves = {
				Progress = {},
				Edron = {},
				DarkCathedral = {},
				Ghostlands = {},
				Cormaya = {},
				FemorHills = {},
				Ankrahmun = {},
				Kilmaresh = {},
				Vengoth = {},
				Darashia = {},
				Thais = {},
				Orclands = {},
				IceIslands = {},
			},
			Bosses = {
				LordAzaram = {
					Killed = {},
					Timer = {},
					Room = {},
				},
				CountVlarkorth = {
					Killed = {},
					Timer = {},
					Room = {},
				},
				EarlOsam = {
					Killed = {},
					Timer = {},
					Room = {},
				},
				BaelocNictros = {
					Timer = {},
					Room = {},
					Killed = {},
				},
				DukeKrule = {
					Timer = {},
					Room = {},
					TransformCD = {},
					Killed = {},
				},
				KingZelos = {
					Killed = {},
					Timer = {},
					Room = {},
				},
			},
			CobraBastion = {
				Questline = {},
			},
		},
		HandOfTheInquisitionOutfits = {
			Outfits = {},
			Addon1 = {},
			Addon2 = {},
		},
		KilmareshQuest = {
			Questline = {},
			First = {
				Title = {},
			},
			Second = {
				Investigating = {},
			},
			Third = {
				Recovering = {},
			},
			Fourth = {
				Moe = {},
				MoeTimer = {},
			},
			Fifth = {
				Memories = {},
				MemoriesShards = {},
			},
			Sixth = {
				Favor = {},
				FourMasks = {},
				BlessedStatues = {},
				IvoryMask = {},
				MirrorMask = {},
				SilverMask = {},
				GryphonMask = {},
			},
			Set = {
				Ritual = {},
			},
			Eighth = {
				Yonan = {},
				Narsai = {},
				Shimun = {},
				Tefrit = {},
			},
			Nine = {
				Owl = {},
			},
			Tem = {
				Bleeds = {},
			},
			Eleven = {
				Basin = {},
			},
			Twelve = {
				Boss = {},
				Bragrumol = {},
				Mozradek = {},
				Xogixath = {},
			},
			Thirteen = {
				Fafnar = {},
				Lyre = {},
				Presente = {},
			},
			Fourteen = {
				Remains = {},
			},
			AccessDoor = {},
		},
		Orcsoberfest = {},
	},
	U12_30 = { -- update 12.30 - Reserved Storages 47001 - 47200
		FalconerOutfits = {},
		FeasterOfSouls = {
			UnazKilled = {},
			VokKilled = {},
			FearFeasterKilled = {},
			DreadMaidenKilled = {},
			UnwelcomeKilled = {},
			PaleWormEntrance = {},
			PaleWormKilled = {},
		},
		PoltergeistOutfits = {
			Received = {},
		},
	},
	U12_40 = { -- update 12.40 - Reserved Storages 47201 - 47500
		RevenantOutfits = {},
		TheOrderOfTheLion = {
			QuestLine = {},
			AccessEastSide = {},
			AccessSouthernSide = {},
		},
		SoulWar = {
			GoshnarMaliceKilled = {},
			GoshnarHatredKilled = {},
			GoshnarSpiteKilled = {},
			GoshnarCrueltyKilled = {},
			GoshnarGreedKilled = {},
			GoshnarMegalomaniaAccess = {},
			GoshnarMegalomaniaKilled = {},
			QuestReward = {},
			OutfitReward = {},
			MountReward = {},
		},
	},
	U12_60 = { -- update 12.60 - Reserved Storages 47501 - 47600
		APiratesTail = {
			QuestLine = {},
			RascacoonShortcut = {},
			TentuglyKilled = {},
			TentuglyDoor = {},
		},
		RascoohanOutfits = {},
	},
	U12_70 = { -- update 12.70 - Reserved Storages 47601 - 47800
		AdventuresOfGalthen = {
			AccessDoor = {},
		},
		CitizenOfIssaviOutfits = {},
		RoyalBounaceanAdvisorOutfits = {},
	},
	U12_80 = { -- update 12.80 - Reserved Storages 47801 - 47850
		RoyalCostumeOutfits = {},
	},
	U12_90 = { -- update 12.90 - Reserved Storages 47851 - 47900
		PrimalOrdeal = {
			QuestLine = {},
			Bosses = {
				MagmaBubbleKilled = {},
				ThePrimalMenaceKilled = {},
			},
		},
	},
	U13_10 = { -- update 13.10 - Reserved Storages 47901 - 47951
		CradleOfMonsters = {
			QuestLine = {},
			Access = {
				Ingol = {},
				LowerIngol = {},
				Monster = {},
				MutatedAbomination = {},
			},
		},
	},
	U13_20 = { -- update 13.20 - Reserved Storages 47952 - 47970
		RottenBlood = {
			AccessDoor = {},
		},
	},
}
Storage.KeysUpdate = {} -- Reserved storage from 40000 - 40000

Storage.PoiLeverCount = {}
Storage.LastStartupTimestamp = {}
Storage.MawhawkState = {}
Storage.Football = {
	LeftScore = {},
	RightScore = {},
	Timer = {},
	MatchGoing = {},
	GoalTimeout = {},
	Field = {},
}
Storage.DominoAlive = {}
Storage.Domino2Alive = {}
Storage.Protection = {}
Storage.ZEZombieCount = {}
Storage.ZEPlayerCount = {}
Storage.ZEState = {}
Storage.GrimEventGrimCount = {}
Storage.GrimEventPlayerCount = {}
Storage.GrimEventState = {}
Storage.LMSJoinedCount = {}
Storage.LMSEventState = {}
Storage.Bomberman = {}
Storage.BombermanTimer = {}
Storage.BombermanArea = {}
Storage.BomberEventPlayerCount = {}
Storage.BomberEventState = {}
Storage.MeteorEventPlayerCount = {}
Storage.MeteorEventState = {}
Storage.SpleefDepo = {}
Storage.SpleefDepoLayers = {}
Storage.MeteorTimer = {}
Storage.ZombieTimer = {}
Storage.GrimTimer = {}
Storage.PathmanTimer = {}
Storage.CrossRoadTimer = {}

Storage.PathEventState = {}
Storage.PathEventPlayerCount = {}
Storage.PathEventRound = {}

Storage.CrossRoadState = {}
Storage.CrossRoadPlayerCount = {}
Storage.CrossRoadCounter = {}
Storage.CrossRoadArea = {}

Storage.StoneRunTimer = {}
Storage.StoneRunState = {}
Storage.StoneRunPlayerCount = {}
Storage.StoneRunCounter = {}
Storage.StoneRunArea = {}

Storage.ushurielTimer = {}
Storage.zuguroshTimer = {}
Storage.madarethTimer = {}
Storage.latrivanTimer = {}
Storage.golgordanTimer = {}
Storage.annihilonTimer = {}
Storage.hellgorakTimer = {}

Storage.PitsOfInfernoLevers = {}
Storage.DailyQuest = { LLvl = {}, MLvl = {}, HLvl = {} }
Storage.Warzones = {}
Storage.Weeper = {}
Storage.Versperoth = { Battle = {}, Health = {} }
Storage.NexusLock = {}
Storage.XpDisplayMode = {}
Storage.DreamBoss = {}
Storage.RestoredIdols = {}
Storage.DeeplingBoss = {}
Storage.WereBoss = {}
Storage.PrinceDrazzakEventTime = {}
Storage.IzcandarTransforming = {}
Storage.UglyMonster = {}
Storage.SmierdzichwastLock = {}
Storage.SmierdzichwastSpawned = {}
--[[
Storage.ElementalSphere = {
	BossRoom = {},

	KnightBoss = {},
	SorcererBoss = {},
	PaladinBoss = {},
	DruidBoss = {},

	Machine1 = {},
	Machine2 = {},
	Machine3 = {},
	Machine4 = {},
}
]]

Storage.ExpBoost = {}
Storage.OberonLock = {}
Storage.Warzone1Global = {}
Storage.GameStore = {
	ExpBoostCount = {},
}
Storage.NextDailyReset = {}
Storage.NextWeeklyReset = {}
Storage.FamiliarSummonEvent10 = {}
Storage.FamiliarSummonEvent60 = {}

Storage.FirstTrackerRequest = {}

startupStorages = {}
