-- 1. Locate the Player's Screen GUI Folder
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Destroy any old versions of the menu so they don't stack up
if playerGui:FindFirstChild("MyCustomMenu") then
    playerGui.MyCustomMenu:Destroy()
end

-- 2. Create the Base Screen Layer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MyCustomMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- 3. Create the Main Window Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainPanel"
mainFrame.Size = UDim2.new(0, 320, 0, 220)
mainFrame.Position = UDim2.new(0.5, -160, 0.4, -110) -- Centered on screen
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35) -- Dark sleek background
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- You can drag this on your mobile screen
mainFrame.Parent = screenGui

-- Rounded corners for the menu
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = mainFrame

-- 4. Top Title Header Bar
local titleBar = Instance.new("TextLabel")
titleBar.Name = "Header"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
titleBar.Text = "  MY MOD MENU"
titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
titleBar.TextXAlignment = Enum.TextXAlignment.Left
titleBar.Font = Enum.Font.GothamBold
titleBar.TextSize = 16
titleBar.Parent = mainFrame

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(0, 12)
barCorner.Parent = titleBar

-- Purple Neon Accent Line
local accentLine = Instance.new("Frame")
accentLine.Size = UDim2.new(1, 0, 0, 2)
accentLine.Position = UDim2.new(0, 0, 0, 38)
accentLine.BackgroundColor3 = Color3.fromRGB(140, 80, 255) -- Purple accent
accentLine.BorderSizePixel = 0
accentLine.Parent = mainFrame

-- 5. Close Button Layout
local closeButton = Instance.new("TextButton")
closeButton.Name = "Close"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 5)
closeButton.BackgroundTransparency = 1
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 100, 100)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 18
closeButton.Parent = mainFrame

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy() -- Removes menu when clicked
end)

-- 6. Interactive Fly Hack Button
local flyButton = Instance.new("TextButton")
flyButton.Name = "FlyButton"
flyButton.Size = UDim2.new(0, 280, 0, 45)
flyButton.Position = UDim2.new(0, 20, 0, 70)
flyButton.BackgroundColor3 = Color3.fromRGB(45, 40, 60)
flyButton.Text = "Toggle Fly Hack"
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.Font = Enum.Font.GothamBold
flyButton.TextSize = 14
flyButton.Parent = mainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = flyButton

-- Fly Variables
local flying = false
local flySpeed = 50
local bVel = nil
local flyConnection = nil

-- Fly Logic Function
flyButton.MouseButton1Click:Connect(function()
    flying = not flying
    local Camera = workspace.CurrentCamera
    local Character = player.Character or player.CharacterAdded:Wait()
    local RootPart = Character:WaitForChild("HumanoidRootPart")
    local Humanoid = Character:WaitForChild("Humanoid")
    
    if flying then
        flyButton.BackgroundColor3 = Color3.fromRGB(140, 80, 255) -- Turns Purple when ON
        
        bVel = Instance.new("BodyVelocity")
        bVel.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bVel.Velocity = Vector3.new(0, 0, 0)
        bVel.Parent = RootPart
        Humanoid.PlatformStand = true
        
        flyConnection = game:GetService("RunService").RenderStepped:Connect(function()
            if not flying or not RootPart.Parent then return end
            bVel.Velocity = Camera.CFrame.LookVector * flySpeed
        end)
    else
        flyButton.BackgroundColor3 = Color3.fromRGB(45, 40, 60) -- Turns back when OFF
        Humanoid.PlatformStand = false
        if bVel then bVel:Destroy() end
        if flyConnection then flyConnection:Disconnect() end
    end
end)