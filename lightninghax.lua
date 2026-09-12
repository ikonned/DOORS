local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "lightninghax [ Matex_xyz ]",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by @matex_xyz",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "ExampleHub2",
        FileName = "Settings2"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = true
    },
    KeySystem = false,
})

Rayfield:Notify({
   Title = "lightninghax Successfully Loaded",
   Content = "By @matex_xyz",
   Duration = 11.5,
   Image = 98381986793772,
})

-- TABS
local HomeTab = Window:CreateTab("Home", 98381986793772)
local ExploitsTab = Window:CreateTab("Exploits", 10448639430)
local ChamsTab = Window:CreateTab("Chams", 14380950090)
local SpawnsTab = Window:CreateTab("Spawns", 11278229112)
local PlushysTab = Window:CreateTab("Plushys", 11924266902)
local ExtraTab = Window:CreateTab("Extra", 16587986504)
local Tools = Window:CreateTab("Tools", 0)

-- PARAGRAPH
HomeTab:CreateParagraph({
    Title = "Note:",
    Content = "Execute Figure or Seek MODS in the room they will spawn in"
})

---------------------------------------------------
-- HOME SECTION
---------------------------------------------------

HomeTab:CreateButton({
    Name = "Mischievous Tablet [ HOTEL 0 ]",
    Callback = function()

        function giveTablet()
            local Scanner = game:GetObjects("rbxassetid://117271882843186")[1]
        
        Scanner.Parent = game.Players.LocalPlayer.Backpack
        _G.scanner_fps = 1000
        local target_fps = _G.scanner_fps or 1000
        local disable_static = _G.disable_static or false
        
        -- Variables
        local Storage = Scanner:WaitForChild("Storage")
        local Handle = Scanner:WaitForChild("Handle", 1)
        local ScannerViewportFrame = Storage.ScreenUI
        
        local ScannerActivateTickDelay = tick()
        
        local ScannerCamera = Instance.new("Camera")
        
        local TweenService = game:GetService("TweenService")
        local player = game.Players.LocalPlayer
        
        local LastScannedRoom = -1
        local CalculatedFPSWait = (1 / target_fps)
        
        local IsScannerOpened = false
        local Equipped = false
        
        -- tables
        local ScannerObjectives = {
            "KeyObtain",
            "LeverForGate",
            "LiveBreakerPolePickup",
            "LiveHintBook",
            "FuseObtain",
            "MinesAnchor",
            "WaterPump",
            "TimerLever",
            "RoomEntrance"
        }
        
        local StaticImageUrl = {
            "rbxassetid://8681113666",
            "rbxassetid://8681113503"
        }
        
        local LoadedAnimations = {}
        
        
        -- Animation Functions
        local function ScannerStaticStart()
            ScannerViewportFrame.OffScreen.Visible = false
        
            ScannerViewportFrame.Static1.ImageTransparency = 0
            ScannerViewportFrame.Static2.ImageTransparency = 0
        
            TweenService:Create(ScannerViewportFrame.Static1, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
                ImageTransparency = 0.9
            }):Play()
        
            TweenService:Create(ScannerViewportFrame.Static2, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
                ImageTransparency = 1
            }):Play()
        
            ScannerViewportFrame.ViewSpecial.ImageColor3 = Color3.fromRGB(217, 255, 206)
        
            TweenService:Create(ScannerViewportFrame.ViewSpecial, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut, 10, true), {
                ImageColor3 = Color3.fromRGB(53, 93, 52)
            }):Play()
        
            ScannerCamera.FieldOfView = 1
        
            TweenService:Create(ScannerCamera, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
                FieldOfView = 30
            }):Play()
        
            Scanner.Handle.Use:Play()
            Scanner.Handle.Idle:Play()
        end
        
        local function ScannerStaticStop()
            ScannerViewportFrame.OffScreen.Visible = true
            ScannerViewportFrame.OffScreen.Frame.Size = UDim2.new(1, 0, 1, 0)
        
            TweenService:Create(ScannerViewportFrame.OffScreen.Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(1, 0, 0.1, 0)
            }):Play()
        
            task.delay(0.31, function()
                TweenService:Create(ScannerViewportFrame.OffScreen.Frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0), {
                    Size = UDim2.new(0, 0, 0.1, 0)
                }):Play()
            end)
        
            ScannerViewportFrame.OffScreen.BackgroundColor3 = Color3.fromRGB(39, 59, 33)
            TweenService:Create(ScannerViewportFrame.OffScreen, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0), {
                BackgroundColor3 = Color3.fromRGB(3, 6, 2)
            }):Play()
        
            Scanner.Handle.Disable:Play()
            Scanner.Handle.Idle:Stop()
        end
        
        local function ScannerAnimateStatic()
            ScannerViewportFrame.Static1.Position = UDim2.new(0.5, math.random(-28, 28) * 6, 0.5, math.random(-18, 18) * 6)
            ScannerViewportFrame.Static2.Position = UDim2.new(0.5, math.random(-28, 28) * 6, 0.5, math.random(-18, 18) * 6)
        
            local static_image = StaticImageUrl[math.random(1, #StaticImageUrl)]
            ScannerViewportFrame.Static1.Image = static_image
        end
        
        -- Essential Functions
        
        local function SetupScannerView(room)
            local ScannerRoomView = Instance.new("Model", ScannerViewportFrame.ViewNormal)
            ScannerRoomView.Name = room.Name
        
            local function SetupCloneRoomPart(instance)
                if instance:IsA("BasePart") and instance.Transparency ~= 1 and instance.Size.Magnitude > 0.2 then
                    local current_room_part = instance:Clone()
        
                    current_room_part.CanQuery = false
                    current_room_part.Parent = ScannerRoomView
        
                    if not instance.Anchored then
                        task.spawn(function()
                            while task.wait(0.5) do
                                if not instance or not instance.Parent then
                                    break
                                end
                            
                                current_room_part.Position = instance.Position
                            end
                            
                            current_room_part:Destroy()
                        end)
                    end
                end
        
                if instance:IsA("Model") and table.find(ScannerObjectives, instance.Name) then
                    local StarObjective = Storage.Star:Clone()
        
                    StarObjective.CFrame = instance.PrimaryPart.CFrame or instance:GetPivot()
                    StarObjective.Parent = ScannerViewportFrame.ViewSpecial
                end
            end
        
        
            for _, v in pairs(room:GetDescendants()) do
                SetupCloneRoomPart(v)
            end
        
            local connection = room.DescendantAdded:Connect(function(part)
                SetupCloneRoomPart(part)
            end)
        
            ScannerRoomView.AncestryChanged:Connect(function()
                connection:Disconnect()
            end)
        end
        
        local function CleanupScannerView()
            for _, v in pairs(ScannerViewportFrame.ViewNormal:GetChildren()) do
                if v:IsA("Model") then
                    v:Destroy()
                end
            end
            
            for _, v in pairs(ScannerViewportFrame.ViewSpecial:GetChildren()) do
                if v:IsA("BasePart") then
                    v:Destroy()
                end
            end
        end
        
        
        ScannerCamera.Parent = ScannerViewportFrame
        ScannerCamera.FieldOfView = 50
        
        ScannerViewportFrame.ViewNormal.CurrentCamera = ScannerCamera
        ScannerViewportFrame.ViewSpecial.CurrentCamera = ScannerCamera
        
        Scanner.Activated:Connect(function()
            if not (ScannerActivateTickDelay <= tick()) then
                return
            end
        
            if ScannerActivateTickDelay <= tick() then
                ScannerActivateTickDelay = tick() + 0.5
        
                LoadedAnimations.fire:Play(0.05, 1, 1)
        
                task.wait(0.2)
        
                IsScannerOpened = not IsScannerOpened
        
                if not IsScannerOpened then
                    return ScannerStaticStop()
                end
            end
        
            ScannerStaticStart()
        end)
        
        Scanner.Equipped:Connect(function()
            for _, anim in pairs(Scanner:WaitForChild("Animations"):GetChildren()) do
                LoadedAnimations[anim.Name] = player.Character.Humanoid:LoadAnimation(anim)
            end
        
            LoadedAnimations.equip:Play()
            LoadedAnimations.idle:Play()
        
            ScannerViewportFrame.Parent = player.PlayerGui
            ScannerViewportFrame.Enabled = true
            ScannerViewportFrame.Adornee = Scanner:WaitForChild("Handle"):WaitForChild("Screen")
        
            local target_room = player:GetAttribute("CurrentRoom")
            LastScannedRoom = target_room
        
            local room_instance = workspace.CurrentRooms:FindFirstChild(target_room)
            if room_instance and ScannerViewportFrame.ViewNormal:FindFirstChild(target_room) == nil then
                SetupScannerView(room_instance)
            end
        
            task.wait(0.2)
        
            Equipped = true
            IsScannerOpened = true
        
            ScannerStaticStart()
        
            while Equipped do
                if IsScannerOpened then
                    
                    local success, errormsg = pcall(function()
                        target_room = player:GetAttribute("CurrentRoom")
        
                        if not disable_static then
                            ScannerCamera.CFrame = Scanner.Handle.Screen.CFrame * CFrame.Angles(0, 3.15, 0)
                            ScannerViewportFrame.ViewNormal.LightDirection = ScannerCamera.CFrame.LookVector - Vector3.new(0, 1, 0)
                            
                            ScannerAnimateStatic()
                        end
        
                        if disable_static and not ScannerViewportFrame.Static1.Visible then
                            ScannerViewportFrame.Static1.Visible = false
                            ScannerViewportFrame.Static2.Visible = false
                        end
        
                        for _, v in pairs(ScannerViewportFrame.ViewSpecial:GetChildren()) do
                            if v:IsA("BasePart") then
                                v.CFrame = CFrame.new(v.Position, ScannerCamera.CFrame.Position)
                            end
                        end
        
                        if target_room ~= LastScannedRoom then
                            LastScannedRoom = target_room
        
                            ScannerStaticStart()
                            CleanupScannerView()
        
                            room_instance = workspace.CurrentRooms:FindFirstChild(target_room)
                            if room_instance and ScannerViewportFrame.ViewNormal:FindFirstChild(target_room) == nil then
                                SetupScannerView(room_instance)
                            end
                        end
                    end)
                    
                    if errormsg then
                        warn(errormsg)
                    end
                end
        
                if not Equipped then
                    break
                end
        
                task.wait(CalculatedFPSWait)
            end
        end)
        
        Scanner.Unequipped:Connect(function()
            ScannerViewportFrame.Parent = script
            ScannerViewportFrame.Enabled = false
        
            Equipped = false
        
        
            for _, v in pairs(Handle:GetChildren()) do
                if v:IsA("Sound") then
                    v:Stop()
                end
            end
        
            Scanner.Handle.Disable:Play()
        
            CleanupScannerView()
        
            LoadedAnimations.equip:Stop()
            LoadedAnimations.idle:Stop()
        end)
        end
        
        local model = game:GetObjects("rbxassetid://72100839686852")[1]
            
            local lid = model.Lid
            local Torso = model.Torso
            local P2 = Torso.Parent.Tablet.ProximityPrompt2
            model.Parent = game.Workspace
            model:SetPrimaryPartCFrame(CFrame.new(277.521, -2.986, -35.233) * CFrame.Angles(0, math.rad(14.925), 0))
            
            local Sound = model.Open
            
            local novaPosicao = Vector3.new(278.878, -1.696, -35.652)
            local novaRotacao = Vector3.new(66.559, -72.771, 180)
            
            Torso.ProximityPrompt.Triggered:Connect(function()
                Sound:Play()
                lid.Position = novaPosicao
                lid.Orientation = novaRotacao
                lid.Latches.Position = novaPosicao
                lid.Latches.Orientation = novaRotacao
                lid.Metal.Position = novaPosicao
                lid.Metal.Orientation = novaRotacao
                lid.NormalHandle.Position = novaPosicao
                lid.NormalHandle.Orientation = novaRotacao
                lid.Wood.Position = novaPosicao
                lid.Wood.Orientation = novaRotacao
                Torso.ProximityPrompt.Enabled = false
                P2.Enabled = true
            end)
            
            P2.Triggered:Connect(function()
                giveTablet()
                model.Tablet:Destroy()
            end)

    end,
})

