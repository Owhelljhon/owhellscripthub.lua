-- [[ Turk Hub: Universal Private Server Manager ]] --
-- Creator: Turk Hub
-- Compatibility: Works on all games (Universal)

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Creator: Turk Hub",
   LoadingTitle = "Turk Hub Universal",
   LoadingSubtitle = "by Turk",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "TurkHubData",
      FileName = "UniversalConfig"
   },
   Discord = {
      Enabled = false,
      Invite = "",
      RememberJoins = true
   },
   KeySystem = false, -- Change to true if you want to add a key
})

-- [[ MAIN TAB ]] --
local MainTab = Window:CreateTab("Server Tools", 4483362458) 
local Section = MainTab:CreateSection("Server Creation")

MainTab:CreateButton({
   Name = "Generate Private Server & Teleport",
   Info = "This will create a new instance and copy the code to your clipboard.",
   Callback = function()
       local TS = game:GetService("TeleportService")
       local Players = game:GetService("Players")
       
       -- Generate the Reserved Server
       local success, code = pcall(function()
           return TS:ReserveServer(game.PlaceId)
       end)

       if success then
           setclipboard(code) -- Automatically copies for sharing
           Rayfield:Notify({
              Title = "Success!",
              Content = "Code Copied to Clipboard! Teleporting now...",
              Duration = 6.5,
              Image = 4483362458,
           })
           task.wait(1.5)
           TS:TeleportToPrivateServer(game.PlaceId, code, {Players.LocalPlayer})
       else
           Rayfield:Notify({
              Title = "Error",
              Content = "Game does not support Reserved Servers.",
              Duration = 5,
              Image = 4483362458,
           })
       end
   end,
})

local Section = MainTab:CreateSection("Join Friend")

local JoinInput = MainTab:CreateInput({
   Name = "Enter Server Code",
   PlaceholderText = "Paste long code here...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       _G.TargetServerCode = Text
   end,
})

MainTab:CreateButton({
   Name = "Join via Code",
   Callback = function()
       if _G.TargetServerCode and _G.TargetServerCode ~= "" then
           game:GetService("TeleportService"):TeleportToPrivateServer(game.PlaceId, _G.TargetServerCode, {game.Players.LocalPlayer})
       else
           Rayfield:Notify({
              Title = "Input Required",
              Content = "Please paste a code into the box above!",
              Duration = 5,
              Image = 4483362458,
           })
       end
   end,
})

-- [[ INFO TAB ]] --
local InfoTab = Window:CreateTab("Game Info", 4483362458)
local GameSection = InfoTab:CreateSection("Current Game Details")

InfoTab:CreateLabel("Game ID: " .. game.GameId)
InfoTab:CreateLabel("Place ID: " .. game.PlaceId)
InfoTab:CreateLabel("Server JobID: " .. game.JobId)

InfoTab:CreateButton({
   Name = "Rejoin Current Server",
   Callback = function()
       game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
   end,
})

-- [[ MISC TAB ]] --
local MiscTab = Window:CreateTab("Settings", 4483362458)
MiscTab:CreateButton({
   Name = "Destroy UI",
   Callback = function()
       Rayfield:Destroy()
   end,
})

Rayfield:Notify({
   Title = "Turk Hub Loaded",
   Content = "Universal Script is ready for use!",
   Duration = 5,
   Image = 4483362458,
})
