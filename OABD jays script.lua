-- ================= SERVICES =================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

-- ================= SETTINGS =================
local SPEED = 67 -- Auto Farm speed
local running = false
local afkTime = 0
local guiVisible = true
local dragging = false
local dragOffset = Vector2.new()

-- ================= AUTO FARM COORDINATES =================
local Points = {
    Vector3.new(5835.4619140625, 679.2723388671875, -1301.5216064453125),
    Vector3.new(5764.2490234375, 679.2723388671875, -1126.8243408203125),
    Vector3.new(5631.462890625, 740.5225219726562, -1068.5355224609375),
    Vector3.new(5543.90869140625, 727.2730102539062, -1227.1522216796875),
    Vector3.new(5441.43359375, 727.2730102539062, -1226.5018310546875),
    Vector3.new(5607.701171875, 683.2730102539062, -1274.1214599609375),
    Vector3.new(5575.95947265625, 679.6836547851562, -1342.7491455078125),
    Vector3.new(5487.3642578125, 679.5223388671875, -1363.302978515625),
    Vector3.new(5589.71044921875, 679.2730102539062, -1433.4471435546875),
    Vector3.new(5526.98095703125, 679.7490844726562, -1553.5762939453125),
    Vector3.new(5421.376953125, 679.7490844726562, -1556.590087890625),
    Vector3.new(5448.40087890625, 643.6984252929688, -1570.15283203125),
    Vector3.new(5556.27001953125, 679.2723388671875, -1578.986328125),
    Vector3.new(5469.333984375, 679.7490844726562, -1635.415771484375),
    Vector3.new(5626.005859375, 679.7490844726562, -1593.24365234375),
    Vector3.new(5617.30712890625, 679.7490844726562, -1561.203369140625),
    Vector3.new(5673.724609375, 679.7490844726562, -1412.671875),
    Vector3.new(5668.92578125, 679.7490844726562, -1398.653564453125),
    Vector3.new(5741.90869140625, 679.2723388671875, -1410.342041015625),
    Vector3.new(5856.560546875, 684.7222900390625, -1506.0340576171875)
}

-- ================= FUNCTIONS =================
local function startTweening()
    if running then return end
    running = true
    -- ENABLE NOCLIP
    RunService.Stepped:Connect(function()
        if running then
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
    task.spawn(function()
        local i = 1
        while running do
            local nextIndex = i + 1
            if nextIndex > #Points then
                nextIndex = 1
            end
            local nextPoint = Points[nextIndex]
            local dist = (root.Position - nextPoint).Magnitude
            local time = dist / SPEED
            local tween = TweenService:Create(root, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = CFrame.new(nextPoint)})
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

-- ================= ANTI AFK =================
player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- ================= GUI =================
local cam = workspace.CurrentCamera
local size = Vector2.new(400, 200)
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

local afkLabel = Drawing.new("Text")
afkLabel.Text = "AFK TIME: 0s"
afkLabel.Size = 18
afkLabel.Center = true
afkLabel.Position = pos + Vector2.new(size.X/2,120)
afkLabel.Color = Color3.fromRGB(200,200,200)
afkLabel.Visible = true

local info = Drawing.new("Text")
info.Text = "] = Start    [ = Stop    F = Hide/Show"
info.Size = 18
info.Center = true
info.Position = pos + Vector2.new(size.X/2,150)
info.Color = Color3.fromRGB(200,200,200)
info.Visible = true

local closeBtn = Drawing.new("Text")
closeBtn.Text = "X"
closeBtn.Size = 18
closeBtn.Center = true
closeBtn.Position = pos + Vector2.new(size.X-15,15)
closeBtn.Color = Color3.fromRGB(255,0,0)
closeBtn.Visible = true

-- ================= DRAGGING =================
local mouse = player:GetMouse()
mouse.Button1Down:Connect(function()
    local m = Vector2.new(mouse.X, mouse.Y)
    if guiVisible and m.X >= pos.X and m.X <= pos.X + size.X and m.Y >= pos.Y and m.Y <= pos.Y + 50 then
        dragging = true
        dragOffset = m - pos
    end
    local closeX1 = pos.X + size.X - 30
    local closeY1 = pos.Y
    local closeX2 = pos.X + size.X
    local closeY2 = pos.Y + 30
    if guiVisible and m.X >= closeX1 and m.X <= closeX2 and m.Y >= closeY1 and m.Y <= closeY2 then
        box:Remove()
        title:Remove()
        status:Remove()
        info:Remove()
        afkLabel:Remove()
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
        afkLabel.Position = pos + Vector2.new(size.X/2,120)
        info.Position = pos + Vector2.new(size.X/2,150)
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
            afkLabel.Visible = guiVisible
            closeBtn.Visible = guiVisible
        end
    end
end)

-- ================= AFK TIMER =================
task.spawn(function()
    while true do
        task.wait(1)
        afkTime += 1
        afkLabel.Text = "AFK TIME: "..afkTime.."s"
    end
end)

print("AUTO FARM + ANTI AFK LOADED | ] = Start, [ = Stop, F = Hide/Show, X = Close")