HomeTab:CreateButton({
    Name = "Buff Figure [ SEEK ]",
    Callback = function()

        local ToFind =
            workspace:FindFirstChild("SeekMoving")
            or workspace:FindFirstChild("SeekMovingNewClone")

        if ToFind then

            for _, Color in pairs(ToFind:GetDescendants()) do
                if Color:IsA("BasePart") or Color:IsA("Decal") then
                    Color.Transparency = 1
                end
            end

            local Figure = game:GetObjects("rbxassetid://17147503424")[1]

            Figure.Body.Weld.C0 =
                CFrame.new(0,0,0)
                * CFrame.Angles(math.rad(0), math.rad(180), math.rad(0))

            Figure.Body.Weld.Part1 =
                ToFind.SeekRig.UpperTorso

            Figure.Parent = ToFind.SeekRig
        end
    end,
})

HomeTab:CreateButton({
    Name = "Big Seek [ SEEK ]",
    Callback = function()

-- SEEK

function Setup(SeekMoving : Model)
    for _, Color : BasePart in pairs(SeekMoving:GetDescendants()) do
        if Color:IsA("BasePart") or Color:IsA("Decal") then
            Color.Transparency = 1
        end
    end

    for _, Cheese : Beam in pairs(SeekMoving:GetDescendants()) do
        if Cheese:IsA("Beam") and Cheese.Name == "StringCheese" then
            Cheese:Destroy()
        end
    end

    task.wait()

    local Seek : Model = game:GetObjects("rbxassetid://137059330176031")[1]
    Seek.Weld.Part1 = SeekMoving.SeekRig.UpperTorso
    Seek.Parent = SeekMoving.SeekRig
end

local SeekMoving : Model = workspace:FindFirstChild("SeekMoving") or workspace:FindFirstChild("SeekMovingNewClone")
if SeekMoving then
    Setup(SeekMoving)
end
workspace.ChildAdded:Connect(function(Child : Model)
    task.wait(3)
    
    if Child.Name == "SeekMoving" or Child.Name == "SeekMovingNewClone" then
        Setup(Child)
    end
end)

    end,
})

HomeTab:CreateButton({
    Name = "Buff Figure [ FIGURE ]",
    Callback = function()

-- FIGURE

function Setup(Child : Folder)
    local Figure = Child:FindFirstChild("FigureSetup")

    if Figure then
        Figure = Figure.FigureRig
        
        for _, Obj : Object in pairs(Figure:GetDescendants()) do
            if Obj:IsA("BasePart") or Obj:IsA("Decal") then
                Obj.Transparency = 1
            end
        end

        task.wait()

        local BigFigure : Model = game:GetObjects("rbxassetid://80300729404499")[1]    
        BigFigure.Parent = Figure

        while Figure and BigFigure do
            BigFigure.Body.CFrame = Figure.Torso.CFrame * CFrame.Angles(0, math.rad(180), 0)

            task.wait()
        end
    end
end
workspace.CurrentRooms.ChildAdded:Connect(function(Child : Folder)
    task.wait(3)
    Setup(Child)
end)

for _, Child : Folder in pairs(workspace.CurrentRooms:GetChildren()) do
    Setup(Child)
end
    end,
})

HomeTab:CreateButton({
    Name = "Big Seek [ FIGURE ]",
    Callback = function()

-- FIGURE

function SetupFigure(Child)
	local Figure = Child:FindFirstChild("FigureSetup")

	if not Figure then
		return
	end

	Figure = Child.FigureSetup.FigureRig

	for _, v in pairs(Figure:GetDescendants()) do
		if v:IsA("BasePart") or v:IsA("Decal") then
			v.Transparency = 1
		end
	end

	task.wait()

	local Seek = game:GetObjects("rbxassetid://17147814210")[1]	
	Seek.Weld.Part1 = Figure.Torso
	Seek.Parent = Figure
end

workspace.CurrentRooms.ChildAdded:Connect(function(Child)
	task.wait(3)
	SetupFigure(Child)
end)
for _, Child in pairs(workspace.CurrentRooms:GetChildren()) do
	SetupFigure(Child)
end

    end,
})

---------------------------------------------------
-- EXPLOITS SECTION
---------------------------------------------------

local SpeedValue = 22

ExploitsTab:CreateSlider({
    Name = "Speed Boost",
    Range = {16, 99},
    Increment = 1,
    Suffix = " Speed",
    CurrentValue = 22,
    Flag = "SpeedBoostSlider",

    Callback = function(Value)
        SpeedValue = Value

        if getgenv().SpeedBypass then
            if Character and Character:FindFirstChildOfClass("Humanoid") then
                Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Value
            end

            pcall(function()
                UpdateSpeedBypassLabel(Value)
            end)
        end
    end
})

local SpeedBoostConnection

ExploitsTab:CreateToggle({
    Name = "Enable Speed Boots",
    CurrentValue = false,
    Flag = "EnableSpeedBoost",

    Callback = function(Value)

        if not Value then
            getgenv().SpeedBypass = false
            OldHotel = false

            local Clone = Character and Character:FindFirstChild("ClonedCollision")
            if Clone then
                Clone:Destroy()
            end

            if SpeedBoostConnection then
                SpeedBoostConnection:Disconnect()
                SpeedBoostConnection = nil
            end

            StopWalkSpeedForce()
            RestoreWalkSpeed()

            if Character then
                local HRP = Character:FindFirstChild("HumanoidRootPart")

                if HRP then
                    HRP.Massless = false
                    HRP.RootPriority = 0
                end
            end

            return
        end

        getgenv().SpeedBypass = true

        if RemotesFolder.Name == "Bricks" then
            OldHotel = true
            ApplyWalkSpeedBoost()
            StartWalkSpeedForce()
        end

        StartSpeedBypassLoop()

        if SpeedBoostConnection then
            SpeedBoostConnection:Disconnect()
        end

        SpeedBoostConnection = game:GetService("RunService").Heartbeat:Connect(function()

            if Character and Character:FindFirstChildOfClass("Humanoid") then
                Character:FindFirstChildOfClass("Humanoid").WalkSpeed = SpeedValue
            end

            ApplyWalkSpeedBoost()
        end)

        task.spawn(function()
            task.wait(0.35)

            if Character and not Character:FindFirstChild("ClonedCollision") then
                local Collision = Character:FindFirstChild("Collision")

                if Collision then
                    local Clone = Collision:Clone()
                    Clone.Name = "ClonedCollision"
                    Clone.Parent = Character
                    Clone.CanCollide = false
                    Clone.Massless = true

                    local Crouch = Clone:FindFirstChild("CollisionCrouch")
                    if Crouch then
                        Crouch:Destroy()
                    end
                end
            end
        end)

    end
})

ExploitsTab:CreateButton({
    Name = "Break Doors",
    Callback = function()
for _, v in pairs(workspace:GetDescendants()) do
	if v.Name == "Door" then
		pcall(function()
			v:Destroy()
		end)
	end
end

    end,
})

