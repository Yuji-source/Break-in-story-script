local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Create GUI Root
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BreakInScriptGUI"
ScreenGui.ResetOnSpawn = false

local parentSuccess = pcall(function()
    ScreenGui.Parent = game:GetService("CoreGui")
end)
if not parentSuccess then
    ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
end

-- Shared Draggable Function
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
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(0, 170, 255)
ToggleStroke.Thickness = 1.2
ToggleStroke.Parent = ToggleBtn

makeDraggable(ToggleBtn)

-- Compact Main Window (430x220)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 430, 0, 220)
MainFrame.Position = UDim2.new(0.5, -215, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(50, 50, 60)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

makeDraggable(MainFrame)

-- Toggle Visibility Listener
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Title Label
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Break in Story Script"
TitleLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
TitleLabel.TextSize = 14
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

-- 1. Food Section (Left Side)
createSection("FOOD", "FOOD", UDim2.new(0, 10, 0, 32), UDim2.new(0, 200, 0, 135), {
    "Apple", "Cookie", "BloxyCola", "Bag Of Chips", 
    "Lollipop", "Pie", "Pizza", "High Sugar Bloxy Cola"
})

-- 2. Weapons Section (Right Side)
createSection("WEAPONS", "WEAPONS", UDim2.new(0, 220, 0, 32), UDim2.new(0, 200, 0, 135), {
    "Wrench", "BaseBall bat", "Hammer", "PitchFork", "CrowBar", 
    "IceBreaker", "Broom", "ToolBox", "Toy Sword", "Gun", 
    "Classic Sword", "MachineGun", "Golden Crowbar"
})

-- Single Spawn Action Button Across the Bottom
local SpawnBtn = Instance.new("TextButton")
SpawnBtn.Size = UDim2.new(0, 410, 0, 34)
SpawnBtn.Position = UDim2.new(0, 10, 0, 175)
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

-- Spawn Remote Execution Logic
SpawnBtn.MouseButton1Click:Connect(function()
    if not selectedItemName then
        warn("No item selected from the menu!")
        return
    end
    
    if selectedCategory == "WEAPONS" then
        -- Execute BasementWeapon remote for weapons
        local args = {
            true,
            selectedItemName
        }
        ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("BasementWeapon"):FireServer(unpack(args))
    else
        -- Execute GiveTool remote for food items
        local args = {
            selectedItemName
        }
        ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("GiveTool"):FireServer(unpack(args))
    end
end)
