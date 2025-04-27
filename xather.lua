-- Fluent UI Kütüphanesini Yükle
local fluentUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/FluentUI/FluentUI-ROBLOX/main/fluent-ui.lua"))()

-- Menü Tasarımı Başlat
local screenGui = fluentUI.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Menü Başlık
local title = fluentUI.TextLabel({
    Text = "Xeno Executor Menü",
    FontSize = 24,
    TextColor = Color3.fromRGB(255, 255, 255),
    BackgroundColor = Color3.fromRGB(40, 40, 40),
    Size = UDim2.new(0, 400, 0, 50),
    Position = UDim2.new(0.5, -200, 0.2, -25),
    Parent = screenGui
})

-- Menü Butonları
local button1 = fluentUI.TextButton({
    Text = "Aimbot Aç",
    FontSize = 18,
    TextColor = Color3.fromRGB(255, 255, 255),
    BackgroundColor = Color3.fromRGB(60, 60, 60),
    Size = UDim2.new(0, 200, 0, 50),
    Position = UDim2.new(0.5, -100, 0.4, 0),
    Parent = screenGui
})

button1.MouseButton1Click:Connect(function()
    -- Aimbot açma kodu burada yer alacak
    print("Aimbot Açıldı!")
end)

local button2 = fluentUI.TextButton({
    Text = "Duvar Koruması Aç",
    FontSize = 18,
    TextColor = Color3.fromRGB(255, 255, 255),
    BackgroundColor = Color3.fromRGB(60, 60, 60),
    Size = UDim2.new(0, 200, 0, 50),
    Position = UDim2.new(0.5, -100, 0.5, 0),
    Parent = screenGui
})

button2.MouseButton1Click:Connect(function()
    -- Duvar koruması açma kodu burada yer alacak
    print("Duvar Koruması Açıldı!")
end)

local button3 = fluentUI.TextButton({
    Text = "Çıkış",
    FontSize = 18,
    TextColor = Color3.fromRGB(255, 255, 255),
    BackgroundColor = Color3.fromRGB(60, 60, 60),
    Size = UDim2.new(0, 200, 0, 50),
    Position = UDim2.new(0.5, -100, 0.6, 0),
    Parent = screenGui
})

button3.MouseButton1Click:Connect(function()
    screenGui:Destroy()  -- Menü kapatılır
end)

-- Menü açma/kapama için "Ins" tuşu kullan
local UserInputService = game:GetService("UserInputService")
local menuVisible = false

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end -- Eğer oyun zaten bu tuşu işledi ise, işleme devam etme

    if input.KeyCode == Enum.KeyCode.Insert then
        menuVisible = not menuVisible  -- Menü görünürlük durumunu tersine çevir
        screenGui.Enabled = menuVisible  -- Menü görünürlüğünü güncelle
    end
end)

-- Başlangıçta menü gizli olacak
screenGui.Enabled = false
