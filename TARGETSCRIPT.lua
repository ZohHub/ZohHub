-- LocalScript inside StarterPlayerScripts

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- Create the GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Target"
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0, 50, 0, 50)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
titleBar.Parent = frame

local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "Target GUI"
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.Parent = titleBar

-- Draggable Logic
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

local function updateDrag(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

titleBar.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if dragging then
                updateDrag(input)
            end
        end)
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Create the textbox to enter the username
local usernameBox = Instance.new("TextBox")
usernameBox.Size = UDim2.new(1, -20, 0, 40)
usernameBox.Position = UDim2.new(0, 10, 0, 40)
usernameBox.PlaceholderText = "Enter Target Username"
usernameBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
usernameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
usernameBox.ClearTextOnFocus = false
usernameBox.TextSize = 16
usernameBox.Parent = frame

-- Buttons for the actions
local function createActionButton(name, position, action)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 30)
    button.Position = position
    button.Text = name
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 14
    button.Parent = frame

    button.MouseButton1Click:Connect(action)
end

-- Define the action buttons
local function getTargetPlayer()
    local targetName = usernameBox.Text
    return game.Players:FindFirstChild(targetName)
end

-- Teleport to Target
createActionButton("Teleport to Target", UDim2.new(0, 10, 0, 90), function()
    local target = getTargetPlayer()
    if target then
        player.Character:SetPrimaryPartCFrame(target.Character.PrimaryPart.CFrame)
    else
        warn("Player not found!")
    end
end)

-- Teleport Target to Me
createActionButton("Teleport Target to Me", UDim2.new(0, 10, 0, 130), function()
    local target = getTargetPlayer()
    if target then
        target.Character:SetPrimaryPartCFrame(player.Character.PrimaryPart.CFrame)
    else
        warn("Player not found!")
    end
end)

-- Fling Target
createActionButton("Fling Target", UDim2.new(0, 10, 0, 170), function()
    local target = getTargetPlayer()
    if target then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        bodyVelocity.Velocity = Vector3.new(0, 100, 0) -- Fling upwards
        bodyVelocity.Parent = target.Character.PrimaryPart
        wait(0.1)
        bodyVelocity:Destroy()
    else
        warn("Player not found!")
    end
end)

-- Kill Target
createActionButton("Kill Target", UDim2.new(0, 10, 0, 210), function()
    local target = getTargetPlayer()
    if target then
        target:LoadCharacter() -- Respawns the target player, effectively killing them
    else
        warn("Player not found!")
    end
end)

-- View Target
createActionButton("View Target", UDim2.new(0, 10, 0, 250), function()
    local target = getTargetPlayer()
    if target then
        player.CameraMode = Enum.CameraMode.Locked
        player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
    else
        warn("Player not found!")
    end
end)

-- Minimize button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 40, 0, 30)
minimizeButton.Position = UDim2.new(1, -40, 0, 0)
minimizeButton.Text = "-"
minimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.TextSize = 18
minimizeButton.Parent = titleBar

minimizeButton.MouseButton1Click:Connect(function()
    if frame.Size == UDim2.new(0, 300, 0, 400) then
        frame.Size = UDim2.new(0, 300, 0, 40) -- Minimized size
    else
        frame.Size = UDim2.new(0, 300, 0, 400) -- Original size
    end
end)
