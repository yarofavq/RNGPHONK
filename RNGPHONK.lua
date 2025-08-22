-- Phonk RNG Script using Rayfield UI by yarofav
-- Key check (link + password)
local correctKey = "Ztag.inf"
local keyLink = "https://direct-link.net/1386295/x18O4Rt56sgl"

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local function requestKey()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "PhonkKeyGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = PlayerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 520, 0, 160)
    frame.Position = UDim2.new(0.5, -260, 0.5, -80)
    frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    local uic = Instance.new("UICorner", frame)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, -20, 0, 40)
    title.Position = UDim2.new(0, 10, 0, 10)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.new(1,1,1)
    title.TextScaled = false
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.Text = "Enter Key to Use Script"

    local info = Instance.new("TextLabel", frame)
    info.Size = UDim2.new(1, -20, 0, 48)
    info.Position = UDim2.new(0, 10, 0, 48)
    info.BackgroundTransparency = 1
    info.TextColor3 = Color3.new(1,1,1)
    info.TextWrapped = true
    info.Font = Enum.Font.Gotham
    info.TextSize = 14
    info.Text = "Get key at:\n" .. keyLink .. "\nPassword for archive: Ztag.inf"

    local inputBox = Instance.new("TextBox", frame)
    inputBox.Size = UDim2.new(1, -120, 0, 32)
    inputBox.Position = UDim2.new(0, 10, 0, 108)
    inputBox.PlaceholderText = "Enter key here"
    inputBox.ClearTextOnFocus = false
    inputBox.Text = ""
    inputBox.Font = Enum.Font.Gotham
    inputBox.TextSize = 18
    inputBox.TextColor3 = Color3.new(1,1,1)
    inputBox.BackgroundColor3 = Color3.fromRGB(45,45,45)
    Instance.new("UICorner", inputBox)

    local submit = Instance.new("TextButton", frame)
    submit.Size = UDim2.new(0, 90, 0, 32)
    submit.Position = UDim2.new(1, -100, 0, 108)
    submit.Text = "Submit"
    submit.Font = Enum.Font.GothamBold
    submit.TextSize = 18
    submit.TextColor3 = Color3.new(1,1,1)
    submit.BackgroundColor3 = Color3.fromRGB(70,130,180)
    Instance.new("UICorner", submit)

    local status = Instance.new("TextLabel", frame)
    status.Size = UDim2.new(1, -20, 0, 14)
    status.Position = UDim2.new(0, 10, 0, 144)
    status.BackgroundTransparency = 1
    status.TextColor3 = Color3.fromRGB(200,200,200)
    status.Font = Enum.Font.Gotham
    status.TextSize = 13
    status.Text = "Enter the key and press Submit."

    local keyAccepted = false

    local function checkKey(k)
        if k == correctKey then
            keyAccepted = true
            screenGui:Destroy()
            return true
        else
            status.Text = "Incorrect key. Get key at: " .. keyLink
            inputBox.Text = ""
            return false
        end
    end

    submit.MouseButton1Click:Connect(function()
        checkKey(inputBox.Text)
    end)

    -- also allow Enter key
    inputBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            checkKey(inputBox.Text)
        end
    end)

    repeat task.wait() until keyAccepted
end

-- Request key before continuing
requestKey()

-- Load Rayfield
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

-- Aura Sound folder & sound
local AuraSoundFolder = LocalPlayer:FindFirstChild("AuraSound") or Instance.new("Folder", LocalPlayer)
AuraSoundFolder.Name = "AuraSound"
local AuraSound = AuraSoundFolder:FindFirstChild("AuraSound") or Instance.new("Sound", AuraSoundFolder)
AuraSound.Name = "AuraSound"
AuraSound.Looped = true
AuraSound.Volume = 0.5

-- Variables
local AuraToggles = {}
local CurrentAura = nil
local LastCopiedAura = "None"
local AutoRollEnabled = false

-- Create window
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

-- Functions
local function ResetAuras()
    for _, toggle in pairs(AuraToggles) do
        if toggle and toggle.Set then toggle:Set(false) end
    end
    CurrentAura = nil
end

local function RebuildAuraList()
    -- destroy old toggles
    for _, toggle in pairs(AuraToggles) do
        if toggle and toggle.Destroy then toggle:Destroy() end
    end
    AuraToggles = {}

    -- collect numeric first then strings
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

-- Give proximity prompts to all players (press to copy aura)
TabCopy:CreateButton({Name="Enable Proximity Aura", Callback=function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            -- create temporary prompt
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

            game:GetService("Debris"):AddItem(prompt, 6) -- prompt exists for 6 seconds
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
