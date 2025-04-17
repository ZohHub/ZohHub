-- Mimic Super Script Full Version by RendoZXZ

local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local uis = game:GetService("UserInputService")
local runService = game:GetService("RunService")

-- GUI
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "MimicSuperGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 340, 0, 580)
frame.Position = UDim2.new(0.5, -170, 0.5, -290)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local layout = Instance.new("UIListLayout", frame)
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder

local function createButton(txt, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Position = UDim2.new(0, 5, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.Text = txt
    btn.BorderSizePixel = 0
    btn.MouseButton1Click:Connect(callback)
end

-- Flying system
local flying = false
local function flyFunc()
    local bp = Instance.new("BodyPosition", hrp)
    local bg = Instance.new("BodyGyro", hrp)
    bp.P = 9e4
    bp.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    bg.P = 9e4

    runService.Heartbeat:Connect(function()
        if flying then
            local move = Vector3.zero
            if uis:IsKeyDown(Enum.KeyCode.W) then move += workspace.CurrentCamera.CFrame.LookVector end
            if uis:IsKeyDown(Enum.KeyCode.S) then move -= workspace.CurrentCamera.CFrame.LookVector end
            if uis:IsKeyDown(Enum.KeyCode.A) then move -= workspace.CurrentCamera.CFrame.RightVector end
            if uis:IsKeyDown(Enum.KeyCode.D) then move += workspace.CurrentCamera.CFrame.RightVector end
            bp.Position = hrp.Position + move * 3
            bg.CFrame = workspace.CurrentCamera.CFrame
        else
            bp:Destroy()
            bg:Destroy()
        end
    end)
end

-- ESP
local function createESP(part, color)
    if not part or part:FindFirstChild("Highlight") then return end
    local h = Instance.new("Highlight", part)
    h.FillColor = color
    h.OutlineColor = Color3.new(1, 1, 1)
    h.FillTransparency = 0.5
end

local function espSpecialTargets()
    local targets = {
        { name = "rat", color = Color3.fromRGB(255, 255, 0) },
        { name = "exit", color = Color3.fromRGB(0, 255, 0) },
        { name = "rin", color = Color3.fromRGB(255, 0, 150) },
        { name = "snake", color = Color3.fromRGB(0, 200, 255) },
        { name = "minka", color = Color3.fromRGB(255, 100, 0) },
        { name = "office", color = Color3.fromRGB(180, 180, 255) },
        { name = "devil", color = Color3.fromRGB(200, 0, 255) },
    }

    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Model") then
            for _, t in pairs(targets) do
                if v.Name:lower():find(t.name) then
                    createESP(v, t.color)
                end
            end
        end
    end
end

-- Auto Win
local function autoWin()
    local names = { "office", "minka", "rat", "feed", "exit", "rin", "snake", "nagisa", "devil" }
    for _, name in pairs(names) do
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name:lower():find(name) then
                hrp.CFrame = obj.CFrame + Vector3.new(0, 5, 0)
                wait(1)
            end
        end
    end
end

-- Fun: Chat Spoof
local function spoofMessage()
    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Rin is watching you...", "All")
end

-- FullBright
local function fullBright()
    game.Lighting.Brightness = 5
    game.Lighting.FogEnd = 1e9
end

-- God Mode
local function godMode()
    char.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
        char.Humanoid.Health = 100
    end)
end

-- Buttons
createButton("Toggle Fly (F)", function() flying = not flying if flying then flyFunc() end end)
createButton("ESP All Targets", espSpecialTargets)
createButton("Auto Win The Mimic", autoWin)
createButton("God Mode", godMode)
createButton("Fullbright", fullBright)
createButton("Spoof Monster Message", spoofMessage)

-- Fly Keybind
uis.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F then
        flying = not flying
        if flying then flyFunc() end
    end
end)
