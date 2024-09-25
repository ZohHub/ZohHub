local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui for the Target System
local targetGui = Instance.new("ScreenGui")
targetGui.Name = "TargetGui"
targetGui.Parent = playerGui

-- Create the main frame for the Target GUI
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = targetGui

-- Add corner rounding
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainFrame

-- Title label for the GUI
local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "Target Control"
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 24
titleLabel.Parent = mainFrame

-- Input box for the target username
local targetInput = Instance.new("TextBox")
targetInput.PlaceholderText = "Enter Username"
targetInput.Size = UDim2.new(0.8, 0, 0, 40)
targetInput.Position = UDim2.new(0.1, 0, 0, 60)
targetInput.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
targetInput.TextColor3 = Color3.new(1, 1, 1)
targetInput.Font = Enum.Font.SourceSans
targetInput.TextSize = 18
targetInput.ClearTextOnFocus = false
targetInput.Parent = mainFrame

-- Function to style buttons
local function createButton(text, posY)
    local button = Instance.new("TextButton")
    button.Text = text
    button.Size = UDim2.new(0.8, 0, 0, 40)
    button.Position = UDim2.new(0.1, 0, 0, posY)
    button.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 18
    button.Parent = mainFrame
    
    -- Add corner rounding
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    return button
end

-- Create Action Buttons
local flingButton = createButton("Fling", 120)
local killButton = createButton("Kill", 170)
local teleportButton = createButton("Teleport to Target", 220)
local viewButton = createButton("View Target", 270)
local resetButton = createButton("Reset Target", 320)

-- Function to find player by username
local function findPlayerByUsername(username)
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if string.lower(plr.Name) == string.lower(username) then
            return plr
        end
    end
    return nil
end

-- Fling Function
flingButton.MouseButton1Click:Connect(function()
    local targetPlayer = findPlayerByUsername(targetInput.Text)
    if targetPlayer and targetPlayer.Character then
        -- Fling the target player by applying a force
        local humanoidRootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.new(1000, 1000, 1000) -- High velocity to fling
            bodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000)
            bodyVelocity.Parent = humanoidRootPart
            
            -- Remove the velocity after a short time
            wait(0.1)
            bodyVelocity:Destroy()
        end
    end
end)

-- Kill Function
killButton.MouseButton1Click:Connect(function()
    local targetPlayer = findPlayerByUsername(targetInput.Text)
    if targetPlayer and targetPlayer.Character then
        -- Kill the target player
        local humanoid = targetPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.Health = 0
        end
    end
end)

-- Teleport Function
teleportButton.MouseButton1Click:Connect(function()
    local targetPlayer = findPlayerByUsername(targetInput.Text)
    if targetPlayer and targetPlayer.Character then
        -- Teleport to the target player
        local targetRootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetRootPart and player.Character then
            player.Character:SetPrimaryPartCFrame(targetRootPart.CFrame + Vector3.new(2, 0, 0)) -- Teleport nearby
        end
    end
end)

-- View Function
viewButton.MouseButton1Click:Connect(function()
    local targetPlayer = findPlayerByUsername(targetInput.Text)
    if targetPlayer and targetPlayer.Character then
        -- Camera focus on the target player
        local camera = workspace.CurrentCamera
        camera.CameraSubject = targetPlayer.Character:FindFirstChild("Humanoid")
    end
end)

-- Reset Target Button (Optional: To Reset Camera or Actions)
resetButton.MouseButton1Click:Connect(function()
    -- Reset camera to the player
    workspace.CurrentCamera.CameraSubject = player.Character:FindFirstChild("Humanoid")
    -- Clear the input
    targetInput.Text = ""
end)
