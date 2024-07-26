local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Create a function to create the ESP label
local function CreateESPLabel(player)
    local label = Instance.new("TextLabel")
    label.Name = "ESPLabel"
    label.Text = "Enemies"
    label.Size = UDim2.new(0, 100, 0, 20) -- Adjust size as needed
    label.Position = UDim2.new(0, 0, 0, -30) -- Position above the player's head
    label.Parent = player.Character.Head
end

-- Function to handle player added event
local function OnPlayerAdded(player)
    if player ~= LocalPlayer then
        CreateESPLabel(player)
    end
end

-- Initial setup for existing players
for _, player in pairs(Players:GetPlayers()) do
    OnPlayerAdded(player)
end

-- Connect player added event
Players.PlayerAdded:Connect(OnPlayerAdded)
