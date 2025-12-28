
-- ================= SETTINGS =================
local SPEED = 50 -- updated speed
local LOOP = true

local Points = {
    Vector3.new(5741.19, 679.27, -1410.79),
    Vector3.new(5836.14, 679.27, -1301.05),
    Vector3.new(5764.16, 679.27, -1127.30),
    Vector3.new(5607.96, 683.27, -1274.60),
    Vector3.new(5672.91, 679.75, -1412.85),
    Vector3.new(5589.60, 679.27, -1433.03),
    Vector3.new(5625.64, 679.75, -1593.40),
    Vector3.new(5575.72, 679.68, -1343.09),
    Vector3.new(5479.03, 679.52, -1369.48),
    Vector3.new(5713.01, 618.44, -1516.24)
}

-- ================= SERVICES =================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local running = false
local dragging = false
local dragOffset = Vector2.new()
local guiVisible = true

-- ================= CHARACTER =================
local function getRoot()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart")
end

-- ================= TWEENING FUNCTION =================
local function startTweening()
    if running then return end
    running = true
    task.spawn(function()
        local i = 1
        while running do
            local current = Points[i]
            local nextIndex = i + 1
            if nextIndex > #Points then
                nextIndex = 1 -- loop back to first point
            end
            local nextPoint = Points[nextIndex]
            
            local root = getRoot()
            local dist = (root.Position - nextPoint).Magnitude
            local time = dist / SPEED
            local tween = TweenService:Create(
                root,
                TweenInfo.new(time, Enum.EasingStyle.Linear),
                {CFrame = CFrame.new(nextPoint)}
            )
            tween:Play()
            tween.Completed:Wait()
            
            i = nextIndex
            task.wait(0.05)
        end
    end)
end

local function stopTweening()
    running = false
end

-- ================= DRAWING GUI =================
local cam = workspace.CurrentCamera
local size = Vector2.new(400, 180)
local pos = Vector2.new(cam.ViewportSize.X/2 - size.X/2, cam.ViewportSize.Y/2 - size.Y/2)

local box = Drawing.new("Square")
box.Size = size
box.Position = pos
box.Filled = true
box.Color = Color3.fromRGB(30,30,30)
box.Visible = true

local title = Drawing.new("Text")
title.Text = "Jay's Auto Farm OABD"
title.Size = 24
title.Center = true
title.Position = pos + Vector2.new(size.X/2,30)
title.Color = Color3.new(1,1,1)
title.Visible = true

local status = Drawing.new("Text")
status.Text = "Status: OFF"
status.Size = 20
status.Center = true
status.Position = pos + Vector2.new(size.X/2,80)
status.Color = Color3.fromRGB(255,0,0)
status.Visible = true

local info = Drawing.new("Text")
info.Text = "] = Start    [ = Stop    F = Hide/Show"
info.Size = 18
info.Center = true
info.Position = pos + Vector2.new(size.X/2,120)
info.Color = Color3.fromRGB(200,200,200)
info.Visible = true

local closeBtn = Drawing.new("Text")
closeBtn.Text = "X"
closeBtn.Size = 18
closeBtn.Center = true
closeBtn.Position = pos + Vector2.new(size.X-15,15)
closeBtn.Color = Color3.fromRGB(255,0,0)
closeBtn.Visible = true

-- ================= MOUSE & DRAGGING =================
local mouse = player:GetMouse()

mouse.Button1Down:Connect(function()
    local m = Vector2.new(mouse.X, mouse.Y)

    -- DRAG AREA: top 50px
    if guiVisible and m.X >= pos.X and m.X <= pos.X + size.X and m.Y >= pos.Y and m.Y <= pos.Y + 50 then
        dragging = true
        dragOffset = m - pos
    end

    -- CLOSE BUTTON
    local closeX1 = pos.X + size.X - 30
    local closeY1 = pos.Y
    local closeX2 = pos.X + size.X
    local closeY2 = pos.Y + 30
    if guiVisible and m.X >= closeX1 and m.X <= closeX2 and m.Y >= closeY1 and m.Y <= closeY2 then
        box:Remove()
        title:Remove()
        status:Remove()
        info:Remove()
        closeBtn:Remove()
        guiVisible = false
    end
end)

mouse.Button1Up:Connect(function()
    dragging = false
end)

RunService.RenderStepped:Connect(function()
    if dragging and guiVisible then
        local m = Vector2.new(mouse.X, mouse.Y)
        pos = m - dragOffset
    end

    if guiVisible then
        box.Position = pos
        title.Position = pos + Vector2.new(size.X/2,30)
        status.Position = pos + Vector2.new(size.X/2,80)
        info.Position = pos + Vector2.new(size.X/2,120)
        closeBtn.Position = pos + Vector2.new(size.X-15,15)
    end
end)

-- ================= KEYBIND TOGGLE =================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard then
        local key = input.KeyCode
        if key == Enum.KeyCode.RightBracket then
            startTweening()
            status.Text = "Status: ON"
            status.Color = Color3.fromRGB(0,255,0)
        elseif key == Enum.KeyCode.LeftBracket then
            stopTweening()
            status.Text = "Status: OFF"
            status.Color = Color3.fromRGB(255,0,0)
        elseif key == Enum.KeyCode.F then
            guiVisible = not guiVisible
            box.Visible = guiVisible
            title.Visible = guiVisible
            status.Visible = guiVisible
            info.Visible = guiVisible
            closeBtn.Visible = guiVisible
        end
    end
end)

print("DRAGGABLE TWEEN GUI LOADED | ] = Start, [ = Stop, F = Hide/Show, X = Close")
