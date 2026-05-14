-- Light versions of Rampant Arsenal shells for light artillery
-- Damage: 30% of original (70% weaker)
-- Cost: 70% of original (30% cheaper)
-- AOE: Same as original

-- Only load if Rampant Arsenal ammo is available
if not data.raw["ammo"]["incendiary-artillery-ammo-rampant-arsenal"] then
    return
end

local lightShells = {}

-- Damage scaler function
local function scaleDamage(originalDamage)
    return math.floor(originalDamage * 0.3)
end

-- Incendiary Light Shell
local incendiaryLightShell = table.deepcopy(data.raw["ammo"]["incendiary-artillery-ammo-rampant-arsenal"])
incendiaryLightShell.name = "light-incendiary-artillery"
incendiaryLightShell.icon = "__RampantArsenalFork__/graphics/icons/light-incendiary-artillery-shell.png"

-- Scale down the projectile damage
local incendiaryLightProjectile = table.deepcopy(data.raw["artillery-projectile"]["incendiary"])
incendiaryLightProjectile.name = "light-incendiary"

-- Modify damage in projectile effects
if incendiaryLightProjectile.action and incendiaryLightProjectile.action.action_delivery and
   incendiaryLightProjectile.action.action_delivery.target_effects then
    for _, effect in ipairs(incendiaryLightProjectile.action.action_delivery.target_effects) do
        if effect.type == "nested-result" and effect.action and effect.action.action_delivery and
           effect.action.action_delivery.target_effects then
            for _, targetEffect in ipairs(effect.action.action_delivery.target_effects) do
                if targetEffect.type == "damage" and targetEffect.damage then
                    targetEffect.damage.amount = scaleDamage(targetEffect.damage.amount)
                end
            end
        elseif effect.type == "nested-result" and effect.action and effect.action.radius then
            -- Keep AOE radius the same
        end
    end
end

-- Update the ammo to use new projectile
incendiaryLightShell.ammo_type.action.action_delivery.projectile = "light-incendiary"

-- Light Incendiary Recipe
local incendiaryLightRecipe = table.deepcopy(data.raw["recipe"]["incendiary-artillery-ammo-rampant-arsenal"])
incendiaryLightRecipe.name = "light-incendiary-artillery"
incendiaryLightRecipe.enabled = false
incendiaryLightRecipe.results = {{type="item", name="light-incendiary-artillery", amount=1}}
incendiaryLightRecipe.ingredients = {
    {type="item", name="steel-plate", amount=1},
    {type="item", name="explosives", amount=1},
    {type="fluid", name="napalm-fluid-rampant-arsenal", amount=200}
}
incendiaryLightRecipe.energy_required = 5
incendiaryLightRecipe.category = "advanced-crafting"
incendiaryLightRecipe.order = "d[explosive-cannon-shell]-d[light-incendiary]"

-- HE Light Shell
local heLightShell = table.deepcopy(data.raw["ammo"]["he-artillery-ammo-rampant-arsenal"])
heLightShell.name = "light-he-artillery"
heLightShell.icon = "__RampantArsenalFork__/graphics/icons/light-he-artillery-shell.png"

-- Scale down HE projectile
local heLightProjectile = table.deepcopy(data.raw["artillery-projectile"]["he"])
heLightProjectile.name = "light-he"

-- Modify HE damage
if heLightProjectile.action and heLightProjectile.action.action_delivery and
   heLightProjectile.action.action_delivery.target_effects then
    for _, effect in ipairs(heLightProjectile.action.action_delivery.target_effects) do
        if effect.type == "nested-result" and effect.action and effect.action.action_delivery and
           effect.action.action_delivery.target_effects then
            for _, targetEffect in ipairs(effect.action.action_delivery.target_effects) do
                if targetEffect.type == "damage" and targetEffect.damage then
                    targetEffect.damage.amount = scaleDamage(targetEffect.damage.amount)
                end
            end
        end
    end
end

heLightShell.ammo_type.action.action_delivery.projectile = "light-he"

-- Light HE Recipe
local heLightRecipe = table.deepcopy(data.raw["recipe"]["he-artillery-ammo-rampant-arsenal"])
heLightRecipe.name = "light-he-artillery"
heLightRecipe.enabled = false
heLightRecipe.results = {{type="item", name="light-he-artillery", amount=1}}
heLightRecipe.ingredients = {
    {type="item", name="steel-plate", amount=1},
    {type="item", name="explosives", amount=1},
    {type="item", name="cluster-grenade", amount=1}
}
heLightRecipe.energy_required = 5
heLightRecipe.category = "advanced-crafting"
heLightRecipe.order = "d[explosive-cannon-shell]-d[light-he]"

-- Bio Light Shell
local bioLightShell = table.deepcopy(data.raw["ammo"]["bio-artillery-ammo-rampant-arsenal"])
bioLightShell.name = "light-bio-artillery"
bioLightShell.icon = "__RampantArsenalFork__/graphics/icons/light-bio-artillery-shell.png"

-- Scale down Bio projectile
local bioLightProjectile = table.deepcopy(data.raw["artillery-projectile"]["bio"])
bioLightProjectile.name = "light-bio"

-- Modify bio damage
if bioLightProjectile.action and bioLightProjectile.action.action_delivery and
   bioLightProjectile.action.action_delivery.target_effects then
    for _, effect in ipairs(bioLightProjectile.action.action_delivery.target_effects) do
        if effect.type == "nested-result" and effect.action and effect.action.action_delivery and
           effect.action.action_delivery.target_effects then
            for _, targetEffect in ipairs(effect.action.action_delivery.target_effects) do
                if targetEffect.type == "damage" and targetEffect.damage then
                    targetEffect.damage.amount = scaleDamage(targetEffect.damage.amount)
                end
            end
        end
    end
end

bioLightShell.ammo_type.action.action_delivery.projectile = "light-bio"

-- Light Bio Recipe
local bioLightRecipe = table.deepcopy(data.raw["recipe"]["bio-artillery-ammo-rampant-arsenal"])
bioLightRecipe.name = "light-bio-artillery"
bioLightRecipe.enabled = false
bioLightRecipe.results = {{type="item", name="light-bio-artillery", amount=1}}
bioLightRecipe.ingredients = {
    {type="item", name="steel-plate", amount=1},
    {type="item", name="explosives", amount=1},
    {type="item", name="toxic-capsule", amount=3}
}
bioLightRecipe.energy_required = 5
bioLightRecipe.category = "advanced-crafting"
bioLightRecipe.order = "d[explosive-cannon-shell]-d[light-bio]"

-- Register all prototypes
data:extend({
    incendiaryLightShell,
    incendiaryLightRecipe,
    incendiaryLightProjectile,
    heLightShell,
    heLightRecipe,
    heLightProjectile,
    bioLightShell,
    bioLightRecipe,
    bioLightProjectile
})

return lightShells
