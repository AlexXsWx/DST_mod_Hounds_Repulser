-- --------------------------------------------------------------------------
-- --[[ HoundsRepulser class definition ]]
-- --------------------------------------------------------------------------

-- return Class(function(self, inst)

-- assert(TheWorld.ismastersim, "HoundsRepulser should not exist on client")

-- --------------------------------------------------------------------------
-- --[[ Member variables ]]
-- --------------------------------------------------------------------------

-- -- Public

-- self.inst = inst

-- -- Private

-- local _hounds_repulser_active = false

-- --------------------------------------------------------------------------
-- --[[ Private member functions ]]
-- --------------------------------------------------------------------------

-- local function PauseHounded()
--     -- TODO: clean up
--     print("HoundsRepulser: pause hounded")
--     TheWorld:PushEvent("pausehounded", { source = self.inst })
-- end

-- local function UnpauseHounded()
--     -- TODO: clean up
--     print("HoundsRepulser: unpause hounded")
--     TheWorld:PushEvent("unpausehounded", { source = self.inst })
-- end

-- --------------------------------------------------------------------------
-- --[[ Initialization ]]
-- --------------------------------------------------------------------------

-- inst:ListenForEvent("mod_alexxswx_hounds_repulser_debug_on", DebugOn)
-- inst:ListenForEvent("mod_alexxswx_hounds_repulser_debug_off", DebugOff)

-- -- TODO: check if this step is necessary

-- self.inst:StartUpdatingComponent(self)

-- function self:OnUpdate(dt)
--     -- nothing to do
-- end

-- self.LongUpdate = self.OnUpdate

-- --------------------------------------------------------------------------
-- --[[ Save/Load ]]
-- --------------------------------------------------------------------------

-- function self:OnSave()
--     return
--     {
--         hounds_repulser_active = _hounds_repulser_active,
--     }
-- end

-- function self:OnLoad(data)
--     _hounds_repulser_active = data.hounds_repulser_active or false

--     if _hounds_repulser_active then
--         -- TODO: check if this needs to be delayed
--         --       (e.g. perhaps hounded component isn't initialized yet)
--         PauseHounded()
--     end
-- end

-- --------------------------------------------------------------------------
-- --[[ Debug ]]
-- --------------------------------------------------------------------------

-- local function DebugOn()
--     PauseHounded()
-- end

-- local function DebugOff()
--     UnpauseHounded()
-- end

-- function self:GetDebugString()
--     if _hounds_repulser_active then
--         return "Hounds Repulser Active"
--     end
--     return "Hounds Repulser Disabled"
-- end

-- end)
