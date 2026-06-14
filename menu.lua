-- menu.lua - Modern Universal Admin Hub (with Minimize + Close)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UniversalAdminHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 620, 0, 480)
MainFrame.Position = UDim2.new(0.5, -310, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 60)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 16)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -160, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "UNIVERSAL ADMIN HUB"
Title.TextColor3 = Color3.fromRGB(255, 80, 80)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = TitleBar

-- Minimize Button
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 40, 0, 40)
MinimizeBtn.Position = UDim2.new(1, -100, 0, 10)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Text = "−"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 220, 100)
MinimizeBtn.TextScaled = true
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Parent = TitleBar

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -55, 0, 10)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar

-- Content Area
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -20, 1, -80)
Content.Position = UDim2.new(0, 10, 0, 70)
Content.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
Content.BorderSizePixel = 0
Content.Parent = MainFrame
Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 12)

local isMinimized = false
local originalSize = MainFrame.Size

local function ToggleMinimize()
    isMinimized = not isMinimized
    if isMinimized then
        -- Minimize
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
            Size = UDim2.new(0, 620, 0, 60)
        }):Play()
        Content.Visible = false
        MinimizeBtn.Text = "+"
    else
        -- Restore
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
            Size = originalSize
        }):Play()
        Content.Visible = true
        MinimizeBtn.Text = "−"
    end
end

MinimizeBtn.MouseButton1Click:Connect(ToggleMinimize)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Click Title Bar to restore if minimized
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and isMinimized then
        ToggleMinimize()
    end
end)

-- Notification Function
getgenv().Notify = function(text, color)
    color = color or Color3.fromRGB(80, 255, 120)
    local notif = Instance.new("TextLabel")
    notif.Size = UDim2.new(0, 340, 0, 50)
    notif.Position = UDim2.new(0.5, -170, 0, 80)
    notif.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    notif.Text = text
    notif.TextColor3 = color
    notif.TextScaled = true
    notif.Font = Enum.Font.GothamSemibold
    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 12)
    notif.Parent = ScreenGui
    
    TweenService:Create(notif, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0.5, -170, 0, 120)}):Play()
    task.delay(3, function()
        TweenService:Create(notif, TweenInfo.new(0.6), {TextTransparency=1, BackgroundTransparency=1}):Play()
        task.wait(0.7); notif:Destroy()
    end)
end

-- Chat Commands
local Commands = {}
getgenv().AddCommand = function(cmd, func)
    Commands[cmd:lower()] = func
end

player.Chatted:Connect(function(msg)
    if msg:sub(1,1) == ":" then
        local args = string.split(msg, " ")
        local cmd = table.remove(args, 1):lower()
        if Commands[cmd] then
            Commands[cmd](args)
        else
            getgenv().Notify("Unknown command: " .. cmd, Color3.fromRGB(255, 100, 100))
        end
    end
end)

-- Example Toggles (expand as needed)
local function CreateToggle(name, key, defaultState, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -20, 0, 55)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    toggleFrame.Parent = Content
    Instance.new("UICorner", toggleFrame).CornerRadius = UDim.new(0, 10)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.65, 0, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name .. "   [" .. key .. "]"
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.GothamSemibold
    label.TextScaled = true
    label.Parent = toggleFrame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 90, 0, 38)
    btn.Position = UDim2.new(1, -105, 0.5, -19)
    btn.BackgroundColor3 = defaultState and Color3.fromRGB(0, 170, 100) or Color3.fromRGB(100, 100, 100)
    btn.Text = defaultState and "ON" or "OFF"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.Parent = toggleFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    btn.MouseButton1Click:Connect(function()
        defaultState = not defaultState
        btn.BackgroundColor3 = defaultState and Color3.fromRGB(0, 170, 100) or Color3.fromRGB(100, 100, 100)
        btn.Text = defaultState and "ON" or "OFF"
        if callback then callback(defaultState) end
    end)
end

-- Add your toggles here
CreateToggle("ESP", "E", false, function(s) if getgenv().ToggleESP then getgenv().ToggleESP(s) end end)
CreateToggle("Fly", "F", false, function(s) if getgenv().ToggleFly then getgenv().ToggleFly(s) end end)
CreateToggle("Noclip", "N", false, function(s) if getgenv().ToggleNoclip then getgenv().ToggleNoclip(s) end end)
CreateToggle("Infinite Jump", "J", false, function(s) getgenv().InfJump = s end)

-- Commands
getgenv().AddCommand(":esp", function() if getgenv().ToggleESP then getgenv().ToggleESP(not getgenv().ESP_Enabled) end end)
getgenv().AddCommand(":fly", function() if getgenv().ToggleFly then getgenv().ToggleFly(not getgenv().flying) end end)

getgenv().Notify("Universal Admin Hub Loaded! (Minimize with −)", Color3.fromRGB(100, 200, 255))
print("✅ Menu with Minimize + Close Loaded")
