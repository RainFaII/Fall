getgenv().Settings = {
   ["BodyPart"] = "Head";
   ["FOVCircle"] = true;
   
   ["Thickness"] = 1.5;
   ["Rounding"] = 100;
   ["Color"] = 255,0,0;
   ["FOV"] = 120;
};



local Settings = getgenv().Settings;
local CharTable, Network, ModuleLoader, Old, OldIndex, LoadedModules;
local Players = game:GetService("Players");
local Player = Players.LocalPlayer;
local Camera = workspace.CurrentCamera;
local Mouse = Player:GetMouse();
local RunService = game:GetService("RunService");

ModuleLoader = require(game:GetService("ReplicatedStorage").Modules.Shared.ModuleLoader);
LoadedModules = ModuleLoader.LoadedModules;

for Index, Value in next, getgc(true) do
   if (type(Value) == "function") and (islclosure(Value)) and (debug.getinfo(Value).name == "NewChar") then
       Characters = getupvalue(Value, 1);
   end;
end;


Network = LoadedModules.Network;
local Old = Network.FireServer;

local Circle = Drawing.new("Circle");
Circle.Radius = getgenv().Settings.FOV;
Circle.Visible = getgenv().Settings.FOVCircle;
Circle.Thickness = getgenv().Settings.Thickness;
Circle.NumSides = getgenv().Settings.Rounding;
Circle.Color = Color3.fromRGB(getgenv().Settings.Color);

local function GetNearest()

   Targets = {};

   for Index, Value in next, Players:GetPlayers() do
           if (Value ~= Player) and (Value.SelectedTeam.Value ~= Player.SelectedTeam.Value) then
           if (not Characters[Value]) then continue end; -- Ignore the "continue" error it doesn't actually break anything!
           local Char = Characters[Value];
           if (not Char:FindFirstChild(Settings.BodyPart)) then continue end;

           Distance = (Char.HumanoidRootPart.CFrame.p - Camera.CFrame.p).Magnitude;
           worldPoint = Char.Head.Position;
           vector, onScreen = Camera:WorldToScreenPoint(worldPoint);
           magnitude = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(vector.X, vector.Y)).Magnitude;
   
           if (magnitude > Settings["FOV"]) then continue end;

           table.insert(Targets, {Value, Distance, Char:FindFirstChild(Settings.BodyPart)});
       end;
   end;

   if (#Targets > 1) then
    table.sort(Targets, function(a, b)
        return a[2] < b[2];
       end);
   end;

   if (#Targets == 0) then
       return nil;
   end;

   return Targets[1][3];
end;

local function ResolveRotation(Target)
  return CFrame.new(Camera.CFrame["p"], Target.CFrame["p"]);
end;

local function WTS(Object)
   local Screen = Camera:WorldToViewportPoint(Object)
   return Vector2.new(Screen.x, Screen.y);
end;

Network.FireServer = function(...)
   local Args = {...};

    if (Args[2] == "FireBullet") then

       local Nearest = GetNearest()

       if (not Nearest) then
           return Old(...);
       end;

       ResolvedRotation = ResolveRotation(Nearest);
       Args[3][1].OriginCFrame = ResolvedRotation;
       Args[3][1].RotationMatrix = ResolvedRotation - ResolvedRotation["p"];

       return Old(unpack(Args));
 
   end;

   return Old(...);
end;

RunService.Stepped:Connect(function()
   Circle.Visible = getgenv().Settings.FOVCircle;
   Circle.Radius = getgenv().Settings.FOV;
   Circle.Position = WTS(Mouse.hit.p);
end);
