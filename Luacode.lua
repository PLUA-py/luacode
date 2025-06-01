local Players      = game:GetService("Players")
local RunService   = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInput    = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Camera      = workspace.CurrentCamera

local screenGui = Instance.new("ScreenGui")
screenGui.Name   = "C00lkiddPanel"
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Name               = "MainFrame"
mainFrame.Size               = UDim2.new(0, 360, 0, 500)
mainFrame.Position           = UDim2.new(0.5, -180, 0.5, -250)
mainFrame.BackgroundColor3   = Color3.fromRGB(20, 20, 20)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel    = 0
mainFrame.Active             = true
mainFrame.Draggable          = true

local topBar = Instance.new("Frame", mainFrame)
topBar.Name             = "TopBar"
topBar.Size             = UDim2.new(1, 0, 0, 30)
topBar.Position         = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
topBar.BorderSizePixel  = 0

local titleLabel = Instance.new("TextLabel", topBar)
titleLabel.Size              = UDim2.new(0.6, 0, 1, 0)
titleLabel.Position          = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text              = "C00lkidd panel"
titleLabel.TextColor3        = Color3.fromRGB(255, 255, 255)
titleLabel.Font              = Enum.Font.GothamBold
titleLabel.TextSize          = 16
titleLabel.TextXAlignment    = Enum.TextXAlignment.Left

local userLabel = Instance.new("TextLabel", topBar)
userLabel.Size              = UDim2.new(0.4, -10, 1, 0)
userLabel.Position          = UDim2.new(0.6, 10, 0, 0)
userLabel.BackgroundTransparency = 1
userLabel.Text              = "spongebybka"
userLabel.TextColor3        = Color3.fromRGB(170, 170, 170)
userLabel.Font              = Enum.Font.Gotham
userLabel.TextSize          = 14
userLabel.TextXAlignment    = Enum.TextXAlignment.Right

local icon = Instance.new("ImageLabel", topBar)
icon.Size              = UDim2.new(0, 20, 0, 20)
icon.Position          = UDim2.new(0, 5, 0, 5)
icon.BackgroundTransparency = 1
icon.Image             = "file://storage/emulated/0/Delta/Workspace/2025060112261389.jpg"

local btnMinimize = Instance.new("TextButton", topBar)
btnMinimize.Size              = UDim2.new(0, 30, 0, 30)
btnMinimize.Position          = UDim2.new(1, -70, 0, 0)
btnMinimize.BackgroundTransparency = 0.2
btnMinimize.BackgroundColor3  = Color3.fromRGB(40, 40, 40)
btnMinimize.Text              = "–"
btnMinimize.TextColor3        = Color3.fromRGB(255, 255, 255)
btnMinimize.Font              = Enum.Font.Gotham
btnMinimize.TextSize          = 20

local btnClose = Instance.new("TextButton", topBar)
btnClose.Size              = UDim2.new(0, 30, 0, 30)
btnClose.Position          = UDim2.new(1, -35, 0, 0)
btnClose.BackgroundTransparency = 0.2
btnClose.BackgroundColor3  = Color3.fromRGB(40, 40, 40)
btnClose.Text              = "✕"
btnClose.TextColor3        = Color3.fromRGB(255, 100, 100)
btnClose.Font              = Enum.Font.Gotham
btnClose.TextSize          = 18

local minimized = false
btnMinimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    for _, child in pairs(mainFrame:GetChildren()) do
        if child ~= topBar then
            child.Visible = not minimized
        end
    end
    btnMinimize.Text = minimized and "+" or "–"
end)
btnClose.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

local tabsFrame = Instance.new("Frame", mainFrame)
tabsFrame.Name              = "TabsFrame"
tabsFrame.Size              = UDim2.new(0, 100, 1, -30)
tabsFrame.Position          = UDim2.new(0, 0, 0, 30)
tabsFrame.BackgroundColor3  = Color3.fromRGB(15, 15, 15)
tabsFrame.BorderSizePixel   = 0

local function createTabButton(text, positionY)
    local btn = Instance.new("TextButton", tabsFrame)
    btn.Size             = UDim2.new(1, -10, 0, 40)
    btn.Position         = UDim2.new(0, 5, 0, positionY)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text             = text
    btn.TextColor3       = Color3.fromRGB(200, 200, 200)
    btn.Font             = Enum.Font.Gotham
    btn.TextSize         = 14
    return btn
end

local btnKill     = createTabButton("Kill", 0)
local btnCT       = createTabButton("CT", 50)
local btnTeleport = createTabButton("Teleport", 100)
local btnFly      = createTabButton("Fly/NoClip", 150)
local btnSpawn    = createTabButton("Spawn Weapon", 200)
local btnCurrency = createTabButton("Currency", 250)

