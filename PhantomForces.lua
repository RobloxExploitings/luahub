getgenv().Color = Color3.fromRGB(141, 115, 245)
getgenv().Material = Enum.Material.ForceField
getgenv().enabled = false
getgenv().chatSpam = false

game.RunService.Heartbeat:Connect(function()
    if getgenv().enabled == true then
    if (workspace.CurrentCamera["Left Arm"] ~= nil) then
        for i, v in pairs(workspace.CurrentCamera:GetChildren()) do
            if (v:IsA("Model") and v.Name:find("Arm")) then
                for i2, v2 in pairs(v:GetChildren()) do
                    if (v2:IsA("MeshPart") or v2:IsA("BasePart")) then
                        v2.Color = getgenv().Color
                        v2.Material = getgenv().Material
                    end
                end
            end
        end
        
        for i, v in pairs(workspace.CurrentCamera:GetChildren()) do
            if (v.Name ~= "Left Arm" or v.Name ~= "Right Arm") then
                if (v:IsA("Model")) then
                    for i2, v2 in pairs(v:GetChildren()) do
                        if (v2:IsA("MeshPart") or v2:IsA("BasePart")) then
                            v2.Color = getgenv().Color
                            v2.Material = getgenv().Material
                        end
                    end
                end
            end
        end
    end
    end
end)


local client = {}; do
    -- Tables
    client.esp = {}
    
    -- Modules
    for i,v in pairs(getgc(true)) do
        if (type(v) == "table") then
            if (rawget(v, "getplayerhealth")) then
                client.hud = v
            elseif (rawget(v, "getplayerhit")) then
                client.replication = v
            end
        end
    end

    client.chartable = debug.getupvalue(client.replication.getbodyparts, 1)
end

client.esp.Options = {
    Enable = false,
    TeamCheck = true,
    TeamColor = false,
    VisibleOnly = false,
    Color = Color3.fromRGB(255, 255, 255),
    Name = false,
    Box = true,
    Health = false,
    Distance = false,
    Tracer = true,
    TracerPos = 1
}

client.esp.Services = setmetatable({}, {
    __index = function(Self, Index)
        local GetService = game.GetService
        local Service = GetService(game, Index)

        if Service then
            Self[Index] = Service
        end

        return Service
    end
})

local function GetDrawingObjects()
    return {
        Name = Drawing.new("Text"),
        Box = Drawing.new("Quad"),
        Tracer = Drawing.new("Line"),
    }
end

