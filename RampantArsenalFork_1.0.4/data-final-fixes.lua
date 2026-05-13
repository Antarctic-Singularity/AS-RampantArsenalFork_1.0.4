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


if mods["Krastorio2"] and settings.startup["rampant-arsenal-enableVehicle"].value then
    data.raw["car"]["nuclear-tank-vehicle-rampant-arsenal"].burner = {
        fuel_categories = {"nuclear"},
        effectivity = 0.9,
        emissions_per_minute = {pollution = 30},
        fuel_inventory_size = 2,
        burnt_inventory_size = 2,
        smoke =
            {
                {
                    name = "tank-smoke",
                    deviation = {0.25, 0.25},
                    frequency = 50,
                    position = {0, 1.5},
                    starting_frame = 0,
                    starting_frame_deviation = 60
                }
            }
    }

    data.raw["car"]["nuclear-car-vehicle-rampant-arsenal"].burner = {
		fuel_categories = {"nuclear"},
        effectivity = 1,
        emissions_per_minute = {pollution = 20},
        fuel_inventory_size = 1,
        burnt_inventory_size = 1,
        smoke =
            {
                {
                    name = "tank-smoke",
                    deviation = {0.25, 0.25},
                    frequency = 50,
                    position = {0, 1.5},
                    starting_frame = 0,
                    starting_frame_deviation = 60
                }
            }
    }
end

local function setResistancePercent(entity, resistanceType, setPercent)
	local entityResist
	for i = 1, #entity.resistances do
		if entity.resistances[i].type == resistanceType then
			entityResist = entity.resistances[i]
			break
		end
	end
	if not setPercent then
		if entityResist then
			return entityResist.percent or 0
		else
			return 0
		end	
	end
	if not entityResist then
		entity.resistances[#entity.resistances+1] = {type = resistanceType, decrease = 0, percent = 0}
		entityResist = entity.resistances[#entity.resistances]
	end	
	entityResist.percent = setPercent
	return entityResist.percent
end

if mods["space-age"] then
    for _, asteroid in pairs(data.raw["asteroid"]) do
		setResistancePercent(asteroid, "poison", 100)
	end
	
	local collision_mask = {
		layers = {
			object = true,
			player = true,
			trigger_target = true,
			train = true
		},
		not_colliding_with_itself = true
	}

	for projectile_name, projectile in pairs(data.raw["projectile"]) do
		if string.find(string.lower(projectile_name), "cannon") or string.find(string.lower(projectile_name), "shotgun") then
			projectile.hit_collision_mask = collision_mask
		end
	end

end

-- Light Artillery Shells: Optional support for light artillery mod
if mods["snip-light-artillery"] then
    -- Add light versions with Light Artillery tech unlock
    require("prototypes/light-artillery-shells")

    -- Add recipe unlocks to Light Artillery technology
    if data.raw["technology"]["snip-light-artillery"] then
        table.insert(data.raw["technology"]["snip-light-artillery"].effects, {
            type = "unlock-recipe",
            recipe = "light-incendiary-artillery"
        })
        table.insert(data.raw["technology"]["snip-light-artillery"].effects, {
            type = "unlock-recipe",
            recipe = "light-he-artillery"
        })
        table.insert(data.raw["technology"]["snip-light-artillery"].effects, {
            type = "unlock-recipe",
            recipe = "light-bio-artillery"
        })
    end
else
    -- Add light versions with vanilla Artillery tech unlock
    require("prototypes/light-artillery-shells")

    -- Check if Rampant Arsenal modified the vanilla artillery tech
    local artilleryTech = data.raw["technology"]["artillery"] or
                         (mods["RampantArsenalFork"] and data.raw["technology"]["lite-artillery"])

    if artilleryTech then
        table.insert(artilleryTech.effects, {
            type = "unlock-recipe",
            recipe = "light-incendiary-artillery"
        })
        table.insert(artilleryTech.effects, {
            type = "unlock-recipe",
            recipe = "light-he-artillery"
        })
        table.insert(artilleryTech.effects, {
            type = "unlock-recipe",
            recipe = "light-bio-artillery"
        })
    end
end