local function createContentFrame()
    local fr = Instance.new("Frame", mainFrame)
    fr.Size             = UDim2.new(1, -100, 1, -30)
    fr.Position         = UDim2.new(0, 100, 0, 30)
    fr.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    fr.BorderSizePixel  = 0
    fr.Visible          = false
    return fr
end

local contentKill     = createContentFrame()
local contentCT       = createContentFrame()
local contentTeleport = createContentFrame()
local contentFly      = createContentFrame()
local contentSpawn    = createContentFrame()
local contentCurrency = createContentFrame()

local function showContent(frame)
    for _, fr in pairs({contentKill, contentCT, contentTeleport, contentFly, contentSpawn, contentCurrency}) do
        fr.Visible = (fr == frame)
    end
end

btnKill.MouseButton1Click:Connect(function() showContent(contentKill) end)
btnCT.MouseButton1Click:Connect(function() showContent(contentCT) end)
btnTeleport.MouseButton1Click:Connect(function() showContent(contentTeleport) end)
btnFly.MouseButton1Click:Connect(function() showContent(contentFly) end)
btnSpawn.MouseButton1Click:Connect(function() showContent(contentSpawn) end)
btnCurrency.MouseButton1Click:Connect(function() showContent(contentCurrency) end)

showContent(contentKill)

do
    local lbl = Instance.new("TextLabel", contentKill)
    lbl.Size              = UDim2.new(1, -20, 0, 20)
    lbl.Position          = UDim2.new(0, 10, 0, 10)
    lbl.BackgroundTransparency = 1
    lbl.Text              = "Имя игрока для убийства:"
    lbl.TextColor3        = Color3.fromRGB(255, 255, 255)
    lbl.Font              = Enum.Font.Gotham
    lbl.TextSize          = 14

    local txtBox = Instance.new("TextBox", contentKill)
    txtBox.Size              = UDim2.new(1, -20, 0, 30)
    txtBox.Position          = UDim2.new(0, 10, 0, 40)
    txtBox.PlaceholderText   = "Введите ник"
    txtBox.TextColor3        = Color3.fromRGB(0, 0, 0)
    txtBox.Font              = Enum.Font.Gotham
    txtBox.TextSize          = 14

    local btnExec = Instance.new("TextButton", contentKill)
    btnExec.Size             = UDim2.new(1, -20, 0, 30)
    btnExec.Position         = UDim2.new(0, 10, 0, 80)
    btnExec.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
    btnExec.Text             = "Убить"
    btnExec.TextColor3       = Color3.fromRGB(255, 255, 255)
    btnExec.Font             = Enum.Font.Gotham
    btnExec.TextSize         = 14

    btnExec.MouseButton1Click:Connect(function()
        local targetName = txtBox.Text
        if targetName and targetName ~= "" then
            for _, pl in pairs(Players:GetPlayers()) do
                if pl.Name:lower() == targetName:lower() and pl.Character and pl.Character:FindFirstChildOfClass("Humanoid") then
                    pl.Character:FindFirstChildOfClass("Humanoid"):TakeDamage(1e9)
                    break
                end
            end
        end
    end)
end

