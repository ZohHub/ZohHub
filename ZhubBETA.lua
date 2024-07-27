-- Define UI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Buttons = {}

-- Set up the ScreenGui
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Position = UDim2.new(0, 10, 0, 10)
MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainFrame.BorderSizePixel = 0

-- Create buttons
local buttonNames = {"ESP", "Fly", "Noclip", "Fling"}
for i, name in ipairs(buttonNames) do
    local Button = Instance.new("TextButton")
    Button.Parent = MainFrame
    Button.Size = UDim2.new(0, 180, 0, 30)
    Button.Position = UDim2.new(0, 10, 0, (i - 1) * 35 + 10)
    Button.Text = name
    Button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.BorderSizePixel = 0
    table.insert(Buttons, Button)
end

-- Function for ESP
local function createESP(player)
    local billboard = Instance.new("BillboardGui")
    local nameTag = Instance.new("TextLabel")

    billboard.Parent = player.Character.Head
    billboard.Size = UDim2.new(0, 100, 0, 50)
    billboard.Adornee = player.Character.Head
    billboard.AlwaysOnTop = true

    nameTag.Parent = billboard
    nameTag.Size = UDim2.new(1, 0, 1, 0)
    nameTag.BackgroundTransparency = 1
    nameTag.Text = "Enemies"
    nameTag.TextColor3 = Color3.new(1, 0, 0)
    nameTag.TextScaled = true
end

-- Apply ESP to all players
local function applyESP()
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            createESP(player)
        end
    end
end

-- Fly function
local flying = false
local function toggleFly()
    flying = not flying
    local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoid = character:FindFirstChildOfClass("Humanoid")

    if flying then
        humanoid.PlatformStand = true
        character.PrimaryPart.Anchored = true
    else
        humanoid.PlatformStand = false
        character.PrimaryPart.Anchored = false
    end
end

-- Noclip function
local noclip = false
local function toggleNoclip()
    noclip = not noclip
    local character = game.Players.LocalPlayer.Character

    if noclip then
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    else
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

-- Fling function
local function fling()
    local player = game.Players.LocalPlayer
    local character = player.Character

    local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
    bodyAngularVelocity.Parent = character.PrimaryPart
    bodyAngularVelocity.AngularVelocity = Vector3.new(0, math.rad(1000), 0)
    bodyAngularVelocity.MaxTorque = Vector3.new(100000, 100000, 100000)

    wait(0.1)
    bodyAngularVelocity:Destroy()
end

-- Button actions
Buttons[1].MouseButton1Click:Connect(applyESP)
Buttons[2].MouseButton1Click:Connect(toggleFly)
Buttons[3].MouseButton1Click:Connect(toggleNoclip)
Buttons[4].MouseButton1Click:Connect(fling)

-- Add player added event for ESP
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        createESP(player)
    end)
end)
