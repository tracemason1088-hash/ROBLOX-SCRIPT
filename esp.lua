local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local ESP_Color = Color3.fromRGB(0, 255, 0) -- Neon Green from your image

-- Table to keep track of active ESP elements
local ActiveESP = {}

-- Function to clean up ESP elements for a single player
local function removeESP(player)
    if ActiveESP[player] then
        for _, obj in pairs(ActiveESP[player]) do
            if obj then obj:Destroy() end
        end
        ActiveESP[player] = nil
    end
end

-- Function to create ESP elements for a player
local function createESP(player)
    if player == LocalPlayer then return end
    
    removeESP(player) -- Reset if already exists
    ActiveESP[player] = {}
    
    local function setupCharacter(character)
        local root = character:WaitForChild("HumanoidRootPart", 5)
        local humanoid = character:WaitForChild("Humanoid", 5)
        if not root or not humanoid then return end
        
        -- 1. CHAMS (The Neon Green Body Glow)
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESPHighlight"
        highlight.FillColor = ESP_Color
        highlight.FillTransparency = 0.4
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.OutlineTransparency = 0.2
        highlight.Adornee = character
        highlight.Parent = character
        table.insert(ActiveESP[player], highlight)
        
        -- 2. TEXT PANEL (Name and Distance)
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESPText"
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.AlwaysOnTop = true
        billboard.ExtentsOffset = Vector3.new(0, 3, 0) -- Places text above head
        billboard.Adornee = root
        billboard.Parent = root
        table.insert(ActiveESP[player], billboard)
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextColor3 = ESP_Color
        textLabel.Font = Enum.Font.GothamBold
        textLabel.TextSize = 14
        textLabel.TextStrokeTransparency = 0 -- Adds dark outline for visibility
        textLabel.Parent = billboard
        
        -- 3. TRACERS (Line Connecting Camera to Player)
        local tracer = Instance.new("LineHandleAdornment")
        tracer.Name = "ESPTracer"
        tracer.Length = 0
        tracer.Thickness = 2
        tracer.Color3 = ESP_Color
        tracer.AlwaysOnTop = true
        tracer.ZIndex = 10
        tracer.Adornee = Camera
        tracer.Parent = Camera
        table.insert(ActiveESP[player], tracer)
        
        -- Loop to continuously update Distance and Tracer lines
        local updateConnection
        updateConnection = RunService.RenderStepped:Connect(function()
            if not character.Parent or not root.Parent or humanoid.Health <= 0 then
                updateConnection:Disconnect()
                return
            end
            
            -- Calculate real distance in studs
            local distance = math.floor((LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - root.Position).Magnitude) or 0)
            textLabel.Text = player.Name .. " | " .. distance .. " studs"
            
            -- Update Tracer positions (Lines come from the top middle of the screen)
            local screenPos, onScreen = Camera:WorldToViewportPoint(root.Position)
            if onScreen then
                tracer.Visible = true
                -- Origin position at the top middle of the viewport camera matrix
                local startRay = Camera:ViewportPointToRay(Camera.ViewportSize.X / 2, 0)
                tracer.CFrame = CFrame.lookAt(startRay.Origin, root.Position)
                tracer.Length = (startRay.Origin - root.Position).Magnitude
            else
                tracer.Visible = false
            end
        end)
    end
    
    if player.Character then setupCharacter(player.Character) end
    player.CharacterAdded:Connect(setupCharacter)
end

-- Initialize for existing players and watch for new ones
for _, p in pairs(Players:GetPlayers()) do createESP(p) end
Players.PlayerAdded:Connect(createESP)
Players.PlayerRemoving:Connect(removeESP)