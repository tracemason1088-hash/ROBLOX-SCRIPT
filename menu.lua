-- 1. Fetch the Visual Elements from the Library
local OrionLib = loadstring(game:HttpGet(('https://githubusercontent.com')))()

-- 2. Create the Visual Window Window (The Main Container)
local Window = OrionLib:MakeWindow({
    Name = "My Custom Visual Menu", 
    HidePremium = true, 
    SaveConfig = false
})

-- 3. Create a Blank Tab on the Side Bar
local BlankTab = Window:MakeTab({
    Name = "Blank Tab Layout",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- 4. A Visual Text Header
BlankTab:AddLabel("This is a blank visual design element.")

-- 5. An Empty Clickable Button
BlankTab:AddButton({
    Name = "Empty Design Button",
    Callback = function()
        -- Left completely empty (No script executes)
    end    
})

-- 6. An Empty On/Off Toggle Switch
BlankTab:AddToggle({
    Name = "Empty Toggle Switch",
    Default = false,
    Callback = function(Value)
        -- Left completely empty (No script executes)
    end    
})

-- 7. An Empty Adjustable Slider
BlankTab:AddSlider({
    Name = "Empty Adjustment Slider",
    Min = 0,
    Max = 100,
    Default = 50,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 1,
    ValueName = "Units",
    Callback = function(Value)
        -- Left completely empty (No script executes)
    end    
})

-- 8. Open the Interface on Screen
OrionLib:Init()
