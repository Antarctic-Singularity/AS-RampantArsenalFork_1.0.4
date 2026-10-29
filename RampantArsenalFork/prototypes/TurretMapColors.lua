-- Map view colors for turrets.
-- Physical turrets: #de2d29, laser/electric turrets: #ec2394, flame/fire turrets: #ec6023.
-- Vanilla artillery turret: #ffffff.
-- Applies to Rampant Arsenal turrets, modular (w93) turrets, and the vanilla turrets.

local turretMapColors = {
    physical = {r = 0.871, g = 0.176, b = 0.161},
    laser = {r = 0.925, g = 0.137, b = 0.580},
    fire = {r = 0.925, g = 0.376, b = 0.137},
    artillery = {r = 1, g = 1, b = 1},
}

-- map_color is only used when friendly/enemy colors are unset, so set all three
local function setTurretMapColor(turret, color)
    turret.map_color = color
    turret.friendly_map_color = color
    turret.enemy_map_color = color
end

local turretTypeCategories = {
    ["ammo-turret"] = "physical",
    ["electric-turret"] = "laser",
    ["fluid-turret"] = "fire",
}

local vanillaTurrets = {
    ["gun-turret"] = {type = "ammo-turret", category = "physical"},
    ["artillery-turret"] = {type = "artillery-turret", category = "artillery"},
    ["laser-turret"] = {type = "electric-turret", category = "laser"},
    ["flamethrower-turret"] = {type = "fluid-turret", category = "fire"},
}

for turretType, category in pairs(turretTypeCategories) do
    for name, turret in pairs(data.raw[turretType] or {}) do
        if name:find("%-rampant%-arsenal$") or name:find("^w93%-") then
            setTurretMapColor(turret, turretMapColors[category])
        end
    end
end

for name, vanilla in pairs(vanillaTurrets) do
    local turret = data.raw[vanilla.type] and data.raw[vanilla.type][name]
    if turret then
        setTurretMapColor(turret, turretMapColors[vanilla.category])
    end
end
