local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ลบ GUI เก่าถ้ามีอยู่
if CoreGui:FindFirstChild("MultiToolUI") then
    CoreGui.MultiToolUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MultiToolUI"
ScreenGui.ResetOnSpawn = false

if gethui then
    ScreenGui.Parent = gethui()
else
    ScreenGui.Parent = CoreGui
end

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 280, 0, 220)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Top Bar (สำหรับลาก GUI)
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 10)
TopBarCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "Auto Clicker & Speed System"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 12
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

-- ==================== Auto Clicker UI ====================
local ToggleClickBtn = Instance.new("TextButton")
ToggleClickBtn.Size = UDim2.new(1, -20, 0, 38)
ToggleClickBtn.Position = UDim2.new(0, 10, 0, 45)
ToggleClickBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
ToggleClickBtn.Text = "Auto Click: OFF (กด Q)"
ToggleClickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleClickBtn.Font = Enum.Font.GothamBold
ToggleClickBtn.TextSize = 13
ToggleClickBtn.Parent = MainFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleClickBtn

-- ==================== Speed Hack UI ====================
local SpeedFrame = Instance.new("Frame")
SpeedFrame.Size = UDim2.new(1, -20, 0, 115)
SpeedFrame.Position = UDim2.new(0, 10, 0, 92)
SpeedFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
SpeedFrame.BorderSizePixel = 0
SpeedFrame.Parent = MainFrame

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 8)
SpeedCorner.Parent = SpeedFrame

local ToggleSpeedBtn = Instance.new("TextButton")
ToggleSpeedBtn.Size = UDim2.new(1, -20, 0, 35)
ToggleSpeedBtn.Position = UDim2.new(0, 10, 0, 10)
ToggleSpeedBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
ToggleSpeedBtn.Text = "วิ่งเร็ว: OFF"
ToggleSpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleSpeedBtn.Font = Enum.Font.GothamBold
ToggleSpeedBtn.TextSize = 13
ToggleSpeedBtn.Parent = SpeedFrame

local SpeedToggleCorner = Instance.new("UICorner")
SpeedToggleCorner.CornerRadius = UDim.new(0, 6)
SpeedToggleCorner.Parent = ToggleSpeedBtn

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, -20, 0, 20)
SpeedLabel.Position = UDim2.new(0, 10, 0, 50)
SpeedLabel.Text = "ความเร็วที่ต้องการ (ค่าเริ่มต้น: 16)"
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
SpeedLabel.TextSize = 11
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Parent = SpeedFrame

local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(1, -20, 0, 30)
SpeedInput.Position = UDim2.new(0, 10, 0, 72)
SpeedInput.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
SpeedInput.Text = "50"
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.Font = Enum.Font.GothamBold
SpeedInput.TextSize = 14
SpeedInput.PlaceholderText = "กรอกความเร็ว..."
SpeedInput.Parent = SpeedFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 6)
InputCorner.Parent = SpeedInput

-- ==================== ระบบ Drag UI ====================
local dragging, dragInput, dragStart, startPos

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- ==================== ระบบ Auto Clicker Logic ====================
local autoClickEnabled = false

local function toggleAutoClick()
    autoClickEnabled = not autoClickEnabled
    if autoClickEnabled then
        ToggleClickBtn.Text = "Auto Click: ON (กด Q)"
        ToggleClickBtn.BackgroundColor3 = Color3.fromRGB(40, 170, 90)
    else
        ToggleClickBtn.Text = "Auto Click: OFF (กด Q)"
        ToggleClickBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    end
end

ToggleClickBtn.MouseButton1Click:Connect(toggleAutoClick)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Q then
        toggleAutoClick()
    end
end)

task.spawn(function()
    while true do
        if autoClickEnabled then
            local VirtualInputManager = game:GetService("VirtualInputManager")
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
        end
        task.wait(0.01)
    end
end)

-- ==================== ระบบ Speed Hack Logic ====================
local speedEnabled = false
local walkSpeedValue = 50

local function toggleSpeed()
    speedEnabled = not speedEnabled
    if speedEnabled then
        ToggleSpeedBtn.Text = "วิ่งเร็ว: ON"
        ToggleSpeedBtn.BackgroundColor3 = Color3.fromRGB(40, 170, 90)
    else
        ToggleSpeedBtn.Text = "วิ่งเร็ว: OFF"
        ToggleSpeedBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        
        -- คืนค่าความเร็วปกติ (16)
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 16
        end
    end
end

ToggleSpeedBtn.MouseButton1Click:Connect(toggleSpeed)

SpeedInput.FocusLost:Connect(function()
    local num = tonumber(SpeedInput.Text)
    if num then
        walkSpeedValue = num
    else
        SpeedInput.Text = tostring(walkSpeedValue)
    end
end)

-- ลูปการล็อกความเร็ว (ป้องกันเกมรีเซ็ต WalkSpeed กลับ)
RunService.Stepped:Connect(function()
    if speedEnabled then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = walkSpeedValue
        end
    end
end)

-- ปุ่มปิด
CloseBtn.MouseButton1Click:Connect(function()
    autoClickEnabled = false
    speedEnabled = false
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = 16
    end
    ScreenGui:Destroy()
end)
