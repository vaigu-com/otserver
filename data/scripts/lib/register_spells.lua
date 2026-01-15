SpellRepository = {}
SpellRepository.__index = SpellRepository
SpellRepository.registry = {}
SpellRepository.duplicateRegisted = {}

local function pad_right(s, countChars)
	if #s > countChars then
		s = s:sub(1, countChars)
	end

	return s .. string.rep(" ", countChars - #s)
end
function SpellRepository:Add(spell)
	local id = spell:getId()
	if self.registry[id] then
		self.duplicateRegisted[id] = true
		logger.warn(T("[SpellRepository::Add] Spell with id :id: is already registered. Existing name: :existingName: New name: :newName:", { id = pad_right(tostring(id), 10), existingName = pad_right(self.registry[id]:getName(), 35), newName = pad_right(spell:getName(), 35) }))
	end
	self.registry[id] = spell
end

local spellnameToIdWords = {
	["Annihilation"] = { id = 62, words = "exori gran ico" },
	["Apprentice's Strike"] = { id = 169, words = "exori min flam" },
	["Berserk"] = { id = 80, words = "exori" },
	["Brutal Strike"] = { id = 61, words = "exori ico" },
	["Buzz"] = { id = 177, words = "exori infir vis" },
	["Chill Out"] = { id = 173, words = "exevo infir frigo hur" },
	["Curse"] = { id = 139, words = "utori mort" },
	["Death Strike"] = { id = 87, words = "exori mort" },
	["Divine Caldera"] = { id = 124, words = "exevo mas san" },
	["Divine Grenade"] = { id = 258, words = "exevo tempo mas san" },
	["Divine Missile"] = { id = 122, words = "exori san" },
	["Electrify"] = { id = 140, words = "utori vis" },
	["Energy Beam"] = { id = 22, words = "exevo vis lux" },
	["Energy Strike"] = { id = 88, words = "exori vis" },
	["Energy Wave"] = { id = 13, words = "exevo vis hur" },
	["Envenom"] = { id = 142, words = "utori pox" },
	["Eternal Winter"] = { id = 118, words = "exevo gran mas frigo" },
	["Ethereal Spear"] = { id = 111, words = "exori con" },
	["Executioner's Throw"] = { id = 261, words = "exori amp kor" },
	["Fierce Berserk"] = { id = 105, words = "exori gran" },
	["Fire Wave"] = { id = 19, words = "exevo flam hur" },
	["Flame Strike"] = { id = 89, words = "exori flam" },
	["Front Sweep"] = { id = 59, words = "exori min" },
	["Great Death Beam"] = { id = 260, words = "exevo max mort" },
	["Great Energy Beam"] = { id = 23, words = "exevo gran vis lux" },
	["Great Fire Wave"] = { id = 240, words = "exevo gran flam hur" },
	["Groundshaker"] = { id = 106, words = "exori mas" },
	["Hell's Core"] = { id = 24, words = "exevo gran mas flam" },
	["Holy Flash"] = { id = 143, words = "utori san" },
	["Ice Burst"] = { id = 262, words = "exevo ulus frigo" },
	["Ice Strike"] = { id = 112, words = "exori frigo" },
	["Ice Wave"] = { id = 121, words = "exevo frigo hur" },
	["Ignite"] = { id = 138, words = "utori flam" },
	["Inflict Wound"] = { id = 141, words = "utori kor" },
	--["Lesser Front Sweep"] = { id = unknown, words = "exori min" },
	["Lightning"] = { id = 149, words = "exori amp vis" },
	["Mud Attack"] = { id = 175, words = "exori infir tera" },
	["Physical Strike"] = { id = 148, words = "exori moe ico" },
	["Practise Fire Wave"] = { id = 167, words = "exevo dis flam hur" },
	["Rage of the Skies"] = { id = 119, words = "exevo gran mas vis" },
	["Scorch"] = { id = 178, words = "exevo infir flam hur" },
	["Strong Energy Strike"] = { id = 151, words = "exori gran vis" },
	["Strong Ethereal Spear"] = { id = 57, words = "exori gran con" },
	["Strong Flame Strike"] = { id = 150, words = "exori gran flam" },
	["Strong Ice Strike"] = { id = 152, words = "exori gran frigo" },
	["Strong Ice Wave"] = { id = 43, words = "exevo gran frigo hur" },
	["Strong Terra Strike"] = { id = 153, words = "exori gran tera" },
	["Terra Burst"] = { id = 263, words = "exevo ulus tera" },
	["Terra Strike"] = { id = 113, words = "exori tera" },
	["Terra Wave"] = { id = 120, words = "exevo tera hur" },
	["Ultimate Energy Strike"] = { id = 155, words = "exori max vis" },
	["Ultimate Flame Strike"] = { id = 154, words = "exori max flam" },
	["Ultimate Ice Strike"] = { id = 156, words = "exori max frigo" },
	["Ultimate Terra Strike"] = { id = 157, words = "exori max tera" },
	["Whirlwind Throw"] = { id = 107, words = "exori hur" },
	["Wrath of Nature"] = { id = 56, words = "exevo gran mas tera" },
	["Arrow Call"] = { id = 176, words = "exevo infir con" },
	["Conjure Arrow"] = { id = 51, words = "exevo con" },
	["Conjure Bolt"] = { id = 79, words = "exevo con mort" },
	["Conjure Explosive Arrow"] = { id = 49, words = "exevo con flam" },
	["Conjure Piercing Bolt"] = { id = 109, words = "exevo con grav" },
	["Conjure Poisoned Arrow"] = { id = 48, words = "exevo con pox" },
	["Conjure Power Bolt"] = { id = 95, words = "exevo con vis" },
	["Conjure Royal Star"] = { id = 191, words = "exevo gran con grav" },
	["Conjure Sniper Arrow"] = { id = 108, words = "exevo con hur" },
	["Conjure Wand of Darkness"] = { id = 92, words = "exevo gran mort" },
	["Enchant Spear"] = { id = 110, words = "exeta con" },
	["Bruise Bane"] = { id = 170, words = "exura infir ico" },
	["Cure Bleeding"] = { id = 144, words = "exana kor" },
	["Cure Burning"] = { id = 145, words = "exana flam" },
	["Cure Curse"] = { id = 147, words = "exana mort" },
	["Cure Electrification"] = { id = 146, words = "exana vis" },
	["Cure Poison"] = { id = 29, words = "exana pox" },
	["Divine Healing"] = { id = 125, words = "exura san" },
	["Fair Wound Cleansing"] = { id = 239, words = "exura med ico" },
	["Heal Friend"] = { id = 84, words = "exura sio" },
	["Intense Healing"] = { id = 2, words = "exura gran" },
	["Intense Recovery"] = { id = 160, words = "utura gran" },
	["Intense Wound Cleansing"] = { id = 158, words = "exura gran ico" },
	["Light Healing"] = { id = 1, words = "exura" },
	["Magic Patch"] = { id = 174, words = "exura infir" },
	["Mass Healing"] = { id = 82, words = "exura gran mas res" },
	["Nature's Embrace"] = { id = 242, words = "exura gran sio" },
	["Practice Healing"] = { id = 166, words = "exura dis" },
	["Recovery"] = { id = 159, words = "utura" },
	["Restoration"] = { id = 241, words = "exura max vita" },
	["Salvation"] = { id = 36, words = "exura gran san" },
	["Ultimate Healing"] = { id = 3, words = "exura vita" },
	["Wound Cleansing"] = { id = 123, words = "exura ico" },
	["Enchant Party"] = { id = 129, words = "utori mas sio" },
	["Heal Party"] = { id = 128, words = "utura mas sio" },
	["Protect Party"] = { id = 127, words = "utamo mas sio" },
	["Train Party"] = { id = 126, words = "utito mas sio" },
	["Avatar of Light"] = { id = 265, words = "uteta res sac" },
	["Avatar of Nature"] = { id = 267, words = "uteta res dru" },
	["Avatar of Steel"] = { id = 264, words = "uteta res eq" },
	["Avatar of Storm"] = { id = 266, words = "uteta res ven" },
	["Blood Rage"] = { id = 133, words = "utito tempo" },
	["Cancel Invisibility"] = { id = 90, words = "exana ina" },
	["Cancel Magic Shield"] = { id = 245, words = "exana vita" },
	["Challenge"] = { id = 93, words = "exeta res" },
	["Charge"] = { id = 131, words = "utani tempo hur" },
	["Chivalrous Challenge"] = { id = 237, words = "exeta amp res" },
	["Creature Illusion"] = { id = 38, words = "utevo res ina" },
	["Divine Dazzle"] = { id = 238, words = "exana amp res" },
	["Divine Empowerment"] = { id = 268, words = "utevo grav san" },
	["Expose Weakness"] = { id = 243, words = "exori moe" },
	--["Find Fiend"] = { id = 20, words = "exiva moe res" },
	["Find Person"] = { id = 20, words = "exiva" },
	["Food"] = { id = 42, words = "exevo pan" },
	["Great Light"] = { id = 11, words = "utevo gran lux" },
	["Haste"] = { id = 6, words = "utani hur" },
	["Invisibility"] = { id = 45, words = "utana vid" },
	["Levitate"] = { id = 81, words = "exani hur" },
	["Light"] = { id = 10, words = "utevo lux" },
	["Magic Rope"] = { id = 76, words = "exani tera" },
	["Magic Shield"] = { id = 44, words = "utamo vita" },
	["Protector"] = { id = 132, words = "utamo tempo" },
	["Sap Strength"] = { id = 244, words = "exori kor" },
	["Sharpshooter"] = { id = 135, words = "utito tempo san" },
	["Strong Haste"] = { id = 39, words = "utani gran hur" },
	["Summon Creature"] = { id = 9, words = "utevo res" },
	["Swift Foot"] = { id = 134, words = "utamo tempo san" },
	["Ultimate Light"] = { id = 75, words = "utevo vis lux" },
}

local function tryUpdateIdWords(spell)
	local name = spell:getName()
	if spellnameToIdWords[name] then
		spell:id(spellnameToIdWords[name].id)
	elseif spell:getId() == 0 then
		spell:id(NextSpellId())
	end

	if spell:getWords() == nil or spell:getWords() == "" then
		spell:words(NextSpellWords())
	end
end

local proxy = Spell.register
Spell.register = function(self)
	tryUpdateIdWords(self)
	SpellRepository:Add(self)
	proxy(self)
end

--Pre-made areas
--Waves
AREA_SHORTWAVE3 = {
	{ 1, 1, 1 },
	{ 1, 1, 1 },
	{ 0, 3, 0 },
}

AREA_WAVE10 = {
	{ 1, 1, 1, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 3, 0, 0, 0 },
}

AREA_WAVE11 = {
	{ 1, 1, 1, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 0, 3, 0, 0, 0 },
}

AREA_WAVE12 = {
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 0, 3, 0, 0, 0 },
}