ExploitsTab:CreateButton({
    Name = "Break Elevators",
    Callback = function()
for _, v in pairs(workspace:GetDescendants()) do
	if string.lower(v.Name):find("elevator") then
		pcall(function()
			v:Destroy()
		end)
	end
end

    end,
})

local BypassSeek = false
local SeekConnections = {}
local SeekDeleted = {}

local function DisconnectSeekConnections()
    for _, c in pairs(SeekConnections) do
        c:Disconnect()
    end
    table.clear(SeekConnections)
end

local function DeleteSeekTrigger(trigger)
    if SeekDeleted[trigger] then return end
    SeekDeleted[trigger] = true

    for _, part in pairs(trigger:GetChildren()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
            part.CanTouch = false
        end
    end
end

local function WatchForSeekTriggers()
    DisconnectSeekConnections()

    local function CheckSeek(inst)
        if not BypassSeek then return end
        if inst.Name == "TriggerEventCollision" then
            DeleteSeekTrigger(inst)
        end
    end

    for _, desc in pairs(workspace:GetDescendants()) do
        CheckSeek(desc)
    end

    SeekConnections["Added"] = workspace.DescendantAdded:Connect(CheckSeek)
end

ExploitsTab:CreateToggle({
    Name = "Delete Seek Hotel - [ TROLL ]",
    CurrentValue = false,
    Callback = function(Value)
        BypassSeek = Value

        if Value then
            WatchForSeekTriggers()
        else
            DisconnectSeekConnections()
        end
    end
})

local PadlockConnection

ExploitsTab:CreateToggle({
    Name = "Auto Padlock [ LIBRARY ]",
    CurrentValue = false,
    Flag = "AutoPadlock",
    Callback = function(Value)

        if Value then

            local function padlock_Fix()
                local Character = LocalPlayer.Character
                if not Character then
                    return {"_","_","_","_","_"}
                end

                local Paper = Character:FindFirstChild("LibraryHintPaper")
                local Hints = LocalPlayer.PlayerGui:WaitForChild("PermUI"):WaitForChild("Hints")

                local Code = {"_","_","_","_","_"}

                if Paper then
                    for _, v in ipairs(Paper.UI:GetChildren()) do
                        if v:IsA("ImageLabel") and v.Name ~= "Image" then
                            for _, img in ipairs(Hints:GetChildren()) do
                                if img:IsA("ImageLabel")
                                    and img.Visible
                                    and v.ImageRectOffset == img.ImageRectOffset then

                                    Code[tonumber(v.Name)] =
                                        img:FindFirstChild("TextLabel").Text
                                end
                            end
                        end
                    end
                end

                return Code
            end

            if PadlockConnection then
                PadlockConnection:Disconnect()
            end

            PadlockConnection = LocalPlayer.Character.ChildAdded:Connect(function(Check)

                if Check:IsA("Tool") and Check.Name == "LibraryHintPaper" then

                    local Code = table.concat(padlock_Fix())

                    if Code:find("_") then
                        return
                    end

                    Rayfield:Notify({
                        Title = "Auto Padlock",
                        Content = "Code: "..Code,
                        Duration = 5,
                        Image = 4483345998

                    })

                    RemotesFolder.PL:FireServer(Code)
                end
            end)

        else

            if PadlockConnection then
                PadlockConnection:Disconnect()
                PadlockConnection = nil
            end

        end
    end
})

ExploitsTab:CreateToggle({
    Name = "Disable A-90",
    CurrentValue = false,
    Flag = "DisableA90",
    Callback = function(Value)

        local Modules = game.Players.LocalPlayer.PlayerGui.MainUI
            .Initiator.Main_Game.RemoteListener.Modules

        local A90 =
            Modules:FindFirstChild("A90")
            or Modules:FindFirstChild("_A90")
            or Modules:FindFirstChild("A90_Disabled")

        if not A90 then return end

        A90.Name = Value and "A90_Disabled" or "A90"
    end
})

ExploitsTab:CreateToggle({
    Name = "Disable Halt",
    CurrentValue = false,
    Flag = "DisableHalt",
    Callback = function(Value)

        local Modules = game.ReplicatedStorage.ModulesClient.EntityModules

        local Halt =
            Modules:FindFirstChild("Shade")
            or Modules:FindFirstChild("_Shade")
            or Modules:FindFirstChild("Shade_Disabled")

        if not Halt then return end

        Halt.Name = Value and "Shade_Disabled" or "Shade"
    end
})

local AntiSnareConnection

ExploitsTab:CreateToggle({
    Name = "Disable Snare",
    CurrentValue = false,
    Flag = "AntiSnare",
    Callback = function(Value)

        if AntiSnareConnection then
            AntiSnareConnection:Disconnect()
            AntiSnareConnection = nil
        end

        local function SetSnareHitbox(Snare, Enabled)
            if not Snare then
                return
            end

            local Hitbox =
                Snare:FindFirstChild("Hitbox")
                or Snare:FindFirstChild("HitboxPart")
                or Snare:FindFirstChild("HitboxMesh")

            if Hitbox and Hitbox:IsA("BasePart") then
                Hitbox.CanTouch = Enabled
            end
        end

        local function UpdateAllSnares(Enabled)
            for _, Room in ipairs(workspace.CurrentRooms:GetChildren()) do
                local Assets = Room:FindFirstChild("Assets")
                if not Assets then
                    continue
                end

                local SnaresFolder = Assets:FindFirstChild("Snares")
                if SnaresFolder then
                    for _, Snare in ipairs(SnaresFolder:GetChildren()) do
                        if Snare.Name == "Snare" then
                            SetSnareHitbox(Snare, Enabled)
                        end
                    end
                end

                local Snare = Assets:FindFirstChild("Snare")
                if Snare then
                    SetSnareHitbox(Snare, Enabled)
                end
            end
        end

        if not Value then
            UpdateAllSnares(true)
            return
        end

        UpdateAllSnares(false)

        AntiSnareConnection = workspace.DescendantAdded:Connect(function(Object)

            if Object.Name == "Snares" then
                for _, Snare in ipairs(Object:GetChildren()) do
                    if Snare.Name == "Snare" then
                        SetSnareHitbox(Snare, false)
                    end
                end
            end

            if Object.Name == "Snare" then
                SetSnareHitbox(Object, false)
            end

            if Object.Name == "Hitbox"
                or Object.Name == "HitboxPart"
                or Object.Name == "HitboxMesh" then

                local Parent = Object.Parent

                if Parent and Parent.Name == "Snare" and Object:IsA("BasePart") then
                    Object.CanTouch = false
                end
            end

        end)

    end
})

ExploitsTab:CreateToggle({
    Name = "Disable Screech",
    CurrentValue = false,
    Flag = "DisableScreech",
    Callback = function(Value)

        local Modules = game.Players.LocalPlayer.PlayerGui.MainUI
            .Initiator.Main_Game.RemoteListener.Modules

        local Screech =
            Modules:FindFirstChild("Screech")
            or Modules:FindFirstChild("_Screech")
            or Modules:FindFirstChild("Screech_Disabled")

        if not Screech then return end

        Screech.Name = Value and "Screech_Disabled" or "Screech"
    end
})

ExploitsTab:CreateToggle({
    Name = "Disable Dread",
    CurrentValue = false,
    Flag = "DisableDread",
    Callback = function(Value)

        local Modules = game.Players.LocalPlayer.PlayerGui.MainUI
            .Initiator.Main_Game.RemoteListener.Modules

        local Dread =
            Modules:FindFirstChild("Dread")
            or Modules:FindFirstChild("_Dread")
            or Modules:FindFirstChild("Dread_Disabled")

        if not Dread then return end

        Dread.Name = Value and "Dread_Disabled" or "Dread"
    end
})

local AntiFHConnection

ExploitsTab:CreateToggle({
    Name = "Anti Figure Hearing",
    CurrentValue = false,
    Flag = "AntiFigureHearing",
    Callback = function(Value)

        if AntiFHConnection then
            AntiFHConnection:Disconnect()
            AntiFHConnection = nil
        end

        if not Value then

            if RemotesFolder:FindFirstChild("Crouch") then
                RemotesFolder.Crouch:FireServer(false)
            end

            return
        end

        if RemotesFolder:FindFirstChild("Crouch") then
            RemotesFolder.Crouch:FireServer(true)
        end

        AntiFHConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if RemotesFolder:FindFirstChild("Crouch") then
                RemotesFolder.Crouch:FireServer(true)
            end
        end)

    end
})

local AntiJeffConnection

ExploitsTab:CreateToggle({
    Name = "Anti Jeff",
    CurrentValue = false,
    Flag = "AntiJeff",
    Callback = function(Value)

        if AntiJeffConnection then
            AntiJeffConnection:Disconnect()
            AntiJeffConnection = nil
        end

        if not Value then
            return
        end

        local function KillJeff(Model)
            if not Model then
                return
            end

            task.delay(0.5, function()
                if not Model or not Model.Parent then
                    return
                end

                local Humanoid =
                    Model:FindFirstChild("Humanoid")
                    or Model:WaitForChild("Humanoid", 2)

                if Humanoid then
                    Humanoid.Health = 0
                end
            end)
        end

        local Existing = workspace:FindFirstChild("JeffTheKiller")
        if Existing then
            KillJeff(Existing)
        end

        AntiJeffConnection = workspace.ChildAdded:Connect(function(Object)
            if Object.Name == "JeffTheKiller" then
                KillJeff(Object)
            end
        end)

    end
})

