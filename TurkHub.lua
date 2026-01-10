--[[ 
    TURK HUB [FORCE SHOW UPDATE]
    Creator: TurkeyMajoJaMan0
--]]

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

-- 1. KILL EXISTING GUI (Prevents duplication glitches)
if CoreGui:FindFirstChild("TurkHub") then CoreGui.TurkHub:Destroy() end
if Players.LocalPlayer.PlayerGui:FindFirstChild("TurkHub") then Players.LocalPlayer.PlayerGui.TurkHub:Destroy() end

-- 2. CREATE THE GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TurkHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999 -- Forces it to the front

-- Try to parent to CoreGui first, then PlayerGui
local successParent, errParent = pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not successParent then
    ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
end

-- 3. THE MAIN FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 0) -- Green Border
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -75)
MainFrame.Size = UDim2.new(0, 250, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true -- Standard for most executors

-- 4. BUTTONS & TEXT
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Text = "TURK HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.TextSize = 18

local SearchBtn = Instance.new("TextButton")
SearchBtn.Parent = MainFrame
SearchBtn.Text = "Search Abandoned Server"
SearchBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
SearchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
SearchBtn.Size = UDim2.new(0.8, 0, 0, 45)

local Credits = Instance.new("TextLabel")
Credits.Parent = MainFrame
Credits.Text = "TurkeyMajoJaMan0"
Credits.TextColor3 = Color3.fromRGB(150, 150, 150)
Credits.Position = UDim2.new(0, 0, 0.85, 0)
Credits.Size = UDim2.new(1, 0, 0, 20)
Credits.BackgroundTransparency = 1
Credits.TextSize = 10

-- 5. THE UNIVERSAL LOGIC
SearchBtn.MouseButton1Click:Connect(function()
    SearchBtn.Text = "Finding 0 Players..."
    
    local url = "https://games.roproxy.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    
    local function GetRequest(target)
        if request then return request({Url = target, Method = "GET"}).Body end
        if http_request then return http_request({Url = target, Method = "GET"}).Body end
        return game:HttpGet(target)
    end

    local success, body = pcall(function() return GetRequest(url) end)
    
    if success and body then
        local data = HttpService:JSONDecode(body)
        for _, server in pairs(data.data) do
            -- Find the one with the least people (Abandoned)
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                SearchBtn.Text = "Abandoned Found! Joining..."
                TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, Players.LocalPlayer)
                return
            end
        end
    else
        SearchBtn.Text = "Error: Check Console (F9)"
        warn("Turk Hub Error: " .. tostring(body))
    end
    wait(2)
    SearchBtn.Text = "Search Abandoned Server"
end)

print("Turk Hub Loaded Successfully!")