AREA_WAVE13 = {
	{ 1, 1, 1, 1, 1, 1, 1 },
	{ 1, 1, 1, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 0, 3, 0, 0, 0 },
}

AREA_WAVE4 = {
	{ 1, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 0 },
	{ 0, 0, 3, 0, 0 },
}

AREA_WAVE5 = {
	{ 1, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 0 },
	{ 0, 0, 1, 0, 0 },
	{ 0, 0, 3, 0, 0 },
}

AREA_WAVE6 = {
	{ 0, 0, 0, 0, 0 },
	{ 0, 1, 3, 1, 0 },
	{ 0, 0, 0, 0, 0 },
}

AREA_WAVE7 = {
	{ 1, 1, 1, 1, 1 },
	{ 1, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 0 },
	{ 0, 0, 3, 0, 0 },
}

AREA_SQUAREWAVE5 = {
	{ 1, 1, 1 },
	{ 1, 1, 1 },
	{ 1, 1, 1 },
	{ 0, 1, 0 },
	{ 0, 3, 0 },
}

AREA_SQUAREWAVE6 = {
	{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0 },
}

AREA_SQUAREWAVE7 = {
	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0 },
}

--Diagonal waves
AREADIAGONAL_WAVE4 = {
	{ 0, 0, 0, 0, 1, 0 },
	{ 0, 0, 0, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 0 },
	{ 1, 1, 1, 1, 1, 0 },
	{ 0, 0, 0, 0, 0, 3 },
}