do
    local btnTsunami = Instance.new("TextButton", contentCT)
    btnTsunami.Size             = UDim2.new(1, -20, 0, 30)
    btnTsunami.Position         = UDim2.new(0, 10, 0, 10)
    btnTsunami.BackgroundColor3 = Color3.fromRGB(50, 50, 180)
    btnTsunami.Text             = "Цунами"
    btnTsunami.TextColor3       = Color3.fromRGB(255, 255, 255)
    btnTsunami.Font             = Enum.Font.Gotham
    btnTsunami.TextSize         = 14

    btnTsunami.MouseButton1Click:Connect(function()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                local keep = false
                if obj:IsDescendantOf(LocalPlayer.Character) then
                    keep = true
                else
                    local parentChar = obj:FindFirstAncestorWhichIsA("Model")
                    if parentChar and parentChar.Name == "spongebybka" then
                        keep = true
                    end
                end
                if not keep then
                    obj:Destroy()
                end
            end
        end
    end)

    local btnFatality = Instance.new("TextButton", contentCT)
    btnFatality.Size             = UDim2.new(1, -20, 0, 30)
    btnFatality.Position         = UDim2.new(0, 10, 0, 50)
    btnFatality.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
    btnFatality.Text             = "Фаталити"
    btnFatality.TextColor3       = Color3.fromRGB(255, 255, 255)
    btnFatality.Font             = Enum.Font.Gotham
    btnFatality.TextSize         = 14

    local lastKiller = nil
    local function trackKiller(pl)
        if pl.Character then
            local hum = pl.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.Died:Connect(function()
                    local tag = hum:FindFirstChild("creator")
                    if tag and tag.Value then
                        lastKiller = tag.Value
                    end
                end)
            end
        end
    end
    for _, pl in pairs(Players:GetPlayers()) do
        trackKiller(pl)
        pl.CharacterAdded:Connect(function(char) trackKiller(pl) end)
    end

    btnFatality.MouseButton1Click:Connect(function()
        local target = nil
        if lastKiller and lastKiller.Character and lastKiller.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (LocalPlayer.Character.HumanoidRootPart.Position - lastKiller.Character.HumanoidRootPart.Position).Magnitude
            if dist < 50 then
                target = lastKiller
            end
        end
        if not target then
            local mind, closest = math.huge, nil
            for _, pl in pairs(Players:GetPlayers()) do
                if pl ~= LocalPlayer and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
                    local d = (LocalPlayer.Character.HumanoidRootPart.Position - pl.Character.HumanoidRootPart.Position).Magnitude
                    if d < mind then
                        mind, closest = d, pl
                    end
                end
            end
            target = closest
        end
        if target and target.Character and target.Character:FindFirstChildOfClass("Humanoid") then
            local katana = Instance.new("Part", workspace)
            katana.Name         = "FatalityKatana"
            katana.Size         = Vector3.new(1, 4, 0.2)
            katana.CFrame       = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2) * CFrame.Angles(0, math.rad(180), 0)
            katana.BrickColor   = BrickColor.new("Really black")
            katana.Material     = Enum.Material.Metal
            katana.Anchored     = true
            local goal = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 0.5)
            local tween = TweenService:Create(katana, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {CFrame = goal})
            tween:Play()
            task.delay(0.5, function()
                target.Character:FindFirstChildOfClass("Humanoid"):TakeDamage(1e5)
                katana:Destroy()
            end)
        end
    end)

    local btnC00lkidd = Instance.new("TextButton", contentCT)
    btnC00lkidd.Size             = UDim2.new(1, -20, 0, 30)
    btnC00lkidd.Position         = UDim2.new(0, 10, 0, 90)
    btnC00lkidd.BackgroundColor3 = Color3.fromRGB(200, 200, 50)
    btnC00lkidd.Text             = "c00lkidd + Skin"
    btnC00lkidd.TextColor3       = Color3.fromRGB(0, 0, 0)
    btnC00lkidd.Font             = Enum.Font.Gotham
    btnC00lkidd.TextSize         = 14

    btnC00lkidd.MouseButton1Click:Connect(function()
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local head = char:FindFirstChild("Head")
        if head then
            local oldTag = head:FindFirstChild("CustomNameTag")
            if oldTag then oldTag:Destroy() end
            local billboard = Instance.new("BillboardGui", head)
            billboard.Name          = "CustomNameTag"
            billboard.Adornee       = head
            billboard.AlwaysOnTop   = true
            billboard.Size          = UDim2.new(0, 200, 0, 50)
            billboard.StudsOffset   = Vector3.new(0, 2.5, 0)
            local label = Instance.new("TextLabel", billboard)
            label.Size              = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text              = "c00lkidd"
            label.TextColor3        = Color3.fromRGB(0, 255, 255)
            label.TextScaled        = true
            label.Font              = Enum.Font.GothamBold
        end
        local success, desc = pcall(function()
            return Players:GetHumanoidDescriptionFromUserId(LocalPlayer.UserId)
        end)
        if success and desc then
            char:WaitForChild("Humanoid"):ApplyDescription(desc)
        end
    end)

    local btnImmortal = Instance.new("TextButton", contentCT)
    btnImmortal.Size             = UDim2.new(1, -20, 0, 30)
    btnImmortal.Position         = UDim2.new(0, 10, 0, 130)
    btnImmortal.BackgroundColor3 = Color3.fromRGB(50, 200, 200)
    btnImmortal.Text             = "Enable Immortality"
    btnImmortal.TextColor3       = Color3.fromRGB(0, 0, 0)
    btnImmortal.Font             = Enum.Font.Gotham
    btnImmortal.TextSize         = 14

    btnImmortal.MouseButton1Click:Connect(function()
        local function onCharAdded(char)
            local hum = char:WaitForChild("Humanoid", 5)
            if hum then
                hum.HealthChanged:Connect(function(h)
                    if h < hum.MaxHealth then
                        hum.Health = hum.MaxHealth
                    end
                end)
                hum.Died:Connect(function()
                    task.wait(0.1)
                    if char.Parent then
                        hum.Health = hum.MaxHealth
                    end
                end)
                hum.MaxHealth = hum.MaxHealth
                hum.Health    = hum.MaxHealth
            end
        end
        if LocalPlayer.Character then onCharAdded(LocalPlayer.Character) end
        LocalPlayer.CharacterAdded:Connect(onCharAdded)
    end)
end

