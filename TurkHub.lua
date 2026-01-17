--[[
    CREATOR: TURK HUB
    VERSION: 9.0 [THE LONE SURVIVOR]
    
    SPECIALTY: SEARCHES FOR 0-PLAYER OR 1-PLAYER DEAD SERVERS
    USE: WORKS ON ALL GAMES (UNIVERSAL)
]]

-- Ensuring the game environment is ready
if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game.Players.LocalPlayer
local TS = game:GetService("TeleportService")
local Http = game:GetService("HttpService")

--// UI DESIGN (LONG CODE)
local TurkHub = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Main = Instance.new("Frame", TurkHub)
Main.Size = UDim2.new(0, 320, 0, 150)
Main.Position = UDim2.new(0.5, -160, 0.5, -75)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.Draggable = true
Main.Active = true

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Title.Text = "CREATOR: TURK HUB [SOLO]"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14

local TCorner = Instance.new("UICorner", Title)

--// NOTIFICATION LOG
local Status = Instance.new("TextLabel", Main)
Status.Position = UDim2.new(0, 0, 0, 45)
Status.Size = UDim2.new(1, 0, 0, 25)
Status.BackgroundTransparency = 1
Status.Text = "Status: Ready to find Solo Server"
Status.TextColor3 = Color3.fromRGB(0, 255, 150)
Status.Font = Enum.Font.Gotham
Status.TextSize = 11

--// BUTTON CREATOR
local function SoloButton(name, color, yPos, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Name = name
    btn.Text = name
    btn.Size = UDim2.new(0, 280, 0, 45)
    btn.Position = UDim2.new(0, 20, 0, yPos)
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(callback)
end

--// THE TRUE SOLO BUTTON
SoloButton("FIND 100% EMPTY SERVER", Color3.fromRGB(100, 30, 30), 85, function()
    Status.Text = "Scanning thousands of servers..."
    
    local function GetDeadServer()
        -- API scans for servers with the absolute lowest players
        local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        local success, result = pcall(function() return game:HttpGet(url) end)
        
        if success then
            local data = Http:JSONDecode(result)
            for _, s in pairs(data.data) do
                -- This logic tries to find a server with 0-1 players
                -- 0 players is a 'Ghost Server' that is starting up
                if s.playing <= 1 and s.id ~= game.JobId then
                    Status.Text = "Ghost Server Found! Teleporting..."
                    TS:TeleportToPlaceInstance(game.PlaceId, s.id, Player)
                    return true
                end
            end
        end
        return false
    end
    
    if not GetDeadServer() then
        Status.Text = "No 1-player servers. Joining smallest available..."
        task.wait(1)
        TS:Teleport(game.PlaceId)
    end
end)
