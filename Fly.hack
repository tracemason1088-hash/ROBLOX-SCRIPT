local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Camera = workspace.CurrentCamera
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- Flight Configuration
local flySpeed = 2.5 -- The speed multiplier for smooth CFrame sliding

-- Clear out colliding limbs so Roblox doesn't drag you along the ground
for _, limb in pairs(Character:GetChildren()) do
    if limb:IsA("BasePart") and limb.Name ~= "HumanoidRootPart" then
        limb.CanCollide = false
    end
end

-- Detach avatar states from default Roblox gravity and grounding controls
Humanoid.PlatformStand = true

-- High-precision frame calculation loop
local flyConnection
flyConnection = RunService.RenderStepped:Connect(function()
    -- Stop running if the character dies or respawns
    if not Character or not RootPart.Parent or Humanoid.Health <= 0 then
        Humanoid.PlatformStand = false
        flyConnection:Disconnect()
        return
    end
    
    -- Teleport your character slightly in the exact direction the camera faces
    -- Looking up will now pull you directly into the sky instantly
    local moveDirection = Camera.CFrame.LookVector
    RootPart.CFrame = RootPart.CFrame + (moveDirection * flySpeed)
    
    -- Keeps your velocity at 0 so standard physics don't drop you back down
    RootPart.Velocity = Vector3.new(0, 0, 0)
end)

-- Clear memory state if the player resets manually
Humanoid.Died:Connect(function()
    if flyConnection then flyConnection:Disconnect() end
end