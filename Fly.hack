-- Simple Mobile Flying Script
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Camera = workspace.CurrentCamera
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- Flight Settings
local flying = true
local flySpeed = 50 -- Increase this number to fly faster

-- Create a BodyVelocity object to control movement forces
local bVel = Instance.new("BodyVelocity")
bVel.MaxForce = Vector3.new(1e5, 1e5, 1e5)
bVel.Velocity = Vector3.new(0, 0, 0)
bVel.Parent = RootPart

-- Turn off character gravity so you don't fall down
Humanoid.PlatformStand = true

-- Continuous loop to push your avatar where the camera looks
local connection
connection = RunService.RenderStepped:Connect(function()
    if not flying or not RootPart.Parent then
        bVel:Destroy()
        Humanoid.PlatformStand = false
        connection:Disconnect()
        return
    end
    
    -- This constantly moves your character exactly forward based on your look angle
    bVel.Velocity = Camera.CFrame.LookVector * flySpeed
end)

-- Deactivates flight automatically if your avatar resets/dies
Humanoid.Died:Connect(function()
    flying = false
end)
