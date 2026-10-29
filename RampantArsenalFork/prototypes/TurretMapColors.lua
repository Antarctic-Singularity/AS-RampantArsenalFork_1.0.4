-- Map view colors for turrets.
-- Physical turrets: #de2d29, laser/electric turrets: #ec2394, flame/fire turrets: #ec6023.
-- Vanilla artillery turret: #ffffff.
-- Applies to Rampant Arsenal turrets, modular (w93) turrets, and the vanilla turrets.
-- Hero Turrets Redux copies (hero-turret-<rank>-for-<base name>) get the color of their base turret.

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

local function baseTurretName(name)
    return name:match("^hero%-turret%-%d+%-for%-(.+)$") or name
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

local function isInScope(baseName)
    return baseName:find("%-rampant%-arsenal$") or baseName:find("^w93%-") or vanillaTurrets[baseName] ~= nil
end

for turretType, category in pairs(turretTypeCategories) do
    for name, turret in pairs(data.raw[turretType] or {}) do
        if isInScope(baseTurretName(name)) then
            setTurretMapColor(turret, turretMapColors[category])
        end
    end
end

for baseName, vanilla in pairs(vanillaTurrets) do
    for name, turret in pairs(data.raw[vanilla.type] or {}) do
        if baseTurretName(name) == baseName then
            setTurretMapColor(turret, turretMapColors[vanilla.category])
        end
    end
end
