-- Minlevel and multiplier are MANDATORY
-- Maxlevel is OPTIONAL, but is considered infinite by default
-- Create a stage with minlevel 1 and no maxlevel to disable stages

-- Test Server
local expStagesConfigTable = {
    {
        name = "Day 1-3",
        minDay = 0,
        maxDay = 3,
        stages = {
            { minlevel = 1, maxlevel = 49, multiplier = 40 },
            { minlevel = 50, maxlevel = 99, multiplier = 30 },
            { minlevel = 100, maxlevel = 149, multiplier = 20 },
            { minlevel = 150, maxlevel = 199, multiplier = 15 },
            { minlevel = 200, multiplier = 5 }
        }
    },
    {
        name = "Day 4-6",
        minDay = 4,
        maxDay = 6,
        stages = {
            { minlevel = 1, maxlevel = 49, multiplier = 40 },
            { minlevel = 50, maxlevel = 99, multiplier = 30 },
            { minlevel = 100, maxlevel = 149, multiplier = 20 },
            { minlevel = 150, maxlevel = 199, multiplier = 15 },
            { minlevel = 200, multiplier = 10 }
        }
    },
    {
        name = "Day 7+",
        minDay = 7,
        stages = {
            { minlevel = 1, maxlevel = 49, multiplier = 50 },
            { minlevel = 50, maxlevel = 99, multiplier = 30 },
            { minlevel = 100, maxlevel = 149, multiplier = 20 },
            { minlevel = 150, maxlevel = 199, multiplier = 15 },
            { minlevel = 200, multiplier = 15 }
        }
    }
}

-- Set experienceStages table
for _, stage in ipairs(expStagesConfigTable) do
    if DAY_SINCE_START >= stage.minDay and (not stage.maxDay or DAY_SINCE_START <= stage.maxDay) then
        experienceStages = stage.stages
        logger.info("Stages " .. stage.name)
        break
    end
end

-- Official
--[[experienceStages = {
    {minlevel = 1, maxlevel = 49, multiplier = 5},
    {minlevel = 50, maxlevel = 99, multiplier = 4},
    {minlevel = 100, maxlevel = 149, multiplier = 3.3},
    {minlevel = 150, maxlevel = 199, multiplier = 2.7},
    {minlevel = 200, maxlevel = 249, multiplier = 2.4},
    {minlevel = 250, maxlevel = 299, multiplier = 2.2},
    {minlevel = 300, maxlevel = 324, multiplier = 2},
    {minlevel = 325, maxlevel = 349, multiplier = 1.9},
    {minlevel = 350, maxlevel = 374, multiplier = 1.8},
    {minlevel = 375, maxlevel = 399, multiplier = 1.7},
    {minlevel = 400, maxlevel = 449, multiplier = 1.6},
    {minlevel = 450, multiplier = 1.5}
}]]

skillsStages = {
	{
		minlevel = 0,
		multiplier = configManager.getNumber(configKeys.RATE_SKILL)
	}
}

magicLevelStages = {
	{
		minlevel = 0,
		multiplier = configManager.getNumber(configKeys.RATE_MAGIC)
	}
}