AREADIAGONAL_SQUAREWAVE5 = {
	{ 1, 1, 1, 0, 0 },
	{ 1, 1, 1, 0, 0 },
	{ 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 0 },
	{ 0, 0, 0, 0, 3 },
}

AREADIAGONAL_WAVE6 = {
	{ 0, 0, 1 },
	{ 0, 3, 0 },
	{ 1, 0, 0 },
}

AREADIAGONAL_WAVE7 = {
	{ 0, 0, 0, 0, 0, 1, 0 },
	{ 0, 0, 0, 0, 1, 1, 0 },
	{ 0, 0, 0, 1, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 1, 1, 1, 1, 1, 1, 0 },
	{ 0, 0, 0, 0, 0, 0, 3 },
}

--Beams
AREA_BEAM1 = {
	{ 3 },
}

AREA_BEAM2 = {
	{ 1 },
	{ 3 },
}

AREA_BEAM3 = {
	{ 1 },
	{ 1 },
	{ 3 },
}

AREA_BEAM4 = {
	{ 1 },
	{ 1 },
	{ 1 },
	{ 3 },
}

AREA_BEAM5 = {
	{ 1 },
	{ 1 },
	{ 1 },
	{ 1 },
	{ 3 },
}

AREA_BEAM6 = {
	{ 1 },
	{ 1 },
	{ 1 },
	{ 1 },
	{ 1 },
	{ 3 },
}

