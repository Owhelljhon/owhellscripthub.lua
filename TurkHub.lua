--[[
    CREATOR: TURK HUB
    VERSION: 8.0 [RONIX SPECIAL]
    
    LOG:
    - Removed Manual Code Input
    - Added Auto-Ghost Scanner
    - Added Error-Bypass Logic
    - Long-form UI Framework
]]

-- Wait for game load
if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game.Players.LocalPlayer
local TS = game:GetService("TeleportService")
local Http = game:GetService("HttpService")

--// THE LONG UI FRAMEWORK (STAYS INSIDE SCRIPT)
local TurkUI = Instance.new("ScreenGui")
TurkUI.Name = "TurkHub_V8"
TurkUI.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = TurkUI
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, -150, 0.5, -80)
Main.Size = UDim2.new(0, 300, 0, 160)
Main.Draggable = true
Main.Active = true

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = Main

local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Text = "CREATOR: TURK HUB"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

--// NOTIFICATION LABEL
local Status = Instance.new("TextLabel")
Status.Parent = Main
Status.Position = UDim2.new(0, 0, 0, 40)
Status.Size = UDim2.new(1, 0, 0, 20)
Status.BackgroundTransparency = 1
Status.Text = "System Ready"
Status.TextColor3 = Color3.fromRGB(150, 150, 150)
Status.Font = Enum.Font.Gotham
Status.TextSize = 10

--// BUTTON CREATOR FUNCTION
local function NewButton(name, pos, color, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = Main
    btn.Name = name
    btn.Position = pos
    btn.Size = UDim2.new(0, 260, 0, 40)
    btn.BackgroundColor3 = color
    btn.Font = Enum.Font.GothamBold
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 14
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
end

--// THE ONLY BUTTONS YOU NEEDED
NewButton("Create Private Server", UDim2.new(0, 20, 0, 65), Color3.fromRGB(40, 80, 40), function()
    Status.Text = "Attempting to create server..."
    local success, code = pcall(function() return TS:ReserveServer(game.PlaceId) end)
    
    if success then
        Status.Text = "Success! Teleporting..."
        task.wait(1)
        TS:TeleportToPrivateServer(game.PlaceId, code, {Player})
    else
        Status.Text = "BLOCKED BY GAME! Use Join Button below."
        task.wait(2)
        Status.Text = "System Ready"
    end
end)

NewButton("Join Private Server", UDim2.new(0, 20, 0, 110), Color3.fromRGB(40, 40, 80), function()
    Status.Text = "Searching for 1-player server (Bypass)..."
    
    local function FindGhost()
        local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        local Success, Result = pcall(function() return game:HttpGet(Api) end)
        
        if Success then
            local Servers = Http:JSONDecode(Result)
            for _, s in pairs(Servers.data) do
                -- This ensures you join a server with ONLY 1 or 0 players
                if s.playing <= 1 and s.id ~= game.JobId then
                    TS:TeleportToPlaceInstance(game.PlaceId, s.id, Player)
                    return true
                end
            end
        end
        return false
    end
    
    if not FindGhost() then
        Status.Text = "No empty servers found. Retrying..."
        task.wait(1)
        TS:Teleport(game.PlaceId)
    end
end)
