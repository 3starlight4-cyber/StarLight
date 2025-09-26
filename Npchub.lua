local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local mouse = player:GetMouse()
local function safePcall(f,...) local ok,err = pcall(f,...) if not ok then end end
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NPCHub"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 999
screenGui.Parent = playerGui
local WINDOW_W, WINDOW_H = 180, 230
local TITLE_H = 36
local window = Instance.new("Frame")
window.Name = "Window"
window.Size = UDim2.new(0, WINDOW_W, 0, WINDOW_H)
window.Position = UDim2.new(0.5, -WINDOW_W/2, 0.5, -WINDOW_H/2)
window.AnchorPoint = Vector2.new(0.5, 0.5)
window.BackgroundColor3 = Color3.fromRGB(22,22,22)
window.BorderSizePixel = 0
window.Parent = screenGui
local windowCorner = Instance.new("UICorner", window)
windowCorner.CornerRadius = UDim.new(0, 12)
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, TITLE_H)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundTransparency = 1
titleBar.Parent = window
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -80, 1, 0)
titleLabel.Position = UDim2.new(0, 12, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Npc Hub"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 15
titleLabel.TextColor3 = Color3.fromRGB(240,240,240)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -32, 0.5, -14)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "×"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.TextColor3 = Color3.fromRGB(230,230,230)
closeBtn.Parent = titleBar
closeBtn.AutoButtonColor = true
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 28, 0, 28)
minimizeBtn.Position = UDim2.new(1, -64, 0.5, -14)
minimizeBtn.BackgroundTransparency = 1
minimizeBtn.Text = "−"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 20
minimizeBtn.TextColor3 = Color3.fromRGB(200,200,200)
minimizeBtn.Parent = titleBar
minimizeBtn.AutoButtonColor = true
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -12, 1, -TITLE_H - 12)
contentFrame.Position = UDim2.new(0, 6, 0, TITLE_H + 6)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = window
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, 0, 1, 0)
scroll.Position = UDim2.new(0, 0, 0, 0)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 6
scroll.Parent = contentFrame
local uiList = Instance.new("UIListLayout", scroll)
uiList.Padding = UDim.new(0, 8)
uiList.SortOrder = Enum.SortOrder.LayoutOrder
uiList.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiList.VerticalAlignment = Enum.VerticalAlignment.Top
uiList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() scroll.CanvasSize = UDim2.new(0,0,0, uiList.AbsoluteContentSize.Y + 12) end)
local miniFrame = Instance.new("Frame")
miniFrame.Size = UDim2.new(0,160,0,36)
miniFrame.Position = UDim2.new(0.5, -80, 0, 12)
miniFrame.BackgroundColor3 = Color3.fromRGB(22,22,22)
miniFrame.BorderSizePixel = 0
miniFrame.Parent = screenGui
local miniCorner = Instance.new("UICorner", miniFrame)
miniCorner.CornerRadius = UDim.new(0,12)
miniFrame.Visible = false
local miniLabel = Instance.new("TextButton")
miniLabel.Size = UDim2.new(0.7,0,1,0)
miniLabel.Position = UDim2.new(0,8,0,0)
miniLabel.BackgroundTransparency = 1
miniLabel.Text = "Npc Hub"
miniLabel.Font = Enum.Font.GothamBold
miniLabel.TextSize = 13
miniLabel.TextColor3 = Color3.fromRGB(240,240,240)
miniLabel.TextXAlignment = Enum.TextXAlignment.Left
miniLabel.Parent = miniFrame
miniLabel.AutoButtonColor = false
local sep = Instance.new("Frame")
sep.Size = UDim2.new(0,1,0.6,0)
sep.Position = UDim2.new(0.72,0,0.2,0)
sep.BackgroundColor3 = Color3.fromRGB(120,120,120)
sep.BorderSizePixel = 0
sep.Parent = miniFrame
local dragBtn = Instance.new("TextButton")
dragBtn.Size = UDim2.new(0,26,0,26)
dragBtn.Position = UDim2.new(1,-34,0.5,-13)
dragBtn.BackgroundTransparency = 1
dragBtn.Text = "¤"
dragBtn.Font = Enum.Font.Gotham
dragBtn.TextSize = 16
dragBtn.TextColor3 = Color3.fromRGB(220,220,220)
dragBtn.Parent = miniFrame
dragBtn.AutoButtonColor = true
local function createButton(text,order,callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.94,0,0,32)
    btn.LayoutOrder = order or 1
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.TextColor3 = Color3.fromRGB(245,245,245)
    btn.Parent = scroll
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0,8)
    btn.MouseButton1Click:Connect(function() safePcall(callback) end)
    return btn
