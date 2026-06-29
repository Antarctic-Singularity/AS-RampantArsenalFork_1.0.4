-- Custom short-lived fire for super cluster rocket
-- Shorter lifetime than standard fire-flame (300 ticks = 5 seconds)
data:extend({
  {
    type = "fire",
    name = "super-cluster-fire-rampant-arsenal",
    localised_name = {"", "Super cluster fire"},
    flags = {"placeable-off-grid", "not-on-map"},
    damage_per_tick = {amount = 0.5, type = "fire"},
    maximum_damage_to_tiles = 0.5,
    spread_delay = 8,
    spread_delay_deviation = 5,
    lifetime = 300,
    damage_multiplier_tick_rate = 60,
    on_fuel_depleted_damage_multiplier = 0,
    sound = {
      filename = "__base__/sound/burning.ogg",
      volume = 0.5
    },
    animation = {
      filename = "__base__/graphics/entity/fire/fire-13-13.png",
      priority = "high",
      width = 13,
      height = 13,
      frame_count = 8,
      line_length = 4,
      animation_speed = 0.3
    },
    smoke = {
      {
        name = "fire-smoke",
        deviation = {0.5, 0.5},
        frequency = 2,
        position = {0, 0},
        starting_frame = 0,
        starting_frame_deviation = 10,
        starting_frame_speed = 1,
        starting_frame_speed_deviation = 5,
        speed_from_center = 0.1,
        speed_from_center_deviation = 0.05
      }
    }
  }
})

-- Cluster Missile - Spawns 7 grenades on detonation
-- Per grenade: 35 explosion damage in 6.5 radius
-- Total: 245 explosion damage spread across 7 locations