---------------------------------------------------
-- CHAMS SECTION
---------------------------------------------------

local FOVConnection
local CurrentFOV = 70

ChamsTab:CreateSlider({
    Name = "Field Of View",
    Range = {10, 120},
    Increment = 1,
    Suffix = " FOV",
    CurrentValue = 70,
    Flag = "FOVSlider",
    Callback = function(Value)

        CurrentFOV = Value

        if FOVConnection then
            FOVConnection:Disconnect()
            FOVConnection = nil
        end

        local Camera = workspace.CurrentCamera
        if not Camera then
            return
        end

        local Tween = game:GetService("TweenService"):Create(
            Camera,
            TweenInfo.new(
                0.25,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.Out
            ),
            {
                FieldOfView = Value
            }
        )

        Tween:Play()

        Tween.Completed:Connect(function()

            FOVConnection = game:GetService("RunService").RenderStepped:Connect(function()

                local Cam = workspace.CurrentCamera

                if Cam then
                    Cam.FieldOfView = CurrentFOV
                end

            end)

        end)

    end
})

local ChestESPEnabled = false
local ChestESPConnection = nil

local ChestNames = {
    "Toolshed_Small",
    "Chest_Vine",
    "ChestBox",
    "ChestBoxLocked",
    "MouseHole",
    "Locker_Small_Locked",
    "Toolbox_Locked",
    "Toolbox"
}

local function createChestESP(obj)
    if not obj then return end
    if obj:FindFirstChild("ChestESPHighlight") then return end
    local h = Instance.new("Highlight")
    h.Name = "ChestESPHighlight"
    h.Adornee = obj
    h.FillColor = Color3.fromRGB(255, 255, 0) -- YELLOW
    h.OutlineColor = Color3.fromRGB(255, 255, 0)
    h.FillTransparency = 0.5
    h.OutlineTransparency = 0
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent = obj

    local box = Instance.new("BoxHandleAdornment")
    box.Name = "ChestESPBox"
    box.Adornee = obj
    box.AlwaysOnTop = true
    box.ZIndex = 5
    box.Size = obj:IsA("Model") and obj:GetExtentsSize() or Vector3.new(4,4,4)
    box.Color3 = Color3.fromRGB(255, 255, 0) -- YELLOW
    box.Transparency = 0.75
    box.Parent = obj
end
local function removeChestESP()
    for _, v in ipairs(workspace:GetDescendants()) do
        local h = v:FindFirstChild("ChestESPHighlight")
        if h then h:Destroy() end

        local b = v:FindFirstChild("ChestESPBox")
        if b then b:Destroy() end
    end
end

local function scanChests()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if table.find(ChestNames, obj.Name) then
            createChestESP(obj)
        end
    end
end

ChamsTab:CreateToggle({
    Name = "ESP Chests",
    CurrentValue = false,
    Flag = "ChestESP",

    Callback = function(Value)
        ChestESPEnabled = Value

        if Value then
            scanChests()

            ChestESPConnection = workspace.DescendantAdded:Connect(function(obj)
                if not ChestESPEnabled then return end

                if table.find(ChestNames, obj.Name) then
                    task.wait()
                    createChestESP(obj)
                end
            end)
        else
            if ChestESPConnection then
                ChestESPConnection:Disconnect()
                ChestESPConnection = nil
            end

            removeChestESP()
        end
    end,
})

local ItemESPEnabled = false
local ItemESPConnection = nil

local ItemNames = {
    "Lighter","Flashlight","Lockpick","Vitamins","Bandage",
    "StarVial","StarBottle","StarJug","Shakelight","Straplight",
    "Bulklight","Battery","Candle","Crucifix","CrucifixWall",
    "Glowsticks","SkeletonKey","Candy","ShieldMini","ShieldBig",
    "BandagePack","BatteryPack","RiftCandle","LaserPointer",
    "HolyGrenade","Shears","Smoothie","Cheese","Bread",
    "AlarmClock","RiftSmoothie","GweenSoda","GlitchCube",
    "Scanner","Bomb","Knockbomb","Nanner","BigBomb",
    "SnakeBox","GoldGun","StopSign","TipJar","Lantern",
    "IronKey","LotusPetal","Compass","LotusPetalPickup",
    "LanternLitItem","KeyIron","IronKeyForCrypt","LotusHolder",
    "Multitool","RiftJar","AloeVera","Donut","Lotus",
    "BoxingGloves","Green_Herb"
}

local function createESP(obj)
    if not obj then return end
    if obj:FindFirstChild("ItemESPHighlight") then return end

    -- Highlight (YELLOW)
    local h = Instance.new("Highlight")
    h.Name = "ItemESPHighlight"
    h.Adornee = obj
    h.FillColor = Color3.fromRGB(255, 255, 0)
    h.OutlineColor = Color3.fromRGB(255, 255, 0)
    h.FillTransparency = 0.5
    h.OutlineTransparency = 0
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent = obj

    -- Box ESP (optional, same yellow)
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "ItemESPBox"
    box.Adornee = obj
    box.AlwaysOnTop = true
    box.ZIndex = 5
    box.Size = obj:IsA("Model") and obj:GetExtentsSize() or Vector3.new(4,4,4)
    box.Color3 = Color3.fromRGB(255, 255, 0)
    box.Transparency = 0.75
    box.Parent = obj
end

local function removeESP()
    for _, v in ipairs(workspace:GetDescendants()) do
        local h = v:FindFirstChild("ItemESPHighlight")
        if h then h:Destroy() end

        local b = v:FindFirstChild("ItemESPBox")
        if b then b:Destroy() end
    end
end

local function scan()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if table.find(ItemNames, obj.Name) then
            createESP(obj)
        end
    end
end

ChamsTab:CreateToggle({
    Name = "ESP Items",
    CurrentValue = false,
    Flag = "ItemESP",

    Callback = function(Value)
        ItemESPEnabled = Value

        if Value then
            scan()

            ItemESPConnection = workspace.DescendantAdded:Connect(function(obj)
                if not ItemESPEnabled then return end
                if table.find(ItemNames, obj.Name) then
                    task.wait()
                    createESP(obj)
                end
            end)
        else
            if ItemESPConnection then
                ItemESPConnection:Disconnect()
                ItemESPConnection = nil
            end

            removeESP()
        end
    end,
})

local ObjectiveESPEnabled = false
local ObjectiveConnection = nil

local Objectives = {
    "LeverForGate",
    "LiveBreakerPolePickup",
    "LiveHintBook",
    "FuseObtain",
    "MinesAnchor",
    "WaterPump",
    "TimerLever",
    "RoomEntrance"
}

local function createObjectiveESP(obj)
    if not obj or obj:FindFirstChild("ObjectiveESPHighlight") then
        return
    end

    local h = Instance.new("Highlight")
    h.Name = "ObjectiveESPHighlight"
    h.FillColor = Color3.fromRGB(0, 250, 10)
    h.OutlineColor = Color3.fromRGB(0, 250, 10)
    h.FillTransparency = 0.6
    h.OutlineTransparency = 0
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Adornee = obj
    h.Parent = obj

    local box = Instance.new("BoxHandleAdornment")
    box.Name = "ObjectiveESPBox"
    box.Adornee = obj
    box.AlwaysOnTop = true
    box.ZIndex = 5
    box.Color3 = Color3.fromRGB(0, 250, 10)
    box.Transparency = 0.75

    if obj:IsA("Model") then
        box.Size = obj:GetExtentsSize()
    elseif obj:IsA("BasePart") then
        box.Size = obj.Size
    else
        box.Size = Vector3.new(4,4,4)
    end

    box.Parent = obj
end

local function createKeyESP(hitbox)
    if not hitbox or hitbox:FindFirstChild("KeyESPHighlight") then
        return
    end

    local h = Instance.new("Highlight")
    h.Name = "KeyESPHighlight"
    h.FillColor = Color3.fromRGB(255,255,0)
    h.OutlineColor = Color3.fromRGB(255,255,0)
    h.FillTransparency = 0.5
    h.OutlineTransparency = 0
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Adornee = hitbox
    h.Parent = hitbox

    local box = Instance.new("BoxHandleAdornment")
    box.Name = "KeyESPBox"
    box.Adornee = hitbox
    box.AlwaysOnTop = true
    box.ZIndex = 5
    box.Color3 = Color3.fromRGB(255,255,0)
    box.Transparency = 0.5
    box.Size = hitbox.Size
    box.Parent = hitbox
end

local function scanObjectives()
    -- Normal objectives
    for _, obj in ipairs(workspace:GetDescendants()) do
        if table.find(Objectives, obj.Name) then
            createObjectiveESP(obj)
        end
    end

    -- Keys
    for _, room in ipairs(workspace.CurrentRooms:GetChildren()) do
        local key = room:FindFirstChild("KeyObtain", true)

        if key then
            local hitbox = key:FindFirstChild("KeyHitbox", true)

            if hitbox and hitbox:IsA("BasePart") then
                createKeyESP(hitbox)
            end
        end
    end
end

local function removeObjectiveESP()
    for _, v in ipairs(workspace:GetDescendants()) do
        local h1 = v:FindFirstChild("ObjectiveESPHighlight")
        local b1 = v:FindFirstChild("ObjectiveESPBox")
        local h2 = v:FindFirstChild("KeyESPHighlight")
        local b2 = v:FindFirstChild("KeyESPBox")

        if h1 then h1:Destroy() end
        if b1 then b1:Destroy() end
        if h2 then h2:Destroy() end
        if b2 then b2:Destroy() end
    end
