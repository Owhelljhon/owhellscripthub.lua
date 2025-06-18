-- Owhelljhon Fake Fruit Spawner GUI 🌈

local fruits = {"Kitsune", "Dragon", "Light", "Dough"}
local player = game.Players.LocalPlayer

-- Rainbow function
local function rainbowify(textLabel)
	local h = 0
	coroutine.wrap(function()
		while true do
			h = (h + 1) % 255
			textLabel.TextColor3 = Color3.fromHSV(h/255, 1, 1)
			wait(0.03)
		end
	end)()
end

-- Main GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 250)
frame.Position = UDim2.new(0.5, -150, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Owhelljhon Fruit Spawner 🌈"
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextScaled = true
rainbowify(title)

local input = Instance.new("TextBox", frame)
input.Size = UDim2.new(0.8, 0, 0, 40)
input.Position = UDim2.new(0.1, 0, 0, 50)
input.PlaceholderText = "Type: Kitsune, Dragon, Light, Dough"
input.TextScaled = true

local spawnBtn = Instance.new("TextButton", frame)
spawnBtn.Size = UDim2.new(0.4, 0, 0, 40)
spawnBtn.Position = UDim2.new(0.3, 0, 0, 100)
spawnBtn.Text = "Spawn Fruit"
spawnBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 75)
spawnBtn.TextScaled = true

-- Fake Inventory
local fruitInv = {}

-- Fruit GUI
local function openFruitGUI(fruitName)
	local popup = Instance.new("Frame", gui)
	popup.Size = UDim2.new(0, 220, 0, 180)
	popup.Position = UDim2.new(0.5, -110, 0.5, -90)
	popup.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	popup.Active = true
	popup.Draggable = true

	local lbl = Instance.new("TextLabel", popup)
	lbl.Size = UDim2.new(1, 0, 0, 40)
	lbl.Text = "You got a " .. fruitName .. " 🍉"
	lbl.BackgroundTransparency = 1
	lbl.TextScaled = true

	local function makeButton(text, yPos)
		local btn = Instance.new("TextButton", popup)
		btn.Size = UDim2.new(0.8, 0, 0, 30)
		btn.Position = UDim2.new(0.1, 0, yPos, 0)
		btn.Text = text
		btn.BackgroundColor3 = Color3.fromRGB(80, 80, 255)
		btn.TextScaled = true
		btn.MouseButton1Click:Connect(function()
			if text == "Eat" then
				lbl.Text = "You ate the " .. fruitName
			elseif text == "Store" then
				lbl.Text = fruitName .. " stored!"
			elseif text == "Drop" then
				lbl.Text = "You dropped the " .. fruitName
			elseif text == "Nevermind" then
				popup:Destroy()
			end
		end)
	end

	makeButton("Eat", 0.3)
	makeButton("Store", 0.5)
	makeButton("Drop", 0.7)
	makeButton("Nevermind", 0.9)
end

-- Spawn logic
spawnBtn.MouseButton1Click:Connect(function()
	local name = input.Text:lower()
	for _, v in pairs(fruits) do
		if v:lower() == name then
			table.insert(fruitInv, v)
			openFruitGUI(v)
			break
		end
	end
end)
