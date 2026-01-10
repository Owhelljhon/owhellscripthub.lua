-- Turk Hub (Optimized Version)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CreateBtn = Instance.new("TextButton")
local AntiKickBtn = Instance.new("TextButton")
local Credits = Instance.new("TextLabel")

-- Setup GUI
ScreenGui.Parent = game.CoreGui -- Use CoreGui to stay visible through teleports
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.4, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 200)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Text = "TURK HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1

CreateBtn.Parent = MainFrame
CreateBtn.Text = "Search Empty Servers"
CreateBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
CreateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CreateBtn.Position = UDim2.new(0.1, 0, 0.25, 0)
CreateBtn.Size = UDim2.new(0.8, 0, 0, 45)

AntiKickBtn.Parent = MainFrame
AntiKickBtn.Text = "Anti-Kick: OFF"
AntiKickBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
AntiKickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiKickBtn.Position = UDim2.new(0.1, 0, 0.55, 0)
AntiKickBtn.Size = UDim2.new(0.8, 0, 0, 45)

Credits.Parent = MainFrame
Credits.Text = "Creator: TurkeyMajoJaMan0"
Credits.TextColor3 = Color3.fromRGB(180, 180, 180)
Credits.TextSize = 12
Credits.Position = UDim2.new(0.05, 0, 0.88, 0)
Credits.Size = UDim2.new(0.9, 0, 0, 20)
Credits.BackgroundTransparency = 1

-- Logic to prevent glitches
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

CreateBtn.MouseButton1Click:Connect(function()
    CreateBtn.Text = "Searching..."
    CreateBtn.AutoButtonColor = false
    
    local PlaceId = game.PlaceId
    local servers = {}
    
    -- Using the Roblox API to sort by player count (Ascending)
    local url = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    
    local success, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(url))
    end)
    
    if success and result and result.data then
        for _, server in pairs(result.data) do
            -- Find a server that isn't the one we are currently in
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                table.insert(servers, server.id)
            end
        end
        
        if #servers > 0 then
            CreateBtn.Text = "Server Found! Joining..."
            TeleportService:TeleportToPlaceInstance(PlaceId, servers[1], game.Players.LocalPlayer)
        else
            CreateBtn.Text = "No Empty Servers Found"
            wait(2)
            CreateBtn.Text = "Search Empty Servers"
        end
    else
        CreateBtn.Text = "Error: Use an Executor"
        wait(2)
        CreateBtn.Text = "Search Empty Servers"
    end
end)
