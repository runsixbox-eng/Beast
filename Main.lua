--========================================================--
--        PREMIUM CLIENT - AUTO LOAD FROM FILENAME
--========================================================--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ลบ GUI เก่า (ถ้ามี)
local Old = PlayerGui:FindFirstChild("DarkGoldHub")
if Old then
    Old:Destroy()
end

--========================================================--
-- SETTINGS & CONFIGURATION
--========================================================--

local LOGO_ASSET_ID = "rbxassetid://102265344621893"  
local OPEN_TIME = 0.25
local CLOSE_TIME = 0.20

-- โทนสี ดำ - ทอง พรีเมียม
local Gold = Color3.fromRGB(212, 175, 55)
local GoldLight = Color3.fromRGB(240, 205, 95)
local BgBlack = Color3.fromRGB(15, 15, 18)
local SidebarBlack = Color3.fromRGB(18, 18, 22)
local TextLight = Color3.fromRGB(240, 240, 245)

--========================================================--
-- SCREEN GUI & MAIN WINDOW
--========================================================--

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DarkGoldHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- ปุ่มเปิด-ปิด UI (Toggle)
local Toggle = Instance.new("ImageButton")
Toggle.Name = "Toggle"
Toggle.Size = UDim2.fromOffset(45, 45)
Toggle.Position = UDim2.new(0, 14, 0.5, -22)
Toggle.BackgroundColor3 = BgBlack
Toggle.BorderSizePixel = 0
Toggle.AutoButtonColor = false
Toggle.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 14)
ToggleCorner.Parent = Toggle

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Gold
ToggleStroke.Thickness = 1.5
ToggleStroke.Transparency = 0.2
ToggleStroke.Parent = Toggle

local ToggleLogo = Instance.new("ImageLabel")
ToggleLogo.Size = UDim2.new(0.7, 0, 0.7, 0)
ToggleLogo.Position = UDim2.new(0.15, 0, 0.15, 0)
ToggleLogo.BackgroundTransparency = 1
ToggleLogo.Image = LOGO_ASSET_ID
ToggleLogo.Parent = Toggle

-- หน้าต่างหลัก (Main Window)
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(450, 310)
Main.Position = UDim2.new(0.5, -225, 0.5, -155)
Main.BackgroundColor3 = BgBlack
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 18)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Gold
MainStroke.Thickness = 1.2
MainStroke.Transparency = 0.4
MainStroke.Parent = Main

-- Header (ส่วนหัวหน้าต่าง)
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 48)
Header.BackgroundColor3 = BgBlack
Header.BackgroundTransparency = 0.2
Header.BorderSizePixel = 0
Header.Parent = Main

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 18)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -130, 1, 0)
Title.Position = UDim2.fromOffset(48, 0)
Title.BackgroundTransparency = 1
Title.Text = "Premium Client"
Title.TextColor3 = Gold
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Minimize = Instance.new("TextButton")
Minimize.Name = "Minimize"
Minimize.Size = UDim2.fromOffset(32, 32)
Minimize.Position = UDim2.new(1, -72, 0, 8)
Minimize.BackgroundTransparency = 1
Minimize.Text = "—"
Minimize.TextColor3 = Gold
Minimize.TextSize = 19
Minimize.Font = Enum.Font.GothamBold
Minimize.Parent = Header

local Close = Instance.new("TextButton")
Close.Name = "Close"
Close.Size = UDim2.fromOffset(32, 32)
Close.Position = UDim2.new(1, -38, 0, 8)
Close.BackgroundTransparency = 1
Close.Text = "×"
Close.TextColor3 = Gold
Close.TextSize = 22
Close.Font = Enum.Font.GothamBold
Close.Parent = Header

-- Sidebar (แถบเมนูด้านซ้าย)
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 135, 1, -58)
Sidebar.Position = UDim2.fromOffset(8, 52)
Sidebar.BackgroundColor3 = SidebarBlack
Sidebar.BackgroundTransparency = 0.3
Sidebar.BorderSizePixel = 0
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
Sidebar.ScrollBarThickness = 2
Sidebar.Parent = Main

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Padding = UDim.new(0, 6)
SidebarLayout.Parent = Sidebar

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 15)
SidebarCorner.Parent = Sidebar

-- Content (พื้นที่บอกสถานะเมื่อกดรันสคริปต์)
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -151, 1, -58)
Content.Position = UDim2.fromOffset(143, 52)
Content.BackgroundColor3 = BgBlack
Content.BackgroundTransparency = 0.4
Content.BorderSizePixel = 0
Content.ClipsDescendants = true
Content.Parent = Main

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 15)
ContentCorner.Parent = Content

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 1, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Select a script from the menu."
StatusLabel.TextColor3 = TextLight
StatusLabel.TextSize = 14
StatusLabel.Font = Enum.Font.GothamMedium
StatusLabel.Parent = Content

