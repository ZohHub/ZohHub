local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Tabs = Instance.new("Frame")
local HomeButton = Instance.new("TextButton")
local OtherButton = Instance.new("TextButton")
local AboutButton = Instance.new("TextButton")
local HomeSection = Instance.new("Frame")
local OtherSection = Instance.new("Frame")
local AboutSection = Instance.new("Frame")

local TitleBar = Instance.new("Frame")
local MinimizeButton = Instance.new("TextButton")
local FullscreenButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")

-- Parent UI
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
Frame.Parent = ScreenGui
Tabs.Parent = Frame
HomeButton.Parent = Tabs
OtherButton.Parent = Tabs
AboutButton.Parent = Tabs
HomeSection.Parent = Frame
OtherSection.Parent = Frame
AboutSection.Parent = Frame
TitleBar.Parent = Frame
MinimizeButton.Parent = TitleBar
FullscreenButton.Parent = TitleBar
CloseButton.Parent = TitleBar

-- UI Properties
Frame.Size = UDim2.new(0, 400, 0, 300)
Frame.Position = UDim2.new(0.5, -200, 0.5, -150)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 2
Frame.Active = true
Frame.Draggable = true

Tabs.Size = UDim2.new(0, 400, 0, 50)
Tabs.Position = UDim2.new(0, 0, 0, 30)
Tabs.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

TitleBar.Size = UDim2.new(0, 400, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

-- Title Bar Buttons
local function createTitleButton(button, text, pos)
    button.Size = UDim2.new(0, 30, 0, 30)
    button.Position = pos
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
end

createTitleButton(MinimizeButton, "_", UDim2.new(0, 310, 0, 0))
createTitleButton(FullscreenButton, "[ ]", UDim2.new(0, 340, 0, 0))
createTitleButton(CloseButton, "X", UDim2.new(0, 370, 0, 0))

-- Button Functions
local isMinimized = false
local isFullscreen = false
local originalSize = Frame.Size
local originalPosition = Frame.Position

MinimizeButton.MouseButton1Click:Connect(function()
    if isMinimized then
        Frame.Size = originalSize
    else
        Frame.Size = UDim2.new(0, 400, 0, 30)
    end
    isMinimized = not isMinimized
end)

FullscreenButton.MouseButton1Click:Connect(function()
    if isFullscreen then
        Frame.Size = originalSize
        Frame.Position = originalPosition
    else
        Frame.Size = UDim2.new(1, 0, 1, 0)
        Frame.Position = UDim2.new(0, 0, 0, 0)
    end
    isFullscreen = not isFullscreen
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Tab Buttons
local function createTabButton(button, name, pos, section)
    button.Size = UDim2.new(0, 130, 0, 50)
    button.Position = pos
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.MouseButton1Click:Connect(function()
        HomeSection.Visible = false
        OtherSection.Visible = false
        AboutSection.Visible = false
        section.Visible = true
    end)
end

createTabButton(HomeButton, "Home", UDim2.new(0, 0, 0, 0), HomeSection)
createTabButton(OtherButton, "Other", UDim2.new(0, 135, 0, 0), OtherSection)
createTabButton(AboutButton, "About Us", UDim2.new(0, 270, 0, 0), AboutSection)

-- Sections
local function createSection(section)
    section.Size = UDim2.new(0, 400, 0, 250)
    section.Position = UDim2.new(0, 0, 0, 80)
    section.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    section.Visible = false
end

createSection(HomeSection)
createSection(OtherSection)
createSection(AboutSection)
HomeSection.Visible = true

-- Toggle Button Function
local function createToggle(parent, name, pos, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 350, 0, 40)
    button.Position = pos
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Text = name .. " (OFF)"
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = parent
    
    local toggled = false
    button.MouseButton1Click:Connect(function()
        toggled = not toggled
        button.Text = name .. (toggled and " (ON)" or " (OFF)")
        callback(toggled)
    end)
end

-- Home Toggles
createToggle(HomeSection, "Infinite Money", UDim2.new(0, 25, 0, 10), function(state)
    if state then
        game:GetService("ReplicatedStorage").RemoteEvents.GiveMoney:FireServer(math.huge)
    end
end)

createToggle(HomeSection, "10X Fireworks", UDim2.new(0, 25, 0, 60), function(state)
    if state then
        for _, item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if item:IsA("Tool") then
                item.Amount.Value = item.Amount.Value * 10
            end
        end
    end
end)

createToggle(HomeSection, "Black Market for Free", UDim2.new(0, 25, 0, 110), function(state)
    if state then
        game:GetService("ReplicatedStorage").RemoteEvents.BuyGamepass:FireServer("BlackMarket", true)
    end
end)

createToggle(HomeSection, "Infinite Spins", UDim2.new(0, 25, 0, 160), function(state)
    if state then
        game:GetService("ReplicatedStorage").RemoteEvents.GiveSpins:FireServer(math.huge)
    end
end)

createToggle(HomeSection, "Free Robux Fireworks", UDim2.new(0, 25, 0, 210), function(state)
    if state then
        for _, item in pairs(game:GetService("ReplicatedStorage").RobuxFireworks:GetChildren()) do
            game:GetService("ReplicatedStorage").RemoteEvents.PurchaseFirework:FireServer(item.Name, true)
        end
    end
end)

-- Other Section
local discordLabel = Instance.new("TextLabel")
discordLabel.Size = UDim2.new(0, 350, 0, 50)
discordLabel.Position = UDim2.new(0, 25, 0, 100)
discordLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
discordLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
discordLabel.Text = "Join our Discord: discord.gg/wA7KGd2CPF"
discordLabel.Parent = OtherSection

-- About Us Section
local aboutLabel = Instance.new("TextLabel")
aboutLabel.Size = UDim2.new(0, 350, 0, 200)
aboutLabel.Position = UDim2.new(0, 25, 0, 20)
aboutLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
aboutLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
aboutLabel.TextWrapped = true
aboutLabel.Text = [[Welcome to the Pyro Playground Hack GUI! 
Enjoy and have fun!]]
aboutLabel.Parent = AboutSection
