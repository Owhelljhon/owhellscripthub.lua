-- [[ Turk Hub V2: Bypass Edition ]] --
-- Works on games that block Private Servers

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Creator: Turk Hub [BYPASS]",
   LoadingTitle = "Turk Hub: Fixing Errors...",
   LoadingSubtitle = "by Turk",
})

local MainTab = Window:CreateTab("Bypass Tools", 4483362458)

-- [[ THE FIX: SERVER HOPPER ]] --
MainTab:CreateButton({
   Name = "Find Empty Public Server (Bypass)",
   Info = "Use this if 'Create Server' gives you an Error!",
   Callback = function()
       Rayfield:Notify({Title = "Scanning...", Content = "Looking for empty servers...", Duration = 3})
       
       local HttpService = game:GetService("HttpService")
       local TeleportService = game:GetService("TeleportService")
       local PlaceId = game.PlaceId
       
       -- This scans public servers for the one with the least players
       local function Hop()
           local url = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
           local serverData = HttpService:JSONDecode(game:HttpGet(url))
           
           for _, server in pairs(serverData.data) do
               if server.playing < server.maxPlayers and server.id ~= game.JobId then
                   TeleportService:TeleportToPlaceInstance(PlaceId, server.id, game.Players.LocalPlayer)
                   return
               end
           end
       end
       
       pcall(Hop)
   end,
})

-- [[ ORIGINAL FEATURE (STILL HERE) ]] --
MainTab:CreateButton({
   Name = "Create Private Server (Legacy)",
   Callback = function()
       local success, code = pcall(function()
           return game:GetService("TeleportService"):ReserveServer(game.PlaceId)
       end)

       if success then
           setclipboard(code)
           game:GetService("TeleportService"):TeleportToPrivateServer(game.PlaceId, code, {game.Players.LocalPlayer})
       else
           Rayfield:Notify({
              Title = "Error Blocked!",
              Content = "Game blocked this. Use 'Find Empty Server' instead!",
              Duration = 5,
           })
       end
   end,
})

Rayfield:Notify({
   Title = "Turk Hub V2 Ready",
   Content = "Use 'Bypass' for games that show errors!",
   Duration = 5,
})
