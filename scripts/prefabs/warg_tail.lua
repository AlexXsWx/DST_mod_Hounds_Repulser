local assets =
{
    Asset("ANIM", "anim/warg_tail.zip"),
    Asset("ATLAS", "images/inventoryimages/warg_tail.xml"),    -- a custom asset, found in the mod folder
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("warg_tail")
    inst.AnimState:SetBuild("warg_tail")
    inst.AnimState:PlayAnimation("idle")

    MakeInventoryFloatable(inst, "med", nil, 0.6)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/warg_tail.xml"
    
    MakeHauntableLaunch(inst)

    return inst
end

-- Add some strings for this item
STRINGS.NAMES.WARG_TAIL = "Warg's tail"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.WARG_TAIL = "Tail of that horrible beast"

return Prefab("common/inventory/warg_tail", fn, assets)
