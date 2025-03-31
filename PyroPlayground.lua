-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local MinimizeButton = Instance.new("TextButton")
local FullscreenButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")

local Tabs = Instance.new("Frame")
local HomeButton = Instance.new("TextButton")
local OtherButton = Instance.new("TextButton")
local AboutButton = Instance.new("TextButton")

local HomeSection = Instance.new("Frame")
local OtherSection = Instance.new("Frame")
local AboutSection = Instance.new("Frame")

-- Music Bar
local MusicBar = Instance.new("Frame")
local PlayPauseButton = Instance.new("TextButton")
local StopButton = Instance.new("TextButton")
local VolumeBar = Instance.new("Slider")
local SoundIdBox = Instance.new("TextBox")
local Sound = Instance.new("Sound")

ScreenGui.Parent = game:GetService("CoreGui")

-- 🌟 Main UI Styling
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 420, 0, 320)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

-- Title Bar
TitleBar.Parent = MainFrame
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

-- 🎛️ Minimize, Fullscreen, Close Buttons
local function createButton(parent, text, pos, color)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Size = UDim2.new(0, 30, 0, 30)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.Text = text
    btn.AutoButtonColor = true
    return btn
end

MinimizeButton = createButton(TitleBar, "—", UDim2.new(1, -90, 0, 3), Color3.fromRGB(50, 50, 50))
FullscreenButton = createButton(TitleBar, "[ ]", UDim2.new(1, -60, 0, 3), Color3.fromRGB(50, 50, 50))
CloseButton = createButton(TitleBar, "X", UDim2.new(1, -30, 0, 3), Color3.fromRGB(200, 50, 50))

-- 🌌 Starry Background and Aurora Effect
local aurora = Instance.new("Frame")
aurora.Parent = MainFrame
aurora.Size = UDim2.new(1, 0, 1, 0)
aurora.Position = UDim2.new(0, 0, 0, 0)
aurora.BackgroundTransparency = 1
aurora.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

local auroraGradient = Instance.new("UIGradient")
auroraGradient.Parent = aurora
auroraGradient.Color = ColorSequence.new(
    Color3.fromRGB(0, 255, 255), 
    Color3.fromRGB(0, 255, 0), 
    Color3.fromRGB(255, 0, 255)
)
auroraGradient.Rotation = 45
auroraGradient.Offset = Vector2.new(0, 0)

-- 🌠 Create Starry Effect
local function createStar(parent)
    local star = Instance.new("Frame")
    star.Size = UDim2.new(0, math.random(1, 3), 0, math.random(1, 3))
    star.Position = UDim2.new(0, math.random(0, 420), 0, math.random(0, 320))
    star.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    star.BackgroundTransparency = math.random(0, 3) * 0.1
    star.Parent = parent

    -- Animate Star Fading In and Out
    local tweenInfo = TweenInfo.new(math.random(3, 6), Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true)
    local goal = {BackgroundTransparency = 0.5}
    local tween = game:GetService("TweenService"):Create(star, tweenInfo, goal)
    tween:Play()
end

for i = 1, 200 do
    createStar(aurora)
end

-- 📡 Music Control Bar
MusicBar.Parent = MainFrame
MusicBar.Size = UDim2.new(1, 0, 0, 50)
MusicBar.Position = UDim2.new(0, 0, 1, -50)
MusicBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

-- Play/Pause Button
PlayPauseButton.Parent = MusicBar
PlayPauseButton.Size = UDim2.new(0, 80, 0, 50)
PlayPauseButton.Text = "Play"
PlayPauseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayPauseButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
PlayPauseButton.Font = Enum.Font.SourceSansBold
PlayPauseButton.TextSize = 18
PlayPauseButton.AutoButtonColor = true

-- Stop Button
StopButton.Parent = MusicBar
StopButton.Size = UDim2.new(0, 80, 0, 50)
StopButton.Position = UDim2.new(0, 90, 0, 0)
StopButton.Text = "Stop"
StopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
StopButton.Font = Enum.Font.SourceSansBold
StopButton.TextSize = 18
StopButton.AutoButtonColor = true

-- Volume Bar (Slider)
VolumeBar.Parent = MusicBar
VolumeBar.Size = UDim2.new(0, 200, 0, 30)
VolumeBar.Position = UDim2.new(0, 180, 0, 10)
VolumeBar.MinValue = 0
VolumeBar.MaxValue = 1
VolumeBar.Value = 0.5 -- Default volume

-- Sound ID Input Box
SoundIdBox.Parent = MusicBar
SoundIdBox.Size = UDim2.new(0, 250, 0, 30)
SoundIdBox.Position = UDim2.new(0, 400, 0, 10)
SoundIdBox.Text = "Enter Roblox Sound ID"
SoundIdBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SoundIdBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SoundIdBox.Font = Enum.Font.SourceSans
SoundIdBox.TextSize = 14

-- Sound (Placeholder for actual sound)
Sound.Parent = game.Workspace
Sound.Looped = true
Sound.Volume = 0.5

-- Play/Pause Button Functionality
PlayPauseButton.MouseButton1Click:Connect(function()
    if Sound.IsPlaying then
        Sound:Pause()
        PlayPauseButton.Text = "Play"
    else
        Sound:Play()
        PlayPauseButton.Text = "Pause"
    end
end)

-- Stop Button Functionality
StopButton.MouseButton1Click:Connect(function()
    Sound:Stop()
    PlayPauseButton.Text = "Play"
end)

-- Volume Bar Functionality
VolumeBar.Changed:Connect(function()
    Sound.Volume = VolumeBar.Value
end)

-- Sound ID Input Box Functionality
SoundIdBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local soundId = SoundIdBox.Text
        if soundId and soundId ~= "" then
            -- Set the Sound ID and play the sound
            Sound.SoundId = "rbxassetid://" .. soundId
            Sound:Play()
            PlayPauseButton.Text = "Pause"
        end
    end
end)

-- Minimize, Fullscreen, Close Button Functions
MinimizeButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
FullscreenButton.MouseButton1Click:Connect(function() MainFrame.Size = UDim2.new(1, 0, 1, 0) end)
CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
