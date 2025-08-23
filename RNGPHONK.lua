-- Phonk RNG Script using Rayfield UI by yarofav
-- Enhanced key system with modern UI

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local correctKey = "Ztag.inf"
local keyLink = "https://direct-link.net/1386295/x18O4Rt56sgl"

-- Modern key verification UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PhonkKeyGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = PlayerGui

-- Fullscreen blur effect
local blur = Instance.new("BlurEffect")
blur.Size = 20
blur.Parent = game:GetService("Lighting")

-- Background gradient
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.Position = UDim2.new(0, 0, 0, 0)
bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bg.BackgroundTransparency = 0.2
bg.ZIndex = 0
bg.Parent = screenGui

local gradient = Instance.new("UIGradient")
gradient.Rotation = 45
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 40)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 15, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 50))
}
gradient.Transparency = NumberSequence.new(0.5)
gradient.Parent = bg

-- Animated particles background
local particles = Instance.new("Frame")
particles.Size = UDim2.new(1, 0, 1, 0)
particles.Position = UDim2.new(0, 0, 0, 0)
particles.BackgroundTransparency = 1
particles.ZIndex = 1
particles.Parent = screenGui

-- Create floating particles
for i = 1, 15 do
    local particle = Instance.new("Frame")
    particle.Size = UDim2.new(0, 4, 0, 4)
    particle.Position = UDim2.new(0, math.random(0, 1000), 0, math.random(0, 600))
    particle.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    particle.BorderSizePixel = 0
    particle.ZIndex = 1
    particle.Parent = particles
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = particle
    
    -- Animate particles
    spawn(function()
        while particle and particle.Parent do
            for i = 0, 1, 0.01 do
                if not particle then break end
                particle.Position = particle.Position + UDim2.new(0, math.sin(tick() + i) * 0.5, 0, math.cos(tick() + i) * 0.5)
                particle.BackgroundTransparency = 0.5 + math.sin(tick() + i) * 0.3
                task.wait(0.05)
            end
        end
    end)
end

-- Modern container
local container = Instance.new("Frame")
container.Size = UDim2.new(0, 500, 0, 350)
container.Position = UDim2.new(0.5, -250, 0.5, -175)
container.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
container.BorderSizePixel = 0
container.ZIndex = 2
container.Parent = screenGui

-- Make container non-draggable by preventing mouse events from propagating
container.Active = true
container.Selectable = false

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 15)
uiCorner.Parent = container

-- Glow effect
local glow = Instance.new("ImageLabel")
glow.Image = "rbxassetid://5028851472"
glow.ScaleType = Enum.ScaleType.Slice
glow.SliceCenter = Rect.new(24, 24, 276, 276)
glow.ImageColor3 = Color3.fromRGB(70, 50, 150)
glow.ImageTransparency = 0.8
glow.Size = UDim2.new(1, 40, 1, 40)
glow.Position = UDim2.new(0, -20, 0, -20)
glow.BackgroundTransparency = 1
glow.ZIndex = 1
glow.Parent = container

-- Header with gradient
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 60)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
header.BorderSizePixel = 0
header.ZIndex = 3
header.Parent = container

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 15)
headerCorner.Parent = header

local headerGradient = Instance.new("UIGradient")
headerGradient.Rotation = 90
headerGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 30, 130)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 20, 90))
}
headerGradient.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 22
title.Text = "🎵 PHONK RNG AUTHENTICATION"
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 4
title.Parent = header

local subtitle = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 20)
title.Position = UDim2.new(0, 20, 0, 35)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(200, 200, 220)
title.Font = Enum.Font.Gotham
title.TextSize = 12
title.Text = "Enter your key to unlock the ultimate Phonk experience"
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 4
title.Parent = header

-- Content
local instructions = Instance.new("TextLabel")
instructions.Size = UDim2.new(1, -40, 0, 60)
instructions.Position = UDim2.new(0, 20, 0, 70)
instructions.BackgroundTransparency = 1
instructions.TextColor3 = Color3.fromRGB(200, 200, 220)
instructions.Font = Enum.Font.Gotham
instructions.TextSize = 14
instructions.TextWrapped = true
instructions.Text = "Get your access key from the link below. The key is required to use the Phonk RNG script features."
instructions.TextXAlignment = Enum.TextXAlignment.Left
instructions.ZIndex = 3
instructions.Parent = container