data:extend({
  {
    type = "projectile",
    name = "cluster-missile-rampant-arsenal",
    flags = {"not-on-map"},
    hidden = true,
    acceleration = 0.005,
    action = {
      {
        type = "direct",
        action_delivery = {
          type = "instant",
          target_effects = {
            {type = "create-entity", entity_name = "grenade-explosion"},
            {type = "create-entity", entity_name = "small-scorchmark-tintable",
             check_buildability = true}
          }
        }
      },
      {
        type = "cluster",
        cluster_count = 7,
        distance = 4,
        distance_deviation = 3,
        action_delivery = {
          type = "projectile",
          projectile = "grenade",
          direction_deviation = 0.6,
          starting_speed = 0.25,
          starting_speed_deviation = 0.3
        }
      }
    },
    animation = {
      layers = {
        util.sprite_load("__base__/graphics/entity/rocket/rocket", {
          scale = 0.5,
          repeat_count = 8,
          frame_count = 1,
          rotate_shift = true,
          priority = "high"
        }),
        util.sprite_load("__base__/graphics/entity/rocket/rocket-tinted-tip", {
          scale = 0.5,
          repeat_count = 8,
          frame_count = 1,
          rotate_shift = true,
          priority = "high",
          tint = {r = 1, g = 0.5, b = 0}
        }),
        util.sprite_load("__base__/graphics/entity/rocket/rocket-lights", {
          blend_mode = "additive",
          draw_as_glow = true,
          scale = 0.5,
          frame_count = 8,
          rotate_shift = true,
          priority = "high",
        }),
      }
    },
    shadow = util.sprite_load("__base__/graphics/entity/rocket/rocket", {
      draw_as_shadow = true,
      scale = 0.5,
      frame_count = 1,
      rotate_shift = true,
      priority = "high"
    }),
    smoke = {
      {
        name = "smoke-fast",
        deviation = {0.15, 0.15},
        frequency = 1,
        position = {0, 1},
        slow_down_factor = 1,
        starting_frame = 3,
        starting_frame_deviation = 5,
        starting_frame_speed = 0,
        starting_frame_speed_deviation = 5
      }
    }
  },

  -- Incendiary Cluster Missile - Spawns 7 clusters of fire
  -- Per cluster: 120 fire damage + 15 explosion damage in 6.5 radius + 4 ground flames
  -- Total: 840 fire + 105 explosion damage spread across 7 locations
  {
    type = "projectile",
    name = "incendiary-cluster-missile-rampant-arsenal",
    flags = {"not-on-map"},
    hidden = true,
    acceleration = 0.005,
    action = {
      {
        type = "direct",
        action_delivery = {
          type = "instant",
          target_effects = {
            {type = "create-entity", entity_name = "explosion"},
            {type = "create-entity", entity_name = "small-scorchmark-tintable",
             check_buildability = true}
          }
        }
      },
      {
        type = "cluster",
        cluster_count = 7,
        distance = 4,
        distance_deviation = 3,
        action_delivery = {
          type = "instant",
          target_effects = {
            {
              type = "create-fire",
              entity_name = "fire-flame",
              initial_ground_flame_count = 4,
              check_buildability = true,
              show_in_tooltip = true
            },
            {
              type = "damage",
              damage = {amount = 120, type = "fire"},
              apply_damage_to_trees = false
            },
            {
              type = "damage",
              damage = {amount = 15, type = "explosion"},
              apply_damage_to_trees = false
            }
          }
        }
      }
    },
    animation = {
      layers = {
        util.sprite_load("__base__/graphics/entity/rocket/rocket", {
          scale = 0.5,
          repeat_count = 8,
          frame_count = 1,
          rotate_shift = true,
          priority = "high"
        }),
        util.sprite_load("__base__/graphics/entity/rocket/rocket-tinted-tip", {
          scale = 0.5,
          repeat_count = 8,
          frame_count = 1,
          rotate_shift = true,
          priority = "high",
          tint = {r = 1.0, g = 0.3, b = 0}
        }),
        util.sprite_load("__base__/graphics/entity/rocket/rocket-lights", {
          blend_mode = "additive",
          draw_as_glow = true,
          scale = 0.5,
          frame_count = 8,
          rotate_shift = true,
          priority = "high",
        }),
      }
    },
    shadow = util.sprite_load("__base__/graphics/entity/rocket/rocket", {
      draw_as_shadow = true,
      scale = 0.5,
      frame_count = 1,
      rotate_shift = true,
      priority = "high"
    }),
    smoke = {
      {
        name = "smoke-fast",
        deviation = {0.15, 0.15},
        frequency = 1,
        position = {0, 1},
        slow_down_factor = 1,
        starting_frame = 3,
        starting_frame_deviation = 5,
        starting_frame_speed = 0,
        starting_frame_speed_deviation = 5
      }
    }
  },

  -- Super Cluster Rocket - Spawns 7 clusters of high-damage explosions
  -- Per cluster: 350 explosion damage in 6.5 radius + push-back
  -- Total: 2450 explosion damage spread across 7 locations
  -- Based on HE grenade (550 damage) balanced for clustering
  {
    type = "projectile",
    name = "super-cluster-rocket-rampant-arsenal",
    flags = {"not-on-map"},
    hidden = true,
    acceleration = 0.005,
    action = {
      {
        type = "direct",
        action_delivery = {
          type = "instant",
          target_effects = {
            {type = "create-entity", entity_name = "big-explosion"},
            {type = "create-entity", entity_name = "small-scorchmark-tintable",
             check_buildability = true}
          }
        }
      },
      {
        type = "cluster",
        cluster_count = 7,
        distance = 4,
        distance_deviation = 3,
        action_delivery = {
          type = "instant",
          target_effects = {
            {
              type = "damage",
              damage = {amount = 350, type = "explosion"}
            },
            {
              type = "damage",
              damage = {amount = 25, type = "fire"},
              apply_damage_to_trees = false
            },
            {
              type = "push-back",
              distance = 1
            },
            {
              type = "create-fire",
              entity_name = "super-cluster-fire-rampant-arsenal",
              initial_ground_flame_count = 3,
              check_buildability = true,
              show_in_tooltip = true
            },
            {
              type = "create-entity",
              entity_name = "medium-explosion"
            }
          }
        }
      }
    },
    animation = {
      layers = {
        util.sprite_load("__base__/graphics/entity/rocket/rocket", {
          scale = 0.5,
          repeat_count = 8,
          frame_count = 1,
          rotate_shift = true,
          priority = "high"
        }),
        util.sprite_load("__base__/graphics/entity/rocket/rocket-tinted-tip", {
          scale = 0.5,
          repeat_count = 8,
          frame_count = 1,
          rotate_shift = true,
          priority = "high",
          tint = {r = 0.2, g = 0.2, b = 1}
        }),
        util.sprite_load("__base__/graphics/entity/rocket/rocket-lights", {
          blend_mode = "additive",
          draw_as_glow = true,
          scale = 0.5,
          frame_count = 8,
          rotate_shift = true,
          priority = "high",
        }),
      }
    },
    shadow = util.sprite_load("__base__/graphics/entity/rocket/rocket", {
      draw_as_shadow = true,
      scale = 0.5,
      frame_count = 1,
      rotate_shift = true,
      priority = "high"
    }),
    smoke = {
      {
        name = "smoke-fast",
        deviation = {0.15, 0.15},
        frequency = 1,
        position = {0, 1},
        slow_down_factor = 1,
        starting_frame = 3,
        starting_frame_deviation = 5,
        starting_frame_speed = 0,
        starting_frame_speed_deviation = 5
      }
    }
  }
})