local function CreateEsp(Player)
    local Objects = GetDrawingObjects()
    local Character = client.chartable[Player].head.Parent
    local Head = Character.Head
    local HeadPosition = Head.Position
    local Head2dPosition, OnScreen = workspace.CurrentCamera:WorldToScreenPoint(HeadPosition)
    local Origin = workspace.CurrentCamera.CFrame.p
    local HeadPos = Head.Position
    local IgnoreList = { Character, client.esp.Services.Players.LocalPlayer.Character, workspace.CurrentCamera, workspace.Ignore }
    local PlayerRay = Ray.new(Origin, HeadPos - Origin)
    local Hit = workspace:FindPartOnRayWithIgnoreList(PlayerRay, IgnoreList)

    local function Create()
        if (OnScreen) then
            local Name = ""
            local Health = ""
            local Distance = ""
    
            if (client.esp.Options.Name) then
                Name = Player.Name
            end
    
            if (client.esp.Options.Health) then
                local Characters = debug.getupvalue(client.replication.getplayerhit, 1)
                Health = " [ " .. client.hud:getplayerhealth(Characters[Character]) .. "% ]"
            end
    
            if (client.esp.Options.Distance) then
                Distance = " [ " .. math.round((HeadPosition - workspace.CurrentCamera.CFrame.p).Magnitude) .. " studs ]"
            end
    
            Objects.Name.Visible = true
            Objects.Name.Transparency = 1
            Objects.Name.Text = string.format("%s%s%s", Name, Health, Distance)
            Objects.Name.Size = 18
            Objects.Name.Center = true
            Objects.Name.Outline = true
            Objects.Name.OutlineColor = Color3.fromRGB(0, 0, 0)
            Objects.Name.Position = Vector2.new(Head2dPosition.X, Head2dPosition.Y)
    
            if (client.esp.Options.TeamColor) then
                Objects.Name.Color = Player.Team.TeamColor.Color
            else
                Objects.Name.Color = Color3.fromRGB(255, 255, 255)
            end
    
            if (client.esp.Options.Box) then
                local Part = Character.HumanoidRootPart
                local Size = Part.Size * Vector3.new(1, 1.5)
                local Sizes = {
                    TopRight = (Part.CFrame * CFrame.new(-Size.X, -Size.Y, 0)).Position,
                    BottomRight = (Part.CFrame * CFrame.new(-Size.X, Size.Y, 0)).Position,
                    TopLeft = (Part.CFrame * CFrame.new(Size.X, -Size.Y, 0)).Position,
                    BottomLeft = (Part.CFrame * CFrame.new(Size.X, Size.Y, 0)).Position,
                }
    
                local TL, OnScreenTL = workspace.CurrentCamera:WorldToScreenPoint(Sizes.TopLeft)
                local TR, OnScreenTR = workspace.CurrentCamera:WorldToScreenPoint(Sizes.TopRight)
                local BL, OnScreenBL = workspace.CurrentCamera:WorldToScreenPoint(Sizes.BottomLeft)
                local BR, OnScreenBR = workspace.CurrentCamera:WorldToScreenPoint(Sizes.BottomRight)
    
                if (OnScreenTL and OnScreenTR and OnScreenBL and OnScreenBR) then
                    Objects.Box.Visible = true
                    Objects.Box.Transparency = 1
                    Objects.Box.Thickness = 2
                    Objects.Box.Filled = false
                    Objects.Box.PointA = Vector2.new(TL.X, TL.Y + 36)
                    Objects.Box.PointB = Vector2.new(TR.X, TR.Y + 36)
                    Objects.Box.PointC = Vector2.new(BR.X, BR.Y + 36)
                    Objects.Box.PointD = Vector2.new(BL.X, BL.Y + 36)
    
                    if (client.esp.Options.TeamColor) then
                        Objects.Box.Color = Player.Team.TeamColor.Color
                    else
                        Objects.Box.Color = client.esp.Options.Color
                    end
                end
            end
    
            if (client.esp.Options.Tracer) then
                local CharTorso = Character:FindFirstChild("Torso") or Character:FindFirstChild("UpperTorso")
                local Torso, OnScreen = workspace.CurrentCamera:WorldToScreenPoint(CharTorso.Position)
    
                if (OnScreen) then
                    Objects.Tracer.Visible = true
                    Objects.Tracer.Transparency = 1
                    Objects.Tracer.Thickness = 1
                    Objects.Tracer.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / client.esp.Options.TracerPos)
                    Objects.Tracer.To = Vector2.new(Torso.X, Torso.Y + 36)
    
                    if (client.esp.Options.TeamColor) then
                        Objects.Tracer.Color = Player.Team.TeamColor.Color
                    else
                        Objects.Tracer.Color = client.esp.Options.Color
                    end
                end
            end
        end
    end

    if (client.esp.Options.VisibleOnly) then
        if (Hit == nil) then
            Create()
        end
    else
        Create()
    end

    client.esp.Services.RunService.Heartbeat:Wait()
    client.esp.Services.RunService.Heartbeat:Wait()

    Objects.Name:Remove()
    Objects.Box:Remove()
    Objects.Tracer:Remove()
end

client.esp.Services.RunService.RenderStepped:Connect(function()
    local LocalPlayer = client.esp.Services.Players.LocalPlayer

    for i,v in pairs(client.esp.Services.Players:GetPlayers()) do
        if (v and client.chartable[v] and v.Name ~= LocalPlayer.Name) then
            if (client.esp.Options.Enable) then
                if (client.esp.Options.TeamCheck) then
                    if (v.Team ~= LocalPlayer.Team) then
                        CreateEsp(v)
                    end
                else
                    CreateEsp(v)
                end
            end
        end
    end
end)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

getgenv().isFlying = false

local CurrentCamera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer

local Speed = 50
local MovementTable = {
	0,
	0,
	0,
	0,
	0,
	0
}
local KeyCodeTable = {
	[Enum.KeyCode.W] = 1,
	[Enum.KeyCode.A] = 2,
	[Enum.KeyCode.S] = 3,
	[Enum.KeyCode.D] = 4,
	[Enum.KeyCode.LeftControl] = 5,
	[Enum.KeyCode.Space] = 6
}

