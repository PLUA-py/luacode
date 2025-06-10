--=# Anime Mobile Troll Samurai v2.1 #=--
-- Optimized for Roblox mobile devices

local Players = game:GetService("Players")
local UserInput = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hum = character:WaitForChild("Humanoid")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AnimeMobileUI"
ScreenGui.Parent = player.PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.4, 0, 0.1, 0) -- 40% width, 10% height
MainFrame.Position = UDim2.new(0.55, 0, 0.02, 0) -- Top-right corner
MainFrame.BackgroundTransparency = 0.7
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Tab System
local Tabs = {"Attack", "Troll"}
local TabButtons = {}

for i, tabName in ipairs(Tabs) do
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(0.49, 0, 0.3, 0) -- Wider tabs
    TabButton.Position = UDim2.new(0.49 * (i-1), 0, 0, 0)
    TabButton.Text = tabName
    TabButton.TextColor3 = Color3.new(1, 1, 1)
    TabButton.BackgroundColor3 = i == 1 and Color3.fromRGB(80, 20, 20) or Color3.fromRGB(40, 40, 60)
    TabButton.BorderSizePixel = 0
    TabButton.Font = Enum.Font.GothamBold
    TabButton.TextSize = 16
    TabButton.Parent = MainFrame
    
    TabButton.MouseButton1Click:Connect(function()
        for _, btn in ipairs(TabButtons) do
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        end
        TabButton.BackgroundColor3 = Color3.fromRGB(80, 20, 20)
        updateContent(tabName)
    end)
    
    table.insert(TabButtons, TabButton)
end

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 0.7, 0)
ContentFrame.Position = UDim2.new(0, 0, 0.3, 0)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Update UI
function updateContent(tabName)
    for _, child in ipairs(ContentFrame:GetChildren()) do
        if child:IsA("GuiObject") then child:Destroy() end
    end
    
    if tabName == "Attack" then
        -- Attack Button
        local AttackButton = Instance.new("TextButton")
        AttackButton.Size = UDim2.new(0.45, 0, 0.9, 0)
        AttackButton.Position = UDim2.new(0.025, 0, 0.05, 0)
        AttackButton.Text = "⚔️ Attack"
        AttackButton.TextColor3 = Color3.new(1, 1, 1)
        AttackButton.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        AttackButton.Font = Enum.Font.GothamBold
        AttackButton.TextSize = 16
        AttackButton.Parent = ContentFrame
        
        AttackButton.MouseButton1Click:Connect(animeAttack)
        
        -- Super Attack Button
        local SuperButton = Instance.new("TextButton")
        SuperButton.Size = UDim2.new(0.45, 0, 0.9, 0)
        SuperButton.Position = UDim2.new(0.525, 0, 0.05, 0)
        SuperButton.Text = "🔥 Super"
        SuperButton.TextColor3 = Color3.new(1, 1, 1)
        SuperButton.BackgroundColor3 = Color3.fromRGB(200, 100, 20)
        SuperButton.Font = Enum.Font.GothamBold
        SuperButton.TextSize = 16
        SuperButton.Parent = ContentFrame
        
        SuperButton.MouseButton1Click:Connect(superAttack)
        
    elseif tabName == "Troll" then
        -- Troll Button
        local TrollButton = Instance.new("TextButton")
        TrollButton.Size = UDim2.new(0.45, 0, 0.9, 0)
        TrollButton.Position = UDim2.new(0.025, 0, 0.05, 0)
        TrollButton.Text = "😂 Troll"
        TrollButton.TextColor3 = Color3.new(1, 1, 1)
        TrollButton.BackgroundColor3 = Color3.fromRGB(120, 30, 180)
        TrollButton.Font = Enum.Font.GothamBold
        TrollButton.TextSize = 16
        TrollButton.Parent = ContentFrame
        
        TrollButton.MouseButton1Click:Connect(trollPlayer)
        
        -- Balloons Button
        local BalloonButton = Instance.new("TextButton")
        BalloonButton.Size = UDim2.new(0.45, 0, 0.9, 0)
        BalloonButton.Position = UDim2.new(0.525, 0, 0.05, 0)
        BalloonButton.Text = "🎈 Balloons"
        BalloonButton.TextColor3 = Color3.new(1, 1, 1)
        BalloonButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        BalloonButton.Font = Enum.Font.GothamBold
        BalloonButton.TextSize = 16
        BalloonButton.Parent = ContentFrame
        
        BalloonButton.MouseButton1Click:Connect(spawnBalloons)
    end