end

ChamsTab:CreateToggle({
    Name = "ESP Objectives + Doors",
    CurrentValue = false,
    Flag = "ObjectiveHighlights",

    Callback = function(Value)
        ObjectiveESPEnabled = Value

        if Value then
            scanObjectives()

            if ObjectiveConnection then
                ObjectiveConnection:Disconnect()
            end

            ObjectiveConnection = workspace.DescendantAdded:Connect(function(obj)
                if not ObjectiveESPEnabled then
                    return
                end

                task.wait()

                if table.find(Objectives, obj.Name) then
                    createObjectiveESP(obj)
                end

                if obj.Name == "KeyHitbox" and obj:IsA("BasePart") then
                    createKeyESP(obj)
                end
            end)
        else
            if ObjectiveConnection then
                ObjectiveConnection:Disconnect()
                ObjectiveConnection = nil
            end

            removeObjectiveESP()
        end
    end,
})

local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()

SpawnsTab:CreateButton({
    Name = "Ripper",
    Callback = function()
            local killed = false
            local Plr = game.Players.LocalPlayer
            local ReSt = game.ReplicatedStorage
            local val = 80
            local events = require(game.ReplicatedStorage.ClientModules.Module_Events)
            local cameraShaker = require(game.ReplicatedStorage.CameraShaker)
            local camera = workspace.CurrentCamera
    
            local camShake = cameraShaker.new(Enum.RenderPriority.Camera.Value, function(cf)
                camera.CFrame = camera.CFrame * cf
            end)
    
            local function DEATHMESSAGE(message,who)
                spawn(function()
                    for i = 1,50 do wait()
                        game:GetService("ReplicatedStorage").GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = who
                        firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, message, 'Blue')
                    end
                end)
            end
    
            local function GetTime(Distance, Speed)
                local Time = Distance / Speed
                return Time
            end
    
            local DEF_SPEED = 99999
    
            local ambruhspeed = 100
            local storer = ambruhspeed
            local ambushheight = Vector3.new(0,5,0)
            local redtweeninfo = TweenInfo.new(3)
            local redinfo = {Color = Color3.new(1, 0, 0.133333)}
    
            camShake:Shake(cameraShaker.Presets.Earthquake)
            for i,v in pairs(game.Workspace.CurrentRooms:GetDescendants()) do
                if v:IsA("Light") then
                    game.TweenService:Create(v,redtweeninfo,redinfo):Play()
                    if v.Parent.Name == "LightFixture" then
                        game.TweenService:Create(v.Parent,redtweeninfo,redinfo):Play()
                    end
                end
            end
    
            local s = game:GetObjects("rbxassetid://12272798431")[1]
            s.Parent = workspace
            local ambush = s.Ripe
            ambush.Ambush.Volume = 0
            local amb = ambush.Spawn:Clone()
            amb.Parent = workspace
            amb.TimePosition = 0
            amb:Play()
            amb.Volume = 6
    
            game.Debris:AddItem(amb,10)
            ambush.Ambush:Stop()
            local h = ambush.Ambush
            h.SoundId = "rbxassetid://6963538865"
            h.Volume = 10
            h.RollOffMinDistance = 5
            h.PlaybackSpeed = 0.37
            h.TimePosition = 0
            h.Volume = 10
            wait(8)
            ambush.Ambush:Play()
            game.TweenService:Create(ambush.Ambush,TweenInfo.new(6),{Volume = 0.8}):Play()
            local gruh = workspace.CurrentRooms
            ambruhspeed = DEF_SPEED
            
            for i = 1, game.ReplicatedStorage.GameData.LatestRoom.Value + 1 do
                if gruh:FindFirstChild(i) then
                    local room = gruh[i]
                    
                    local waypoint = room.RoomEntrance
                    
                    local Distance = (ambush.Position - waypoint.Position).magnitude
    
                    local Tween = game.TweenService:Create(ambush, TweenInfo.new(GetTime(Distance, ambruhspeed), Enum.EasingStyle.Linear,Enum.EasingDirection.Out), { CFrame = waypoint.CFrame + ambushheight })
                    Tween:Play()
                    Tween.Completed:Wait()
                end
            end
    
            workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value]:WaitForChild("Door").ClientOpen:FireServer()
            local slam = Instance.new("Sound",ambush)
            slam.Volume = 10
            slam.SoundId = "rbxassetid://1837829565"
            camShake:Shake(cameraShaker.Presets.Explosion)
            slam:Play()
            wait(1)
            ambush.Anchored = false
            ambush.CanCollide = false
            game.Debris:AddItem(s,5)
    end,
})

SpawnsTab:CreateButton({
    Name = "Stupid horse",
    Callback = function()
local spawner = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
		spawner.Create({
			Entity = {
				Name = "STUPID HORSE",
				Asset = "https://github.com/MateiDaBest/Utilities/raw/refs/heads/main/Doors/Other/Stupid%20Horse.rbxm",
				HeightOffset = 0
			},
			Lights = {
				Flicker = {
					Enabled = true,
					Duration = 1
				},
				Shatter = true,
				Repair = false
			},
			Earthquake = {
				Enabled = false
			},
			CameraShake = {
				Enabled = true,
				Range = 100,
				Values = {1.5, 20, 0.1, 1}
			},
			Movement = {
				Speed = 100,
				Delay = 2,
				Reversed = false
			},
			Rebounding = {
				Enabled = false,
				Type = "Ambush",
				Min = 1,
				Max = 1,
				Delay = 2
			},
			Damage = {
				Enabled = false,
				Range = 40,
				Amount = 125
			},
			Crucifixion = {
				Enabled = true,
				Range = 40,
				Resist = false,
				Break = true
			},
			Death = {
				Type = "Guiding",
				Hints = {"Stupid", "Horse", "Stupid", "Horse"},
				Cause = ""
			}
		}):Run()

    end,
})

SpawnsTab:CreateButton({
    Name = "Rebound",
    Callback = function()
local spawner = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
		local MainEntity = game:GetObjects("rbxassetid://86937268250993")[1]
		MainEntity.Parent = workspace
		MainEntity.Rebound.CanCollide = false
		local Plr = game:GetService("Players").LocalPlayer
		local CameraShaker = require(game:GetService("ReplicatedStorage").CameraShaker)

		local CamShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(cf)
			workspace.CurrentCamera.CFrame *= cf
		end)

		CamShake:Start()

		local Reboundcolor = Instance.new("ColorCorrectionEffect", game:GetService("Lighting"))
		Reboundcolor.Name = "Warn"
		Reboundcolor.TintColor = Color3.fromRGB(65, 138, 255)
		Reboundcolor.Saturation = -0.7
		Reboundcolor.Contrast = 0.2

		local Tween = game:GetService("TweenService"):Create(Reboundcolor, TweenInfo.new(15), {TintColor = Color3.fromRGB(255, 255, 255), Saturation = 0, Contrast = 0})
		Tween:Play()
		Tween.Completed:Connect(function()
			Reboundcolor:Destroy()
		end)
		CamShake:ShakeOnce(10, 3, 0.1, 6, 2, 0.5)

		task.wait(4)

		MainEntity.Rebound.CFrame = workspace.CurrentRooms[game:GetService("ReplicatedStorage").GameData.LatestRoom.Value].RoomExit.CFrame

		for Room = game:GetService("ReplicatedStorage").GameData.LatestRoom.Value, 0, -1 do
			local MainRoom = workspace.CurrentRooms:FindFirstChild(Room)
			if MainRoom then
				local tween = game:GetService("TweenService"):Create(MainEntity.Rebound, TweenInfo.new(2), {CFrame = MainRoom:FindFirstChild("RoomEntrance").CFrame + Vector3.new(0, 0.6, 0)})				
				tween:Play()
				tween.Completed:Wait()

				task.wait(2)
			end
		end

		MainEntity:Destroy()

    end,
})

SpawnsTab:CreateButton({
    Name = "OG Ambush",
    Callback = function()
local spawner = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
		spawner.Create({
			Entity = {
				Name = "OG Ambush",
				Asset = "https://github.com/MateiDaBest/Utilities/raw/refs/heads/main/Doors/Other/AmbushMoving.rbxm",
				HeightOffset = 0
			},
			Lights = {
				Flicker = {
					Enabled = true,
					Duration = 2
				},
				Shatter = true,
				Repair = false
			},
			Earthquake = {
				Enabled = false
			},
			CameraShake = {
				Enabled = true,
				Range = 100,
				Values = {1.5, 20, 0.1, 1}
			},
			Movement = {
				Speed = 150,
				Delay = 2,
				Reversed = false
			},
			Rebounding = {
				Enabled = true,
				Type = "Ambush",
				Min = 1,
				Max = 5,
				Delay = 2
			},
			Damage = {
				Enabled = false,
				Range = 40,
				Amount = 125
			},
			Crucifixion = {
				Enabled = true,
				Range = 40,
				Resist = false,
				Break = true
			},
			Death = {
				Type = "Guiding",
				Hints = {"OG", "Ambush", "OG", "Ambush"},
				Cause = ""
			}
		}):Run()

    end,
})

