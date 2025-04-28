local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- GUI oluştur
local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))

-- Ana Frame
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

-- Üst Çubuk (Yeni Eklendi)
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 30)  -- Çubuğun boyutu
TopBar.Position = UDim2.new(0, 0, 0, 0)  -- Üst tarafta
TopBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

-- "CB" Yazısı
local CBText = Instance.new("TextLabel", TopBar)
CBText.Size = UDim2.new(0, 50, 1, 0)  -- Çubuğun sol tarafında yer alacak
CBText.Position = UDim2.new(0, 10, 0, 0)
CBText.BackgroundTransparency = 1
CBText.Text = "CB"
CBText.TextColor3 = Color3.fromRGB(255, 165, 0)  -- Turuncu renk
CBText.Font = Enum.Font.SourceSansBold
CBText.TextSize = 20

-- "Vortex Premium - https://discord.gg/B2FAHtRufp" Yazısı
local VortexText = Instance.new("TextLabel", TopBar)
VortexText.Size = UDim2.new(1, -70, 1, 0)  -- Geriye kalan alanı kaplayacak
VortexText.Position = UDim2.new(0, 60, 0, 0)  -- "CB" yazısından sonra başlayacak
VortexText.BackgroundTransparency = 1
VortexText.Text = "Vortex Premium - https://discord.gg/B2FAHtRufp"
VortexText.TextColor3 = Color3.fromRGB(255, 0, 0)  -- Kırmızı renk
VortexText.Font = Enum.Font.SourceSansBold  -- Kalın yazı fontu
VortexText.TextSize = 18
VortexText.TextXAlignment = Enum.TextXAlignment.Left  -- Yazı sola hizalanacak

-- Sol Menü
local MenuFrame = Instance.new("Frame", MainFrame)
MenuFrame.Size = UDim2.new(0, 80, 1, 0)
MenuFrame.Position = UDim2.new(0, 0, 0, 30)  -- Menüyü üst çubuğun altına yerleştiriyoruz
MenuFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

-- Sağ İçerik Paneli
local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Size = UDim2.new(1, -80, 1, 0)
ContentFrame.Position = UDim2.new(0, 80, 0, 30)  -- İçeriği de çubuğun altına yerleştiriyoruz
ContentFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

-- Menü başlangıçta görünür
MainFrame.Visible = true

-- Fonksiyon: Switch Oluşturma
local function CreateSwitch(Parent, Position)
    local Switch = Instance.new("Frame")
    Switch.Size = UDim2.new(0, 50, 0, 25)
    Switch.Position = Position or UDim2.new(0, 20, 0, 20)
    Switch.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    Switch.Parent = Parent

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Switch

    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 20, 0, 20)
    Circle.Position = UDim2.new(0, 2, 0, 2)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Circle.Parent = Switch

    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(1, 0)
    CircleCorner.Parent = Circle

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 1, 0)
    Button.BackgroundTransparency = 1
    Button.Text = ""
    Button.Parent = Switch

    local toggled = false

    Button.MouseButton1Click:Connect(function()
        toggled = not toggled

        if toggled then
            TweenService:Create(Switch, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(0, 170, 255)}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.25), {Position = UDim2.new(1, -22, 0, 2)}):Play()
        else
            TweenService:Create(Switch, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(100, 100, 100)}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.25), {Position = UDim2.new(0, 2, 0, 2)}):Play()
        end
    end)

    return Switch
end

-- İçeriği Temizleme
local function ClearContent()
    for _, child in ipairs(ContentFrame:GetChildren()) do
        if child:IsA("GuiObject") then
            child:Destroy()
        end
    end
end

-- Menü Butonu Fonksiyonu
local function CreateMenuButton(Icon, Name, Order, Callback)
    local Button = Instance.new("TextButton", MenuFrame)
    Button.Size = UDim2.new(0, 60, 0, 60)
    Button.Position = UDim2.new(0, 10, 0, 10 + (70 * (Order - 1)))
    Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Button.Text = Icon
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.SourceSans
    Button.TextSize = 30

    local UICorner = Instance.new("UICorner", Button)
    UICorner.CornerRadius = UDim.new(0.2, 0)

    Button.MouseButton1Click:Connect(function()
        Callback()
    end)
end

-- Menü Fonksiyonları
CreateMenuButton("🏠", "Ana Menü", 1, function()
    ClearContent()

    local Label = Instance.new("TextLabel", ContentFrame)
    Label.Size = UDim2.new(1, 0, 0, 50)
    Label.Position = UDim2.new(0, 0, 0, 10)
    Label.BackgroundTransparency = 1
    Label.Text = "Ana Menü"
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.SourceSansBold
    Label.TextSize = 24
end)

