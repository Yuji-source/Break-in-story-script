local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

-- Create GUI Root
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Break In Story item spawner script"
ScreenGui.ResetOnSpawn = false

local parentSuccess = pcall(function()
    ScreenGui.Parent = game:GetService("CoreGui")
end)
if not parentSuccess then
    ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
end

-- ====================================================================
-- LOADING SCREEN
-- ====================================================================

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Name = "LoadingFrame"
LoadingFrame.Size = UDim2.new(0, 380, 0, 200)
LoadingFrame.Position = UDim2.new(0.5, -190, 0.5, -100)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.Parent = ScreenGui

local LoadingCorner = Instance.new("UICorner")
LoadingCorner.CornerRadius = UDim.new(0, 10)
LoadingCorner.Parent = LoadingFrame

local LoadingStroke = Instance.new("UIStroke")
LoadingStroke.Color = Color3.fromRGB(0, 170, 255)
LoadingStroke.Thickness = 1.5
LoadingStroke.Parent = LoadingFrame

local LoadingTitle = Instance.new("TextLabel")
LoadingTitle.Size = UDim2.new(1, 0, 0, 35)
LoadingTitle.Position = UDim2.new(0, 0, 0, 10)
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Text = "Break In Story item spawner script"
LoadingTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
LoadingTitle.TextSize = 14
LoadingTitle.Font = Enum.Font.GothamBold
LoadingTitle.Parent = LoadingFrame

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -40, 0, 20)
StatusLabel.Position = UDim2.new(0, 20, 0, 50)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Initializing..."
StatusLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
StatusLabel.TextSize = 12
StatusLabel.Font = Enum.Font.GothamSemibold
StatusLabel.Parent = LoadingFrame

-- Outer Bar
local BarBackground = Instance.new("Frame")
BarBackground.Size = UDim2.new(1, -40, 0, 16)
BarBackground.Position = UDim2.new(0, 20, 0, 75)
BarBackground.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
BarBackground.BorderSizePixel = 0
BarBackground.Parent = LoadingFrame

local BarBgCorner = Instance.new("UICorner")
BarBgCorner.CornerRadius = UDim.new(0, 8)
BarBgCorner.Parent = BarBackground

-- Inner Fill Bar
local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
BarFill.BorderSizePixel = 0
BarFill.Parent = BarBackground

local BarFillCorner = Instance.new("UICorner")
BarFillCorner.CornerRadius = UDim.new(0, 8)
BarFillCorner.Parent = BarFill

-- Credit Text Under Loading Bar
local CreditLabel = Instance.new("TextLabel")
CreditLabel.Size = UDim2.new(1, -20, 0, 60)
CreditLabel.Position = UDim2.new(0, 10, 0, 115)
CreditLabel.BackgroundTransparency = 1
CreditLabel.Text = "Script made by Yuji_scripts on Rscripts.net"
CreditLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CreditLabel.TextSize = 15
CreditLabel.Font = Enum.Font.GothamBold
CreditLabel.TextWrapped = true
CreditLabel.Parent = LoadingFrame

-- ====================================================================
-- MAIN GUI COMPONENTS (Initially Hidden)
-- ====================================================================

local function makeDraggable(guiObject)
    local dragging, dragInput, dragStart, startPos
    guiObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    guiObject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            guiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Draggable Toggle Button
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Size = UDim2.new(0, 90, 0, 32)
ToggleBtn.Position = UDim2.new(0, 15, 0.4, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
ToggleBtn.Text = "Toggle GUI"
ToggleBtn.TextColor3 = Color3.fromRGB(0, 170, 255)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 12
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Visible = false
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(0, 170, 255)
ToggleStroke.Thickness = 1.2
ToggleStroke.Parent = ToggleBtn

makeDraggable(ToggleBtn)

-- Main Frame (430x330)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 430, 0, 330)
MainFrame.Position = UDim2.new(0.5, -215, 0.5, -165)
MainFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(50, 50, 60)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

makeDraggable(MainFrame)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Header Title
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Break In Story item spawner script"
TitleLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
TitleLabel.TextSize = 13
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = MainFrame

-- State Variables
local selectedItemName = nil
local selectedCategory = nil
local activeItemButton = nil

