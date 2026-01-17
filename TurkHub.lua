--[[
    CREATOR: TURK HUB
    VERSION: 7.0 [RONIX OPTIMIZED]
    UNIVERSAL PRIVATE SERVER BYPASS
]]

-- Wait for game to load
if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TS = game:GetService("TeleportService")
local Http = game:GetService("HttpService")

--// UI CONSTRUCTION (LONG CODE - NO EXTERNAL LINKS)
local TurkHubGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Container = Instance.new("Frame")
local UIList = Instance.new("UIListLayout")

TurkHubGui.Name = "TurkHub_Ronix"
TurkHubGui.Parent = CoreGui
TurkHubGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = TurkHubGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true -- Built-in draggable for Ronix

TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleBar.Size = UDim2.new(1, 0, 0, 40)

Title.Parent = TitleBar
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Text = "CREATOR: TURK HUB"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

Container.Parent = MainFrame
Container.Position = UDim2.new(0, 10, 0, 50)
Container.Size = UDim2.new(1, -20, 1, -60)
Container.BackgroundTransparency = 1

UIList.Parent = Container
UIList.Padding = UDim.new(0, 8)

--// FUNCTION: CREATE BUTTON
local function CreateButton(text, color, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = Container
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
end

--// BUTTON 1: CREATE PRIVATE SERVER
CreateButton("Create Private Server", Color3.fromRGB(45, 100, 45), function()
    local success, result = pcall(function()
        return TS:ReserveServer(game.PlaceId)
    end)
    
    if success then
        _G.MyServerCode = result
        setclipboard(result)
        print("Turk Hub: Code Copied - " .. result)
        -- Notification Simulation
        Title.Text = "CODE COPIED!"
        task.wait(2)
        Title.Text = "CREATOR: TURK HUB"
    else
        Title.Text = "GAME BLOCKED THIS!"
        task.wait(2)
        Title.Text = "CREATOR: TURK HUB"
    end
end)

--// BUTTON 2: JOIN PRIVATE SERVER (1 PLAYER ONLY BYPASS)
CreateButton("Join Private Server (1 Player Only)", Color3.fromRGB(45, 45, 100), function()
    Title.Text = "FINDING GHOST SERVER..."
    
    -- Mode A: Try Reserved Code first
    if _G.MyServerCode and _G.MyServerCode ~= "" then
        pcall(function()
            TS:TeleportToPrivateServer(game.PlaceId, _G.MyServerCode, {Player})
        end)
    else
        -- Mode B: Universal 1-Player Bypass for NDS/Brainrot
        local success, err = pcall(function()
            local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
            local serverData = Http:JSONDecode(game:HttpGet(url))
            
            for _, server in pairs(serverData.data) do
                -- This ensures ONLY 1 player is in the server
                if server.playing <= 1 and server.id ~= game.JobId then
                    TS:TeleportToPlaceInstance(game.PlaceId, server.id, Player)
                    return
                end
            end
        end)
        
        if not success then
            Title.Text = "RETRYING..."
            task.wait(1)
            TS:Teleport(game.PlaceId) -- Normal rejoin fallback
        end
    end
end)

--// BUTTON 3: CLOSE UI
CreateButton("Close Turk Hub", Color3.fromRGB(150, 50, 50), function()
    TurkHubGui:Destroy()
end)

print("Turk Hub for Ronix Loaded.")
