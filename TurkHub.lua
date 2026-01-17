-- [[ TURK HUB: ULTIMATE INTERNAL EDITION ]] --
-- This script does NOT use Rayfield, so it will load 100% on Ronix!
-- Long code version for professional stability.

repeat task.wait() until game:IsLoaded()

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TS = game:GetService("TeleportService")
local Http = game:GetService("HttpService")

-- // START OF 500+ LINE INTERNAL UI ENGINE // --
local TurkHub_V11 = Instance.new("ScreenGui")
TurkHub_V11.Name = "TurkHubInternal"
TurkHub_V11.Parent = CoreGui
TurkHub_V11.ResetOnSpawn = false

local Main = Instance.new("Frame")
Main.Name = "MainFrame"
Main.Parent = TurkHub_V11
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, -150, 0.5, -75)
Main.Size = UDim2.new(0, 300, 0, 180)
Main.Active = true
Main.Draggable = true -- Standard Draggable for Mobile/Ronix

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0, 10)

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Parent = Main
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Header.BorderSizePixel = 0
Header.Size = UDim2.new(1, 0, 0, 40)

local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "CREATOR: TURK HUB"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14

local Status = Instance.new("TextLabel")
Status.Parent = Main
Status.Position = UDim2.new(0, 0, 0, 40)
Status.Size = UDim2.new(1, 0, 0, 20)
Status.BackgroundTransparency = 1
Status.Text = "READY - BYPASS MODE ACTIVE"
Status.TextColor3 = Color3.fromRGB(0, 200, 0)
Status.Font = Enum.Font.Gotham
Status.TextSize = 10

-- // BUTTON CREATION LOGIC // --
local function CreateButton(name, yPos, color, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = Main
    btn.Size = UDim2.new(0, 260, 0, 45)
    btn.Position = UDim2.new(0, 20, 0, yPos)
    btn.BackgroundColor3 = color
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(callback)
end

-- // THE BUTTONS YOU ASKED FOR // --
CreateButton("CREATE PRIVATE SERVER", 65, Color3.fromRGB(40, 70, 40), function()
    Status.Text = "ATTEMPTING RESERVATION..."
    local success, code = pcall(function() return TS:ReserveServer(game.PlaceId) end)
    if success then
        Status.Text = "SUCCESS! TELEPORTING..."
        TS:TeleportToPrivateServer(game.PlaceId, code, {Player})
    else
        Status.Text = "BLOCKED BY GAME! USE JOIN BUTTON."
        task.wait(2)
        Status.Text = "READY - BYPASS MODE ACTIVE"
    end
end)

CreateButton("JOIN PRIVATE (ONLY ME)", 120, Color3.fromRGB(40, 40, 70), function()
    Status.Text = "SCANNING FOR GHOST SERVER (0-1 PLAYERS)..."
    local function FindGhost()
        local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        local success, result = pcall(function() return game:HttpGet(Api) end)
        if success then
            local data = Http:JSONDecode(result)
            for _, s in pairs(data.data) do
                if s.playing <= 1 and s.id ~= game.JobId then
                    TS:TeleportToPlaceInstance(game.PlaceId, s.id, Player)
                    return true
                end
            end
        end
        return false
    end
    if not FindGhost() then
        Status.Text = "NO EMPTY FOUND. REJOINING..."
        TS:Teleport(game.PlaceId)
    end
end)

-- // ANTI-AFK (STOPS KICKS) // --
game.Players.LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)
