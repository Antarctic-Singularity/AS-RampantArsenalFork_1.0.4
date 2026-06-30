# Military Rebalance Plan

## Overview
This document outlines all planned rebalances for Rampant Arsenal military items, focusing on stack size adjustments to balance late-game ammunition consumption.

## Stack Size Changes

### Bullet Type Ammo
All bullet-based ammunition types (including new variants)
- **New Stack Size:** 20
- **Current Stack Size:** 200 (vanilla)
- **Affected Items:**
  - Regular rounds
  - Piercing rounds
  - Explosive rounds
  - Uranium rounds
  - Splinter rounds
  - Laser ammo

### Rockets
Standard rocket-based ammunition
- **New Stack Size:** 10
- **Current Stack Size:** 200 (current Rampant Arsenal)
- **Affected Items:**
  - Incendiary rockets
  - HE rockets
  - Bio rockets

### Cluster Missiles
Special cluster rocket ammunition
- **New Stack Size:** 5 (regular and incendiary)
- **Current Stack Size:** 200 (current Rampant Arsenal)
- **Affected Items:**
  - Cluster missiles
  - Incendiary cluster missiles

### Super Cluster Rocket
High-end cluster rocket ammunition
- **New Stack Size:** 2
- **Current Stack Size:** 100 (new items)
- **Affected Items:**
  - Super cluster rockets

### Grenades
All grenade ammunition types
- **New Stack Size:** 10
- **Current Stack Size:** 200 (current Rampant Arsenal)
- **Affected Items:**
  - Incendiary grenades
  - HE grenades
  - Bio grenades

### Capsules
All capsule ammunition
- **New Stack Size:** 10
- **Current Stack Size:** 200 (current Rampant Arsenal)
- **Affected Items:**
  - All capsule variants

### Grenade Launcher Ammo
Rampant Arsenal grenade launcher ammunition
- **New Stack Size:** 5
- **Current Stack Size:** 200 (current Rampant Arsenal)
- **Affected Items:**
  - All grenade launcher ammo types

### Shotgun Shells
All shotgun ammunition
- **New Stack Size:** 20
- **Current Stack Size:** 200 (current Rampant Arsenal)
- **Affected Items:**
  - Shotgun shells (all variants)
  - Uranium shotgun shells
  - Incendiary shotgun shells

### Cannon Shells
All cannon ammunition
- **New Stack Size:** 10
- **Current Stack Size:** 200 (current Rampant Arsenal)
- **Affected Items:**
  - Cannon shells (all variants)
  - Uranium cannon shells
  - Explosive uranium cannon shells

### Artillery Shells
Artillery-based ammunition
- **New Stack Size:** 1
- **Current Stack Size:** 10 (current Rampant Arsenal - already low)
- **Affected Items:**
  - All artillery shell variants

### Laser Ammo
New laser weapon ammunition
- **New Stack Size:** 20
- **Current Stack Size:** 200 (new items)
- **Affected Items:**
  - Laser ammo (regular gun)
  - Laser minigun ammo

### Landmines
Landmine items
- **New Stack Size:** 20
- **Current Stack Size:** 100 (current Rampant Arsenal)
- **Affected Items:**
  - All landmine variants

### Turret Capsules
Capsule turret ammunition
- **New Stack Size:** 10
- **Current Stack Size:** 200 (current Rampant Arsenal)
- **Affected Items:**
  - All turret capsule variants

### Flamethrower Ammo
Flamethrower fuel/ammunition
- **New Stack Size:** 10
- **Current Stack Size:** 200 (current Rampant Arsenal)
- **Affected Items:**
  - All flamethrower ammo variants

## Magazine/Case System

### Rocket Cases
Magazine-style containers for rockets
- **Purpose:** Hold multiple rockets in a single item stack slot
- **Case Types:**
  - Standard rocket case (holds 5 rockets)
  - Incendiary rocket case (holds 5 rockets)
  - HE rocket case (holds 5 rockets)
  - Bio rocket case (holds 5 rockets)
  - Cluster missile case (holds 3)
  - Incendiary cluster case (holds 3)
  - Super cluster case (holds 2)
