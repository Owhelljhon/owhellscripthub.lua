local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- UI REFERENCES
local screenGui = script.Parent
local mainFrame = screenGui:WaitForChild("MainFrame")
local speedInput = mainFrame:WaitForChild("SpeedInput")
local instaTakeBtn = mainFrame:WaitForChild("InstaTakeButton")

-- 1. CREATE MOBILE TOGGLE BUTTON
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "TurkHubToggle"
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 60, 0, 60)
toggleButton.Position = UDim2.new(0, 10, 0.5, -30) -- Left side of screen
toggleButton.BackgroundColor3 = Color3.fromHex("#1A1A1A")
toggleButton.Text = "🦃"
toggleButton.TextSize = 30
toggleButton.ZIndex = 10

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = toggleButton

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.new(0, 0, 0)
stroke.Parent = toggleButton

-- TOGGLE LOGIC (Tapping the Turkey opens the menu)
toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- 2. APPLY DARK THEME
mainFrame.BackgroundColor3 = Color3.fromHex("#121212") -- Darker
mainFrame.Visible = false -- Start hidden

--- 🏃 MOBILE SPEED LOGIC ---
speedInput.FocusLost:Connect(function()
	local val = tonumber(speedInput.Text)
	if val then
		local clamped = math.clamp(val, 16, 2000)
		humanoid.WalkSpeed = clamped
		speedInput.Text = "SPEED: " .. tostring(clamped)
	else
		speedInput.Text = "TAP TO SET SPEED"
	end
end)

--- ⚡ MOBILE INSTA-TAKE ---
local instaTakeEnabled = false
instaTakeBtn.MouseButton1Click:Connect(function()
	instaTakeEnabled = not instaTakeEnabled
	
	if instaTakeEnabled then
		instaTakeBtn.BackgroundColor3 = Color3.fromHex("#333333")
		instaTakeBtn.Text = "INSTA-TAKE: ON"
		instaTakeBtn.TextColor3 = Color3.fromRGB(0, 255, 0)
	else
		instaTakeBtn.BackgroundColor3 = Color3.fromHex("#1A1A1A")
		instaTakeBtn.Text = "INSTA-TAKE: OFF"
		instaTakeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	end
end)

--- 🤏 AUTO-COLLECT (Works on Mobile) ---
RunService.Heartbeat:Connect(function()
	if instaTakeEnabled and character:FindFirstChild("HumanoidRootPart") then
		for _, v in pairs(workspace:GetDescendants()) do
			if v:IsA("ProximityPrompt") then
				local dist = (character.HumanoidRootPart.Position - v.Parent:GetPivot().Position).Magnitude
				if dist <= v.MaxActivationDistance then
					-- This triggers the "E" button for you
					fireproximityprompt(v) 
				end
			end
		end
	end
end)