SpawnsTab:CreateButton({
    Name = "OG A-60",
    Callback = function()

        local spawner = loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"
        ))()

        local entity = spawner.Create({
            Entity = {
                Name = "A-60",
                Asset = "https://github.com/Idk-lol2/a-60aa/blob/main/11379072534.rbxm?raw=true",
                HeightOffset = 0
            },
            Lights = {
                Flicker = {
                    Enabled = true,
                    Duration = 7
                },
                Shatter = true,
                Repair = false
            },
            Earthquake = {
                Enabled = false
            },
            CameraShake = {
                Enabled = true,
                Range = 100,
                Values = {3, 50, 1, 1}
            },
            Movement = {
                Speed = 135,
                Delay = 11,
                Reversed = false
            },
            Rebounding = {
                Enabled = true,
                Type = "Blitz",
                Min = 2,
                Max = 4,
                Delay = 7
            },
            Damage = {
                Enabled = false,
                Range = 40,
                Amount = 125
            }
        })

        entity:Run()

        print("A-60 Spawned!")
    end,
})

SpawnsTab:CreateButton({
    Name = "Depth",
    Callback = function()

        local spawner = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
		spawner.Create({
			Entity = {
				Name = "Depth",
				Asset = "https://github.com/MateiDaBest/Utilities/raw/refs/heads/main/Doors/Other/DepthMoving.rbxm",
				HeightOffset = 0
			},
			Lights = {
				Flicker = {
					Enabled = true,
					Duration = 1
				},
				Shatter = true,
				Repair = false
			},
			Earthquake = {
				Enabled = false
			},
			CameraShake = {
				Enabled = true,
				Range = 100,
				Values = {1.5, 20, 0.1, 1}
			},
			Movement = {
				Speed = 100,
				Delay = 2,
				Reversed = false
			},
			Rebounding = {
				Enabled = false,
				Type = "Ambush",
				Min = 1,
				Max = 1,
				Delay = 2
			},
			Damage = {
				Enabled = false,
				Range = 40,
				Amount = 125
			},
			Crucifixion = {
				Enabled = true,
				Range = 40,
				Resist = false,
				Break = true
			},
			Death = {
				Type = "Guiding",
				Hints = {"Depth", "Depth", "Depth", "Depth"},
				Cause = ""
			}
		}):Run()
	end,
})


-- PARAGRAPH
PlushysTab:CreateParagraph({
    Title = "Note:",
    Content = "A-120 and Depth plushy can be executed in pre-run shop for there own section in it (Hotel-)"
})

PlushysTab:CreateButton({
    Name = "Rush Plushy",
    Callback = function()
     --[[
 
 RUSH
 AMBUSH
 JACK
 DUPE
 
 ]]--
 
 local RushEnabled = true
 local AmbushEnabled = false
 local JackEnabled = false
 local DupeEnabled = false
 
 ---------------------------------------------------------
 
 local Players = game:GetService("Players")
 local UIS = game:GetService("UserInputService")
 local Plr = Players.LocalPlayer
 local Char = Plr.Character or Plr.CharacterAdded:Wait()
 
 local Rush = game:GetObjects("rbxassetid://106490395325401")[1]
 if RushEnabled then
     Rush.Parent = game.Players.LocalPlayer.Backpack
 end
 
 local Ambush = game:GetObjects("rbxassetid://91769363360905")[1]
 if AmbushEnabled then
     Ambush.Parent = game.Players.LocalPlayer.Backpack
 end
 
 local Jack = game:GetObjects("rbxassetid://135816582968851")[1]
 if JackEnabled then
     Jack.Parent = game.Players.LocalPlayer.Backpack
 end
 
 local Dupe = game:GetObjects("rbxassetid://116858052599982")[1]
 if DupeEnabled then
     Dupe.Parent = game.Players.LocalPlayer.Backpack
 end
    end,
 })
 
PlushysTab:CreateButton({
    Name = "Ambush Plushy",
    Callback = function()
     --[[
 
 RUSH
 AMBUSH
 JACK
 DUPE
 
 ]]--
 
 local RushEnabled = false
 local AmbushEnabled = true
 local JackEnabled = false
 local DupeEnabled = false
 
 ---------------------------------------------------------
 
 local Players = game:GetService("Players")
 local UIS = game:GetService("UserInputService")
 local Plr = Players.LocalPlayer
 local Char = Plr.Character or Plr.CharacterAdded:Wait()
 
 local Rush = game:GetObjects("rbxassetid://106490395325401")[1]
 if RushEnabled then
     Rush.Parent = game.Players.LocalPlayer.Backpack
 end
 
 local Ambush = game:GetObjects("rbxassetid://91769363360905")[1]
 if AmbushEnabled then
     Ambush.Parent = game.Players.LocalPlayer.Backpack
 end
 
 local Jack = game:GetObjects("rbxassetid://135816582968851")[1]
 if JackEnabled then
     Jack.Parent = game.Players.LocalPlayer.Backpack
 end
 
 local Dupe = game:GetObjects("rbxassetid://116858052599982")[1]
 if DupeEnabled then
     Dupe.Parent = game.Players.LocalPlayer.Backpack
 end
    end,
 })
 
PlushysTab:CreateButton({
    Name = "Dupe Plushy",
    Callback = function()
     --[[
 
 RUSH
 AMBUSH
 JACK
 DUPE
 
 ]]--
 
 local RushEnabled = false
 local AmbushEnabled = false
 local JackEnabled = false
 local DupeEnabled = true
 
 ---------------------------------------------------------
 
 local Players = game:GetService("Players")
 local UIS = game:GetService("UserInputService")
 local Plr = Players.LocalPlayer
 local Char = Plr.Character or Plr.CharacterAdded:Wait()
 
 local Rush = game:GetObjects("rbxassetid://106490395325401")[1]
 if RushEnabled then
     Rush.Parent = game.Players.LocalPlayer.Backpack
 end
 
 local Ambush = game:GetObjects("rbxassetid://91769363360905")[1]
 if AmbushEnabled then
     Ambush.Parent = game.Players.LocalPlayer.Backpack
 end
 
 local Jack = game:GetObjects("rbxassetid://135816582968851")[1]
 if JackEnabled then
     Jack.Parent = game.Players.LocalPlayer.Backpack
 end
 
 local Dupe = game:GetObjects("rbxassetid://116858052599982")[1]
 if DupeEnabled then
     Dupe.Parent = game.Players.LocalPlayer.Backpack
 end
    end,
 })
 
 PlushysTab:CreateButton({
    Name = "Guiding Light Plushy",
    Callback = function()
        local plr = game.Players.LocalPlayer
        local hum = plr.Character:WaitForChild("Humanoid")
        
        local plush = game:GetObjects("rbxassetid://86849317933417")[1]
        plush.Parent = plr.Backpack
        local anim = hum:LoadAnimation(plush.A.Hold)
        
        plush.Equipped:Connect(function()
            anim:Play()
        end)
        plush.Unequipped:Connect(function()
            anim:Stop()
        end)
        
        plush.Activated:Connect(function()
            plush.Toy:Play()
        end)
    end,
 })

PlushysTab:CreateButton({
    Name = "Seek Plushy",
    Callback = function()
     local plr = game.Players.LocalPlayer
 local hum = plr.Character:WaitForChild("Humanoid")
 
 local plush = game:GetObjects("rbxassetid://13613269677")[1]
 plush.Parent = plr.Backpack
 local anim = hum:LoadAnimation(plush.A.Hold)
 
 plush.Equipped:Connect(function()
   anim:Play()
 end)
 plush.Unequipped:Connect(function()
   anim:Stop()
 end)
 
 plush.Activated:Connect(function()
   plush.Toy:Play()
 end)
 
    end,
 })
  
PlushysTab:CreateButton({
    Name = "A-60 Plushy",
    Callback = function()
 local Players = game:GetService("Players")
 local UIS = game:GetService("UserInputService")
 local Plr = Players.LocalPlayer
 local Char = Plr.Character or Plr.CharacterAdded:Wait()
 
 local shadow = game:GetObjects("rbxassetid://85674900664881")[1]
 shadow.Parent = game.Players.LocalPlayer.Backpack
 
 UIS.InputBegan:Connect(function(input, gameProcessed)
     if not gameProcessed and input.KeyCode == Enum.KeyCode.Space then
         local plushie = Char:FindFirstChild("A60")
 
         if plushie then
             plushie.Handle.Sound:Stop()
         end
     end
 end)
 
 UIS.InputBegan:Connect(function(input, gameProcessed)
     if not gameProcessed and input.KeyCode == Enum.KeyCode.K then
         local plushie = Char:FindFirstChild("A60")
 
         if plushie then
             plushie.Handle.Sound:Play()
         end
     end
 end)
    end,
 })
  
PlushysTab:CreateButton({
    Name = "A-90 Plushy",
    Callback = function()
 local Players = game:GetService("Players")
 local Equipped = false
 local Plr = Players.LocalPlayer
 local Char = Plr.Character or Plr.CharacterAdded:Wait()
 local Hum = Char:WaitForChild("Humanoid")
 local Root = Char:WaitForChild("HumanoidRootPart")
 local RightArm = Char:WaitForChild("RightUpperArm")
 local LeftArm = Char:WaitForChild("LeftUpperArm")
 local RightC1 = RightArm.RightShoulder.C1
 local LeftC1 = LeftArm.LeftShoulder.C1
 local A90 = game:GetObjects("rbxassetid://12544988486")[1]
 
 A90.Parent = game.Players.LocalPlayer.Backpack
 
 local function setupHands(tool)
     tool.Equipped:Connect(function()
         Equipped = true
         Char:SetAttribute("Hiding", true)
         for _, v in next, Hum:GetPlayingAnimationTracks() do
             v:Stop()
         end
 
         RightArm.Name = "R_Arm"
         LeftArm.Name = "L_Arm"
 
         RightArm.RightShoulder.C1 = RightC1
             * CFrame.Angles(math.rad(-90), math.rad(-10), 0)
         LeftArm.LeftShoulder.C1 = LeftC1
             * CFrame.new(-0.2, 0, -0.5)
             * CFrame.Angles(math.rad(-110), math.rad(15), math.rad(0))
     end)
 
     tool.Unequipped:Connect(function()
         Equipped = false
         Char:SetAttribute("Hiding", nil)
         RightArm.Name = "RightUpperArm"
         LeftArm.Name = "LeftUpperArm"
 
         RightArm.RightShoulder.C1 = RightC1
         LeftArm.LeftShoulder.C1 = LeftC1
     end)
 end
 
 setupHands(A90)
    end,
 })
 
