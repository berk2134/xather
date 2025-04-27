-- Kütüphane yükle (örnek temiz çalışan kütüphane)
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
    Settings = Window:AddTab('Ayarlar'),
    Aim = Window:AddTab('Aimbot'),
    Rage = Window:AddTab('Rage'),
}

Tabs.Main:AddButton({
    Text = 'Aimbot Aç',
    Func = function()
        print('Aimbot Açıldı!')
    end
})

Tabs.Main:AddToggle('Aimbot Aktif', {
    Text = 'Aimbot Aktif Mi?',
    Default = false,
    Callback = function(Value)
        print('Aimbot Aktiflik Durumu:', Value)
    end
})

Tabs.Settings:AddButton({
    Text = 'Menüyü Kapat',
    Func = function()
        Library:Unload()
    end
})

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
SaveManager:SetFolder('PepsiUIExample')
SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)