-- Key input
local inputContainer = Instance.new("Frame")
inputContainer.Size = UDim2.new(1, -40, 0, 50)
inputContainer.Position = UDim2.new(0, 20, 0, 140)
inputContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
inputContainer.BorderSizePixel = 0
inputContainer.ZIndex = 3
inputContainer.Parent = container

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 10)
inputCorner.Parent = inputContainer

local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(1, -20, 1, 0)
inputBox.Position = UDim2.new(0, 10, 0, 0)
inputBox.PlaceholderText = "Enter your access key here..."
inputBox.ClearTextOnFocus = false
inputBox.Text = ""
inputBox.Font = Enum.Font.Gotham
inputBox.TextSize = 16
inputBox.TextColor3 = Color3.new(1, 1, 1)
inputBox.BackgroundTransparency = 1
inputBox.ZIndex = 4
inputBox.Parent = inputContainer

inputBox.Focused:Connect(function()
    inputContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
end)

inputBox.FocusLost:Connect(function()
    inputContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
end)

-- Buttons container
local buttonsContainer = Instance.new("Frame")
buttonsContainer.Size = UDim2.new(1, -40, 0, 40)
buttonsContainer.Position = UDim2.new(0, 20, 0, 200)
buttonsContainer.BackgroundTransparency = 1
buttonsContainer.ZIndex = 3
buttonsContainer.Parent = container

-- Copy link button
local copyLinkButton = Instance.new("TextButton")
copyLinkButton.Size = UDim2.new(0, 180, 1, 0)
copyLinkButton.Position = UDim2.new(0, 0, 0, 0)
copyLinkButton.Text = "🌐 Copy Key Link"
copyLinkButton.Font = Enum.Font.GothamBold
copyLinkButton.TextSize = 14
copyLinkButton.TextColor3 = Color3.new(1, 1, 1)
copyLinkButton.BackgroundColor3 = Color3.fromRGB(70, 50, 150)
copyLinkButton.AutoButtonColor = false
copyLinkButton.ZIndex = 4
copyLinkButton.Parent = buttonsContainer

local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0, 8)
copyCorner.Parent = copyLinkButton

-- Hover effect for copy button
copyLinkButton.MouseEnter:Connect(function()
    game:GetService("TweenService"):Create(
        copyLinkButton, 
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(90, 70, 180)}
    ):Play()
end)

copyLinkButton.MouseLeave:Connect(function()
    game:GetService("TweenService"):Create(
        copyLinkButton, 
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(70, 50, 150)}
    ):Play()
end)

-- Submit button
local submit = Instance.new("TextButton")
submit.Size = UDim2.new(0, 120, 1, 0)
submit.Position = UDim2.new(1, -120, 0, 0)
submit.Text = "✅ Submit"
submit.Font = Enum.Font.GothamBold
submit.TextSize = 14
submit.TextColor3 = Color3.new(1, 1, 1)
submit.BackgroundColor3 = Color3.fromRGB(60, 180, 100)
submit.AutoButtonColor = false
submit.ZIndex = 4
submit.Parent = buttonsContainer

local submitCorner = Instance.new("UICorner")
submitCorner.CornerRadius = UDim.new(0, 8)
submitCorner.Parent = submit

-- Hover effect for submit button
submit.MouseEnter:Connect(function()
    game:GetService("TweenService"):Create(
        submit, 
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(80, 200, 120)}
    ):Play()
end)

submit.MouseLeave:Connect(function()
    game:GetService("TweenService"):Create(
        submit, 
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(60, 180, 100)}
    ):Play()
end)

-- Status
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -40, 0, 20)
status.Position = UDim2.new(0, 20, 0, 250)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.fromRGB(200, 200, 220)
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.Text = "Enter your key and press Submit to continue"
status.TextXAlignment = Enum.TextXAlignment.Left
status.ZIndex = 3
status.Parent = container

-- Progress bar background
local progressBarBg = Instance.new("Frame")
progressBarBg.Size = UDim2.new(1, -40, 0, 12)
progressBarBg.Position = UDim2.new(0, 20, 0, 280)
progressBarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
progressBarBg.BorderSizePixel = 0
progressBarBg.ZIndex = 3
progressBarBg.Parent = container

local progressBgCorner = Instance.new("UICorner")
progressBgCorner.CornerRadius = UDim.new(0, 6)
progressBgCorner.Parent = progressBarBg

