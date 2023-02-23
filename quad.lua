if QUADHUB_LOADED then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Quad Hub";
        Text = "Script already loaded";
        Duration = 5;
    })
    while wait(30) do end
end
getgenv().QUADHUB_LOADED = true
repeat wait(.5) until game:IsLoaded()
_G.QUADHUB_UNLOADED = false
_G.QUADHUB_INVIS = false

local plr = game:GetService("Players").LocalPlayer
local mouse = plr:GetMouse()
local sg = game:GetService("StarterGui")
local sc = game:GetService("ScriptContext")

pcall(function() for _,v in next, getconnections(sc.Error) do v:Disable() end end)

if not _G.SKIP_INGAME_WAIT and not plr:FindFirstChild("Ingame") and not plr:FindFirstChild("InGame") then
    sg:SetCore("SendNotification", {
        Title = "Quad Hub";
        Text = "Script will not run in menu, please spawn in";
        Duration = 5;
    })
    repeat wait(.5) until plr:FindFirstChild("Ingame") or plr:FindFirstChild("InGame")
    wait(.5)
end

local creator = "PLAYER"
if game.CreatorType == Enum.CreatorType.Group then
    creator = game.CreatorId
end

local library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()
library.configuration.hideKeybind = Enum.KeyCode.RightControl
local Wait = library.subs.Wait
--local esplib = loadstring(game:HttpGet(("https://pastebin.com/raw/RrSA6RU9"),true))()

local uis = game:GetService("UserInputService")
local cs = game:GetService("CollectionService")
local players = game:GetService("Players")
local rs = game:GetService("ReplicatedStorage")
local map = workspace:WaitForChild("Map")
local lighting = game:GetService("Lighting")

local killbricknames = {
    "killbrick",
    "pitkillbrick",
    "lava",
    "killfire",
    "ardoriankillbrick",
    "kill",
    "kbrick",
    "kb"
}

local killbricks = {}
local fires = {}
local barriers = {}
for _,v in pairs(map:GetChildren()) do
    if v:IsA("BasePart") and table.find(killbricknames,string.lower(v.Name)) then
        table.insert(killbricks,v)
    elseif v:IsA("BasePart") and (v.Name == "Fire" or v.Name == "PoisonField") then
        table.insert(fires,v)
    elseif v:IsA("BasePart") and (v.Name == "OrderField" or v.Name == "MageField" or v.Name == "ScroomField" or v.Name == "ChaoticField") then
        table.insert(barriers,v)
    end
end

local function GetClosest()
    local Character = plr.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if not (Character or HumanoidRootPart) then return end
 
    local TargetDistance = 100
    local Target
 
    for i,v in ipairs(game:GetService("Players"):GetPlayers()) do
        if v ~= plr and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local TargetHRP = v.Character.HumanoidRootPart
            local mag = (HumanoidRootPart.Position - TargetHRP.Position).magnitude
            if mag < TargetDistance then
                TargetDistance = mag
                Target = v
            end
        end
    end
 
    return Target
 end

function randomString()
	local length = math.random(10,20)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

local findItemWithHandle = function()
    if not plr or not plr.Backpack or #plr.Backpack:GetChildren() == 0 then return nil end
    for _,v in pairs(plr.Backpack:GetChildren()) do
        if plr.Backpack:FindFirstChild("Sword") then
            return plr.Backpack.Sword
        end
        if plr.Backpack:FindFirstChild("Spear") then
            return plr.Backpack.Spear
        end
        if plr.Backpack:FindFirstChild("Dagger") then
            return plr.Backpack.Dagger
        end
        if plr.Backpack:FindFirstChild("Tanto") then
            return plr.Backpack.Tanto
        end
        if v:IsA("Tool") and v:FindFirstChild("Handle") then
            return v
        end
    end
end

COREGUI = game:GetService("CoreGui")
PARENT = nil
if get_hidden_gui or gethui then
	local hiddenUI = get_hidden_gui or gethui
	local Main = Instance.new("ScreenGui")
	Main.Name = randomString()
	Main.Parent = hiddenUI()
	PARENT = Main
elseif (not is_sirhurt_closure) and (syn and syn.protect_gui) then
	local Main = Instance.new("ScreenGui")
	Main.Name = randomString()
	syn.protect_gui(Main)
	Main.Parent = COREGUI
	PARENT = Main
elseif COREGUI:FindFirstChild('RobloxGui') then
	PARENT = COREGUI.RobloxGui
else
	local Main = Instance.new("ScreenGui")
	Main.Name = randomString()
	Main.Parent = COREGUI
	PARENT = Main
end

