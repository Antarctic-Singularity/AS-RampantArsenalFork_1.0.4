-- Copyright (C) 2022  veden

-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.


local rockets = {}

local turretUtils = require("utils/TurretUtils")
local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local projectileUtils = require("utils/ProjectileUtils")
local ammoUtils = require("utils/AmmoUtils")

local makeAmmo = ammoUtils.makeAmmo
local addEffectToTech = technologyUtils.addEffectToTech
local makeRocketProjectile = projectileUtils.makeRocketProjectile
local makeRecipe = recipeUtils.makeRecipe
local makeAmmoTurret = turretUtils.makeAmmoTurret

local function rocketSheetMk1()
    return
        {
            layers =
                {
                    {
                        filename = "__RampantArsenalFork__/graphics/yuokiTani/entities/rocket-mk1-sheet.png",
                        priority = "high",
                        width = 72,
                        height = 80,
                        line_length = 16,
                        axially_symmetrical = false,
                        direction_count = 64,
                        frame_count = 1,
                        shift = {0.35, 0},
                    }
                }
        }

end

local function rocketSheetMk2()
    return
        {
            layers =
                {
                    {
                        filename = "__RampantArsenalFork__/graphics/yuokiTani/entities/rocket-mk2-sheet.png",
                        priority = "high",
                        width = 88,
                        height = 80,
                        line_length = 16,
                        axially_symmetrical = false,
                        direction_count = 64,
                        frame_count = 1,
                        shift = {0.1, -0.15},
                    }
                }
        }

end

