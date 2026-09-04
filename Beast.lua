--========================================================--
--              DARK HUB | MOBILE + PC (REFINED)
--========================================================--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--========================================================--
--                    CONFIG
--========================================================--

local Config = {
    Title = "PISIT x TATA | Main Hub",

    -- ปรับขนาด UI ให้เล็กกระชับพอดี
    Width = 520,
    Height = 360,

    -- ใส่ Image ID สำหรับโลโก้ปุ่มเปิด/ปิด (ใส่ rbxassetid://... หรือใส่ลิงก์รูปได้)
    -- หากไม่ใส่ จะแสดงเป็นตัวอักษร "P"
    LogoImage = "rbxassetid://6031094678", 

    Scripts = {
        {
            Name = "Steal An Egg Script",
            URL = "https://raw.githubusercontent.com/runsixbox-eng/Beast/refs/heads/main/StealAnEgg.lua"
        },
    }
}

--========================================================--
--                    THEME
--========================================================--

local Theme = {
    Background = Color3.fromRGB(15, 15, 18),
    TopBar     = Color3.fromRGB(22, 22, 26),
    Sidebar    = Color3.fromRGB(18, 18, 22),
    Item       = Color3.fromRGB(26, 26, 32),
    ItemHover  = Color3.fromRGB(36, 36, 45),

    Text       = Color3.fromRGB(240, 240, 245),
    SubText    = Color3.fromRGB(150, 150, 160),

    Accent     = Color3.fromRGB(220, 40, 60),
    Border     = Color3.fromRGB(45, 45, 55)
}

--========================================================--
--                  REMOVE OLD UI
--========================================================--

pcall(function()
    if PlayerGui:FindFirstChild("DarkHub") then
        PlayerGui.DarkHub:Destroy()
    end
end)

--========================================================--
--                    SCREEN GUI
--========================================================--

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DarkHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

--========================================================--
--                 MOBILE SCALE
--========================================================--

local Scale = Instance.new("UIScale")
Scale.Scale = 1
Scale.Parent = ScreenGui

local function UpdateScale()
    local Camera = workspace.CurrentCamera
    if not Camera then return end
    local Viewport = Camera.ViewportSize

    if Viewport.X < 600 then
        Scale.Scale = math.clamp(Viewport.X / 550, 0.65, 0.85)
    else
        Scale.Scale = 1
    end
end

UpdateScale()
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateScale)

--========================================================--
--                  OPEN BUTTON (WITH LOGO & ANIMATED STROKE)
--========================================================--

local OpenButton = Instance.new("TextButton")
OpenButton.Name = "OpenButton"
OpenButton.Size = UDim2.fromOffset(50, 50)
OpenButton.Position = UDim2.new(0, 20, 0.5, -25)
OpenButton.BackgroundColor3 = Theme.Background
OpenButton.Text = Config.LogoImage == "" and "P" or ""
OpenButton.TextColor3 = Theme.Accent
OpenButton.TextSize = 24
OpenButton.Font = Enum.Font.GothamBold
OpenButton.AutoButtonColor = false
OpenButton.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1, 0)
OpenCorner.Parent = OpenButton

-- ใส่โลโก้รูปภาพบนปุ่ม
if Config.LogoImage ~= "" then
    local LogoImg = Instance.new("ImageLabel")
    LogoImg.Name = "LogoIcon"
    LogoImg.Size = UDim2.new(0.65, 0, 0.65, 0)
    LogoImg.Position = UDim2.new(0.175, 0, 0.175, 0)
    LogoImg.BackgroundTransparency = 1
    LogoImg.Image = Config.LogoImage
    LogoImg.Parent = OpenButton
end

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Thickness = 2
OpenStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
OpenStroke.Parent = OpenButton

local OpenGradient = Instance.new("UIGradient")
OpenGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 75)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 75))
})
OpenGradient.Parent = OpenStroke

--========================================================--
--                    MAIN WINDOW
--========================================================--

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(Config.Width, Config.Height)
Main.Position = UDim2.new(0.5, -Config.Width/2, 0.5, -Config.Height/2)
Main.BackgroundColor3 = Theme.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

