-- Minlevel and multiplier are MANDATORY
-- Maxlevel is OPTIONAL, but is considered infinite by default
-- Create a stage with minlevel 1 and no maxlevel to disable stages
experienceStages = {
	{
		minlevel = 1,
		maxlevel = 8,
		multiplier = 2.0,
	},
	{
		minlevel = 9,
		maxlevel = 20,
		multiplier = 1.5
	},
	{
		minlevel = 21,
		maxlevel = 30,
		multiplier = 1.2,
	},
	{
		minlevel = 31,
		maxlevel = 40,
		multiplier = 1.0,
	},
	{
		minlevel = 41,
		maxlevel = 50,
		multiplier = 1.3,
	},
	{
		minlevel = 51,
		maxlevel = 65,
		multiplier = 1.5,
	},
	{
		minlevel = 66,
		maxlevel = 80,
		multiplier = 2.0,
	},
	{
		minlevel = 81,
		maxlevel = 100,
		multiplier = 2.5,
	},
	{
		minlevel = 101,
		maxlevel = 200,
		multiplier = 2.8,
	},
	{
		minlevel = 201,
		multiplier = 3.0,
	},
}

skillsStages = {
	{
		minlevel = 10,
		maxlevel = 25,
		multiplier = 15,
	},
	{
		minlevel = 26,
		maxlevel = 50,
		multiplier = 6,
	},
	{
		minlevel = 51,
		maxlevel = 70,
		multiplier = 8,
	},
	{
		minlevel = 71,
		maxlevel = 90,
		multiplier = 10,
	},
	{
		minlevel = 90,
		maxlevel = 100,
		multiplier = 7,
	},
	{
		minlevel = 101,
		multiplier = 5,
	},
}

magicLevelStages = {
	{
		minlevel = 0,
		maxlevel = 4,
		multiplier = 8,
	},
	{
		minlevel = 5,
		maxlevel = 45,
		multiplier = 4,
	},
}
