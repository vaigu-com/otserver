-- 25% probability
local CREATURE_SKINNING_CHANCE = 25000
SKINNING_SPECIAL_ACTION_NOT_PERFORMED = "SKINNING_SPECIAL_ACTION_NOT_PERFORMED"
SKINNING_SPECIAL_ACTION_PERFORMED = "SKINNING_SPECIAL_ACTION_PERFORMED"
local toolToCorpseToData = {
	[5908] = {
		[5688] = {
			successChance = 15000,
			rewardId = 9633,
			nextCorpseId = 5689,
		},
		[6075] = {
			successChance = 15000,
			rewardId = 9633,
			nextCorpseId = 5689,
		},
		[4130] = {
			successChance = 10000,
			rewardId = 5914,
			nextCorpseId = 4131,
		},
		[6004] = {
			successChance = 10000,
			rewardId = 5914,
			nextCorpseId = 4131,
		},
		[19046] = {
			successChance = 15000,
			rewardId = 18994,
			nextCorpseId = 19047,
		},
		[19042] = {
			successChance = 15000,
			rewardId = 18994,
			nextCorpseId = 19047,
		},
		[8957] = {
			successChance = 15000,
			rewardId = 9668,
			nextCorpseId = 8959,
		},
		[8958] = {
			successChance = 15000,
			rewardId = 9668,
			nextCorpseId = 8959,
		},
		[8915] = {
			successChance = 15000,
			rewardId = 9662,
			nextCorpseId = 8917,
		},
		[8916] = {
			successChance = 15000,
			rewardId = 9662,
			nextCorpseId = 8917,
		},
		[8999] = {
			successChance = 15000,
			rewardId = 10311,
			nextCorpseId = 4358,
		},
		[9000] = {
			successChance = 15000,
			rewardId = 10311,
			nextCorpseId = 4358,
		},
		[12325] = {
			successChance = 20000,
			rewardId = 12312,
			nextCorpseId = 12326,
		},
		[12328] = {
			successChance = 20000,
			rewardId = 12312,
			nextCorpseId = 12326,
		},
		[25841] = {
			successChance = 15000,
			rewardId = 25697,
			nextCorpseId = 25840,
		},
		[25842] = {
			successChance = 15000,
			rewardId = 25697,
			nextCorpseId = 25840,
		},
		[7256] = {
			successChance = 15000,
			rewardId = 5898,
			nextCorpseId = 7257,
		},
		[7260] = {
			successChance = 15000,
			rewardId = 5898,
			nextCorpseId = 7257,
		},
		[6037] = {
			successChance = 15000,
			rewardId = 5898,
			nextCorpseId = 4234,
		},
		[4233] = {
			successChance = 15000,
			rewardId = 5898,
			nextCorpseId = 4234,
		},
		[22780] = {
			successChance = 10000,
			rewardId = 22730,
			nextCorpseId = 22782,
		},
		[22781] = {
			successChance = 10000,
			rewardId = 22730,
			nextCorpseId = 22782,
		},
		[22776] = {
			successChance = 10000,
			rewardId = 22728,
			nextCorpseId = 22778,
		},
		[22777] = {
			successChance = 10000,
			rewardId = 22728,
			nextCorpseId = 22778,
		},
		[22787] = {
			successChance = 20000,
			rewardId = 22729,
			nextCorpseId = 22778,
		},
		[22784] = {
			successChance = 20000,
			rewardId = 22729,
			nextCorpseId = 22778,
		},
		[4333] = { successChance = 10000, rewardId = 5883, nextCorpseId = 4334 },
		[4339] = { successChance = 10000, rewardId = 5883, nextCorpseId = 4340 },
		[4336] = { successChance = 10000, rewardId = 5883, nextCorpseId = 4337 },
		[5624] = { successChance = 4000, rewardId = 5899, nextCorpseId = 5625 },
		[5627] = { successChance = 4000, rewardId = 5899, nextCorpseId = 5628 },
		[4007] = { successChance = 25000, rewardId = 5897 },
		[5968] = { successChance = 25000, rewardId = 5897, nextCorpseId = 4008 },
		[4030] = { successChance = 15000, rewardId = 5896 },
		[5975] = { successChance = 15000, rewardId = 5896, nextCorpseId = 4031 },
		[4016] = { successChance = 15000, rewardId = 10297 },
		[5970] = { successChance = 15000, rewardId = 10297, nextCorpseId = 4017 },
		[4363] = { successChance = 30000, rewardId = 5894 },
		[6053] = { successChance = 30000, rewardId = 5894, nextCorpseId = 4364 },
		[4360] = { successChance = 25000, rewardId = 3044 },
		[6052] = { successChance = 25000, rewardId = 3044, nextCorpseId = 4361 },
		[8114] = { successChance = 20000, rewardId = 9665 },
		[8113] = { successChance = 20000, rewardId = 9665, nextCorpseId = 8115 },
		[18967] = { successChance = 20000, rewardId = 9665 },
		[18966] = { successChance = 25000, rewardId = 9665, nextCorpseId = 18968 },
		[8966] = { successChance = 10000, rewardId = 9666 },
		[8965] = { successChance = 10000, rewardId = 9666, nextCorpseId = 8967 },
		[951] = { successChance = 14000, rewardId = 9666, nextCorpseId = 955 },
		[949] = { successChance = 20000, rewardId = 9666, nextCorpseId = 955 },
		[4348] = { successChance = 15000, rewardId = 10282 },
		[6048] = { successChance = 15000, rewardId = 10282, nextCorpseId = 4349 },
		[4086] = { successChance = 15000, rewardId = 10319 },
		[5991] = { successChance = 15000, rewardId = 10319, nextCorpseId = 4087 },
		[4330] = { successChance = 25000, rewardId = 5890 },
		[6042] = { successChance = 25000, rewardId = 5890, nextCorpseId = 4331 },
		[9010] = { successChance = 20000, rewardId = 10304 },
		[9009] = { successChance = 20000, rewardId = 10304, nextCorpseId = 9011 },
		[7092] = { successChance = 20000, rewardId = 9661 },
		[7091] = { successChance = 20000, rewardId = 9661, nextCorpseId = 7093 },
		[910] = { successChance = 10000, rewardId = 9661 },
		[909] = { successChance = 10000, rewardId = 9661, nextCorpseId = 911 },
		[4173] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 12172, nextCorpseId = 4302 },
		[6017] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 12172, nextCorpseId = 4302 },
		[4011] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5878, nextCorpseId = 4012 },
		[5969] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5878, nextCorpseId = 4012 },
		[4052] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5878, nextCorpseId = 4053 },
		[5982] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5878, nextCorpseId = 4053 },
		[4047] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5878, nextCorpseId = 4048 },
		[5981] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5878, nextCorpseId = 4048 },
		[4057] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5878, nextCorpseId = 4058 },
		[5983] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5878, nextCorpseId = 4058 },
		[21092] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5878, nextCorpseId = 21093 },
		[21091] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5878, nextCorpseId = 21093 },
		[21096] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5878, nextCorpseId = 21097 },
		[21095] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5878, nextCorpseId = 21097 },
		[21100] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5878, nextCorpseId = 21101 },
		[21099] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5878, nextCorpseId = 21101 },
		[21000] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5878, nextCorpseId = 21002 },
		[21001] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5878, nextCorpseId = 21002 },
		[21004] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5878, nextCorpseId = 21006 },
		[21005] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5878, nextCorpseId = 21006 },
		[20996] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5878, nextCorpseId = 20998 },
		[20997] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5878, nextCorpseId = 20998 },
		[4324] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5876, nextCorpseId = 4325 },
		[6040] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5876, nextCorpseId = 4325 },
		[4327] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5876, nextCorpseId = 4328 },
		[6041] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5876, nextCorpseId = 4328 },
		[4321] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5876, nextCorpseId = 4322 },
		[4239] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5876, nextCorpseId = 4322 },
		[10368] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5876, nextCorpseId = 10369 },
		[10371] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5876, nextCorpseId = 10369 },
		[10360] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5876, nextCorpseId = 10361 },
		[10363] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5876, nextCorpseId = 10361 },
		[10352] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5876, nextCorpseId = 10353 },
		[10355] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5876, nextCorpseId = 10353 },
		[10364] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5876, nextCorpseId = 10365 },
		[10367] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5876, nextCorpseId = 10365 },
		[10356] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5876, nextCorpseId = 10357 },
		[10359] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5876, nextCorpseId = 10357 },
		[4025] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5877, nextCorpseId = 4026 },
		[5973] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5877, nextCorpseId = 4026 },
		[4062] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5948, nextCorpseId = 4063 },
		[5984] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5948, nextCorpseId = 4063 },
		[4112] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5893, nextCorpseId = 4113 },
		[5999] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5893, nextCorpseId = 4113 },
		[4212] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5925, nextCorpseId = 4213 },
		[6030] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5925, nextCorpseId = 4213 },
		[22743] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 22186, nextCorpseId = 22744 },
		[22742] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 22186, nextCorpseId = 22744 },
		[12816] = {
			{ successChance = 5000, rewardId = 8032 },
			{ successChance = 5000, rewardId = 8178 },
			{ successChance = 5000, rewardId = 6491 },
			{ successChance = 20000, rewardId = 6525 },
			{ successChance = 90000, rewardId = 8177, amount = 20 },
			{ successChance = 10000, rewardId = 6571 },
			{ successChance = 10000, rewardId = 6570 },
			{ successChance = 50000, rewardId = 6574 },
			{ successChance = 60000, rewardId = 2977 },
			{ successChance = 45000, rewardId = 3594 },
			{ successChance = 90000, rewardId = 3599, amount = 50 },
			{ successChance = 90000, rewardId = 6569, amount = 50 },
			{ successChance = 2000, rewardId = 6574, amount = 50 },
		},
		[4240] = {
			{ successChance = 3000, rewardId = 5909, nextCorpseId = 4241 },
			{ successChance = 3000, rewardId = 5910, nextCorpseId = 4241 },
			{ successChance = 4000, rewardId = 5911, nextCorpseId = 4241 },
			{ successChance = 5000, rewardId = 5912, nextCorpseId = 4241 },
			{ successChance = 5000, rewardId = 5913, nextCorpseId = 4241 },
			{ successChance = 5000, rewardId = 5914, nextCorpseId = 4241 },
			{ successChance = 35000, rewardId = 3115, nextCorpseId = 4241 },
		},
		[4247] = {
			{ successChance = 3000, rewardId = 5909, nextCorpseId = 4248 },
			{ successChance = 3000, rewardId = 5910, nextCorpseId = 4248 },
			{ successChance = 4000, rewardId = 5911, nextCorpseId = 4248 },
			{ successChance = 5000, rewardId = 5912, nextCorpseId = 4248 },
			{ successChance = 5000, rewardId = 5913, nextCorpseId = 4248 },
			{ successChance = 5000, rewardId = 5914, nextCorpseId = 4248 },
			{ successChance = 35000, rewardId = 3115, nextCorpseId = 4248 },
		},
		[10426] = {
			{
				successChance = 10000,
				rewardId = 10429,
				desc = "This little figurine of Tibiasula was masterfully sculpted by |PLAYERNAME|.",
			},
			{
				successChance = 26764,
				rewardId = 10428,
				desc = "This little figurine made by |PLAYERNAME| has some room for improvement.",
			},
			{ successChance = 60000, rewardId = 10427, desc = "This shoddy work was made by |PLAYERNAME|." },
		},
		[7441] = { successChance = 22344, rewardId = 7442 },
		[7442] = { successChance = 22344, rewardId = 7444 },
		[7444] = { successChance = 22344, rewardId = 7445 },
		[7445] = { successChance = 22344, rewardId = 7446 },
	},
	[5942] = {
		[6339] = {
			successChance = 10000,
			rewardId = 10306,
			nextCorpseId = 6341,
		},
		[6340] = {
			successChance = 10000,
			rewardId = 10306,
			nextCorpseId = 6341,
		},
		[6363] = {
			successChance = 22000,
			rewardId = 6499,
			nextCorpseId = 6365,
		},
		[6364] = {
			successChance = 22000,
			rewardId = 6499,
			nextCorpseId = 6365,
		},
		[18146] = {
			successChance = 5000,
			rewardId = 5904,
			nextCorpseId = 18147,
		},
		[18149] = {
			successChance = 5000,
			rewardId = 5904,
			nextCorpseId = 18147,
		},
		[6335] = {
			successChance = 20000,
			rewardId = 6499,
			nextCorpseId = 6337,
		},
		[6336] = {
			successChance = 20000,
			rewardId = 6499,
			nextCorpseId = 6337,
		},
		[4097] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5906, nextCorpseId = 4098 },
		[5995] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5906, nextCorpseId = 4098 },
		[4137] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5905, nextCorpseId = 4138 },
		[6006] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5905, nextCorpseId = 4138 },
		[8738] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5905, nextCorpseId = 8742 },
		[8744] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5905, nextCorpseId = 8742 },
		[8109] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5905, nextCorpseId = 8111 },
		[8110] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5905, nextCorpseId = 8111 },
		[18958] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5905, nextCorpseId = 18959 },
		[18961] = { successChance = CREATURE_SKINNING_CHANCE, rewardId = 5905, nextCorpseId = 18959 },
	},
}
local function onIceCubeSculpting(player, corpse, corpseId, corpseData, roll)
	local effect = CONST_ME_HITAREA
	corpse:getPosition():sendMagicEffect(effect)

	if roll <= corpseData.successChance then
		if corpseData.rewardId == 7446 then
			player:addAchievement("Ice Sculptor")
			player:addAchievementProgress("Cold as Ice", 10)
		end
		corpse:transform(corpseData.rewardId, 1)
	else
		player:say("The attempt of sculpting failed miserably.", TALKTYPE_MONSTER_SAY)
		corpse:remove()
	end