-- ขอบ UI ไฟวิ่ง (Animated Rainbow Gradient Stroke)
local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Parent = Main

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 30, 80)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(160, 30, 255)),
    ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 200, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 30, 80))
})
MainGradient.Parent = MainStroke

-- Loop หมุน Gradient สร้างเอฟเฟกต์ไฟวิ่ง
RunService.RenderStepped:Connect(function()
    MainGradient.Rotation = (MainGradient.Rotation + 1.5) % 360
    OpenGradient.Rotation = (OpenGradient.Rotation + 2) % 360
end)

--========================================================--
--                     TOP BAR
--========================================================--

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Theme.TopBar
TopBar.BorderSizePixel = 0
TopBar.Parent = Main

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 12)
TopCorner.Parent = TopBar

local TopCover = Instance.new("Frame")
TopCover.Size = UDim2.new(1, 0, 0, 10)
TopCover.Position = UDim2.new(0, 0, 1, -10)
TopCover.BackgroundColor3 = Theme.TopBar
TopCover.BorderSizePixel = 0
TopCover.Parent = TopBar

--========================================================--
--                      TITLE
--========================================================--

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -90, 1, 0)
Title.Position = UDim2.fromOffset(15, 0)
Title.BackgroundTransparency = 1
Title.Text = Config.Title
Title.TextColor3 = Theme.Text
Title.TextSize = 15
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

--========================================================--
--                  MINIMIZE & CLOSE
--========================================================--

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(30, 28)
Minimize.Position = UDim2.new(1, -68, 0, 8)
Minimize.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
Minimize.Text = "-"
Minimize.TextColor3 = Theme.Text
Minimize.TextSize = 16
Minimize.Font = Enum.Font.GothamBold
Minimize.AutoButtonColor = false
Minimize.Parent = TopBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = Minimize

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(30, 28)
Close.Position = UDim2.new(1, -34, 0, 8)
Close.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
Close.Text = "×"
Close.TextColor3 = Theme.Text
Close.TextSize = 18
Close.Font = Enum.Font.GothamBold
Close.AutoButtonColor = false
Close.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = Close

--========================================================--
--                       SIDEBAR
--========================================================--

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 130, 1, -45)
Sidebar.Position = UDim2.new(0, 0, 0, 45)
Sidebar.BackgroundColor3 = Theme.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local SidebarLine = Instance.new("Frame")
SidebarLine.Size = UDim2.new(0, 1, 1, 0)
SidebarLine.Position = UDim2.new(1, -1, 0, 0)
SidebarLine.BackgroundColor3 = Theme.Border
SidebarLine.BorderSizePixel = 0
SidebarLine.Parent = Sidebar

-- เหลือเพียงเมนู "ช่วยเล่น" รายการเดียว
local SideButton = Instance.new("TextButton")
SideButton.Size = UDim2.new(1, -16, 0, 36)
SideButton.Position = UDim2.fromOffset(8, 12)
SideButton.BackgroundTransparency = 1
SideButton.Text = "ช่วยเล่น"
SideButton.TextSize = 13
SideButton.Font = Enum.Font.GothamBold
SideButton.TextColor3 = Theme.Text
SideButton.TextXAlignment = Enum.TextXAlignment.Left
SideButton.AutoButtonColor = false
SideButton.Parent = Sidebar

local SidePadding = Instance.new("UIPadding")
SidePadding.PaddingLeft = UDim.new(0, 14)
SidePadding.Parent = SideButton

local SelectedBar = Instance.new("Frame")
SelectedBar.Size = UDim2.fromOffset(3, 20)
SelectedBar.Position = UDim2.fromOffset(0, 8)
SelectedBar.BackgroundColor3 = Theme.Accent
SelectedBar.BorderSizePixel = 0
SelectedBar.Parent = SideButton

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(1, 0)
BarCorner.Parent = SelectedBar

--========================================================--
--                     CONTENT
--========================================================--

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -130, 1, -45)
Content.Position = UDim2.new(0, 130, 0, 45)
Content.BackgroundColor3 = Theme.Background
Content.BorderSizePixel = 0
Content.Parent = Main

local ContentPadding = Instance.new("UIPadding")
ContentPadding.PaddingTop = UDim.new(0, 12)
ContentPadding.PaddingBottom = UDim.new(0, 10)
ContentPadding.PaddingLeft = UDim.new(0, 12)
ContentPadding.PaddingRight = UDim.new(0, 10)
ContentPadding.Parent = Content

