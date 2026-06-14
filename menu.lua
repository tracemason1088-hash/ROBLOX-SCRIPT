-- menu.lua - Neon Modern Admin Hub (Magnet Simulator Ready)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NeonAdminHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 680, 0, 520)
MainFrame.Position = UDim2.new(0.5, -340, 0.5, -260)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(0, 255, 200)

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 65)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
TitleBar.Parent = MainFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 16)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -180, 1, 0)
Title.Position = UDim2.new(0, 25, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "NEON ADMIN HUB"
Title.TextColor3 = Color3.fromRGB(0, 255, 200)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = TitleBar

-- Minimize & Close
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 50, 0, 50)
MinimizeBtn.Position = UDim2.new(1, -115, 0, 8)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Text = "−"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 220, 100)
MinimizeBtn.TextScaled = true
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 50, 0, 50)
CloseBtn.Position = UDim2.new(1, -60, 0, 8)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar

-- Content
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -30, 1, -85)
Content.Position = UDim2.new(0, 15, 0, 75)
Content.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
Content.Parent = MainFrame
Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 12)

-- Minimize Logic
local isMinimized = false
local originalSize = MainFrame.Size

local function ToggleMinimize()
    isMinimized = not isMinimized
    if isMinimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 680, 0, 65)}):Play()
        Content.Visible = false
        MinimizeBtn.Text = "+"
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quint), {Size = originalSize}):Play()
        Content.Visible = true
        MinimizeBtn.Text = "−"
    end
end

MinimizeBtn.MouseButton1Click:Connect(ToggleMinimize)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Keybind (Insert)
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

-- Notification
getgenv().Notify = function(text, color)
    color = color or Color3.fromRGB(0, 255, 200)
    local notif = Instance.new("TextLabel")
    notif.Size = UDim2.new(0, 340, 0, 55)
    notif.Position = UDim2.new(0.5, -170, 0, 90)
    notif.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    notif.Text = text
    notif.TextColor3 = color
    notif.TextScaled = true
    notif.Font = Enum.Font.GothamSemibold
    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 12)
    notif.Parent = ScreenGui
    TweenService:Create(notif, TweenInfo.new(0.4), {Position = UDim2.new(0.5, -170, 0, 130)}):Play()
    task.delay(3, function() notif:Destroy() end)
end

-- Toggle Creator
local yOffset = 10
local function AddToggle(name, key, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -30, 0, 65)
    frame.Position = UDim2.new(0, 15, 0, yOffset)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.Parent = Content
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.65, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = name .. "  [" .. key .. "]"
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.GothamSemibold
    label.TextScaled = true
    label.Parent = frame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 95, 0, 42)
    btn.Position = UDim2.new(1, -110, 0.5, -21)
    btn.BackgroundColor3 = default and Color3.fromRGB(0, 255, 180) or Color3.fromRGB(80, 80, 90)
    btn.Text = default and "ON" or "OFF"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.Parent = frame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    
    btn.MouseButton1Click:Connect(function()
        default = not default
        btn.BackgroundColor3 = default and Color3.fromRGB(0, 255, 180) or Color3.fromRGB(80, 80, 90)
        btn.Text = default and "ON" or "OFF"
        if callback then callback(default) end
    end)
    
    yOffset += 75
end

-- === Magnet Simulator Toggles ===
AddToggle("Anti-AFK", "None", true, function(s) getgenv().AntiAFK = s end)
AddToggle("Auto Farm Coins", "F1", false, function(s) getgenv().AutoFarm = s end)
AddToggle("Auto Sell", "F2", false, function(s) getgenv().AutoSell = s end)
AddToggle("Auto Buy Magnets", "F3", false, function(s) getgenv().AutoBuyMagnets = s end)
AddToggle("Auto Buy Backpacks", "F4", false, function(s) getgenv().AutoBuyBackpacks = s end)
AddToggle("Auto Rebirth", "F5", false, function(s) getgenv().AutoRebirth = s end)
AddToggle("Auto Open Eggs", "F6", false, function(s) getgenv().AutoOpenEggs = s end)
AddToggle("Noclip (G)", "G", false, function(s) getgenv().Noclip = s end)
AddToggle("Fly (B)", "B", false, function(s) getgenv().Fly = s end)

getgenv().Notify("Neon Hub Loaded for Magnet Simulator!", Color3.fromRGB(0, 255, 200))
print("✅ Neon Menu Loaded")
