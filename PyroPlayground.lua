-- Create the GUI
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

-- Music Control Elements
local MusicBar = Instance.new("Frame")
local PlayPauseButton = Instance.new("TextButton")
local StopButton = Instance.new("TextButton")
local VolumeBar = Instance.new("Slider")
local MuteButton = Instance.new("TextButton")
local SoundIdBox = Instance.new("TextBox")
local TrackTitleLabel = Instance.new("TextLabel")
local ProgressBar = Instance.new("Frame")
local PlaylistNextButton = Instance.new("TextButton")
local PlaylistPrevButton = Instance.new("TextButton")
local Sound = Instance.new("Sound")

-- Pyro Playground Elements
local InfiniteMoneyButton = Instance.new("TextButton")
local Fireworks10XButton = Instance.new("TextButton")
local BlackMarketButton = Instance.new("TextButton")
local InfiniteSpinsButton = Instance.new("TextButton")
local FreeRobuxFireworksButton = Instance.new("TextButton")

-- Playlist and Track Info
local Playlist = {}
local CurrentTrackIndex = 1
local IsPlaying = false
local VolumeLevel = 0.5
local IsMuted = false

ScreenGui.Parent = game:GetService("CoreGui")

-- Main UI Styling
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 420, 0, 600)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -300)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

-- Title Bar
TitleBar.Parent = MainFrame
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

-- Minimize, Fullscreen, Close Buttons
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

-- Music Bar
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
VolumeBar.Value = VolumeLevel
VolumeBar.BackgroundTransparency = 0.5
VolumeBar.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

-- Mute Button
MuteButton.Parent = MusicBar
MuteButton.Size = UDim2.new(0, 40, 0, 50)
MuteButton.Position = UDim2.new(0, 390, 0, 0)
MuteButton.Text = "Mute"
MuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MuteButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MuteButton.Font = Enum.Font.SourceSansBold
MuteButton.TextSize = 18
MuteButton.AutoButtonColor = true

-- SoundId TextBox (for user input)
SoundIdBox.Parent = MusicBar
SoundIdBox.Size = UDim2.new(0, 200, 0, 30)
SoundIdBox.Position = UDim2.new(0, 0, 0, 10)
SoundIdBox.PlaceholderText = "Enter Sound ID"
SoundIdBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SoundIdBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SoundIdBox.Font = Enum.Font.SourceSans
SoundIdBox.TextSize = 16
SoundIdBox.ClearTextOnFocus = true

-- Track Info Display
TrackTitleLabel.Parent = MusicBar
TrackTitleLabel.Size = UDim2.new(0, 200, 0, 30)
TrackTitleLabel.Position = UDim2.new(0, 0, 0, 40)
TrackTitleLabel.Text = "No Track Playing"
TrackTitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TrackTitleLabel.BackgroundTransparency = 1
TrackTitleLabel.Font = Enum.Font.SourceSans
TrackTitleLabel.TextSize = 14

-- Playlist Navigation Buttons
PlaylistPrevButton.Parent = MusicBar
PlaylistPrevButton.Size = UDim2.new(0, 50, 0, 50)
PlaylistPrevButton.Position = UDim2.new(0, 50, 0, 0)
PlaylistPrevButton.Text = "<<"
PlaylistPrevButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PlaylistPrevButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
PlaylistPrevButton.Font = Enum.Font.SourceSansBold
PlaylistPrevButton.TextSize = 18

PlaylistNextButton.Parent = MusicBar
PlaylistNextButton.Size = UDim2.new(0, 50, 0, 50)
PlaylistNextButton.Position = UDim2.new(0, 330, 0, 0)
PlaylistNextButton.Text = ">>"
PlaylistNextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PlaylistNextButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
PlaylistNextButton.Font = Enum.Font.SourceSansBold
PlaylistNextButton.TextSize = 18

-- Pyro Playground Features
InfiniteMoneyButton.Parent = MainFrame
InfiniteMoneyButton.Size = UDim2.new(0, 400, 0, 50)
InfiniteMoneyButton.Position = UDim2.new(0, 10, 0, 70)
InfiniteMoneyButton.Text = "Infinite Money"
InfiniteMoneyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
InfiniteMoneyButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
InfiniteMoneyButton.Font = Enum.Font.SourceSansBold
InfiniteMoneyButton.TextSize = 18
InfiniteMoneyButton.AutoButtonColor = true

