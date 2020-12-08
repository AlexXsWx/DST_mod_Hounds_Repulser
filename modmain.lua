PrefabFiles = {
    "warg_tail",
}

-- Change Warg's drop table to add its tail

local function wargPostInit(inst)
    if GLOBAL.TheWorld.ismastersim then
        local dropChance = GetModConfigData("WargTailDropChance") / 100
        if dropChance > 0 then
            inst.components.lootdropper:AddChanceLoot("warg_tail", dropChance)
        end
    end
end
AddPrefabPostInit("warg", wargPostInit)

--

-- Prefab that will get the construction modifier
local target_prefab = GetModConfigData("RepulserConstructionTarget")


-- Construction Recipe for the repulser activation
local constructionPlan = {}
if GetModConfigData("WargTailRequired") ~= 0 then
    table.insert(
        constructionPlan,
        Ingredient("warg_tail", 1)
    )
end
table.insert(
    constructionPlan,
    Ingredient("houndstooth", GetModConfigData("HoundsTeethToBuildRepulser"))
)
GLOBAL.CONSTRUCTION_PLANS[target_prefab] = constructionPlan


local function activateRepulser(inst)
    GLOBAL.c_announce("Leave us be, hounds")

    GLOBAL.TheWorld:PushEvent(
        "pausehounded",
        { source = inst }
    )
    -- TODO: find or make a more appropriate sound
    inst.SoundEmitter:PlaySound("dontstarve/characters/wurt/merm/throne/build")

    local shakeMode = GLOBAL.CAMERASHAKE.FULL
    local shakeDuration = 3
    local shakeSpeed = .02
    local shakeScale = 1
    for i, v in ipairs(GLOBAL.AllPlayers) do
        v:ShakeCamera(shakeMode, shakeDuration, shakeSpeed, shakeScale)
    end

    inst:RemoveComponent("constructionsite")
    inst:RemoveTag("constructionsite")

    inst.components.constructedboolflag:SetTo(true)
end

local function OnConstructed(inst, doer)
    if inst.components.constructionsite:IsComplete() then
        -- Normally one would need to register on destroy as well,
        -- but implementation of pausehounded allows to just use entitys as origin of blocking.
        -- So once the entity is destroyed the block is lifted (from this very entity)
        activateRepulser(inst)
    end
end

local function targetPrefabPostInit(inst)
    -- Ensure sound emitter exists for later
    if inst.SoundEmitter == nil then
        inst.entity:AddSoundEmitter()
    end

    -- FIXME: what about removing this tag on non-master sim?
    inst:AddTag("constructionsite")
    if GLOBAL.TheWorld.ismastersim then
        inst:AddComponent("constructionsite")
        inst.components.constructionsite:SetConstructionPrefab("construction_container")
        inst.components.constructionsite:SetOnConstructedFn(OnConstructed)

        -- This component is used basically for persistent storage,
        -- and to disable consturctionsite component once construction is complete
        inst:AddComponent("constructedboolflag")
        local function onload()
            if inst.components.constructedboolflag:Get() then
                activateRepulser(inst)
            end
        end
        inst.components.constructedboolflag:AddOnLoadHook(onload)
    end
end
AddPrefabPostInit(target_prefab, targetPrefabPostInit)
