-- menu.lua - Modern Professional Universal Admin Hub
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
Title.Size = UDim2.new(1, -140, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "UNIVERSAL ADMIN HUB"
Title.TextColor3 = Color3.fromRGB(255, 80, 80)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = TitleBar

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 50, 0, 50)
CloseBtn.Position = UDim2.new(1, -55, 0, 5)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Left Sidebar (Tabs)
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 180, 1, -60)
Sidebar.Position = UDim2.new(0, 0, 0, 60)
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 16)

-- Content Area
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -180, 1, -60)
Content.Position = UDim2.new(0, 180, 0, 60)
Content.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
Content.BorderSizePixel = 0
Content.Parent = MainFrame

Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 16)

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

-- Chat Command System
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

-- Example Toggles (you can expand)
local toggles = {}

local function CreateToggle(parent, name, key, default, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -20, 0, 50)
    toggleFrame.Position = UDim2.new(0, 10, 0, #toggles * 60 + 20)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    toggleFrame.Parent = parent
    Instance.new("UICorner", toggleFrame).CornerRadius = UDim.new(0, 10)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = name .. "  [" .. key .. "]"
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.GothamSemibold
    label.TextScaled = true
    label.Parent = toggleFrame
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 80, 0, 35)
    button.Position = UDim2.new(1, -90, 0.5, -17.5)
    button.BackgroundColor3 = default and Color3.fromRGB(0, 170, 100) or Color3.fromRGB(100, 100, 100)
    button.Text = default and "ON" or "OFF"
    button.TextColor3 = Color3.new(1,1,1)
    button.Font = Enum.Font.GothamBold
    button.Parent = toggleFrame
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)
    
    button.MouseButton1Click:Connect(function()
        default = not default
        button.BackgroundColor3 = default and Color3.fromRGB(0, 170, 100) or Color3.fromRGB(100, 100, 100)
        button.Text = default and "ON" or "OFF"
        if callback then callback(default) end
    end)
    
    table.insert(toggles, toggleFrame)
end

-- Add Toggles Here
CreateToggle(Content, "ESP", "E", false, function(state)
    if getgenv().ToggleESP then getgenv().ToggleESP(state) end
end)

CreateToggle(Content, "Fly", "F", false, function(state)
    if getgenv().ToggleFly then getgenv().ToggleFly(state) end
end)

CreateToggle(Content, "Noclip", "N", false, function(state)
    if getgenv().ToggleNoclip then getgenv().ToggleNoclip(state) end
end)

CreateToggle(Content, "Infinite Jump", "J", false, function(state)
    getgenv().InfJump = state
    getgenv().Notify("Infinite Jump " .. (state and "ON" or "OFF"))
end)

-- Commands
getgenv().AddCommand(":esp", function() 
    local state = not (getgenv().ESP_Enabled or false)
    if getgenv().ToggleESP then getgenv().ToggleESP(state) end
end)

getgenv().AddCommand(":fly", function() 
    if getgenv().ToggleFly then getgenv().ToggleFly(not getgenv().flying) end
end)

getgenv().AddCommand(":noclip", function() 
    if getgenv().ToggleNoclip then getgenv().ToggleNoclip(not getgenv().Noclip) end
end)

getgenv().Notify("Universal Admin Hub Loaded!", Color3.fromRGB(100, 200, 255))
print("✅ Modern Menu Loaded - Check in-game")