local chat_logger = Instance.new("ScreenGui")
local template_message = Instance.new("TextLabel")
task.spawn(function()
    chat_logger.IgnoreGuiInset = true
    chat_logger.ResetOnSpawn = false
    chat_logger.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    chat_logger.Name = "ChatLogger"
    chat_logger.Parent = PARENT

    local frame = Instance.new("ImageLabel")
    frame.Image = "rbxassetid://1327087642"
    frame.ImageTransparency = 0.6499999761581421
    frame.BackgroundColor3 = Color3.new(1, 1, 1)
    frame.BackgroundTransparency = 1
    frame.Position = UDim2.new(0.0766663328, 0, 0.594427288, 0)
    frame.Size = UDim2.new(0.28599999995, 0, 0.34499999, 0)
    frame.Visible = true
    frame.ZIndex = 99999000
    frame.Name = "Frame"
    frame.Parent = chat_logger
    frame.Draggable = true
    frame.Active = true
    frame.Selectable = true

    local title = Instance.new("TextLabel")
    title.Font = Enum.Font.SourceSansBold
    title.Text = "Chat Logger"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextSize = 32
    title.TextStrokeTransparency = 0.20000000298023224
    title.BackgroundColor3 = Color3.new(1, 1, 1)
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, 0, 0.075000003, 0)
    title.Visible = true
    title.ZIndex = 99999001
    title.Name = "Title"
    title.Parent = frame

    local frame_2 = Instance.new("ScrollingFrame")
    frame_2.CanvasPosition = Vector2.new(0, 99999)
    frame_2.BackgroundColor3 = Color3.new(1, 1, 1)
    frame_2.BackgroundTransparency = 1
    frame_2.Position = UDim2.new(0.0700000003, 0, 0.100000001, 0)
    frame_2.Size = UDim2.new(0.870000005, 0, 0.800000012, 0)
    frame_2.Visible = true
    frame_2.ZIndex = 99999000
    frame_2.Name = "Frame"
    frame_2.Parent = frame

    local uilist_layout = Instance.new("UIListLayout")
    uilist_layout.SortOrder = Enum.SortOrder.LayoutOrder
    uilist_layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    uilist_layout.Parent = frame_2

    template_message.Font = Enum.Font.SourceSans
    template_message.Text = "Lannis [Ragoozer]: hi im real ragoozer Rogue Lineage"
    template_message.TextColor3 = Color3.new(1, 1, 1)
    template_message.TextScaled = true
    template_message.TextSize = 18
    template_message.TextStrokeTransparency = 0.20000000298023224
    template_message.TextWrapped = true
    template_message.TextXAlignment = Enum.TextXAlignment.Left
    template_message.BackgroundColor3 = Color3.new(1, 1, 1)
    template_message.BackgroundTransparency = 1
    template_message.Position = UDim2.new(0, 0, -0.101166956, 0)
    template_message.Size = UDim2.new(0.949999988, 0, 0.035, 0)
    template_message.Visible = false
    template_message.ZIndex = 99999010
    template_message.RichText = true
    template_message.Name = "TemplateMessage"
    template_message.Parent = chat_logger

    task.spawn(function()
        coroutine.resume(coroutine.create(function()
            local ChatEvents = rs:WaitForChild("DefaultChatSystemChatEvents", math.huge)
            local OnMessageEvent = ChatEvents:WaitForChild("OnMessageDoneFiltering", math.huge)
            if OnMessageEvent:IsA("RemoteEvent") then
                OnMessageEvent.OnClientEvent:Connect(function(data)
                    if data ~= nil then
                        local player = tostring(data.FromSpeaker)
                        local message = tostring(data.Message)
                        local originalchannel = tostring(data.OriginalChannel)
                        if string.find(originalchannel, "To ") then
                            message = "/w " .. string.gsub(originalchannel, "To ", "") .. " " .. message
                        end
                        if originalchannel == "Team" then
                            message = "/team " .. message
                        end

                        local displayname = "?"
                        local realplayer = players[player]
                        if realplayer and realplayer.Character ~= nil and realplayer.Character:FindFirstChildOfClass("Humanoid") then
                            displayname = realplayer.Character:FindFirstChildOfClass("Humanoid").DisplayName
                        elseif realplayer and realplayer:FindFirstChild("leaderstats") and realplayer.leaderstats:FindFirstChild("FirstName") then
                            displayname = realplayer.leaderstats.FirstName.Value
                        elseif realplayer then
                            displayname = realplayer.Name
                        end
                        
                        frame_2.CanvasPosition = Vector2.new(0, 99999)
                        local messagelabel = template_message:Clone()
                        game:GetService("Debris"):AddItem(messagelabel,300)
                        messagelabel.Text = "<b>"..displayname.." ["..realplayer.Name.."]:</b> "..message
                        messagelabel.Visible = true
                        messagelabel.Parent = frame_2
                    end
                end)
            end
        end))
    end)
end)

local window = library:CreateWindow({
Name = "Quad Hub",
Themeable = {
Info = "Rogue Lineage: FIM script made\nby Q and marshadow",
Background = "rbxassetid://0"
}
})

local tab1 = window:CreateTab({Name = "Rogue Lineage"})
local movementsection = tab1:CreateSection({Name = "Movement"})
local flytoggle = movementsection:AddToggle({
    Name = "Fly",
    Flag = "Fly1",
    Keybind = Enum.KeyCode.F3,
    Callback = function(val) end,
    UnloadFunc = function()
        _G.QUADHUB_UNLOADED = true
    end
})
local flyspeed = movementsection:AddSlider({
    Name = "Fly Speed",
    Flag = "FlySpeed",
    Value = 150,
    Min = 10,
    Max = tostring(game.PlaceId) ~= "12159215859" and 250 or 400
})
local fallspeed = movementsection:AddSlider({
    Name = "Fly Fall Speed",
    Flag = "FallSpeed",
    Value = 55,
    Min = 0,
    Max = 150
})
local raisespeed = movementsection:AddSlider({
    Name = "Fly Up Speed",
    Flag = "FlyUpSpeed",
    Value = 85,
    Min = 0,
    Max = 150
})
local speedtoggle = movementsection:AddToggle({
    Name = "Speed",
    Flag = "Speed",
    Keybind = Enum.KeyCode.F4,
    Callback = function(val) end
})
local walkspeed = movementsection:AddSlider({
    Name = "Walk Speed",
    Flag = "WalkSpeed",
    Value = 100,
    Min = 16,
    Max = 250
})

local infjumpconnection
local infjump = function()
    if infjumpconnection then infjumpconnection:Disconnect() end
    infjumpconnection = uis.JumpRequest:Connect(function()
		plr.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
	end)
end

local infjumptoggle = movementsection:AddToggle({
    Name = "Infinite Jump",
    Flag = "InfJumpEnabled",
    Keybind = Enum.KeyCode.F4,
    Callback = function(val)
        if val then
            infjump()
        else
            if infjumpconnection then infjumpconnection:Disconnect() end
        end
    end
})
local jumppower = movementsection:AddSlider({
    Name = "Jump Power",
    Flag = "InfJump_JumpPower",
    Value = 50,
    Min = 16,
    Max = 200
})

local toggles = tab1:CreateSection({Name = "Toggles"})

local noclip = function()
    local s,e = pcall(function()
        for i, v in pairs(plr.Character:GetChildren()) do
            pcall(function()
                if v.CanCollide == true then
                    v.CanCollide = false
                    cancollideparts[v] = true
                end
            end)
        end
    end)
    if not s then warn(e) end
end

local noclipcon = nil
local nocliptoggle = toggles:AddToggle({
    Name = "Noclip",
    Flag = "NoclipEnabled",
    Keybind = Enum.KeyCode.F5,
    Value = false,
    Callback = function(val)
        local s,e = pcall(function()
            if val then
                noclipcon = game:GetService("RunService").Stepped:Connect(noclip)
            else
                if noclipcon ~= nil then
					noclipcon:Disconnect()
                    noclipcon = nil
					pcall(function()
						for _,v in pairs(plr.Character:GetChildren()) do
							if cancollideparts[v] then
								pcall(function()
									v.CanCollide = true
								end)
							end
						end
					end)
				end
            end
        end)
    end
})

