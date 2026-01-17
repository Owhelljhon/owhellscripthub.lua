-- [[ TURK HUB: ULTIMATE INTERNAL EDITION ]] --
-- FEATURES: DRAGGABLE, DARK THEME, BYPASS LOCKS, UNIVERSAL
-- DESIGNED FOR: RONIX EXECUTOR

repeat task.wait() until game:IsLoaded()

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TS = game:GetService("TeleportService")
local Http = game:GetService("HttpService")

-- // INTERNAL UI ENGINE (THIS MAKES IT SHOW UP INSTANTLY) // --
local TurkHub_V12 = Instance.new("ScreenGui")
TurkHub_V11.Name = "TurkHubInternal"
TurkHub_V11.Parent = CoreGui
TurkHub_V11.ResetOnSpawn = false

local Main = Instance.new("Frame")
Main.Name = "MainFrame"
Main.Parent = TurkHub_V12
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, -150, 0.5, -90)
Main.Size = UDim2.new(0, 300, 0, 180)
Main.Active = true
Main.Draggable = true 

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0, 10)

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Parent = Main
Header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Header.BorderSizePixel = 0
Header.Size = UDim2.new(1, 0, 0, 45)

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
Status.Position = UDim2.new(0, 0, 0, 45)
Status.Size = UDim2.new(1, 0, 0, 20)
Status.BackgroundTransparency = 1
Status.Text = "UNIVERSAL SYSTEM: READY"
Status.TextColor3 = Color3.fromRGB(0, 255, 150)
Status.Font = Enum.Font.Gotham
Status.TextSize = 10

-- // BUTTON CONSTRUCTOR // --
local function CreateButton(name, yPos, color, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = Main
    btn.Size = UDim2.new(0, 260, 0, 42)
    btn.Position = UDim2.new(0, 20, 0, yPos)
    btn.BackgroundColor3 = color
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(callback)
end

-- // CORE LOGIC // --
CreateButton("CREATE PRIVATE SERVER", 75, Color3.fromRGB(35, 75, 35), function()
    Status.Text = "STATUS: REQUESTING RESERVATION..."
    local success, code = pcall(function() return TS:ReserveServer(game.PlaceId) end)
    if success then
        Status.Text = "SUCCESS! TELEPORTING..."
        TS:TeleportToPrivateServer(game.PlaceId, code, {Player})
    else
        Status.Text = "ERROR: RESERVED SERVERS BLOCKED."
        task.wait(2)
        Status.Text = "USE 'JOIN' TO BYPASS GAME LOCKS"
    end
end)

CreateButton("JOIN PRIVATE (1 PLAYER SOLO)", 125, Color3.fromRGB(35, 35, 75), function()
    Status.Text = "STATUS: GHOST SCANNING (0-1 PLAYERS)..."
    local function FindGhost()
        local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        local success, result = pcall(function() return game:HttpGet(Api) end)
        if success then
            local data = Http:JSONDecode(result)
            for _, s in pairs(data.data) do
                -- Target: Servers with 0 or 1 player that aren't this current one
                if s.playing <= 1 and s.id ~= game.JobId then
                    TS:TeleportToPlaceInstance(game.PlaceId, s.id, Player)
                    return true
                end
            end
        end
        return false
    end
    if not FindGhost() then
        Status.Text = "NO DEAD SERVERS FOUND. TRYING SMALLEST..."
        TS:Teleport(game.PlaceId)
    end
end)

-- // ANTI-AFK // --
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)
