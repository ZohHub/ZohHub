-- Eternal Darkness: RendoZXZ Edition
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

local ADMIN_NAME = "RendoZXZ"
local DARK_FOG_COLOR = Color3.new(0, 0, 0)
local NORMAL_FOG_COLOR = Color3.new(1, 1, 1)
local darknessEnabled = false

-- Create RemoteEvent
local toggleEvent = Instance.new("RemoteEvent")
toggleEvent.Name = "ToggleDarkness"
toggleEvent.Parent = game.ReplicatedStorage

-- Message to display
local epicMessage = [[
lightness, through darkness. I come through. through out the right, and wrong.
領域は拡大し、誰もが死に、誰もが生きてきた。
天国と地獄を通り抜け、領域の拡大、永遠の闇、そして虚ろな光。
]]

-- Function to apply lighting
local function setDarknessMode(enabled)
	darknessEnabled = enabled
	if enabled then
		Lighting.ClockTime = 0
		Lighting.Brightness = 0
		Lighting.FogColor = DARK_FOG_COLOR
		Lighting.FogStart = 0
		Lighting.FogEnd = 100
		Lighting.OutdoorAmbient = Color3.new(0, 0, 0)
	else
		Lighting.ClockTime = 14
		Lighting.Brightness = 2
		Lighting.FogColor = NORMAL_FOG_COLOR
		Lighting.FogStart = 100
		Lighting.FogEnd = 100000
		Lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
	end
end

-- Handle darkness toggle and message
toggleEvent.OnServerEvent:Connect(function(player, enabled)
	if player.Name == ADMIN_NAME then
		setDarknessMode(enabled)

		-- Broadcast mystical message
		for _, plr in pairs(Players:GetPlayers()) do
			plr:LoadCharacter()
			local message = Instance.new("Message")
			message.Text = epicMessage
			message.Parent = plr:WaitForChild("PlayerGui")
			game:GetService("Debris"):AddItem(message, 8)
		end

		-- Billboard message over admin’s head
		local char = player.Character
		if char and char:FindFirstChild("Head") then
			local billboard = Instance.new("BillboardGui")
			billboard.Size = UDim2.new(5, 0, 2, 0)
			billboard.Adornee = char.Head
			billboard.StudsOffset = Vector3.new(0, 2.5, 0)
			billboard.AlwaysOnTop = true
			billboard.Parent = char

			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(1, 0, 1, 0)
			label.BackgroundTransparency = 1
			label.TextColor3 = Color3.fromRGB(255, 255, 255)
			label.TextScaled = true
			label.Font = Enum.Font.Fantasy
			label.Text = epicMessage
			label.Parent = billboard

			game:GetService("Debris"):AddItem(billboard, 10)
		end
	end
end)

-- GUI Setup for new players
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Wait()

	local playerGui = player:WaitForChild("PlayerGui")
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "DarknessGUI"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = playerGui

	if player.Name == ADMIN_NAME then
		local button = Instance.new("TextButton")
		button.Size = UDim2.new(0, 250, 0, 60)
		button.Position = UDim2.new(0, 20, 0, 20)
		button.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
		button.TextColor3 = Color3.fromRGB(255, 255, 255)
		button.Text = "Toggle Eternal Darkness"
		button.Font = Enum.Font.GothamBold
		button.TextScaled = true
		button.Parent = screenGui

		local localScript = Instance.new("LocalScript")
		localScript.Parent = button
		localScript.Source = [[
			local button = script.Parent
			local replicatedStorage = game:GetService("ReplicatedStorage")
			local toggleEvent = replicatedStorage:WaitForChild("ToggleDarkness")
			local isDark = false

			button.MouseButton1Click:Connect(function()
				isDark = not isDark
				toggleEvent:FireServer(isDark)
				button.Text = isDark and "Disable Darkness" or "Enable Darkness"
			end)
		]]
	end

	if darknessEnabled then
		setDarknessMode(true)
	end
end)
