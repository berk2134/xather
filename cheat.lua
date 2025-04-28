local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()

local Window = OrionLib:MakeWindow({
    Name = "Vortex Premium",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "VortexPremiumFolder"
})

local Tab = Window:MakeTab({
    Name = "Aimbot",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Tab:AddToggle({
    Name = "Aimbot Aç/Kapat",
    Default = false,
    Callback = function(Value)
        print("Aimbot aktif mi: ", Value)
    end
})

Tab:AddSlider({
    Name = "FOV Ayarı",
    Min = 10,
    Max = 100,
    Default = 50,
    Color = Color3.fromRGB(255, 0, 0),
    Increment = 1,
    ValueName = "px",
    Callback = function(Value)
        print("Yeni FOV: ", Value)
    end
})

Tab:AddButton({
    Name = "Aimbot Başlat",
    Callback = function()
        print("Aimbot Başlatıldı!")
    end
})

-- Ayarlar Tabı
local SettingsTab = Window:MakeTab({
    Name = "Settings",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

SettingsTab:AddButton({
    Name = "Menüyü Kapat",
    Callback = function()
        OrionLib:Destroy()
    end
})
