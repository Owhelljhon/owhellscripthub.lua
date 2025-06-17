-- Owhell Slap Troller GUI (Fake 100M Slaps + Orbit Badge Troll)
local StarterGui = game:GetService("StarterGui")

-- Rainbow Color Cycle
local function rainbowText(textLabel)
    local hue = 0
    task.spawn(function()
        while textLabel and textLabel.Parent do
            hue = (hue + 0.01) % 1
            textLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
            task.wait(0.05)
        end
    end)
end

-- GUI Setup
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "OwhellSlapGui"
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 160)
frame.Position = UDim2.new(0.5, -150, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Active = true
frame.Draggable = true

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.Text = "🌈 Owhell Glove Troller 🌈"
title.TextScaled = true
title.Font = Enum.Font.GothamBold
rainbowText(title)

-- Exit Button
local exit = Instance.new("TextButton", frame)
exit.Size = UDim2.new(0, 30, 0, 30)
exit.Position = UDim2.new(1, -30, 0, 0)
exit.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
exit.Text = "X"
exit.TextScaled = true
exit.Font = Enum.Font.SourceSansBold
exit.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Fake Slap Button
local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.8, 0, 0.4, 0)
button.Position = UDim2.new(0.1, 0, 0.5, 0)
button.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
button.Text = "Give 100M Slaps (Troll)"
button.TextScaled = true
button.Font = Enum.Font.GothamBold
button.TextColor3 = Color3.new(1, 1, 1)

button.MouseButton1Click:Connect(function()
    StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = "[SYSTEM] You gave yourself 100,000,000 slaps! (Troll 😂)",
        Color = Color3.fromRGB(255, 255, 0),
        Font = Enum.Font.SourceSansBold,
        FontSize = Enum.FontSize.Size24
    })
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("OrbitBadge")
    if remote then
        pcall(function()
            remote:FireServer()
        end)
    end
end)
