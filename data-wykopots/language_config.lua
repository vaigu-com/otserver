-- 38f8: convert all npc to new system and forgo this spooge
function GetConfigByLanguge(config_list, lang)
	return config_list[lang]
end

-- 38f8: convert all npc to new system and forgo this spooge
function GetConfigByPlayer(player, config_list)
	return GetConfigByLanguge(config_list, getPlayerLanguage(player))
end
