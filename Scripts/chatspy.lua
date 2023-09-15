enabled = true
spyOnMyself = true
publicItalics = false

local Version = "1.5"
local Players = game:GetService("Players")
local player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() or Players.LocalPlayer
local saymsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
local getmsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering")
local bullshit = "GJGJGJGJGJGGJGJGJGGJGJJJJGJGJGJJJGJGJGJGJGJGJJGGJJGJGJGJGJGJ"
local instance = (_G.chatSpyInstance or 0) + 1
local timeInfo = os.date("*t")
local date_table = os.date("*t")
local monthTable = {
  "January",
  "February",
  "March",
  "April",
   "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
}

_G.chatSpyInstance = instance
local function onChatted(p,msg)
	if _G.chatSpyInstance == instance then
		if p==player and msg:lower():sub(1,6)=="/e .. bullshit .. " then
			enabled = not enabled
			wait(0.3)
			rconsoleprint("\n("..timeInfo.hour ..":".. timeInfo.min .. ") [Hidden Spy "..(enabled and "En" or "Dis").."abled]")
			StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
	    	elseif enabled and (spyOnMyself==true or p~=player) then
			msg = msg:gsub("[\n\r]",''):gsub("\t",' '):gsub("[ ]+",' ')
			local hidden = true
			local conn = getmsg.OnClientEvent:Connect(function(packet,channel)
			if packet.SpeakerUserId==p.UserId and packet.Message==msg:sub(#msg-#packet.Message+1) and (channel=="All" or (channel=="Team" and public==false and p.Team==player.Team)) then
			hidden = false
			end end)
			wait(1)
			conn:Disconnect()
			if hidden and enabled then
			rconsoleprint("\n("..timeInfo.hour ..":".. timeInfo.min .. ") [Hidden Spy] [".. p.Name .."]: "..msg)
          end
      end
   end
end

for _,p in ipairs(Players:GetPlayers()) do
	p.Chatted:Connect(function(msg) onChatted(p,msg) end)
end
Players.PlayerAdded:Connect(function(p)
	p.Chatted:Connect(function(msg) onChatted(p,msg) end)
end)


rconsoleprint("\n("..timeInfo.hour ..":".. timeInfo.min .. ") [Hidden Spy "..(enabled and "En" or "Dis").."abled]")
player:WaitForChild("PlayerGui"):WaitForChild("Chat")

rconsolename("Hidden Chat Spy | Version: " .. Version .. " | User: " .. game.Players.LocalPlayer.DisplayName.. " | Date: "..monthTable[date_table.month].." "..date_table.day..", "..date_table.year .. " | Credits: jailedd")
