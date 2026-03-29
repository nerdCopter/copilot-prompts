---
name: LUAU instructions
applyTo: "**/*.lua,**/*.luau"
description: "Best practices and AI coding standards for Roblox Luau scripts."
---

# Roblox Luau: Production-Grade Engineering & AI Standards

**Goal:** Equip AI to write code that is idiomatic, testable, performant, maintainable, and production-ready.

## 1. Guiding Principles
- **Optimize for Readability:** Code is written once; many read it. Prioritize clarity and future-proofing over brevity.
- **Consistency Matters:** Adhere strictly to the [Roblox Lua Style Guide](https://roblox.github.io/lua-style-guide/). Consistency avoids arguments and accelerates reviews.
- **Avoid Magic:** Use only well-understood Lua features. Metatables only for classes/enums. Avoid surprising or undocumented patterns.
- **Clarity in Code:** Use descriptive variable, function, and module names. Spell out words fully; abbreviations reduce readability.
- **Optimize for Diffs:** Structure code so diffs stay minimal and readable. One change per line when possible.

## 2. File Structure & Organization

**Strict file order:**
1. **Block comment** — Describe *why* this file exists (NOT file name/author/date—use version control).
2. **Services** — All `game:GetService()` calls, alphabetized.
3. **Module imports** — All `require()` calls, alphabetized, grouped by source.
4. **Constants** — Module-level `LOUD_SNAKE_CASE` constants.
5. **Module-level vars & functions** — Local state, helpers, private members (prefix `_`).
6. **Exported object/API** — The table/object returned by this module.
7. **Return statement** — Always end with `return TheThing`.

**Modules:**
- Prefer ModuleScripts for reusable logic.
- Keep each module focused on a **single responsibility**.
- Organize by feature/domain (e.g., Systems, Controllers, Services), not by type.

**Other entry points:**
- Use `StarterPlayerScripts`, `StarterCharacterScripts`, `StarterGui` for player-facing logic only.

## 3. Type Annotations & Static Analysis

- **Enable strict mode:** Add `--!strict` at the top of all production scripts.
- **Annotate all public functions:** Parameters and return values must have types.
- **Export type definitions:** Use `export type` for classes and complex structures.
- **Example:**
  ```lua
  export type PlayerType = typeof(setmetatable(
      {} :: { health: number, name: string },
      PlayerController
  ))
  
  function PlayerController.new(name: string): PlayerType
      local self = { health = 100, name = name }
      return setmetatable(self, PlayerController)
  end
  ```

## 4. Object-Oriented Design (Prototype-Based Classes)

**Pattern:**
```lua
local MyClass = {}
MyClass.__index = MyClass

export type MyClassType = typeof(setmetatable(
    {} :: { property: number },
    MyClass
))

function MyClass.new(property: number): MyClassType
    local self = { property = property }
    return setmetatable(self, MyClass)
end

function MyClass.doSomething(self: MyClassType)
    self.property += 1
end

function MyClass.isMyClass(instance: any): boolean
    return getmetatable(instance).__index == MyClass
end

function MyClass.__tostring(self: MyClassType): string
    return string.format("MyClass(%d)", self.property)
end

return MyClass
```

**Key points:**
- Use dot (`.`) for method definitions (allows type annotations on `self`).
- Use colon (`:`) for method calls.
- Always provide a type export and constructor.
- Include `isMyClass()` type guard.
- Provide `__tostring` for debugging.
- Use `__index` only for inheritance/class lookups; avoid other metatable tricks.

## 5. Performance, Memory & Async

**Memory cleanup (critical):**
- Always disconnect events and clean up references.
- Provide a `destroy()` method for all objects that hold connections.
- Nil out large tables and release resources explicitly.

**Async & Yielding:**
- **Never yield on the main task.** Wrap yields in `coroutine.wrap()` or use Promises.
- Avoid `wait()` and `task.wait()` unless absolutely necessary.
- Use events/signals for async communication instead of polling.

**Performance optimization:**
- Minimize per-frame logic in `Heartbeat`/`RenderStepped`.
- Use throttling/debouncing for expensive operations.
- Profile first; optimize only measurable bottlenecks.
- Prefer deterministic logic for AI behaviors (aids debugging and reproducibility).

## 6. Security & Networking

- **Always use `game:GetService()`** at the top of files (ensures consistency, avoids globals).
- **Never trust the client.** Always validate and sanitize inputs on the server.
- **Whitelist allowed actions.** Explicitly define what clients may request.
- **Encrypt sensitive data** (currency, inventory); sign messages to prevent tampering.
- **Rate limit** remote calls to prevent abuse.
- **Module isolation:** Never require() untrusted modules or user-provided scripts.

**Example (safe RemoteFunction):**
```lua
RemoteFunction.OnServerInvoke = function(player: Player, action: string, data: any)
    -- Whitelist allowed actions
    if action == "BuyItem" then
        if not canPlayerBuyItem(player, data.itemId) then
            return false
        end
        return processItemPurchase(player, data.itemId)
    end
    
    -- Deny unknown actions
    return false
end
```

## 7. Error Handling & Result Types

**Prefer returning `(success: boolean, result: any)` or a Result type:**
```lua
function Player.loadData(playerId: number): (boolean, table?)
    local success, data = pcall(function()
        return database:get(playerId)
    end)
    return success and data or false, nil
end
```

**Rules:**
- Only throw errors for invalid usage (parameter validation with `assert()`).
- Wrap error-prone calls in `pcall()` with documented exception handling.
- Never silently swallow errors; log or propagate them.

## 8. Comments & Documentation

**Block comments (for documentation):**
```lua
--[[
    Manages player death, including ragdoll, respawn cooldown, and revival logic.
    Handles edge cases: network latency, concurrent death events, etc.
    Fires: 'died(player)', 'respawned(player)'
]]
local DeathSystem = {}
```

**Inline comments (explain why, not what):**
```lua
-- Without this check, players could bypass respawn cooldown by disconnecting/reconnecting
if player.lastDeathTime and tick() - player.lastDeathTime < RESPAWN_COOLDOWN then
    return false
end
```

**Rules:**
- Focus on "why," not "what." Code is readable; intent is not.
- Wrap comments to 80 columns.
- No section comments (`--- VARIABLES ---`). Break large files instead.
- Use block comments for module/function/class documentation.

## 9. Naming Conventions

| Category | Convention | Example |
|----------|-----------|---------|
| Classes/Enums | `PascalCase` | `PlayerController`, `GameState` |
| Local variables | `camelCase` | `playerHealth`, `isMoving` |
| Functions/Methods | `camelCase` | `doSomething()`, `calculateDamage()` |
| Constants | `LOUD_SNAKE_CASE` | `MAX_HEALTH`, `SPAWN_TIMEOUT` |
| Private members | `_camelCase` | `_internalState`, `_cachedValue` |

**Rules:**
- Spell out words fully; abbreviations reduce readability.
- Acronyms: `aJsonVariable`, `aRgbValue` (not `aJSONVariable`).
- File names match their primary export: `PlayerController.lua` exports `PlayerController`.

## 10. Requires & Module Dependencies

**Rules:**
- All `require()` calls at the top of the file.
- Alphabetize by module name.
- Group by origin: (1) packages, (2) exports from packages, (3) internal modules.
- Use relative paths for portability.

**Example:**
```lua
-- 1. Packages
local Signal = require(script.Parent.Packages.Signal)
local Util = require(script.Parent.Packages.Util)

-- 2. Exports from packages
local TableUtils = Util.TableUtils

-- 3. Internal modules
local Config = script.Parent.Config
local InputConfig = require(Config.InputConfig)
```

## 11. Control Flow & Tables

**if-then-else expressions:**
```lua
-- Good: Clear, safe
local scale = if someCondition() then 1 else 2

-- Bad: Unsafe pattern
local scale = someCondition() and 1 or 2
```

**Long conditions:**
```lua
if
    someReallyLongCondition()
    and someOtherReallyLongCondition()
then
    doSomething()
end
```

**Tables:**
- Avoid mixed tables (list + dict); split into two if needed.
- Use `ipairs` for lists, `pairs` for dicts.
- Add trailing commas in multiline tables.

## 12. Formatting & Style

- **Indentation:** Tabs (treated as 4 spaces).
- **Line length:** ≤100 columns (code), ≤80 columns (comments).
- **Strings:** Double quotes (`"hello"`) unless string contains double quotes.
- **Operators:** Space before and after (`a + b`, not `a+b`).
- **One statement per line.** Function bodies on new lines.
- **No vertical alignment** (`=` signs should NOT line up).
- **No semicolons.**
- **Trailing commas** in multiline tables/lists.

## 13. Functions & Minimalism

- **Keep arguments minimal:** Prefer 1–2 parameters.
- **Use tables for multiple related params.**
- **Always use parentheses** for calls (even for no args).

```lua
-- Good
function doSomething(name: string): boolean end

function configure(options: { maxPlayers: number, difficulty: string }) end

-- Bad (too many args, no parentheses)
function doManyThings(a, b, c, d, e, f) end
doSomething "hello"
```

## 14. Scripting Best Practices

- **Avoid globals:** Never create or rely on global variables. Use local scope and module returns.
- **Events & Signals:** Use `BindableEvent`/`RemoteEvent` for decoupled communication. Prefer signals over polling.
- **State machines:** Use clear state machines for NPC/AI logic.
- **Testing:** Write testable, modular functions. Provide debug toggles/logging for AI routines.

## 15. References & Tools

- **[Roblox Lua Style Guide](https://roblox.github.io/lua-style-guide/)** — Canonical reference.
- **[Luau Type System](https://roblox.github.io/luau/typecheck)** — Type checking.
- **[Roblox Developer Hub](https://create.roblox.com/docs/)** — Official docs.
- **[Selene](https://kampfkarren.github.io/selene/)** — Lua static analyzer.
