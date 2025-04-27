-- Kütüphane yükle
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons/SaveManager.lua"))()

local Window = Library:CreateWindow({
    Title = "Vortex Premium - https://discord.gg/B2FAHtRufp",
    Center = true,
    AutoShow = true,
})

local Tabs = {
    Main = Window:AddTab('Main'),
    Aim = Window:AddTab('Aimbot'),
    Rage = Window:AddTab('Rage'),
    Visual = Window:AddTab('Visual'),
    Movement = Window:AddTab('Movement'),
    Misc = Window:AddTab('Misc'),
    Settings = Window:AddTab('Settings'),
}

-- Main sekmesinde sabit yazı (paragraf)
Tabs.Main:AddParagraph("Vortex Premium", "Gelişmiş olan oyun dünyasının en önemli oyunlarından birisi olan Counter Blox için yazılmış 3. parti yazılım olan Vortex Premium, müşterilerine iyi hizmet ve eğlenceli bir deneyim yaşatmaya çalışır. İyi Oyunlar.")

-- Discord linki kopyalayan buton
Tabs.Main:AddButton({
    Text = 'Discord Linkini Kopyala',
    Func = function()
        setclipboard("https://discord.gg/B2FAHtRufp")
        Library:Notify("Discord linki kopyalandı!")
    end
})

-- Aimbot Aç butonu
Tabs.Main:AddButton({
    Text = 'Aimbot Aç',
    Func = function()
        print('Aimbot Açıldı!')
    end
})

-- Aimbot Aktif toggle
Tabs.Main:AddToggle('Aimbot Aktif', {
    Text = 'Aimbot Aktif Mi?',
    Default = false,
    Callback = function(Value)
        print('Aimbot Aktiflik Durumu:', Value)
    end
})

-- Ayarlar sekmesi
Tabs.Settings:AddButton({
    Text = 'Menüyü Kapat',
    Func = function()
        Library:Unload()
    end
})

-- Tema ve kayıt sistemi
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
SaveManager:SetFolder('PepsiUIExample')
SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)
