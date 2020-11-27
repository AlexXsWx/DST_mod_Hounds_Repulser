local MyTestComponent = Class(function(self, inst)
    self.inst = inst
    self.constructed_mark = false
end)

function MyTestComponent:OnUpdate(dt)
    
end

function MyTestComponent:GetDebugString(dt)
    return "MTC: debug string "..tostring(self.constructed_mark)
end

--

function MyTestComponent:RegisterChangeFn(fn)
    self.change_fn = fn
end

--

function MyTestComponent:MarkConstructed(dt)
    if self.constructed_mark ~= true then
        self.constructed_mark = true
        if self.change_fn ~= nil then
            self.change_fn()
        end
    end
end

function MyTestComponent:UnmarkConstructed(dt)
    if self.constructed_mark ~= true then
        self.constructed_mark = true
        if self.change_fn ~= nil then
            self.change_fn()
        end
    end
end

function MyTestComponent:GetConstructed(dt)
    return self.constructed_mark
end

--

function MyTestComponent:OnSave()
    print("MyTestComponent:OnSave "..tostring(self.constructed_mark))
    return { constructedmark = self.constructed_mark }
end

function MyTestComponent:OnLoad(data)
    print("MyTestComponent:OnLoad "..tostring(data.constructedmark))
    if data.constructedmark ~= nil then
        if data.constructedmark then
            self:MarkConstructed()
        else
            self:UnmarkConstructed()
        end
    end
end

--

return MyTestComponent