end
local function createToggle(text,order,onChanged)
    local root = Instance.new("Frame")
    root.Size = UDim2.new(0.94,0,0,32)
    root.LayoutOrder = order or 1
    root.BackgroundTransparency = 1
    root.Parent = scroll
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1,0,1,0)
    bg.BackgroundColor3 = Color3.fromRGB(40,40,40)
    bg.BorderSizePixel = 0
    bg.Parent = root
    local corner = Instance.new("UICorner", bg)
    corner.CornerRadius = UDim.new(0,8)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.68,0,1,0)
    lbl.Position = UDim2.new(0,10,0,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 13
    lbl.TextColor3 = Color3.fromRGB(240,240,240)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = bg
    local toggle = Instance.new("ImageButton")
    toggle.Size = UDim2.new(0,48,0,26)
    toggle.Position = UDim2.new(1,-58,0.5,-13)
    toggle.BackgroundColor3 = Color3.fromRGB(120,120,120)
    toggle.BorderSizePixel = 0
    toggle.Parent = bg
    local tcorner = Instance.new("UICorner", toggle)
    tcorner.CornerRadius = UDim.new(1,0)
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0.44,0,0.86,0)
    knob.Position = UDim2.new(0.05,0,0.07,0)
    knob.BackgroundColor3 = Color3.fromRGB(250,250,250)
    knob.Parent = toggle
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)
    local state = false
    local function setVisual(v)
        state = not not v
        if state then
            toggle.BackgroundColor3 = Color3.fromRGB(0,200,0)
            knob:TweenPosition(UDim2.new(0.51,0,0.07,0),"Out","Quad",0.16,true)
        else
            toggle.BackgroundColor3 = Color3.fromRGB(120,120,120)
            knob:TweenPosition(UDim2.new(0.05,0,0.07,0),"Out","Quad",0.16,true)
        end
    end
    toggle.MouseButton1Click:Connect(function()
        state = not state
        setVisual(state)
        safePcall(function() onChanged(state) end)
    end)
    return setVisual, function() return state end
end
local function notify(text)
    safePcall(function()
        local notif = Instance.new("Frame")
        notif.Size = UDim2.new(0, 300, 0, 48)
        notif.Position = UDim2.new(1, 40, 1, -80)
        notif.BackgroundColor3 = Color3.fromRGB(30,30,30)
        notif.BorderSizePixel = 0
        notif.Parent = screenGui
        Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 12)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -24, 1, 0)
        label.Position = UDim2.new(0, 12, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.TextColor3 = Color3.fromRGB(240,240,240)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = notif
        local tIn = TweenService:Create(notif, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, -320, 1, -80)})
        tIn:Play(); tIn.Completed:Wait()
        task.wait(2)
        local tOut = TweenService:Create(notif, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 40, 1, -80)})
        tOut:Play(); tOut.Completed:Wait()
        notif:Destroy()
    end)
end
local function getNPCs()
    local out = {}
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Model") then
            local hum = v:FindFirstChildOfClass("Humanoid")
            if hum and not Players:GetPlayerFromCharacter(v) then
                table.insert(out, v)
            end
        end
    end
    return out
