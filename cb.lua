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
    ClearContent()    -- Aimbot switch kısmı

    -- Aimbot switch kısmı
    local Switch = CreateSwitch(ContentFrame, UDim2.new(0, 20, 0, 20))

    local Label = Instance.new("TextLabel", ContentFrame)
    Label.Size = UDim2.new(0, 200, 0, 25)
    Label.Position = UDim2.new(0, 80, 0, 20)
    Label.BackgroundTransparency = 1
    Label.Text = "Aimbot Aç/Kapat"
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = 20

    -- Aimbot aktif/pasif durumu
    local AimbotEnabled = false
    local AimbotSwitch = Instance.new("Frame", ContentFrame)
    AimbotSwitch.Size = UDim2.new(0, 50, 0, 25)
    AimbotSwitch.Position = UDim2.new(0, 20, 0, 60)
    AimbotSwitch.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

    local AimbotCircle = Instance.new("Frame", AimbotSwitch)
    AimbotCircle.Size = UDim2.new(0, 20, 0, 20)
    AimbotCircle.Position = UDim2.new(0, 2, 0, 2)
    AimbotCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    AimbotCircle.Parent = AimbotSwitch

    local AimbotButton = Instance.new("TextButton", AimbotSwitch)
    AimbotButton.Size = UDim2.new(1, 0, 1, 0)
    AimbotButton.BackgroundTransparency = 1
    AimbotButton.Text = ""
    AimbotButton.MouseButton1Click:Connect(function()
        AimbotEnabled = not AimbotEnabled
        if AimbotEnabled then
            TweenService:Create(AimbotCircle, TweenInfo.new(0.25), {Position = UDim2.new(1, -22, 0, 2)}):Play()
            -- Aimbot aktif olduğunda yapılacak işlemler
            _G.AimbotEnabled = true
        else
            TweenService:Create(AimbotCircle, TweenInfo.new(0.25), {Position = UDim2.new(0, 2, 0, 2)}):Play()
            -- Aimbot pasif olduğunda yapılacak işlemler
            _G.AimbotEnabled = false
        end
    end)
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

local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Holding = false

_G.AimbotEnabled = false 
_G.TeamCheck = false -- If set to true then the script would only lock your aim at enemy team members.
_G.AimPart = "Head" -- Where the aimbot script would lock at.
_G.Sensitivity = 0 -- How many seconds it takes for the aimbot script to officially lock onto the target's aimpart.

_G.CircleSides = 64 -- How many sides the FOV circle would have.
_G.CircleColor = Color3.fromRGB(255, 255, 255) -- (RGB) Color that the FOV circle would appear as.
_G.CircleTransparency = 0.7 -- Transparency of the circle.
_G.CircleRadius = 80 -- The radius of the circle / FOV.
_G.CircleFilled = false -- Determines whether or not the circle is filled.
_G.CircleVisible = false -- Determines whether or not the circle is visible. 
_G.CircleThickness = 0 -- The thickness of the circle.

local FOVCircle = Drawing.new("Circle")
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Filled = _G.CircleFilled
FOVCircle.Color = _G.CircleColor
FOVCircle.Visible = _G.CircleVisible
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Transparency = _G.CircleTransparency
FOVCircle.NumSides = _G.CircleSides
FOVCircle.Thickness = _G.CircleThickness

local function GetClosestPlayer()
	local MaximumDistance = _G.CircleRadius
	local Target = nil

	for _, v in next, Players:GetPlayers() do
		if v.Name ~= LocalPlayer.Name then
			if _G.TeamCheck == true then
				if v.Team ~= LocalPlayer.Team then
					if v.Character ~= nil then
						if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
							if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
								local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
								local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
								
								if VectorDistance < MaximumDistance then
									Target = v
								end
							end
						end
					end
				end
			else
				if v.Character ~= nil then
					if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
						if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
							local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
							local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
							
							if VectorDistance < MaximumDistance then
								Target = v
							end
						end
					end
				end
			end
		end
	end

	return Target
end

UserInputService.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = true
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = false
    end
end)

RunService.RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
    FOVCircle.Radius = _G.CircleRadius
    FOVCircle.Filled = _G.CircleFilled
    FOVCircle.Color = _G.CircleColor
    FOVCircle.Visible = _G.CircleVisible
    FOVCircle.Radius = _G.CircleRadius
    FOVCircle.Transparency = _G.CircleTransparency
    FOVCircle.NumSides = _G.CircleSides
    FOVCircle.Thickness = _G.CircleThickness

    if Holding == true and _G.AimbotEnabled == true then
        TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, GetClosestPlayer().Character[_G.AimPart].Position)}):Play()
    end
end)