local knockedownershiptoggle = toggles:AddToggle({
    Name = "Knocked Ownership",
    Flag = "KnockedOwnership",
    Value = false
})
local nofalltoggle = toggles:AddToggle({
    Name = "No Fall Damage",
    Flag = "NoFall",
    Value = true
})
if tostring(game.PlaceId) ~= "12159215859" then
    for _,v in pairs(killbricks) do
        pcall(function()
            v.CanTouch = false
        end)
    end
    local disablekillbrickstoggle = toggles:AddToggle({
        Name = "Disable Kill Bricks",
        Flag = "DisableKillBricks",
        Value = true,
        Callback = function(val)
            for _,v in pairs(killbricks) do
                pcall(function()
                    v.CanTouch = not val
                end)
            end
        end,
        UnloadFunc = function()
            for _,v in pairs(killbricks) do
                pcall(function()
                    v.CanTouch = true
                end)
            end
        end
    })
end
--[[local autosprintcon
local autosprinttoggle = toggles:AddToggle({
    Name = "Auto Sprint",
    Flag = "AutoSprint",
    Value = false,
    Callback = function(val)
        local s,e = pcall(function()
            if autosprintcon then autosprintcon:Disconnect() end
            local char = plr.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum then return end
            if val then
                autosprintcon = hum:GetPropertyChangedSignal("MoveDirection"):Connect(function()
                    if hum.MoveDirection.Magnitude > 0 and iswindowactive() then
                        task.wait(.02)
                        keypress(0x57)
                        task.wait(.01)
                        keyrelease(0x57)
                    end
                end)
            end
        end)
    end
})]]
if tostring(game.PlaceId) ~= "12159215859" then
    local disablefirebrickstoggle = toggles:AddToggle({
        Name = "Disable Fire Bricks",
        Flag = "DisableFireBricks",
        Value = false,
        Callback = function(val)
            for _,v in pairs(fires) do
                pcall(function()
                    v.CanTouch = not val
                end)
            end
        end,
        UnloadFunc = function()
            for _,v in pairs(fires) do
                pcall(function()
                    v.CanTouch = true
                end)
            end
        end
    })
    local disablebarrierstoggle = toggles:AddToggle({
        Name = "Disable Barriers",
        Flag = "DisableBarriers",
        Value = false,
        Callback = function(val)
            for _,v in pairs(barriers) do
                pcall(function()
                    v.CanTouch = not val
                    v.CanCollide = false
                end)
            end
        end,
        UnloadFunc = function()
            for _,v in pairs(barriers) do
                pcall(function()
                    v.CanCollide = false
                    v.CanTouch = true
                end)
            end
        end
    })
end
--[[local killoncarrytoggle = toggles:AddToggle({
    Name = "Kill When Carried",
    Flag = "KillOnCarry"
})]]

local showhealthchildname = randomString()

local showHealth = function(char)
    local s,e = pcall(function()
        local hum = char:FindFirstChildOfClass("Humanoid")
        hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOn
        hum.HealthDisplayDistance = 60

        local typecon = hum:GetPropertyChangedSignal("HealthDisplayType"):Connect(function()
            hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOn
        end)
        local distcon = hum:GetPropertyChangedSignal("HealthDisplayDistance"):Connect(function()
            hum.HealthDisplayDistance = 60
        end)
        local deathcon
        deathcon = hum.Died:Connect(function()
            if typecon then typecon:Disconnect() end
            if distcon then distcon:Disconnect() end
            if deathcon then deathcon:Disconnect() end
        end)
        local removedcon
        removedcon = PARENT.ChildRemoved:Connect(function(child)
            if child.Name == showhealthchildname then
                if typecon then typecon:Disconnect() end
                if distcon then distcon:Disconnect() end
                if deathcon then deathcon:Disconnect() end
                task.wait()
                hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
                if removedcon then removedcon:Disconnect() end
            end
        end)
    end)
    if not s then warn(e) end
end

local gaysex
local showHealthBars = function(val)
    if gaysex then gaysex:Disconnect() end
    if val then
        local showhealthchild = Instance.new("Accessory")
        showhealthchild.Name = showhealthchildname
        showhealthchild.Parent = PARENT
        for _,v in pairs(workspace.Live:GetChildren()) do
            task.spawn(showHealth,v)
        end
        gaysex = workspace.Live.ChildAdded:Connect(function(child)
            task.spawn(function()
                repeat task.wait(1) until child:FindFirstChildOfClass("Humanoid")
                task.spawn(showHealth,child)
            end)
        end)
    else
        for _,v in pairs(PARENT:GetChildren()) do
            if v.Name == showhealthchildname then
                v:Destroy()
            end
        end
        for _,v in pairs(workspace.Live:GetChildren()) do
            pcall(function()
                v.Humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
            end)
        end
    end
end

local healthbartoggle = toggles:AddToggle({
    Name = "Show Health Bars",
    Flag = "ShowHealthBars",
    Value = true,
    Callback = showHealthBars
})
if tostring(game.PlaceId) ~= "12159215859" then
    local nofogtoggle = toggles:AddToggle({
        Name = "No Fog",
        Flag = "NoFog"
    })
    
    local fbtoggle = toggles:AddToggle({
        Name = "Fullbright",
        Flag = "Fullbright",
        UnloadFunc = function()
            pcall(function()
                lighting.GlobalShadows = true
            end)
        end
    })
end

