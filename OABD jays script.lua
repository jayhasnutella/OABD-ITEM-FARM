--==================================================
-- NUTELLAS OABD FARM
--==================================================
-- LocalScript inside StarterGui
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local Player = Players.LocalPlayer

--==================================================
-- SETTINGS
--==================================================

local SPEED = 67
local WAIT_BETWEEN_POINTS = 1

--==================================================
-- FARM LOCATIONS
--==================================================

local FarmLocations = {
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
	Vector3.new(5856.560546875, 684.7222900390625, -1506.0340576171875),
}

--==================================================
-- GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "NutellasOABDFarm"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.DisplayOrder = 999999
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
Gui.Parent = Player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 340, 0, 285)
Main.Position = UDim2.new(0.5, -170, 0.5, -142)
Main.BackgroundColor3 = Color3.fromRGB(28, 12, 45)
Main.BorderSizePixel = 0
Main.Active = true
Main.ZIndex = 100
Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(170, 65, 255)
MainStroke.Thickness = 2
MainStroke.Parent = Main

--==================================================
-- TITLE
--==================================================

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 42)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "Nutellas OABD Farm"
Title.TextColor3 = Color3.fromRGB(220, 165, 255)
Title.TextSize = 24
Title.Font = Enum.Font.GothamBold
Title.ZIndex = 101
Title.Parent = Main

--==================================================
-- ORIGINAL UI
--==================================================

local OriginalUI = Instance.new("Frame")
OriginalUI.Name = "OriginalUI"
OriginalUI.Size = UDim2.new(1, 0, 1, -50)
OriginalUI.Position = UDim2.new(0, 0, 0, 50)
OriginalUI.BackgroundTransparency = 1
OriginalUI.ZIndex = 101
OriginalUI.Parent = Main

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -20, 0, 22)
Subtitle.Position = UDim2.new(0, 10, 0, -5)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "20 Point Farming Route • 67 Studs/Sec"
Subtitle.TextColor3 = Color3.fromRGB(150, 120, 175)
Subtitle.TextSize = 13
Subtitle.Font = Enum.Font.Gotham
Subtitle.ZIndex = 102
Subtitle.Parent = OriginalUI

--==================================================
-- START BUTTON
--==================================================

local StartButton = Instance.new("TextButton")
StartButton.Name = "StartButton"
StartButton.Size = UDim2.new(1, -40, 0, 52)
StartButton.Position = UDim2.new(0, 20, 0, 25)
StartButton.BackgroundColor3 = Color3.fromRGB(115, 35, 190)
StartButton.BorderSizePixel = 0
StartButton.Text = "START"
StartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartButton.TextSize = 19
StartButton.Font = Enum.Font.GothamBold
StartButton.ZIndex = 103
StartButton.Parent = OriginalUI

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 10)
ButtonCorner.Parent = StartButton

local ButtonStroke = Instance.new("UIStroke")
ButtonStroke.Color = Color3.fromRGB(205, 120, 255)
ButtonStroke.Thickness = 1.5
ButtonStroke.Parent = StartButton

--==================================================
-- STATUS
--==================================================

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -40, 0, 35)
Status.Position = UDim2.new(0, 20, 0, 88)
Status.BackgroundTransparency = 1
Status.Text = "● Farm Status: OFF"
Status.TextColor3 = Color3.fromRGB(255, 100, 120)
Status.TextSize = 14
Status.Font = Enum.Font.GothamMedium
Status.ZIndex = 103
Status.Parent = OriginalUI

--==================================================
-- EQUIP ALL ITEMS BUTTON
--==================================================

local EquipAllButton = Instance.new("TextButton")
EquipAllButton.Name = "EquipAllItemsForSell"
EquipAllButton.Size = UDim2.new(1, -40, 0, 48)
EquipAllButton.Position = UDim2.new(0, 20, 0, 130)
EquipAllButton.BackgroundColor3 = Color3.fromRGB(95, 35, 150)
EquipAllButton.BorderSizePixel = 0
EquipAllButton.Text = "Equip All Items For Sell"
EquipAllButton.TextColor3 = Color3.fromRGB(255, 255, 255)
EquipAllButton.TextSize = 15
EquipAllButton.Font = Enum.Font.GothamBold
EquipAllButton.ZIndex = 103
EquipAllButton.Parent = OriginalUI

local EquipCorner = Instance.new("UICorner")
EquipCorner.CornerRadius = UDim.new(0, 9)
EquipCorner.Parent = EquipAllButton

local EquipStroke = Instance.new("UIStroke")
EquipStroke.Color = Color3.fromRGB(205, 120, 255)
EquipStroke.Thickness = 1.5
EquipStroke.Parent = EquipAllButton

--==================================================
-- SELL NOTE
--==================================================

local SellNote = Instance.new("TextLabel")

SellNote.Name = "SellNote"
SellNote.Size = UDim2.new(1, -40, 0, 28)
SellNote.Position = UDim2.new(0, 20, 0, 180)

SellNote.BackgroundTransparency = 1

