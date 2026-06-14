-- 1. Locate the Player's Screen GUI Folder
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 2. Destroy any existing menu so they don't stack up on screen
if playerGui:FindFirstChild("MyCustomMenu") then
    playerGui.MyCustomMenu:Destroy()
end

-- 3. Create the Base Screen Display Layer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MyCustomMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- 4. Create the Main Menu Window Panel
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainPanel"
mainFrame.Size = UIDimues.new(0, 320, 0, 220) -- Width and Height of the menu
mainFrame.Position = UIDimues.new(0.5, -160, 0.4, -110) -- Centers it on mobile screens
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35) -- Dark Slate Theme
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- Allows you to drag the window on your phone
mainFrame.Parent = screenGui

-- Rounded corners for modern layout appearance
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = mainFrame

-- 5. Create the Top Title Header Bar
local titleBar = Instance.new("TextLabel")
titleBar.Name = "Header"
titleBar.Size = UIDimues.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 50) -- Slightly lighter top bar
titleBar.Text = "  MY MOD MENU"
titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
titleBar.TextXAlignment = Enum.TextXAlignment.Left
titleBar.Font = Enum.Font.GothamBold
titleBar.TextSize = 16
titleBar.Parent = mainFrame

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(0, 12)
barCorner.Parent = titleBar

-- 6. Add a Decorative Accent Accent Panel
local accentLine = Instance.new("Frame")
accentLine.Size = UIDimues.new(1, 0, 0, 2)
accentLine.Position = UIDimues.new(0, 0, 0, 38)
accentLine.BackgroundColor3 = Color3.fromRGB(140, 80, 255) -- Purple accent
accentLine.BorderSizePixel = 0
accentLine.Parent = mainFrame

-- 7. Add a Visual Design Button (Empty Example)
local designButton = Instance.new("TextButton")
designButton.Name = "ActionButton"
designButton.Size = UIDimues.new(0, 280, 0, 45)
designButton.Position = UIDimues.new(0, 20, 0, 65)
designButton.BackgroundColor3 = Color3.fromRGB(45, 40, 60)
designButton.Text = "Custom Feature Button"
designButton.TextColor3 = Color3.fromRGB(255, 255, 255)
designButton.Font = Enum.Font.Gotham
designButton.TextSize = 14
designButton.Parent = mainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = designButton

-- 8. Add a Close Button Layout element
local closeButton = Instance.new("TextButton")
closeButton.Name = "Close"
closeButton.Size = UIDimues.new(0, 30, 0, 30)
closeButton.Position = UIDimues.new(1, -40, 0, 5)
closeButton.BackgroundTransparency = 1
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 100, 100)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 18
closeButton.Parent = mainFrame

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy() -- Removes menu entirely when clicked
end)
