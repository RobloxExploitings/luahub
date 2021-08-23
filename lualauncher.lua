-- Gui to Lua
-- Version: 3.2

-- Instances:

local LuahubLauncher = Instance.new("ScreenGui")
local main = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local title = Instance.new("Frame")
local text = Instance.new("TextLabel")
local launchbutton = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local exitbutton = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local credits = Instance.new("TextLabel")
local UICorner_4 = Instance.new("UICorner")

--Properties:

LuahubLauncher.Name = "LuahubLauncher"
LuahubLauncher.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
LuahubLauncher.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

main.Name = "main"
main.Parent = LuahubLauncher
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.Position = UDim2.new(0.378020257, 0, 0.413496941, 0)
main.Size = UDim2.new(0, 313, 0, 141)

UICorner.Parent = main

title.Name = "title"
title.Parent = main
title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1.000
title.Size = UDim2.new(0, 313, 0, 29)

text.Name = "text"
text.Parent = title
text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
text.BackgroundTransparency = 1.000
text.BorderSizePixel = 0
text.Position = UDim2.new(0.025559105, 0, 0, 0)
text.Size = UDim2.new(0, 297, 0, 27)
text.Font = Enum.Font.Gotham
text.Text = "LuaHub - Launcher"
text.TextColor3 = Color3.fromRGB(255, 255, 255)
text.TextSize = 14.000
text.TextWrapped = true
text.TextXAlignment = Enum.TextXAlignment.Left

launchbutton.Name = "launchbutton"
launchbutton.Parent = main
launchbutton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
launchbutton.BorderSizePixel = 0
launchbutton.Position = UDim2.new(0.0223642178, 0, 0.19026649, 0)
launchbutton.Size = UDim2.new(0, 305, 0, 29)
launchbutton.Font = Enum.Font.SourceSans
launchbutton.Text = "Launch {game.name} script"
launchbutton.TextColor3 = Color3.fromRGB(255, 255, 255)
launchbutton.TextSize = 16.000
launchbutton.TextWrapped = true
launchbutton.TextXAlignment = Enum.TextXAlignment.Left

UICorner_2.Parent = launchbutton

exitbutton.Name = "exitbutton"
exitbutton.Parent = main
exitbutton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
exitbutton.BorderSizePixel = 0
exitbutton.Position = UDim2.new(0.0222148299, 0, 0.448326796, 0)
exitbutton.Size = UDim2.new(0, 305, 0, 29)
exitbutton.Font = Enum.Font.SourceSans
exitbutton.Text = "Exit LuaHub Launcher."
exitbutton.TextColor3 = Color3.fromRGB(255, 255, 255)
exitbutton.TextSize = 16.000
exitbutton.TextWrapped = true
exitbutton.TextXAlignment = Enum.TextXAlignment.Left

UICorner_3.Parent = exitbutton

credits.Name = "credits"
credits.Parent = main
credits.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
credits.Position = UDim2.new(0.0191693306, 0, 0.702127635, 0)
credits.Size = UDim2.new(0, 305, 0, 29)
credits.Font = Enum.Font.SourceSans
credits.Text = "This script was made by Lua."
credits.TextColor3 = Color3.fromRGB(255, 255, 255)
credits.TextSize = 16.000
credits.TextWrapped = true
credits.TextXAlignment = Enum.TextXAlignment.Left

UICorner_4.Parent = credits

-- Scripts:

local function CYVEKNI_fake_script() -- main.Dragify 
	local script = Instance.new('LocalScript', main)

	local UIS = game:GetService("UserInputService")
	local dragSpeed = -math.huge
	
	local dragToggle = nil
	local dragInput = nil
	local dragStart = nil
	local dragPos = nil
	
	function dragify(Frame)
		function updateInput(input)
	        local Delta = input.Position - dragStart
	        local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
	        script.Parent.Position = Position
		end
		
	    Frame.InputBegan:Connect(function(input)
	        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UIS:GetFocusedTextBox() == nil then
	            dragToggle = true
	            dragStart = input.Position
	            startPos = Frame.Position
	            input.Changed:Connect(function()
	                if input.UserInputState == Enum.UserInputState.End then
	                    dragToggle = false
	                end
	            end)
	        end
		end)
		
	    Frame.InputChanged:Connect(function(input)
	        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
	            dragInput = input
	        end
		end)
		
	    game:GetService("UserInputService").InputChanged:Connect(function(input)
	        if input == dragInput and dragToggle then
	            updateInput(input)
	        end
	    end)
	end
	
	dragify(script.Parent)
end
coroutine.wrap(CYVEKNI_fake_script)()
local function MOMCWD_fake_script() -- LuahubLauncher.launchmanager 
	local script = Instance.new('LocalScript', LuahubLauncher)

	local launchButton = script.Parent.main.launchbutton
	local exitButton = script.Parent.main.exitbutton
	-- elseif game.PlaceId == 1 then
	
	function setupLauncher()
		launchButton.Text = "Launch "..game.Name.." script"
	end
	
	function launchScript() -- Destroy the launcher because why not
		if game.PlaceId == 292439477 then
			loadstring(game:HttpGet(("https://raw.githubusercontent.com/RobloxExploitings/luahub/main/PhantomForces.lua"), true))()
		elseif game.PlaceId == 2551991523 then
			loadstring(game:HttpGet(("https://raw.githubusercontent.com/RobloxExploitings/luahub/main/BrokenBonesIV.lua"), true))()
		elseif game.PlaceId == 3956818381 then
			loadstring(game:HttpGet(("https://raw.githubusercontent.com/RobloxExploitings/luahub/main/NinjaLegends.lua"), true))()
		elseif game.PlaceId == 5852812686 then
			loadstring(game:HttpGet(("https://raw.githubusercontent.com/RobloxExploitings/luahub/main/CandyClickingSim.lua"), true))()
		elseif game.PlaceId == 155615604 then
			loadstring(game:HttpGet(("https://raw.githubusercontent.com/RobloxExploitings/luahub/main/PrisonLife.lua"), true))()
		else
			launchButton.Text = "This game isn't supported by LuaHub. For supported games, please join our discord that has been copied to your clipboard."
			setclipboard("https://discord.gg/P3RjmbKN")
			wait(5)
		end
		
		script.Parent:Destroy()
	end
	
	setupLauncher()
	
	exitButton.MouseButton1Click:Connect(function()
		script.Parent:Destroy()
	end)
	
	launchButton.MouseButton1Click:Connect(function()
		launchScript()
	end)
end
coroutine.wrap(MOMCWD_fake_script)()
