-- handles all movement functions / modules

local Movement = {}
Movement.__index  = Movement



function Movement.Init()
    local self = {}
    self.enabled = true
    setmetatable(self, Movement)
end

function Movement:Start(classes)
    
    self.inputClass = classes.Input


    self.inputClass.input.Event:Connect(function(processedInput, inputType)
        


    end)
end

function Movement:Enable()
    self.enabled = true
end

function Movement:Disable()
    self.enabled = false
end

function Movement:Clean()
    
end

return Movement