-- movement.lua
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

getgenv().ToggleNoclip = function(state)
    if state then
        getgenv().NoclipConn = game:GetService("RunService").Stepped:Connect(function()
            if char and char:FindFirstChild("HumanoidRootPart") then
                for _,v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
            end
        end)
    else
        if getgenv().NoclipConn then getgenv().NoclipConn:Disconnect() end
    end
    getgenv().Notify("Noclip " .. (state and "ON" or "OFF"))
end

getgenv().SetWalkSpeed = function(val)
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = val
    end
end

getgenv().SetJumpPower = function(val)
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = val
    end
end

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if getgenv().InfJump then
        char:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

getgenv().AddCommand(":ws", function(args) getgenv().SetWalkSpeed(tonumber(args[1]) or 50) end)
getgenv().AddCommand(":jp", function(args) getgenv().SetJumpPower(tonumber(args[1]) or 200) end)
getgenv().AddCommand(":noclip", function(args) getgenv().ToggleNoclip(not getgenv().Noclip) end)
getgenv().AddCommand(":infjump", function() getgenv().InfJump = not getgenv().InfJump; getgenv().Notify("Infinite Jump " .. (getgenv().InfJump and "ON" or "OFF")) end)

