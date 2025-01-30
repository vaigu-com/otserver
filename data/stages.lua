-- Minlevel and multiplier are MANDATORY
-- Maxlevel is OPTIONAL, but is considered infinite by default
-- Create a stage with minlevel 1 and no maxlevel to disable stages
experienceStages = {
	{
		minlevel = 1,
		maxlevel = 20,
		multiplier = 1.0,
	},
	{
		minlevel = 21,
		maxlevel = 30,
		multiplier = 1.5,
	},
	{
		minlevel = 31,
		maxlevel = 40,
		multiplier = 1.0,
	},
	{
		minlevel = 41,
		maxlevel = 50,
		multiplier = 1.5,
	},
	{
		minlevel = 51,
		maxlevel = 60,
		multiplier = 2.0,
	},
	{
		minlevel = 61,
		maxlevel = 80,
		multiplier = 3.0,
	},
	{
		minlevel = 81,
		maxlevel = 100,
		multiplier = 4.0,
	},
	{
		minlevel = 101,
		multiplier = 6.0,
	}
}

skillsStages = {
	{
		minlevel = 10,
		maxlevel = 35,
		multiplier = 4,
	},
	{
		minlevel = 36,
		maxlevel = 50,
		multiplier = 6,
	},
	{
		minlevel = 51,
		maxlevel = 70,
		multiplier = 9,
	},
	{
		minlevel = 71,
		maxlevel = 90,
		multiplier = 12,
	},
	{
		minlevel = 91,
		multiplier = 15,
	},
}

magicLevelStages = {
	{
		minlevel = 0,
		maxlevel = 35,
		multiplier = 4,
	},
	{
		minlevel = 36,
		maxlevel = 50,
		multiplier = 5,
	},
	{
		minlevel = 51,
		maxlevel = 70,
		multiplier = 6,
	},
	{
		minlevel = 71,
		maxlevel = 90,
		multiplier = 7,
	},
	{
		minlevel = 90,
		maxlevel = 100,
		multiplier = 8,
	},
	{
		minlevel = 101,
		multiplier = 10,
	},
}