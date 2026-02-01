# War Without Fronts

**War Without Fronts** is a real-time tactical war game set in the Vietnam War era.  
It combines a **strategic grand map** with **real-time tactical battles**, both running on a **single continuous timeline**.

There are no fixed frontlines.  
Enemies can appear on any tile, at any time.

---

## Core Concept

- Two gameplay layers:
  - **Grand Map** – strategy, logistics, movement, base management
  - **Battle Map** – real-time tactical combat
- Both layers run **simultaneously**
- Players can switch between layers at any moment
- Battle maps are created **only when combat occurs** and destroyed afterward

Unlike games where every region is always active, most tiles exist only as strategic space until violence breaks out.

---

## Grand Map

- Square, tile-based grid (e.g. 8×8)
- Tile types:
  - **Ground** – can host battles
  - **Water** – cannot host battles
- Units move tile-to-tile in 4 directions
- Each ground tile represents a potential battle map

### Tile Control
- Infantry must **stop** on a tile to capture it
- **Camp**:
  - Restores stamina
  - Uses medical supplies
  - Only available on captured tiles
- **Ambush does not capture tiles**

---

## Battle Map

- Tile-based RTS combat
- Spawned dynamically when combat begins
- Units enter from the edge corresponding to their movement direction
- Units merely passing through will cross the map and return to the grand map
- Battle maps are closed when:
  - All units leave
  - One side is eliminated
  - An ambush disengages without contact
  - System limits force shutdown

---

## Units

### Infantry Squads
- 4–6 soldiers per squad
- Each soldier carries:
  - Weapon
  - Ammunition
  - Grenades
  - Medkit
- Soldiers have **3 HP**
- Medkits:
  - Single use
  - Can only be used while camping
- Wounded soldiers must be evacuated to base for recovery

### Vehicles
- Count as squads (vehicle + 2–4 crew)
- Categories:
  - Ground vehicles
  - Air vehicles
- Vehicles can be disabled without being destroyed
- Disabled vehicles eject their crew
- Movement consumes fuel
- Repairs and refueling only occur at base

#### Medical Vehicles
- Can only carry medics and wounded soldiers
- Cannot transport healthy troops

---

## Weapons (Current Scope)

- **M16** – 5.56mm
- **Type 56 (AK)** – 7.62mm
- **RPG-2**
- **M72 LAW**
- Fragmentation grenades

All other gear (helmets, vests, bags) is **cosmetic only**.

---

## Resources

- **Manpower**
  - Finite
  - Recovered only when wounded soldiers heal
- **Ammo**
  - Generated over time by bases and captured tiles
- **Supply**
  - Used for building construction and vehicle repair
- **Fuel**
  - Required for vehicle movement

Poor logistics leads directly to battlefield losses.

---

## Bases

- Bases are **mobile**
- Relocation consumes large amounts of fuel
- Destruction of the base results in instant defeat
- Bases are **invisible on the grand map** unless discovered
- Prevents static base rushing and encourages maneuver warfare

### Base Buildings
- HQ
- Barracks
- Armory
- Fuel Depot
- Medical Center
- Vehicle Depot
- Helipad

---

## Factions

### MACV (US)
- Strong air mobility
- Transport helicopters
- Can deploy **MACV-SOG** special forces:
  - 2–4 soldiers
  - Invisible on the grand map
  - Cannot capture tiles
  - Mixed US and NVA equipment

### NVA
- Can set up camps on any tile, including enemy-controlled tiles
- Infantry squads have +1 soldier

---

## Ambush System

- Ambushes are **player-controlled**
- When an enemy enters an ambush tile:
  - A timer icon appears
  - Player chooses whether to trigger combat
- Ambushers enter battle from a selected edge
- Enemy units continue normal movement until contact

---

## Map Editor (Editor-First Design)

Procedural generation is intentionally avoided.

The project includes a **manual map editor**:
- **Grand Map Editor**
  - Ground / water tiles
- **Battle Map Editor (per tile)**
  - Ground
  - Trees
  - Rocks

Hand-authored maps ensure meaningful ambushes and intentional terrain design.

---

## Design Philosophy

- No frontlines
- No safe backline
- No infinite resources
- Positioning and logistics matter more than statistics
- Brutal outcomes are intentional

> If supply hits zero, that’s on you.  
> If fuel runs out in enemy territory, you’re infantry now.

---

## Project Status

Early development.

Current focus:
- Core mechanics
- Map tools
- Performance-friendly systems

Content expansion and polish come later.

---

### About GoDot
See [GoDot Game Engine](https://godotengine.org).