end
local controllingEnabled = false
local followingEnabled = false
local controlledNPC = nil
local followMin, followMax = 2, 4
local controlSetter, controlGetter = createToggle("Control NPC (tap NPC)", 1, function(state)
    controllingEnabled = state
    if not state then
        controlledNPC = nil
        notify("Control NPC disabled - Bugs May Occur")
    else
        notify("Control NPC enabled — Beta")
    end
end)
local followSetter, followGetter = createToggle("Follow NPCs (nearby)", 2, function(state)
    followingEnabled = state
    if state then notify("Follow NPCs enabled") else notify("Follow NPCs disabled") end
end)
createButton("Kill NPCs", 3, function()
    for _, npc in ipairs(getNPCs()) do
        local hum = npc:FindFirstChildOfClass("Humanoid")
        if hum then hum.Health = 0 end
    end
    notify("Killed all NPCs")
end)
createButton("Fling NPCs", 4, function()
    for _, npc in ipairs(getNPCs()) do
        local hum = npc:FindFirstChildOfClass("Humanoid")
        if hum then hum.HipHeight = 1024 end
    end
    notify("Flinged all NPCs")
end)
createButton("Void NPCs", 5, function()
    for _, npc in ipairs(getNPCs()) do
        local hum = npc:FindFirstChildOfClass("Humanoid")
        if hum then hum.HipHeight = -1024 end
    end
    notify("Voided all NPCs")
end)
createButton("Bring NPCs", 6, function()
    local char = player.Character
    local rootPart = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso"))
    if rootPart then
        for _, npc in ipairs(getNPCs()) do
            local rp = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChild("Torso")
            if rp then rp.CFrame = rootPart.CFrame end
        end
        notify("Brought all NPCs to you")
    else
        notify("Could not find your root part – thats means close the script")
    end
end)
mouse.Button1Down:Connect(function()
    if not controllingEnabled then return end
    local target = mouse.Target
    if not target then return end
    local model = target:FindFirstAncestorOfClass("Model")
    if not model then return end
    local hum = model:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if Players:GetPlayerFromCharacter(model) then return end
    controlledNPC = model
    notify("Controlling: "..(model.Name or "NPC"))
end)
RunService.Heartbeat:Connect(function()
    local char = player.Character
    local playerRoot = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso"))
    if controllingEnabled and controlledNPC and controlledNPC.Parent then
        local hum = controlledNPC:FindFirstChildOfClass("Humanoid")
        local rp = controlledNPC:FindFirstChild("HumanoidRootPart") or controlledNPC:FindFirstChild("Torso")
        if hum and rp then
            local targetPos = (mouse and mouse.Hit and mouse.Hit.p) or rp.Position
            hum:MoveTo(targetPos)
            local pHum = char and char:FindFirstChildOfClass("Humanoid")
            if pHum and hum and pHum.WalkSpeed and typeof(hum.WalkSpeed) == "number" then
                safePcall(function() hum.WalkSpeed = pHum.WalkSpeed end)
            end
            for _, part in ipairs(controlledNPC:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        else
            controlledNPC = nil
        end
    end
    if followingEnabled and playerRoot then
        for _, npc in ipairs(getNPCs()) do
            local hum = npc:FindFirstChildOfClass("Humanoid")
            local rp = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChild("Torso")
            if hum and rp then
                local angle = math.random() * math.pi * 2
                local radius = followMin + math.random() * (followMax - followMin)
                local offset = Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)
                local dest = Vector3.new(playerRoot.Position.X + offset.X, playerRoot.Position.Y, playerRoot.Position.Z + offset.Z)
                if (rp.Position - dest).Magnitude > 1.2 then hum:MoveTo(dest) end
            end
        end
    end
end)
local function disableAll()
    controllingEnabled = false
    followingEnabled = false
    controlledNPC = nil
    safePcall(function() controlSetter(false) end)
    safePcall(function() followSetter(false) end)
    notify("Death detected — turning off all settings")