PlushysTab:CreateButton({
    Name = "A-120 Plushy",
    Callback = function()
      local Players = game:GetService("Players")
 local Equipped = false
 local Plr = Players.LocalPlayer
 local Char = Plr.Character or Plr.CharacterAdded:Wait()
 local Hum = Char:WaitForChild("Humanoid")
 local Root = Char:WaitForChild("HumanoidRootPart")
 local RightArm = Char:WaitForChild("RightUpperArm")
 local LeftArm = Char:WaitForChild("LeftUpperArm")
 local RightC1 = RightArm.RightShoulder.C1
 local LeftC1 = LeftArm.LeftShoulder.C1
 local Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))()
 local CustomShop = loadstring(game:HttpGet("https://raw.githubusercontent.com/MateiDaBest/Utilities/main/Doors/Custom%20Shop%20Items/Main.lua"))()
 local A120 = game:GetObjects("rbxassetid://12564739530")[1]
 
 CustomShop.CreateItem({
     Title = "A-120 Plushie",
     Desc = "Balls",
     Image = "https://i.pinimg.com/236x/76/ed/02/76ed02350afbd78b8275743958871368.jpg",
     Price = 69,
     Stack = 1,
 })
 
 A120.Parent = game.Players.LocalPlayer.Backpack
 
 local function setupHands(tool)
     tool.Equipped:Connect(function()
         Equipped = true
         Char:SetAttribute("Hiding", true)
         for _, v in next, Hum:GetPlayingAnimationTracks() do
             v:Stop()
         end
 
         RightArm.Name = "R_Arm"
         LeftArm.Name = "L_Arm"
 
         RightArm.RightShoulder.C1 = RightC1
             * CFrame.Angles(math.rad(-90), math.rad(-10), 0)
         LeftArm.LeftShoulder.C1 = LeftC1
             * CFrame.new(-0.2, 0, -0.5)
             * CFrame.Angles(math.rad(-110), math.rad(15), math.rad(0))
     end)
 
     tool.Unequipped:Connect(function()
         Equipped = false
         Char:SetAttribute("Hiding", nil)
         RightArm.Name = "RightUpperArm"
         LeftArm.Name = "LeftUpperArm"
 
         RightArm.RightShoulder.C1 = RightC1
         LeftArm.LeftShoulder.C1 = LeftC1
     end)
 end
 
 setupHands(A120)
    end,
 })
 
 PlushysTab:CreateButton({
    Name = "Depth Plushy",
    Callback = function()
     local plr = game.Players.LocalPlayer
   local Players = game:GetService("Players")
 local Equipped = false
 local Plr = Players.LocalPlayer
 local Char = Plr.Character or Plr.CharacterAdded:Wait()
 local Hum = Char:WaitForChild("Humanoid")
 local Root = Char:WaitForChild("HumanoidRootPart")
 local RightArm = Char:WaitForChild("RightUpperArm")
 local LeftArm = Char:WaitForChild("LeftUpperArm")
 local RightC1 = RightArm.RightShoulder.C1
 local LeftC1 = LeftArm.LeftShoulder.C1
 local Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))()
 local CustomShop = loadstring(game:HttpGet("https://raw.githubusercontent.com/MateiDaBest/Utilities/main/Doors/Custom%20Shop%20Items/Main.lua"))()
 local Depth = game:GetObjects("rbxassetid://12564733947")[1]
 local Atmosphere = Instance.new("Atmosphere")
 
 Atmosphere.Density = 0.75
 Atmosphere.Parent = game.ReplicatedStorage
 
 CustomShop.CreateItem({
     Title = "Depth Plushy",
     Desc = "Im gonna tickle your balls",
     Image = "rbxassetid://11278229112",
     Price = 69,
     Stack = 1,
 })
 
 Depth.Parent = game.Players.LocalPlayer.Backpack
 
 local function setupHands(tool)
     tool.Equipped:Connect(function()
         Equipped = true
         Char:SetAttribute("Hiding", true)
         for _, v in next, Hum:GetPlayingAnimationTracks() do
             v:Stop()
         end
 
         RightArm.Name = "R_Arm"
         LeftArm.Name = "L_Arm"
 
         RightArm.RightShoulder.C1 = RightC1
             * CFrame.Angles(math.rad(-90), math.rad(-10), 0)
         LeftArm.LeftShoulder.C1 = LeftC1
             * CFrame.new(-0.2, 0.1, -0.5)
             * CFrame.Angles(math.rad(-110), math.rad(15), math.rad(0))
 
         Atmosphere.Parent = game.Lighting
 
         for i, object in pairs(workspace:WaitForChild("CurrentRooms"):GetDescendants()) do
             if object.Name == "Neon" then
                 object.Color = Color3.new(0.333333, 0.666667, 1)
             end
         end
     end)
 
     tool.Unequipped:Connect(function()
         Equipped = false
         Char:SetAttribute("Hiding", nil)
         RightArm.Name = "RightUpperArm"
         LeftArm.Name = "LeftUpperArm"
 
         RightArm.RightShoulder.C1 = RightC1
         LeftArm.LeftShoulder.C1 = LeftC1
 
         Atmosphere.Parent = game.ReplicatedStorage
 
         for i, object in pairs(workspace:WaitForChild("CurrentRooms"):GetDescendants()) do
             if object.Name == "Neon" then
                 object.Color = Color3.new(0.764706, 0.631373, 0.552941)
             end
         end
     end)
 end
 
 setupHands(Depth)
    end,
 })
PlushysTab:CreateButton({
    Name = "Green Blitz Plushy",
    Callback = function()
     --[[
 
 HASTE + DOUBLE BLITZ PLUSHIES
 
 [K] - PLAY SOUNDS
 [SPACE] - STOP SOUNDS
 
 ]]--
 
 local Sounds = true
 
 local HasteEnabled = false
 local BrotherEnabled = true
 local SisterEnabled = false
 
 local SoundKey = Enum.KeyCode.K
 local StopSoundKey = Enum.KeyCode.Space
 
 ---------------------------------------------------------
 
 local Players = game:GetService("Players")
 local UIS = game:GetService("UserInputService")
 local Plr = Players.LocalPlayer
 local Char = Plr.Character or Plr.CharacterAdded:Wait()
 
 local Haste = game:GetObjects("rbxassetid://109374845896295")[1]
 if HasteEnabled then
     Haste.Parent = game.Players.LocalPlayer.Backpack
 end
 
 local Brother = game:GetObjects("rbxassetid://81472152992030")[1]
 if BrotherEnabled then
     Brother.Parent = game.Players.LocalPlayer.Backpack
 end
 
 local Sister = game:GetObjects("rbxassetid://85239321727099")[1]
 if SisterEnabled then
     Sister.Parent = game.Players.LocalPlayer.Backpack
 end
 
 if Sounds then
     Haste.Handle.Sound.SoundId = getsynasset("Sounds/Haste.MP3")
     Brother.Handle.Sound.SoundId = getsynasset("Sounds/Blitz.MP3")
     Sister.Handle.Sound.SoundId = getsynasset("Sounds/Blitz.MP3")
 end
 
 UIS.InputBegan:Connect(function(input, gameProcessed)
     if not gameProcessed and input.KeyCode == StopSoundKey then
         local HastePlushie = Char:FindFirstChild(Haste.Name)
         local BrotherPlushie = Char:FindFirstChild(Brother.Name)
         local SisterPlushie = Char:FindFirstChild(Sister.Name)
         
         if HastePlushie then
             HastePlushie.Handle.Sound:Stop()
         end
         
         if BrotherPlushie then
             BrotherPlushie.Handle.Sound:Stop()
         end
 
         if SisterPlushie then
             SisterPlushie.Handle.Sound:Stop()
         end
     end
 end)
 
 UIS.InputBegan:Connect(function(input, gameProcessed)
     if not gameProcessed and input.KeyCode == SoundKey then
         local HastePlushie = Char:FindFirstChild(Haste.Name)
         local BrotherPlushie = Char:FindFirstChild(Brother.Name)
         local SisterPlushie = Char:FindFirstChild(Sister.Name)
 
         if HastePlushie then
             HastePlushie.Handle.Sound:Play()
         end
 
         if BrotherPlushie then
             BrotherPlushie.Handle.Sound:Play()
         end
 
         if SisterPlushie then
             SisterPlushie.Handle.Sound:Play()
         end
     end
 end)
    end,
 })
 