-- Progress bar
local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.Position = UDim2.new(0, 0, 0, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
progressBar.BorderSizePixel = 0
progressBar.ZIndex = 4
progressBar.Parent = progressBarBg

local progressCorner = Instance.new("UICorner")
progressCorner.CornerRadius = UDim.new(0, 6)
progressCorner.Parent = progressBar

-- Animated progress bar gradient
local progressGradient = Instance.new("UIGradient")
progressGradient.Rotation = 90
progressGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 130, 180)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 160, 230))
}
progressGradient.Parent = progressBar

-- Functions
copyLinkButton.MouseButton1Click:Connect(function()
    setclipboard(keyLink)
    local originalText = copyLinkButton.Text
    copyLinkButton.Text = "📋 Copied to clipboard!"
    
    game:GetService("TweenService"):Create(
        copyLinkButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(100, 80, 200)}
    ):Play()
    
    task.wait(2)
    
    copyLinkButton.Text = originalText
    game:GetService("TweenService"):Create(
        copyLinkButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(70, 50, 150)}
    ):Play()
end)

local keyAccepted = false
local function checkKey(k)
    if k == correctKey then
        keyAccepted = true
        status.Text = "Key accepted! Loading..."
        
        -- Smooth progress animation
        for i = 0, 1, 0.01 do
            progressBar.Size = UDim2.new(i, 0, 1, 0)
            status.Text = "Loading... "..math.floor(i*100).."%"
            task.wait(0.02)
        end
        
        -- Fade out effect
        for i = 0, 1, 0.05 do
            container.BackgroundTransparency = i
            header.BackgroundTransparency = i
            inputContainer.BackgroundTransparency = i
            progressBarBg.BackgroundTransparency = i
            progressBar.BackgroundTransparency = i
            glow.ImageTransparency = 0.8 + i * 0.2
            task.wait(0.03)
        end
        
        screenGui:Destroy()
        blur:Destroy()
        return true
    else
        -- Shake animation for wrong key
        status.Text = "❌ Incorrect key! Please try again."
        inputBox.Text = ""
        
        local shakeTime = 0.5
        local shakeOffset = 5
        local originalPosition = container.Position
        
        for i = 0, shakeTime, 0.05 do
            container.Position = originalPosition + UDim2.new(0, math.random(-shakeOffset, shakeOffset), 0, math.random(-shakeOffset, shakeOffset))
            task.wait(0.05)
        end
        container.Position = originalPosition
        return false
    end
end

submit.MouseButton1Click:Connect(function()
    checkKey(inputBox.Text)
end)

inputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        checkKey(inputBox.Text)
    end
end)

-- Make sure the UI is always centered and not movable
game:GetService("RunService").RenderStepped:Connect(function()
    container.Position = UDim2.new(0.5, -250, 0.5, -175)
end)

repeat task.wait() until keyAccepted

-- ======= Остальная часть скрипта без изменений =======
-- [Здесь следует остальной код скрипта без изменений]
-- [Здесь следует остальной код скрипта без изменений]

-- ======= Основной скрипт Phonk RNG после загрузки =======
local Rayfield = nil
local ok, err = pcall(function()
    Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield', true))()
end)
if not ok or not Rayfield then
    Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source', true))()
end

local StarterGui = game:GetService("StarterGui")
local EquippedAura = LocalPlayer:WaitForChild("Equipped"):WaitForChild("Aura")
local Rolled = LocalPlayer:WaitForChild("Rolled")

local AuraSoundFolder = LocalPlayer:FindFirstChild("AuraSound") or Instance.new("Folder", LocalPlayer)
AuraSoundFolder.Name = "AuraSound"
local AuraSound = AuraSoundFolder:FindFirstChild("AuraSound") or Instance.new("Sound", AuraSoundFolder)
AuraSound.Name = "AuraSound"
AuraSound.Looped = true
AuraSound.Volume = 0.5

local AuraToggles = {}
local CurrentAura = nil
local LastCopiedAura = "None"
local AutoRollEnabled = false

local Window = Rayfield:CreateWindow({
    Name = "🎵 Phonk RNG Script",
    LoadingTitle = "Phonk RNG Hub",
    LoadingSubtitle = "Made with Rayfield",
    KeySystem = false,
})

-- Tabs
local TabAuras = Window:CreateTab("Auras", 4483362458)
local TabGame = Window:CreateTab("Game", 4483362458)
local TabTools = Window:CreateTab("Tools", 4483362458)
local TabFun = Window:CreateTab("Fun", 4483362458)
local TabCopy = Window:CreateTab("Copy Aura", 4483362458)
local TabMusic = Window:CreateTab("Aura Music", 4483362458)

