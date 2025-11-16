-- Cripzy's Hub - Brookhaven GUI Script
-- Made by Owhelljhon (edit your hub name below)
local HUB_NAME = "Cripzy's Hub"

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local FlyEnabled = false
local ESPEnabled = false
local SkyState = 1

-- Create GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FlyButton = Instance.new("TextButton")
local ESPButton = Instance.new("TextButton")
local SkyButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

-- GUI Properties
MainFrame.Size = UDim2.new(0, 250, 0, 200)
MainFrame.Position = UDim2.new(0.5, -125, 0.4, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = HUB_NAME
Title.TextSize = 24
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

FlyButton.Size = UDim2.new(0.8, 0, 0, 30)
FlyButton.Position = UDim2.new(0.1, 0, 0.3, 0)
FlyButton.Text = "Fly: OFF"
FlyButton.Parent = MainFrame

ESPButton.Size = UDim2.new(0.8, 0, 0, 30)
ESPButton.Position = UDim2.new(0.1, 0, 0.5, 0)
ESPButton.Text = "ESP: OFF"
ESPButton.Parent = MainFrame

SkyButton.Size = UDim2.new(0.8, 0, 0, 30)
SkyButton.Position = UDim2.new(0.1, 0, 0.7, 0)
SkyButton.Text = "Sky: Day"
SkyButton.Parent = MainFrame

-- Rainbow UI effect
spawn(function()
    while true do
        for hue = 0, 1, 0.01 do
            Title.TextColor3 = Color3.fromHSV(hue, 1, 1)
            wait(0.05)
        end
    end
end)

-- Fly code
local function toggleFly()
    FlyEnabled = not FlyEnabled
    FlyButton.Text = "Fly: " .. (FlyEnabled and "ON" or "OFF")
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    if FlyEnabled then
        humanoid.PlatformStand = true
        while FlyEnabled do
            character:TranslateBy(Vector3.new(0, 0.5, 0))
            wait()
        end
        humanoid.PlatformStand = false
    end
end

-- ESP code
local function toggleESP()
    ESPEnabled = not ESPEnabled
    ESPButton.Text = "ESP: " .. (ESPEnabled and "ON" or "OFF")
    
    if ESPEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local billboard = Instance.new("BillboardGui")
                billboard.Name = "ESP"
                billboard.Adornee = player.Character:WaitForChild("HumanoidRootPart")
                billboard.Size = UDim2.new(0, 200, 0, 50)
                billboard.StudsOffset = Vector3.new(0, 3, 0)
                billboard.AlwaysOnTop = true
                local text = Instance.new("TextLabel", billboard)
                text.Size = UDim2.new(1, 0, 1, 0)
                text.Text = player.Name
                text.TextColor3 = Color3.new(1, 1, 1)
                text.BackgroundTransparency = 1
                billboard.Parent = player.Character
            end
        end
    else
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character:FindFirstChild("ESP") then
                player.Character.ESP:Destroy()
            end
        end
    end
end

-- Sky changer
local function changeSky()
    SkyState = SkyState + 1
    if SkyState > 3 then SkyState = 1 end
    
    if SkyState == 1 then
        SkyButton.Text = "Sky: Day"
        Lighting.ClockTime = 12
    elseif SkyState == 2 then
        SkyButton.Text = "Sky: Evening"
        Lighting.ClockTime = 18
    elseif SkyState == 3 then
        SkyButton.Text = "Sky: Night"
        Lighting.ClockTime = 0
    end
end

-- Button events
FlyButton.MouseButton1Click:Connect(toggleFly)
ESPButton.MouseButton1Click:Connect(toggleESP)
SkyButton.MouseButton1Click:Connect(changeSky)
