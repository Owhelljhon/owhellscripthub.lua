--[[
    CREATOR: TURK HUB
    SUPPORTED GAMES: 
    - Natural Disaster Survival
    - Steal a Brainrot
    - Escape Tsunami For Brainrots
    - Brookhaven (RP)
    - Universal (Works on any game)
]]

--// CORE SETUP (LONG CODE RENDERING)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Creator: Turk Hub | Universal v4",
   LoadingTitle = "Turk Hub: Multi-Game Support",
   LoadingSubtitle = "by Turk",
   ConfigurationSaving = {Enabled = true, FolderName = "TurkHub", FileName = "Config"}
})

--// MAIN TAB
local Tab = Window:CreateTab("Server Control", 4483362458)

local Section = Tab:CreateSection("Bypass Tools (For NDS & Brainrot)")

Tab:CreateButton({
   Name = "Bypass: Find Smallest Server",
   Info = "Use this for NDS and Steal a Brainrot to play alone!",
   Callback = function()
       Rayfield:Notify({Title = "Scanning...", Content = "Finding an empty server...", Duration = 4})
       local Http = game:GetService("HttpService")
       local TS = game:GetService("TeleportService")
       local ID = game.PlaceId
       
       -- Scans the Roblox API for servers with the fewest players
       local function ServerHop()
           local url = "https://games.roblox.com/v1/games/" .. ID .. "/servers/Public?sortOrder=Asc&limit=100"
           local success, result = pcall(function() return game:HttpGet(url) end)
           if success then
               local data = Http:JSONDecode(result)
               for _, server in pairs(data.data) do
                   if server.playing < server.maxPlayers and server.id ~= game.JobId then
                       TS:TeleportToPlaceInstance(ID, server.id, game.Players.LocalPlayer)
                       return
                   end
               end
           end
       end
       ServerHop()
   end,
})

local Section = Tab:CreateSection("Private Tools (For Brookhaven)")

Tab:CreateButton({
   Name = "Create Private Server (Code)",
   Callback = function()
       local TS = game:GetService("TeleportService")
       local success, code = pcall(function() return TS:ReserveServer(game.PlaceId) end)
       
       if success then
           setclipboard(code)
           Rayfield:Notify({Title = "Success", Content = "Code copied! Teleporting...", Duration = 5})
           task.wait(1)
           TS:TeleportToPrivateServer(game.PlaceId, code, {game.Players.LocalPlayer})
       else
           -- This message appears if NDS or Brainrot blocks the request
           Rayfield:Notify({Title = "Blocked", Content = "Game blocked this! Use 'Bypass' button instead.", Duration = 7})
       end
   end,
})

local Section = Tab:CreateSection("Misc Utilities")

Tab:CreateButton({
   Name = "Anti-AFK (Stay Online)",
   Callback = function()
       local VU = game:GetService("VirtualUser")
       game:GetService("Players").LocalPlayer.Idled:Connect(function()
           VU:CaptureController()
           VU:ClickButton2(Vector2.new())
           Rayfield:Notify({Title = "Anti-AFK", Content = "Prevented kick!", Duration = 2})
       end)
   end,
})

Tab:CreateButton({
   Name = "Instant Rejoin",
   Callback = function()
       game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
   end,
})

Rayfield:Notify({
   Title = "Turk Hub Loaded!",
   Content = "Ready for NDS, Brookhaven, and Brainrot games.",
   Duration = 5,
})