end
local function onCharacterAdded(char)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum.Died:Connect(function() disableAll() end) end
    controlledNPC = nil
end
if player.Character then onCharacterAdded(player.Character) end
player.CharacterAdded:Connect(onCharacterAdded)
local dragging = false
local dragTarget = nil
local dragStart = nil
local frameStart = nil
local function beginDrag(frame, input)
    dragging = true
    dragTarget = frame
    dragStart = input.Position
    frameStart = frame.Position
    local conn
    conn = UserInputService.InputChanged:Connect(function(inp)
        if not dragging then conn:Disconnect() return end
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
            local delta = inp.Position - dragStart
            local newX = frameStart.X.Offset + delta.X
            local newY = frameStart.Y.Offset + delta.Y
            frame.Position = UDim2.new(frameStart.X.Scale, newX, frameStart.Y.Scale, newY)
        end
    end)
    input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then dragging = false dragTarget = nil conn:Disconnect() end
    end)
end
titleBar.InputBegan:Connect(function(input)
    if miniFrame.Visible then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then beginDrag(window, input) end
end)
dragBtn.InputBegan:Connect(function(input)
    if not miniFrame.Visible and not window.Visible then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then beginDrag(miniFrame, input) end
end)

local minimized = false

minimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    
    window.Visible = not minimized
    miniFrame.Visible = minimized
    
    if minimized then
        minimizeBtn.Text = "+"
    else
        minimizeBtn.Text = "−"
    end
end)

miniLabel.MouseButton1Click:Connect(function()
    minimized = not minimized
    
    window.Visible = not minimized
    miniFrame.Visible = minimized
    
    if minimized then
        minimizeBtn.Text = "+"
    else
        minimizeBtn.Text = "−"
    end
end)

closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)
controlSetter(false)
followSetter(false)
local introTween = TweenService:Create(window, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(window.Position.X.Scale, window.Position.X.Offset, window.Position.Y.Scale, window.Position.Y.Offset - 8)})
introTween:Play()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local mouse = player:GetMouse()
local function safePcall(f,...) local ok,err = pcall(f,...) if not ok then end end
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NPCHub"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 999
screenGui.Parent = playerGui
local WINDOW_W, WINDOW_H = 180, 230
local TITLE_H = 36
local window = Instance.new("Frame")
window.Name = "Window"
window.Size = UDim2.new(0, WINDOW_W, 0, WINDOW_H)
window.Position = UDim2.new(0.5, -WINDOW_W/2, 0.5, -WINDOW_H/2)
window.AnchorPoint = Vector2.new(0.5, 0.5)
window.BackgroundColor3 = Color3.fromRGB(22,22,22)
window.BorderSizePixel = 0
window.Parent = screenGui
local windowCorner = Instance.new("UICorner", window)
windowCorner.CornerRadius = UDim.new(0, 12)
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, TITLE_H)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundTransparency = 1
titleBar.Parent = window
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -80, 1, 0)
titleLabel.Position = UDim2.new(0, 12, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Npc Hub"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 15
titleLabel.TextColor3 = Color3.fromRGB(240,240,240)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -32, 0.5, -14)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "×"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.TextColor3 = Color3.fromRGB(230,230,230)
closeBtn.Parent = titleBar
closeBtn.AutoButtonColor = true
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 28, 0, 28)
minimizeBtn.Position = UDim2.new(1, -64, 0.5, -14)
minimizeBtn.BackgroundTransparency = 1
minimizeBtn.Text = "−"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 20
minimizeBtn.TextColor3 = Color3.fromRGB(200,200,200)
minimizeBtn.Parent = titleBar
minimizeBtn.AutoButtonColor = true
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -12, 1, -TITLE_H - 12)
contentFrame.Position = UDim2.new(0, 6, 0, TITLE_H + 6)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = window
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, 0, 1, 0)
scroll.Position = UDim2.new(0, 0, 0, 0)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 6
scroll.Parent = contentFrame
local uiList = Instance.new("UIListLayout", scroll)
uiList.Padding = UDim.new(0, 8)
uiList.SortOrder = Enum.SortOrder.LayoutOrder
uiList.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiList.VerticalAlignment = Enum.VerticalAlignment.Top
uiList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() scroll.CanvasSize = UDim2.new(0,0,0, uiList.AbsoluteContentSize.Y + 12) end)
local miniFrame = Instance.new("Frame")
miniFrame.Size = UDim2.new(0,160,0,36)
miniFrame.Position = UDim2.new(0.5, -80, 0, 12)
miniFrame.BackgroundColor3 = Color3.fromRGB(22,22,22)
miniFrame.BorderSizePixel = 0
miniFrame.Parent = screenGui
local miniCorner = Instance.new("UICorner", miniFrame)
miniCorner.CornerRadius = UDim.new(0,12)
miniFrame.Visible = false
local miniLabel = Instance.new("TextButton")
miniLabel.Size = UDim2.new(0.7,0,1,0)
miniLabel.Position = UDim2.new(0,8,0,0)
miniLabel.BackgroundTransparency = 1
miniLabel.Text = "Npc Hub"
miniLabel.Font = Enum.Font.GothamBold
miniLabel.TextSize = 13
miniLabel.TextColor3 = Color3.fromRGB(240,240,240)
miniLabel.TextXAlignment = Enum.TextXAlignment.Left
miniLabel.Parent = miniFrame
miniLabel.AutoButtonColor = false
local sep = Instance.new("Frame")
sep.Size = UDim2.new(0,1,0.6,0)
sep.Position = UDim2.new(0.72,0,0.2,0)
sep.BackgroundColor3 = Color3.fromRGB(120,120,120)
sep.BorderSizePixel = 0
sep.Parent = miniFrame
local dragBtn = Instance.new("TextButton")
dragBtn.Size = UDim2.new(0,26,0,26)
dragBtn.Position = UDim2.new(1,-34,0.5,-13)
dragBtn.BackgroundTransparency = 1
dragBtn.Text = "¤"
dragBtn.Font = Enum.Font.Gotham
dragBtn.TextSize = 16
dragBtn.TextColor3 = Color3.fromRGB(220,220,220)
dragBtn.Parent = miniFrame
dragBtn.AutoButtonColor = true
local function createButton(text,order,callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.94,0,0,32)
    btn.LayoutOrder = order or 1
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.TextColor3 = Color3.fromRGB(245,245,245)
    btn.Parent = scroll
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0,8)
    btn.MouseButton1Click:Connect(function() safePcall(callback) end)
    return btn
end
local function createToggle(text,order,onChanged)
    local root = Instance.new("Frame")
    root.Size = UDim2.new(0.94,0,0,32)
    root.LayoutOrder = order or 1
    root.BackgroundTransparency = 1
    root.Parent = scroll
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1,0,1,0)
    bg.BackgroundColor3 = Color3.fromRGB(40,40,40)
    bg.BorderSizePixel = 0
    bg.Parent = root
    local corner = Instance.new("UICorner", bg)
    corner.CornerRadius = UDim.new(0,8)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.68,0,1,0)
    lbl.Position = UDim2.new(0,10,0,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 13
    lbl.TextColor3 = Color3.fromRGB(240,240,240)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = bg
    local toggle = Instance.new("ImageButton")
    toggle.Size = UDim2.new(0,48,0,26)
    toggle.Position = UDim2.new(1,-58,0.5,-13)
    toggle.BackgroundColor3 = Color3.fromRGB(120,120,120)
    toggle.BorderSizePixel = 0
    toggle.Parent = bg
    local tcorner = Instance.new("UICorner", toggle)
    tcorner.CornerRadius = UDim.new(1,0)
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0.44,0,0.86,0)
    knob.Position = UDim2.new(0.05,0,0.07,0)
    knob.BackgroundColor3 = Color3.fromRGB(250,250,250)
    knob.Parent = toggle
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)
    local state = false
    local function setVisual(v)
        state = not not v
        if state then
            toggle.BackgroundColor3 = Color3.fromRGB(0,200,0)
            knob:TweenPosition(UDim2.new(0.51,0,0.07,0),"Out","Quad",0.16,true)
        else
            toggle.BackgroundColor3 = Color3.fromRGB(120,120,120)
            knob:TweenPosition(UDim2.new(0.05,0,0.07,0),"Out","Quad",0.16,true)
        end
    end
    toggle.MouseButton1Click:Connect(function()
        state = not state
        setVisual(state)
        safePcall(function() onChanged(state) end)
    end)
    return setVisual, function() return state end
