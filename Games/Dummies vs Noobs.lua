
_G.target = "head" -- Torso or Head
_G.extensionsize = 4.5
_G.parttransparency = 0.6

if game.PlaceId == 8657806289 then
print("Hitbox expander executed")

if not game:IsLoaded() then
   game.Loaded:Wait();
end

local enemyNames = game:GetService("ReplicatedStorage").Units.Noobs:GetChildren()
local mapFolder = game:GetService("Workspace").Map

local function PutOnExtend(instance)
 for _, x in ipairs(enemyNames) do
   if tostring(x) == instance.Name and instance ~= nil then
if _G.target == "Torso" then -- TORSO
   instance.Torso.Transparency = _G.parttransparency
   instance.Torso.Size = Vector3.new(_G.extensionsize, _G.extensionsize, _G.extensionsize)
end
if _G.target == "torso" then
   instance.Torso.Transparency = parttransparency
   instance.Torso.Size = Vector3.new(_G.extensionsize, _G.extensionsize, _G.extensionsize)
end

if _G.target == "Head" then -- HEAD
   instance.Head.Transparency = _G.parttransparency
   instance.Head.Size = Vector3.new(_G.extensionsize, _G.extensionsize, _G.extensionsize)
end
if _G.target == "head" then
   instance.Head.Transparency = _G.parttransparency
   instance.Head.Size = Vector3.new(_G.extensionsize, _G.extensionsize, _G.extensionsize)
         end
      end
   end
end

for _, v in ipairs(workspace:GetChildren()) do
    task.wait()
    PutOnExtend(v)
end

workspace.ChildAdded:Connect(function(v)
    task.wait()
    PutOnExtend(v)
end)

end -- end of game check