UserInputService.InputBegan:Connect(function(Input, ...)
	if getgenv().isFlying then
	if Input.KeyCode == Enum.KeyCode.LeftShift then
		Speed = 100
	elseif KeyCodeTable[Input.KeyCode] then
		MovementTable[KeyCodeTable[Input.KeyCode]] = 1
	end
end
end)

UserInputService.InputEnded:Connect(function(Input, ...)
	if Input.KeyCode == Enum.KeyCode.LeftShift then
		Speed = 50
	elseif KeyCodeTable[Input.KeyCode] then
		MovementTable[KeyCodeTable[Input.KeyCode]] = 0
	end
end)

local GetMass = function(Model)
	local Mass = 0
	for _, Value in pairs(Model:GetDescendants()) do
		if Value:IsA("BasePart") then
			Mass = Mass + Value:GetMass()
		end
	end
	return Mass * workspace.Gravity
end

RunService.RenderStepped:Connect(function(...)
	local Character = LocalPlayer.Character
	if Character then
		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
		local Mass = GetMass(Character)
		if HumanoidRootPart then
			local BodyVelocity = HumanoidRootPart:FindFirstChildOfClass("BodyVelocity")
			if BodyVelocity then
				if getgenv().isFlying then
					BodyVelocity.MaxForce = Vector3.new(Mass * Speed, Mass * Speed, Mass * Speed)
					BodyVelocity.Velocity = CurrentCamera.CFrame.LookVector * Speed * (MovementTable[1] - MovementTable[3]) + CurrentCamera.CFrame.RightVector * Speed * (MovementTable[4] - MovementTable[2]) + CurrentCamera.CFrame.UpVector * Speed * (MovementTable[6] - MovementTable[5])
				else
					BodyVelocity.MaxForce = Vector3.new(0, 0, 0)
					BodyVelocity.Velocity = Vector3.new(0, 2, 0)
				end
			end
		end
	end
end)

local cur = os.clock()
getgenv().silentAim = false

local rsRunner

for i,v in pairs(getconnections(game:GetService("RunService").RenderStepped)) do
    if v.Function then
        local taskManager = debug.getupvalues(v.Function)[1]
        if type(taskManager) == "table" and rawget(taskManager, "_taskContainers") then
            rsRunner = taskManager
            break
        end
    end
end

local charStep = next(rsRunner._taskContainers.char.tasks).task

local pf = {}
pf.menu = debug.getupvalue(charStep, 27)
pf.sound = debug.getupvalue(charStep, 24)
pf.roundsystem = debug.getupvalue(charStep, 17)
pf.cframe = debug.getupvalue(charStep, 15)
pf.char = debug.getupvalue(charStep, 3)
pf.camera = debug.getupvalue(charStep, 2)
pf.network = debug.getupvalue(pf.char.setmovementmode, 20)
pf.hud = debug.getupvalue(pf.char.setmovementmode, 10)
pf.input = debug.getupvalue(pf.char.setmovementmode, 17)
pf.gamelogic = debug.getupvalue(pf.char.setsprint, 1)
pf.replication = debug.getupvalue(pf.hud.attachflag, 1)

do
    local receive = getconnections(debug.getupvalue(pf.network.send, 1).OnClientEvent)[1].Function
    pf.networkCache = debug.getupvalue(receive, 1)
end

local fakeBarrel = Instance.new("Part")
fakeBarrel.CanCollide = false
fakeBarrel.Size = Vector3.new(1,1,1)
fakeBarrel.Transparency = 1 -- comment out if you wanna see it in action or whatever
fakeBarrel.Parent = workspace

local lp = game:GetService("Players").LocalPlayer