end
local function notify(text)
    safePcall(function()
        local notif = Instance.new("Frame")
        notif.Size = UDim2.new(0, 300, 0, 48)
        notif.Position = UDim2.new(1, 40, 1, -80)
        notif.BackgroundColor3 = Color3.fromRGB(30,30,30)
        notif.BorderSizePixel = 0
        notif.Parent = screenGui
        Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 12)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -24, 1, 0)
        label.Position = UDim2.new(0, 12, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.TextColor3 = Color3.fromRGB(240,240,240)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = notif
        local tIn = TweenService:Create(notif, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, -320, 1, -80)})
        tIn:Play(); tIn.Completed:Wait()
        task.wait(2)
        local tOut = TweenService:Create(notif, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 40, 1, -80)})
        tOut:Play(); tOut.Completed:Wait()
        notif:Destroy()
    end)
end
local function getNPCs()
    local out = {}
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Model") then
            local hum = v:FindFirstChildOfClass("Humanoid")
            if hum and not Players:GetPlayerFromCharacter(v) then
                table.insert(out, v)
            end
        end
    end
    return out
end
local controllingEnabled = false
local followingEnabled = false
local controlledNPC = nil
local followMin, followMax = 2, 4
local controlSetter, controlGetter = createToggle("Control NPC (tap NPC)", 1, function(state)
    controllingEnabled = state
    if not state then
        controlledNPC = nil
        notify("Control NPC disabled - Bugs May Occur")
    else
        notify("Control NPC enabled — Beta")
    end
end)
local followSetter, followGetter = createToggle("Follow NPCs (nearby)", 2, function(state)
    followingEnabled = state
    if state then notify("Follow NPCs enabled") else notify("Follow NPCs disabled") end
end)
createButton("Kill NPCs", 3, function()
    for _, npc in ipairs(getNPCs()) do
        local hum = npc:FindFirstChildOfClass("Humanoid")
        if hum then hum.Health = 0 end
    end
    notify("Killed all NPCs")
end)
createButton("Fling NPCs", 4, function()
    for _, npc in ipairs(getNPCs()) do
        local hum = npc:FindFirstChildOfClass("Humanoid")
        if hum then hum.HipHeight = 1024 end
    end
    notify("Flinged all NPCs")
end)
createButton("Void NPCs", 5, function()
    for _, npc in ipairs(getNPCs()) do
        local hum = npc:FindFirstChildOfClass("Humanoid")
        if hum then hum.HipHeight = -1024 end
    end
    notify("Voided all NPCs")
end)
createButton("Bring NPCs", 6, function()
    local char = player.Character
    local rootPart = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso"))
    if rootPart then
        for _, npc in ipairs(getNPCs()) do
            local rp = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChild("Torso")
            if rp then rp.CFrame = rootPart.CFrame end
        end
        notify("Brought all NPCs to you")
    else
        notify("Could not find your root part – thats means close the script")
    end
end)
mouse.Button1Down:Connect(function()
    if not controllingEnabled then return end
    local target = mouse.Target
    if not target then return end
    local model = target:FindFirstAncestorOfClass("Model")
    if not model then return end
    local hum = model:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if Players:GetPlayerFromCharacter(model) then return end
    controlledNPC = model
    notify("Controlling: "..(model.Name or "NPC"))
end)
RunService.Heartbeat:Connect(function()
    local char = player.Character
    local playerRoot = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso"))
    if controllingEnabled and controlledNPC and controlledNPC.Parent then
        local hum = controlledNPC:FindFirstChildOfClass("Humanoid")
        local rp = controlledNPC:FindFirstChild("HumanoidRootPart") or controlledNPC:FindFirstChild("Torso")
        if hum and rp then
            local targetPos = (mouse and mouse.Hit and mouse.Hit.p) or rp.Position
            hum:MoveTo(targetPos)
            local pHum = char and char:FindFirstChildOfClass("Humanoid")
            if pHum and hum and pHum.WalkSpeed and typeof(hum.WalkSpeed) == "number" then
                safePcall(function() hum.WalkSpeed = pHum.WalkSpeed end)
            end
            for _, part in ipairs(controlledNPC:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        else
            controlledNPC = nil
        end
    end
    if followingEnabled and playerRoot then
        for _, npc in ipairs(getNPCs()) do
            local hum = npc:FindFirstChildOfClass("Humanoid")
            local rp = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChild("Torso")
            if hum and rp then
                local angle = math.random() * math.pi * 2
                local radius = followMin + math.random() * (followMax - followMin)
                local offset = Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)
                local dest = Vector3.new(playerRoot.Position.X + offset.X, playerRoot.Position.Y, playerRoot.Position.Z + offset.Z)
                if (rp.Position - dest).Magnitude > 1.2 then hum:MoveTo(dest) end
            end
        end
    end
end)
local function disableAll()
    controllingEnabled = false
    followingEnabled = false
    controlledNPC = nil
    safePcall(function() controlSetter(false) end)
    safePcall(function() followSetter(false) end)
    notify("Death detected — turning off all settings")