SellNote.Text = '(YOU STILL HAVE TO PRESS "E" ALOT TO SELL)'
SellNote.TextColor3 = Color3.fromRGB(180, 150, 200)
SellNote.TextSize = 11
SellNote.Font = Enum.Font.GothamMedium

SellNote.TextWrapped = true
SellNote.ZIndex = 103

SellNote.Parent = OriginalUI

--==================================================
-- RUNNING UI
--==================================================

local RunningUI = Instance.new("Frame")
RunningUI.Name = "RunningUI"
RunningUI.Size = UDim2.new(1, 0, 1, -50)
RunningUI.Position = UDim2.new(0, 0, 0, 50)
RunningUI.BackgroundTransparency = 1
RunningUI.Visible = false
RunningUI.ZIndex = 101
RunningUI.Parent = Main

local AutoFarmText = Instance.new("TextLabel")
AutoFarmText.Size = UDim2.new(1, -40, 0, 35)
AutoFarmText.Position = UDim2.new(0, 20, 0, 0)
AutoFarmText.BackgroundTransparency = 1
AutoFarmText.Text = "● Auto Farm Started"
AutoFarmText.TextColor3 = Color3.fromRGB(100, 255, 180)
AutoFarmText.TextSize = 16
AutoFarmText.Font = Enum.Font.GothamBold
AutoFarmText.ZIndex = 102
AutoFarmText.Parent = RunningUI

local ElapsedText = Instance.new("TextLabel")
ElapsedText.Size = UDim2.new(1, -40, 0, 30)
ElapsedText.Position = UDim2.new(0, 20, 0, 42)
ElapsedText.BackgroundTransparency = 1
ElapsedText.Text = "Time Elapsed: 00:00:00"
ElapsedText.TextColor3 = Color3.fromRGB(220, 200, 240)
ElapsedText.TextSize = 14
ElapsedText.Font = Enum.Font.GothamMedium
ElapsedText.ZIndex = 102
ElapsedText.Parent = RunningUI

local StopButton = Instance.new("TextButton")
StopButton.Size = UDim2.new(1, -40, 0, 42)
StopButton.Position = UDim2.new(0, 20, 0, 82)
StopButton.BackgroundColor3 = Color3.fromRGB(180, 45, 80)
StopButton.BorderSizePixel = 0
StopButton.Text = "STOP"
StopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopButton.TextSize = 17
StopButton.Font = Enum.Font.GothamBold
StopButton.ZIndex = 103
StopButton.Parent = RunningUI

local StopCorner = Instance.new("UICorner")
StopCorner.CornerRadius = UDim.new(0, 9)
StopCorner.Parent = StopButton

--==================================================
-- DRAGGING
--==================================================

local Dragging = false
local DragStart
local StartPosition

Main.InputBegan:Connect(function(Input)

	if Input.UserInputType == Enum.UserInputType.MouseButton1
		or Input.UserInputType == Enum.UserInputType.Touch then

		Dragging = true
		DragStart = Input.Position
		StartPosition = Main.Position

	end

end)

Main.InputEnded:Connect(function(Input)

	if Input.UserInputType == Enum.UserInputType.MouseButton1
		or Input.UserInputType == Enum.UserInputType.Touch then

		Dragging = false

	end

end)

UserInputService.InputChanged:Connect(function(Input)

	if not Dragging then
		return
	end

	if Input.UserInputType == Enum.UserInputType.MouseMovement
		or Input.UserInputType == Enum.UserInputType.Touch then

		local Delta = Input.Position - DragStart

		Main.Position = UDim2.new(
			StartPosition.X.Scale,
			StartPosition.X.Offset + Delta.X,

			StartPosition.Y.Scale,
			StartPosition.Y.Offset + Delta.Y
		)

	end

end)

--==================================================
-- FARMING VARIABLES
--==================================================

local Farming = false
local CurrentTween = nil
local FarmStartTime = 0

--==================================================
-- FORMAT TIME
--==================================================

local function FormatTime(Seconds)

	local Hours = math.floor(Seconds / 3600)

	local Minutes =
		math.floor((Seconds % 3600) / 60)

	local SecondsLeft =
		math.floor(Seconds % 60)

	return string.format(
		"%02d:%02d:%02d",
		Hours,
		Minutes,
		SecondsLeft
	)

end

--==================================================
-- MOVE AT CONSTANT SPEED
--==================================================

