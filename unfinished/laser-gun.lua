-- Laser Gun and Laser Ammo
-- Laser gun uses only laser ammo, deals laser damage similar to uranium rounds

local gunUtils = require("utils/GunUtils")
local ammoUtils = require("utils/AmmoUtils")
local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")

local makeGun = gunUtils.makeGun
local makeAmmo = ammoUtils.makeAmmo
local makeRecipe = recipeUtils.makeRecipe
local addEffectToTech = technologyUtils.addEffectToTech

-- Laser Gun (based on assault rifle sprites)
local laserGun = makeGun(
  {
    name = "laser-gun",
    icon = "__base__/graphics/icons/assault-rifle.png",
    iconSize = 64,
    order = "d[laser-gun]"
  },
  {
    type = "projectile",
    ammo_category = "laser-ammo",
    cooldown = 5,
    movement_slow_down_factor = 0.95,
    damage_modifier = 1.0,
    gun_center_shift = {
      north = {0, 0},
      east = {0.15625, 0},
      south = {0, 0},
      west = {-0.15625, 0}
    },
    gun_barrel_shift = {
      north = {0, -0.40625},
      east = {0.40625, 0},
      south = {0, 0.40625},
      west = {-0.40625, 0}
    }
  }
)

-- Laser Ammo (uses regular ammo sprite)
local laserAmmo = makeAmmo({
  name = "laser-ammo",
  icon = "__base__/graphics/icons/piercing-rounds-magazine.png",
  order = "b[laser]",
  magSize = 1,
  stackSize = 200,
  ammo_category = "laser-ammo",
  ammoType = {
    category = "laser-ammo",
    action = {
      {
        type = "direct",
        action_delivery = {
          type = "projectile",
          projectile = "laser-ammo-projectile-rampant-arsenal",
          starting_speed = 0.5
        }
      }
    }
  }
})

-- Laser Projectile (laser damage, similar damage to uranium rounds)
data:extend({
  {
    type = "projectile",
    name = "laser-ammo-projectile-rampant-arsenal",
    flags = {"not-on-map"},
    hidden = true,
    collision_box = {{-0.3, -0.3}, {0.3, 0.3}},
    acceleration = 0,
    direction_only = true,
    piercing_damage = 5,
    action = {
      type = "direct",
      action_delivery = {
        type = "instant",
        target_effects = {
          {
            type = "damage",
            damage = {amount = 35, type = "laser"}
          },
          {
            type = "create-entity",
            entity_name = "explosion-gunshot"
          }
        }
      }
    },
    animation = {
      filename = "__base__/graphics/entity/bullet/bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
      priority = "high",
      tint = {r = 1, g = 0.2, b = 0.2, a = 1}
    },
    shadow = {
      filename = "__base__/graphics/entity/bullet/bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
      priority = "high"
    }
  }
})

-- Laser Ammo Recipe
makeRecipe({
  name = laserAmmo,
  icon = "__base__/graphics/icons/piercing-rounds-magazine.png",
  enabled = false,
  category = "crafting",
  ingredients = {
    {type = "item", name = "copper-plate", amount = 2},
    {type = "item", name = "iron-plate", amount = 1},
    {type = "item", name = "electronic-circuit", amount = 1},
    {type = "item", name = "firearm-magazine", amount = 1}
  },
  result = laserAmmo
})

-- Laser Gun Recipe
makeRecipe({
  name = laserGun,
  icon = "__base__/graphics/icons/assault-rifle.png",
  enabled = false,
  category = "crafting",
  ingredients = {
    {type = "item", name = "iron-plate", amount = 5},
    {type = "item", name = "copper-plate", amount = 5},
    {type = "item", name = "electronic-circuit", amount = 3}
  },
  result = laserGun
})

-- Add techs
addEffectToTech("automated-gun-turret-2",
  {
    type = "unlock-recipe",
    recipe = laserGun
  }
)

addEffectToTech("uranium-ammo",
  {
    type = "unlock-recipe",
    recipe = laserAmmo
  }
)
