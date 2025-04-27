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

-- Aimbot özelliklerini kontrol eden değişkenler
local aimlockEnabled = false
local fovEnabled = false
local lockFOV = math.rad(8)  -- The smaller lock FOV angle in radians
local lockFOVCircleRadius = 50  -- FOV Circle radius (adjustable)
local toggleMouseButton = Enum.UserInputType.MouseButton1 -- Right mouse button (can change)
local fovCircle = nil

-- FOV Circle çizme fonksiyonu
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

    -- Lock the camera onto the head of the closest player
    if closestPlayer then
        camera.CFrame = CFrame.new(camera.CFrame.Position, closestPlayer.Position)
    end
end

-- Aimbot ayarları
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

-- Aimbot ayarları ve fonksiyonlar

-- FOV Circle'ın konumunu güncelleme
RunService.RenderStepped:Connect(function()
    if aimlockEnabled then
        Aimlock()
    end

    -- FOV Circle'ı kameraya göre ayarlıyoruz
    if fovCircle and fovEnabled then
        local camera = game.Workspace.CurrentCamera
        local mousePos = game.Players.LocalPlayer:GetMouse().Hit.p
        fovCircle.Position = Vector3.new(mousePos.X, mousePos.Y, camera.CFrame.Position.Z)  -- adjust for 3D positioning
    end
end)

-- Diğer özellikler
Tabs.Settings:AddButton({
    Text = "Menüyü Kapat",
    Func = function()
        Library:Unload()
    end
})

-- Tema ve Kayıt ayarları
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
SaveManager:SetFolder('VortexPremium')
SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)