- **Crafting Requirements:** Plastic + Iron/Steel
- **Mechanics:** Cases are consumed when used (like magazines), need to be crafted fresh

### Cannon Cases
Magazine-style containers for cannon shells
- **Purpose:** Hold multiple cannon shells in a single item stack slot
- **Case Types:**
  - Standard cannon case (holds 10 shells)
  - Explosive cannon case (holds 10 shells)
  - Uranium cannon case (holds 10 shells)
  - Explosive uranium case (holds 10 shells)
- **Crafting Requirements:** Plastic + Iron/Steel
- **Mechanics:** Cases are consumed when used, need constant supply

### Case Crafting
All cases require:
- **Primary material:** Plastic or Low-Density Structure
- **Secondary material:** Iron/Steel plates
- **Result:** Reduces ammo spam, creates meaningful supply chain
- **Example Recipe:**
  - Rocket case: 5 plastic + 2 iron plate → rocket case (empty)
  - Filled at workbench or by hand

## Drum Magazine System

### Concept
Special high-capacity magazines for minigun-style weapons to hold more ammunition per magazine.

### Drum Magazine Types
- **Standard Drum Magazine**
  - Stack Size: 1
  - Capacity: 50 rounds (vs magazine default of ~10)
  - Required for: Minigun, Laser minigun
  - Crafting: Plastic + Steel + Iron gears
  - Purpose: High-capacity ammo storage for sustained fire

- **Optional Support** (if Modular Turrets mod is installed)
  - Gatling turret drum magazine (150 round capacity)
  - Stack Size: 1
  - Same crafting requirements, scaled to turret capacity

### Drum Magazine Mechanics
- Drum magazines are single-use items (like cases)
- Required to use miniguns/gatling turrets effectively
- Creates ongoing crafting requirement for late-game
- Balances high fire rate with ammo consumption

### Crafting Recipe Example
Standard drum magazine:
- 10 plastic
- 5 steel plate
- 2 iron gear
→ 1 drum magazine (empty)

## Rationale
- Reduces late-game ammo spam and inventory bloat
- Creates more meaningful logistics and supply chain decisions
- Makes ammunition weight/storage more impactful
- Encourages player to plan ammo production and supply
- Maintains balance between different weapon types
- Cases create intermediate crafting step for late-game gameplay

## Implementation Status
- [ ] Bullet type ammo stack sizes (20)
- [ ] Rocket stack sizes (10)
- [ ] Cluster missile stack sizes (5)
- [ ] Super cluster rocket stack sizes (2)
- [ ] Grenade stack sizes (10)
- [ ] Capsule stack sizes (10)
- [ ] Grenade launcher ammo stack sizes (5)
- [ ] Shotgun shells stack sizes (20)
- [ ] Cannon shells stack sizes (10)
- [ ] Artillery shells stack sizes (1)
- [ ] Laser ammo stack sizes (20)
- [ ] Landmines stack sizes (20)
- [ ] Turret capsules stack sizes (10)
- [ ] Flamethrower ammo stack sizes (10)
- [ ] Rocket case system design
  - [ ] Standard rocket cases
  - [ ] Incendiary rocket cases
  - [ ] HE rocket cases
  - [ ] Bio rocket cases
  - [ ] Cluster missile cases
  - [ ] Super cluster missile cases
- [ ] Cannon case system design
  - [ ] Standard cannon cases
  - [ ] Explosive cannon cases
  - [ ] Uranium cannon cases
  - [ ] Explosive uranium cannon cases
- [ ] Case crafting recipes
- [ ] Case filling/loading mechanics
- [ ] Integration with turrets/guns
- [ ] Drum magazine system design
  - [ ] Standard drum magazine (50 round capacity)
  - [ ] Gatling turret drum magazine (150 round capacity - optional)
- [ ] Drum magazine crafting recipes
- [ ] Minigun/laser minigun integration with drums
- [ ] Optional modular turrets gatling support
- [ ] Testing and balance validation