local currentgun = pf.gamelogic.currentgun
setmetatable(pf.gamelogic, {
    __index = function(t,k)
        if k == "currentgun" then
            return currentgun
        end
    end,
    __newindex = function(t,k,v)
        if k == "currentgun" then
            currentgun = v
            
            
            
            if v ~= nil and v.step ~= nil then
                local gunStep = debug.getupvalues(v.step)
                gunStep = gunStep[#gunStep]
                
                if not gunStep or type(gunStep) ~= "function" or is_synapse_function(gunStep) then
                    return    
                end
                
                debug.setupvalue(gunStep, 38, fakeBarrel)
                
                local gunInfo = debug.getupvalue(gunStep, 6)
                gunInfo.choke = false
                gunInfo.hipchoke = false
                gunInfo.aimchoke = false
                
                local hook
                hook = hookfunction(gunStep, function(...)
                    if currentgun == v then
                        
                        local nearestDist = math.huge
                        local nearest
                        
                        for o,p in pairs(game:GetService("Players"):GetPlayers()) do
                            if pf.hud:isplayeralive(p) and p.TeamColor ~= lp.TeamColor then
                                local _, headPos = pf.replication.getupdater(p).getpos()
                                
                                local viewportHead, onScreen = pf.camera.currentcamera:WorldToViewportPoint(headPos)
                                
                                local distFromCursor = (Vector2.new(viewportHead.x, viewportHead.y) - (pf.camera.currentcamera.ViewportSize / 2)).magnitude
                                
                                if distFromCursor < nearestDist then
                                    nearestDist = distFromCursor
                                    nearest = p
                                end
                            end
                        end
                        
                        if nearest then
                        if getgenv().silentAim then
                            local _, headPos = pf.replication.getupdater(nearest).getpos()
                            
                            fakeBarrel.CFrame = CFrame.lookAt(v.barrel.Position, headPos)
                        
                            debug.setupvalue(hook, 9, false)
                        else
                            fakeBarrel.CFrame = v.barrel.CFrame
                            end
                        end
                    end
                    return hook(...)
                end)
            end
        end
    end
})
pf.gamelogic.currentgun = nil


for i,v in pairs(pf.networkCache) do
    if debug.getconstants(v)[24] == " : " then
        v({Name = "gamign", TeamColor = BrickColor.White()}, "loaded! (took " .. math.round((os.clock() - cur) * 1000000) .. " ns)")
        break
    end
end


















local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("LuaHub - Phantom Forces", "BloodTheme")

local CombatTab = Window:NewTab("Combat")
local ModsTab = Window:NewTab("Movement")
local ExtrasTab = Window:NewTab("Extras")

local ArmsSection = ExtrasTab:NewSection("Arm Customisation")
local ChatSpamSection = ExtrasTab:NewSection("Chat spam")
local SilentSection = CombatTab:NewSection("Silent aimbot")
local toggleUIsectrionhelpmeimboredlol = ExtrasTab:NewSection("Toggle UI")
local FlySection = ModsTab:NewSection("Flying")
local ESPSection = CombatTab:NewSection("ESP")

-- Silent aim
SilentSection:NewToggle("Enable Silent Aim", "Enables the Silent Aimbot", function(v)
    getgenv().silentAim = v
end)

-- ESP
ESPSection:NewToggle("Enable ESP", "Enables the ESP", function(v)
    client.esp.Options.Enable = v
end)

ESPSection:NewToggle("Enable names", "Enables the ESP's names", function(v)
    client.esp.Options.Name = v
end)

ESPSection:NewColorPicker("ESP Colour", "Changes the colour of the ESP", Color3.fromRGB(255,255,255), function(color)
    client.esp.Options.Color = color
end)

-- Flying
FlySection:NewToggle("Enable flying", "Enables the player to fly, this is obvious.", function(v)
    getgenv().isFlying = v
end)


-- Chat spam
local message = "LuaHub on top"
local chatInterval = 3

    while getgenv().chatSpam do
        local args = {[1] = "chatted",[2] = message}
        game:GetService("ControllerService").RemoteEvent:FireServer(unpack(args))
        wait(chatInterval)
    end

ChatSpamSection:NewTextBox("Message to spam", "Change the message to spam", function(v)
	message = v
end)

ChatSpamSection:NewToggle("Enable chat spam", "Enables the Chat Spam", function(v)
    getgenv().chatSpam = v
end)

-- Arms
ArmsSection:NewToggle("Custom arms", "Enables the Custom Arms Feature", function(v)
    getgenv().enabled = v
end)

ArmsSection:NewColorPicker("Arms Colour", "Changes the colour of the arms", Color3.fromRGB(255,255,255), function(color)
    getgenv().Color = color
end)

-- Toggle UI
toggleUIsectrionhelpmeimboredlol:NewKeybind("Toggle UI", "Toggles the UI", Enum.KeyCode.RightShift, function()
	Library:ToggleUI()
end)