CreateMenuButton("🎯", "Aimbot", 2, function()
    ClearContent()

    -- Aimbot açma/kapama toggle butonunu oluşturuyoruz
    local Switch = CreateSwitch(ContentFrame, UDim2.new(0, 20, 0, 20))

    -- Etiket (Label) kısmı, Aimbot başlığını gösterecek
    local Label = Instance.new("TextLabel", ContentFrame)
    Label.Size = UDim2.new(0, 200, 0, 25)
    Label.Position = UDim2.new(0, 80, 0, 20)
    Label.BackgroundTransparency = 1
    Label.Text = "AIMBOT"
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = 20

    -- Aimbot'un aktif olup olmadığını kontrol edeceğiz.
    local toggled = false -- Başlangıçta aimbot kapalı

    -- Düğmeye tıklanması durumunda işlemi yap
    Switch.MouseButton1Click:Connect(function()
        toggled = not toggled  -- Durum değiştir

        if toggled then
            -- Aimbot aktif olduğunda yapılacak işlemler:
            aimlockEnabled = true  -- **BURADA DEĞİŞTİRECEĞİN ŞEYİ true YAP**
            print("Aimbot Açıldı")  -- Konsola çıktı verir
        else
            -- Aimbot kapalı olduğunda yapılacak işlemler:
            aimlockEnabled = false  -- **BURADA DEĞİŞTİRECEĞİN ŞEYİ false YAP**
            print("Aimbot Kapalı")  -- Konsola çıktı verir
        end
    end)

CreateMenuButton("👁️", "ESP", 3, function()
    ClearContent()

    local Switch = CreateSwitch(ContentFrame, UDim2.new(0, 20, 0, 20))

    local Label = Instance.new("TextLabel", ContentFrame)
    Label.Size = UDim2.new(0, 200, 0, 25)
    Label.Position = UDim2.new(0, 80, 0, 20)
    Label.BackgroundTransparency = 1
    Label.Text = "ESP Aç/Kapat"
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = 20
end)

CreateMenuButton("👟", "Movement", 4, function()
    ClearContent()

    local Switch = CreateSwitch(ContentFrame, UDim2.new(0, 20, 0, 20))

    local Label = Instance.new("TextLabel", ContentFrame)
    Label.Size = UDim2.new(0, 200, 0, 25)
    Label.Position = UDim2.new(0, 80, 0, 20)
    Label.BackgroundTransparency = 1
    Label.Text = "Hızlı Koşu Aç/Kapat"
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = 20
end)

CreateMenuButton("⚙️", "Ayarlar", 5, function()
    ClearContent()

    local Label = Instance.new("TextLabel", ContentFrame)
    Label.Size = UDim2.new(1, 0, 0, 50)
    Label.Position = UDim2.new(0, 0, 0, 10)
    Label.BackgroundTransparency = 1
    Label.Text = "Ayarlar Menüsü"
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.SourceSansBold
    Label.TextSize = 24
end)

-- Menü görünürlüğünü kontrol eden fonksiyon
local function ToggleMenu()
    MainFrame.Visible = not MainFrame.Visible
end

-- 'O' tuşuna basıldığında menü açma ve kapama
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.O then
        ToggleMenu()
    end
end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local camera = game.Workspace.CurrentCamera

-- Aimbot Ayarları
local aimlockEnabled = false
local lockFOV = math.rad(8)  -- FOV açısı (radyan cinsinden)
local lockFOVCircleRadius = 100  -- FOV dairesi çapı

-- Aimbot'a Başlamak için Burada Ayarlar Yapılabilir
local function Aimlock()
    local localPlayer = Players.LocalPlayer
    local mouse = localPlayer:GetMouse()

    local closestPlayer = nil
    local closestAngle = lockFOV  -- Başlangıçta FOV açısı
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Head") and player.Team ~= localPlayer.Team and player.Character.Humanoid.Health > 0 then
            local head = player.Character.Head
            local direction = (head.Position - camera.CFrame.Position).Unit
            local angle = math.acos(direction:Dot(camera.CFrame.LookVector))
            if angle < closestAngle then
                closestAngle = angle
                closestPlayer = head
            end
        end
    end

    -- En yakına kilitlen
    if closestPlayer then
        camera.CFrame = CFrame.new(camera.CFrame.Position, closestPlayer.Position)
    end
end

-- Aimbot'u tetiklemek için mouse tuşu

-- Aimbot'u tetiklemek için Insert tuşuna basıldığında yapılacak işlem
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    -- Eğer oyun zaten bu girişi işliyorsa (örneğin, menü açık vs.) işlemi geç
    if gameProcessedEvent then return end
    
    -- Insert tuşuna basıldığını kontrol et
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.X then
        aimlockEnabled = not aimlockEnabled  -- Toggle işlemi
        print("Aimbot durumu: " .. (aimlockEnabled and "Aktif" or "Pasif"))
    end
end)

-- Aimbot aktifse her frame'de çalıştır
RunService.RenderStepped:Connect(function()
    if aimlockEnabled then
        Aimlock()
    end
end)

-- FOV'nin dairesini göster
local function DrawFOVCircle()
    if not aimlockEnabled then return end
    local localPlayer = Players.LocalPlayer
    local mouse = localPlayer:GetMouse()
    local fovCircle = Instance.new("Part")
    fovCircle.Shape = Enum.PartType.Ball
    fovCircle.Size = Vector3.new(lockFOVCircleRadius, lockFOVCircleRadius, lockFOVCircleRadius)
    fovCircle.Position = mouse.Hit.p
    fovCircle.Anchored = true
    fovCircle.CanCollide = false
    fovCircle.Transparency = 0.5
    fovCircle.BrickColor = BrickColor.new("Bright blue")
    fovCircle.Parent = workspace

    -- FOV dairesi belirli bir süre sonra silinir
    game:GetService("Debris"):AddItem(fovCircle, 0.1)
end

-- FOV dairesi göster
RunService.RenderStepped:Connect(function()
    if fovEnabled then
        DrawFOVCircle()
    end
end)

-- Menüdeki ayarları kullanarak kodu değiştirebilirsiniz:
-- 1. Aimbot'u aktif edebilirsiniz (mouse sağ tıklama ile)
-- 2. FOV dairesi ve FOV açısını menüden ayarlayabilirsiniz
