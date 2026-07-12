local GhostHuntChecker
Exploits:Toggle({
  Flag = "ghosthuntcheckToggle",
  Title = "Bypass Ghost Hunt",
  Value = false,
  Callback = function(value)
        if value then
            local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
            local truck = game.Workspace.Map.Rooms["Base Camp"].Truck.Primary
            GhostHuntChecker = game.DescendantAdded:Connect(function(sound)
                if sound:IsA("Sound") then
                    if sound.SoundId == "rbxassetid://89871052622148" then
                        hrp.CFrame = truck.CFrame
                        WindUI:Notify({
                          Title = "Notifier",
                          Content = "ghost hunt",
                          Icon = "solar:bell-bold",
                          Duration = 2,
                        })
                    end
                end
            end)
        else
            GhostHuntChecker:Disconnect()
            GhostHuntChecker = nil
            print("Disabled ghost hunt stuff")
        end
  end,
})