local disablecharacteractions = false
local misc = tab1:CreateSection({Name = "Miscellaneous",Side = "Right"})
local observenotiftoggle = misc:AddToggle({
    Name = "Chat Logger",
    Flag = "ChatLoggerEnabled",
    Value = true,
    Callback = function(val)
        pcall(function()
            chat_logger.Enabled = val
        end)
    end
})
local observenotiftoggle = misc:AddToggle({
    Name = "Illu Observe Notification",
    Flag = "ObserveNotification",
    Value = true
})
local illunotiftoggle = misc:AddToggle({
    Name = "Illu Detection Notification",
    Flag = "IllusionistDetectionNotif",
    Value = true
})
local Prssed = false
_G.Offset = 1.5
local attachtobacktoggle = misc:AddToggle({
    Name = "Attach To Back",
    Flag = "AttachToBack",
    Keybind = Enum.KeyCode.X,
    Value = false,
    Callback = function(val)
        pcall(function()
            Prssed = val
            plr.Character.Humanoid.AutoRotate = not val
        end)
    end,
    UnloadFunc = function()
        Prssed = false
    end
})
local attachtobackoffsetslider = misc:AddSlider({
    Name = "Offset",
    Flag = "AttachToBackOffset",
    Precise = 1,
    Value = 1.5,
    Min = 0,
    Max = 7.5,
    Callback = function(val)
        _G.Offset = val
    end
})
local attachtobackpart = misc:AddDropdown({
    Name = "Part To Attach With",
    Flag = "AttachToBackPart",
    List = {
        "HumanoidRootPart",
        "Torso"
    },
    Value = "HumanoidRootPart",
    Callback = function(val,oldval) end
})
local anchortorsotoggle = misc:AddToggle({
    Name = "Anchor",
    Flag = "AnchorEnabled",
    Keybind = Enum.KeyCode.Z,
    Value = false,
    Callback = function(val)
        pcall(function()
            plr.Character:FindFirstChild(library.flags["AnchorPart"]).Anchored = val
        end)
    end
})
local anchorpartdropdown = misc:AddDropdown({
    Name = "Part To Anchor",
    Flag = "AnchorPart",
    List = {
        "Torso",
        "Head",
        "Left Leg",
        "Right Leg",
        "Left Arm",
        "Right Arm"
    },
    Value = "Torso",
    Callback = function(val,oldval)
        pcall(function()
            plr.Character:FindFirstChild(oldval).Anchored = false
        end)
    end
})
local setmanatoggle = misc:AddToggle({
    Name = "Set Mana (Risky)",
    Flag = "SetManaEnabled",
    Value = false,
    Callback = function(val)
        local s,e = pcall(function()
            local char = plr.Character
            if val then
                char.Mana.Value = library.flags["ManaPercentage"]
            else
                char.Mana.Value = 0
            end
        end)
        if not s then warn(e) end
    end
})
local setmanaslider = misc:AddSlider({
    Name = "Mana Percentage",
    Flag = "ManaPercentage",
    Value = 100,
    Min = 0,
    Max = 100,
    Callback = function(val)
        local s,e = pcall(function()
            if library.flags["SetManaEnabled"] then
                local char = plr.Character
                char.Mana.Value = val
            end
        end)
        if not s then warn(e) end
    end
})
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
FLYING = false
QEfly = true
iyflyspeed = 2.25
vehicleflyspeed = 1
function sFLY(vfly)
	repeat wait() until plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChildOfClass("Humanoid")
	repeat wait() until mouse
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end

	local T = plr.Character:FindFirstChild("HumanoidRootPart")
	local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local SPEED = 0

	local function FLY()
		FLYING = true
		local BG = Instance.new('BodyGyro')
		local BV = Instance.new('BodyVelocity')
		BG.P = 9e4
		BG.Parent = T
		BV.Parent = T
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = T.CFrame
		BV.velocity = Vector3.new(0, 0, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
		task.spawn(function()
			repeat wait()
				if not vfly and plr.Character:FindFirstChildOfClass('Humanoid') then
					plr.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
				end
				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					SPEED = 50
				elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
					SPEED = 0
				end
				if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
					lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
				elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
				else
					BV.velocity = Vector3.new(0, 0, 0)
				end
				BG.cframe = workspace.CurrentCamera.CoordinateFrame
			until not FLYING
			CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			SPEED = 0
			BG:Destroy()
			BV:Destroy()
			if plr.Character:FindFirstChildOfClass('Humanoid') then
				plr.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
			end
		end)
	end
	flyKeyDown = mouse.KeyDown:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 's' then
			CONTROL.B = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 'a' then
			CONTROL.L = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 'd' then 
			CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
		elseif QEfly and KEY:lower() == 'e' then
			CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed)*2
		elseif QEfly and KEY:lower() == 'q' then
			CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed)*2
		end
		pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
	end)
	flyKeyUp = mouse.KeyUp:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = 0
		elseif KEY:lower() == 's' then
			CONTROL.B = 0
		elseif KEY:lower() == 'a' then
			CONTROL.L = 0
		elseif KEY:lower() == 'd' then
			CONTROL.R = 0
		elseif KEY:lower() == 'e' then
			CONTROL.Q = 0
		elseif KEY:lower() == 'q' then
			CONTROL.E = 0
		end
	end)
	FLY()
end

