local function notifsound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://131390520971848" -- Your sound ID
    sound.Volume = 1 -- 0 to 1
    sound.Parent = workspace -- Where the sound lives
    sound:Play()
    task.wait(2)
    sound:Destroy()
end

local repo = 'https://raw.githubusercontent.com/8273952/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/8273952/ESPLibrary/refs/heads/main/Library.lua"))()

ESPLibrary:SetTextSize(11)
ESPLibrary:SetFillTransparency(0.7)
ESPLibrary:SetOutlineTransparency(0)
ESPLibrary:SetTextTransparency(0)
ESPLibrary:SetTextOutlineTransparency(1)
ESPLibrary:SetFadeTime(0.25)
ESPLibrary:SetFont(Enum.Font.GothamSemibold)
ESPLibrary:SetMatchColors(true)
ESPLibrary:SetTracerOrigin("Bottom")
ESPLibrary:SetTracerSize(0.1)
ESPLibrary:SetDistanceSizeRatio(1)
ESPLibrary:SetShowDistance(true)
ESPLibrary:SetTracers(true)
ESPLibrary:SetArrows(false)
ESPLibrary:SetArrowRadius(250)

local Chr
local Plr = game:GetService("Players").LocalPlayer
local Hum
local Hrp
local Camera = game:GetService("Workspace").CurrentCamera
local Lighting = game:GetService("Lighting")
local OldAmbient = Lighting.Ambient
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local function NewChr(NewChr)
    Chr = NewChr
    Hum = NewChr:WaitForChild("Humanoid")
    Hrp = NewChr:WaitForChild("HumanoidRootPart")
end

if Plr.Character then
    NewChr(Plr.Character)
end

Plr.CharacterAdded:Connect(function(NewCharacter)
    NewChr(NewCharacter)
end)

-- create ui --

local Window = Library:CreateWindow({
    Title = 'Demonology',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

-- tabs --

Main = Window:AddTab('Main'),
['UI Settings'] = Window:AddTab('UI Settings'),

-- GB and TB --

local CharacterGB = Tabs.Main:AddLeftGroupbox('Groupbox')

-- Toggles and stuff(Main)

getgenv().WalkspeedSliderValue = 2
LeftGroupBox:AddSlider('WalkspeedSlider', {
    Text = 'Walkspeed',
    Default = 2,
    Min = 2,
    Max = 100,
    Rounding = 0.1,
    Compact = false,

    Callback = function(Value)
    end
})

Options.WalkspeedSlider:OnChanged(function()
    getgenv().WalkspeedSliderValue = Options.MySlider.Value
end)

local WalkspeedLoop
CharacterGB:AddToggle('WalkspeedToggle', {
    Text = 'Enable',
    Default = false,
    Tooltip = 'Makes you move faster',

    Callback = function(Value)
    end
})

Toggles.WalkspeedToggle:OnChanged(function()
    if Toggles.WalkspeedToggle.Value then
        WalkspeedLoop = RunService.RenderStepped:Connect(function()
            Hum.WalkSpeed = getgenv().WalkspeedSliderValue
        end)
    else
        if WalkspeedLoop then
            WalkspeedLoop:Disconnect()
            WalkspeedLoop = nil
        end
    end
end)
