return {
	["MINIGAME_FAILED_TO_START_TOO_FEW_PLAYERS"] = function(context)
		return T("Zbyt malo graczy, aby wystartowac :minigameName: event.", { minigameName = context.minigameName })
	end,
	["MINIGAME_JUST_STARTED_GOOD_LUCK"] = function(context)
		return T(":minigameName: Event wystartowal, powodzenia!.", { minigameName = context.minigameName })
	end,
	["MINIGAME_IS_STARTING_MIN_MAX_PLAYERS_ARE_REQUIRED"] = function(context)
		return T(":minigameName: Event startuje! Wymagane jest przynajmniej :min: na :max: graczy, pozostalo :minutes: minut aby dolaczyc..", { minigameName = context.minigameName, min = context.min, max = context.max })
	end,
	["COIN_LOTTERY_WINNER"] = function(context)
		return T("Coin lottery! :playerName: wygrywa :coins: coinow. Gratulacje!", { playerName = context.playerName, coins = context.coins })
	end,
}
