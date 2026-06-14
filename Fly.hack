-- fly.lua - Universal Fly
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local cam = workspace.CurrentCamera
local flying = false
local speed = 50

local function startFly()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local root = char.HumanoidRootPart
    local bv = Instance.new("BodyVelocity")
    local bg = Instance.new("BodyGyro")
    bv.MaxForce = Vector3.new(9e9,9e9,9e9)
    bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
    bv.Parent = root
    bg.Parent = root
    
    task.spawn(function()
        while flying and char.Parent do
            local move = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0,1,0) end
            
            bv.Velocity = move.Unit * speed
            bg.CFrame = cam.CFrame
            task.wait()
        end
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
    end)
end

getgenv().ToggleFly = function(state)
    flying = state
    if state then
        startFly()
        getgenv().Notify("Fly Enabled (Speed: " .. speed .. ")", Color3.fromRGB(0,255,100))
    else
        getgenv().Notify("Fly Disabled")
    end
end

getgenv().AddCommand(":fly", function() ToggleFly(not flying) end)
getgenv().AddCommand(":speed", function(args) speed = tonumber(args[1]) or 50; getgenv().Notify("Fly speed set to " .. speed) end)

print("✅ Fly Loaded")
