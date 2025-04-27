-- Pepsi UI Kütüphanesini yükle
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/DeividComSono/PesiUI/main/Library.lua"))()

-- Menü Oluştur
local Window = Library:CreateWindow("Xather")

-- Sekme (Tab) Oluştur
local Tab = Window:CreateTab("Ana Menü")

-- Toggle (Aç/Kapat butonu)
local Toggle = Tab:CreateToggle("Aimbot Aç/Kapat", function(state)
    if state then
        print("Aimbot Açıldı!")
        -- Buraya Aimbot'u açan kodu yazarsın
    else
        print("Aimbot Kapatıldı!")
        -- Buraya Aimbot'u kapatan kodu yazarsın
    end
end)

-- Buton
local Button = Tab:CreateButton("Duvar Koruması Aktif Et", function()
    print("Duvar koruması aktif edildi!")
    -- Buraya duvar kontrolü kodu yazılır
end)

-- Label (Bilgi yazısı)
local Label = Tab:CreateLabel("by Hezli Meymun")
