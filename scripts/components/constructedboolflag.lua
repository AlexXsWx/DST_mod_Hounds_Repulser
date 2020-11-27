local ConstructedBoolFlag = Class(function(self, inst)
    self.inst = inst

    self._constructed = false
    self._onload_hook = nil
end)

-- Setter for _onload_hook

-- I couldn't find a good way to run some code _after_ persistent data is restored, so using this
function ConstructedBoolFlag:AddOnLoadHook(fn)
    self._onload_hook = fn
end

-- Getter/Setter for _constructed

function ConstructedBoolFlag:Get(dt)
    return self._constructed
end

function ConstructedBoolFlag:SetTo(constructed)
    self._constructed = constructed
end

-- Save/Loaad

function ConstructedBoolFlag:OnSave()
    return { constructed = self._constructed }
end

function ConstructedBoolFlag:OnLoad(data)
    if data.constructed ~= nil then
        self._constructed = data.constructed
    end

    -- TODO: clean up
    print(self:GetDebugString())

    if self._onload_hook ~= nil then
        self._onload_hook()
    end
end

-- Debug

function ConstructedBoolFlag:GetDebugString(dt)
    return "CBF: _constructed = "..tostring(self._constructed)
end

--

return ConstructedBoolFlag