function NOFLY()
	FLYING = false
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
	if plr.Character:FindFirstChildOfClass('Humanoid') then
		plr.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
	end
	pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local invis = misc:AddButton({
    Name = "Invisible (Risky)",
    Callback = function()
        local s,e = pcall(function()
            if disablecharacteractions then return end
            local char = plr.Character
            if not char then return end
            local hrp = char.HumanoidRootPart
            if not hrp then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum then return end
            local torso = char.Torso
            if not torso then return end
            local tool = findItemWithHandle()
            if not tool then
                sg:SetCore("SendNotification", {
                    Title = "Quad Hub",
                    Text = "You must have a holdable item in your inventory to go invisible (weapon, ingredient, trinket, etc.)",
                    Duration = 5.5,
                    Button1 = "OK"
                })
                return
            end
            disablecharacteractions = true

            _G.QUADHUB_INVIS = true
            task.spawn(function()
                plr.CharacterRemoving:Wait()
                FLYING = false
                _G.QUADHUB_INVIS = false
            end)
            task.spawn(function()
                task.wait(1)
                for i = 1,9e9 do
                    if _G.QUADHUB_INVIS == false then break end
                    task.wait()
                    if hum.RequiresNeck ~= false then hum.RequiresNeck = false end
                end
            end)

            local s,e = pcall(function()
                for _,v in pairs(getconnections(char.DescendantAdded)) do
                    v:Disable()
                end
            end)
            if not s then warn(e) end
            local s2,e2 = pcall(function()
                for _,v in pairs(getconnections(char.ChildAdded)) do
                    v:Disable()
                end
            end)
            if not s2 then warn(e2) end

            hum:UnequipTools()
            cs:AddTag(char,"FreezeRoot")
            hrp.Anchored = true
            --hum.PlatformStand = false
            game:GetService("RunService").Heartbeat:Wait()
            
            hrp.CFrame = CFrame.new(hrp.Position.X,hrp.Position.Y + 7.5,hrp.Position.Z)

            task.wait(1.1)

            local args = {
                [1] = hum.MaxHealth + 230.9984033203125
            }
            char.CharacterHandler.Remotes.ApplyFallDamage:FireServer(unpack(args))

            task.wait(.3)
            hum:UnequipTools()
            task.wait(.15)
            hum:EquipTool(tool)
            task.wait(.15)
            hum:UnequipTools()
            task.wait(2.3)
            char.Head:Destroy()

            --hum.PlatformStand = true
            hrp.Anchored = false
            cs:RemoveTag(char,"FreezeRoot")

            task.wait(.2)

            NOFLY()
            wait()
            sFLY()
            hrp.Transparency = .5

            task.delay(3.5,function()
                disablecharacteractions = false
            end)
        end)
        if not s then warn(e) end
    end
})
local respawn = misc:AddButton({
    Name = "Respawn",
    Callback = function()
        pcall(function()
            if disablecharacteractions then return end
            local char = plr.Character
            if not char then return end
            if _G.QUADHUB_INVIS == true then
                disablecharacteractions = true
                plr:Kick("Instant Log")
                task.wait()
                COREGUI.RobloxPromptGui.promptOverlay.ErrorPrompt.TitleFrame.ErrorTitle.TextColor3 = Color3.new(1,0,0)
                COREGUI.RobloxPromptGui.promptOverlay.ErrorPrompt.MessageArea.ErrorFrame.ErrorMessage.TextColor3 = Color3.new(1,0,0)
                COREGUI.RobloxPromptGui.promptOverlay.ErrorPrompt.TitleFrame.ErrorTitle.Text = "Quad Hub"
                COREGUI.RobloxPromptGui.promptOverlay.ErrorPrompt.MessageArea.ErrorFrame.ErrorMessage.Text = "You must rejoin to exit invisibility"
                return
            end
            local torso = char:FindFirstChild("Torso")
            if not torso then warn("Can not respawn because player has no torso") return end

            torso:Destroy()

            disablecharacteractions = true
            task.delay(6,function()
                disablecharacteractions = false
            end)
        end)
    end
})
local die = misc:AddButton({
    Name = "Die",
    Callback = function()
        local s,e = pcall(function()
            if disablecharacteractions then return end
            local char = plr.Character
            if not char then return end
            local hrp = char.HumanoidRootPart
            if not hrp then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum then return end
            local killbrick = map:FindFirstChild("KillBrick")
            if not killbrick then return end
            disablecharacteractions = true
            pcall(function() firetouchinterest(plr.Character["Right Leg"],killbrick,0) end)
            task.delay(6,function()
                disablecharacteractions = false
            end)
        end)
        if not s then warn(e) end
    end
})
local knock = misc:AddButton({
    Name = "Knock",
    Callback = function()
        local s,e = pcall(function()
            if disablecharacteractions then return end
            local char = plr.Character
            if not char then return end
            local hrp = char.HumanoidRootPart
            if not hrp then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum then return end
            local torso = char.Torso
            if not torso then return end
            disablecharacteractions = true

            cs:AddTag(char,"FreezeRoot")
            hrp.Anchored = true
            hum.PlatformStand = false
            game:GetService("RunService").Heartbeat:Wait()
            
            hrp.CFrame = CFrame.new(hrp.Position.X,hrp.Position.Y + 7.5,hrp.Position.Z)

            task.wait(1.1)

            local args = {
                [1] = hum.MaxHealth + 200.9884033203125
            }
            plr.Character.CharacterHandler.Remotes.ApplyFallDamage:FireServer(unpack(args))
            
            game:GetService("RunService").Heartbeat:Wait()
            hum.PlatformStand = true
            hrp.Anchored = false
            cs:RemoveTag(char,"FreezeRoot")

            task.delay(1.5,function()
                disablecharacteractions = false
            end)
        end)
        if not s then warn(e) end
    end
})

local instantlogkeybind = Enum.KeyCode.End
local server = tab1:CreateSection({Name = "Server",Side = "Right"})
local instalog = server:AddKeybind({
    Name = "Instant Log",
    Flag = "InstantLogKeybind",
    Value = Enum.KeyCode.End,
    Callback = function(val)
        instantlogkeybind = Enum.KeyCode.World95
        wait()
        instantlogkeybind = val
    end
})
local menubutton = misc:AddButton({
    Name = "Return To Menu",
    Callback = function()
        local s,e = pcall(function()
            game:GetService("ReplicatedStorage").toMenu:FireServer()
        end)
        if not s then warn(e) end
    end
})

-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
--
local esptab = window:CreateTab({Name = "ESP"})
local playeresp = esptab:CreateSection({Name = "Players",Side = "Left"})

