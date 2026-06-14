-- esp.lua - MM2 Style ESP (Like your screenshot)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local player = Players.LocalPlayer
local ESP_Enabled = false
local Connections = {}
local ESP_Objects = {}

local Colors = {
    Murderer = Color3.fromRGB(255, 50, 50),
    Sheriff = Color3.fromRGB(50, 150, 255),
    Innocent = Color3.fromRGB(0, 255, 100),
    Default = Color3.fromRGB(255, 255, 255)
}

local function CreateESP(plr)
    if plr == player then return end
    
    local data = {}
    
    -- Tracer Line
    data.Tracer = Drawing.new("Line")
    data.Tracer.Thickness = 2.5
    data.Tracer.Transparency = 0.75
    data.Tracer.Visible = false
    
    -- Main Text Label (Name + Role + Distance)
    data.Text = Drawing.new("Text")
    data.Text.Size = 17
    data.Text.Center = true
    data.Text.Outline = true
    data.Text.OutlineColor = Color3.new(0,0,0)
    data.Text.Font = 2 -- Gotham
    data.Text.Visible = false
    
    -- Small character preview glow (Highlight)
    data.Highlight = Instance.new("Highlight")
    data.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    data.Highlight.OutlineTransparency = 0.3
    data.Highlight.FillTransparency = 0.8
    data.Highlight.Parent = plr.Character or workspace
    
    ESP_Objects[plr] = data
end

local function UpdateESP()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == player or not plr.Character then continue end
        
        local root = plr.Character:FindFirstChild("HumanoidRootPart")
        local head = plr.Character:FindFirstChild("Head")
        local humanoid = plr.Character:FindFirstChild("Humanoid")
        
        if not root or not head then continue end
        
        local data = ESP_Objects[plr]
        if not data then
            CreateESP(plr)
            data = ESP_Objects[plr]
        end
        
        -- Role Detection
        local role = "Innocent"
        local roleColor = Colors.Innocent
        
        local roleObj = plr.Character:FindFirstChild("Role") or plr:FindFirstChild("Role")
        if roleObj then
            role = roleObj.Value or "Innocent"
            if role:lower():find("murderer") then
                roleColor = Colors.Murderer
            elseif role:lower():find("sheriff") then
                roleColor = Colors.Sheriff
            end
        end
        
        -- Update Highlight Glow
        data.Highlight.FillColor = roleColor
        data.Highlight.OutlineColor = roleColor
        data.Highlight.Enabled = ESP_Enabled
        
        -- World to Screen
        local rootPos, onScreen = Camera:WorldToViewportPoint(root.Position)
        local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 2.5, 0))
        
        if not onScreen then
            data.Tracer.Visible = false
            data.Text.Visible = false
            continue
        end
        
        -- Tracer (from bottom center like screenshot)
        local screenBottom = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y - 50)
        data.Tracer.From = screenBottom
        data.Tracer.To = Vector2.new(rootPos.X, rootPos.Y)
        data.Tracer.Color = roleColor
        data.Tracer.Visible = ESP_Enabled
        
        -- Main Text (exactly like screenshot style)
        local distance = math.floor((player.Character and player.Character:FindFirstChild("HumanoidRootPart") and 
            (root.Position - player.Character.HumanoidRootPart.Position).Magnitude) or 0)
        
        data.Text.Text = string.format("%s [%s] | %d studs", plr.Name, role, distance)
        data.Text.Position = Vector2.new(rootPos.X, rootPos.Y - 30)
        data.Text.Color = roleColor
        data.Text.Visible = ESP_Enabled
    end
end

-- Public Toggle
getgenv().ToggleESP = function(state)
    ESP_Enabled = state
    if not state then
        for _, data in pairs(ESP_Objects) do
            if data.Tracer then data.Tracer.Visible = false end
            if data.Text then data.Text.Visible = false end
            if data.Highlight then data.Highlight.Enabled = false end
        end
    end
    getgenv().Notify("ESP " .. (state and "Enabled" or "Disabled"), Color3.fromRGB(100, 255, 100))
end

-- Cleanup
Players.PlayerRemoving:Connect(function(plr)
    local data = ESP_Objects[plr]
    if data then
        if data.Tracer then data.Tracer:Remove() end
        if data.Text then data.Text:Remove() end
        if data.Highlight then data.Highlight:Destroy() end
        ESP_Objects[plr] = nil
    end
end)

-- Main Loop
Connections[#Connections+1] = RunService.RenderStepped:Connect(UpdateESP)

-- Auto add new players
Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function() task.wait(1); CreateESP(plr) end)
end)

-- Initial setup
for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= player and plr.Character then CreateESP(plr) end
end

print("✅ MM2 Screenshot-Style ESP Loaded")

-- Test command
getgenv().AddCommand(":esp", function() getgenv().ToggleESP(not ESP_Enabled) end)
