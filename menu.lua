local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("MobileMenuSystem") then
    playerGui.MobileMenuSystem:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MobileMenuSystem"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- ========================================================
-- MAIN PANEL VISUAL LAYOUT
-- ========================================================
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainPanel"
mainFrame.Size = UDim2.new(0, 320, 0, 260)
mainFrame.Position = UDim2.new(0.5, -160, 0.4, -130)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.Active = true
mainFrame.Draggable = true 
mainFrame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = mainFrame

-- Title Header Bar
local titleBar = Instance.new("TextLabel")
titleBar.Name = "Header"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
titleBar.Text = "  MY MOD HUB"
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
accentLine.BackgroundColor3 = Color3.fromRGB(140, 80, 255) -- Purple Accent Theme
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
-- MINIMIZE SYSTEM
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
openButton.Draggable = true 
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
-- CLICKABLE BUTTONS (REDIRECTS TO EXTERNAL SCRIPTS)
-- ========================================================

-- BUTTON 1: Flight Redirect
local flyButton = Instance.new("TextButton")
flyButton.Name = "FlyButton"
flyButton.Size = UDim2.new(0, 280, 0, 45)
flyButton.Position = UDim2.new(0, 20, 0, 70)
flyButton.BackgroundColor3 = Color3.fromRGB(45, 40, 60)
flyButton.Text = "Load Flight System"
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.Font = Enum.Font.GothamBold
flyButton.TextSize = 14
flyButton.Parent = mainFrame

local btnCorner1 = Instance.new("UICorner")
btnCorner1.CornerRadius = UDim.new(0, 8)
btnCorner1.Parent = flyButton

flyButton.MouseButton1Click:Connect(function()
    flyButton.Text = "Loading..."
    -- Pulls purely your external fly script code string
    loadstring(game:HttpGet("https://githubusercontent.com"))()
    flyButton.Text = "Flight System Loaded"
    flyButton.BackgroundColor3 = Color3.fromRGB(140, 80, 255)
end)

-- BUTTON 2: ESP Redirect
local espButton = Instance.new("TextButton")
espButton.Name = "ESPButton"
espButton.Size = UDim2.new(0, 280, 0, 45)
espButton.Position = UDim2.new(0, 20, 0, 130)
espButton.BackgroundColor3 = Color3.fromRGB(45, 40, 60)
espButton.Text = "Load Visual ESP Matrix"
espButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espButton.Font = Enum.Font.GothamBold
espButton.TextSize = 14
espButton.Parent = mainFrame

local btnCorner2 = Instance.new("UICorner")
btnCorner2.CornerRadius = UDim.new(0, 8)
btnCorner2.Parent = espButton

espButton.MouseButton1Click:Connect(function()
    espButton.Text = "Loading..."
    -- Pulls purely your external ESP script code string
    loadstring(game:HttpGet("https://githubusercontent.com"))()
    espButton.Text = "ESP Matrix Loaded"
    espButton.BackgroundColor3 = Color3.fromRGB(140, 80, 255)
end)