function rockets.enable()

    local entity = {
        name = "rocket",
        icon = "__RampantArsenalFork__/graphics/icons/rocketTurret.png",
        miningTime = 1,
        health = 800,
        order = "b[turret]-a[zzzracket-turret]",
        collisionBox = {{-0.75, -0.75}, {0.75, 0.75}},
        selectionBox = {{-0.5, -1}, {0.5, 1}},
        foldedAnimation = rocketSheetMk1(),
        foldingAnimation = rocketSheetMk1(),
        preparedAnimation = rocketSheetMk1(),
        preparingAnimation = rocketSheetMk1(),
        hasBaseDirection = true,
        rotationSpeed = 0.002,
        resistances = {
            {
                type = "fire",
                percent = 60
            },
            {
                type = "impact",
                percent = 30
            },
            {
                type = "explosion",
                percent = 10
            },
            {
                type = "physical",
                percent = 10
            },
            {
                type = "acid",
                percent = 30
            },
            {
                type = "electric",
                percent = 60
            },
            {
                type = "laser",
                percent = 60
            },
            {
                type = "poison",
                percent = 30
            }
        }
    }
    local rocketTurret, rocketTurretItem = makeAmmoTurret(entity,
                                                          {
                                                              type = "projectile",
                                                              ammo_category = "rocket", ammo_categories = {"rocket", "x-cluster-rocket"},
                                                              cooldown = 300,
                                                              projectile_creation_distance = 1.39375,
                                                              projectile_center = {0, -0.0875},
                                                              min_range = 20,
                                                              turn_range = 0.30,
                                                              range = 52,
                                                              sound = {
                                                                  {
                                                                      filename = "__base__/sound/fight/rocket-launcher.ogg",
                                                                      volume = 0.7
                                                                  }
                                                              }
    })

    local entity1 = {
        name = "rapid-rocket",
        icon = "__RampantArsenalFork__/graphics/icons/rapidRocketTurret.png",
        miningTime = 1,
        health = 1800,
        order = "b[turret]-a[zzzrzcket-turret]",
        foldedAnimation = rocketSheetMk2(),
        foldingAnimation = rocketSheetMk2(),
        preparedAnimation = rocketSheetMk2(),
        preparingAnimation = rocketSheetMk2(),
        hasBaseDirection = true,
        rotationSpeed = 0.005,
        resistances = {
            {
                type = "fire",
                percent = 60
            },
            {
                type = "impact",
                percent = 30
            },
            {
                type = "explosion",
                percent = 10
            },
            {
                type = "physical",
                percent = 10
            },
            {
                type = "acid",
                percent = 30
            },
            {
                type = "electric",
                percent = 60
            },
            {
                type = "laser",
                percent = 60
            },
            {
                type = "poison",
                percent = 30
            }
        }
    }
    local rapidRocketTurret, rapidRocketTurretItem = makeAmmoTurret(entity1, {
                                                                        type = "projectile",
                                                                        ammo_category = "rocket", ammo_categories = {"rocket", "x-cluster-rocket"},
                                                                        cooldown = 50,
                                                                        projectile_creation_distance = 1.39375,
                                                                        projectile_center = {0, -0.0875},
                                                                        min_range = 20,
                                                                        turn_range = 0.30,
                                                                        range = 42,
                                                                        sound = {
                                                                            {
                                                                                filename = "__base__/sound/fight/rocket-launcher.ogg",
                                                                                volume = 0.7
                                                                            }
                                                                        }
    })

    makeRecipe({
            name = rocketTurretItem,
            icon = "__RampantArsenalFork__/graphics/icons/rocketTurret.png",
            enabled = false,
            ingredients = {
                {type = "item", name = "electronic-circuit", amount = 20},
                {type = "item", name = "steel-plate", amount = 10},
                {type = "item", name = "iron-gear-wheel", amount = 15}
            },
            result = rocketTurretItem,
    })

    makeRecipe({
            name = rapidRocketTurretItem,
            icon = "__RampantArsenalFork__/graphics/icons/rapidRocketTurret.png",
            enabled = false,
            ingredients = {
                {type = "item", name = "steel-plate", amount = 20},
                {type = "item", name = "productivity-module-3", amount = 1},
                {type = "item", name = "engine-unit", amount = 10},
                {type = "item", name = rocketTurretItem, amount = 1}
            },
            result = rapidRocketTurretItem,
    })

    addEffectToTech("rocket-turret-1",
                    {
                        type = "unlock-recipe",
                        recipe = rocketTurretItem,
    })


    addEffectToTech("rocket-turret-2",
                    {
                        type = "unlock-recipe",
                        recipe = rapidRocketTurretItem,
    })

    if settings.startup["rampant-arsenal-enableAmmoTypes"].value then

        local incendiaryRocketAmmo = makeAmmo({
                name = "incendiary-rocket",
                icon = "__RampantArsenalFork__/graphics/icons/incendiary-rocket.png",
                order = "d[rocket-launcher]-b[incendiary]",
                magSize = 1,
                stackSize = 200,
				ammo_category = "rocket",
                ammoType = {
                    category = "rocket",
                    action =
                        {
                            {
                                type = "direct",
                                action_delivery =
                                    {
                                        type = "instant",
                                        source_effects =
                                            {
                                                {
                                                    type = "create-explosion",
                                                    entity_name = "explosion-gunshot"
                                                }
                                            }
                                    }
                            },
                            {
                                type = "direct",
                                action_delivery =
                                    {
                                        type = "projectile",
                                        starting_speed = 0.1,
                                        projectile = makeRocketProjectile({
                                                name = "incendiary",
                                                action =
                                                    {
                                                        type = "direct",
                                                        action_delivery =
                                                            {
                                                                type = "instant",
                                                                target_effects =
                                                                    {
                                                                        {
                                                                            type = "nested-result",
                                                                            affects_target = true,
                                                                            action =
                                                                                {
                                                                                    {
                                                                                        type = "cluster",
                                                                                        cluster_count = 7,
                                                                                        distance = 4,
                                                                                        distance_deviation = 3,
                                                                                        action_delivery =
                                                                                            {
                                                                                                type = "instant",
                                                                                                target_effects =
                                                                                                    {
                                                                                                        {
                                                                                                            type = "create-fire",
                                                                                                            entity_name = "fire-flame",
                                                                                                            initial_ground_flame_count = 4,
                                                                                                            check_buildability = true,
                                                                                                            show_in_tooltip = true
                                                                                                        }
                                                                                                    }
                                                                                            }
                                                                                    },
                                                                                    {
                                                                                        type = "area",
                                                                                        radius = 6.5,
                                                                                        action_delivery =
                                                                                            {
                                                                                                type = "instant",
                                                                                                target_effects =
                                                                                                    {
                                                                                                        {
                                                                                                            type = "create-fire",
                                                                                                            entity_name = "fire-flame",
                                                                                                            initial_ground_flame_count = 7
                                                                                                        },
                                                                                                        {
                                                                                                            type = "create-sticker",
                                                                                                            sticker = "small-fire-sticker-rampant-arsenal"
                                                                                                        },
                                                                                                        {
                                                                                                            type = "damage",
                                                                                                            damage = {amount = 600 , type = "fire"},
                                                                                                            apply_damage_to_trees = false
                                                                                                        },
                                                                                                        {
                                                                                                            type = "damage",
                                                                                                            damage = {amount = 50 , type = "explosion"},
                                                                                                            apply_damage_to_trees = false
                                                                                                        }
                                                                                                    }
                                                                                            }
                                                                                    }
                                                                                }
                                                                        },
                                                                        {
                                                                            type = "invoke-tile-trigger",
                                                                            repeat_count = 1,
                                                                        },
                                                                        {
                                                                            type = "destroy-decoratives",
                                                                            from_render_layer = "decorative",
                                                                            to_render_layer = "object",
                                                                            include_soft_decoratives = true,
                                                                            include_decals = false,
                                                                            invoke_decorative_trigger = true,
                                                                            decoratives_with_trigger_only = false,
                                                                            radius = 3
                                                                        },
                                                                        {
                                                                            type = "create-entity",
                                                                            entity_name = "explosion"
                                                                        }
                                                                    }
                                                            }
                                                    }
                                        })
                                    }
                            }
                        }
                }
        })

        makeRecipe({
                name = incendiaryRocketAmmo,
                icon = "__RampantArsenalFork__/graphics/icons/incendiary-rocket.png",
                enabled = false,
                category = "crafting-with-fluid",
                ingredients = {
                    {type = "item", name = "explosive-rocket", amount = 1},
                    {type = "item", name = "steel-plate", amount = 1},
                    {type = "fluid", name = "light-oil", amount = 40}
                },
                result = incendiaryRocketAmmo,
        })

        addEffectToTech("incendiary-rockets",
                        {
                            type = "unlock-recipe",
                            recipe = incendiaryRocketAmmo,
        })

        local heRocketAmmo = makeAmmo({
                name = "he-rocket",
                icon = "__RampantArsenalFork__/graphics/icons/he-rocket.png",
                order = "d[rocket-launcher]-b[he]",
                magSize = 1,
                stackSize = 200,
				ammo_category = "rocket",
                ammoType = {
                    category = "rocket",
                    action =
                        {
                            {
                                type = "direct",
                                action_delivery =
                                    {
                                        type = "instant",
                                        source_effects =
                                            {
                                                {
                                                    type = "create-explosion",
                                                    entity_name = "explosion-gunshot"
                                                }
                                            }
                                    }
                            },
                            {
                                type = "direct",
                                action_delivery =
                                    {
                                        type = "projectile",
                                        starting_speed = 0.1,
                                        projectile = makeRocketProjectile({
                                                name = "he",
                                                action =
                                                    {
                                                        type = "direct",
                                                        action_delivery =
                                                            {
                                                                type = "instant",
                                                                target_effects =
                                                                    {
                                                                        {
                                                                            type = "nested-result",
                                                                            affects_target = true,
                                                                            action =
                                                                                {
                                                                                    type = "area",
                                                                                    radius = 6.5,
                                                                                    action_delivery =
                                                                                        {
                                                                                            type = "instant",
                                                                                            target_effects =
                                                                                                {
                                                                                                    {
                                                                                                        type = "push-back",
                                                                                                        distance = 1
                                                                                                    },
                                                                                                    {
                                                                                                        type = "damage",
                                                                                                        damage = {amount = 1050 , type = "explosion"}
                                                                                                    }
                                                                                                }
                                                                                        }
                                                                                }
                                                                        },
                                                                        {
                                                                            type = "invoke-tile-trigger",
                                                                            repeat_count = 1,
                                                                        },
                                                                        {
                                                                            type = "destroy-decoratives",
                                                                            from_render_layer = "decorative",
                                                                            to_render_layer = "object",
                                                                            include_soft_decoratives = true,
                                                                            include_decals = false,
                                                                            invoke_decorative_trigger = true,
                                                                            decoratives_with_trigger_only = false,
                                                                            radius = 3
                                                                        },
                                                                        {
                                                                            type = "create-entity",
                                                                            entity_name = "big-explosion"
                                                                        }
                                                                    }
                                                            }
                                                    }
                                        })
                                    }
                            }
                        }
                }
        })

        makeRecipe({
                name = heRocketAmmo,
                icon = "__RampantArsenalFork__/graphics/icons/he-rocket.png",
                enabled = false,
                category = "crafting",
                ingredients = {
                    {type = "item", name = "explosive-rocket", amount = 1},
                    {type = "item", name = "steel-plate", amount = 1},
                    {type = "item", name = "explosives", amount = 6}
                },
                result = heRocketAmmo,
        })

        addEffectToTech("he-rockets",
                        {
                            type = "unlock-recipe",
                            recipe = heRocketAmmo,
        })

        local bioRocketAmmo = makeAmmo({
                name = "bio-rocket",
                icon = "__RampantArsenalFork__/graphics/icons/bio-rocket.png",
                order = "d[rocket-launcher]-b[fbio]",
                magSize = 1,
                stackSize = 200,
				ammo_category = "rocket",
                ammoType = {
                    category = "rocket",
                    action =
                        {
                            {
                                type = "direct",
                                action_delivery =
                                    {
                                        type = "instant",
                                        source_effects =
                                            {
                                                {
                                                    type = "create-explosion",
                                                    entity_name = "explosion-gunshot"
                                                }
                                            }
                                    }
                            },
                            {
                                type = "direct",
                                action_delivery =
                                    {
                                        type = "projectile",
                                        starting_speed = 0.1,
                                        projectile = makeRocketProjectile({
                                                name = "bio",
                                                action =
                                                    {
                                                        type = "direct",
                                                        action_delivery =
                                                            {
                                                                type = "instant",
                                                                target_effects =
                                                                    {
                                                                        {
                                                                            type = "nested-result",
                                                                            affects_target = true,
                                                                            action =
                                                                                {
                                                                                    type = "area",
                                                                                    radius = 6.5,
                                                                                    action_delivery =
                                                                                        {
                                                                                            type = "instant",
                                                                                            target_effects =
                                                                                                {
                                                                                                    {
                                                                                                        type = "damage",
                                                                                                        damage = {amount = 600 , type = "poison"}
                                                                                                    },
                                                                                                    {
                                                                                                        type = "damage",
                                                                                                        damage = {amount = 50 , type = "explosion"}
                                                                                                    }
                                                                                                }
                                                                                        }
                                                                                }
                                                                        },
                                                                        {
                                                                            type = "invoke-tile-trigger",
                                                                            repeat_count = 1,
                                                                        },
                                                                        {
                                                                            type = "destroy-decoratives",
                                                                            from_render_layer = "decorative",
                                                                            to_render_layer = "object",
                                                                            include_soft_decoratives = true,
                                                                            include_decals = false,
                                                                            invoke_decorative_trigger = true,
                                                                            decoratives_with_trigger_only = false,
                                                                            radius = 3
                                                                        },
                                                                        {
                                                                            type = "create-entity",
                                                                            entity_name = "toxic-cloud-rampant-arsenal",
                                                                            show_in_tooltip = true
                                                                        },
                                                                        {
                                                                            type = "create-entity",
                                                                            entity_name = "big-explosion"
                                                                        }
                                                                    }
                                                            }
                                                    }
                                        })
                                    }
                            }
                        }
                }
        })

        makeRecipe({
                name = bioRocketAmmo,
                icon = "__RampantArsenalFork__/graphics/icons/bio-rocket.png",
                enabled = false,
                category = "crafting-with-fluid",
                ingredients = {
                    {type = "item", name = "explosive-rocket", amount = 1},
                    {type = "item", name = "steel-plate", amount = 1},
                    {type = "item", name = "poison-capsule", amount = 2}
                },
                result = bioRocketAmmo,
        })

        addEffectToTech("bio-rockets",
                        {
                            type = "unlock-recipe",
                            recipe = bioRocketAmmo,
        })

        -- Cluster missiles
        data:extend({
          {
            type = "ammo",
            name = "cluster-missile",
            icon = "__RampantArsenalFork__/graphics/icons/cluster-missile.png",
            icon_size = 32,
            order = "d[rocket-launcher]-c[cluster]",
            subgroup = "ammo",
            stack_size = 200,
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
                    projectile = makeRocketProjectile({
                      name = "cluster-missile",
                      action = {
                        type = "direct",
                        action_delivery = {
                          type = "instant",
                          target_effects = {
                            {
                              type = "nested-result",
                              affects_target = true,
                              action = {
                                {
                                  type = "area",
                                  radius = 5,
                                  action_delivery = {
                                    type = "instant",
                                    target_effects = {
                                      {
                                        type = "push-back",
                                        distance = 0.5
                                      },
                                      {
                                        type = "damage",
                                        damage = {amount = 300, type = "explosion"}
                                      }
                                    }
                                  }
                                },
                                {
                                  type = "cluster",
                                  cluster_count = 4,
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
                              }
                            },
                            {
                              type = "invoke-tile-trigger",
                              repeat_count = 1
                            },
                            {
                              type = "destroy-decoratives",
                              from_render_layer = "decorative",
                              to_render_layer = "object",
                              include_soft_decoratives = true,
                              include_decals = false,
                              invoke_decorative_trigger = true,
                              decoratives_with_trigger_only = false,
                              radius = 2
                            },
                            {
                              type = "create-entity",
                              entity_name = "medium-explosion"
                            }
                          }
                        }
                      }
                    })
                  }
                }
              }
            }
          }
        })

        local clusterMissileAmmo = "cluster-missile"

        makeRecipe({
                name = clusterMissileAmmo,
                subgroup = "ammo",
                enabled = false,
                category = "crafting",
                ingredients = {
                    {type = "item", name = "explosive-rocket", amount = 1},
                    {type = "item", name = "steel-plate", amount = 2},
                    {type = "item", name = "explosives", amount = 8}
                },
                result = clusterMissileAmmo,
        })

        addEffectToTech("cluster-missiles",
                        {
                            type = "unlock-recipe",
                            recipe = clusterMissileAmmo,
        })

        -- Incendiary cluster missile
        data:extend({
          {
            type = "ammo",
            name = "incendiary-cluster-missile",
            icon = "__RampantArsenalFork__/graphics/icons/incendiary-cluster-missile.png",
            icon_size = 32,
            order = "d[rocket-launcher]-c[cluster-incendiary]",
            subgroup = "ammo",
            stack_size = 200,
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
                    projectile = makeRocketProjectile({
                      name = "incendiary-cluster-missile",
                      action = {
                        type = "direct",
                        action_delivery = {
                          type = "instant",
                          target_effects = {
                            {
                              type = "nested-result",
                              affects_target = true,
                              action = {
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
                                      }
                                    }
                                  }
                                },
                                {
                                  type = "area",
                                  radius = 6.5,
                                  action_delivery = {
                                    type = "instant",
                                    target_effects = {
                                      {
                                        type = "create-fire",
                                        entity_name = "fire-flame",
                                        initial_ground_flame_count = 7
                                      },
                                      {
                                        type = "create-sticker",
                                        sticker = "small-fire-sticker-rampant-arsenal"
                                      },
                                      {
                                        type = "damage",
                                        damage = {amount = 300, type = "fire"},
                                        apply_damage_to_trees = false
                                      },
                                      {
                                        type = "damage",
                                        damage = {amount = 100, type = "explosion"},
                                        apply_damage_to_trees = false
                                      }
                                    }
                                  }
                                }
                              }
                            },
                            {
                              type = "invoke-tile-trigger",
                              repeat_count = 1
                            },
                            {
                              type = "destroy-decoratives",
                              from_render_layer = "decorative",
                              to_render_layer = "object",
                              include_soft_decoratives = true,
                              include_decals = false,
                              invoke_decorative_trigger = true,
                              decoratives_with_trigger_only = false,
                              radius = 3
                            },
                            {
                              type = "create-entity",
                              entity_name = "big-explosion"
                            }
                          }
                        }
                      }
                    })
                  }
                }
              }
            }
          }
        })

        local incendiaryClusterMissileAmmo = "incendiary-cluster-missile"

        makeRecipe({
                name = incendiaryClusterMissileAmmo,
                subgroup = "ammo",
                enabled = false,
                category = "crafting-with-fluid",
                time = 15,
                ingredients = {
                    {type = "item", name = "cluster-missile", amount = 1},
                    {type = "item", name = "steel-plate", amount = 5},
                    {type = "item", name = "explosives", amount = 6},
                    {type = "fluid", name = "light-oil", amount = 80}
                },
                result = incendiaryClusterMissileAmmo,
        })

        addEffectToTech("incendiary-cluster-missiles",
                        {
                            type = "unlock-recipe",
                            recipe = incendiaryClusterMissileAmmo,
        })

        -- Super cluster rocket
        data:extend({
          {
            type = "ammo",
            name = "super-cluster-rocket",
            icon = "__RampantArsenalFork__/graphics/icons/super-cluster-rocket.png",
            icon_size = 32,
            order = "d[rocket-launcher]-c[super-cluster]",
            subgroup = "ammo",
            stack_size = 100,
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
                    projectile = makeRocketProjectile({
                      name = "super-cluster-rocket",
                      action = {
                        type = "direct",
                        action_delivery = {
                          type = "instant",
                          target_effects = {
                            {
                              type = "nested-result",
                              affects_target = true,
                              action = {
                                {
                                  type = "cluster",
                                  cluster_count = 10,
                                  distance = 6,
                                  distance_deviation = 4,
                                  action_delivery = {
                                    type = "instant",
                                    target_effects = {
                                      {
                                        type = "damage",
                                        damage = {amount = 300, type = "explosion"}
                                      },
                                      {
                                        type = "push-back",
                                        distance = 1.5
                                      },
                                      {
                                        type = "create-entity",
                                        entity_name = "medium-explosion"
                                      }
                                    }
                                  }
                                },
                                {
                                  type = "area",
                                  radius = 8,
                                  action_delivery = {
                                    type = "instant",
                                    target_effects = {
                                      {
                                        type = "push-back",
                                        distance = 2
                                      },
                                      {
                                        type = "damage",
                                        damage = {amount = 1000, type = "explosion"}
                                      }
                                    }
                                  }
                                }
                              }
                            },
                            {
                              type = "invoke-tile-trigger",
                              repeat_count = 1
                            },
                            {
                              type = "destroy-decoratives",
                              from_render_layer = "decorative",
                              to_render_layer = "object",
                              include_soft_decoratives = true,
                              include_decals = false,
                              invoke_decorative_trigger = true,
                              decoratives_with_trigger_only = false,
                              radius = 4
                            },
                            {
                              type = "create-entity",
                              entity_name = "big-explosion"
                            }
                          }
                        }
                      }
                    })
                  }
                }
              }
            }
          }
        })

        local superClusterRocketAmmo = "super-cluster-rocket"

        makeRecipe({
                name = superClusterRocketAmmo,
                subgroup = "ammo",
                enabled = false,
                category = "crafting",
                time = 20,
                ingredients = {
                    {type = "item", name = "explosive-rocket", amount = 2},
                    {type = "item", name = "steel-plate", amount = 5},
                    {type = "item", name = "explosives", amount = 15},
                    {type = "item", name = "processing-unit", amount = 2}
                },
                result = superClusterRocketAmmo,
        })

        addEffectToTech("super-cluster-rockets",
                        {
                            type = "unlock-recipe",
                            recipe = superClusterRocketAmmo,
        })

        -- X Cluster missile (cloned from super-cluster-rocket, reusing the same sprites/tech)
        -- Own ammo category so hand-held rocket launchers cannot fire it
        data:extend({
          {
            type = "ammo-category",
            name = "x-cluster-rocket"
          },
          {
            type = "ammo",
            name = "x-cluster-missile",
            icon = "__RampantArsenalFork__/graphics/icons/super-cluster-rocket.png",
            icon_size = 32,
            order = "d[rocket-launcher]-c[x-cluster]",
            subgroup = "ammo",
            stack_size = 100,
            ammo_category = "x-cluster-rocket",
            ammo_type = {
              category = "x-cluster-rocket",
              cooldown_modifier = 1.5,
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
                    projectile = makeRocketProjectile({
                      name = "x-cluster-missile",
                      action = {
                        type = "direct",
                        action_delivery = {
                          type = "instant",
                          target_effects = {
                            {
                              type = "nested-result",
                              affects_target = true,
                              action = {
                                {
                                  type = "cluster",
                                  cluster_count = 25,
                                  distance = 9,
                                  distance_deviation = 6,
                                  action_delivery = {
                                    type = "instant",
                                    target_effects = {
                                      {
                                        type = "damage",
                                        damage = {amount = 175, type = "explosion"}
                                      },
                                      {
                                        type = "damage",
                                        damage = {amount = 350, type = "fire"}
                                      },
                                      {
                                        type = "push-back",
                                        distance = 1.5
                                      },
                                      {
                                        type = "create-fire",
                                        entity_name = "fire-flame",
                                        initial_ground_flame_count = 10
                                      },
                                      {
                                        type = "create-entity",
                                        entity_name = "medium-explosion"
                                      },
                                      {
                                        type = "nested-result",
                                        affects_target = true,
                                        action = {
                                          type = "cluster",
                                          cluster_count = 6,
                                          distance = 3,
                                          distance_deviation = 2,
                                          action_delivery = {
                                            type = "instant",
                                            target_effects = {
                                              {
                                                type = "damage",
                                                damage = {amount = 125, type = "explosion"}
                                              },
                                              {
                                                type = "damage",
                                                damage = {amount = 250, type = "fire"}
                                              },
                                              {
                                                type = "create-fire",
                                                entity_name = "fire-flame",
                                                initial_ground_flame_count = 6
                                              },
                                              {
                                                type = "create-sticker",
                                                sticker = "small-fire-sticker-rampant-arsenal"
                                              },
                                              {
                                                type = "create-entity",
                                                entity_name = "explosion"
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                },
                                {
                                  type = "area",
                                  radius = 24,
                                  action_delivery = {
                                    type = "instant",
                                    target_effects = {
                                      {
                                        type = "push-back",
                                        distance = 2.5
                                      },
                                      {
                                        type = "damage",
                                        damage = {amount = 650, type = "explosion"}
                                      },
                                      {
                                        type = "damage",
                                        damage = {amount = 1300, type = "fire"}
                                      },
                                      {
                                        type = "create-fire",
                                        entity_name = "fire-flame",
                                        initial_ground_flame_count = 20
                                      }
                                    }
                                  }
                                }
                              }
                            },
                            {
                              type = "invoke-tile-trigger",
                              repeat_count = 1
                            },
                            {
                              type = "destroy-decoratives",
                              from_render_layer = "decorative",
                              to_render_layer = "object",
                              include_soft_decoratives = true,
                              include_decals = false,
                              invoke_decorative_trigger = true,
                              decoratives_with_trigger_only = false,
                              radius = 6
                            },
                            {
                              type = "create-entity",
                              entity_name = "massive-explosion"
                            }
                          }
                        }
                      }
                    })
                  }
                }
              }
            }
          }
        })

        local xClusterMissileAmmo = "x-cluster-missile"

        makeRecipe({
                name = xClusterMissileAmmo,
                subgroup = "ammo",
                enabled = false,
                category = "crafting",
                time = 100,
                ingredients = {
                    {type = "item", name = "explosive-rocket", amount = 10},
                    {type = "item", name = "steel-plate", amount = 25},
                    {type = "item", name = "explosives", amount = 75},
                    {type = "item", name = "processing-unit", amount = 10}
                },
                result = xClusterMissileAmmo,
        })

        addEffectToTech("super-cluster-rockets",
                        {
                            type = "unlock-recipe",
                            recipe = xClusterMissileAmmo,
        })
    end

end

return rockets