AREA_BEAM7 = {
	{ 1 },
	{ 1 },
	{ 1 },
	{ 1 },
	{ 1 },
	{ 1 },
	{ 3 },
}

AREA_BEAM8 = {
	{ 1 },
	{ 1 },
	{ 1 },
	{ 1 },
	{ 1 },
	{ 1 },
	{ 1 },
	{ 3 },
}

AREA_BEAM9 = {
	{ 1 },
	{ 1 },
	{ 1 },
	{ 1 },
	{ 1 },
	{ 1 },
	{ 1 },
	{ 1 },
	{ 3 },
}

AREA_BEAM10 = {
	{ 1 },
	{ 1 },
	{ 1 },
	{ 1 },
	{ 1 },
	{ 1 },
	{ 1 },
	{ 1 },
	{ 1 },
	{ 3 },
}

--Diagonal Beams
AREADIAGONAL_BEAM5 = {
	{ 1, 0, 0, 0, 0 },
	{ 0, 1, 0, 0, 0 },
	{ 0, 0, 1, 0, 0 },
	{ 0, 0, 0, 1, 0 },
	{ 0, 0, 0, 0, 3 },
}

AREADIAGONAL_BEAM7 = {
	{ 1, 0, 0, 0, 0, 0, 0 },
	{ 0, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 0 },
	{ 0, 0, 0, 0, 0, 0, 3 },
}

AREADIAGONAL_SQUAREWAVE5_NAGA = {
	{ 0, 0, 0, 0, 0 },
	{ 0, 1, 1, 0, 0 },
	{ 0, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 0 },
	{ 0, 0, 0, 0, 3 },
}

--Circles
AREA_CIRCLE2X2 = {
	{ 0, 1, 1, 1, 0 },
	{ 1, 1, 1, 1, 1 },
	{ 1, 1, 3, 1, 1 },
	{ 1, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 0 },
}

AREA_CIRCLE3X3 = {
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 1, 1, 1, 1, 1, 1, 1 },
	{ 1, 1, 1, 3, 1, 1, 1 },
	{ 1, 1, 1, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
}

AREA_CIRCLE3X32 = {
	{ 1, 1, 1, 1, 1, 1, 1 },
	{ 1, 1, 1, 1, 1, 1, 1 },
	{ 1, 1, 1, 1, 1, 1, 1 },
	{ 1, 1, 1, 3, 1, 1, 1 },
	{ 1, 1, 1, 1, 1, 1, 1 },
	{ 1, 1, 1, 1, 1, 1, 1 },
	{ 1, 1, 1, 1, 1, 1, 1 },
}

AREA_CIRCLE3X33 = {
	{ 1, 1, 1, 1, 1, 1, 1 },
	{ 1, 1, 1, 1, 1, 1, 1 },
	{ 1, 1, 0, 0, 1, 1, 1 },
	{ 1, 1, 0, 3, 1, 1, 1 },
	{ 1, 1, 0, 1, 1, 1, 1 },
	{ 1, 1, 1, 1, 1, 1, 1 },
	{ 1, 1, 1, 1, 1, 1, 1 },
}

AREA_CIRCLE3X4 = {
	{ 0, 0, 0, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 1, 1, 1, 1, 1, 0 },
	{ 1, 1, 1, 1, 1, 1, 1, 1, 1 },
	{ 1, 1, 1, 1, 3, 1, 1, 1, 1 },
	{ 1, 1, 1, 1, 1, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 1, 1, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 0, 0, 0 },
}

-- Crosses
AREA_CIRCLE1X1 = {
	{ 0, 1, 0 },
	{ 1, 3, 1 },
	{ 0, 1, 0 },
}

