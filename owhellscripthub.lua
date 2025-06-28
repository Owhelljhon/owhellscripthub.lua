-- Fake 1000X Luck GUI by Owhelljhon
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "FakeLuckGUI"
gui.ResetOnSpawn = false

-- Draggable Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Rainbow Text Function
local function rainbowText(label)
	local hue = 0
	while true do
		hue = (hue + 1) % 360
		label.TextColor3 = Color3.fromHSV(hue/360, 1, 1)
		wait(0.03)
	end
end

-- Rainbow Name
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🌈 Owhelljhon's GUI 🌈"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.new(1, 0, 0)
spawn(function() rainbowText(title) end)

-- Luck Label
local luckLabel = Instance.new("TextLabel", frame)
luckLabel.Size = UDim2.new(1, 0, 0, 30)
luckLabel.Position = UDim2.new(0, 0, 0.35, 0)
luckLabel.BackgroundTransparency = 1
luckLabel.Text = "💯 1000X Luck"
luckLabel.Font = Enum.Font.Gotham
luckLabel.TextSize = 18
luckLabel.TextColor3 = Color3.fromRGB(0, 255, 0)

-- On Button
local onBtn = Instance.new("TextButton", frame)
onBtn.Size = UDim2.new(0, 120, 0, 30)
onBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
onBtn.Text = "ON 🔥"
onBtn.Font = Enum.Font.GothamBold
onBtn.TextSize = 18
onBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
onBtn.TextColor3 = Color3.new(1,1,1)

-- Off Button
local offBtn = Instance.new("TextButton", frame)
offBtn.Size = UDim2.new(0, 120, 0, 30)
offBtn.Position = UDim2.new(0.55, 0, 0.7, 0)
offBtn.Text = "OFF ❌"
offBtn.Font = Enum.Font.GothamBold
offBtn.TextSize = 18
offBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
offBtn.TextColor3 = Color3.new(1,1,1)

-- Button Binds (They do nothing! Just for troll!)
onBtn.MouseButton1Click:Connect(function()
	luckLabel.Text = "💯 1000X Luck - ENABLED ✅"
end)

offBtn.MouseButton1Click:Connect(function()
	luckLabel.Text = "💯 1000X Luck - DISABLED ❌"
end)
