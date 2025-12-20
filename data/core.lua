DATA_DIRECTORY = configManager.getString(configKeys.DATA_DIRECTORY)
CORE_DIRECTORY = configManager.getString(configKeys.CORE_DIRECTORY)

dofile(CORE_DIRECTORY .. "/generated_item_id.lua")
dofile(CORE_DIRECTORY .. "/item_id.lua")
dofile(CORE_DIRECTORY .. "/global.lua")
dofile(CORE_DIRECTORY .. "/libs/libs.lua")
dofile(CORE_DIRECTORY .. "/stages.lua")
