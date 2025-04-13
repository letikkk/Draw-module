local Draw = {}

Draw.__index = Draw

type tableOfTypes = {
	Material: Enum.Material;
	Shape: Enum.PartType;
	Color:Color3;
	Size:Vector3;
}

local Parts = {
	
}


function Draw.Started(character, infos: tableOfTypes, mousePos)
	
	local self = setmetatable({}, Draw)
	
	self.Char = character
	self.RootPart = character.HumanoidRootPart
	self.Material = infos.Material
	self.Shape = infos.Shape
	self.Color = infos.Color
	self.Size = infos.Size
	
	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	rayParams.FilterDescendantsInstances = {self.RootPart, Parts, workspace.DrawParts}
	
	local RayRes = workspace:Raycast(mousePos.Origin, mousePos.Direction * 1000, rayParams)
	
	if RayRes then
		local Part = Instance.new("Part")
		Part.Shape = self.Shape
		Part.Size = self.Size
		Part.Material = self.Material
		Part.Color = self.Color
		Part.Anchored = true
		Part.CanCollide = false
		Part.Parent = workspace.DrawParts
		Part.Position = RayRes.Position
		table.insert(Parts, Part)
		task.delay(5, function()
			Part:Destroy()
		end)
	end

return self

end


return Draw
