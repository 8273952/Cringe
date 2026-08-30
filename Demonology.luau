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

local Notification = NeverLose:CreateNotification();
local Logging = NeverLose:CreateLogger();
local Indicator = NeverLose:CreateIndicator();

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
local Ghost = Workspace.Ghost
local Truck = Workspace.Map.Rooms["Base Camp"].Truck.Primary

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

local window = NeverLose:CreateWindow({
	Logo = NeverLose.GlobalLogo,
	Name = "Idk hub",
	Content = "Demonology",
	Size = NeverLose.Scales.Auto,
	ConfigFolder = "NeverLoseConfigs",
	Enable3DRenderer = false,
	Keybind = "RightControl"
});

-- watermarks --

local Watermark = window:Watermark();
local UIToggle = Watermark:AddBlock("circle-x", "Idk hub");

UIToggle:Input(function()
	window:ToggleInterface()
end)

-- tabs --

local Tabs = {
    Main = window:AddTab({
    	Icon = 'person',
    	Name = "Main",
    }),

	Visuals = window:AddTab({
    	Icon = 'eye',
    	Name = "Visuals",
    })
}

-- Sections --

local Sections = {
    Character = Tabs.Main:AddSection({
	    Name = "Character",
        Position = 'left'
    }),

    Game = Tabs.Main:AddSection({
	    Name = "Game",
        Position = 'right'
    }),

	Player = Tabs.Visuals:AddSection({
	    Name = "Player",
        Position = 'left'
    })
}

-- toggles and stuff(Main tab) --

local Labels = {
	WalkspeedValue = Sections.Character:AddLabel(''),
    Walkspeed = Sections.Character:AddLabel('Walkspeed'),
	Noclip = Sections.Character:AddLabel('Noclip'),
	AntiGhostHunt = Sections.Game:AddLabel('Anti Chost Hunt')
}

local WalkspeedLoop
getgenv().WalkspeedSliderValue = 35
Labels.WalkspeedValue:AddSlider({
	Min = 2,
	Max = 100,
	Rounding = 1,
	Default = 35,
	Type = "",
	Size = 180,
	Callback = function(value)
		getgenv().WalkspeedSliderValue = value
	end,
	Flag = "WalkspeedSlider",
})

Labels.Walkspeed:AddToggle({
	Default = false,
	Callback = function(value)
		if value then
			WalkspeedLoop = RunService.RenderStepped:Connect(function()
				Hum.WalkSpeed = getgenv().WalkspeedSliderValue
			end)
		else
			if WalkspeedLoop then
				WalkspeedLoop:Disconnect()
				WalkspeedLoop = nil
			end

			Hum.WalkSpeed = 15
		end
	end,
	Flag = "WalkspeedToggle",
})

local NoclipLoop
Labels.Noclip:AddToggle({
	Default = false,
	Callback = function(value)
		if value then
			NoclipLoop = RunService.RenderStepped:Connect(function()
				for _, part in ipairs(Chr:GetDescendants()) do
					if part and part:IsA("BasePart") then
						if part and part.CanCollide == true then
							part.CanCollide = false
						end
					end
				end
			end)
		else
			if NoclipLoop then
				NoclipLoop:Disconnect()
				NoclipLoop = nil
			end

			for _, part in ipairs(Chr:GetDescendants()) do
				if part and part:IsA("BasePart") then
					if part and part.CanCollide == false then
						part.CanCollide = true
					end
				end
			end
		end
	end,
	Flag = "NoclipToggle",
})

local GhostHuntChecker
Labels.AntiGhostHunt:AddToggle({
	Default = false,
	Callback = function(value)
		if value then
			GhostHuntChecker = Ghost:GetAttributeChangedSignal("Hunting"):Connect(function()
				if Ghost:GetAttribute("Hunting") == true then
					Hrp.CFrame = Truck.CFrame + CFrame.new(0, 3, 0)

					Notification.new({
						Title = "Idk hub",
						Content = "Ghost hunt started",
						Duration = 1.5,  -- seconds
					})
					notifsound()
				end
			end)
		else

		end
	end,
	Flag = "AntiGhostHuntToggle",
})