-- Recipes for cluster missiles
-- Cluster Missile Recipe
-- Based on explosive-rocket + cluster grenade
-- More expensive than HE rocket (1 explosive-rocket + 1 steel + 6 explosives)
data:extend({
  {
    type = "recipe",
    name = "cluster-missile-rampant-arsenal",
    category = "crafting",
    enabled = false,
    ingredients = {
      {type = "item", name = "explosive-rocket", amount = 1},
      {type = "item", name = "steel-plate", amount = 2},
      {type = "item", name = "explosives", amount = 8}
    },
    results = {{type = "item", name = "cluster-missile-rampant-arsenal", amount = 1}},
    energy_required = 5
  }
})

-- Incendiary Cluster Missile Recipe (more expensive than both)
data:extend({
  {
    type = "recipe",
    name = "incendiary-cluster-missile-rampant-arsenal",
    category = "crafting-with-fluid",
    enabled = false,
    ingredients = {
      {type = "item", name = "cluster-missile-rampant-arsenal", amount = 1},
      {type = "item", name = "steel-plate", amount = 3},
      {type = "item", name = "explosives", amount = 4},
      {type = "fluid", name = "light-oil", amount = 60}
    },
    results = {{type = "item", name = "incendiary-cluster-missile-rampant-arsenal", amount = 1}},
    energy_required = 8
  }
})

-- Super Cluster Rocket Recipe (very expensive, based on HE grenade damage)
data:extend({
  {
    type = "recipe",
    name = "super-cluster-rocket-rampant-arsenal",
    category = "crafting",
    enabled = false,
    ingredients = {
      {type = "item", name = "explosive-rocket", amount = 2},
      {type = "item", name = "steel-plate", amount = 5},
      {type = "item", name = "explosives", amount = 15},
      {type = "item", name = "processing-unit", amount = 2}
    },
    results = {{type = "item", name = "super-cluster-rocket-rampant-arsenal", amount = 1}},
    energy_required = 10
  }
})

-- Create ammo items for the missiles
data:extend({
  {
    type = "ammo",
    name = "cluster-missile-rampant-arsenal",
    icon = "__RampantArsenalFork__/graphics/icons/he-rocket.png",
    ammo_category = "rocket",
    ammo_type = {
      category = "rocket",
      action = {
        {
          type = "direct",
          action_delivery = {
            type = "instant",
            source_effects = {
              {
                type = "create-explosion",
                entity_name = "explosion-gunshot"
              }
            }
          }
        },
        {
          type = "direct",
          action_delivery = {
            type = "projectile",
            starting_speed = 0.1,
            projectile = "cluster-missile-rampant-arsenal"
          }
        }
      }
    },
    stack_size = 200,
    order = "d[rocket-launcher]-c[cluster]"
  },
  {
    type = "ammo",
    name = "incendiary-cluster-missile-rampant-arsenal",
    icon = "__RampantArsenalFork__/graphics/icons/incendiary-rocket.png",
    ammo_category = "rocket",
    ammo_type = {
      category = "rocket",
      action = {
        {
          type = "direct",
          action_delivery = {
            type = "instant",
            source_effects = {
              {
                type = "create-explosion",
                entity_name = "explosion-gunshot"
              }
            }
          }
        },
        {
          type = "direct",
          action_delivery = {
            type = "projectile",
            starting_speed = 0.1,
            projectile = "incendiary-cluster-missile-rampant-arsenal"
          }
        }
      }
    },
    stack_size = 200,
    order = "d[rocket-launcher]-c[cluster-incendiary]"
  },
  {
    type = "ammo",
    name = "super-cluster-rocket-rampant-arsenal",
    icon = "__RampantArsenalFork__/graphics/icons/he-rocket.png",
    ammo_category = "rocket",
    ammo_type = {
      category = "rocket",
      action = {
        {
          type = "direct",
          action_delivery = {
            type = "instant",
            source_effects = {
              {
                type = "create-explosion",
                entity_name = "explosion-gunshot"
              }
            }
          }
        },
        {
          type = "direct",
          action_delivery = {
            type = "projectile",
            starting_speed = 0.1,
            projectile = "super-cluster-rocket-rampant-arsenal"
          }
        }
      }
    },
    stack_size = 100,
    order = "d[rocket-launcher]-c[super-cluster]"
  }
})
