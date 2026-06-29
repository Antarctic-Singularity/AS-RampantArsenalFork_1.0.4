-- Cluster missile that spawns grenades on detonation
-- Uses the same clustering parameters as the official Factorio cluster grenade

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
  }
})
