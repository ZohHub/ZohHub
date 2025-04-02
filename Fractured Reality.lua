-- T1HS SCR1PT W4S M4D3 3Y Z0H, 4ND TH1S 1S MY G4M3 1M M4K1NG.

local player = game.Players.LocalPlayer
local gui = player.PlayerGui:WaitForChild("CheatMenu")

-- Buttons
local infiniteMoneyButton = gui:WaitForChild("InfiniteMoneyButton")
local doubleTimeButton = gui:WaitForChild("DoubleTimeButton")
local jumpscareButton = gui:WaitForChild("JumpscareButton")
local doubleSpeedButton = gui:WaitForChild("DoubleSpeedButton")
local doubleMoneyButton = gui:WaitForChild("DoubleMoneyButton")
local speedSlider = gui:WaitForChild("SpeedSlider")
local speedLabel = gui:WaitForChild("SpeedLabel")
local flyButton = gui:WaitForChild("FlyButton")
local godModeButton = gui:WaitForChild("GodModeButton")
local teleportButton = gui:WaitForChild("TeleportButton")
local spawnVehicleButton = gui:WaitForChild("SpawnVehicleButton")
local nightVisionButton = gui:WaitForChild("NightVisionButton")
local freezeAllButton = gui:WaitForChild("FreezeAllButton")
local earthquakeButton = gui:WaitForChild("EarthquakeButton")
local superJumpButton = gui:WaitForChild("SuperJumpButton")
local randomLocationButton = gui:WaitForChild("RandomLocationButton")
local timeOfDayButton = gui:WaitForChild("TimeOfDayButton")
local speedBoostButton = gui:WaitForChild("SpeedBoostButton")
local invisibilityButton = gui:WaitForChild("InvisibilityButton")
local nukeButton = gui:WaitForChild("NukeButton")
local invincibilityShieldButton = gui:WaitForChild("InvincibilityShieldButton")
local weatherControlButton = gui:WaitForChild("WeatherControlButton")
local superPowerButton = gui:WaitForChild("SuperPowerButton")
local explosionButton = gui:WaitForChild("ExplosionButton")
local teleportToPlayerButton = gui:WaitForChild("TeleportToPlayerButton")
local flingPlayerButton = gui:WaitForChild("FlingPlayerButton")
local gravityControlButton = gui:WaitForChild("GravityControlButton")
local invisibleWallsButton = gui:WaitForChild("InvisibleWallsButton")
local soundEffectButton = gui:WaitForChild("SoundEffectButton")
local timeControlButton = gui:WaitForChild("TimeControlButton")
local objectManipulationButton = gui:WaitForChild("ObjectManipulationButton")
local endlessAmmoButton = gui:WaitForChild("EndlessAmmoButton")
local randomEventButton = gui:WaitForChild("RandomEventButton")
local invisibleModeButton = gui:WaitForChild("InvisibleModeButton")
local teleportRandomPlayerButton = gui:WaitForChild("TeleportRandomPlayerButton")
local nightModeButton = gui:WaitForChild("NightModeButton")
local energyBoostButton = gui:WaitForChild("EnergyBoostButton")

-- Infinite Money
infiniteMoneyButton.MouseButton1Click:Connect(function()
    -- Infinite money functionality here
end)

-- Double Time
doubleTimeButton.MouseButton1Click:Connect(function()
    -- Double time functionality here
end)

-- Jumpscare
jumpscareButton.MouseButton1Click:Connect(function()
    game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer("Jumpscare!", "All")
    local jumpscareSound = Instance.new("Sound", player.Character)
    jumpscareSound.SoundId = "rbxassetid://6754147732"
    jumpscareSound:Play()
end)

-- Double Speed
doubleSpeedButton.MouseButton1Click:Connect(function()
    -- Double speed functionality here
end)

-- Double Money
doubleMoneyButton.MouseButton1Click:Connect(function()
    -- Double money functionality here
end)

-- Speed Slider
speedSlider.Changed:Connect(function()
    local speed = speedSlider.Value
    speedLabel.Text = "Speed: " .. speed
    player.Character.Humanoid.WalkSpeed = speed
end)

-- Fly Button
flyButton.MouseButton1Click:Connect(function()
    -- Fly functionality here
end)

-- God Mode
godModeButton.MouseButton1Click:Connect(function()
    -- God mode functionality here
end)

