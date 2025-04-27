--// GUI Setup
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.CoreGui
screenGui.Name = "ESP_Aimbot_GUI"

-- Create Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 50)  -- Start with a small size (just for the menu bar)
mainFrame.Position = UDim2.new(0, 20, 0, 20)
mainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Create Menu Toggle Button
local menuToggleButton = Instance.new("TextButton")
menuToggleButton.Size = UDim2.new(0, 100, 0, 40)
menuToggleButton.Position = UDim2.new(0, 10, 0, 5)
menuToggleButton.Text = "Menu"
menuToggleButton.TextSize = 16
menuToggleButton.TextColor3 = Color3.new(1, 1, 1)
menuToggleButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
menuToggleButton.Parent = mainFrame

-- Create Menu Panel (hidden by default)
local menuPanel = Instance.new("Frame")
menuPanel.Size = UDim2.new(0, 300, 0, 250)
menuPanel.Position = UDim2.new(0, 0, 0, 50)
menuPanel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
menuPanel.BorderSizePixel = 0
menuPanel.Visible = false  -- Initially hidden
menuPanel.Parent = screenGui

-- Title Label in the Menu Panel
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 300, 0, 30)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.Text = "ESP & Aimbot Menu"
titleLabel.TextSize = 18
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
titleLabel.Parent = menuPanel

-- Aimbot Toggle Button
local aimbotToggle = Instance.new("TextButton")
aimbotToggle.Size = UDim2.new(0, 280, 0, 30)
aimbotToggle.Position = UDim2.new(0, 10, 0, 40)
aimbotToggle.Text = "Aimbot: OFF"
aimbotToggle.TextSize = 14
aimbotToggle.TextColor3 = Color3.new(1, 1, 1)
aimbotToggle.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
aimbotToggle.Parent = menuPanel

-- ESP Toggle Button
local espToggle = Instance.new("TextButton")
espToggle.Size = UDim2.new(0, 280, 0, 30)
espToggle.Position = UDim2.new(0, 10, 0, 80)
espToggle.Text = "ESP: OFF"
espToggle.TextSize = 14
espToggle.TextColor3 = Color3.new(1, 1, 1)
espToggle.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
espToggle.Parent = menuPanel

-- Close Menu Button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 280, 0, 30)
closeButton.Position = UDim2.new(0, 10, 0, 120)
closeButton.Text = "Close Menu"
closeButton.TextSize = 14
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
closeButton.Parent = menuPanel

-- Variables to track if Aimbot and ESP are enabled
local isAimbotEnabled = false
local isEspEnabled = false

-- Aimbot script (from the code you provided)
local function aimbotScript()
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local localPlayer = Players.LocalPlayer
    local camera = game.Workspace.CurrentCamera
    local targetPart = nil
    local aimbotActive = false

    -- Function to toggle aimbot
    local function toggleAimbot()
        aimbotActive = not aimbotActive
        if not aimbotActive then
            targetPart = nil
        end
    end

    -- Listen for mouse input
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.F then
            toggleAimbot()
        end
    end)

    -- Aimbot aiming logic
    RunService.RenderStepped:Connect(function()
        if aimbotActive then
            local closestPlayer = nil
            local shortestDistance = math.huge

            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local target = player.Character.HumanoidRootPart
                    local screenPos, onScreen = camera:WorldToScreenPoint(target.Position)
                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - UserInputService:GetMouseLocation()).Magnitude

                    if onScreen and distance < shortestDistance then
                        closestPlayer = player
                        shortestDistance = distance
                        targetPart = target
                    end
                end
            end

            if targetPart then
                camera.CFrame = CFrame.new(camera.CFrame.Position, targetPart.Position)
            end
        end
    end)
end

-- ESP script (from the code you provided)
local function espScript()
    local Players = game:GetService("Players")
    local Camera = game:GetService("Workspace").CurrentCamera

    local function createESP(player)
        local espBox = Instance.new("BillboardGui")
        espBox.Parent = player.Character.HumanoidRootPart
        espBox.Size = UDim2.new(0, 200, 0, 50)
        espBox.StudsOffset = Vector3.new(0, 3, 0)
        espBox.AlwaysOnTop = true
        espBox.Name = "ESPBox"

        local label = Instance.new("TextLabel")
        label.Parent = espBox
        label.Text = player.Name
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.new(1, 1, 1)
        label.TextStrokeTransparency = 0.8
        label.TextSize = 14
    end

    -- Create ESP for players
    Players.PlayerAdded:Connect(function(player)
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            createESP(player)
        end
        player.CharacterAdded:Connect(function(character)
            createESP(player)
        end)
    end)

    -- Remove ESP when player leaves
    Players.PlayerRemoving:Connect(function(player)
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local espBox = player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("ESPBox")
            if espBox then
                espBox:Destroy()
            end
        end
    end)
end

-- Aimbot toggle function
aimbotToggle.MouseButton1Click:Connect(function()
    isAimbotEnabled = not isAimbotEnabled
    if isAimbotEnabled then
        aimbotToggle.Text = "Aimbot: ON"
        -- Activate Aimbot
        aimbotScript()
    else
        aimbotToggle.Text = "Aimbot: OFF"
        -- Deactivate Aimbot
    end
end)

-- ESP toggle function
espToggle.MouseButton1Click:Connect(function()
    isEspEnabled = not isEspEnabled
    if isEspEnabled then
        espToggle.Text = "ESP: ON"
        -- Activate ESP
        espScript()
    else
        espToggle.Text = "ESP: OFF"
        -- Deactivate ESP
    end
end)

-- Close Menu button
closeButton.MouseButton1Click:Connect(function()
    menuPanel.Visible = false  -- Hide menu when clicked
end)

-- Menu toggle function
menuToggleButton.MouseButton1Click:Connect(function()
    menuPanel.Visible = not menuPanel.Visible  -- Toggle menu visibility
end)
