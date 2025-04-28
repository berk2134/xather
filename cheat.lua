local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
    Name = "Vortex Premium",
    LoadingTitle = "Vortex Premium",
    LoadingSubtitle = "by YourName",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "VortexPremium", -- Config dosyalarının kaydedileceği klasör
        FileName = "Settings"
    },
    Discord = {
        Enabled = false,
        Invite = "yourdiscord", -- İstersen burayı ayarlarsın
        RememberJoins = false
    },
    KeySystem = false,
})

local MainTab = Window:CreateTab("Main", 4483362458) -- Birinci Tab
local Section = MainTab:CreateSection("Aimbot Settings")

-- Toggle
local AimbotToggle = MainTab:CreateToggle({
    Name = "Aimbot Aç/Kapat",
    CurrentValue = false,
    Flag = "AimbotToggle",
    Callback = function(Value)
        print("Aimbot aktif mi: ", Value)
    end,
})

-- Slider
local FOVSlider = MainTab:CreateSlider({
    Name = "FOV Ayarı",
    Range = {10, 100},
    Increment = 1,
    Suffix = "px",
    CurrentValue = 50,
    Flag = "FOVSlider",
    Callback = function(Value)
        print("Yeni FOV: ", Value)
    end,
})

-- Button
local StartButton = MainTab:CreateButton({
    Name = "Aimbot Başlat",
    Callback = function()
        print("Aimbot Başlatıldı!")
    end,
})