-- ======= Функции =======
local function ResetAuras()
    for _, toggle in pairs(AuraToggles) do
        if toggle and toggle.Set then toggle:Set(false) end
    end
    CurrentAura = nil
end

local function RebuildAuraList()
    for _, toggle in pairs(AuraToggles) do
        if toggle and toggle.Destroy then toggle:Destroy() end
    end
    AuraToggles = {}

    local numericAuras, stringAuras = {}, {}
    for _, item in ipairs(Rolled:GetChildren()) do
        local name = item.Name
        if tonumber(name:match("%d+")) then
            table.insert(numericAuras, name)
        else
            table.insert(stringAuras, name)
        end
    end
    table.sort(numericAuras)
    table.sort(stringAuras)

    local finalList = {}
    for _, v in ipairs(numericAuras) do table.insert(finalList, v) end
    for _, v in ipairs(stringAuras) do table.insert(finalList, v) end

    for _, name in ipairs(finalList) do
        local Toggle = TabAuras:CreateToggle({
            Name = name,
            CurrentValue = (EquippedAura.Value == name),
            Callback = function(state)
                if state then
                    for otherName, otherToggle in pairs(AuraToggles) do
                        if otherName ~= name then otherToggle:Set(false) end
                    end
                    CurrentAura = name
                    EquippedAura.Value = name
                    AuraSound:Stop()
                    Rayfield:Notify({Title = "Aura Selected", Content = "Equipped: "..name, Duration = 2})
                else
                    if CurrentAura == name then
                        CurrentAura = nil
                        EquippedAura.Value = ""
                    end
                end
            end
        })
        AuraToggles[name] = Toggle
    end
end

RebuildAuraList()
Rolled.ChildAdded:Connect(RebuildAuraList)
Rolled.ChildRemoved:Connect(RebuildAuraList)

-- Copy Aura
TabCopy:CreateParagraph({Title = "Copy Aura Info", Content = "Type a player's name to copy their aura or hold for 2 seconds"})
local AuraStatus = TabCopy:CreateLabel("Last Copied Aura: "..LastCopiedAura)

TabCopy:CreateInput({
    Name = "Player Name",
    PlaceholderText = "Example: Player1",
    RemoveTextAfterFocusLost = false,
    Callback = function(input)
        local target
        for _, p in pairs(Players:GetPlayers()) do
            if string.find(p.Name:lower(), input:lower()) then target = p break end
        end
        if target then
            local equipped = target:FindFirstChild("Equipped")
            if equipped and equipped:FindFirstChild("Aura") then
                local auraValue = equipped.Aura.Value
                EquippedAura.Value = auraValue
                LastCopiedAura = auraValue
                AuraStatus:Set("Last Copied Aura: "..LastCopiedAura)
                Rayfield:Notify({Title="Copied", Content="Aura copied: "..auraValue, Duration=2})
                for name, toggle in pairs(AuraToggles) do toggle:Set(name==auraValue) end
            else
                Rayfield:Notify({Title="Error", Content="Target has no Aura.", Duration=2})
            end
        else
            Rayfield:Notify({Title="Error", Content="Player not found.", Duration=2})
        end
    end
})

TabCopy:CreateButton({Name="Enable Proximity Aura", Callback=function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            local prompt = Instance.new("ProximityPrompt")
            prompt.Name = "PhonkCopyPrompt"
            prompt.ActionText = "Hold to Copy Aura"
            prompt.ObjectText = player.Name
            prompt.RequiresLineOfSight = false
            prompt.MaxActivationDistance = 8
            prompt.HoldDuration = 2
            prompt.Parent = hrp

            prompt.Triggered:Connect(function(plr)
                if plr == LocalPlayer then
                    local equipped = player:FindFirstChild("Equipped")
                    if equipped and equipped:FindFirstChild("Aura") then
                        local auraValue = equipped.Aura.Value
                        EquippedAura.Value = auraValue
                        LastCopiedAura = auraValue
                        AuraStatus:Set("Last Copied Aura: "..LastCopiedAura)
                        Rayfield:Notify({Title="Copied via Proximity", Content="Aura copied: "..auraValue, Duration=2})
                        for name, toggle in pairs(AuraToggles) do toggle:Set(name==auraValue) end
                    end
                end
            end)

            game:GetService("Debris"):AddItem(prompt, 6)
        end
    end
end})

