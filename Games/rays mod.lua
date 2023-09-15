
getgenv().settings = {
   godmode = true,
   pitch = 1,
   distortion = 1,
   volume = 1,
   audio = 2665514874,
}


local args = {
    [1] = getgenv().settings.pitch
}
game:GetService("Players").LocalPlayer.PlayerGui.RadioGui.audioframe.Pitch.SliderObject.ComparableValue.RemoteEvent:FireServer(unpack(args))
local args = {
    [1] = getgenv().settings.distortion
}
game:GetService("Players").LocalPlayer.PlayerGui.RadioGui.audioframe.DistortionSoundEffect.Slider.SliderObject.ComparableValue.RemoteEvent:FireServer(unpack(args))
local args = {
    [1] = getgenv().settings.volume
}
game:GetService("Players").LocalPlayer.PlayerGui.RadioGui.audioframe.Volume.SliderObject.ComparableValue.RemoteEvent:FireServer(unpack(args))
local args = {
    [1] = getgenv().settings.audio
}
game:GetService("ReplicatedStorage").RadioEvent:FireServer(unpack(args))


while getgenv().settings.godmode == true do
 task.wait()
   game:GetService("ReplicatedStorage").MoreHealth:FireServer() -- best security fr fr
 task.wait()
end
