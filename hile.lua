-- PepsiUI Kütüphanesini Yükleme
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/berk2134/PepsiUI/main/PepsiUI.lua"))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Aimbot Parametreleri
local aimlockEnabled = false
local fovEnabled = false
local lockFOV = math.rad(8)  -- FOV açısı (radyan cinsinden)
local lockFOVCircleRadius = 50  -- FOV dairesinin çapı
local toggleMouseButton = Enum.UserInputType.MouseButton1 -- Sağ tıklama
local fovCircle = nil

-- FOV Circle'ı çizme fonksiyonu
local function DrawFOVCircle()
    if not fovCircle then
        fovCircle = Instance.new("Part")
        fovCircle.Shape = Enum.PartType.Ball
        fovCircle.Size = Vector3.new(0.1, 0.1, 0.1)
        fovCircle.Anchored = true
        fovCircle.CanCollide = false
        fovCircle.Material = Enum.Material.Neon
        fovCircle.Color = Color3.fromRGB(255, 0, 0)
        fovCircle.Parent = game.Workspace
    end
end

-- Aimbot fonksiyonu
local function Aimlock()
    local localPlayer = game.Players.LocalPlayer
    local mouse = localPlayer:GetMouse()
    local camera = game.Workspace.CurrentCamera

    local closestPlayer = nil
    local closestAngle = lockFOV
    for _, player in ipairs(game.Players:GetPlayers()) do
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

    -- Kamera kilitleme
    if closestPlayer then
        camera.CFrame = CFrame.new(camera.CFrame.Position, closestPlayer.Position)
    end
end

-- PepsiUI Menü Penceresi
local Window = Library:CreateWindow("Vortex Premium - https://discord.gg/B2FAHtRufp")
local Tabs = {
    Main = Window:AddTab('Main'),
    Aim = Window:AddTab('Aimbot'),
    Settings = Window:AddTab('Settings')
}

-- Aimbot Sekmesindeki Ayarlar
Tabs.Aim:AddToggle("Aimbot Aktif", {
    Text = "Aimbot Aktif Mi?",
    Default = false,
    Callback = function(Value)
        aimlockEnabled = Value
    end
})

Tabs.Aim:AddToggle("FOV Çiz", {
    Text = "FOV Çizimi Aktif Mi?",
    Default = false,
    Callback = function(Value)
        fovEnabled = Value
        if fovEnabled then
            DrawFOVCircle()
        else
            if fovCircle then
                fovCircle:Destroy()
                fovCircle = nil
            end
        end
    end
})

Tabs.Aim:AddSlider("FOV Çapı", {
    Text = "FOV Çapı",
    Min = 10,
    Max = 100,
    Default = lockFOVCircleRadius,
    Callback = function(Value)
        lockFOVCircleRadius = Value
        if fovCircle then
            fovCircle.Size = Vector3.new(Value, Value, Value)
        end
    end
})

Tabs.Aim:AddButton({
    Text = "Aimbot Başlat",
    Func = function()
        print("Aimbot Başlatıldı!")
    end
})

Tabs.Aim:AddButton({
    Text = "Kilitlenme (Lock)",
    Func = function()
        print("Aimbot Kilitlenmesi Başlatıldı!")
    end
})

-- Menü Butonu
Tabs.Settings:AddButton({
    Text = "Menüyü Kapat",
    Func = function()
        Library:Unload()
    end
})

-- RunService ile Aimbot ve FOV Çizimini Çalıştırma
RunService.RenderStepped:Connect(function()
    if aimlockEnabled then
        Aimlock()
    end

    -- FOV Circle'ı kameraya göre ayarlama
    if fovCircle and fovEnabled then
        local camera = game.Workspace.CurrentCamera
        local mousePos = game.Players.LocalPlayer:GetMouse().Hit.p
        fovCircle.Position = Vector3.new(mousePos.X, mousePos.Y, camera.CFrame.Position.Z)  -- 3D pozisyon ayarlama
    end
end)

-- Tema ve Kayıt Ayarları
Library:BuildConfigSection(Tabs.Settings)
