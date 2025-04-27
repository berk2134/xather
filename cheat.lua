local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons/SaveManager.lua"))()

-- Tema ve Kaydetme yönetimi
local theme = ThemeManager.New({
    Theme = "Dark"
})

local Save = SaveManager.New({
    Folder = "MyGameSaves"
})

-- Menü oluşturma
local Window = Library.CreateWindow("Game Settings")  -- Pencereyi oluştur

-- Genel Ayar Sekmesi
local GeneralTab = Window:NewTab("General Settings")  -- Genel ayarlar sekmesi
local GeneralSection = GeneralTab:NewSection("General Options")

-- Ses seviyesi ayarı
GeneralSection:NewSlider("Volume", "Set the game volume", 100, 0, function(value)
    print("Volume set to: " .. value)
    -- Burada sesi ayarlama kodlarını ekleyebilirsin
end)

-- Grafik ayarı
GeneralSection:NewDropdown("Graphics Quality", "Choose the graphics quality", {"Low", "Medium", "High"}, function(selected)
    print("Graphics quality set to: " .. selected)
    -- Burada grafik ayarlarını değiştirme kodlarını ekleyebilirsin
end)

-- Kontroller sekmesi
local ControlsTab = Window:NewTab("Controls Settings")  -- Kontroller sekmesi
local ControlsSection = ControlsTab:NewSection("Controls Options")

-- Hareket hızı ayarı
ControlsSection:NewSlider("Movement Speed", "Set the movement speed", 100, 1, function(value)
    print("Movement speed set to: " .. value)
    -- Burada hareket hızı ayarlarını değiştirme kodlarını ekleyebilirsin
end)

-- Tuş atama ayarı
ControlsSection:NewButton("Rebind Keys", "Rebind control keys", function()
    print("Opening key rebind menu")
    -- Burada tuş atama menüsünü açma kodlarını ekleyebilirsin
end)

-- Kullanıcı Sekmesi
local UserTab = Window:NewTab("User Settings")  -- Kullanıcı ayarları sekmesi
local UserSection = UserTab:NewSection("User Options")

-- Kullanıcı adı gösterme
UserSection:NewToggle("Show Username", "Toggle visibility of username", function(state)
    if state then
        print("Username will be shown")
        -- Burada kullanıcı adı gösterme kodlarını ekleyebilirsin
    else
        print("Username will be hidden")
        -- Burada kullanıcı adı gizleme kodlarını ekleyebilirsin
    end
end)

-- Menü gösterme
Window:Show()