--========================================================--
-- SYSTEM: AUTO LOAD SCRIPT FROM FILENAME
--========================================================--

local function LoadFilesIntoMenu()
    if not listfiles or not pcall(listfiles, "Functions") then
        StatusLabel.Text = "Error: 'Functions' folder not found!"
        return
    end

    local files = listfiles("Functions")
    for _, filePath in ipairs(files) do
        if filePath:sub(-4) == ".lua" then
            -- ตัดเอาเฉพาะชื่อไฟล์มาทำเป็นชื่อปุ่ม (เช่น "Functions/Speed.lua" จะเหลือ "Speed")
            local fileName = filePath:match("([^/\\]+)%.lua$")

            -- สร้างปุ่มเมนู
            local MenuBtn = Instance.new("TextButton")
            MenuBtn.Name = fileName .. "Btn"
            MenuBtn.Size = UDim2.new(1, -6, 0, 38)
            MenuBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
            MenuBtn.BorderSizePixel = 0
            MenuBtn.Text = ""
            MenuBtn.AutoButtonColor = false
            MenuBtn.Parent = Sidebar

            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 10)
            BtnCorner.Parent = MenuBtn

            local Icon = Instance.new("TextLabel")
            Icon.Size = UDim2.fromOffset(28, 38)
            Icon.Position = UDim2.fromOffset(3, 0)
            Icon.BackgroundTransparency = 1
            Icon.Text = "📂"
            Icon.TextColor3 = Gold
            Icon.TextSize = 14
            Icon.Font = Enum.Font.GothamBold
            Icon.Parent = MenuBtn

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -34, 1, 0)
            Label.Position = UDim2.fromOffset(32, 0)
            Label.BackgroundTransparency = 1
            Label.Text = fileName
            Label.TextColor3 = TextLight
            Label.TextSize = 11
            Label.Font = Enum.Font.GothamBold
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = MenuBtn

            -- **[กดปุ่มแล้วโหลด + รันสคริปต์ในไฟล์นั้นทันที]**
            MenuBtn.MouseButton1Click:Connect(function()
                local success, err = pcall(function()
                    local scriptContent = readfile(filePath)
                    local runFunc = loadstring(scriptContent)
                    if runFunc then
                        task.spawn(runFunc) -- รันสคริปต์
                    end
                end)

                if success then
                    StatusLabel.Text = "Executed: " .. fileName
                    -- ทำอนิเมชั่นเปลี่ยนสีปุ่มชั่วคราวให้รู้ว่ากดแล้ว
                    TweenService:Create(MenuBtn, TweenInfo.new(0.1), {BackgroundColor3 = GoldLight}):Play()
                    task.wait(0.15)
                    TweenService:Create(MenuBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 32)}):Play()
                else
                    StatusLabel.Text = "Error in " .. fileName
                    warn(err)
                end
            end)
        end
    end
end

task.spawn(LoadFilesIntoMenu)

--========================================================--
-- ANIMATIONS & DRAGGING
--========================================================--

local Opened = true
local NormalSize = UDim2.fromOffset(450, 310)
local NormalPosition = UDim2.new(0.5, -225, 0.5, -155)

local function OpenGUI()
    Main.Visible = true
    Main.Size = UDim2.fromOffset(380, 260)
    Main.Position = UDim2.new(0.5, -190, 0.5, -130)
    TweenService:Create(Main, TweenInfo.new(OPEN_TIME, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = NormalSize,
        Position = NormalPosition,
    }):Play()
end

local function CloseGUI()
    local Tween = TweenService:Create(Main, TweenInfo.new(CLOSE_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.fromOffset(380, 260),
        Position = UDim2.new(0.5, -190, 0.5, -130),
    })
    Tween:Play()
    Tween.Completed:Connect(function()
        Main.Visible = false
    end)
end

Toggle.MouseButton1Click:Connect(function()
    Opened = not Opened
    if Opened then OpenGUI() else CloseGUI() end
end)

Close.MouseButton1Click:Connect(function() Opened = false; CloseGUI() end)
Minimize.MouseButton1Click:Connect(function() Opened = false; CloseGUI() end)

local function MakeDraggable(TopBar, TargetField)
    local Dragging = false
    local DragStart, StartPosition

    TopBar.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = Input.Position
            StartPosition = TargetField.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)
        if not Dragging then return end
        if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
            local Delta = Input.Position - DragStart
            TargetField.Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
        end
    end)

    UserInputService.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
        end
    end)
end

MakeDraggable(Header, Main)
MakeDraggable(Toggle, Toggle)