-- Invincibility Shield
invincibilityShieldButton.MouseButton1Click:Connect(function()
    local shield = Instance.new("Part")
    shield.Shape = Enum.PartType.Ball
    shield.Size = Vector3.new(10, 10, 10)
    shield.Anchored = true
    shield.CanCollide = false
    shield.Position = player.Character.HumanoidRootPart.Position
    shield.Color = Color3.fromRGB(0, 255, 255)
    shield.Parent = workspace
    shield:SetNetworkOwner(nil)
    wait(10)
    shield:Destroy()
end)

-- Weather Control
weatherControlButton.MouseButton1Click:Connect(function()
    local rain = Instance.new("ParticleEmitter")
    rain.Parent = workspace.Terrain
    rain.Texture = "rbxassetid://241394680"
    rain.Rate = 500
    rain.Size = NumberSequence.new(0.5, 1)
    rain.Speed = NumberRange.new(10, 15)

    local sky = Instance.new("Sky")
    sky.SkyboxBk = "rbxassetid://1234567890"
    sky.SkyboxDn = "rbxassetid://1234567890"
    sky.SkyboxFt = "rbxassetid://1234567890"
    sky.SkyboxLf = "rbxassetid://1234567890"
    sky.SkyboxRt = "rbxassetid://1234567890"
    sky.SkyboxUp = "rbxassetid://1234567890"
    sky.Parent = game.Lighting
end)

-- Super Power
superPowerButton.MouseButton1Click:Connect(function()
    local humanoid = player.Character:WaitForChild("Humanoid")
    humanoid.Health = humanoid.Health + 1000
    humanoid.WalkSpeed = humanoid.WalkSpeed * 2
    humanoid.JumpPower = humanoid.JumpPower * 2
    print("Super Power activated!")
end)

-- Explosion Button
explosionButton.MouseButton1Click:Connect(function()
    local explosion = Instance.new("Explosion")
    explosion.Position = player.Character.HumanoidRootPart.Position
    explosion.BlastRadius = 50
    explosion.BlastPressure = 10000
    explosion.Parent = workspace
end)

-- Nuke Button
nukeButton.MouseButton1Click:Connect(function()
    -- Nuke functionality here
end)

-- Energy Boost
energyBoostButton.MouseButton1Click:Connect(function()
    local humanoid = player.Character:WaitForChild("Humanoid")
    humanoid.Health = humanoid.Health + 500
    humanoid.WalkSpeed = humanoid.WalkSpeed + 10
    humanoid.JumpPower = humanoid.JumpPower + 10
end)

-- Teleport to Random Location
randomLocationButton.MouseButton1Click:Connect(function()
    local randomPos = Vector3.new(math.random(-1000, 1000), 50, math.random(-1000, 1000))
    player.Character:SetPrimaryPartCFrame(CFrame.new(randomPos))
end)

-- Random Event Trigger
randomEventButton.MouseButton1Click:Connect(function()
    -- Random event code here (could trigger a flood, meteor shower, etc.)
end)

-- Invisible Mode
invisibleModeButton.MouseButton1Click:Connect(function()
    player.Character.HumanoidRootPart.Transparency = 1
    player.Character.HumanoidRootPart.CanCollide = false
end)

-- Teleport to Random Player
teleportRandomPlayerButton.MouseButton1Click:Connect(function()
    local players = game.Players:GetChildren()
    local randomPlayer = players[math.random(1, #players)]
    if randomPlayer.Character then
        player.Character:SetPrimaryPartCFrame(randomPlayer.Character.HumanoidRootPart.CFrame)
    end
end)

-- Time Control
timeControlButton.MouseButton1Click:Connect(function()
    local currentTime = game.Lighting.TimeOfDay
    if currentTime == "12:00:00" then
        game.Lighting.TimeOfDay = "00:00:00"
    else
        game.Lighting.TimeOfDay = "12:00:00"
    end
end)

-- Object Manipulation
objectManipulationButton.MouseButton1Click:Connect(function()
    -- Modify in-game objects (resize, color change, etc.)
end)

-- Endless Ammo
endlessAmmoButton.MouseButton1Click:Connect(function()
    -- Enable unlimited ammo functionality here
end)

-- Night Mode
nightModeButton.MouseButton1Click:Connect(function()
    game.Lighting.TimeOfDay = "00:00:00"
    game.Lighting.Ambient = Color3.fromRGB(0, 0, 0)
end)

-- More cheat buttons can be added below