local function MoveToPoint(Position)

	local Character = Player.Character

	if not Character then
		return false
	end

	local Root =
		Character:FindFirstChild("HumanoidRootPart")

	if not Root then
		return false
	end

	local StartPosition = Root.Position

	local Distance =
		(Position - StartPosition).Magnitude

	-- Travel time is calculated from:
	-- distance / 67 studs per second

	local TravelTime =
		Distance / SPEED

	if TravelTime <= 0.05 then

		Character:PivotTo(
			CFrame.new(Position)
		)

		return Farming

	end

	local CFrameValue =
		Instance.new("CFrameValue")

	CFrameValue.Value =
		Character:GetPivot()

	local Connection

	Connection =
		CFrameValue:GetPropertyChangedSignal(
			"Value"
		):Connect(function()

			if Farming and Character.Parent then

				Character:PivotTo(
					CFrameValue.Value
				)

			end

		end)

	CurrentTween =
		TweenService:Create(
			CFrameValue,

			TweenInfo.new(
				TravelTime,
				Enum.EasingStyle.Linear,
				Enum.EasingDirection.InOut
			),

			{
				Value = CFrame.new(Position)
			}
		)

	CurrentTween:Play()

	while CurrentTween.PlaybackState ==
		Enum.PlaybackState.Playing do

		if not Farming then

			CurrentTween:Cancel()

			break

		end

		task.wait(0.05)

	end

	if Connection then
		Connection:Disconnect()
	end

	CFrameValue:Destroy()

	CurrentTween = nil

	return Farming

end

--==================================================
-- TIMER
--==================================================

task.spawn(function()

	while true do

		if Farming then

			local Elapsed =
				os.clock() - FarmStartTime

			ElapsedText.Text =
				"Time Elapsed: " ..
				FormatTime(Elapsed)

		end

		task.wait(1)

	end

end)

--==================================================
-- START FARM
--==================================================

local function StartFarm()

	if Farming then
		return
	end

	Farming = true

	FarmStartTime =
		os.clock()

	OriginalUI.Visible = false
	RunningUI.Visible = true

	task.spawn(function()

		while Farming do

			for i, Location in ipairs(FarmLocations) do

				if not Farming then
					break
				end

				if not Player.Character then
					Player.CharacterAdded:Wait()
				end

				AutoFarmText.Text =
					"● Auto Farm • " ..
					SPEED ..
					" studs/sec • Point " ..
					i ..
					"/20"

				local Success =
					MoveToPoint(Location)

				if not Success then
					break
				end

				if Farming then
					task.wait(WAIT_BETWEEN_POINTS)
				end

			end

		end

	end)

end

--==================================================
-- STOP FARM
--==================================================

local function StopFarm()

	Farming = false

	if CurrentTween then

		CurrentTween:Cancel()
		CurrentTween = nil

	end

	RunningUI.Visible = false
	OriginalUI.Visible = true

	StartButton.Text = "START"

	StartButton.BackgroundColor3 =
		Color3.fromRGB(115, 35, 190)

	Status.Text =
		"● Farm Status: OFF"

	Status.TextColor3 =
		Color3.fromRGB(255, 100, 120)

end

--==================================================
-- EQUIP ALL ITEMS FOR SELL
--==================================================

local AllEquipped = false

EquipAllButton.MouseButton1Click:Connect(function()

	local Character = Player.Character

	if not Character then
		return
	end

	local Backpack =
		Player:FindFirstChildOfClass("Backpack")

	if not Backpack then
		return
	end

	--==============================================
	-- EQUIP EVERYTHING
	--==============================================

	if not AllEquipped then

		local Tools = {}

		for _, Item in ipairs(Backpack:GetChildren()) do

			if Item:IsA("Tool") then
				table.insert(Tools, Item)
			end

		end

		for _, Tool in ipairs(Tools) do

			if Tool.Parent == Backpack then
				Tool.Parent = Character
			end

		end

		AllEquipped = true

		EquipAllButton.Text =
			"Unequip All Items"

		EquipAllButton.BackgroundColor3 =
			Color3.fromRGB(125, 45, 180)

	--==============================================
	-- UNEQUIP EVERYTHING
	--==============================================

	else

		for _, Item in ipairs(Character:GetChildren()) do

			if Item:IsA("Tool") then
				Item.Parent = Backpack
			end

		end

		AllEquipped = false

		EquipAllButton.Text =
			"Equip All Items For Sell"

		EquipAllButton.BackgroundColor3 =
			Color3.fromRGB(95, 35, 150)

	end

end)

--==================================================
-- BUTTONS
--==================================================

StartButton.MouseButton1Click:Connect(function()
	StartFarm()
end)

StopButton.MouseButton1Click:Connect(function()
	StopFarm()
end)

--==================================================
-- LEFT CTRL = HIDE / SHOW
--==================================================

local UIHidden = false

UserInputService.InputBegan:Connect(function(
	Input,
	GameProcessed
)

	if GameProcessed then
		return
	end

	if Input.KeyCode ==
		Enum.KeyCode.LeftControl then

		UIHidden = not UIHidden

		Main.Visible =
			not UIHidden

	end

end)

--==================================================
-- EXECUTION NOTIFICATION
--==================================================

task.delay(1, function()

	pcall(function()

		StarterGui:SetCore(
			"SendNotification",
			{
				Title = "Nutellas OABD Farm",

				Text =
					"Successfully Executed! " ..
					SPEED ..
					" studs/sec • Left Ctrl = Hide!",

				Duration = 6
			}
		)

	end)

end)

loadstring(game:HttpGet("https://raw.githubusercontent.com/hassanxzayn-lua/Anti-afk/main/antiafkbyhassanxzyn"))();