end
local function onCharacterAdded(char)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum.Died:Connect(function() disableAll() end) end
    controlledNPC = nil
end
if player.Character then onCharacterAdded(player.Character) end
player.CharacterAdded:Connect(onCharacterAdded)
local dragging = false
local dragTarget = nil
local dragStart = nil
local frameStart = nil
local function beginDrag(frame, input)
    dragging = true
    dragTarget = frame
    dragStart = input.Position
    frameStart = frame.Position
    local conn
    conn = UserInputService.InputChanged:Connect(function(inp)
        if not dragging then conn:Disconnect() return end
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
            local delta = inp.Position - dragStart
            local newX = frameStart.X.Offset + delta.X
            local newY = frameStart.Y.Offset + delta.Y
            frame.Position = UDim2.new(frameStart.X.Scale, newX, frameStart.Y.Scale, newY)
        end
    end)
    input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then dragging = false dragTarget = nil conn:Disconnect() end
    end)
end
titleBar.InputBegan:Connect(function(input)
    if miniFrame.Visible then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then beginDrag(window, input) end
end)
dragBtn.InputBegan:Connect(function(input)
    if not miniFrame.Visible and not window.Visible then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then beginDrag(miniFrame, input) end
end)

local minimized = false

minimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    
    window.Visible = not minimized
    miniFrame.Visible = minimized
    
    if minimized then
        minimizeBtn.Text = "+"
    else
        minimizeBtn.Text = "−"
    end
end)

miniLabel.MouseButton1Click:Connect(function()
    minimized = not minimized
    
    window.Visible = not minimized
    miniFrame.Visible = minimized
    
    if minimized then
        minimizeBtn.Text = "+"
    else
        minimizeBtn.Text = "−"
    end
end)

closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)
controlSetter(false)
followSetter(false)
local introTween = TweenService:Create(window, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(window.Position.X.Scale, window.Position.X.Offset, window.Position.Y.Scale, window.Position.Y.Offset - 8)})
introTween:Play()
