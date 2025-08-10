-- GUI Script: Leave & Reset Buttons (Draggable)
-- Made by Owhelljhon

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

-- Main Frame (Draggable)
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 220, 0, 80)
MainFrame.Position = UDim2.new(0.4, 0, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.Active = true
MainFrame.Draggable = true

-- Leave Button
local LeaveButton = Instance.new("TextButton")
LeaveButton.Parent = MainFrame
LeaveButton.Text = "Leave"
LeaveButton.Size = UDim2.new(0, 100, 0, 50)
LeaveButton.Position = UDim2.new(0, 10, 0, 15)
LeaveButton.BackgroundColor3 = Color3.fromRGB(128, 128, 128)
LeaveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LeaveButton.Font = Enum.Font.SourceSansBold
LeaveButton.TextSize = 20

-- Reset Button
local ResetButton = Instance.new("TextButton")
ResetButton.Parent = MainFrame
ResetButton.Text = "Reset"
ResetButton.Size = UDim2.new(0, 100, 0, 50)
ResetButton.Position = UDim2.new(0, 120, 0, 15)
ResetButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ResetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetButton.Font = Enum.Font.SourceSansBold
ResetButton.TextSize = 20

-- Leave Function
LeaveButton.MouseButton1Click:Connect(function()
    game.Players.LocalPlayer:Kick("You left the game.")
end)

-- Reset Function
ResetButton.MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character:BreakJoints()
end)