local unnamedloaded = false
playeresp:AddButton({
    Name = "Unnamed ESP",
    Callback = function()
        if unnamedloaded == true then return end
        unnamedloaded = true
        local s,e = pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua'))() end)
        if not s then warn(e) end
    end
})
--[[
esplib.initmodule(false,PARENT)
local playerlib = esplib.init("quadhub_playeresp",false);

players.PlayerAdded:Connect(function(v)
    pcall(function()
        for i = 1,30 do
            pcall(function()
                for i, v in pairs(players:GetPlayers()) do
                    if v == plr then continue end
                    if not esplib.index[v.Character] and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChildOfClass("Humanoid") then
                        local part = v.Character;
                        esplib.createesp({
                            TextColor = library.flags["PlayerEspTextColor"],
                            PrimaryPart = part,
                            Name = v.Character:FindFirstChildOfClass("Humanoid").DisplayName.."\n"..v.Name, 
                            Font = Enum.Font.Code,
                            Size = UDim2.new(0, 100, 0, 100),
                            TextSize = library.flags["PlayerEspTextSize"],
                            Color = library.flags["PlayerEspHighlightColor"],
                            Transparency = .08,
                            UseChams = true
                        }, part, playerlib)
                    end
                end
            end)
            task.wait(0.25)
        end
    end)
end)
task.spawn(function()
    while task.wait(.5) do
        pcall(function()
            for i = 1,30 do
                pcall(function()
                    for i, v in pairs(players:GetPlayers()) do
                        if v == plr then continue end
                        if not esplib.index[v.Character] and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChildOfClass("Humanoid") then
                            local part = v.Character;
                            esplib.createesp({
                                TextColor = library.flags["PlayerEspTextColor"],
                                PrimaryPart = part,
                                Name = v.Character:FindFirstChildOfClass("Humanoid").DisplayName.."\n"..v.Name, 
                                Font = Enum.Font.Code,
                                Size = UDim2.new(0, 100, 0, 100),
                                TextSize = library.flags["PlayerEspTextSize"],
                                Color = library.flags["PlayerEspHighlightColor"],
                                Transparency = .08,
                                UseChams = true
                            }, part, playerlib)
                        end
                    end
                end)
                task.wait()
            end
        end)
    end
end)
playeresp:AddToggle({
    Name = "Enabled",
    Flag = "PlayerESPEnabled",
    Enabled = true,
    Callback = function(enabled)
        pcall(function() playerlib.Enabled = enabled end)
        for _,v in pairs(PARENT.quadhub_playeresp:GetDescendants()) do
            pcall(function()
                v.Visible = enabled
            end)
            pcall(function()
                v.Enabled = enabled
            end)
        end
    end
})
playeresp:AddSlider({
    Name = "Text Size",
    Flag = "PlayerEspTextSize",
    Value = 14,
    Min = 1,
    Max = 48,
    Callback = function(val)
        for _,v in pairs(PARENT.quadhub_playeresp:GetDescendants()) do
            pcall(function()
                v.TextSize = val
            end)
        end
    end
})
playeresp:AddColorpicker({
    Name = "Text Color",
    Flag = "PlayerEspTextColor",
    Value = Color3.new(1,0,0),
    Callback = function(color)
        for _,v in pairs(PARENT.quadhub_playeresp:GetDescendants()) do
            pcall(function()
                v.TextColor3 = color
            end)
        end
    end
})
playeresp:AddColorpicker({
    Name = "Highlight Color",
    Flag = "PlayerEspHighlightColor",
    Value = Color3.new(1,0,0),
    Callback = function(color)
        for _,v in pairs(PARENT.quadhub_playeresp:GetDescendants()) do
            pcall(function()
                v.OutlineColor = color
            end)
        end
    end
})
-------------------------------------------------------------------------
local trinketesp = esptab:CreateSection({Name = "Trinkets",Side = "Right"})
local artilib = esplib.init("quadhub_artifactesp",false);
local scrolllib = esplib.init("quadhub_scrollesp",false);

local function addArtiEsp(trinket,trinketName,color)
    if not esplib.index[trinket] then
        esplib.createesp({
            TextColor = color,
            PrimaryPart = trinket,
            Name = trinketName, 
            Font = Enum.Font.Code,
            Size = UDim2.new(0, 100, 0, 100),
            TextSize = 12,
            Color = Color3.fromRGB(255,162,52),
            Transparency = .08,
            UseChams = false
        }, part, artilib)
    end
end

local function addScrollEsp(trinket)
    if not esplib.index[trinket] then
        esplib.createesp({
            TextColor = Color3.fromRGB(255,237,142),
            PrimaryPart = trinket,
            Name = "Scroll", 
            Font = Enum.Font.Code,
            Size = UDim2.new(0, 100, 0, 100),
            TextSize = 12,
            Color = Color3.fromRGB(255,162,52),
            Transparency = .08,
            UseChams = false
        }, part, scrolllib)
    end
end

local function checkArti(trinket)
    if trinket.Color == Color3.fromRGB(255,255,0) and trinket.Reflectance == 5 and trinket.Material == Enum.Material.Neon then
        addArtiEsp(trinket,"Spider Cloak",Color3.fromRGB(255, 255, 123))
        return
    end
    if trinket.Color == Color3.fromRGB(255, 89, 89) and trinket.Size == Vector3.new(0.444, 0.444, 0.433) then
        addArtiEsp(trinket,"Philosopher's Stone",Color3.fromRGB(255,89,89))
        return
    end
    if trinket.ClassName == "UnionOperation" and trinket.Color == Color3.fromRGB(248, 248, 248) and trinket.Material == Enum.Material.Neon then
        if trinket:FindFirstChildOfClass("PointLight") then
            addArtiEsp(trinket,"White King's Amulet",Color3.fromRGB(255,255,255))
        else
            addArtiEsp(trinket,"Lannis Amulet",Color3.fromRGB(118,44,255))
        end
        return
    end
    if trinket.ClickPart.Size == Vector3.new(0.313, 0.17, 0.934) then
        addArtiEsp(trinket,"Howler Friend",Color3.fromRGB(177,228,255))
        return
    end
    if trinket.ClickPart.Size == Vector3.new(1.5,1.5,1.5) then
        addArtiEsp(trinket,"Fairfrozen",Color3.fromRGB(0,255,255))
        return
    end
    if trinket.ClickPart.Size == Vector3.new(0.65, 0.65, 0.65) then
        addArtiEsp(trinket,"Nightstone",Color3.fromRGB(152,0,210))
        return
    end
    if trinket.ClickPart.Size == Vector3.new(1.94, 1.94, 1.94) then
        if trinket:FindFirstChild("OrbParticle") and trinket:FindFirstChildOfClass("PointLight") then
            addArtiEsp(trinket,"???",Color3.fromRGB(106,56,255))
        else
            if trinket:FindFirstChildOfClass("Attachment") and trinket:FindFirstChildOfClass("Attachment"):FindFirstChildOfClass("ParticleEmitter") then
                local particle = trinket:FindFirstChildOfClass("Attachment"):FindFirstChildOfClass("ParticleEmitter")
                if string.gsub(tostring(particle.Color)," ","") == "010.03921570.03921570110.03921570.03921570" then
                    addArtiEsp(trinket,"Azael Horn",Color3.fromRGB(255,40,40))
                else
                    if particle.LightEmission == .5 then
                        addArtiEsp(trinket,"Pheonix Down",Color3.fromRGB(255,162,52))
                    else
                        addArtiEsp(trinket,"Mysterious Artifact",Color3.fromRGB(36,255,36))
                    end
                end
            else
                addArtiEsp(trinket,"Rift Gem",Color3.fromRGB(255,100,100))
            end
        end
        return
    end
    if trinket:IsA("MeshPart") and string.find(tostring(trinket.MeshId),"5204453430") then
        addScrollEsp(trinket)
        return
    end
end

for _,v in pairs(workspace:WaitForChild("Trinkets"):GetChildren()) do
    if not v:IsA("BasePart") then continue end
    pcall(checkArti,v)
end

workspace:WaitForChild("Trinkets").ChildAdded:Connect(function(v)
    if not v:IsA("BasePart") then return end
    wait(2)
    pcall(checkArti,v)
end)

trinketesp:AddToggle({
    Name = "Artifact ESP",
    Flag = "ArtiESPEnabled",
    Enabled = true,
    Callback = function(enabled)
        pcall(function()
            for _,v in pairs(PARENT.quadhub_artifactesp:GetDescendants()) do
                pcall(function()
                    v.Visible = enabled
                end)
                pcall(function()
                    v.Enabled = enabled
                end)
            end
        end)
    end
})

trinketesp:AddToggle({
    Name = "Scroll ESP",
    Flag = "ScrollESPEnabled",
    Enabled = true,
    Callback = function(enabled)
        pcall(function()
            for _,v in pairs(PARENT.quadhub_scrollesp:GetDescendants()) do
                pcall(function()
                    v.Visible = enabled
                end)
                pcall(function()
                    v.Enabled = enabled
                end)
            end
        end)
    end
})
--]]
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------

