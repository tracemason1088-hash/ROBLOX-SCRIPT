local SlaughterHouse = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Noclip = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
local ClickTp = Instance.new("TextButton")
local TextLabel_2 = Instance.new("TextLabel")
local HeadTp = Instance.new("TextButton")
local TextLabel_3 = Instance.new("TextLabel")
local Sprint = Instance.new("TextButton")
local TextLabel_4 = Instance.new("TextLabel")
local GrabCoins = Instance.new("TextButton")
local God = Instance.new("TextButton")
local TeleportLobby = Instance.new("TextButton")
local GMS = Instance.new("TextButton")
local WS = Instance.new("TextButton")
local BTD = Instance.new("TextButton")
local BTG = Instance.new("TextButton")
local BTC = Instance.new("TextButton")
local BT = Instance.new("TextButton")
local LOCK = Instance.new("TextButton")
local Value = Instance.new("TextBox")
local Open = Instance.new("TextButton")
 
-- Properties
 
SlaughterHouse.Name = "SlaughterHouse"
SlaughterHouse.Parent = game.Players.LocalPlayer.PlayerGui
SlaughterHouse.Enabled = true
SlaughterHouse.ResetOnSpawn = false
 
MainFrame.Name = "MainFrame"
MainFrame.Parent = SlaughterHouse
MainFrame.BackgroundColor3 = Color3.new(0.580392, 0, 0)
MainFrame.BorderColor3 = Color3.new(0.223529, 0.34902, 0.439216)
MainFrame.BorderSizePixel = 4
MainFrame.Position = UDim2.new(0, 800, 0, 200)
MainFrame.Size = UDim2.new(0, 500, 0, 300)
 
Noclip.Name = "Noclip"
Noclip.Parent = MainFrame
Noclip.BackgroundColor3 = Color3.new(0.639216, 0, 0)
Noclip.BorderColor3 = Color3.new(0.176471, 0.27451, 0.345098)
Noclip.BorderSizePixel = 5
Noclip.Position = UDim2.new(0, 350, 0, 75)
Noclip.Size = UDim2.new(0, 25, 0, 25)
Noclip.Font = Enum.Font.SourceSans
Noclip.Text = ""
Noclip.TextColor3 = Color3.new(1, 1, 1)
Noclip.TextSize = 14
 
TextLabel.Parent = Noclip
TextLabel.BackgroundColor3 = Color3.new(0.666667, 0, 0)
TextLabel.BorderSizePixel = 2
TextLabel.Position = UDim2.new(0, 35, 0, 0)
TextLabel.Size = UDim2.new(0, 75, 0, 25)
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.Text = "Noclip [F]"
TextLabel.TextColor3 = Color3.new(1, 1, 1)
TextLabel.TextScaled = true
TextLabel.TextSize = 50
TextLabel.TextWrapped = true
 
ClickTp.Name = "ClickTp"
ClickTp.Parent = MainFrame
ClickTp.BackgroundColor3 = Color3.new(0.639216, 0, 0)
ClickTp.BorderColor3 = Color3.new(0.176471, 0.27451, 0.345098)
ClickTp.BorderSizePixel = 5
ClickTp.Position = UDim2.new(0, 350, 0, 125)
ClickTp.Size = UDim2.new(0, 25, 0, 25)
ClickTp.Font = Enum.Font.SourceSans
ClickTp.Text = ""
ClickTp.TextColor3 = Color3.new(1, 1, 1)
ClickTp.TextSize = 14
 
TextLabel_2.Parent = ClickTp
TextLabel_2.BackgroundColor3 = Color3.new(0.666667, 0, 0)
TextLabel_2.BorderSizePixel = 2
TextLabel_2.Position = UDim2.new(0, 35, 0, 0)
TextLabel_2.Size = UDim2.new(0, 75, 0, 25)
TextLabel_2.Font = Enum.Font.SourceSansBold
TextLabel_2.Text = "ClickTp [R]"
TextLabel_2.TextColor3 = Color3.new(1, 1, 1)
TextLabel_2.TextScaled = true
TextLabel_2.TextSize = 50
TextLabel_2.TextWrapped = true
 
HeadTp.Name = "HeadTp"
HeadTp.Parent = MainFrame
HeadTp.BackgroundColor3 = Color3.new(0.639216, 0, 0)
HeadTp.BorderColor3 = Color3.new(0.176471, 0.27451, 0.345098)
HeadTp.BorderSizePixel = 5
HeadTp.Position = UDim2.new(0, 350, 0, 25)
HeadTp.Size = UDim2.new(0, 25, 0, 25)
HeadTp.Font = Enum.Font.SourceSans
HeadTp.Text = ""
HeadTp.TextColor3 = Color3.new(1, 1, 1)
HeadTp.TextSize = 14
 
TextLabel_3.Parent = HeadTp
TextLabel_3.BackgroundColor3 = Color3.new(0.666667, 0, 0)
TextLabel_3.BorderSizePixel = 2
TextLabel_3.Position = UDim2.new(0, 35, 0, 0)
TextLabel_3.Size = UDim2.new(0, 100, 0, 25)
TextLabel_3.Font = Enum.Font.SourceSansBold
TextLabel_3.Text = "Head Tp [Tab]"
TextLabel_3.TextColor3 = Color3.new(1, 1, 1)
TextLabel_3.TextScaled = true
TextLabel_3.TextSize = 50
TextLabel_3.TextWrapped = true
 -- menu.lua - Universal Modern Admin Hub GUI
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UniversalAdminHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 560, 0, 460)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -230)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 55)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
Title.Text = "UNIVERSAL ADMIN HUB"
Title.TextColor3 = Color3.fromRGB(255, 90, 90)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 16)

-- Close
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 40, 0, 40)
Close.Position = UDim2.new(1, -45, 0, 8)
Close.BackgroundTransparency = 1
Close.Text = "✕"
Close.TextColor3 = Color3.fromRGB(255, 80, 80)
Close.TextScaled = true
Close.Font = Enum.Font.GothamBold
Close.Parent = Title
Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Notification
local function Notify(text, color)
    color = color or Color3.fromRGB(100, 255, 100)
    local notif = Instance.new("TextLabel")
    notif.Size = UDim2.new(0, 320, 0, 45)
    notif.Position = UDim2.new(0.5, -160, 0, 70)
    notif.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    notif.Text = text
    notif.TextColor3 = color
    notif.TextScaled = true
    notif.Font = Enum.Font.GothamSemibold
    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 10)
    notif.Parent = ScreenGui
    
    TweenService:Create(notif, TweenInfo.new(0.4), {Position = UDim2.new(0.5, -160, 0, 100)}):Play()
    task.delay(3, function()
        TweenService:Create(notif, TweenInfo.new(0.5), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
        task.wait(0.6); notif:Destroy()
    end)
end

-- Chat Commands
local Commands = {}
game.Players.LocalPlayer.Chatted:Connect(function(msg)
    if msg:sub(1,1) ~= ":" then return end
    local args = msg:split(" ")
    local cmd = args[1]:lower()
    table.remove(args,1)
    
    if Commands[cmd] then
        Commands[cmd](args)
    else
        Notify("Unknown command: " .. cmd, Color3.fromRGB(255,100,100))
    end
end)

-- Expose for other scripts
getgenv().Notify = Notify
getgenv().AddCommand = function(cmd, func) Commands[cmd:lower()] = func end

Notify("Universal Admin Hub Loaded! Type :help", Color3.fromRGB(100,200,255))
print("✅ Menu Loaded")