end
local function onMarbleSculpting(player, corpse, corpseId, corpseData, roll)
	local added = false
	local _skin
	for i = 1, #corpseData do
		_skin = corpseData[i]
		if roll <= _skin.successChance then
			if corpseId == 10426 then
				corpse:getPosition():sendMagicEffect(CONST_ME_HITAREA)
				player:AddCustomItem({ id = _skin.rewardId, count = _skin.amount or 1, desc = _skin.desc:gsub("|PLAYERNAME|", player:getName()) })
				if _skin.rewardId == 10429 then
					player:addAchievement("Marblelous")
					player:addAchievementProgress("Marble Madness", 5)
				end
				corpse:remove()
				added = true
			else
				corpse:transform(_skin.rewardId, _skin.amount or 1)
				added = true
			end
			break
		end
	end

	if not added and corpseId == 10426 then
		local effect = CONST_ME_HITAREA
		player:say("Your attempt at shaping that marble rock failed miserably.", TALKTYPE_MONSTER_SAY)
		corpse:getPosition():sendMagicEffect(effect)
		corpse:remove()
	end
end
local function onHumanSkinning(player, corpse, corpseId, corpseData, roll)
	local reward = table.random(corpseData)
	
	if player:getStorageValueByKey(Storage.SilenceOfTheLambs.RubMeatWithLecter) == QuestState.SilenceOfTheLambs.RubMeatWithLecter.BringHeartsToLecter then
		if roll <= 50000 then
			player:say("Ehh, I still need to pracise.", TALKTYPE_MONSTER_SAY)
			corpse:getPosition():sendMagicEffect(CONST_ME_POFF)
		else
			player:AddCustomItem(QuestKeyItems.SilenceOfTheLambs.HumanHeart)
			player:say("I got it!", TALKTYPE_MONSTER_SAY)
			corpse:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		end
		corpse:transform(reward.nextCorpseId)
		return SKINNING_SPECIAL_ACTION_PERFORMED
	end

	player:AddCustomItem({ id = reward.rewardId, count = reward.amount or 1 })
	local effect = CONST_ME_HITAREA
	corpse:getPosition():sendMagicEffect(effect)
	corpse:transform(corpseData.nextCorpseId)
