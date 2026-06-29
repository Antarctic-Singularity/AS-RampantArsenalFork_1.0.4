-- Splinter Rounds - Similar damage to uranium rounds but with AOE splash on impact
-- Like Age of Empires 2 arrows - creates area damage where projectile lands

local projectileUtils = require("utils/ProjectileUtils")
local ammoUtils = require("utils/AmmoUtils")
local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")

local makeAmmo = ammoUtils.makeAmmo
local makeShotgunProjectile = projectileUtils.makeShotgunProjectile
local makeRecipe = recipeUtils.makeRecipe
local addEffectToTech = technologyUtils.addEffectToTech

-- Splinter projectile with AOE splash damage
local splinterProjectile = makeShotgunProjectile({
  name = "splinter",
  collisionBox = {{-0.3, -0.3}, {0.3, 0.3}},
  acceleration = 0,
  directionOnly = true,
  piercingDamage = 5,
  tint = {r = 0.6, g = 0.6, b = 0.4},
  action = {
    {
      type = "direct",
      action_delivery = {
        type = "instant",
        target_effects = {
          {
            type = "damage",
            damage = {amount = 35, type = "physical"}
          },
          {
            type = "create-entity",
            entity_name = "explosion-gunshot"
          }
        }
      }
    },
    {
      type = "area",
      radius = 4,
      action_delivery = {
        type = "instant",
        target_effects = {
          {
            type = "damage",
            damage = {amount = 15, type = "physical"}
          },
          {
            type = "create-entity",
            entity_name = "small-explosion"
          }
        }
      }
    }
  }
})

-- Splinter Rounds ammo
local splinterRoundsAmmo = makeAmmo({
  name = "splinter-rounds",
  icon = "__RampantArsenalFork__/graphics/icons/piercing-rounds-magazine.png",
  order = "b[splinter]",
  magSize = 1,
  stackSize = 200,
  ammo_category = "bullet",
  ammoType = {
    category = "bullet",
    action = {
      {
        type = "direct",
        action_delivery = {
          type = "projectile",
          projectile = splinterProjectile,
          starting_speed = 0.5
        }
      }
    }
  }
})

-- Splinter Rounds Recipe (more expensive than uranium rounds)
makeRecipe({
  name = splinterRoundsAmmo,
  icon = "__RampantArsenalFork__/graphics/icons/piercing-rounds-magazine.png",
  enabled = false,
  category = "crafting",
  ingredients = {
    {type = "item", name = "uranium-238", amount = 2},
    {type = "item", name = "copper-plate", amount = 5},
    {type = "item", name = "steel-plate", amount = 2},
    {type = "item", name = "firearm-magazine", amount = 1}
  },
  result = splinterRoundsAmmo
})

-- Add to uranium ammo tech (since it's at similar tier)
addEffectToTech("uranium-ammo", {
  type = "unlock-recipe",
  recipe = splinterRoundsAmmo
})
