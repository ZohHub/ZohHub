-- zhub
-- Define UI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Buttons = {}
local teleportBackPosition = nil

-- Set up the ScreenGui
ScreenGui.Name = "zhub"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 220, 0, 400)
MainFrame.Position = UDim2.new(0, 10, 0, 10)
MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainFrame.BorderSizePixel = 0

-- Create buttons
local buttonNames = {"ESP", "Fly", "Noclip", "Fling", "Teleport"}
for i, name in ipairs(buttonNames) do
    local Button = Instance.new("TextButton")
    Button.Parent = MainFrame
    Button.Size = UDim2.new(0, 200, 0, 30)
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

-- Teleport function
local function teleport(position)
    local player = game.Players.LocalPlayer
    local character = player.Character

    if teleportBackPosition == nil then
        teleportBackPosition = character.PrimaryPart.Position
    end

    character:SetPrimaryPartCFrame(CFrame.new(position))

    local notification = Instance.new("ScreenGui", player.PlayerGui)
    local frame = Instance.new("Frame", notification)
    frame.Size = UDim2.new(0, 200, 0, 100)
    frame.Position = UDim2.new(0.5, -100, 1, -120)
    frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    frame.BorderSizePixel = 0

    local text = Instance.new("TextLabel", frame)
    text.Size = UDim2.new(1, 0, 0.6, 0)
    text.Position = UDim2.new(0, 0, 0, 0)
    text.Text = "Teleport back?"
    text.BackgroundTransparency = 1
    text.TextColor3 = Color3.new(1, 1, 1)

    local yesButton = Instance.new("TextButton", frame)
    yesButton.Size = UDim2.new(0.45, 0, 0.4, 0)
    yesButton.Position = UDim2.new(0.05, 0, 0.6, 0)
    yesButton.Text = "Yes"
    yesButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    yesButton.TextColor3 = Color3.new(1, 1, 1)
    yesButton.BorderSizePixel = 0

    local noButton = Instance.new("TextButton", frame)
    noButton.Size = UDim2.new(0.45, 0, 0.4, 0)
    noButton.Position = UDim2.new(0.5, 0, 0.6, 0)
    noButton.Text = "No"
    noButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    noButton.TextColor3 = Color3.new(1, 1, 1)
    noButton.BorderSizePixel = 0

    yesButton.MouseButton1Click:Connect(function()
        character:SetPrimaryPartCFrame(CFrame.new(teleportBackPosition))
        notification:Destroy()
    end)

    noButton.MouseButton1Click:Connect(function()
        notification:Destroy()
    end)
end

local function askTeleport(position)
    local player = game.Players.LocalPlayer
    local confirmation = Instance.new("ScreenGui", player.PlayerGui)
    local frame = Instance.new("Frame", confirmation)
    frame.Size = UDim2.new(0, 200, 0, 100)
    frame.Position = UDim2.new(0.5, -100, 0.5, -50)
    frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    frame.BorderSizePixel = 0

    local text = Instance.new("TextLabel", frame)
    text.Size = UDim2.new(1, 0, 0.6, 0)
    text.Position = UDim2.new(0, 0, 0, 0)
    text.Text = "Would you like to teleport?"
    text.BackgroundTransparency = 1
    text.TextColor3 = Color3.new(1, 1, 1)

    local yesButton = Instance.new("TextButton", frame)
    yesButton.Size = UDim2.new(0.45, 0, 0.4, 0)
    yesButton.Position = UDim2.new(0.05, 0, 0.6, 0)
    yesButton.Text = "Yes"
    yesButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    yesButton.TextColor3 = Color3.new(1, 1, 1)
    yesButton.BorderSizePixel = 0

    local noButton = Instance.new("TextButton", frame)
    noButton.Size = UDim2.new(0.45, 0, 0.4, 0)
    noButton.Position = UDim2.new(0.5, 0, 0.6, 0)
    noButton.Text = "No"
    noButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    noButton.TextColor3 = Color3.new(1, 1, 1)
    noButton.BorderSizePixel = 0

    yesButton.MouseButton1Click:Connect(function()
        teleport(position)
        confirmation:Destroy()
    end)

    noButton.MouseButton1Click:Connect(function()
        confirmation:Destroy()
    end)
end

-- Add teleport functionality
local function addTeleportFunctionality()
    local player = game.Players.LocalPlayer
    local mouse = player:GetMouse()

    mouse.Button1Down:Connect(function()
        if mouse.Target then
            local position = mouse.Hit.p
            askTeleport(position)
        end
    end)
end
