-- Don't Wake The Brainrot — Speed GUI (Executor-ready)
-- Author: assistant (for Owhelljhon)
-- Paste into your executor as a single script.

local TOP_NAME = "Owhelljhon"       -- change if you want a different name
local DEFAULT_WALKSPEED = 16        -- normal Roblox walk speed
local MAX_SPEED = 100

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = (LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")) or nil

-- Try CoreGui if PlayerGui is nil (some executors / contexts)
local guiParent = PlayerGui or game:GetService("CoreGui")

-- simple helper
local function new(name, props)
	local obj = Instance.new(name)
	if props then
		for k,v in pairs(props) do obj[k] = v end
	end
	return obj
end

-- Create GUI
local screenGui = new("ScreenGui", {Name = "OwhellSpeedGui", ResetOnSpawn = false, Parent = guiParent})
local mainFrame = new("Frame", {
	Name = "MainFrame",
	Size = UDim2.new(0, 320, 0, 180),
	Position = UDim2.new(0.5, -160, 0.3, -90),
	AnchorPoint = Vector2.new(0.5,0.5),
	BackgroundColor3 = Color3.fromRGB(20,20,20),
	BorderSizePixel = 0,
	Parent = screenGui
})
mainFrame.Visible = true
mainFrame.Active = true
mainFrame.Draggable = false -- we'll implement custom drag

-- rounded look (UIStroke + Corner)
local corner = new("UICorner", {CornerRadius = UDim.new(0,10), Parent = mainFrame})
local stroke = new("UIStroke", {Thickness = 1, Parent = mainFrame})

-- Top bar with name (rainbow text)
local topBar = new("Frame", {
	Name = "TopBar",
	Size = UDim2.new(1,0,0,40),
	Position = UDim2.new(0,0,0,0),
	BackgroundColor3 = Color3.fromRGB(30,30,30),
	BorderSizePixel = 0,
	Parent = mainFrame
})
new("UICorner", {CornerRadius = UDim.new(0,8), Parent = topBar})

local nameLabel = new("TextLabel", {
	Name = "NameLabel",
	Size = UDim2.new(1,0,1,0),
	BackgroundTransparency = 1,
	Font = Enum.Font.GothamBold,
	TextSize = 20,
	Text = TOP_NAME,
	TextStrokeTransparency = 0.8,
	Parent = topBar
})
nameLabel.TextColor3 = Color3.fromRGB(255,0,0)

-- Speed label + textbox
local labelSpeed = new("TextLabel", {
	Name = "LabelSpeed",
	Size = UDim2.new(0.5, -10, 0, 28),
	Position = UDim2.new(0,10,0,50),
	BackgroundTransparency = 1,
	Font = Enum.Font.GothamMedium,
	TextSize = 14,
	Text = "Speed (0-"..tostring(MAX_SPEED)..")",
	TextColor3 = Color3.fromRGB(220,220,220),
	Parent = mainFrame
})

local speedBox = new("TextBox", {
	Name = "SpeedBox",
	Size = UDim2.new(0.45, -10, 0, 28),
	Position = UDim2.new(0.5, 0, 0, 50),
	PlaceholderText = "Type number",
	ClearTextOnFocus = false,
	Font = Enum.Font.Gotham,
	TextSize = 16,
	Text = tostring(DEFAULT_WALKSPEED),
	BackgroundColor3 = Color3.fromRGB(40,40,40),
	BorderSizePixel = 0,
	TextColor3 = Color3.fromRGB(255,255,255),
	Parent = mainFrame
})
new("UICorner", {CornerRadius = UDim.new(0,6), Parent = speedBox})

-- Speed toggle button
local speedBtn = new("TextButton", {
	Name = "SpeedButton",
	Size = UDim2.new(0.46, 0, 0, 32),
	Position = UDim2.new(0.02, 0, 0, 90),
	Font = Enum.Font.GothamBold,
	TextSize = 16,
	Text = "Speed: Off",
	BackgroundColor3 = Color3.fromRGB(60,60,60),
	BorderSizePixel = 0,
	TextColor3 = Color3.fromRGB(255,255,255),
	Parent = mainFrame
})
new("UICorner", {CornerRadius = UDim.new(0,6), Parent = speedBtn})

-- Speed Bypass toggle
local bypassBtn = new("TextButton", {
	Name = "BypassButton",
	Size = UDim2.new(0.46, 0, 0, 32),
	Position = UDim2.new(0.52, 0, 0, 90),
	Font = Enum.Font.GothamBold,
	TextSize = 16,
	Text = "Speed Bypass: Off",
	BackgroundColor3 = Color3.fromRGB(60,60,60),
	BorderSizePixel = 0,
	TextColor3 = Color3.fromRGB(255,255,255),
	Parent = mainFrame
})
new("UICorner", {CornerRadius = UDim.new(0,6), Parent = bypassBtn})

-- small instructions
local hint = new("TextLabel", {
	Name = "Hint",
	Size = UDim2.new(1, -20, 0, 36),
	Position = UDim2.new(0,10,1,-46),
	BackgroundTransparency = 1,
	Font = Enum.Font.Gotham,
	TextSize = 12,
	Text = "Type a number then press Speed. If teleport-back occurs, enable Speed Bypass.",
	TextColor3 = Color3.fromRGB(180,180,180),
	TextWrapped = true,
	Parent = mainFrame
})

-- drag logic (custom)
do
	local dragging, dragInput, dragStart, startPos
	local function update(input)
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	mainFrame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = mainFrame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	mainFrame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

-- rainbow effect for name label
local hue = 0
local nameConn
nameConn = RunService.RenderStepped:Connect(function(dt)
	hue = (hue + dt * 0.18) % 1 -- speed of rainbow cycle
	nameLabel.TextColor3 = Color3.fromHSV(hue, 0.9, 1)
end)

-- core speed logic
local speedEnabled = false
local bypassEnabled = false
local requestedSpeed = DEFAULT_WALKSPEED

local function getCharacter()
	if not LocalPlayer then return nil end
	return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function getHumanoid()
	local char = getCharacter()
	if not char then return nil end
	return char:FindFirstChildOfClass("Humanoid")
end

local function getRootPart()
	local char = getCharacter()
	if not char then return nil end
	return char:FindFirstChild("HumanoidRootPart")
end

-- clamp helper
local function clampSpeed(n)
	n = tonumber(n) or 0
	if n < 0 then n = 0 end
	if n > MAX_SPEED then n = MAX_SPEED end
	return math.floor(n)
end

-- apply walk speed safely
local function applyWalkSpeed(v)
	local humanoid = getHumanoid()
	if humanoid then
		pcall(function() humanoid.WalkSpeed = v end)
	end
end

-- Speed Button behaviour
speedBtn.MouseButton1Click:Connect(function()
	local val = clampSpeed(speedBox.Text)
	requestedSpeed = val
	speedBox.Text = tostring(requestedSpeed)
	speedEnabled = not speedEnabled
	if speedEnabled then
		speedBtn.Text = "Speed: On"
		-- apply immediately
		applyWalkSpeed(requestedSpeed)
	else
		speedBtn.Text = "Speed: Off"
		applyWalkSpeed(DEFAULT_WALKSPEED)
	end
end)

-- TextBox change clamps value live
speedBox.FocusLost:Connect(function(enterPressed)
	local val = clampSpeed(speedBox.Text)
	requestedSpeed = val
	speedBox.Text = tostring(requestedSpeed)
	if speedEnabled then
		applyWalkSpeed(requestedSpeed)
	end
end)

-- Bypass toggle
bypassBtn.MouseButton1Click:Connect(function()
	bypassEnabled = not bypassEnabled
	if bypassEnabled then
		bypassBtn.Text = "Speed Bypass: On"
	else
		bypassBtn.Text = "Speed Bypass: Off"
	end
end)

-- Bypass implementation:
-- While bypass is enabled, we:
-- 1) keep setting humanoid.WalkSpeed to requestedSpeed each frame
-- 2) nudge HumanoidRootPart.Velocity along the current move direction when moving to help prevent server-side teleport-back
-- Note: this is a mitigation attempt and may not work against strong server anti-cheat. Use responsibly.
local bypassConn
bypassConn = RunService.Stepped:Connect(function(_, dt)
	-- Always keep name color cycling
	-- enforce speed if enabled
	if speedEnabled then
		applyWalkSpeed(requestedSpeed)
	end

	if bypassEnabled and speedEnabled then
		local char = getCharacter()
		local humanoid = char and char:FindFirstChildOfClass("Humanoid")
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		if humanoid and hrp then
			-- small safe velocity nudge only when moving:
			local moveDir = humanoid.MoveDirection
			local speed = requestedSpeed
			-- when the moveDirection magnitude is significant, nudge velocity a bit
			if moveDir.Magnitude > 0.02 and speed > 0 then
				-- convert speed to studs/sec; add small vertical preserve
				local desiredVel = moveDir.Unit * (math.max(0.1, speed))
				-- apply using velocity but keep Y component small (don't fly)
				local currentVel = hrp.Velocity
				local newVel = Vector3.new(desiredVel.X, math.clamp(currentVel.Y, -50, 50), desiredVel.Z)
				-- pcall to avoid runtime errors on some exploits
				pcall(function()
					hrp.Velocity = newVel
				end)
			end
			-- also reapply WalkSpeed to be persistent
			pcall(function() humanoid.WalkSpeed = speed end)
		end
	end

	-- when bypass is off and speed disabled we ensure default
	if (not speedEnabled) and (not bypassEnabled) then
		applyWalkSpeed(DEFAULT_WALKSPEED)
	end
end)

-- Clean up on character respawn: reapply settings
if LocalPlayer then
	LocalPlayer.CharacterAdded:Connect(function()
		wait(0.5)
		if speedEnabled then applyWalkSpeed(requestedSpeed) end
	end)
end

-- small close button (optional)
local closeBtn = new("TextButton", {
	Name = "CloseBtn",
	Size = UDim2.new(0,24,0,24),
	Position = UDim2.new(1,-28,0,6),
	BackgroundColor3 = Color3.fromRGB(120,40,40),
	Text = "X",
	Font = Enum.Font.GothamBold,
	TextSize = 14,
	BorderSizePixel = 0,
	Parent = mainFrame
})
new("UICorner", {CornerRadius = UDim.new(0,6), Parent = closeBtn})
closeBtn.MouseButton1Click:Connect(function()
	pcall(function()
		nameConn:Disconnect()
		bypassConn:Disconnect()
	end)
	screenGui:Destroy()
end)

-- final note printed to console
print("[Owhell] Speed GUI loaded. Use the textbox (0-"..MAX_SPEED..") and press Speed. Enable Bypass if you get teleported back.")
