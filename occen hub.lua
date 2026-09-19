--// Modern Hub UI - Roblox Studio
--// Designed for your own Roblox experience

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

--==================================================
-- CONFIG
--==================================================

local HUB_NAME = "Ocean Hub"

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "OceanHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(620, 400)
main.Position = UDim2.new(0.5, -310, 0.5, -200)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 27)
main.BorderSizePixel = 0
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(65, 65, 80)
stroke.Thickness = 1
stroke.Parent = main

--==================================================
-- TITLE
--==================================================

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -30, 0, 45)
title.Position = UDim2.fromOffset(20, 8)
title.BackgroundTransparency = 1
title.Text = HUB_NAME
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 24
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -30, 0, 20)
subtitle.Position = UDim2.fromOffset(20, 45)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Your own-game control panel"
subtitle.TextColor3 = Color3.fromRGB(145, 145, 160)
subtitle.TextSize = 12
subtitle.Font = Enum.Font.Gotham
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = main

--==================================================
-- SIDEBAR
--==================================================

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.fromOffset(145, 330)
sidebar.Position = UDim2.fromOffset(15, 60)
sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 33)
sidebar.BorderSizePixel = 0
sidebar.Parent = main

Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 9)

local list = Instance.new("UIListLayout")
list.Padding = UDim.new(0, 7)
list.HorizontalAlignment = Enum.HorizontalAlignment.Center
list.SortOrder = Enum.SortOrder.LayoutOrder
list.Parent = sidebar

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 12)
padding.Parent = sidebar

--==================================================
-- CONTENT
--==================================================

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -180, 1, -75)
content.Position = UDim2.fromOffset(170, 65)
content.BackgroundTransparency = 1
content.Parent = main

local pages = {}

local function createPage(name)
    local page = Instance.new("Frame")
    page.Name = name
    page.Size = UDim2.fromScale(1, 1)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = content

    pages[name] = page
    return page
end

--==================================================
-- BUTTON CREATOR
--==================================================

local function createButton(parent, text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 42)
    button.BackgroundColor3 = Color3.fromRGB(31, 31, 42)
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.fromRGB(210, 210, 220)
    button.TextSize = 13
    button.Font = Enum.Font.GothamMedium
    button.AutoButtonColor = false
    button.Parent = parent

    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 7)

    button.MouseEnter:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.15),
            {BackgroundColor3 = Color3.fromRGB(45, 45, 60)}
        ):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.15),
            {BackgroundColor3 = Color3.fromRGB(31, 31, 42)}
        ):Play()
    end)

    button.MouseButton1Click:Connect(callback)

    return button
end

--==================================================
-- PAGE TITLE
--==================================================

local function pageTitle(page, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 35)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 19
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = page
end

--==================================================
-- MAIN PAGE
--==================================================

local home = createPage("Main")
pageTitle(home, "Main")

local welcome = Instance.new("TextLabel")
welcome.Size = UDim2.new(1, 0, 0, 40)
welcome.Position = UDim2.fromOffset(0, 45)
welcome.BackgroundTransparency = 1
welcome.Text = "Welcome, " .. player.DisplayName
welcome.TextColor3 = Color3.fromRGB(170, 170, 185)
welcome.TextSize = 14
welcome.Font = Enum.Font.Gotham
welcome.TextXAlignment = Enum.TextXAlignment.Left
welcome.Parent = home

--==================================================
-- FRUIT PAGE
--==================================================

local fruits = createPage("Fruits")
pageTitle(fruits, "Fruit Tracker")

local fruitInfo = Instance.new("TextLabel")
fruitInfo.Size = UDim2.new(1, 0, 0, 50)
fruitInfo.Position = UDim2.fromOffset(0, 45)
fruitInfo.BackgroundTransparency = 1
fruitInfo.Text = "Fruit tracking for your own game's Workspace."
fruitInfo.TextColor3 = Color3.fromRGB(165, 165, 180)
fruitInfo.TextSize = 13
fruitInfo.Font = Enum.Font.Gotham
fruitInfo.TextWrapped = true
fruitInfo.TextXAlignment = Enum.TextXAlignment.Left
fruitInfo.Parent = fruits