Fireworks10XButton.Parent = MainFrame
Fireworks10XButton.Size = UDim2.new(0, 400, 0, 50)
Fireworks10XButton.Position = UDim2.new(0, 10, 0, 130)
Fireworks10XButton.Text = "10X Fireworks"
Fireworks10XButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Fireworks10XButton.BackgroundColor3 = Color3.fromRGB(255, 150, 50)
Fireworks10XButton.Font = Enum.Font.SourceSansBold
Fireworks10XButton.TextSize = 18
Fireworks10XButton.AutoButtonColor = true

BlackMarketButton.Parent = MainFrame
BlackMarketButton.Size = UDim2.new(0, 400, 0, 50)
BlackMarketButton.Position = UDim2.new(0, 10, 0, 190)
BlackMarketButton.Text = "Black Market Free"
BlackMarketButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BlackMarketButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
BlackMarketButton.Font = Enum.Font.SourceSansBold
BlackMarketButton.TextSize = 18
BlackMarketButton.AutoButtonColor = true

InfiniteSpinsButton.Parent = MainFrame
InfiniteSpinsButton.Size = UDim2.new(0, 400, 0, 50)
InfiniteSpinsButton.Position = UDim2.new(0, 10, 0, 250)
InfiniteSpinsButton.Text = "Infinite Spins"
InfiniteSpinsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
InfiniteSpinsButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
InfiniteSpinsButton.Font = Enum.Font.SourceSansBold
InfiniteSpinsButton.TextSize = 18
InfiniteSpinsButton.AutoButtonColor = true

FreeRobuxFireworksButton.Parent = MainFrame
FreeRobuxFireworksButton.Size = UDim2.new(0, 400, 0, 50)
FreeRobuxFireworksButton.Position = UDim2.new(0, 10, 0, 310)
FreeRobuxFireworksButton.Text = "Free Robux Fireworks"
FreeRobuxFireworksButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FreeRobuxFireworksButton.BackgroundColor3 = Color3.fromRGB(255, 100, 255)
FreeRobuxFireworksButton.Font = Enum.Font.SourceSansBold
FreeRobuxFireworksButton.TextSize = 18
FreeRobuxFireworksButton.AutoButtonColor = true

-- Handle Buttons Functionality
InfiniteMoneyButton.MouseButton1Click:Connect(function()
    -- Add Infinite Money Logic
end)

Fireworks10XButton.MouseButton1Click:Connect(function()
    -- Add 10X Fireworks Logic
end)

BlackMarketButton.MouseButton1Click:Connect(function()
    -- Add Black Market Free Logic
end)

InfiniteSpinsButton.MouseButton1Click:Connect(function()
    -- Add Infinite Spins Logic
end)

FreeRobuxFireworksButton.MouseButton1Click:Connect(function()
    -- Add Free Robux Fireworks Logic
end)

-- Music Play/Pause Button Logic
PlayPauseButton.MouseButton1Click:Connect(function()
    if not IsPlaying then
        Sound.SoundId = "rbxassetid://" .. SoundIdBox.Text
        Sound:Play()
        IsPlaying = true
        PlayPauseButton.Text = "Pause"
        TrackTitleLabel.Text = "Now Playing: " .. SoundIdBox.Text
    else
        Sound:Pause()
        IsPlaying = false
        PlayPauseButton.Text = "Play"
    end
end)

-- Stop Button Logic
StopButton.MouseButton1Click:Connect(function()
    Sound:Stop()
    IsPlaying = false
    PlayPauseButton.Text = "Play"
    TrackTitleLabel.Text = "No Track Playing"
end)

-- Mute Button Logic
MuteButton.MouseButton1Click:Connect(function()
    IsMuted = not IsMuted
    Sound.Volume = IsMuted and 0 or VolumeLevel
end)

-- Handle Volume Change
VolumeBar.Changed:Connect(function()
    VolumeLevel = VolumeBar.Value
    if not IsMuted then
        Sound.Volume = VolumeLevel
    end
end)

-- Playlist Navigation (Next/Previous)
PlaylistNextButton.MouseButton1Click:Connect(function()
    -- Handle Playlist Next
end)

PlaylistPrevButton.MouseButton1Click:Connect(function()
    -- Handle Playlist Previous
end)

-- Handle Sound ID Input
SoundIdBox.FocusLost:Connect(function()
    Sound.SoundId = "rbxassetid://" .. SoundIdBox.Text
    Sound:Play()
end)

