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

    -- Aimbot switch kısmı
    local AimbotSwitch = CreateSwitch(ContentFrame, UDim2.new(0, 20, 0, 20))

    local Label = Instance.new("TextLabel", ContentFrame)
    Label.Size = UDim2.new(0, 200, 0, 25)
    Label.Position = UDim2.new(0, 80, 0, 20)
    Label.BackgroundTransparency = 1
    Label.Text = "Aimbot Aç/Kapat"
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = 20

    -- Aimbot aktif/pasif durumu (false olarak başlıyor)
    local AimbotEnabled = false
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
            _G.AimbotEnabled = true
        else
            TweenService:Create(AimbotCircle, TweenInfo.new(0.25), {Position = UDim2.new(0, 2, 0, 2)}):Play()
            _G.AimbotEnabled = false
        end
    end)

    -- Sensitivity Slider
    local SensitivityLabel = Instance.new("TextLabel", ContentFrame)
    SensitivityLabel.Size = UDim2.new(0, 200, 0, 25)
    SensitivityLabel.Position = UDim2.new(0, 80, 0, 60)
    SensitivityLabel.BackgroundTransparency = 1
    SensitivityLabel.Text = "Sensitivity"
    SensitivityLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SensitivityLabel.Font = Enum.Font.SourceSans
    SensitivityLabel.TextSize = 20

    local SensitivitySlider = Instance.new("Frame", ContentFrame)
    SensitivitySlider.Size = UDim2.new(0, 200, 0, 25)
    SensitivitySlider.Position = UDim2.new(0, 80, 0, 90)
    SensitivitySlider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

    local SliderBar = Instance.new("Frame", SensitivitySlider)
    SliderBar.Size = UDim2.new(0, 0, 1, 0)
    SliderBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderBar.BorderSizePixel = 0

    local SensitivityButton = Instance.new("TextButton", SensitivitySlider)
    SensitivityButton.Size = UDim2.new(0, 10, 1, 0)
    SensitivityButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    SensitivityButton.Text = ""
    SensitivityButton.MouseButton1Drag:Connect(function()
        local MousePos = UserInputService:GetMouseLocation().X
        local SliderPos = SensitivitySlider.AbsolutePosition.X
        local SliderWidth = SensitivitySlider.AbsoluteSize.X
        local NewPos = math.clamp(MousePos - SliderPos, 0, SliderWidth)
        SliderBar.Size = UDim2.new(0, NewPos, 1, 0)
        _G.Sensitivity = NewPos / SliderWidth * 1  -- Sensitivity value between 0 and 1
    end)

    -- FOV Visible Switch
    local FovVisibleLabel = Instance.new("TextLabel", ContentFrame)
    FovVisibleLabel.Size = UDim2.new(0, 200, 0, 25)
    FovVisibleLabel.Position = UDim2.new(0, 80, 0, 130)
    FovVisibleLabel.BackgroundTransparency = 1
    FovVisibleLabel.Text = "FOV Visible"
    FovVisibleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    FovVisibleLabel.Font = Enum.Font.SourceSans
    FovVisibleLabel.TextSize = 20

    local FovVisibleSwitch = CreateSwitch(ContentFrame, UDim2.new(0, 20, 0, 160))
    local FovVisibleEnabled = false
    local FovVisibleCircle = Instance.new("Frame", FovVisibleSwitch)
    FovVisibleCircle.Size = UDim2.new(0, 20, 0, 20)
    FovVisibleCircle.Position = UDim2.new(0, 2, 0, 2)
    FovVisibleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    FovVisibleCircle.Parent = FovVisibleSwitch

    local FovVisibleButton = Instance.new("TextButton", FovVisibleSwitch)
    FovVisibleButton.Size = UDim2.new(1, 0, 1, 0)
    FovVisibleButton.BackgroundTransparency = 1
    FovVisibleButton.Text = ""
    FovVisibleButton.MouseButton1Click:Connect(function()
        FovVisibleEnabled = not FovVisibleEnabled
        if FovVisibleEnabled then
            TweenService:Create(FovVisibleCircle, TweenInfo.new(0.25), {Position = UDim2.new(1, -22, 0, 2)}):Play()
            _G.FovVisible = true
        else
            TweenService:Create(FovVisibleCircle, TweenInfo.new(0.25), {Position = UDim2.new(0, 2, 0, 2)}):Play()
            _G.FovVisible = false
        end
    end)

    -- FOV Büyüklüğü (Slider)
    local FovSizeLabel = Instance.new("TextLabel", ContentFrame)
    FovSizeLabel.Size = UDim2.new(0, 200, 0, 25)
    FovSizeLabel.Position = UDim2.new(0, 80, 0, 200)
    FovSizeLabel.BackgroundTransparency = 1
    FovSizeLabel.Text = "FOV Büyüklüğü"
    FovSizeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    FovSizeLabel.Font = Enum.Font.SourceSans
    FovSizeLabel.TextSize = 20

    local FovSizeSlider = Instance.new("Frame", ContentFrame)
    FovSizeSlider.Size = UDim2.new(0, 200, 0, 25)
    FovSizeSlider.Position = UDim2.new(0, 80, 0, 230)
    FovSizeSlider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

    local FovSliderBar = Instance.new("Frame", FovSizeSlider)
    FovSliderBar.Size = UDim2.new(0, 0, 1, 0)
    FovSliderBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    FovSliderBar.BorderSizePixel = 0

    local FovButton = Instance.new("TextButton", FovSizeSlider)
    FovButton.Size = UDim2.new(0, 10, 1, 0)
    FovButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    FovButton.Text = ""
    FovButton.MouseButton1Drag:Connect(function()
        local MousePos = UserInputService:GetMouseLocation().X
        local SliderPos = FovSizeSlider.AbsolutePosition.X
        local SliderWidth = FovSizeSlider.AbsoluteSize.X
        local NewPos = math.clamp(MousePos - SliderPos, 0, SliderWidth)
        FovSliderBar.Size = UDim2.new(0, NewPos, 1, 0)
        _G.FovSize = NewPos / SliderWidth * 180  -- Fov size value between 0 and 180
    end)

    -- FOV Circle Thickness Slider
    local FovThicknessLabel = Instance.new("TextLabel", ContentFrame)
    FovThicknessLabel.Size = UDim2.new(0, 200, 0, 25)
    FovThicknessLabel.Position = UDim2.new(0, 80, 0, 280)
    FovThicknessLabel.BackgroundTransparency = 1
    FovThicknessLabel.Text = "FOV Circle Thickness"
    FovThicknessLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    FovThicknessLabel.Font = Enum.Font.SourceSans
    FovThicknessLabel.TextSize = 20

    local FovThicknessSlider = Instance.new("Frame", ContentFrame)
    FovThicknessSlider.Size = UDim2.new(0, 200, 0, 25)
    FovThicknessSlider.Position = UDim2.new(0, 80, 0, 310)
    FovThicknessSlider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

    local FovThicknessSliderBar = Instance.new("Frame", FovThicknessSlider)
    FovThicknessSliderBar.Size = UDim2.new(0, 0, 1, 0)
    FovThicknessSliderBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    FovThicknessSliderBar.BorderSizePixel = 0

    local FovThicknessButton = Instance.new("TextButton", FovThicknessSlider)
    FovThicknessButton.Size = UDim2.new(0, 10, 1, 0)
    FovThicknessButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    FovThicknessButton.Text = ""
    FovThicknessButton.MouseButton1Drag:Connect(function()
        local MousePos = UserInputService:GetMouseLocation().X
        local SliderPos = FovThicknessSlider.AbsolutePosition.X
        local SliderWidth = FovThicknessSlider.AbsoluteSize.X
        local NewPos = math.clamp(MousePos - SliderPos, 0, SliderWidth)
        FovThicknessSliderBar.Size = UDim2.new(0, NewPos, 1, 0)
        _G.FovThickness = NewPos / SliderWidth * 10  -- Circle thickness value between 0 and 10
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