local scan = createButton(fruits, "🔎  Scan For Fruits", function()
    local found = {}

    for _, object in ipairs(workspace:GetDescendants()) do
        if object:GetAttribute("Fruit") == true then
            table.insert(found, object.Name)
        end
    end

    if #found == 0 then
        fruitInfo.Text = "No tracked fruits found."
    else
        fruitInfo.Text = "Found: " .. table.concat(found, ", ")
    end
end)

scan.Position = UDim2.fromOffset(0, 105)
scan.Size = UDim2.new(1, 0, 0, 42)

--==================================================
-- ESP PAGE
--==================================================

local espPage = createPage("ESP")
pageTitle(espPage, "Debug ESP")

local espEnabled = false

local function addESP(object)
    if not object:IsA("Model") then return end
    if not object:GetAttribute("Fruit") then return end
    if object:FindFirstChild("DebugHighlight") then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "DebugHighlight"
    highlight.FillTransparency = 0.65
    highlight.OutlineTransparency = 0
    highlight.Parent = object
end

local function removeESP()
    for _, object in ipairs(workspace:GetDescendants()) do
        local highlight = object:FindFirstChild("DebugHighlight")
        if highlight then
            highlight:Destroy()
        end
    end
end

local espButton = createButton(espPage, "ESP: OFF", function(button)
    espEnabled = not espEnabled

    if espEnabled then
        button.Text = "ESP: ON"

        for _, object in ipairs(workspace:GetDescendants()) do
            addESP(object)
        end
    else
        button.Text = "ESP: OFF"
        removeESP()
    end
end)

espButton.Position = UDim2.fromOffset(0, 50)
espButton.Size = UDim2.new(1, 0, 0, 42)

--==================================================
-- TELEPORT PAGE
--==================================================

local teleport = createPage("Teleports")
pageTitle(teleport, "Teleports")

local locations = {
    {"Spawn", Vector3.new(0, 5, 0)},
    {"Island 1", Vector3.new(500, 10, 300)},
    {"Island 2", Vector3.new(-500, 10, 300)},
}

for i, data in ipairs(locations) do
    local button = createButton(teleport, "📍  " .. data[1], function()
        local character = player.Character
        local root = character and character:FindFirstChild("HumanoidRootPart")

        if root then
            root.CFrame = CFrame.new(data[2])
        end
    end)

    button.Position = UDim2.fromOffset(0, 35 + ((i - 1) * 50))
    button.Size = UDim2.new(1, 0, 0, 42)
end

--==================================================
-- SETTINGS PAGE
--==================================================

local settings = createPage("Settings")
pageTitle(settings, "Settings")

local notifications = true

local notificationButton = createButton(settings, "Notifications: ON", function(button)
    notifications = not notifications

    if notifications then
        button.Text = "Notifications: ON"
    else
        button.Text = "Notifications: OFF"
    end
end)

notificationButton.Position = UDim2.fromOffset(0, 50)
notificationButton.Size = UDim2.new(1, 0, 0, 42)

--==================================================
-- NAVIGATION
--==================================================

local function showPage(name)
    for pageName, page in pairs(pages) do
        page.Visible = pageName == name
    end
end

local tabs = {
    {"🏠  Main", "Main"},
    {"🍎  Fruits", "Fruits"},
    {"👁  ESP", "ESP"},
    {"📍  Teleports", "Teleports"},
    {"⚙  Settings", "Settings"},
}

for _, tab in ipairs(tabs) do
    local button = createButton(sidebar, tab[1], function()
        showPage(tab[2])
    end)

    button.LayoutOrder = #sidebar:GetChildren()
end

showPage("Main")

--==================================================
-- DRAGGING
--==================================================

local dragging = false
local dragStart
local startPosition

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

title.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart

        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)