-- Section Generator Function
local function createSection(categoryName, titleText, position, size, items)
    local Container = Instance.new("Frame")
    Container.Size = size
    Container.Position = position
    Container.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
    Container.BorderSizePixel = 0
    Container.Parent = MainFrame

    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 6)
    ContainerCorner.Parent = Container

    local Header = Instance.new("TextLabel")
    Header.Size = UDim2.new(1, 0, 0, 22)
    Header.BackgroundTransparency = 1
    Header.Text = titleText
    Header.TextColor3 = Color3.fromRGB(0, 170, 255)
    Header.TextSize = 11
    Header.Font = Enum.Font.GothamSemibold
    Header.Parent = Container

    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Size = UDim2.new(1, -8, 1, -26)
    ScrollFrame.Position = UDim2.new(0, 4, 0, 22)
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.BorderSizePixel = 0
    ScrollFrame.ScrollBarThickness = 3
    ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(70, 70, 80)
    ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollFrame.Parent = Container

    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Padding = UDim.new(0, 3)
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Parent = ScrollFrame

    for _, itemName in ipairs(items) do
        local ItemBtn = Instance.new("TextButton")
        ItemBtn.Size = UDim2.new(1, -5, 0, 22)
        ItemBtn.BackgroundColor3 = Color3.fromRGB(42, 42, 50)
        ItemBtn.Text = itemName
        ItemBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        ItemBtn.TextSize = 11
        ItemBtn.Font = Enum.Font.Gotham
        ItemBtn.BorderSizePixel = 0
        ItemBtn.Parent = ScrollFrame

        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 4)
        BtnCorner.Parent = ItemBtn

        ItemBtn.MouseButton1Click:Connect(function()
            if activeItemButton then
                activeItemButton.BackgroundColor3 = Color3.fromRGB(42, 42, 50)
                activeItemButton.TextColor3 = Color3.fromRGB(200, 200, 200)
            end
            selectedItemName = itemName
            selectedCategory = categoryName
            activeItemButton = ItemBtn
            ItemBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
            ItemBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)
    end
end

-- 1. Food Section (Top Left)
createSection("FOOD", "FOOD", UDim2.new(0, 10, 0, 32), UDim2.new(0, 200, 0, 120), {
    "Apple", "Cookie", "BloxyCola", "Chips", 
    "Lollipop", "Pie", "Pizza", "ExpiredBloxyCola"
})

-- 2. Weapons Section (Top Right)
createSection("WEAPONS", "WEAPONS", UDim2.new(0, 220, 0, 32), UDim2.new(0, 200, 0, 120), {
    "Wrench", "Bat", "Hammer", "PitchFork", "CrowBar", "Broom", "Gun"
})

-- 3. Miscellaneous Section (Bottom Center)
createSection("MISCELLANEOUS", "MISCELLANEOUS", UDim2.new(0.5, -130, 0, 158), UDim2.new(0, 260, 0, 85), {
    "Plank"
})

-- Spawn Action Button
local SpawnBtn = Instance.new("TextButton")
SpawnBtn.Size = UDim2.new(0, 410, 0, 34)
SpawnBtn.Position = UDim2.new(0, 10, 0, 280)
SpawnBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 100)
SpawnBtn.Text = "Spawn Selected Item"
SpawnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpawnBtn.Font = Enum.Font.GothamBold
SpawnBtn.TextSize = 12
SpawnBtn.BorderSizePixel = 0
SpawnBtn.Parent = MainFrame

local SpawnCorner = Instance.new("UICorner")
SpawnCorner.CornerRadius = UDim.new(0, 6)
SpawnCorner.Parent = SpawnBtn

-- Spawn Remote Execution
SpawnBtn.MouseButton1Click:Connect(function()
    if not selectedItemName then
        warn("No item selected from the menu!")
        return
    end
    
    if selectedCategory == "WEAPONS" then
        local args = {
            true,
            selectedItemName
        }
        ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("BasementWeapon"):FireServer(unpack(args))
    else
        local itemToSpawn = selectedItemName
        if itemToSpawn == "Pizza" then
            itemToSpawn = "Pizza2"
        end

        local args = {
            itemToSpawn
        }
        ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("GiveTool"):FireServer(unpack(args))
    end
end)

-- ====================================================================
-- LOADING SEQUENCE CONTROLLER
-- ====================================================================

task.spawn(function()
    local stages = {
        {pct = 0.20, text = "creating gui", waitTime = 2},
        {pct = 0.40, text = "loading features", waitTime = 2},
        {pct = 0.60, text = "fetching remotes", waitTime = 2},
        {pct = 0.80, text = "finalizing....", waitTime = 2},
        {pct = 1.00, text = "script loaded successfully!", waitTime = 1}
    }

    for _, stage in ipairs(stages) do
        StatusLabel.Text = stage.text
        TweenService:Create(BarFill, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(stage.pct, 0, 1, 0)
        }):Play()
        task.wait(stage.waitTime)
    end

    -- Finish loading: Hide loader, show main UI
    LoadingFrame:Destroy()
    MainFrame.Visible = true
    ToggleBtn.Visible = true
end)
