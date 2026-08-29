local function notifsound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://131390520971848" -- Your sound ID
    sound.Volume = 1 -- 0 to 1
    sound.Parent = workspace -- Where the sound lives
    sound:Play()
    task.wait(2)
    sound:Destroy()
end

local NeverLose = loadstring(game:HttpGet("https://raw.githubusercontent.com/8273952/I-cant-afford-blahaj/refs/heads/main/source.luau"))()
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
local Ping = Plr:GetNetworkReachabilityPing()
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

local Notification = NeverLose:CreateNotification();
local Logging = NeverLose:CreateLogger();
local Indicator = NeverLose:CreateIndicator();
local window = NeverLose:CreateWindow({
	Logo = NeverLose.GlobalLogo,
	Name = "Nom nom nom",
	Content = "Demonology",
	Size = NeverLose.Scales.Auto,
	ConfigFolder = "NeverLoseConfigs",
	Enable3DRenderer = false,
	Keybind = "RightControl"
});

local Watermark = window:Watermark();
Watermark:SetRender(true);

local pingBlock = Watermark:AddBlock("chart-four-vertical-bars" , "0MS");

task.spawn(function()
    while true do
        Ping = math.round(Plr:GetNetworkReachabilityPing() * 1000)
        pingBlock:SetText(tostring(ping) .. "MS")
        task.wait(1)
    end
end)

-- tabs --
local Tabs = {
    Main = window:AddTab({
    	Icon = 'person',
    	Name = "Main",
    })
}
-- Sections --
local Sections = {
    Character = Tabs.Main:AddSection({
	    Name = "Character",
        Position = 'left'
    })
}

-- toggles and stuff --
local Labels = {
    Walkspeed = Sections.Character:AddLabel('Walkspeed')
}

