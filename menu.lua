local Fluent = loadstring(game:HttpGet("https://github.com"))()
local SaveManager = loadstring(game:HttpGet("https://githubusercontent.com"))()
local InterfaceManager = loadstring(game:HttpGet("https://githubusercontent.com"))()

-- Create the main menu window
local Window = Fluent:CreateWindow({
    Title = "Professional Script Hub",
    SubTitle = "by YourName",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- Enables a blur background effect
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Toggle menu visibility
})

-- Add navigation tabs
local Tabs = {
    Main = Window:AddTab({ Title = "Main Features", Icon = "home" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- Add a notification to confirm loading
Fluent:Notify({
    Title = "Script Loaded",
    Content = "Welcome to your professional menu hub.",
    Duration = 5
})

-- 1. BUTTON ELEMENT
Tabs.Main:AddButton({
    Title = "Execute Main Script",
    Description = "Runs your core script functionality",
    Callback = function()
        print("Main script executed!")
    end
})

-- 2. TOGGLE ELEMENT
local MainToggle = Tabs.Main:AddToggle("AutoFarmToggle", {
    Title = "Auto Farm", 
    Default = false 
})

MainToggle:OnChanged(function(Value)
    print("Auto Farm changed:", Value)
    -- Your looping logic goes here
end)

-- 3. SLIDER ELEMENT
local SpeedSlider = Tabs.Main:AddSlider("WalkSpeedSlider", {
    Title = "Walkspeed Changer",
    Description = "Adjust your character speed safely",
    Default = 16,
    Min = 16,
    Max = 150,
    Rounding = 0,
    Callback = function(Value)
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end
})

-- Initialize the background save/theme managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/configs")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)
SaveManager:LoadAutoloadConfig()