-- Game Tab
TabGame:CreateButton({Name="Teleport to Charm 1", Callback=function()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    if char.PrimaryPart == nil then
        char:WaitForChild("HumanoidRootPart")
        char.PrimaryPart = char:FindFirstChild("HumanoidRootPart")
    end
    char:SetPrimaryPartCFrame(CFrame.new(93.9420929,206.313431,-362.343933,1,0,0,0,1,0,0,0,1))
    Rayfield:Notify({Title="Teleported", Content="Teleported to Charm 1", Duration=2})
end})

TabGame:CreateButton({Name="Teleport to Charm 2", Callback=function()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    if char.PrimaryPart == nil then
        char:WaitForChild("HumanoidRootPart")
        char.PrimaryPart = char:FindFirstChild("HumanoidRootPart")
    end
    char:SetPrimaryPartCFrame(CFrame.new(-191.257889,206.213348,-352.611938,1,0,0,0,1,0,0,0,1))
    Rayfield:Notify({Title="Teleported", Content="Teleported to Charm 2", Duration=2})
end})

TabGame:CreateToggle({Name="Auto Roll", CurrentValue=false, Callback=function(state)
    AutoRollEnabled = state
    Rayfield:Notify({Title="Auto Roll", Content=(state and "Enabled" or "Disabled"), Duration=2})
    spawn(function()
        while AutoRollEnabled do
            local args={true}
            local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
            if playerGui and playerGui:FindFirstChild("MainGui") then
                pcall(function()
                    playerGui:WaitForChild("MainGui"):WaitForChild("Rolling"):WaitForChild("Rolling"):FireServer(unpack(args))
                end)
            end
            task.wait(0.1)
        end
    end)
end})

-- Tools
TabTools:CreateButton({Name="Load Infinite Yield", Callback=function()
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/DarkNetworks/Infinite-Yield/main/latest.lua'))()
    end)
    Rayfield:Notify({Title="Loaded", Content="Infinite Yield executed.", Duration=2})
end})

TabTools:CreateButton({Name="Copy Place ID", Callback=function()
    setclipboard(tostring(game.PlaceId))
    Rayfield:Notify({Title="Copied", Content="Place ID copied.", Duration=2})
end})

TabTools:CreateButton({Name="Copy Your User ID", Callback=function()
    setclipboard(tostring(LocalPlayer.UserId))
    Rayfield:Notify({Title="Copied", Content="User ID copied.", Duration=2})
end})

-- Fun
TabFun:CreateToggle({Name="Rainbow Body", CurrentValue=false, Callback=function(state)
    spawn(function()
        while state do
            local char = LocalPlayer.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.Color = Color3.fromHSV((tick()%5)/5,1,1)
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end})

TabFun:CreateToggle({Name="ESP (Highlight Players)", CurrentValue=false, Callback=function(state)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if state then
                local char = player.Character or player.CharacterAdded:Wait()
                if not char:FindFirstChild("PhonkESP_Highlight") then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "PhonkESP_Highlight"
                    highlight.FillColor = Color3.new(1, 0, 0)
                    highlight.OutlineColor = Color3.new(1, 1, 1)
                    highlight.Parent = char
                end
            else
                if player.Character and player.Character:FindFirstChild("PhonkESP_Highlight") then
                    player.Character.PhonkESP_Highlight:Destroy()
                end
            end
        end
    end
end})

-- Aura Music
local musicList = {
    {Name="BRR BRR PATAPIM", ID="83630219580953"},
    {Name="Brainz Funk", ID="70586618643318"},
    {Name="City Lightz Pr Funk", ID="81068115852250"},
    {Name="Funk Diamante Enigma", ID="113208690604605"},
    {Name="Goth Funk", ID="140704128008979"},
    {Name="Nadie Sale de Aqui Funk", ID="95480320349659"},
    {Name="Atmospherika Funk", ID="136295506080844"},
    {Name="Bankai Funk", ID="129078347843179"},
    {Name="Above Phonk", ID="89824897586105"}
}

TabMusic:CreateParagraph({Title="Note", Content="Some tracks may not work due to copyright restrictions"})

for _, track in ipairs(musicList) do
    TabMusic:CreateButton({Name=track.Name, Callback=function()
        AuraSound.SoundId = "rbxassetid://" .. track.ID
        AuraSound:Play()
        EquippedAura.Value = ""
    end})
end

TabMusic:CreateInput({Name="Custom Sound ID", PlaceholderText="Enter Roblox Sound ID", RemoveTextAfterFocusLost=false, Callback=function(id)
    if tonumber(id) then
        AuraSound.SoundId = "rbxassetid://" .. id
        AuraSound:Play()
        EquippedAura.Value = ""
    end
end})
