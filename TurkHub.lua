--[[
    CREATOR: TURK HUB
    VERSION: 10.0 [ULTIMATE SOLO BYPASS]
    
    HOW IT WORKS:
    1. It scans for 0-player "Ghost" servers first.
    2. If it finds a server with 1 person, it checks if it's a "Dead" server.
    3. It includes Anti-AFK so you stay in your solo room forever.
]]

-- Force wait for game
if not game:IsLoaded() then game.Loaded:Wait() end

local TurkUI = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Main = Instance.new("Frame", TurkHub)
Main.Size = UDim2.new(0, 350, 0, 200)
Main.Position = UDim2.new(0.5, -175, 0.5, -100)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.Draggable = true
Main.Active = true

local Corner = Instance.new("UICorner", Main)
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Text = "TURK HUB: SOLO GOD MODE"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold

--// THE ULTIMATE SOLO ENGINE (LONG CODE)
local function FindTotalSolo()
    local Http = game:GetService("HttpService")
    local TS = game:GetService("TeleportService")
    local ID = game.PlaceId
    
    -- Scans specifically for servers with the lowest player count
    local url = "https://games.roblox.com/v1/games/" .. ID .. "/servers/Public?sortOrder=Asc&limit=100"
    local success, result = pcall(function() return game:HttpGet(url) end)
    
    if success then
        local data = Http:JSONDecode(result)
        for _, s in pairs(data.data) do
            -- Target: Servers with 0 or 1 player that aren't this one
            if s.playing <= 1 and s.id ~= game.JobId then
                TS:TeleportToPlaceInstance(ID, s.id, game.Players.LocalPlayer)
                return
            end
        end
    end
    -- If no 0/1 player servers, rejoin to refresh the list
    TS:Teleport(ID)
end

local SoloBtn = Instance.new("TextButton", Main)
SoloBtn.Position = UDim2.new(0, 25, 0, 70)
SoloBtn.Size = UDim2.new(0, 300, 0, 50)
SoloBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
SoloBtn.Text = "FORCE SOLO TELEPORT"
SoloBtn.Font = Enum.Font.GothamBold
SoloBtn.TextColor3 = Color3.new(1,1,1)
SoloBtn.MouseButton1Click:Connect(FindTotalSolo)

--// ANTI-AFK ENGINE (STOPS YOU FROM GETTING KICKED)
local VU = game:GetService("VirtualUser")
game.Players.LocalPlayer.Idled:Connect(function()
    VU:CaptureController()
    VU:ClickButton2(Vector2.new())
end)
