-- OwhellScript Hub GUI by Owhelljhon

-- Character list
local piggyCharacters = {
    "Piggy", "Little Brother", "Mother", "Father", "Grandmother", "Sheepy", "Pandy", "Teacher", "Memory",
    "Kitty", "Mimi", "Dinopiggy", "Daisy", "Angel", "Pony", "Devil", "Doggy", "Giraffy", "Beary",
    "Foxy", "Elly", "Soldier", "Zompiggy", "Badgy", "Bunny", "Skelly", "Clowny", "Tigry", "Mousy",
    "Parasee", "Zizzy", "Ghosty", "Robby", "Bully", "Budgey", "Torcher", "Mr. P"
}

-- Helper function for rainbow color
local function rainbow()
    return Color3.fromHSV(tick() % 5 / 5, 1, 1)
end

-- GUI setup
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "OwhellScriptHub"
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 300, 0, 200)
main.Position = UDim2.new(0.5, -150, 0.5, -100)
main.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
main.Active = true
main.Draggable = true

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "🌈 OwhellScript Hub 🌈"
title.TextScaled = true
title.TextColor3 = Color3.new(1, 1, 1)
task.spawn(function()
    while true do
        title.TextColor3 = rainbow()
        wait(0.1)
    end
end)

-- Minimize/Exit
local close = Instance.new("TextButton", main)
close.Size = UDim2.new(0, 40, 0, 40)
close.Position = UDim2.new(1, -45, 0, 0)
close.Text = "X"
close.MouseButton1Click:Connect(function() gui:Destroy() end)

local minimize = Instance.new("TextButton", main)
minimize.Size = UDim2.new(0, 40, 0, 40)
minimize.Position = UDim2.new(1, -90, 0, 0)
minimize.Text = "_"
minimize.MouseButton1Click:Connect(function()
    main.Visible = false
    scriptBox.Visible = true
end)

-- Script reopen box
local scriptBox = Instance.new("TextButton", gui)
scriptBox.Size = UDim2.new(0, 100, 0, 40)
scriptBox.Position = UDim2.new(0.5, -50, 0, 10)
scriptBox.Text = "Script"
scriptBox.Visible = false
scriptBox.MouseButton1Click:Connect(function()
    main.Visible = true
    scriptBox.Visible = false
end)

-- Input
local nameBox = Instance.new("TextBox", main)
nameBox.Size = UDim2.new(0.8, 0, 0, 30)
nameBox.Position = UDim2.new(0.1, 0, 0.3, 0)
nameBox.PlaceholderText = "Enter Piggy Name or type 'tokens'"

-- Button
local spawnButton = Instance.new("TextButton", main)
spawnButton.Size = UDim2.new(0.6, 0, 0, 40)
spawnButton.Position = UDim2.new(0.2, 0, 0.55, 0)
spawnButton.Text = "Give Item"
spawnButton.MouseButton1Click:Connect(function()
    local text = nameBox.Text
    if text:lower() == "tokens" then
        local tokenRemote = game:GetService("ReplicatedStorage"):FindFirstChild("GivePiggyTokens")
        if tokenRemote then tokenRemote:FireServer(100) end
    else
        for _, char in pairs(piggyCharacters) do
            if string.lower(text) == string.lower(char) then
                local remote = game:GetService("ReplicatedStorage"):FindFirstChild("SpawnPiggy")
                if remote then remote:FireServer(char) end
                break
            end
        end
    end
end)
