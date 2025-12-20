local pseudoQuest = Quest(LOCALIZERS.NONE)

pseudoQuest
	:Constant(function()
		QuestConstants.IndicateUnvisited = {
			[Position(5845, 1529, 7)] = { [Storage.DailyTasks.DailyTaskInfo] = MISSION_NOT_STARTED },
			[Position(5893, 1557, 7)] = { [Storage.DailyRewardShrine.NextCollectTimestamp] = { lt = LockoutExpiryTypeTimestamp(LOCKOUT_EXPIRY_TIME.EXPIRED_TODAY) } },
		}
	end)
	:NoQuestlog()
	:Monster(function() end)
	:Script(function()
		local effect = 252
		local function generateObserver(spawnPosition, requiredState)
			local name = "IndicateUnvisited/Listener" .. spawnPosition:ToString()
			local mType = Game.createMonsterType(name)
			local monster = {}

			monster.description = "a " .. name
			monster.experience = 0
			monster.outfit = {
				lookType = 305,
				lookHead = 0,
				lookBody = 0,
				lookLegs = 0,
				lookFeet = 0,
				lookAddons = 0,
				lookMount = 0,
			}

			monster.health = 500
			monster.maxHealth = 500
			monster.race = "undead"
			monster.speed = 0
			monster.manaCost = 0

			monster.flags = {
				summonable = false,
				attackable = false,
				hostile = false,
				convinceable = false,
				pushable = false,
				rewardBoss = false,
				illusionable = false,
				canPushItems = false,
				canPushCreatures = true,
				staticAttackChance = 0,
				targetDistance = 1,
				runHealth = 0,
				healthHidden = true,
				isBlockable = false,
				canWalkOnEnergy = true,
				canWalkOnFire = true,
				canWalkOnPoison = true,
			}

			monster.light = { level = 0, color = 0 }

			monster.loot = {}

			monster.attacks = {}

			monster.defenses = { defense = 25, armor = 25 }

			monster.elements = {
				{ type = COMBAT_PHYSICALDAMAGE, percent = 100 },
				{ type = COMBAT_ENERGYDAMAGE, percent = 100 },
				{ type = COMBAT_EARTHDAMAGE, percent = 100 },
				{ type = COMBAT_FIREDAMAGE, percent = 100 },
				{ type = COMBAT_LIFEDRAIN, percent = 100 },
				{ type = COMBAT_MANADRAIN, percent = 100 },
				{ type = COMBAT_DROWNDAMAGE, percent = 100 },
				{ type = COMBAT_ICEDAMAGE, percent = 100 },
				{ type = COMBAT_HOLYDAMAGE, percent = 100 },
				{ type = COMBAT_DEATHDAMAGE, percent = 100 },
			}

			monster.immunities = {
				{ type = "paralyze", condition = true },
				{ type = "outfit", condition = true },
				{ type = "invisible", condition = true },
				{ type = "bleed", condition = true },
			}

			local permaInvis = Condition(CONDITION_INVISIBLE)
			permaInvis:setParameter(CONDITION_PARAM_TICKS, -1)

			mType.onSpawn = function(monster, creature)
				monster:addCondition(permaInvis)
			end

			local key, value = next(requiredState, nil)
			local stateFilter = function(player)
				return player:HasRequiredState(key, value)
			end

			local notifiedSinceLogin = {}
			local area = Area.FromSquareRadius(spawnPosition, 3)
			mType.onThink = function()
				local nearbyPlayers = CreatureList():Area(area):FilterByPlayer():Filter(stateFilter, true)
				for _, player in pairs(nearbyPlayers:Get()) do
					if notifiedSinceLogin[player:getId()] == nil then
						player:sendMagicEffect(spawnPosition, effect)
						notifiedSinceLogin[player:getId()] = true
					end
				end
			end
			mType:register(monster)
			return name
		end
		local registerAutoSave = GlobalEvent("indicate_unvisited")
		function registerAutoSave.onStartup()
			for pos, requiredState in pairs(QuestConstants.IndicateUnvisited) do
				local name = generateObserver(pos, requiredState)
				Game.createMonster(name, pos, true, true)
			end
		end
		registerAutoSave:register()
	end)
	:Register()