local ContentTitle = Instance.new("TextLabel")
ContentTitle.Size = UDim2.new(1, 0, 0, 22)
ContentTitle.BackgroundTransparency = 1
ContentTitle.Text = "รายการสคริปต์ช่วยเล่น"
ContentTitle.TextColor3 = Theme.Accent
ContentTitle.TextSize = 14
ContentTitle.Font = Enum.Font.GothamBold
ContentTitle.TextXAlignment = Enum.TextXAlignment.Left
ContentTitle.Parent = Content

--========================================================--
--                     SCRIPT LIST
--========================================================--

local List = Instance.new("ScrollingFrame")
List.Name = "ScriptList"
List.Position = UDim2.fromOffset(0, 30)
List.Size = UDim2.new(1, 0, 1, -30)
List.BackgroundTransparency = 1
List.BorderSizePixel = 0
List.ScrollBarThickness = 3
List.ScrollBarImageColor3 = Theme.Accent
List.CanvasSize = UDim2.new(0, 0, 0, 0)
List.AutomaticCanvasSize = Enum.AutomaticSize.Y
List.Parent = Content

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 8)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Parent = List

--========================================================--
--                   CREATE SCRIPT ITEM
--========================================================--

local function CreateScriptItem(Data)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 42)
    Button.BackgroundColor3 = Theme.Item
    Button.Text = Data.Name
    Button.TextColor3 = Theme.Text
    Button.TextSize = 13
    Button.Font = Enum.Font.GothamMedium
    Button.TextXAlignment = Enum.TextXAlignment.Left
    Button.AutoButtonColor = false
    Button.Parent = List

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Button

    local Padding = Instance.new("UIPadding")
    Padding.PaddingLeft = UDim.new(0, 12)
    Padding.Parent = Button

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Theme.Border
    Stroke.Thickness = 1
    Stroke.Parent = Button

    -- Animation Hover
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.12), {BackgroundColor3 = Theme.ItemHover}):Play()
    end)

    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.12), {BackgroundColor3 = Theme.Item}):Play()
    end)

    -- Run Script
    Button.MouseButton1Click:Connect(function()
        local Success, ErrorMessage = pcall(function()
            local Source = game:HttpGet(Data.URL)
            local Execute = loadstring(Source)
            if not Execute then error("ไม่สามารถโหลด Script ได้") end
            Execute()
        end)

        if not Success then
            warn("[DarkHub] Script Error:", ErrorMessage)
        end
    end)
end

for _, ScriptData in ipairs(Config.Scripts) do
    CreateScriptItem(ScriptData)
end

--========================================================--
--                       DRAG SYSTEM
--========================================================--

local function MakeDraggable(Object, Handle)
    local Dragging = false
    local DragStart, StartPosition

    Handle.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = Input.Position
            StartPosition = Object.Position

            Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)
        if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
            local Delta = Input.Position - DragStart
            Object.Position = UDim2.new(
                StartPosition.X.Scale, StartPosition.X.Offset + Delta.X,
                StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y
            )
        end
    end)
end

MakeDraggable(Main, TopBar)
MakeDraggable(OpenButton, OpenButton)

--========================================================--
--                     OPEN / CLOSE / MINIMIZE
--========================================================--

local IsOpen = true
local IsMinimized = false

OpenButton.MouseButton1Click:Connect(function()
    IsOpen = not IsOpen
    Main.Visible = IsOpen
end)

Close.MouseButton1Click:Connect(function()
    IsOpen = false
    Main.Visible = false
end)

Minimize.MouseButton1Click:Connect(function()
    IsMinimized = not IsMinimized

    if IsMinimized then
        Sidebar.Visible = false
        Content.Visible = false
        TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(Config.Width, 45)
        }):Play()
    else
        TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(Config.Width, Config.Height)
        }):Play()
        task.wait(0.15)
        Sidebar.Visible = true
        Content.Visible = true
    end
end)

local function HoverButton(Button)
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(45, 45, 55)}):Play()
    end)
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(32, 32, 38)}):Play()
    end)
end

HoverButton(Minimize)
HoverButton(Close)

print("[DarkHub] Loaded Successfully!")