local charAdded = function(char)
    local hrp = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    game:GetService("RunService").RenderStepped:Wait()
    char.ChildAdded:Connect(function(child)
        local s,e = pcall(function()
            if library.flags["KillOnCarry"] and child.Name == "Carried" then
                wait()
                char.Torso:Destroy()
            end
        end)
        if not s then warn(e) end
    end)
    
    for _,v in pairs(getconnections(plr:GetPropertyChangedSignal("CameraMaxZoomDistance"))) do
        local s,e = pcall(function() v:Disable() end) if not s then warn(e) end
    end
end
if plr.Character then charAdded(plr.Character) end
plr.CharacterAdded:Connect(charAdded)

local lastFogChange = tick()
local lastKnockedOwnershipEquip = tick()
local lastGlobalShadowsUpdate = tick()
local heartbeat
heartbeat = game:GetService("RunService").Heartbeat:Connect(function()
    local s,e = pcall(function()
        if _G.QUADHUB_UNLOADED then pcall(function() heartbeat:Disconnect() end) end

        local char = plr.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end

        if library.flags["Fly1"] then
            if uis:IsKeyDown(Enum.KeyCode.Space) and not uis:GetFocusedTextBox() then
                hrp.Velocity = Vector3.new(0,library.flags["FlyUpSpeed"],0)
            else
                hrp.Velocity = Vector3.new(0,-library.flags["FallSpeed"],0)
            end
            hrp.Velocity *= Vector3.new(0,1,0)
            if hum.MoveDirection.Magnitude > 0 then
                hrp.Velocity += hum.MoveDirection.Unit * library.flags["FlySpeed"]
            end
        end

        if tostring(game.PlaceId) ~= "12159215859" then
            if library.flags["NoFog"] and tick() - lastFogChange > 1 and lighting.FogStart ~= 99999998 and lighting.FogEnd ~= 99999999 then
                lighting.FogStart = 99999998
                lighting.FogEnd = 99999999
                lastFogChange = tick()
            end

            if library.flags["Fullbright"] and tick() - lastGlobalShadowsUpdate > 1 and lighting.GlobalShadows == true then
                lighting.GlobalShadows = false
                lastGlobalShadowsUpdate = tick()
            end
        end
        
        if library.flags["KnockedOwnership"] and tick() - lastKnockedOwnershipEquip > .1 and char:FindFirstChild("Knocked") and char:FindFirstChild("Unconscious") then
            if char:FindFirstChildOfClass("Tool") then
                hum:UnequipTools()
            else
                local tool = findItemWithHandle()
                if tool then hum:EquipTool(tool) end
            end
            lastKnockedOwnershipEquip = tick()
        end

        pcall(function()
            if Prssed then
                if GetClosest() then
                    pcall(function()
                        local character = GetClosest().Character
                        local EnemyHum = character:FindFirstChild("HumanoidRootPart")
                        local EnemyTorso = character:FindFirstChild("Torso")
                        local distance = (plr.Character.HumanoidRootPart.Position - EnemyHum.Position).Magnitude
                        if distance < 35 then
                            pcall(function()
                                plr.Character:FindFirstChild(library.flags["AttachToBackPart"]).CFrame = EnemyTorso.CFrame * CFrame.new(0,0,_G.Offset)
                            end)
                        end
                    end)
                end
            end
        end)
    end)
    if not s then warn(e) end
end)

local isSpectating = false
function spectatePlayer(player)
    if isSpectating then
        if plr.Character then
            isSpectating = false
            workspace.CurrentCamera.CameraSubject = plr.Character
        end
    return end
    
    isSpectating = true
    if player.Character then
        workspace.CurrentCamera.CameraSubject = player.Character
    end
end

function blackballs(label)
    local player
    for _,v in pairs(players:GetPlayers()) do
        if v.Character ~= nil and (string.lower(v.Character.Name) == string.lower(string.gsub(tostring(label.Text),"[^%w%s_]+",""))) then
            player = v
            break
        end
    end
    if player then
        task.spawn(spectatePlayer,player)

        if isSpectating then
            label.TextColor3 = Color3.new(1,0,0)
            for _,v in pairs(label.Parent:GetChildren()) do
                if v == label then continue end
                v.TextColor3 = Color3.new(1,1,1)
            end
        else
            for _,v in pairs(label.Parent:GetChildren()) do
                v.TextColor3 = Color3.new(1,1,1)
            end
        end
    end
end

