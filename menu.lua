local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Safety sweep: Destroy any old menus so they don't overlay
if playerGui:FindFirstChild("MobileMenuSystem") then
    playerGui.MobileMenuSystem:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MobileMenuSystem"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- ========================================================
-- MAIN PANEL
-- ========================================================
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainPanel"
mainFrame.Size = UDim2.new(0, 320, 0, 240)
mainFrame.Position = UDim2.new(0.5, -160, 0.4, -120)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- Allows moving the menu around your phone screen
mainFrame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = mainFrame

-- Title Banner Header
local titleBar = Instance.new("TextLabel")
titleBar.Name = "Header"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
titleBar.Text = "  MOBILE EXPLOIT PANEL"
titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
titleBar.TextXAlignment = Enum.TextXAlignment.Left
titleBar.Font = Enum.Font.GothamBold
titleBar.TextSize = 13
titleBar.Parent = mainFrame

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(0, 12)
barCorner.Parent = titleBar

local accentLine = Instance.new("Frame")
accentLine.Size = UDim2.new(1, 0, 0, 2)
accentLine.Position = UDim2.new(0, 0, 0, 38)
accentLine.BackgroundColor3 = Color3.fromRGB(140, 80, 255) -- Purple Theme Accent
accentLine.BorderSizePixel = 0
accentLine.Parent = mainFrame

-- Close Button (✕)
local closeButton = Instance.new("TextButton")
closeButton.Name = "Close"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundTransparency = 1
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 100, 100)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 16
closeButton.Parent = mainFrame

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- ========================================================
-- INTERACTIVE MINIMIZE SYSTEM
-- ========================================================
local minButton = Instance.new("TextButton")
minButton.Name = "MinButton"
minButton.Size = UDim2.new(0, 45, 0, 25)
minButton.Position = UDim2.new(1, -85, 0, 7)
minButton.BackgroundColor3 = Color3.fromRGB(45, 40, 60)
minButton.Text = "MIN"
minButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minButton.Font = Enum.Font.GothamBold
minButton.TextSize = 11
minButton.Parent = mainFrame

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = minButton

-- Small floating anchor icon when minimized
local openButton = Instance.new("TextButton")
openButton.Name = "OpenAnchor"
openButton.Size = UDim2.new(0, 55, 0, 35)
openButton.Position = UDim2.new(0, 15, 0.4, 0)
openButton.BackgroundColor3 = Color3.fromRGB(140, 80, 255)
openButton.Text = "OPEN"
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.Font = Enum.Font.GothamBold
openButton.TextSize = 11
openButton.Visible = false
openButton.Draggable = true -- Drag the floating OPEN button anywhere out of your way
openButton.Parent = screenGui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(0, 8)
openCorner.Parent = openButton

minButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    openButton.Visible = true
end)

openButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    openButton.Visible = false
end)

-- ========================================================
-- ADVANCED MOBILE FLIGHT MODULE
-- ========================================================
local flyButton = Instance.new("TextButton")
flyButton.Name = "FlyButton"
flyButton.Size = UDim2.new(0, 280, 0, 45)
flyButton.Position = UDim2.new(0, 20, 0, 70)
flyButton.BackgroundColor3 = Color3.fromRGB(45, 40, 60)
flyButton.Text = "Flight Mode: OFF"
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.Font = Enum.Font.GothamBold
flyButton.TextSize = 14
flyButton.Parent = mainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = flyButton

-- Flight Variable States
local flying = false
local flySpeed = 60
local bVel = nil
local bGyro = nil
local flyConnection = nil

flyButton.MouseButton1Click:Connect(function()
    flying = not flying
    local Camera = workspace.CurrentCamera
    local Character = player.Character or player.CharacterAdded:Wait()
    local RootPart = Character:WaitForChild("HumanoidRootPart")
    local Humanoid = Character:WaitForChild("Humanoid")
    
    if flying then
        flyButton.Text = "Flight Mode: ON"
        flyButton.BackgroundColor3 = Color3.fromRGB(140, 80, 255)
        
        -- Physical linear velocity force configuration
        bVel = Instance.new("BodyVelocity")
        bVel.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bVel.Velocity = Vector3.new(0, 0, 0)
        bVel.Parent = RootPart
        
        -- Physical rotational angular lock (stops character glitching sideways)
        bGyro = Instance.new("BodyGyro")
        bGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
        bGyro.CFrame = RootPart.CFrame
        bGyro.Parent = RootPart
        
        Humanoid.PlatformStand = true
        
        -- High-frequency execution loop (updates vector every single frame rendering)
        flyConnection = game:GetService("RunService").RenderStepped:Connect(function()
            if not flying or not RootPart.Parent then return end
            -- Lock your avatar balance orientation straight to your camera orientation
            bGyro.CFrame = Camera.CFrame
            -- Move precisely in the 3D direction the camera vector looks
            bVel.Velocity = Camera.CFrame.LookVector * flySpeed
        end)
    else
        flyButton.Text = "Flight Mode: OFF"
        flyButton.BackgroundColor3 = Color3.fromRGB(45, 40, 60)
        Humanoid.PlatformStand = false
        if bVel then bVel:Destroy() end
        if bGyro then bGyro:Destroy() end
        if flyConnection then flyConnection:Disconnect() end
    end
end)