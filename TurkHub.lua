--[[
    TURK HUB 🦃 
    Features: Speed Hack (Max 2000), Insta-Take (Auto-E)
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- UI REFERENCES (Ensure these names match your GUI objects)
local mainFrame = script.Parent:WaitForChild("MainFrame")
local titleLabel = mainFrame:WaitForChild("Title") -- Set text to "Turk Hub 🦃"
local speedInput = mainFrame:WaitForChild("SpeedInput")
local instaTakeBtn = mainFrame:WaitForChild("InstaTakeButton")

-- VARIABLES
local instaTakeEnabled = false
local maxSpeedLimit = 2000
local tInfo = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

-- INITIALIZE TITLE
titleLabel.Text = "Turk Hub 🦃"

--- 🏃 SPEED CONTROL ---
speedInput.FocusLost:Connect(function()
	local val = tonumber(speedInput.Text)
	if val then
		local clampedVal = math.clamp(val, 16, maxSpeedLimit)
		humanoid.WalkSpeed = clampedVal
		speedInput.Text = "Speed: "..tostring(clampedVal)
	else
		speedInput.Text = "Enter Number"
	end
end)

--- ⚡ INSTA-TAKE (AUTO-E) ---
instaTakeBtn.MouseButton1Click:Connect(function()
	instaTakeEnabled = not instaTakeEnabled
	
	-- Visual Toggle Animation
	if instaTakeEnabled then
		TweenService:Create(instaTakeBtn, tInfo, {BackgroundColor3 = Color3.fromRGB(0, 255, 127)}):Play()
		instaTakeBtn.Text = "Insta-Take: ON"
	else
		TweenService:Create(instaTakeBtn, tInfo, {BackgroundColor3 = Color3.fromRGB(255, 85, 85)}):Play()
		instaTakeBtn.Text = "Insta-Take: OFF"
	end
end)

-- Heartbeat loop for instant collection
RunService.Heartbeat:Connect(function()
	if instaTakeEnabled and character:FindFirstChild("HumanoidRootPart") then
		for _, descendant in pairs(workspace:GetDescendants()) do
			if descendant:IsA("ProximityPrompt") then
				-- Check distance
				local dist = (character.HumanoidRootPart.Position - descendant.Parent:GetPivot().Position).Magnitude
				if dist <= descendant.MaxActivationDistance then
					-- Instant Trigger
					descendant:InputHoldBegin()
					descendant:InputHoldEnd()
				end
			end
		end
	end
end)

-- Keep WalkSpeed consistent even if character resets
player.CharacterAdded:Connect(function(newChar)
	character = newChar
	humanoid = newChar:WaitForChild("Humanoid")
end)