local s,e = pcall(function()
    uis.InputBegan:Connect(function(input,gpe)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
            local objects = plr.PlayerGui:GetGuiObjectsAtPosition(input.Position.X,input.Position.Y)
            local label = objects[1]

            if label.Name == "PlayerLabel" then
                blackballs(label)
            end
        elseif input.KeyCode == instantlogkeybind then
            plr:Kick("Instant Log")
            task.wait()
            COREGUI.RobloxPromptGui.promptOverlay.ErrorPrompt.TitleFrame.ErrorTitle.TextColor3 = Color3.new(1,0,0)
            COREGUI.RobloxPromptGui.promptOverlay.ErrorPrompt.MessageArea.ErrorFrame.ErrorMessage.TextColor3 = Color3.new(1,0,0)
            COREGUI.RobloxPromptGui.promptOverlay.ErrorPrompt.TitleFrame.ErrorTitle.Text = "Quad Hub"
            COREGUI.RobloxPromptGui.promptOverlay.ErrorPrompt.MessageArea.ErrorFrame.ErrorMessage.Text = "Instant Log"
        end
    end)
end)
if not s then warn(e) end

local mods = {}
local illus = {}
local observing = {}

local backpackAdded = function(tool)
    local player = tool.Parent.Parent
    if library.flags["IllusionistDetectionNotif"] and tool.Name == "Observe" then
        if observing[player] then
            observing[player] = false
            sg:SetCore("SendNotification", {
                Title = "Illusionist Observe",
                Text = player.Name.." stopped observing",
                Duration = 3,
                Button1 = "OK"
            })
            return
        end

        illus[player] = true
        sg:SetCore("SendNotification", {
            Title = "Illusionist Detected",
            Text = player.Name,
            Duration = 9e9,
            Button1 = "OK"
        })
    end
end

local backpackRemoved = function(tool,player)
    if library.flags["IllusionistDetectionNotif"] and tool.Name == "Observe" then
        if player.Character and player.Character:FindFirstChild("Observe") then
            observing[player] = true
            sg:SetCore("SendNotification", {
                Title = "Illusionist Observe",
                Text = player.Name.." began observing",
                Duration = 3,
                Button1 = "OK"
            })
            return
        end

        illus[player] = false
        sg:SetCore("SendNotification", {
            Title = "Illusionist Wiped",
            Text = player.Name,
            Duration = 9e9,
            Button1 = "OK"
        })
    end
end

local groupMemberAllowedRoles = {
    "member",
    "guest",
    "player",
    "open one",
    "access"
}

local playerAdded = function(player)
    if player == plr then return end
    local backpack = player:WaitForChild("Backpack")
    for _,tool in pairs(backpack:GetChildren()) do
        backpackAdded(tool)
    end
    backpack.ChildAdded:Connect(backpackAdded)
    backpack.ChildRemoved:Connect(function(tool) task.spawn(backpackRemoved,tool,player) end)

    if typeof(creator) == "number" then -- if game creator is a group and not a player
        if player:IsInGroup(creator) and not (table.find(groupMemberAllowedRoles,string.lower(player:GetRoleInGroup(creator)))) then
            mods[player] = true
            sg:SetCore("SendNotification", {
                Title = "Group Member Detected",
                Text = player.Name.."\n("..player:GetRoleInGroup(creator)..")",
                Duration = 9e9,
                Button1 = "OK"
            })
        end
    end
end

local playerRemoved = function(player)
    if mods[player] == true then
        mods[player] = false
        sg:SetCore("SendNotification", {
            Title = "Group Member Left",
            Text = player.Name.."\n("..player:GetRoleInGroup(creator)..")",
            Duration = 9e9,
            Button1 = "OK"
        })
    end
    if library.flags["IllusionistDetectionNotif"] and illus[player] == true then
        illus[player] = false
        sg:SetCore("SendNotification", {
            Title = "Illusionist Left",
            Text = player.Name,
            Duration = 9e9,
            Button1 = "OK"
        })
    end
end

for _,v in pairs(players:GetPlayers()) do task.spawn(playerAdded,v) end
players.PlayerAdded:Connect(playerAdded)
players.PlayerRemoving:Connect(playerRemoved)

local mt = getrawmetatable(game)
setreadonly(mt,false)
local oldnewindex
oldnewindex = hookmetamethod(game, "__newindex", newcclosure(function(self,prop,val)
    if not checkcaller() and not _G.QUADHUB_UNLOADED then
        if self.Name == "Lighting" then
            if prop == "FogEnd" and library.flags["NoFog"] then
                return oldnewindex(self,prop,999999999)
            elseif prop == "FogStart" and library.flags["NoFog"] then
                return oldnewindex(self,prop,999999998)
            elseif prop == "Ambient" and library.flags["Fullbright"] then
                return oldnewindex(self,prop, Color3.fromRGB(0.17, 0.23, 0.2))
            elseif prop == "OutdoorAmbient" and library.flags["Fullbright"] then
                return oldnewindex(self,prop,Color3.fromRGB(152,152,152))
            elseif prop == "GlobalShadows" and library.flags["Fullbright"] then
                return oldnewindex(self,prop,false)
            end
        elseif self:IsA("Humanoid") then
            if prop == "WalkSpeed" and library.flags["Speed"] then
                return oldnewindex(self,prop,library.flags["WalkSpeed"])
            elseif prop == "JumpPower" and library.flags["InfJumpEnabled"] then
                return oldnewindex(self,prop,library.flags["InfJump_JumpPower"])
            end
        end
    end 
    return oldnewindex(self,prop,val)
end))

local hook = hookfunction or detour_function
local old
old = hook(Instance.new("RemoteEvent").FireServer,function(self,...)
    local args = {...}
    if not _G.QUADHUB_UNLOADED and plr.Character ~= nil and plr.Character:FindFirstChild("CharacterHandler") and plr.Character.CharacterHandler:FindFirstChild("Remotes") and self.Parent == plr.Character.CharacterHandler.Remotes and (self.Name == "ApplyFallDamage" or self.Name == "FallDamage" or self.Name == "ApplyFall" or self.Name == "Fall") then
        if not checkcaller() and library.flags["NoFall"] and #args == 1 and typeof(args[1]) == "number" and math.floor(args[1]) ~= args[1] then
            return nil
        end
    end
    return old(self,...)
end)

-- sanctum bananim: 9389354015

--[[local oldanim
oldanim = hook(Instance.new("Humanoid"):LoadAnimation(),function(self,...)
    local args = {...}

    if string.find(tostring(args[1]),"0") then
        return nil
    end

    return oldanim(self,...)
end)]]

task.spawn(function()
    local vu = game:GetService("VirtualUser")
    plr.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end)

setreadonly(mt,true)
