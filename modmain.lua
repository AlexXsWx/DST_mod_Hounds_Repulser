-- The PrefabFiles list is the list of all the files in your <modname>/scripts/prefabs folder
-- that you want to load prefabs from
PrefabFiles = {
    "warg_tail",
}

-- local function AddHoundsRepulser()
--     TheWorld:AddComponent("houndsrepulser")
-- end

-- if TheNet:GetIsMasterSimulation() then
--     print("")
--     GamePostInit("world", AddHoundsRepulser)
-- end

local function postConstruct(self, inst)

    print("MAHR: inject")

    local _houndsRepulserActive = false

    --

    -- local ogOnSave = self.OnSave
    -- local function newOnSave()
    --     local data = ogOnSave(self)
    --     -- data.repulsing = _houndsRepulserActive
    --     print("MAHR: save override "..tostring(_houndsRepulserActive))
    --     -- return data


    --     return
    --     {
    --         warning = data.warning,
    --         timetoattack = data.timetoattack,
    --         warnduration = data.warnduration,
    --         attackplanned = data.attackplanned,
    --         repulsing = _houndsRepulserActive,
    --     }
    -- end
    -- self.OnSave = newOnSave

    -- --

    -- local ogOnLoad = self.OnLoad
    -- local function newOnLoad(data)

    --     local _repulsing = data.repulsing or false
    --     print("MAHR: load override "..tostring(_repulsing))

    --     if _repulsing then
    --         DebugOn()
    --     end

    --     ogOnLoad(self, data)
    -- end
    -- self.OnLoad = newOnLoad

    --

    local function DebugOn(src, data)
        if not _houndsRepulserActive then
            _houndsRepulserActive = true
            print("MAHR: pause hounded")
            self.inst:PushEvent(
                "pausehounded",
                { source = self.inst }
            )
        end
    end
    local function DebugOff(src, data)
        if _houndsRepulserActive then
            _houndsRepulserActive = false
            print("MAHR: unpause hounded")
            self.inst:PushEvent(
                "unpausehounded",
                { source = self.inst }
            )
        end
    end
    -- c_announce(TheWorld.components.hounded:GetDebugString())
    -- TheWorld:PushEvent("mod_alexxswx_hounds_repulser_debug_on")
    self.inst:ListenForEvent("mod_alexxswx_hounds_repulser_debug_on", DebugOn)
    self.inst:ListenForEvent("mod_alexxswx_hounds_repulser_debug_off", DebugOff)

    --

    local ogGetDebugString = self.GetDebugString
    local function newGetDebugString()
        return "MAHR="..tostring(_houndsRepulserActive).."; "..ogGetDebugString(self)
    end
    self.GetDebugString = newGetDebugString
end

AddClassPostConstruct("components/hounded", postConstruct)

--[[

-- Import things we like into our mod's own global scope, so we don't have 
-- to type "GLOBAL." every time want to use them.
SpawnPrefab = GLOBAL.SpawnPrefab

--]]


local function wargPostInit(inst)
    print("MAHR: warg post init")
    -- TODO: don't add listener on non-master in the first place?
    if GLOBAL.TheWorld.ismastersim then
        inst.components.health:SetMaxHealth(1)
        inst.components.lootdropper:AddChanceLoot("warg_tail", 1)
    end
end
print("MAHR: inject warg post init")
AddPrefabPostInit("warg", wargPostInit)

--

local function activate(inst)
    print("MAHR: construction concluded")
    -- local new_throne = ReplacePrefab(inst, "mermthrone")
    -- FIXME: disable on destroy
    -- FIXME: restore on load
    GLOBAL.TheWorld:PushEvent("mod_alexxswx_hounds_repulser_debug_on", {})
    -- inst.SoundEmitter:PlaySound("dontstarve/characters/wurt/merm/throne/build")
    GLOBAL.c_announce("MAHR: construction concluded")

    -- inst:RemoveComponent("constructionsite")
    -- inst:RemoveTag("constructionsite")

    inst.components.mytestcomponent:MarkConstructed()
end

local function OnConstructed(inst, doer)
    print("MAHR: constructed")
    -- local concluded = true
    -- for i, v in ipairs(GLOBAL.CONSTRUCTION_PLANS["eyeturret"]) do
    --     if inst.components.constructionsite:GetMaterialCount(v.type) < v.amount then
    --         concluded = false
    --         break
    --     end
    -- end

    -- if concluded then
    if inst.components.constructionsite:IsComplete() then
        activate(inst)
    end
end
local function postinit2(inst)
    -- TODO: move to a better place
    GLOBAL.CONSTRUCTION_PLANS["eyeturret"] = { Ingredient("warg_tail", 1), Ingredient("houndstooth", 20) }
    inst:AddTag("constructionsite")
    if GLOBAL.TheWorld.ismastersim then
        inst:AddComponent("constructionsite")
        inst.components.constructionsite:SetConstructionPrefab("construction_container")
        inst.components.constructionsite:SetOnConstructedFn(OnConstructed)

        -- inst.OnSave = onsave
        -- inst.OnLoad = onload

        inst:AddComponent("mytestcomponent")
        GLOBAL.c_announce("MAHR: "..inst.components.mytestcomponent:GetDebugString())
        print("MAHR: "..inst.components.mytestcomponent:GetDebugString())

        local function onchange()
            print("MAHR: onchange "..inst.components.mytestcomponent:GetDebugString())
            if inst.components.mytestcomponent:GetConstructed() then
                activate(inst)
            end
        end

        inst.components.mytestcomponent:RegisterChangeFn(onchange)
    end
end
AddPrefabPostInit("eyeturret", postinit2)
