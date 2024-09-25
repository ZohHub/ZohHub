local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui for the Kill All Button
local killGui = Instance.new("ScreenGui")
killGui.Name = "KillAllGui"
killGui.Parent = playerGui

-- Create the button for the Kill All functionality
local killAllButton = Instance.new("TextButton")
killAllButton.Text = "Kill All"
killAllButton.Size = UDim2.new(0, 200, 0, 60)
killAllButton.Position = UDim2.new(0.5, -100, 0.8, -30)
killAllButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
killAllButton.TextColor3 = Color3.new(1, 1, 1)
killAllButton.Font = Enum.Font.SourceSansBold
killAllButton.TextSize = 30
killAllButton.Parent = killGui
killAllButton.Active = true
killAllButton.Draggable = true -- Draggable functionality

-- Add shiny effect (UIGradient for a gradient effect)
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(1, 0.4, 0.4)),
    ColorSequenceKeypoint.new(0.5, Color3.new(1, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.new(1, 0.4, 0.4))
}
gradient.Rotation = 45 -- Diagonal gradient for shine effect
gradient.Parent = killAllButton

-- Add corner rounding to the button
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 12)
buttonCorner.Parent = killAllButton

-- Function to kill all players except yourself
local function killAllPlayersExceptMe()
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr ~= player then -- Skip yourself
            if plr.Character then
                local humanoid = plr.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Health = 0 -- Kill the player
                end
            end
        end
    end
end

-- Connect button click to kill all function
killAllButton.MouseButton1Click:Connect(function()
    killAllPlayersExceptMe()
end)

-- Add a smooth highlight effect to the button
local tweenService = game:GetService("TweenService")

local function highlightButton(button)
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true) -- Ping-pong effect
    local goal = {BackgroundColor3 = Color3.fromRGB(255, 100, 100)}
    local tween = tweenService:Create(button, tweenInfo, goal)
    tween:Play()
end

highlightButton(killAllButton)