do
    local lbl = Instance.new("TextLabel", contentTeleport)
    lbl.Size              = UDim2.new(1, -20, 0, 20)
    lbl.Position          = UDim2.new(0, 10, 0, 10)
    lbl.BackgroundTransparency = 1
    lbl.Text              = "Включить Teleport:"
    lbl.TextColor3        = Color3.fromRGB(255, 255, 255)
    lbl.Font              = Enum.Font.Gotham
    lbl.TextSize          = 14

    local toggleLbl = Instance.new("TextLabel", contentTeleport)
    toggleLbl.Size              = UDim2.new(1, -20, 0, 20)
    toggleLbl.Position          = UDim2.new(0, 10, 0, 40)
    toggleLbl.BackgroundTransparency = 1
    toggleLbl.Text              = "Tele: Off"
    toggleLbl.TextColor3        = Color3.fromRGB(200, 200, 200)
    toggleLbl.Font              = Enum.Font.Gotham
    toggleLbl.TextSize          = 14

    local teleportEnabled = false
    local btnToggle = Instance.new("TextButton", contentTeleport)
    btnToggle.Size             = UDim2.new(1, -20, 0, 30)
    btnToggle.Position         = UDim2.new(0, 10, 0, 70)
    btnToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    btnToggle.Text             = "Toggle Teleport"
    btnToggle.TextColor3       = Color3.fromRGB(255, 255, 255)
    btnToggle.Font             = Enum.Font.Gotham
    btnToggle.TextSize         = 14

    btnToggle.MouseButton1Click:Connect(function()
        teleportEnabled = not teleportEnabled
        toggleLbl.Text = "Tele: " .. (teleportEnabled and "On" or "Off")
        btnToggle.BackgroundColor3 = teleportEnabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(80, 80, 80)
    end)

    UserInput.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if teleportEnabled and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            local unitRay = Camera:ScreenPointToRay(input.Position.X, input.Position.Y)
            local ray = Ray.new(unitRay.Origin, unitRay.Direction * 999)
            local _, hitPos = workspace:FindPartOnRay(ray, LocalPlayer.Character)
            if hitPos and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(hitPos + Vector3.new(0, 3, 0))
            end
        end
    end)
end

do
    local lbl = Instance.new("TextLabel", contentFly)
    lbl.Size              = UDim2.new(1, -20, 0, 20)
    lbl.Position          = UDim2.new(0, 10, 0, 10)
    lbl.BackgroundTransparency = 1
    lbl.Text              = "Fly/NoClip: Toggle (F)"
    lbl.TextColor3        = Color3.fromRGB(255, 255, 255)
    lbl.Font              = Enum.Font.Gotham
    lbl.TextSize          = 14

    local flying, noclip = false, false
    local bv, gyro

    local function startFly()
        flying = true
        noclip  = true
        bv = Instance.new("BodyVelocity", LocalPlayer.Character.HumanoidRootPart)
        bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        bv.P        = 1250
        bv.Velocity = Vector3.new(0, 0, 0)
        gyro = Instance.new("BodyGyro", LocalPlayer.Character.HumanoidRootPart)
        gyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
        gyro.P        = 5000
        gyro.CFrame   = LocalPlayer.Character.HumanoidRootPart.CFrame

        RunService.RenderStepped:Connect(function()
            if flying then
                gyro.CFrame = workspace.CurrentCamera.CFrame
                local moveDir = Vector3.new(0, 0, 0)
                if UserInput:IsKeyDown(Enum.KeyCode.W) then
                    moveDir = moveDir + workspace.CurrentCamera.CFrame.LookVector
                end
                if UserInput:IsKeyDown(Enum.KeyCode.S) then
                    moveDir = moveDir - workspace.CurrentCamera.CFrame.LookVector
                end
                if UserInput:IsKeyDown(Enum.KeyCode.A) then
                    moveDir = moveDir - workspace.CurrentCamera.CFrame.RightVector
                end
                if UserInput:IsKeyDown(Enum.KeyCode.D) then
                    moveDir = moveDir + workspace.CurrentCamera.CFrame.RightVector
                end
                if UserInput:IsKeyDown(Enum.KeyCode.Space) then
                    moveDir = moveDir + workspace.CurrentCamera.CFrame.UpVector
                end
                if UserInput:IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveDir = moveDir - workspace.CurrentCamera.CFrame.UpVector
                end
                bv.Velocity = moveDir.Unit * 100
            end
        end)

        RunService.Stepped:Connect(function()
            if noclip and LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end

    local function stopFly()
        flying = false
        noclip  = false
        if bv   then bv:Destroy() end
        if gyro then gyro:Destroy() end
    end

    UserInput.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.F then
            if flying then
                stopFly()
            else
                startFly()
            end
        end
    end)
