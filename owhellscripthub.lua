-- Steal a Brainrot GUI by Owhelljhon (OwhellHubz)
-- Features: ESP, FPS Killer (Smart Ultra Mode), Anti-Lag, Reset Button
-- Blue when OFF, Green when ON | Draggable GUI

local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local runService = game:GetService("RunService")

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ESPButton = Instance.new("TextButton")
local FPSButton = Instance.new("TextButton")
local AntiLagButton = Instance.new("TextButton")
local ResetButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Parent = game.CoreGui

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(0, 85, 170)
Frame.Size = UDim2.new(0, 220, 0, 220)
Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
Frame.Active = true
Frame.Draggable = true
UICorner.Parent = Frame

-- Title
Title.Parent = Frame
Title.Text = "OwhellHubz"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(0, 70, 140)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextScaled = true

-- ESP Button
ESPButton.Parent = Frame
ESPButton.Text = "ESP: OFF"
ESPButton.Size = UDim2.new(0, 200, 0, 40)
ESPButton.Position = UDim2.new(0, 10, 0, 40)
ESPButton.BackgroundColor3 = Color3.fromRGB(0, 85, 170)
ESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPButton.Font = Enum.Font.SourceSansBold
ESPButton.TextScaled = true

-- FPS Killer Button
FPSButton.Parent = Frame
FPSButton.Text = "FPS Killer: OFF"
FPSButton.Size = UDim2.new(0, 200, 0, 40)
FPSButton.Position = UDim2.new(0, 10, 0, 90)
FPSButton.BackgroundColor3 = Color3.fromRGB(0, 85, 170)
FPSButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FPSButton.Font = Enum.Font.SourceSansBold
FPSButton.TextScaled = true

-- Anti-Lag Button
AntiLagButton.Parent = Frame
AntiLagButton.Text = "Anti-Lag: OFF"
AntiLagButton.Size = UDim2.new(0, 200, 0, 40)
AntiLagButton.Position = UDim2.new(0, 10, 0, 140)
AntiLagButton.BackgroundColor3 = Color3.fromRGB(0, 85, 170)
AntiLagButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiLagButton.Font = Enum.Font.SourceSansBold
AntiLagButton.TextScaled = true

-- Reset Button
ResetButton.Parent = Frame
ResetButton.Text = "RESET GUI"
ResetButton.Size = UDim2.new(0, 200, 0, 40)
ResetButton.Position = UDim2.new(0, 10, 0, 190)
ResetButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
ResetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetButton.Font = Enum.Font.SourceSansBold
ResetButton.TextScaled = true

-- Variables
local espEnabled = false
local fpsKill = false
local antiLag = false

-- ESP Function
local function addESP(player)
    if espEnabled and player.Character and not player.Character:FindFirstChild("OwhellESP") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "OwhellESP"
        highlight.FillColor = Color3.fromRGB(0, 255, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.Parent = player.Character
    end
end

ESPButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        ESPButton.Text = "ESP: ON"
        ESPButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        for _, player in pairs(players:GetPlayers()) do
            if player ~= localPlayer then
                addESP(player)
            end
        end
    else
        ESPButton.Text = "ESP: OFF"
        ESPButton.BackgroundColor3 = Color3.fromRGB(0, 85, 170)
        for _, player in pairs(players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("OwhellESP") then
                player.Character.OwhellESP:Destroy()
            end
        end
    end
end)

players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        if espEnabled then
            task.wait(1)
            addESP(player)
        end
    end)
end)

-- FPS Killer Function (Ultra Mode)
FPSButton.MouseButton1Click:Connect(function()
    fpsKill = not fpsKill
    if fpsKill then
        FPSButton.Text = "FPS Killer: ON"
        FPSButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        task.spawn(function()
            while fpsKill do
                local char = localPlayer.Character
                if char and char:FindFirstChild("Stealing") then
                    for i = 1, 10 do -- Spam 10 times per frame
                        game.ReplicatedStorage.Remotes.SwingBat:FireServer()
                    end
                end
                task.wait(0.001) -- Extremely fast
            end
        end)
    else
        FPSButton.Text = "FPS Killer: OFF"
        FPSButton.BackgroundColor3 = Color3.fromRGB(0, 85, 170)
    end
end)

-- Anti-Lag Function (Client only)
AntiLagButton.MouseButton1Click:Connect(function()
    antiLag = not antiLag
    if antiLag then
        AntiLagButton.Text = "Anti-Lag: ON"
        AntiLagButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Enabled = false
            end
        end
    else
        AntiLagButton.Text = "Anti-Lag: OFF"
        AntiLagButton.BackgroundColor3 = Color3.fromRGB(0, 85, 170)
    end
end)

-- Reset GUI Button
ResetButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    loadstring(game:HttpGet("PASTE_YOUR_SCRIPT_LINK_HERE"))() -- You can host your script on Pastebin or GitHub
end)
