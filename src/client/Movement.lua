-- handles all movement functions / modules

local Movement = {}
Movement.__index  = Movement

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local localPlayer: Player = Players.LocalPlayer

local moveDirections = {
    ["MoveRight"] = Vector3.new(1,0,0),
    ["MoveLeft"] = Vector3.new(-1,0,0),
}

local currentMoveDirection = {
    ["MoveRight"] = false,
    ["MoveLeft"] = false,
}


function Movement.Init(): {}
    local self = {}

    self.playerCharacter = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    self.enabled = true

    return setmetatable(self, Movement)
end

function Movement:Start(classes)
    self.inputClass = classes.Input


    self.inputClass.input.Event:Connect(function(processedInput: string, inputType: boolean)
        if moveDirections[processedInput] then
            local bool = true and inputType == "Began" or false
            currentMoveDirection[processedInput] = bool
        end
    end)



    RunService:BindToRenderStep("PlayerMove", Enum.RenderPriority.Character.Value + 1, function(deltaTime)    
        if not self.humanoid then
            if not self.playerCharacter.Humanoid then
                warn("PlayerCharacter.Humanoid not found.")
            else
                self.humanoid = self.playerCharacter.Humanoid
            end
        end

        if self.humanoid then
            local finalMoveDirection = Vector3.new()

            for moveDir: string, isActive: boolean in pairs(currentMoveDirection) do
                
                if isActive then
                    finalMoveDirection += moveDirections[moveDir] -- move player only on X plane.
                end

            end

            self.humanoid:Move(finalMoveDirection, false)
        end

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