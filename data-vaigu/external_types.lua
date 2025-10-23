do -- file not meant to be loaded
	return
end

-- do not remove ---@meta tag
---@meta

---@class Thing
Thing = Thing

---@class Cylinder :Thing
Cylinder = Cylinder
---@class Item : Thing
Item = Item
---@class Creature : Thing
Creature = Creature

---@class Container : Item, Cylinder
Container = Container
---@class Player: Creature, Cylinder
Player = Player
---@class Monster : Creature
Creature = Creature
---@class Npc : CreatureList
Npc = Npc

---@class Teleport : Item, Cylinder

---@class skills_t
skills_t = skills_t
---@class CombatType_t
CombatType_t = CombatType_t

---@class LIGHT_STATE
LIGHT_STATE = LIGHT_STATE
---@class LIGHT_TIME
LIGHT_TIME = LIGHT_TIME

---@class GlobalEvent
---@field interval fun(self: GlobalEvent, intervalMilliseconds: integer): GlobalEvent
---@field register fun(self: GlobalEvent): boolean
---@field onThink fun(intervalMilliseconds: integer): boolean|nil
---@field onTime fun(intervalMilliseconds: integer): boolean|nil
---@field time fun(self: GlobalEvent, timestamp: string): nil
---@field onStartup fun(): boolean|nil
---@field onShutdown fun(): boolean|nil
---@field onRecord fun(currentPlayerCount: integer, topPlayerCountEver): boolean|nil
---@field onPeriodChange fun(lightState: LIGHT_STATE, lightTime: LIGHT_TIME): boolean|nil
---@field onSave fun(player: Player): boolean|nil
---@param eventName string
---@return GlobalEvent
function GlobalEvent(eventName) end

---@class CreatureEvent
---@field onLogin fun(player: Player): boolean|nil
---@field onLogout fun(player: Player): boolean|nil
---@field onThink fun(thinker: Creature, intervalMilliseconds: integer): boolean|nil
---@field onPrepareDeath fun(dyingCreature: Creature, killer: Creature|nil ): boolean|nil
---@field onDeath fun(dyingCreature: Creature, corpse: Item|nil, lastHitKiller: Creature|nil, mostDamageKiller: Creature|nil,isLasthHitKillerUnjustified: boolean, isMostDamageKillerUnjustified ): boolean|nil
---@field onKill fun(killer: Creature, target: Creature, isLastHit: boolean): boolean|nil
---@field onAdvance fun(player:Player, skill: skills_t, oldLevel: integer, newLevel: integer): boolean|nil
---@field onModalWindow fun(player: Player, modalWindowId: integer, buttonId: integer, choiceId: integer): boolean|nil
---@field onTextEdit fun(player: Player, item: Item, text: string): boolean|nil
---@field onHealthChange fun(victim: Creature, attacker: Creature|nil, primaryDamage: integer, primaryType:CombatType_t,secondaryDamage:integer, secondaryType:CombatType_t, origin): integer,CombatType_t,integer,CombatType_t
---@field onManaChange fun(victim: Creature, attacker: Creature|nil, primaryDamage: integer, primaryType:CombatType_t,secondaryDamage:integer, secondaryType:CombatType_t, origin): boolean|nil
---@field onExtendedOpcode fun(player: Player, opcode: integer, buffer: string): boolean|nil
---@param eventname any
---@return CreatureEvent
function CreatureEvent(eventname) end

---@class MoveEvent
---@field key fun(self, key: table): nil key is table because Storage keys are converted to string later. This prevents putting hardcoded strings.
---@field register fun(self): nil
---@field onStepIn fun(player: Player, item: Item, toPosition: Position, fromPosition: Position): nil
---@return MoveEvent
function MoveEvent() end

---@class Action
---@field onUse fun(player: Player, ...): boolean|nil
---@return Action
function Action() end