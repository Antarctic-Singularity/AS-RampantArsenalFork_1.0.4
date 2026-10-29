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


local walls = {}

local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local wallUtils = require("utils/WallUtils")

local makeRecipe = recipeUtils.makeRecipe
local addEffectToTech = technologyUtils.addEffectToTech
local makeWall = wallUtils.makeWall
local addResistance = wallUtils.addResistance
local makeGate = wallUtils.makeGate

local function setResistance(resistances, value)
	for _, resistance in pairs(resistances) do
		if resistance.type == value.type then
			if value.decrease then
				resistance.decrease = value.decrease
			end
			if value.percent then
				resistance.percent = value.percent
			end
			return
		end
	end
	local resistance = resistances[#resistances+1] 
	resistance.type = value.type
	if value.decrease then
		resistance.decrease = value.decrease
	end
	if value.percent then
		resistance.percent = value.percent
	end
end

function walls.enable()

    local mendingWallResistance = {
        {
            type = "physical",
            decrease = 3,
            percent = 20
        },
        {
            type = "impact",
            decrease = 45,
            percent = 60
        },
        {
            type = "explosion",
            decrease = 10,
            percent = 30
        },
        {
            type = "acid",
            percent = 30
        },
        {
            type = "fire",
            percent = 100
        },
        {
            type = "laser",
            percent = 40
        },
        {
            type = "electric",
            percent = 30
        },
        {
            type = "poison",
            decrease = 5,
            percent = 95
        }
    }

    if mods["bobwarfare"] then
        mendingWallResistance[#mendingWallResistance+1] = {
            type = "bob-pierce",
            percent = 25,
            decrease = 20
        }
        mendingWallResistance[#mendingWallResistance+1] = {
            type = "bob-plasma",
            percent = 100
        }
    end

    local mendingWall,mendingWallItem = makeWall(
        {
            name = "mending",
            icon = "__RampantArsenalFork__/graphics/icons/mending-wall.png",
            health = 1000,
            healing = 1,
            tint = {r=0.5,g=0.60,b=0.5,a=1},
            order = "a[stone-wall]-a[zmending-wall]",
            resistances = mendingWallResistance
        },
        {
            range = 18,
            cooldown = 30,
            action = {
                type = "direct",
                action_delivery =
                    {
                        type = "instant",

                        source_effects =
                            {
                                {
                                    type = "create-entity",
                                    trigger_created_entity = true,
                                    entity_name = "small-repair-cloud-rampant-arsenal",
                                    show_in_tooltip = true
                                }
                            }
                    }
            }
        }
    )

    local mendingGate,mendingGateItem = makeGate(
        {
            name = "mending",
            icon = "__RampantArsenalFork__/graphics/icons/mending-gate.png",
            health = 1000,
            healing = 1,
            tint = {r=0.5,g=0.60,b=0.5,a=1},
            order = "a[wall]-b[gatez]",
            resistances = mendingWallResistance
        },
        {
            range = 18,
            cooldown = 30,
            action = {
                type = "direct",
                action_delivery =
                    {
                        type = "instant",

                        source_effects =
                            {
                                {
                                    type = "create-entity",
                                    trigger_created_entity = true,
                                    entity_name = "small-repair-cloud-rampant-arsenal",
                                    show_in_tooltip = true
                                }
                            }
                    }
            }
        }
    )

    makeRecipe({
            name = mendingWallItem,
            icon = "__RampantArsenalFork__/graphics/icons/mending-wall.png",
            enabled = false,
            category = "crafting",
            ingredients = {
                {type = "item", name = "stone-wall", amount = 1},
                {type = "item", name = "repair-capsule-rampant-arsenal", amount = 1}
            },
            result = mendingWallItem
    })

    makeRecipe({
            name = mendingGateItem,
            icon = "__RampantArsenalFork__/graphics/icons/mending-gate.png",
            enabled = false,
            category = "crafting",
            ingredients = {
                {type = "item", name = mendingWall, amount = 1},
                {type = "item", name = "steel-plate", amount = 1},
                {type = "item", name = "advanced-circuit", amount = 5}
            },
            result = mendingGateItem
    })

    addEffectToTech("regeneration-walls",
                    {
                        {
                            type = "unlock-recipe",
                            recipe = mendingGateItem
                        },
                        {
                            type = "unlock-recipe",
                            recipe = mendingWallItem
                        }
    })

    local reinforcedWallResistance = {
                {
                    type = "physical",
                    decrease = 6,
                    percent = 40
                },
                {
                    type = "impact",
                    decrease = 45,
                    percent = 80
                },
                {
                    type = "explosion",
                    decrease = 20,
                    percent = 60
                },
                {
                    type = "acid",
                    percent = 70
                },
                {
                    type = "fire",
                    percent = 100
                },
                {
                    type = "laser",
                    percent = 60
                },
                {
                    type = "electric",
                    percent = 60
                },
                {
                    type = "poison",
                    percent = 60
                }
    }

    if mods["bobwarfare"] then
        reinforcedWallResistance[#reinforcedWallResistance+1] = {
            type = "bob-pierce",
            percent = 25,
            decrease = 20
        }
        reinforcedWallResistance[#reinforcedWallResistance+1] = {
            type = "bob-plasma",
            percent = 100
        }
    end

    local reinforcedWall,reinforcedWallItem = makeWall(
        {
            name = "reinforced",
            icon = "__RampantArsenalFork__/graphics/icons/reinforced-wall.png",
            health = 1500,
            tint = {r=0.5,g=0.5,b=0.60,a=1},
            order = "a[stone-wall]-a[zreinforced-wall]",
            resistances = reinforcedWallResistance
        }
    )

    local reinforcedGate,reinforcedGateItem = makeGate(
        {
            name = "reinforced",
            icon = "__RampantArsenalFork__/graphics/icons/reinforced-gate.png",
            health = 1500,
            tint = {r=0.5,g=0.5,b=0.9,a=1},
            order = "a[wall]-b[gatezz]",
            resistances = reinforcedWallResistance
        }
    )

    makeRecipe({
            name = reinforcedWallItem,
            icon = "__RampantArsenalFork__/graphics/icons/reinforced-wall.png",
            enabled = false,
            category = "crafting",
            ingredients = {
                {type = "item", name = "refined-concrete", amount = 5}
            },
            result = reinforcedWallItem
    })

    makeRecipe({
            name = reinforcedGateItem,
            icon = "__RampantArsenalFork__/graphics/icons/reinforced-gate.png",
            enabled = false,
            category = "crafting",
            ingredients = {
                {type = "item", name = reinforcedWall, amount = 1},
                {type = "item", name = "steel-plate", amount = 1},
                {type = "item", name = "advanced-circuit", amount = 5}
            },
            result = reinforcedGateItem
    })

    addEffectToTech("stone-walls-2",
                    {
                        {
                            type = "unlock-recipe",
                            recipe = reinforcedGateItem
                        },
                        {
                            type = "unlock-recipe",
                            recipe = reinforcedWallItem
                        }
    })

	--- spec.walls
	local laserProofTint = {r=0.2,g=0.7,b=0.80,a=1}
	local laserResistances = table.deepcopy(reinforcedWallResistance)
	setResistance(laserResistances, {type = "laser", decrease = 20, percent = 95})
	
    local laserProofWall, laserProofWallItem = makeWall(
        {
            name = "laserProof",
            icon = "__RampantArsenalFork__/graphics/icons/reinforced-wall.png",
			makeIcons = true,
            health = 1500,
            tint = laserProofTint,
            order = "a[stone-wall]-a[zreinforced-wall]-1[spec-wall]",
            resistances = laserResistances
        }
    )
	
    makeRecipe({
            name = laserProofWallItem,
            icons = {{icon = "__RampantArsenalFork__/graphics/icons/reinforced-wall.png", icon_size = 32, tint = laserProofTint}},
            enabled = false,
            category = "crafting",
            ingredients = {
                {type = "item", name = reinforcedWall, amount = 1},
				{type = "item", name = "refined-concrete", amount = 1},
                {type = "item", name = "steel-plate", amount = 1}
            },
            result = laserProofWallItem
    })

	
	local electricProofTint = {r=0.2,g=0.2,b=0.80,a=1}
	local electricResistances = table.deepcopy(reinforcedWallResistance)
	setResistance(electricResistances, {type = "electric", decrease = 20, percent = 95})
    local electricProofWall, electricProofWallItem = makeWall(
        {
            name = "electricProof",
            icon = "__RampantArsenalFork__/graphics/icons/reinforced-wall.png",
			makeIcons = true,
            health = 1500,
            tint = electricProofTint,
            order = "a[stone-wall]-a[zreinforced-wall]-2[spec-wall]",
            resistances = electricResistances
        }
    )
    makeRecipe({
            name = electricProofWallItem,
            icons = {{icon = "__RampantArsenalFork__/graphics/icons/reinforced-wall.png", icon_size = 32, tint = electricProofTint}},
            enabled = false,
            category = "crafting",
            ingredients = {
                {type = "item", name = reinforcedWall, amount = 1},
				{type = "item", name = "refined-concrete", amount = 1},
                {type = "item", name = "steel-plate", amount = 1}
            },
            result = electricProofWallItem
    })

	local explosionProofTint = {r=0.8,g=0.4,b=0,a=1}
	local explosionResistances = table.deepcopy(reinforcedWallResistance)
	setResistance(explosionResistances, {type = "explosion", decrease = 40, percent = 98})
    local explosionProofWall, explosionProofItem = makeWall(
        {
            name = "explosionProof",
            icon = "__RampantArsenalFork__/graphics/icons/reinforced-wall.png",
			makeIcons = true,
            health = 1500,
            tint = explosionProofTint,
            order = "a[stone-wall]-a[zreinforced-wall]-3[spec-wall]",
            resistances = explosionResistances
        }
    )
    makeRecipe({
            name = explosionProofItem,
            icons = {{icon = "__RampantArsenalFork__/graphics/icons/reinforced-wall.png", icon_size = 32, tint = explosionProofTint}},
            enabled = false,
            category = "crafting",
            ingredients = {
                {type = "item", name = reinforcedWall, amount = 1},
				{type = "item", name = "refined-concrete", amount = 1},
                {type = "item", name = "steel-plate", amount = 1}
            },
            result = explosionProofItem
    })
	
	local acidProofTint = {r=0.2,g=0.8,b=0,a=1}
	local acidResistances = table.deepcopy(reinforcedWallResistance)
	setResistance(acidResistances, {type = "acid", percent = 99})
    local acidProofWall, acidProofItem = makeWall(
        {
            name = "acidProof",
            icon = "__RampantArsenalFork__/graphics/icons/reinforced-wall.png",
			makeIcons = true,
            health = 1500,
            tint = acidProofTint,
            order = "a[stone-wall]-a[zreinforced-wall]-4[spec-wall]",
            resistances = acidResistances
        }
    )
    makeRecipe({
            name = acidProofItem,
            icons = {{icon = "__RampantArsenalFork__/graphics/icons/reinforced-wall.png", icon_size = 32, tint = acidProofTint}},
            enabled = false,
            category = "crafting",
            ingredients = {
                {type = "item", name = reinforcedWall, amount = 1},
				{type = "item", name = "refined-concrete", amount = 1},
                {type = "item", name = "steel-plate", amount = 1}
            },
            result = acidProofItem
    })

    addEffectToTech("spec-walls",
                    {
                        {
                            type = "unlock-recipe",
                            recipe = laserProofWallItem
                        },
                        {
                            type = "unlock-recipe",
                            recipe = electricProofWallItem
                        },
                        {
                            type = "unlock-recipe",
                            recipe = explosionProofItem
                        },
                        {
                            type = "unlock-recipe",
                            recipe = acidProofItem
                        }
    })
	
	----



    addResistance("wall",
                  "stone-wall",
                  {
                      type = "laser",
                      percent = 30
    })


    addResistance("wall",
                  "stone-wall",
                  {
                      type = "electric",
                      percent = 20
    })

    addResistance("wall",
                  "stone-wall",
                  {
                      type = "acid",
                      percent = 15
    })

    addResistance("wall",
                  "stone-wall",
                  {
                      type = "poison",
                      percent = 20
    })

    addResistance("gate",
                  "gate",
                  {
                      type = "laser",
                      percent = 30
    })

    addResistance("gate",
                  "gate",
                  {
                      type = "acid",
                      percent = 15
    })

    addResistance("gate",
                  "gate",
                  {
                      type = "electric",
                      percent = 20
    })

    addResistance("gate",
                  "gate",
                  {
                      type = "poison",
                      percent = 20
    })
end

return walls
