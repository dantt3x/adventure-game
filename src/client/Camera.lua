-- controls the player camera.

local Camera = {}
Camera.__index = Camera

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local SpringModule = require(ReplicatedStorage.Shared.Spring)
local localPlayer = Players.LocalPlayer
local DefaultOffset = Vector3.new(0, 3, 25)

function Camera.Init()
    local newCamera = {}
    newCamera.enabled = true
    newCamera.currentCamera = game.Workspace.CurrentCamera
    newCamera.playerCharacter = localPlayer.Character

    newCamera.xSpring = SpringModule.fromFrequency(10, 1, 5, 0, 0, 0)
    newCamera.xSpring:SnapToCriticalDamping()

    newCamera.ySpring = SpringModule.fromFrequency(10, 1, 5, 0, 0, 0)
    newCamera.ySpring:SnapToCriticalDamping()

    return setmetatable(newCamera, Camera)
end

function Camera:Start()
    self.Camera = RunService.Stepped:Connect(function(time, deltaTime) 
        if self.enabled == false then 
            return
        end

        if not self.currentCamera then
            self.currentCamera = game.Workspace.CurrentCamera
            self.currentCamera.CameraType = Enum.CameraType.Scriptable
        end

        if not self.playerCharacter then
            if localPlayer.Character then
                self.playerCharacter = localPlayer.Character
            end
        end

        self.currentCamera.CameraType = Enum.CameraType.Scriptable

        local primaryPart = self.playerCharacter.PrimaryPart
        --print(self.xSpring.Offset, self.xSpring.Goal)
        --print(self.ySpring.Offset, self.ySpring.Goal)

        local finalPosition = Vector3.new(self.xSpring.Offset, self.ySpring.Offset, primaryPart.Position.Z + DefaultOffset.Z)
        self.currentCamera.CFrame = CFrame.new(finalPosition)

        self.xSpring:SetOffset(self.currentCamera.CFrame.Position.X)
        self.xSpring:SetGoal(primaryPart.Position.X + (self.playerCharacter.Humanoid.MoveDirection.X * 2.5))
        self.ySpring:SetOffset(self.currentCamera.CFrame.Position.Y)
        self.ySpring:SetGoal(primaryPart.Position.Y + DefaultOffset.Y)

        --print(self.xSpring:SetOffset(1 * deltaTime))
        
        

        --local springOffset = Vector3.new(-self.currentSpring.Offset,0,0)
        --print(self.currentSpring.Offset, self.currentSpring.Goal)
        --self.currentSpring.Goal = 200

        --[[
        self.currentCamera.CFrame = CFrame.lookAt(
            (Vector3.new(self.currentSpring.Offset, primaryPart.Position.Y, primaryPart.Position.Z) + DefaultOffset), 
            Vector3.new(self.currentSpring.Offset, primaryPart.Position.Y, primaryPart.Position.Z)
        )]]



        --self.currentSpring:SetOffset(self.lastPosition or 0)
        --self.currentSpring:SetGoal( primaryPart.Position.X)

        --self.lastPosition = primaryPart.Position.X
        --self.currentSpring:Reset()
    end)

    self.Spring = RunService.Stepped:Connect(function(time, deltaTime)
                
    end)
end

function Camera:SetEnabled(isEnabled: boolean)
    self.enabled = isEnabled
end

function Camera:Clean()
    self.Camera:Disconnect()
    self = nil
end

return Camera