AREA_CIRCLE4X4 = {
	{ 0, 0, 0, 0, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 1, 1, 1, 1, 1, 0 },
	{ 1, 1, 1, 1, 3, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 1, 1, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 0, 0, 0, 0 },
}

AREA_CIRCLE5X5 = {
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
	{ 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
}

AREA_CIRCLE5X5V2 = {
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 3, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
}

AREA_CIRCLE6X6 = {
	{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
	{ 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
}

--Squares
AREA_SQUARE1X1 = {
	{ 1, 1, 1 },
	{ 1, 3, 1 },
	{ 1, 1, 1 },
}

AREA_SQUAREWAVE5_NAGA = {
	{ 1, 1, 1 },
	{ 1, 1, 1 },
	{ 0, 1, 0 },
	{ 0, 3, 0 },
}

-- Walls
AREA_WALLFIELD = {
	{ 1, 1, 3, 1, 1 },
}

AREADIAGONAL_WALLFIELD = {
	{ 0, 0, 0, 0, 1 },
	{ 0, 0, 0, 1, 1 },
	{ 0, 1, 3, 1, 0 },
	{ 1, 1, 0, 0, 0 },
	{ 1, 0, 0, 0, 0 },
}

-- Walls Energy
AREA_WALLFIELD_ENERGY = {
	{ 1, 1, 1, 3, 1, 1, 1 },
}

AREADIAGONAL_WALLFIELD_ENERGY = {
	{ 0, 0, 0, 0, 0, 0, 1 },
	{ 0, 0, 0, 0, 0, 1, 1 },
	{ 0, 0, 0, 0, 1, 1, 0 },
	{ 0, 0, 1, 3, 1, 0, 0 },
	{ 0, 1, 1, 0, 0, 0, 0 },
	{ 0, 1, 0, 0, 0, 0, 0 },
	{ 1, 0, 0, 0, 0, 0, 0 },
}

AREA_RING1_BURST3 = {
	{ 0, 0, 0, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 1, 1, 1, 1, 1, 0 },
	{ 1, 1, 1, 0, 0, 0, 1, 1, 1 },
	{ 1, 1, 1, 0, 2, 0, 1, 1, 1 },
	{ 1, 1, 1, 0, 0, 0, 1, 1, 1 },
	{ 0, 1, 1, 1, 1, 1, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 0, 0, 0 },
}

CrossBeamArea3X2 = {
	{ 1, 1, 1 },
	{ 0, 1, 0 },
	{ 0, 3, 0 },
}

AREA_FEAR_OPRESSOR = {
	{ 0, 1, 1, 1, 0 },
	{ 1, 1, 1, 1, 1 },
	{ 1, 1, 3, 1, 1 },
	{ 1, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 0 },
}

AREA_ROOT_OPRESSOR = {
	{ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0 },
	{ 1, 1, 1, 1, 1, 0, 0, 3, 0, 0, 1, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 },
}

-- The numbered-keys represents the damage values, and their table
-- contains the minimum and maximum number of rounds of those damage values.
RANGE = {
	[1] = { 19, 20 },
	[2] = { 10, 10 },
	[3] = { 6, 7 },
	[4] = { 4, 5 },
	[5] = { 3, 4 },
	[6] = { 3, 4 },
	[7] = { 2, 3 },
	[8] = { 2, 3 },
	[9] = { 2, 3 },
	[10] = { 1, 2 },
	[11] = { 1, 2 },
	[12] = { 1, 2 },
	[13] = { 1, 2 },
	[14] = { 1, 2 },
	[15] = { 1, 2 },
	[16] = { 1, 2 },
	[17] = { 1, 2 },
	[18] = { 1, 2 },
	[19] = { 1, 2 },
}

-- Vaigu custom
AREA_SIDEBEAMS1 = {
	{ 1, 0, 1 },
	{ 1, 0, 1 },
	{ 1, 0, 1 },
	{ 1, 0, 1 },
	{ 1, 0, 1 },
	{ 1, 0, 1 },
	{ 1, 2, 1 },
}

AREA_SIDEBEAMS2 = {
	{ 1, 0, 1, 0, 1, 0, 1 },
	{ 1, 0, 1, 0, 1, 0, 1 },
	{ 1, 0, 1, 0, 1, 0, 1 },
	{ 1, 0, 1, 0, 1, 0, 1 },
	{ 1, 0, 1, 0, 1, 0, 1 },
	{ 1, 0, 1, 0, 1, 0, 1 },
	{ 1, 0, 1, 2, 1, 0, 1 },
}

AREA_CIRCLE_EUCLIDEAN_5X5 = {
	{ 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 1, 1, 1, 3, 1, 1, 1 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 0, 0, 1, 0, 0, 0 },
}

AREA_PLUS1 = {
	{ 0, 1, 0 },
	{ 1, 3, 1 },
	{ 0, 1, 0 },
}

AREA_PLUS3 = {
	{ 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0 },
	{ 1, 1, 1, 2, 1, 1, 1 },
	{ 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0 },
}

AREA_PLUS5 = {
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
}

function Creature:addDamageCondition(target, conditionType, listType, damage, time, rounds)
	if target:isImmune(conditionType) then
		return false
	end

	local condition = Condition(conditionType)
	condition:setParameter(CONDITION_PARAM_OWNER, self:getId())
	condition:setParameter(CONDITION_PARAM_DELAYED, true)

	if listType == 0 then
		local exponent, value = -10, 0
		while value < damage do
			value = math.floor(10 * math.pow(1.2, exponent) + 0.5)
			condition:addDamage(1, time or 4000, -value)

			if value >= damage then
				local permille = math.random(10, 1200) / 1000
				condition:addDamage(1, time or 4000, -math.max(1, math.floor(value * permille + 0.5)))
			else
				exponent = exponent + 1
			end
		end
	elseif listType == 1 then
		rounds = rounds or RANGE
		if rounds[damage] then
			condition:addDamage(math.random(1, rounds[damage][2]), time or 4000, -damage)
			damage = damage - 1
		end

		while damage > 0 do
			condition:addDamage(rounds[damage] and math.random(rounds[damage][1], rounds[damage][2]) or 1, time or 4000, -damage)
			damage = damage - (damage > 21 and math.floor(damage / 20) + math.random(0, 1) or 1)
		end
	elseif listType == 2 then
		for _ = 1, rounds do
			condition:addDamage(1, math.random(time[1], time[2]) * 1000, -damage)
		end
	end

	target:addCondition(condition)
	return true
end

function Player:addPartyCondition(combat, variant, condition, baseMana)
	local party = self:getParty()
	if not party then
		self:sendCancelMessage(RETURNVALUE_NOPARTYMEMBERSINRANGE)
		self:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	local members = party:getMembers()
	members[#members + 1] = party:getLeader()

	local position = self:getPosition()
	local affectedMembers = {}
	for _, member in ipairs(members) do
		if member:getPosition():getDistance(position) <= 36 then
			affectedMembers[#affectedMembers + 1] = member
		end
	end

	if #affectedMembers <= 1 then
		self:sendCancelMessage(RETURNVALUE_NOPARTYMEMBERSINRANGE)
		position:sendMagicEffect(CONST_ME_POFF)
		return false
	end

	local mana = math.ceil(math.pow(0.9, #affectedMembers - 1) * baseMana * #affectedMembers)
	if self:getMana() < mana then
		self:sendCancelMessage(RETURNVALUE_NOTENOUGHMANA)
		position:sendMagicEffect(CONST_ME_POFF)
		return false
	end

	if not combat:execute(self, variant) then
		self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		position:sendMagicEffect(CONST_ME_POFF)
		return false
	end

	self:addMana(baseMana - mana, false)
	self:addManaSpent(mana - baseMana)

	for _, member in ipairs(affectedMembers) do
		member:addCondition(condition)
	end
	return true
end

local defaultEffect = CONST_ME_MAGIC_RED
function Player:conjureItem(reagentId, conjureId, conjureCount, effect)
	if not conjureCount and conjureId ~= 0 then
		local itemType = ItemType(conjureId)
		if itemType:getId() == 0 then
			return false
		end

		local charges = itemType:getCharges()
		if charges ~= 0 then
			conjureCount = charges
		end
	end

	local runeReward = { { id = conjureId, count = conjureCount } }
	if not self:CanAddItems(runeReward) then
		return false
	end

	if reagentId ~= 0 and not self:removeItem(reagentId, 1, -1) then
		self:sendCancelMessage(RETURNVALUE_YOUNEEDAMAGICITEMTOCASTSPELL)
		self:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	if not self:addItem(conjureId, conjureCount) then
		self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		self:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	if ItemType(id) and ItemType(id):isRune() then
		effect = CONST_ME_MAGIC_RED
	end
	self:getPosition():sendMagicEffect(effect or defaultEffect)
	return true
end