end
local toolToCorpseIdToSpecialAction = {
	[5908] = {

		[4240] = onHumanSkinning,
		[4247] = onHumanSkinning,
		[18034] = onHumanSkinning,
		[18037] = onHumanSkinning,

		[30329] = function(player, corpse, corpseId, corpseData, roll)
			stopEvent(corpse:getCustomAttribute("event"))
			player:AddCustomItem({ id = corpse:getCustomAttribute("id"), count = 1 })
			corpse:remove()
			return true
		end,
		[33778] = function(player, corpse, corpseId, corpseData, roll)
			local chance = math.random(1, 10000)
			corpse:getPosition():sendMagicEffect(CONST_ME_HITAREA)
			corpse:remove(1)
			if chance <= 8640 then
				player:AddCustomItem({ id = 33779, count = 1 })
			else
				player:AddCustomItem({ id = 33780, count = 1 })
			end
			return true
		end,
		[11339] = function(player, corpse, corpseId, corpseData, roll)
			corpse:transform(11331)
			player:say("You carve a solid bowl of the chunk of wood.", TALKTYPE_MONSTER_SAY)
			return true
		end,
		[10735] = function(player, corpse, corpseId, corpseData, roll)
			if player:getItemCount(11699) > 0 and player:getStorageValueByKey(Storage.Quest.U8_6.AnInterestInBotany.Questline) == 1 then
				player:say("The plant feels cold but dry and very soft. You streak the plant gently with your knife and put a fragment in the almanach.", TALKTYPE_MONSTER_SAY)
				player:setStorageValueByKey(Storage.Quest.U8_6.AnInterestInBotany.Questline, 2)
				return true
			end
		end,
		[10697] = function(player, corpse, corpseId, corpseData, roll)
			if player:getItemCount(11699) > 0 and player:getStorageValueByKey(Storage.Quest.U8_6.AnInterestInBotany.Questline) == 2 then
				player:say("You cut a leaf from a branch and put it in the almanach. It smells strangely sweet and awfully bitter at the same time.", TALKTYPE_MONSTER_SAY)
				player:setStorageValueByKey(Storage.Quest.U8_6.AnInterestInBotany.Questline, 3)
				return true
			end
		end,
		[8181] = function(player, corpse, corpseId, corpseData, roll)
			if player:getStorageValueByKey(789100) <= 1 then
				player:say("You got Neutral matter.", TALKTYPE_MONSTER_SAY)
				player:AddCustomItem({ id = 954, count = 1 })
				player:setStorageValueByKey(789100, 1)
				return true
			end
		end,
		[8182] = function(player, corpse, corpseId, corpseData, roll)
			if player:getStorageValueByKey(789100) <= 1 then
				player:say("You got Neutral matter.", TALKTYPE_MONSTER_SAY)
				player:AddCustomItem({ id = 954, count = 1 })
				player:setStorageValueByKey(789100, 2)
				return true
			end
		end,
		[301] = function(player, corpse, corpseId, corpseData, roll)
			player:say("You successfully gathered a rabbit's food in excellent condition.", TALKTYPE_MONSTER_SAY)
			player:AddCustomItem({ id = 12172, count = 1 })
			return true
		end,
		[12816] = function(player, corpse, corpseId, corpseData, roll)
			if player:getStorageValueByKey(Storage.Quest.U8_2.TheMutatedPumpkin.Skinned) > os.time() then
				player:sendCancelMessage("You already used your knife on the corpse.")
				return true
			end

			player:setStorageValueByKey(Storage.Quest.U8_2.TheMutatedPumpkin.Skinned, os.time() + 4 * 60 * 60)
			player:say("Happy Halloween!", TALKTYPE_MONSTER_SAY)
			player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
			player:addAchievement("Mutated Presents")
			local reward = corpseData[math.random(1, #corpseData)]
			player:AddCustomItem({ id = reward.rewardId, count = reward.amount or 1 })
			local effect = CONST_ME_HITAREA
			corpse:getPosition():sendMagicEffect(effect)
			return true
		end,
		[7441] = onIceCubeSculpting,
		[7442] = onIceCubeSculpting,
		[7444] = onIceCubeSculpting,
		[7445] = onIceCubeSculpting,
		[10426] = onMarbleSculpting,
	},
}

local function isInBags(pos)
	return pos.x == CONTAINER_POSITION
end

local function defaultOnSuccessSkin(player, corpseData, usePosition, skinningTool)
	if table.contains({ 5906, 5905 }, corpseData.rewardId) then
		player:addAchievementProgress("Ashes to Dust", 500)
	else
		player:addAchievementProgress("Skin-Deep", 500)
	end
	local container = Container(skinningTool:getParent().uid)
	if isInBags(usePosition) and container:getEmptySlots() ~= 0 then
		container:addItem(corpseData.rewardId, corpseData.amount or 1)
	else
		player:AddCustomItem({ id = corpseData.rewardId, count = corpseData.amount or 1 })
	end
end

local defaultMaxRoll = 100000
local function calculateMaxRoll(player, corpseId)
	local maxRoll = defaultMaxRoll
	local charmMType = player:getCharmMonsterType(CHARM_SCAVENGE)
	if charmMType then
		local charmCorpse = charmMType:getCorpseId()
		if charmCorpse == corpseId or ItemType(charmCorpse):getDecayId() == corpseId then
			maxRoll = maxRoll * GLOBAL_CHARM_SCAVENGE / 100
		end
	end
	return maxRoll
end

local function tryPerformSpecialCorpseAction(player, corpse, corpseData, roll, toolId, corpseId)
	local toolActions = toolToCorpseIdToSpecialAction[toolId]
	if not toolActions then
		return SKINNING_SPECIAL_ACTION_NOT_PERFORMED
	end

	local specialCorpseIdAction = toolActions[corpseId]
	if not specialCorpseIdAction then
		return SKINNING_SPECIAL_ACTION_NOT_PERFORMED
	end

	local status = specialCorpseIdAction(player, corpse, corpseId, corpseData, roll)
	if status == SKINNING_SPECIAL_ACTION_PERFORMED then
		return SKINNING_SPECIAL_ACTION_PERFORMED
	end

	return SKINNING_SPECIAL_ACTION_NOT_PERFORMED
end

local skinning = Action()
function skinning.onUse(player, skinningTool, usePosition, corpse, corpsePosition, isHotkey)
	if not corpse then
		return true
	end
	if not corpse.getId then
		return true
	end

	local toolId = skinningTool:getId()
	local corpseId = corpse:getId()

	local topItem = false
	local corpseData = toolToCorpseToData[toolId][corpseId]
	local tile = Tile(corpsePosition)
	if tile then
		topItem = tile:getTopDownItem()
		if topItem then
			corpseData = toolToCorpseToData[toolId][topItem:getId()]
		end
	end

	local maxRoll = calculateMaxRoll(player, corpseId)
	local roll = math.random(1, maxRoll)
	if tryPerformSpecialCorpseAction(player, corpse, corpseData, roll, toolId, corpseId) == SKINNING_SPECIAL_ACTION_PERFORMED then
		return
	end

	if not corpseData then
		player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return true
	end

	local effect = CONST_ME_BLOCKHIT
	if roll <= corpseData.successChance then
		effect = CONST_ME_MAGIC_GREEN
		defaultOnSuccessSkin(player, corpseData, usePosition, skinningTool)
	end

	if topItem then
		topItem:transform(corpseData.nextCorpseId or topItem:getType():getDecayId() or topItem.itemid + 1)
	end

	if isInBags(corpsePosition) then
		player:getPosition():sendMagicEffect(effect)
	else
		corpsePosition:sendMagicEffect(effect)
	end

	return true
end

skinning:id(5908, 5942)
skinning:register()