PlushysTab:CreateButton({
    Name = "Pink Blitz Plushy",
    Callback = function()
     --[[
 
 HASTE + DOUBLE BLITZ PLUSHIES
 
 [K] - PLAY SOUNDS
 [SPACE] - STOP SOUNDS
 
 ]]--
 
 local Sounds = true
 
 local HasteEnabled = false
 local BrotherEnabled = false
 local SisterEnabled = true
 
 local SoundKey = Enum.KeyCode.K
 local StopSoundKey = Enum.KeyCode.Space
 
 ---------------------------------------------------------
 
 local Players = game:GetService("Players")
 local UIS = game:GetService("UserInputService")
 local Plr = Players.LocalPlayer
 local Char = Plr.Character or Plr.CharacterAdded:Wait()
 
 local Haste = game:GetObjects("rbxassetid://109374845896295")[1]
 if HasteEnabled then
     Haste.Parent = game.Players.LocalPlayer.Backpack
 end
 
 local Brother = game:GetObjects("rbxassetid://81472152992030")[1]
 if BrotherEnabled then
     Brother.Parent = game.Players.LocalPlayer.Backpack
 end
 
 local Sister = game:GetObjects("rbxassetid://85239321727099")[1]
 if SisterEnabled then
     Sister.Parent = game.Players.LocalPlayer.Backpack
 end
 
 if Sounds then
     Haste.Handle.Sound.SoundId = getsynasset("Sounds/Haste.MP3")
     Brother.Handle.Sound.SoundId = getsynasset("Sounds/Blitz.MP3")
     Sister.Handle.Sound.SoundId = getsynasset("Sounds/Blitz.MP3")
 end
 
 UIS.InputBegan:Connect(function(input, gameProcessed)
     if not gameProcessed and input.KeyCode == StopSoundKey then
         local HastePlushie = Char:FindFirstChild(Haste.Name)
         local BrotherPlushie = Char:FindFirstChild(Brother.Name)
         local SisterPlushie = Char:FindFirstChild(Sister.Name)
         
         if HastePlushie then
             HastePlushie.Handle.Sound:Stop()
         end
         
         if BrotherPlushie then
             BrotherPlushie.Handle.Sound:Stop()
         end
 
         if SisterPlushie then
             SisterPlushie.Handle.Sound:Stop()
         end
     end
 end)
 
 UIS.InputBegan:Connect(function(input, gameProcessed)
     if not gameProcessed and input.KeyCode == SoundKey then
         local HastePlushie = Char:FindFirstChild(Haste.Name)
         local BrotherPlushie = Char:FindFirstChild(Brother.Name)
         local SisterPlushie = Char:FindFirstChild(Sister.Name)
 
         if HastePlushie then
             HastePlushie.Handle.Sound:Play()
         end
 
         if BrotherPlushie then
             BrotherPlushie.Handle.Sound:Play()
         end
 
         if SisterPlushie then
             SisterPlushie.Handle.Sound:Play()
         end
     end
 end)
    end,
 })
 
PlushysTab:CreateButton({
    Name = "Haste Plushy",
    Callback = function()
     --[[
 
 HASTE + DOUBLE BLITZ PLUSHIES
 
 [K] - PLAY SOUNDS
 [SPACE] - STOP SOUNDS
 
 ]]--
 
 local Sounds = true
 
 local HasteEnabled = true
 local BrotherEnabled = false
 local SisterEnabled = false
 
 local SoundKey = Enum.KeyCode.K
 local StopSoundKey = Enum.KeyCode.Space
 
 ---------------------------------------------------------
 
 local Players = game:GetService("Players")
 local UIS = game:GetService("UserInputService")
 local Plr = Players.LocalPlayer
 local Char = Plr.Character or Plr.CharacterAdded:Wait()
 
 local Haste = game:GetObjects("rbxassetid://109374845896295")[1]
 if HasteEnabled then
     Haste.Parent = game.Players.LocalPlayer.Backpack
 end
 
 local Brother = game:GetObjects("rbxassetid://81472152992030")[1]
 if BrotherEnabled then
     Brother.Parent = game.Players.LocalPlayer.Backpack
 end
 
 local Sister = game:GetObjects("rbxassetid://85239321727099")[1]
 if SisterEnabled then
     Sister.Parent = game.Players.LocalPlayer.Backpack
 end
 
 if Sounds then
     Haste.Handle.Sound.SoundId = getsynasset("Sounds/Haste.MP3")
     Brother.Handle.Sound.SoundId = getsynasset("Sounds/Blitz.MP3")
     Sister.Handle.Sound.SoundId = getsynasset("Sounds/Blitz.MP3")
 end
 
 UIS.InputBegan:Connect(function(input, gameProcessed)
     if not gameProcessed and input.KeyCode == StopSoundKey then
         local HastePlushie = Char:FindFirstChild(Haste.Name)
         local BrotherPlushie = Char:FindFirstChild(Brother.Name)
         local SisterPlushie = Char:FindFirstChild(Sister.Name)
         
         if HastePlushie then
             HastePlushie.Handle.Sound:Stop()
         end
         
         if BrotherPlushie then
             BrotherPlushie.Handle.Sound:Stop()
         end
 
         if SisterPlushie then
             SisterPlushie.Handle.Sound:Stop()
         end
     end
 end)
 
 UIS.InputBegan:Connect(function(input, gameProcessed)
     if not gameProcessed and input.KeyCode == SoundKey then
         local HastePlushie = Char:FindFirstChild(Haste.Name)
         local BrotherPlushie = Char:FindFirstChild(Brother.Name)
         local SisterPlushie = Char:FindFirstChild(Sister.Name)
 
         if HastePlushie then
             HastePlushie.Handle.Sound:Play()
         end
 
         if BrotherPlushie then
             BrotherPlushie.Handle.Sound:Play()
         end
 
         if SisterPlushie then
             SisterPlushie.Handle.Sound:Play()
         end
     end
 end)
    end,
 })
  
PlushysTab:CreateButton({
    Name = "Jeff The Killer Plushy",
    Callback = function()
     local tool = game:GetObjects("rbxassetid://13069619857")[1]
       tool.Parent = game.Players.LocalPlayer.Backpack
    end,
 })

 PlushysTab:CreateButton({
    Name = "Feathered Kiwi Plushy",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/PFERptU5", true))()
    end,
 })

-- PARAGRAPH
ExtraTab:CreateParagraph({
    Title = "Note:",
    Content = "Credits to Kodbol for helping me"
}) 

ExtraTab:CreateButton({
    Name = "Reset",
    Callback = function()
        LocalPlayer.Character:WaitForChild("Humanoid").Health = 0
    end
})

ExtraTab:CreateButton({
    Name = "Play Again",
    Callback = function()
        RemotesFolder.PlayAgain:FireServer()
    end
})

ExtraTab:CreateButton({
    Name = "Return To Lobby",
    Callback = function()
        RemotesFolder.Lobby:FireServer()
    end
})

--======================================================
-- TOOLS
--======================================================

Tools:CreateSection("Developer Tools")

Tools:CreateButton({
    Name = "Infinite Yield",

    Callback = function()
        local Success, Result = pcall(function()
            local Source = game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")
            local Script = loadstring(Source)

            if not Script then
                error("Infinite Yield could not be compiled.")
            end

            Script()
        end)

        Rayfield:Notify({
            Title = Success and "Infinite Yield" or "Infinite Yield Error",
            Content = Success
                and "Loaded successfully."
                or tostring(Result),
            Duration = 5
        })
    end
})

Tools:CreateButton({
    Name = "Dex Explorer ++",

    Callback = function()
        local Success, Result = pcall(function()
            local Source = game:HttpGet("https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua") 
                    
            local Script = loadstring(Source)

            if not Script then
                error("Dex Explorer ++ could not be compiled.")
            end

            Script()
        end)

        Rayfield:Notify({
            Title = Success and "Dex Explorer ++" or "Dex Explorer ++ Error",
            Content = Success
                and "Loaded successfully."
                or tostring(Result),
            Duration = 5
        })
    end
})

Tools:CreateButton({
    Name = "SimpleSpy",

    Callback = function()
        local Success, Result = pcall(function()
            local Source = game:HttpGet("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua")
            local Script = loadstring(Source)

            if not Script then
                error("SimpleSpy could not be compiled.")
            end

            Script()
        end)

        Rayfield:Notify({
            Title = Success and "SimpleSpy" or "SimpleSpy Error",
            Content = Success
                and "Loaded successfully."
                or tostring(Result),
            Duration = 5
        })
    end
})

Tools:CreateButton({
    Name = "RemoteSpy",

    Callback = function()
        local Success, Result = pcall(function()
            local Source = game:HttpGet("https://raw.githubusercontent.com/Klinac/scripts/main/utopia_spy.lua")
            local Script = loadstring(Source)

            if not Script then
                error("RemoteSpy could not be compiled.")
            end

            Script()
        end)

        Rayfield:Notify({
            Title = Success and "RemoteSpy" or "RemoteSpy Error",
            Content = Success
                and "Loaded successfully."
                or tostring(Result),
            Duration = 5
        })
    end
})

Tools:CreateButton({
    Name = "Reset Character",

    Callback = function()

        local Character = GetCharacter()

        local Humanoid = Character
            and Character:FindFirstChildOfClass("Humanoid")

        if Humanoid then
            Humanoid.Health = 0
        end
    end
})

Tools:CreateButton({
    Name = "Rejoin Server",

    Callback = function()

        TeleportService:Teleport(
            game.PlaceId,
            LocalPlayer
        )
    end
})

Tools:CreateButton({
    Name = "Open Developer Console",

    Callback = function()

        pcall(function()
            StarterGui:SetCore(
                "DevConsoleVisible",
                true
            )
        end)
    end
})

--======================================================
-- DEBUG
--======================================================

Tools:CreateSection("Debug")

Tools:CreateToggle({
    Name = "Show Debug Info",
    CurrentValue = false,
    Flag = "DebugInfo",

    Callback = function(Value)
        print("Ikonned UI Debug:", Value)
    end
})
