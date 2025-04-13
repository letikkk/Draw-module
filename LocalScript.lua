local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local DrawAnything = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("DrawAnything"))
local connection = nil
if not game:IsLoaded() then
	game.Loaded:Wait()
end



local Table = {
	Material = Enum.Material.Neon;
	Shape = Enum.PartType.Cylinder;
	Color = Color3.fromRGB(12, 150, 255);
	Size = Vector3.new(0.1, 10, 0.1)
}

local plr = game.Players.LocalPlayer
local Gui = plr.PlayerGui
local Char = plr.Character or plr.CharacterAdded:Wait()
local Camera = workspace.CurrentCamera

--[[local ColorGui = Gui.ColorChange


for i, v in pairs(ColorGui:GetChildren()) do
	v:GetPropertyChangedSignal("Text"):Connect(function()
		local R = tonumber(ColorGui.R.Text)
		local G = tonumber(ColorGui.G.Text)
		local B = tonumber(ColorGui.B.Text)
		
		Table.Color = Color3.fromRGB(R, G, B)
	end)
end]]

UserInputService.InputBegan:Connect(function(input, gpe)
	if input.UserInputType ~= Enum.UserInputType.MouseButton1 or gpe then return end
	connection = RunService.Heartbeat:Connect(function()
		local Pos2d = UserInputService:GetMouseLocation()
		local Ray3d = Camera:ViewportPointToRay(Pos2d.X, Pos2d.Y)
		DrawAnything.Started(Char, Table, Ray3d)

	end)
end)

UserInputService.InputEnded:Connect(function(input, gpe)
	if input.UserInputType ~= Enum.UserInputType.MouseButton1 or gpe then return end
	
	if connection then
		connection:Disconnect()
		connection = nil
	end
end)

