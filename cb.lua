local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- GUI oluştur
local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

-- Menünün alt kısmında aimbot ve ayarları
local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Size = UDim2.new(1, -80, 1, 0)
ContentFrame.Position = UDim2.new(0, 80, 0, 30)  
ContentFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

-- Aimbot düğmesi
local AimbotSwitch = Instance.new("Frame", ContentFrame)
AimbotSwitch.Size = UDim2.new(0, 50, 0, 25)
AimbotSwitch.Position = UDim2.new(0, 20, 0, 20)
AimbotSwitch.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

local Circle = Instance.new("Frame", AimbotSwitch)
Circle.Size = UDim2.new(0, 20, 0, 20)
Circle.Position = UDim2.new(0, 2, 0, 2)
Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

local AimbotButton = Instance.new("TextButton", AimbotSwitch)
AimbotButton.Size = UDim2.new(1, 0, 1, 0)
AimbotButton.BackgroundTransparency = 1
AimbotButton.Text = ""
AimbotButton.MouseButton1Click:Connect(function()
    _G.AimbotEnabled = not _G.AimbotEnabled
    -- Aimbot aktif ya da pasif olduğunda yapılacak işlemler
    if _G.AimbotEnabled then
        TweenService:Create(Circle, TweenInfo.new(0.25), {Position = UDim2.new(1, -22, 0, 2)}):Play()
    else
        TweenService:Create(Circle, TweenInfo.new(0.25), {Position = UDim2.new(0, 2, 0, 2)}):Play()
    end
end)

-- Team Check (Düşman Takım Kilidi)
local TeamCheckSwitch = Instance.new("Frame", ContentFrame)
TeamCheckSwitch.Size = UDim2.new(0, 50, 0, 25)
TeamCheckSwitch.Position = UDim2.new(0, 20, 0, 60)
TeamCheckSwitch.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

local TeamCheckCircle = Instance.new("Frame", TeamCheckSwitch)
TeamCheckCircle.Size = UDim2.new(0, 20, 0, 20)
TeamCheckCircle.Position = UDim2.new(0, 2, 0, 2)
TeamCheckCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

local TeamCheckButton = Instance.new("TextButton", TeamCheckSwitch)
TeamCheckButton.Size = UDim2.new(1, 0, 1, 0)
TeamCheckButton.BackgroundTransparency = 1
TeamCheckButton.Text = ""
TeamCheckButton.MouseButton1Click:Connect(function()
    _G.TeamCheck = not _G.TeamCheck
    -- TeamCheck aktif ya da pasif olduğunda yapılacak işlemler
    if _G.TeamCheck then
        TweenService:Create(TeamCheckCircle, TweenInfo.new(0.25), {Position = UDim2.new(1, -22, 0, 2)}):Play()
    else
        TweenService:Create(TeamCheckCircle, TweenInfo.new(0.25), {Position = UDim2.new(0, 2, 0, 2)}):Play()
    end
end)

-- Sensitivity kaydırıcı
local SensitivitySlider = Instance.new("Frame", ContentFrame)
SensitivitySlider.Size = UDim2.new(0, 200, 0, 25)
SensitivitySlider.Position = UDim2.new(0, 20, 0, 100)
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

-- FOV Circle Görünürlük Ayarı
local FOVCircleSwitch = Instance.new("Frame", ContentFrame)
FOVCircleSwitch.Size = UDim2.new(0, 50, 0, 25)
FOVCircleSwitch.Position = UDim2.new(0, 20, 0, 140)
FOVCircleSwitch.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

local FOVCircleCircle = Instance.new("Frame", FOVCircleSwitch)
FOVCircleCircle.Size = UDim2.new(0, 20, 0, 20)
FOVCircleCircle.Position = UDim2.new(0, 2, 0, 2)
FOVCircleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

local FOVCircleButton = Instance.new("TextButton", FOVCircleSwitch)
FOVCircleButton.Size = UDim2.new(1, 0, 1, 0)
FOVCircleButton.BackgroundTransparency = 1
FOVCircleButton.Text = ""
FOVCircleButton.MouseButton1Click:Connect(function()
    _G.CircleVisible = not _G.CircleVisible
    -- FOV Circle aktif ya da pasif olduğunda yapılacak işlemler
    if _G.CircleVisible then
        TweenService:Create(FOVCircleCircle, TweenInfo.new(0.25), {Position = UDim2.new(1, -22, 0, 2)}):Play()
    else
        TweenService:Create(FOVCircleCircle, TweenInfo.new(0.25), {Position = UDim2.new(0, 2, 0, 2)}):Play()
    end
end)

-- Bu kısımda menüyü açıp kapamak için gerekli fonksiyonu ekle
local function ToggleMenu()
    MainFrame.Visible = not MainFrame.Visible
end

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
