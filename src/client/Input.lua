-- handles all player input


local Input = {}
Input.__index  = Input

local UserInputService = game:GetService("UserInputService")

local keyboardMappings = {
    [Enum.KeyCode.W] = "LookUp",
    [Enum.KeyCode.A] = "MoveLeft",
    [Enum.KeyCode.S] = "LookDown",
    [Enum.KeyCode.D] = "MoveRight",

    [Enum.UserInputType.MouseButton1] = "Attack",
    [Enum.KeyCode.P] = "Attack",
    [Enum.KeyCode.F] = "Block",

    [Enum.KeyCode.One] = "Skill_1",
    [Enum.KeyCode.Two] = "Skill_2",
    [Enum.KeyCode.Three] = "Skill_3",
    [Enum.KeyCode.Four] = "Skill_4",
}

function Input.Init(): {}
    local newInput = {}

    newInput.enabled = true
    newInput.input = Instance.new("BindableEvent")
    newInput.input.Name = "Input"
    newInput.input.Parent = script

    return setmetatable(newInput, Input)
end

function Input:Start(classes: {[string] : {}})
    
    self.InputBegan = UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
        if gameProcessedEvent or self.enabled == false then else
            print("InputBegan")

            if keyboardMappings[input.KeyCode] then
                self.input:Fire(keyboardMappings[input.KeyCode], "Began")

            elseif keyboardMappings[input.UserInputType] then
                self.input:Fire(keyboardMappings[input.UserInputType], "Began")

            end
        end
    end) 

    self.InputEnded = UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
        if gameProcessedEvent or self.enabled == false then else
            print("InputEnded")

            if keyboardMappings[input.KeyCode] then
                self.input:Fire(keyboardMappings[input.KeyCode], "Ended")

            elseif keyboardMappings[input.UserInputType] then
                self.input:Fire(keyboardMappings[input.UserInputType], "Ended")
                
            end
        end
    end)
end

function Input:SetEnabled(isEnabled: boolean)
    self.enabled = isEnabled
end

function Input:Clean()
    if self.InputBegan then
        self.InputBegan:Disconnect()
    end

    if self.InputEnded then
        self.InputEnded:Disconnect()
    end

    self.input:Destroy()
    self = nil
end

return Input