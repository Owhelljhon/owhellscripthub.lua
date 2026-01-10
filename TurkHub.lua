--[[ 
    TURK HUB [UNIVERSAL v3]
    - Works on all Executors (Punk X, Wave, etc.)
    - Finds the absolute lowest player count (Abandoned)
    - Creator: TurkeyMajoJaMan0
--]]

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

-- GUI Design
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SearchBtn = Instance.new("TextButton")
local Credits = Instance.new("TextLabel")

-- Set Parent to CoreGui (to stay visible through teleports)
ScreenGui.Parent = (game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:PlayerGui)
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Size = UDim2.new(0, 260, 0, 150)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -75)
MainFrame.Active = true
MainFrame.Draggable = true -- Draggable for all games

Title.Parent = MainFrame
Title.Text = "TURK HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1

SearchBtn.Parent = MainFrame
SearchBtn.Text = "Search Abandoned Server"
SearchBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
SearchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBtn.Position = UDim2.new(0.1, 0, 0.35, 0)
SearchBtn.Size = UDim2.new(0.8, 0, 0, 50)

Credits.Parent = MainFrame
Credits.Text = "Creator: TurkeyMajoJaMan0"
Credits.TextColor3 = Color3.fromRGB(120, 120, 120)
Credits.Position = UDim2.new(0, 10, 0.85, 0)
Credits.Size = UDim2.new(1, 0, 0, 20)
Credits.BackgroundTransparency = 1

-- UNIVERSAL SEARCH LOGIC
SearchBtn.MouseButton1Click:Connect(function()
    SearchBtn.Text = "Searching Millions..."
    
    local PlaceId = game.PlaceId
    -- We use a proxy because Roblox blocks direct API calls from inside the game
    local url = "https://games.roproxy.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    
    local function GetRequest(targetUrl)
        -- Try all known executor methods
        local success, result
        if request then
            success, result = pcall(function() return request({Url = targetUrl, Method = "GET"}).Body end)
        elseif http_request then
            success, result = pcall(function() return http_request({Url = targetUrl, Method = "GET"}).Body end)
        else
            success, result = pcall(function() return game:HttpGet(targetUrl) end)
        end
        return success and result or nil
    end

    local response = GetRequest(url)
    
    if response then
        local decoded = HttpService:JSONDecode(response)
        local targetServer = nil
        
        -- Loop to find the server with the absolute lowest players
        for _, server in pairs(decoded.data) do
            -- Look for 0 or 1 player servers
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                targetServer = server.id
                break
            end
        end
        
        if targetServer then
            SearchBtn.Text = "Found! Teleporting..."
            TeleportService:TeleportToPlaceInstance(PlaceId, targetServer, game.Players.LocalPlayer)
        else
            SearchBtn.Text = "No Empty Servers! Try again."
        end
    else
        SearchBtn.Text = "Request Failed - Try Again"
    end
    
    wait(3)
    SearchBtn.Text = "Search Abandoned Server"
end)
