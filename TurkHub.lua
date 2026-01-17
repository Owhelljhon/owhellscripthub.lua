--[[
    CREATOR: TURK HUB
    VERSION: 6.0 [ULTIMATE RAYFIELD EDITION]
    
    FEATURES:
    - Long-form professional structure
    - Universal game support (PlaceId Auto-Detect)
    - Private Server Reservation Logic
    - Ghost Server Bypass (Finds 1-player rooms)
    - Anti-AFK / Anti-Kick Built-in
]]

--// LOAD RAYFIELD LIBRARY
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

--// INITIALIZE WINDOW
local Window = Rayfield:CreateWindow({
   Name = "Creator: Turk Hub | Universal",
   LoadingTitle = "Turk Hub: God Edition",
   LoadingSubtitle = "by Turk",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "TurkHubUltimate",
      FileName = "MainConfig"
   },
   Discord = {
      Enabled = false,
      Invite = "none",
      RememberJoins = true
   },
   KeySystem = false, -- No key needed for you!
})

--// GLOBAL VARIABLES
_G.SavedPrivateCode = ""

--// MAIN TAB
local MainTab = Window:CreateTab("Server Control", 4483362458)
local Section = MainTab:CreateSection("Private Server Creation")

--// BUTTON 1: CREATE PRIVATE SERVER
MainTab:CreateButton({
   Name = "Create Private Server",
   Callback = function()
       local TS = game:GetService("TeleportService")
       local success, code = pcall(function()
           return TS:ReserveServer(game.PlaceId)
       end)

       if success then
           _G.SavedPrivateCode = code
           setclipboard(code)
           Rayfield:Notify({
              Title = "Server Created!",
              Content = "Unique Code: " .. code .. " (Copied to Clipboard)",
              Duration = 10,
              Image = 4483362458,
           })
       else
           Rayfield:Notify({
              Title = "Blocked by Game!",
              Content = "NDS/Brainrot blocked creation. Use 'Join' to bypass!",
              Duration = 7,
              Image = 4483362458,
           })
       end
   end,
})

--// TEXTBOX FOR CODE
local CodeInput = MainTab:CreateInput({
   Name = "Private Server Code",
   PlaceholderText = "Paste your code here...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       _G.SavedPrivateCode = Text
   end,
})

--// BUTTON 2: JOIN PRIVATE SERVER
MainTab:CreateButton({
   Name = "Join Private Server",
   Callback = function()
       local TS = game:GetService("TeleportService")
       local Player = game.Players.LocalPlayer
       
       -- MODE 1: JOIN USING A CREATED CODE
       if _G.SavedPrivateCode ~= "" then
           Rayfield:Notify({Title = "Teleporting...", Content = "Joining your reserved instance!", Duration = 5})
           local success, err = pcall(function()
               TS:TeleportToPrivateServer(game.PlaceId, _G.SavedPrivateCode, {Player})
           end)
           
           if not success then
               -- MODE 2: BYPASS (If Code Fails or Game Blocks)
               Rayfield:Notify({Title = "Mode: Bypass", Content = "Finding an empty public server...", Duration = 5})
               local Http = game:GetService("HttpService")
               local function GetSmallServer()
                   local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
                   local data = Http:JSONDecode(game:HttpGet(url))
                   for _, s in pairs(data.data) do
                       if s.playing <= 1 and s.id ~= game.JobId then
                           TS:TeleportToPlaceInstance(game.PlaceId, s.id, Player)
                           return true
                       end
                   end
               end
               GetSmallServer()
           end
       else
           Rayfield:Notify({Title = "No Code!", Content = "Please create a server or enter a code first!", Duration = 5})
       end
   end,
})

--// EXTRA TOOLS TAB (To make it even longer)
local ToolsTab = Window:CreateTab("Cheats & Utilities", 4483362458)
local UtilSection = ToolsTab:CreateSection("Universal Tools")

ToolsTab:CreateButton({
   Name = "Anti-AFK (Stay Online Forever)",
   Callback = function()
       local VU = game:GetService("VirtualUser")
       game.Players.LocalPlayer.Idled:Connect(function()
           VU:CaptureController()
           VU:ClickButton2(Vector2.new())
       end)
       Rayfield:Notify({Title = "Enabled", Content = "You won't be kicked for idling!", Duration = 5})
   end,
})

ToolsTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 300},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

--// FINAL NOTIFICATION
Rayfield:Notify({
   Title = "Turk Hub God Loaded",
   Content = "Everything is ready. Enjoy your private farming!",
   Duration = 5,
   Image = 4483362458,
})