end

-- Initialize first tab
updateContent("Attack")

-- Visual Effects
function createAnimeEffect(position, effectType)
    local effects = {
        slash = "rbxassetid://11388742277",
        explosion = "rbxassetid://11854647839",
        laugh = "rbxassetid://10907046825"
    }
    
    local part = Instance.new("Part")
    part.Anchored = true
    part.CanCollide = false
    part.Transparency = 1
    part.Size = Vector3.new(5, 5, 5)
    part.Position = position
    part.Parent = workspace

    local emote = Instance.new("Decal")
    emote.Face = "Top"
    emote.Texture = effects[effectType]
    emote.Parent = part

    game:GetService("Debris"):AddItem(part, 2)
end

-- Targeting System
function getClosestPlayer()
    local closest, dist = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local d = (p.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
            if d < dist then
                closest = p
                dist = d
            end
        end
    end
    return closest
end

-- Combat Functions
function animeAttack()
    local targetPlayer = getClosestPlayer()
    if targetPlayer and targetPlayer.Character then
        local target = targetPlayer.Character
        createAnimeEffect(character.HumanoidRootPart.Position, "slash")
        
        TweenService:Create(
            character.HumanoidRootPart,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
            {CFrame = CFrame.new(target.HumanoidRootPart.Position)}
        ):Play()
        
        task.wait(0.2)
        createAnimeEffect(target.HumanoidRootPart.Position, "explosion")
        target.Humanoid:TakeDamage(50)
        target.HumanoidRootPart:ApplyImpulse(Vector3.new(0, 500, 0))
    end
end

function superAttack()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            local target = p.Character
            createAnimeEffect(target.HumanoidRootPart.Position, "explosion")
            target.Humanoid:TakeDamage(30)
            target.HumanoidRootPart:ApplyImpulse(
                (target.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Unit * 100 + Vector3.new(0, 200, 0)
        end
    end
end

-- Troll Functions
function trollPlayer()
    local targetPlayer = getClosestPlayer()
    if targetPlayer and targetPlayer.Character then
        local target = targetPlayer.Character
        createAnimeEffect(target.HumanoidRootPart.Position, "laugh")
        target.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
    end
end

function spawnBalloons()
    local targetPlayer = getClosestPlayer()
    if targetPlayer and targetPlayer.Character then
        local target = targetPlayer.Character
        for i = 1, 10 do
            local balloon = Instance.new("Part")
            balloon.Size = Vector3.new(2, 3, 2)
            balloon.BrickColor = BrickColor.Random()
            balloon.Position = target.HumanoidRootPart.Position + Vector3.new(math.random(-5,5), 0, math.random(-5,5))
            balloon.Parent = workspace
            
            local tween = TweenService:Create(
                balloon,
                TweenInfo.new(3),
                {Position = balloon.Position + Vector3.new(0, 50, 0)}
            )
            tween:Play()
            game:GetService("Debris"):AddItem(balloon, 5)
        end
    end
end

-- Anime Character Effects
character.Archivable = true
local animeChar = character:Clone()
animeChar.Parent = workspace

for _, part in ipairs(animeChar:GetDescendants()) do
    if part:IsA("BasePart") then
        part.Transparency = 0.5
        part.BrickColor = BrickColor.new("Hot pink")
        part.Material = Enum.Material.Neon
    end
end

hum.Changed:Connect(function()
    animeChar:SetPrimaryPartCFrame(character.PrimaryPart.CFrame)
end)

-- Background Music
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://13827676125" -- Epic anime music
sound.Looped = true
sound.Parent = character.Head
sound:Play()
