-- controls the player camera.

local Camera = {}
Camera.__index = Camera

local RunService = game:GetService("RunService")
--local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local localPlayer = Players.LocalPlayer
local DefaultOffset = Vector3.new(0, 3, 18)

function Camera.Init()
    local newCamera = {}
    newCamera.enabled = true
    newCamera.currentCamera = game.Workspace.CurrentCamera
    newCamera.playerCharacter = localPlayer.Character
    return setmetatable(newCamera, Camera)
end

function Camera:Start()
    self.Camera = RunService:BindToRenderStep("Camera", Enum.RenderPriority.Camera.Value + 1, function (deltaTime)
        if self.enabled == false then 
            return
        end

        if not self.currentCamera then
            self.currentCamera = game.Workspace.CurrentCamera
        end

        if not self.playerCharacter then
            if localPlayer.Character then
                self.playerCharacter = localPlayer.Character
            end
        end

        local primaryPart = self.playerCharacter.PrimaryPart
        self.currentCamera.CameraType = Enum.CameraType.Scriptable
        self.currentCamera.CFrame = CFrame.lookAt(primaryPart.Position + DefaultOffset, primaryPart.Position)
    end)
end

function Camera:Clean()
    self.Camera:Disconnect()
    self = nil
end

function Camera:SetEnabled(isEnabled: boolean)
    self.enabled = isEnabled
end

return Camera