-- 顶部：防检测 Hook 系统
local hookVelocity = false -- 默认关闭
local mt = getrawmetatable(game)
local old = mt.__index
setreadonly(mt, false)

mt.__index = newcclosure(function(self, key)
    if hookVelocity and (key == "AssemblyLinearVelocity" or key == "Velocity") and self:IsA("BasePart") then
        return Vector3.new(0, 0, 0)
    end
    return old(self, key)
end)

setreadonly(mt, true)
-- ============================================
-- 检测多个指定玩家加入服务器并提示（纯源码）
-- ============================================

local TARGET_NAMES = {
    "Suponjibobu00",
    "YK666308",
    "某某某3",
} -- 需要监控的玩家名字，随意增加

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- 快速查表
local targetSet = {}
for _, name in ipairs(TARGET_NAMES) do
    targetSet[string.lower(name)] = name
end

-- 创建提示界面
local function showNotification(playerName)
    local oldGui = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("TargetJoinNotify")
    if oldGui then oldGui:Destroy() end

    local gui = Instance.new("ScreenGui")
    gui.Name = "TargetJoinNotify"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 80)
    frame.Position = UDim2.new(0.5, -200, 0, 50)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 0
    frame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 80, 80)
    stroke.Thickness = 2
    stroke.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 8)
    title.BackgroundTransparency = 1
    title.Text = "目标玩家加入不是脚本作者就是管理员"
    title.TextColor3 = Color3.fromRGB(255, 80, 80)
    title.TextSize = 20
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    local content = Instance.new("TextLabel")
    content.Size = UDim2.new(1, 0, 0, 28)
    content.Position = UDim2.new(0, 0, 0, 40)
    content.BackgroundTransparency = 1
    content.Text = playerName .. " 加入了服务器！"
    content.TextColor3 = Color3.fromRGB(255, 255, 255)
    content.TextSize = 16
    content.Font = Enum.Font.Gotham
    content.Parent = frame

    -- 淡入
    frame.BackgroundTransparency = 1
    title.TextTransparency = 1
    content.TextTransparency = 1
    task.spawn(function()
        for i = 0, 20 do
            local t = i / 20
            frame.BackgroundTransparency = 0.8 - 0.6 * t
            title.TextTransparency = 1 - t
            content.TextTransparency = 1 - t
            task.wait(0.01)
        end
    end)

    -- 30 秒后淡出
    task.delay(30, function()
        for i = 0, 20 do
            local t = i / 20
            frame.BackgroundTransparency = 0.2 + 0.8 * t
            title.TextTransparency = t
            content.TextTransparency = t
            task.wait(0.01)
        end
        gui:Destroy()
    end)

    -- 提示音
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://4590662766"
    sound.Volume = 0.9
    sound.Parent = gui
    sound:Play()
end

-- 检查玩家是否在监控列表里
local function checkPlayer(player)
    if targetSet[string.lower(player.Name)] then
        showNotification(player.Name)
    end
end

-- 检查已经在服务器里的玩家
for _, player in ipairs(Players:GetPlayers()) do
    checkPlayer(player)
end

-- 监听后续加入的玩家
Players.PlayerAdded:Connect(checkPlayer)
-- ==================== 服务 ====================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ==================== 加载 Obsidian UI（代理链接） ====================
local repo = "https://ghproxy.net/https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
local Options = Library.Options

-- ==================== 紫色主题 ====================
Library.Scheme.FontColor = Color3.fromRGB(190, 120, 255)
Library.Scheme.SecondaryFontColor = Color3.fromRGB(160, 95, 220)
Library.Scheme.AccentColor = Color3.fromRGB(155, 60, 225)
Library.Scheme.WhiteColor = Library.Scheme.FontColor
Library:UpdateColorsUsingRegistry()

Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true

-- ==================== 创建窗口 ====================
local Window = Library:CreateWindow({
    Title = "港猫的通缉中国希望",
    Footer = "欢迎使用",
    Icon = "rbxassetid://135749451972137",
    NotifySide = "Right",
    ShowCustomCursor = false,
    Center = true,
    AutoShow = true,
    Resizable = true,
    MobileButtonsSide = "f",
})

-- 背景图片代码
Window:SetBackgroundImage("https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/73bb4309-492f-4ecd-964f-7aa362722299.png")
Window.BackgroundTransparency = 0.9
-- ==================== 创建所有标签页 ====================
local Tabs = {
    gg   = Window:AddTab("公告", "megaphone"),
    wj   = Window:AddTab("玩家", "users"),
    sf   = Window:AddTab("甩飞", "rbxassetid://7733799371"),
    fc   = Window:AddTab("亚洲车王", "rbxassetid://7733708835"),
    jqr   = Window:AddTab("愤怒BOT", "rbxassetid://7733916988"),
    jx   = Window:AddTab("远程击杀+雷达", "crown"),
    gh   = Window:AddTab("光环设置", "crown"),
    bot  = Window:AddTab("瞄准", "target"),
    zj  = Window:AddTab("子追静默瞄准", "target"),
    ESP  = Window:AddTab("ESP", "eye"),
    ESPP = Window:AddTab("ESP2", "eye"),
    pg   = Window:AddTab("苹果端ESP", "eye"),
    wb   = Window:AddTab("ESP物品", "box"),
    lc   = Window:AddTab("自动化农场", "rbxassetid://7733920117"),
    qq   = Window:AddTab("删除", "trash-2"),
    rsao = Window:AddTab("娱乐功能", "zap"),
    gm   = Window:AddTab("购买", "shopping-cart"),
    UI   = Window:AddTab("UI 设置", "settings"),
}
-----公告-------
-- ==================== 公告标签页 ====================
local ggLeft  = Tabs.gg:AddLeftGroupbox(" 公告栏")
local ggRight = Tabs.gg:AddRightGroupbox("使用说明")

ggLeft:AddLabel("欢迎使用 港猫的通缉中国希望")
ggLeft:AddDivider()
ggLeft:AddLabel("有问题、bug请联系作者")
ggLeft:AddLabel("售后1125514261")
ggLeft:AddDivider()
ggLeft:AddLabel("更新内容：")
ggLeft:AddLabel("• 新增飞车光环等")
ggLeft:AddLabel("• 新增愤怒机器人")
ggLeft:AddLabel("• 新增刷钱自动化农场")
ggLeft:AddDivider()

ggRight:AddLabel("使用提示")
ggRight:AddDivider()
ggRight:AddLabel("1. 跑步拉回时")
ggRight:AddLabel("   请连续跳跃再奔跑")
ggRight:AddDivider()
ggRight:AddLabel("2. 苹果端ESP")
ggRight:AddLabel("   已修复")
ggRight:AddDivider()
ggRight:AddLabel("3. ESP 如果没显示")
ggRight:AddLabel("   先把总开关打开")
ggRight:AddDivider()
ggRight:AddLabel("4. 子弹追踪问题")
ggRight:AddLabel("  原版子弹追踪第三人称会视角晃动强制修复可能会有一定概率无法击中")

ggRight:AddDivider()
ggRight:AddButton({
    Text = "复制售后群",
    Func = function()
        if setclipboard then
            setclipboard("1125514261")
            Library:Notify({Title = "已复制", Text = "纸飞机：@you25801", Duration = 3})
        else
            Library:Notify({Title = "提示", Text = "纸飞机：@you25801", Duration = 5})
        end
    end,
})

ggRight:AddButton({
    Text = "重新显示公告",
    Func = function()
        Library:Notify({Title = "公告", Text = "脚本已加载，祝你使用愉快！", Duration = 5})
    end,
})
-- ==================== 通用工具函数 ====================
local function getCharacter()
    if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        return LocalPlayer.Character
    end
    return nil
end

-- ==================== 玩家页：超级快跑 ====================
local speedConn, currentSpeed = nil, 1
local function updateChar()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if speedConn then speedConn:Disconnect() speedConn = nil end
    if not hum or currentSpeed <= 1 then return end
    speedConn = RunService.Heartbeat:Connect(function()
        if not LocalPlayer.Character then
            speedConn:Disconnect() speedConn = nil
            return
        end
        local h = LocalPlayer.Character.Humanoid
        if h.MoveDirection.Magnitude > 0 then
            LocalPlayer.Character:TranslateBy(h.MoveDirection * currentSpeed / 10)
        end
    end)
end
LocalPlayer.CharacterAdded:Connect(updateChar)
task.spawn(updateChar)

local speedGroup = Tabs.wj:AddLeftGroupbox("超级快跑")

speedGroup:AddInput("Speed_Input", {
    Text = "超级快跑 (输入1~200数字)",
    Default = "1",
    Numeric = true,
    Finished = true,
    Placeholder = "输入1~200",
    Callback = function(val)
        local num = tonumber(val)
        if not num then return end
        currentSpeed = math.clamp(num, 1, 200)
        updateChar()
    end,
})

speedGroup:AddSlider("Speed_Slider", {
    Text = "超级快跑(滑块)",
    Default = 1,
    Min = 1,
    Max = 200,
    Rounding = 0,
    Suffix = " studs",
    Callback = function(val)
        currentSpeed = val
        updateChar()
    end,
})

-- ==================== 玩家页：无限跳 ====================
local isInfiniteJumpEnabled = false
UserInputService.JumpRequest:Connect(function()
    if isInfiniteJumpEnabled then
        local character = getCharacter()
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end
end)

-- ==================== 玩家页：灵魂飞行 ====================
-- ==================== 玩家页：飞行（替换灵魂飞行） ====================
local FlyingEnabled = false
local FlightSpeed = 180
local CurrentAO, CurrentLV, CurrentMoverAttachment, FlightConnection
local flyHumanoid = nil

local function getFlyControlModule()
    local PlayerModule = LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")
    return require(PlayerModule:WaitForChild("ControlModule"))
end

local function setupFlyBodyMovers(character)
    local hrp = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")
    local moverParent = workspace:FindFirstChildOfClass("Terrain") or workspace

    local moverAttachment = Instance.new("Attachment", hrp)
    moverAttachment.Name = "FlightAttachment"

    local alignOrientation = Instance.new("AlignOrientation")
    alignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
    alignOrientation.RigidityEnabled = true
    alignOrientation.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    alignOrientation.CFrame = hrp.CFrame
    alignOrientation.Attachment0 = moverAttachment
    alignOrientation.Parent = moverParent

    local linearVelocity = Instance.new("LinearVelocity")
    linearVelocity.VectorVelocity = Vector3.new(0, 0, 0)
    linearVelocity.MaxForce = 9e9
    linearVelocity.Attachment0 = moverAttachment
    linearVelocity.Parent = moverParent

    return alignOrientation, linearVelocity, moverAttachment, humanoid
end

local function startFlying()
    if FlyingEnabled then return end
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    if not character then return end

    CurrentAO, CurrentLV, CurrentMoverAttachment, flyHumanoid = setupFlyBodyMovers(character)
    FlyingEnabled = true

    local controlModule = getFlyControlModule()

    FlightConnection = RunService.Heartbeat:Connect(function()
        if not FlyingEnabled or not CurrentLV or not CurrentAO then
            if FlightConnection then
                FlightConnection:Disconnect()
                FlightConnection = nil
            end
            return
        end

        local moveVector = controlModule:GetMoveVector()
        local cam = workspace.CurrentCamera

        local F, B, L, R, Q, E = 0, 0, 0, 0, 0, 0
        F = -moveVector.Z
        B = moveVector.Z
        L = -moveVector.X
        R = moveVector.X

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then F = 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then B = 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then L = 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then R = 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then Q = 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then E = 1 end

        local flightVector = (cam.CFrame.LookVector * (F - B) +
                              cam.CFrame.RightVector * (R - L) +
                              Vector3.new(0, 1, 0) * (Q - E))

        if flightVector.Magnitude > 0 then
            CurrentLV.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
            CurrentLV.VectorVelocity = flightVector.Unit * FlightSpeed
        else
            CurrentLV.VectorVelocity = Vector3.new(0, 0, 0)
        end

        CurrentAO.CFrame = workspace.CurrentCamera.CFrame
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.PlatformStand = true
        end
    end)

    print("飞行已开启，速度:", FlightSpeed)
end

local function stopFlying()
    if not FlyingEnabled then return end
    FlyingEnabled = false

    if FlightConnection then
        FlightConnection:Disconnect()
        FlightConnection = nil
    end

    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.PlatformStand = false
    end

    if CurrentAO then CurrentAO:Destroy() CurrentAO = nil end
    if CurrentLV then CurrentLV:Destroy() CurrentLV = nil end
    if CurrentMoverAttachment then CurrentMoverAttachment:Destroy() CurrentMoverAttachment = nil end

    print("飞行已关闭")
end

local flyGroup = Tabs.wj:AddLeftGroupbox("飞行")

flyGroup:AddToggle("Fly_Toggle", {
    Text = "飞行模式",
    Default = false,
    Tooltip = "WASD移动，空格上升，左Ctrl下降",
    Callback = function(v)
        if v then startFlying() else stopFlying() end
    end,
})

flyGroup:AddSlider("Fly_Speed", {
    Text = "飞行速度",
    Default = 180,
    Min = 50,
    Max = 400,
    Rounding = 0,
    Callback = function(val) FlightSpeed = val end,
})
-- ==================== 玩家页：人物自转 ====================
local SpinEnabled, SpinSpeed = false, 5
local SpinConnection = nil
local function StartSpin()
    if SpinConnection then return end
    SpinConnection = RunService.RenderStepped:Connect(function(dt)
        if not SpinEnabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hrp2 = char:FindFirstChild("HumanoidRootPart")
        if not hrp2 then return end
        hrp2.CFrame = hrp2.CFrame * CFrame.Angles(0, math.rad(SpinSpeed) * dt * 60, 0)
    end)
end
local function StopSpin()
    SpinEnabled = false
    if SpinConnection then SpinConnection:Disconnect() SpinConnection = nil end
end
LocalPlayer.CharacterAdded:Connect(function()
    if SpinEnabled then task.wait(0.5) StartSpin() end
end)

local spinGroup = Tabs.wj:AddRightGroupbox("人物自转")

spinGroup:AddToggle("Spin_Toggle", {
    Text = "人物自转",
    Default = false,
    Callback = function(v)
        SpinEnabled = v
        if v then StartSpin() else StopSpin() end
    end,
})

spinGroup:AddSlider("Spin_Speed", {
    Text = "旋转速度",
    Default = 5,
    Min = 1,
    Max = 200,
    Rounding = 0,
    Callback = function(v) SpinSpeed = v end,
})

-- ==================== 玩家页：修改别人头部大小 ====================
local CONFIG = {
    defaultSize = 1,
    minSize = 1,
    maxSize = 5000,
    loadDelay = 0.15,
}

local HeadScaler = {
    enabled = false,
    headSize = CONFIG.defaultSize,
    heartbeatConn = nil,
    playerAddedConn = nil,
    charBindings = {},
    _initialized = false,
}

function HeadScaler:UpdateAllHeads()
    local size = Vector3.new(self.headSize, self.headSize, self.headSize)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then
                pcall(function()
                    head.Size = size
                    head.CanCollide = false
                end)
            end
        end
    end
end

function HeadScaler:BindPlayer(player)
    if self.charBindings[player] then return end
    self.charBindings[player] = player.CharacterAdded:Connect(function()
        task.wait(CONFIG.loadDelay)
        self:UpdateAllHeads()
    end)
    task.spawn(function()
        task.wait(CONFIG.loadDelay)
        self:UpdateAllHeads()
    end)
end

function HeadScaler:UnbindPlayer(player)
    if self.charBindings[player] then
        self.charBindings[player]:Disconnect()
        self.charBindings[player] = nil
    end
end

function HeadScaler:ClearAll()
    if self.heartbeatConn then self.heartbeatConn:Disconnect() self.heartbeatConn = nil end
    if self.playerAddedConn then self.playerAddedConn:Disconnect() self.playerAddedConn = nil end
    for player, conn in pairs(self.charBindings) do
        conn:Disconnect()
        self.charBindings[player] = nil
    end
end

function HeadScaler:SetEnabled(enable)
    if self.enabled == enable then return end
    self:ClearAll()
    self.enabled = enable
    if not enable then return end
    self.heartbeatConn = RunService.Heartbeat:Connect(function() self:UpdateAllHeads() end)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then self:BindPlayer(player) end
    end
    self.playerAddedConn = Players.PlayerAdded:Connect(function(player)
        if player ~= LocalPlayer then self:BindPlayer(player) end
    end)
    self:UpdateAllHeads()
end

function HeadScaler:SetSize(newSize)
    local clamped = math.clamp(newSize, CONFIG.minSize, CONFIG.maxSize)
    self.headSize = clamped
    if self.enabled then self:UpdateAllHeads() end
end

Players.PlayerRemoving:Connect(function(player)
    HeadScaler:UnbindPlayer(player)
end)

local headGroup = Tabs.wj:AddRightGroupbox("头部缩放")

headGroup:AddToggle("Head_Toggle", {
    Text = "修改别人头部大小(仅本地)",
    Default = false,
    Callback = function(value) HeadScaler:SetEnabled(value) end,
})

headGroup:AddInput("Head_Size_Input", {
    Text = "别人头部尺寸",
    Default = "1",
    Numeric = true,
    Finished = true,
    Placeholder = "输入1-5000",
    Callback = function(value)
        local num = tonumber(value)
        if num then HeadScaler:SetSize(num) end
    end,
})
---------？？？-----

local laokGroup = Tabs.wj:AddRightGroupbox("坠落功能")

laokGroup:AddButton("Toggle_AntiDetect", {
    Text = "开启/关闭 防摔落",
    Tooltip = "开启后游戏读取你的速度恒为 0（防摔死/防瞬移检测）",
    Callback = function()
        hookVelocity = not hookVelocity -- 切换顶部定义的变量
        
        if hookVelocity then
            print("防检测：已开启")
        else
            print("防检测：已关闭")
        end
    end
})
-- ==================== 玩家页：通用功能 ====================
local clipConn = nil
local miscGroup = Tabs.wj:AddRightGroupbox("通用功能")

miscGroup:AddToggle("Inf_Jump", {
    Text = "无限跳",
    Default = false,
    Callback = function(state) isInfiniteJumpEnabled = state end,
})

miscGroup:AddToggle("Noclip", {
    Text = "穿墙",
    Default = false,
    Callback = function(enabled)
        if clipConn then clipConn:Disconnect() clipConn = nil end
        if enabled then
            clipConn = RunService.Stepped:Connect(function()
                local char = LocalPlayer.Character
                if not char then return end
                for _, part in ipairs(char:GetChildren()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end)
        else
            local char = LocalPlayer.Character
            if char then
                for _, part in ipairs(char:GetChildren()) do
                    if part:IsA("BasePart") then part.CanCollide = true end
                end
            end
        end
    end,
})

miscGroup:AddButton({
    Text = "踏空行走",
    Tooltip = "点击加载踏空行走",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float"))()
    end,
})

miscGroup:AddButton({
    Text = "定 (空中定住)",
    Tooltip = "弹出悬浮GUI，开启后角色悬浮空中",
    Func = function()
        local player = LocalPlayer
        local freeze, lockY = false, nil
        local character, root
        local function LoadCharacter()
            character = player.Character or player.CharacterAdded:Wait()
            root = character:WaitForChild("HumanoidRootPart")
        end
        LoadCharacter()
        player.CharacterAdded:Connect(function() task.wait(1) LoadCharacter() end)
        local gui = Instance.new("ScreenGui")
        gui.Name = "AirFreezeUI"; gui.ResetOnSpawn = false
        gui.Parent = player:WaitForChild("PlayerGui")
        local main = Instance.new("Frame")
        main.Size = UDim2.new(0,90,0,90); main.Position = UDim2.new(0.5,-70,0.65,0)
        main.BackgroundColor3 = Color3.fromRGB(25,25,30); main.Parent = gui
        local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,12); c.Parent = main
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1,0,0,26); title.BackgroundTransparency = 1
        title.Text = "定"; title.TextColor3 = Color3.new(1,1,1); title.TextSize = 16; title.Parent = main
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0,100,0,32); btn.Position = UDim2.new(0.5,-50,0.48,0)
        btn.BackgroundColor3 = Color3.fromRGB(0,170,255); btn.Text = "开启"
        btn.TextColor3 = Color3.new(1,1,1); btn.TextSize = 14; btn.Parent = main
        local tc = Instance.new("UICorner"); tc.CornerRadius = UDim.new(0,8); tc.Parent = btn
        btn.MouseButton1Click:Connect(function()
            freeze = not freeze
            if freeze then
                btn.Text = "关闭"; btn.BackgroundColor3 = Color3.fromRGB(255,70,70)
                if root then lockY = root.Position.Y end
            else
                btn.Text = "开启"; btn.BackgroundColor3 = Color3.fromRGB(0,170,255); lockY = nil
            end
        end)
        RunService.Heartbeat:Connect(function()
            if freeze and root and lockY then
                local pos = root.Position
                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero
                root.CFrame = CFrame.new(pos.X, lockY, pos.Z) * root.CFrame.Rotation
            end
        end)
    end,
})
----═══════════════════════════════════════════════════
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace        = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera      = Workspace.CurrentCamera

-- ═══════════════════════════════════════════════════
-- 参数配置
-- ═══════════════════════════════════════════════════
local CONFIG = {
    SwingRange         = 8,
    SwingFreq          = 20,
    SwingSpeed         = 0.03,
    TeleportPerTick    = 8,
    AngularForce       = 200000,
    VelocityMultiplier = 3.0,
    TargetForce        = 2000,
    TargetAngular      = 500000,
    TeleportDuration   = 4,
    CameraOffset       = Vector3.new(0, 3, 15),
}

-- ═══════════════════════════════════════════════════
-- 工具函数
-- ═══════════════════════════════════════════════════
local function SafeGetCharacter(player)
    if not player or not player.Parent then return nil end
    local char = player.Character
    if not char or not char.Parent then return nil end
    return char
end

local function SafeGetHRP(char)
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart")
end

local function SafeGetHum(char)
    if not char then return nil end
    return char:FindFirstChildOfClass("Humanoid")
end

-- ═══════════════════════════════════════════════════
-- 相机锁定
-- ═══════════════════════════════════════════════════
local cameraLock = { Subject = nil, Conn = nil }

local function LockCamera(subject)
    cameraLock.Subject = subject
    Camera.CameraType = Enum.CameraType.Scriptable
    Camera.CameraSubject = subject

    if cameraLock.Conn then cameraLock.Conn:Disconnect() end

    cameraLock.Conn = RunService.RenderStepped:Connect(function()
        local subj = cameraLock.Subject
        if not subj or not subj.Parent then return end
        local targetPos = subj.Position
        local camPos = targetPos + CONFIG.CameraOffset
        Camera.CFrame = CFrame.new(camPos, targetPos)
        Camera.Focus = CFrame.new(targetPos)
    end)
end

local function UnlockCamera()
    if cameraLock.Conn then
        cameraLock.Conn:Disconnect()
        cameraLock.Conn = nil
    end
    cameraLock.Subject = nil

    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            Camera.CameraSubject = hum
            Camera.CameraType = Enum.CameraType.Custom
        end
    end
end

-- ═══════════════════════════════════════════════════
-- 自甩飞
-- ═══════════════════════════════════════════════════
local selfFlingConn = nil
local selfFlingStepConn = nil

local function EnableSelfFling()
    if selfFlingConn then return end

    selfFlingConn = RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = SafeGetHRP(char)
        local hum = SafeGetHum(char)
        if not hrp or not hum then return end

        pcall(function()
            hum.PlatformStand = false
            hum.Sit = false
            hum.AutoRotate = true

            local state = hum:GetState()
            if state == Enum.HumanoidStateType.Physics
                or state == Enum.HumanoidStateType.FallingDown
                or state == Enum.HumanoidStateType.Ragdoll then
                hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            end

            hum:ChangeState(Enum.HumanoidStateType.Running)

            local vel = hrp.AssemblyLinearVelocity
            local safeY = math.clamp(vel.Y, -40, 40)

            hrp.AssemblyAngularVelocity = Vector3.new(
                CONFIG.AngularForce, CONFIG.AngularForce, CONFIG.AngularForce)
            hrp.AssemblyLinearVelocity = Vector3.new(
                vel.X * CONFIG.VelocityMultiplier, safeY, vel.Z * CONFIG.VelocityMultiplier)

            RunService.RenderStepped:Wait()

            if hrp and hrp.Parent then
                hrp.AssemblyAngularVelocity = Vector3.zero
            end
        end)
    end)

    selfFlingStepConn = RunService.Stepped:Connect(function()
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                for _, part in pairs(p.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        pcall(function() part.CanCollide = false end)
                    end
                end
            end
        end
    end)
end

local function DisableSelfFling()
    if selfFlingConn then selfFlingConn:Disconnect() selfFlingConn = nil end
    if selfFlingStepConn then selfFlingStepConn:Disconnect() selfFlingStepConn = nil end
end

-- ═══════════════════════════════════════════════════
-- 给目标施力
-- ═══════════════════════════════════════════════════
local function ForceTarget(targetPlayer)
    if not targetPlayer then return end
    local char = SafeGetCharacter(targetPlayer)
    if not char then return end
    local hrp = SafeGetHRP(char)
    if not hrp then return end

    pcall(function() hrp:SetNetworkOwner(LocalPlayer) end)

    pcall(function()
        hrp.AssemblyLinearVelocity = Vector3.new(
            CONFIG.TargetForce, CONFIG.TargetForce, CONFIG.TargetForce)
        hrp.AssemblyAngularVelocity = Vector3.new(
            CONFIG.TargetAngular, CONFIG.TargetAngular, CONFIG.TargetAngular)
    end)

    local hum = SafeGetHum(char)
    if hum then
        pcall(function()
            hum.PlatformStand = true
            hum:ChangeState(Enum.HumanoidStateType.Physics)
        end)
    end
end

-- ═══════════════════════════════════════════════════
-- 传送甩飞
-- ═══════════════════════════════════════════════════
local isTeleportFlying = false

local function TeleportFly(targetPlayer, duration)
    if isTeleportFlying then
        Library:Notify("正在执行中，请稍候", 2)
        return false
    end

    duration = duration or CONFIG.TeleportDuration

    if not targetPlayer then
        Library:Notify("目标为空", 2)
        return false
    end

    local targetChar = SafeGetCharacter(targetPlayer)
    if not targetChar then
        Library:Notify("目标不在游戏中", 2)
        return false
    end

    local myChar = SafeGetCharacter(LocalPlayer)
    local myHrp = SafeGetHRP(myChar)
    if not myHrp then
        Library:Notify("自己没有角色", 2)
        return false
    end

    isTeleportFlying = true
    Library:Notify("开始甩飞: " .. targetPlayer.Name, 2)

    local originalPosition = myHrp.Position

    LockCamera(myHrp)
    EnableSelfFling()

    local startTime = tick()
    local direction = 1
    local lastSwitch = tick()
    local detected = false

    while tick() - startTime < duration do
        local targetChar2 = SafeGetCharacter(targetPlayer)
        if not targetChar2 then break end

        local targetHrp = SafeGetHRP(targetChar2)
        if targetHrp then
            if tick() - lastSwitch > CONFIG.SwingSpeed then
                direction = direction * -1
                lastSwitch = tick()
            end

            local currentMyChar = SafeGetCharacter(LocalPlayer)
            local currentMyHrp = SafeGetHRP(currentMyChar)
            if currentMyHrp then
                for i = 1, CONFIG.TeleportPerTick do
                    local offset = direction * CONFIG.SwingRange * (i / CONFIG.TeleportPerTick)
                    local targetPos = targetHrp.Position
                        + targetHrp.CFrame.LookVector * offset
                    pcall(function()
                        currentMyHrp.CFrame = CFrame.new(targetPos)
                    end)
                end

                ForceTarget(targetPlayer)
            end

            if not detected then
                local speed = targetHrp.AssemblyLinearVelocity.Magnitude
                if speed > 30 then
                    detected = true
                    Library:Notify(" 甩飞成功: " .. targetPlayer.Name, 3)
                end
            end
        end

        task.wait(0.02)
    end

    local finalMyChar = SafeGetCharacter(LocalPlayer)
    local finalHrp = SafeGetHRP(finalMyChar)
    if finalHrp then
        pcall(function()
            finalHrp.CFrame = CFrame.new(originalPosition)
            finalHrp.AssemblyAngularVelocity = Vector3.zero
            finalHrp.AssemblyLinearVelocity = Vector3.zero
        end)
    end

    DisableSelfFling()
    UnlockCamera()

    isTeleportFlying = false
    Library:Notify(detected and "甩飞完成" or "甩飞失败", 3)
    return detected
end

-- ═══════════════════════════════════════════════════
-- 循环甩飞
-- ═══════════════════════════════════════════════════
local LoopFly = {
    Running = false,
    Target = nil,
    OriginalPosition = nil,
    LoopConn = nil,
    LeaveConn = nil,
}

local function LoopFly_Start(targetPlayer)
    if LoopFly.Running then
        LoopFly_Stop()
        task.wait(0.2)
    end

    if not targetPlayer then
        Library:Notify("目标为空", 2)
        return false
    end

    local targetChar = SafeGetCharacter(targetPlayer)
    if not targetChar then
        Library:Notify("目标不在游戏中", 2)
        return false
    end

    local myChar = SafeGetCharacter(LocalPlayer)
    local myHrp = SafeGetHRP(myChar)
    if not myHrp then
        Library:Notify("自己没有角色", 2)
        return false
    end

    LoopFly.Running = true
    LoopFly.Target = targetPlayer
    LoopFly.OriginalPosition = myHrp.Position

    Library:Notify("开始循环甩飞: " .. targetPlayer.Name, 2)

    LockCamera(myHrp)
    EnableSelfFling()

    LoopFly.LoopConn = RunService.Heartbeat:Connect(function()
        if not LoopFly.Running then return end

        local currentTargetChar = SafeGetCharacter(LoopFly.Target)
        if not currentTargetChar then
            LoopFly_Stop()
            return
        end

        local currentTargetHrp = SafeGetHRP(currentTargetChar)
        if not currentTargetHrp then return end

        local dir = math.sin(tick() * CONFIG.SwingFreq)
        local offset = dir * CONFIG.SwingRange

        local currentMyChar = SafeGetCharacter(LocalPlayer)
        local currentMyHrp = SafeGetHRP(currentMyChar)
        if currentMyHrp then
            for i = 1, CONFIG.TeleportPerTick do
                local subOffset = offset * (i / CONFIG.TeleportPerTick)
                local targetPos = currentTargetHrp.Position
                    + currentTargetHrp.CFrame.LookVector * subOffset
                pcall(function()
                    currentMyHrp.CFrame = CFrame.new(targetPos)
                end)
            end
            ForceTarget(LoopFly.Target)
        end
    end)

    LoopFly.LeaveConn = Players.PlayerRemoving:Connect(function(p)
        if p == LoopFly.Target and LoopFly.Running then
            LoopFly_Stop()
        end
    end)

    return true
end

function LoopFly_Stop()
    if not LoopFly.Running then return end
    LoopFly.Running = false

    if LoopFly.LoopConn then
        LoopFly.LoopConn:Disconnect()
        LoopFly.LoopConn = nil
    end
    if LoopFly.LeaveConn then
        LoopFly.LeaveConn:Disconnect()
        LoopFly.LeaveConn = nil
    end

    local myChar = SafeGetCharacter(LocalPlayer)
    local myHrp = SafeGetHRP(myChar)
    if myHrp and LoopFly.OriginalPosition then
        pcall(function()
            myHrp.CFrame = CFrame.new(LoopFly.OriginalPosition)
            myHrp.AssemblyAngularVelocity = Vector3.zero
            myHrp.AssemblyLinearVelocity = Vector3.zero
        end)
    end

    DisableSelfFling()
    UnlockCamera()

    LoopFly.Target = nil
    LoopFly.OriginalPosition = nil
    Library:Notify("已停止循环甩飞", 2)
end

-- ═══════════════════════════════════════════════════
-- 选中玩家状态
-- ═══════════════════════════════════════════════════
local selectedPlayer = nil

-- ═══════════════════════════════════════════════════
-- ⭐ Obsidian UI 部分 —— 在你的 sf 标签里添加功能
-- ═══════════════════════════════════════════════════

-- 左侧：主要功能
local sfLeft = Tabs.sf:AddLeftGroupbox("甩飞功能")

-- ── 玩家选择 ──
sfLeft:AddDropdown("Sf_PlayerSelect", {
    Text = "选择目标玩家",
    Values = (function()
        local list = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                table.insert(list, p.Name)
            end
        end
        return list
    end)(),
    Default = nil,
    Callback = function(value)
        if value then
            selectedPlayer = Players:FindFirstChild(value)
            if selectedPlayer then
                Library:Notify("已选择: " .. selectedPlayer.Name, 2)
                if LoopFly.Running then
                    LoopFly_Stop()
                    task.wait(0.2)
                    LoopFly_Start(selectedPlayer)
                end
            end
        end
    end,
})

-- ── 刷新玩家列表 ──
sfLeft:AddButton({
    Text = "刷新玩家列表",
    Func = function()
        local list = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                table.insert(list, p.Name)
            end
        end
        local dropdown = Options.Sf_PlayerSelect
        if dropdown and dropdown.SetValues then
            dropdown:SetValues(list)
        end
        Library:Notify("已刷新，共 " .. #list .. " 个玩家", 2)
    end,
})

sfLeft:AddDivider()

-- ── 传送甩飞 ──
sfLeft:AddButton({
    Text = " 传送甩飞（一次）",
    Func = function()
        if not selectedPlayer then
            Library:Notify(" 请先选择玩家", 2)
            return
        end
        if isTeleportFlying then
            Library:Notify(" 正在执行中", 2)
            return
        end
        task.spawn(function()
            TeleportFly(selectedPlayer)
        end)
    end,
})

-- ── 循环甩飞开关 ──
sfLeft:AddToggle("Sf_LoopFly", {
    Text = " 循环甩飞",
    Default = false,
    Callback = function(state)
        if state then
            if not selectedPlayer then
                Library:Notify("请先选择玩家", 2)
                Toggles.Sf_LoopFly:SetValue(false)
                return
            end
            LoopFly_Start(selectedPlayer)
        else
            LoopFly_Stop()
        end
    end,
})

-- 右侧：参数调节
local sfRight = Tabs.sf:AddRightGroupbox("参数设置")

sfRight:AddSlider("Sf_SwingRange", {
    Text = "摆动幅度",
    Min = 1, Max = 20, Default = 8, Rounding = 0,
    Suffix = " 米",
    Callback = function(v) CONFIG.SwingRange = v end,
})

sfRight:AddSlider("Sf_SwingFreq", {
    Text = "摆动频率",
    Min = 1, Max = 50, Default = 20, Rounding = 0,
    Suffix = " Hz",
    Callback = function(v) CONFIG.SwingFreq = v end,
})

sfRight:AddSlider("Sf_TeleportPerTick", {
    Text = "每次传送次数",
    Min = 1, Max = 20, Default = 8, Rounding = 0,
    Callback = function(v) CONFIG.TeleportPerTick = v end,
})

sfRight:AddSlider("Sf_AngularForce", {
    Text = "自甩角速度",
    Min = 10000, Max = 500000, Default = 200000, Rounding = 0,
    Callback = function(v) CONFIG.AngularForce = v end,
})

sfRight:AddSlider("Sf_VelocityMultiplier", {
    Text = "速度倍率",
    Min = 1, Max = 10, Default = 3, Rounding = 1,
    Suffix = " x",
    Callback = function(v) CONFIG.VelocityMultiplier = v end,
})

sfRight:AddSlider("Sf_TargetForce", {
    Text = "目标施力",
    Min = 100, Max = 10000, Default = 2000, Rounding = 0,
    Callback = function(v) CONFIG.TargetForce = v end,
})

sfRight:AddSlider("Sf_TargetAngular", {
    Text = "目标角速度",
    Min = 10000, Max = 2000000, Default = 500000, Rounding = 0,
    Callback = function(v) CONFIG.TargetAngular = v end,
})

sfRight:AddSlider("Sf_Duration", {
    Text = "传送甩飞时长",
    Min = 1, Max = 10, Default = 4, Rounding = 0,
    Suffix = " 秒",
    Callback = function(v) CONFIG.TeleportDuration = v end,
})

sfRight:AddInput("Sf_CameraOffsetY", {
    Text = "相机Y偏移",
    Default = "3",
    Placeholder = "3",
    Numeric = true,
    Callback = function(v)
        local n = tonumber(v)
        if n then CONFIG.CameraOffset = Vector3.new(0, n, CONFIG.CameraOffset.Z) end
    end,
})

sfRight:AddInput("Sf_CameraOffsetZ", {
    Text = "相机Z偏移",
    Default = "15",
    Placeholder = "15",
    Numeric = true,
    Callback = function(v)
        local n = tonumber(v)
        if n then CONFIG.CameraOffset = Vector3.new(0, CONFIG.CameraOffset.Y, n) end
    end,
})

sfRight:AddDivider()

-- 快速预设
sfRight:AddButton({
    Text = "安全模式",
    Func = function()
        CONFIG.SwingRange = 4
        CONFIG.SwingFreq = 10
        CONFIG.TeleportPerTick = 4
        CONFIG.AngularForce = 80000
        CONFIG.VelocityMultiplier = 1.5
        CONFIG.TargetForce = 1000
        CONFIG.TargetAngular = 200000
        Library:Notify("已应用保守模式", 2)
    end,
})

sfRight:AddButton({
    Text = "暴力模式",
    Func = function()
        CONFIG.SwingRange = 15
        CONFIG.SwingFreq = 30
        CONFIG.TeleportPerTick = 15
        CONFIG.AngularForce = 500000
        CONFIG.VelocityMultiplier = 5.0
        CONFIG.TargetForce = 5000
        CONFIG.TargetAngular = 1000000
        Library:Notify("已应用暴力模式", 2)
    end,
})
-- 玩家进出自动刷新
Players.PlayerAdded:Connect(function()
    task.wait(0.2)
    local list = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(list, p.Name)
        end
    end
    local dropdown = Options.Sf_PlayerSelect
    if dropdown and dropdown.SetValues then
        pcall(function() dropdown:SetValues(list) end)
    end
end)

Players.PlayerRemoving:Connect(function(p)
    task.wait(0.2)
    local list = {}
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= LocalPlayer then
            table.insert(list, pl.Name)
        end
    end
    local dropdown = Options.Sf_PlayerSelect
    if dropdown and dropdown.SetValues then
        pcall(function() dropdown:SetValues(list) end)
    end

    if p == selectedPlayer then
        selectedPlayer = nil
    end
    if LoopFly.Target == p and LoopFly.Running then
        LoopFly_Stop()
    end
end)

-- 角色重生清理
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    if LoopFly.Running then
        LoopFly_Stop()
    end
    UnlockCamera()
end)

Library:Notify("甩飞功能已加载到 sf 标签", 3)    
-- ==================== 亚洲车王：视角稳定（防晃动） ====================
local CamStab = {
    Enabled = false,
    Mode = "稳定跟随",
    Smoothness = 0.3,
    LastCFrame = nil,
    Connection = nil,
    SubjectConn = nil,
}

local function getCam()
    return workspace.CurrentCamera
end

local function restoreCamera()
    local cam = getCam()
    if not cam then return end
    if CamStab.SubjectConn then
        CamStab.SubjectConn:Disconnect()
        CamStab.SubjectConn = nil
    end
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            cam.CameraSubject = hum
        end
    end
    cam.CameraType = Enum.CameraType.Custom
end

local function startStabilize()
    local cam = getCam()
    if not cam then return end

    if CamStab.Connection then CamStab.Connection:Disconnect() CamStab.Connection = nil end
    if CamStab.SubjectConn then CamStab.SubjectConn:Disconnect() CamStab.SubjectConn = nil end

    -- 模式 1：稳定跟随
    if CamStab.Mode == "稳定跟随" then
        local function setSubject()
            local char = LocalPlayer.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then cam.CameraSubject = hrp end
            end
        end
        setSubject()
        CamStab.SubjectConn = RunService.Heartbeat:Connect(function()
            if not CamStab.Enabled then return end
            local char = LocalPlayer.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp and cam.CameraSubject ~= hrp then
                    cam.CameraSubject = hrp
                end
            end
        end)
    end

    -- 模式 2：固定朝向
    if CamStab.Mode == "固定朝向" then
        cam.CameraType = Enum.CameraType.Scriptable
        local lockedRot = cam.CFrame - cam.CFrame.Position

        CamStab.Connection = RunService.RenderStepped:Connect(function()
            if not CamStab.Enabled then return end
            local c = getCam()
            if not c then return end
            local char = LocalPlayer.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local pos = hrp.Position + Vector3.new(0, 2, 0)
                    c.CFrame = CFrame.new(pos) * lockedRot
                end
            end
        end)
    end

    -- 模式 3：抗抖动
    if CamStab.Mode == "抗抖动" then
        cam.CameraType = Enum.CameraType.Custom
        CamStab.LastCFrame = nil

        CamStab.Connection = RunService.RenderStepped:Connect(function()
            if not CamStab.Enabled then return end
            local c = getCam()
            if not c then return end

            local currentCF = c.CFrame
            if not CamStab.LastCFrame then
                CamStab.LastCFrame = currentCF
            else
                local smooth = math.clamp(CamStab.Smoothness, 0, 0.95)
                local newCF = CamStab.LastCFrame:Lerp(currentCF, 1 - smooth)
                c.CFrame = CFrame.new(newCF.Position) * (currentCF - currentCF.Position)
                CamStab.LastCFrame = c.CFrame
            end
        end)
    end
end

local function stopStabilize()
    if CamStab.Connection then CamStab.Connection:Disconnect() CamStab.Connection = nil end
    if CamStab.SubjectConn then CamStab.SubjectConn:Disconnect() CamStab.SubjectConn = nil end
    restoreCamera()
    CamStab.LastCFrame = nil
end

-- 角色重生后自动重挂
LocalPlayer.CharacterAdded:Connect(function()
    if CamStab.Enabled then
        task.wait(1)
        stopStabilize()
        CamStab.Enabled = true
        startStabilize()
    end
end)

-- ==================== UI 控件（Tabs.fc） ====================
local fcCamLeft  = Tabs.fc:AddLeftGroupbox("视角稳定")
local fcCamRight = Tabs.fc:AddRightGroupbox("视角参数")
-- ==================== 亚洲车王：飞车加载器 ====================
local fcFlyLeft = Tabs.fc:AddLeftGroupbox("飞车脚本")

fcFlyLeft:AddButton({
    Text = "启动飞车脚本",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ggsq1741-debug/BAL/refs/heads/main/GUI.lua"))()
        Library:Notify({
            Title = "飞车脚本",
            Text = "已加载，请查看新出现的悬浮按钮",
            Duration = 3,
        })
    end,
})

fcCamLeft:AddToggle("CamStab_Enable", {
    Text = "启用视角稳定（防晃动）",
    Default = false,
    Tooltip = "开启后视角不再晃动",
    Callback = function(v)
        CamStab.Enabled = v
        if v then
            startStabilize()
        else
            stopStabilize()
        end
    end,
})

fcCamLeft:AddDropdown("CamStab_Mode", {
    Text = "防抖模式",
    Values = { "稳定跟随", "固定朝向", "抗抖动" },
    Default = "稳定跟随",
    Callback = function(v)
        CamStab.Mode = v
        if CamStab.Enabled then
            stopStabilize()
            CamStab.Enabled = true
            startStabilize()
        end
    end,
})

fcCamLeft:AddButton("CamStab_Reapply", {
    Text = "重新应用稳定",
    Func = function()
        if not CamStab.Enabled then
            Library:Notify({Title = "提示", Text = "请先开启主开关", Duration = 2})
            return
        end
        stopStabilize()
        CamStab.Enabled = true
        startStabilize()
        Library:Notify({Title = "已重新应用", Text = "视角稳定已生效", Duration = 2})
    end,
})

fcCamRight:AddSlider("CamStab_Smooth", {
    Text = "平滑程度（抗抖动模式）",
    Desc = "越大越稳，但转向越迟钝",
    Default = 0.3, Min = 0, Max = 0.9, Rounding = 2,
    Callback = function(v)
        CamStab.Smoothness = v
    end,
})
-- ═══════════ 在这里定义 Ragebot 功能 + UI ═══════════
local function SetupRagebot(Tab) -- 接收你传入的 Tab
    local Players           = game:GetService("Players")
    local RunService        = game:GetService("RunService")
    local Workspace         = game:GetService("Workspace")
    local Debris            = game:GetService("Debris")
    local SoundService      = game:GetService("SoundService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local LocalPlayer = Players.LocalPlayer
    local userId = LocalPlayer.UserId

    -- 载入 Wanted 模块
    local DevvFolder = ReplicatedStorage:FindFirstChild("Devv") or ReplicatedStorage:FindFirstChild("devv")
    if not DevvFolder then return warn("[Ragebot] 未找到 Devv 模块") end
    local DevvModule = require(DevvFolder)
    local load          = DevvModule.load
    local nuid          = load("NUID")
    local Network       = load("Network")
    local MathUtil      = load("MathUtil")
    local ClientPlayers = load("ClientPlayers")
    local fireServer    = Network.FireServer
    local ClientTools   = require(ReplicatedStorage.Client.Wanted.Modules.ClientTools)

    -- 状态表
    local State = {
        Ragebot = false, Wallbang = true, TeamCheck = true, IgnoreCrawl = true, IgnoreKnock = true, IgnoreGrab = true,
        LastFire = 0, FireRate = 0.05, MaxDistance = 500, WallSpread = 30, Running = false, LoopConn = nil,
        TracerEnabled = true, TracerColor = Color3.fromRGB(255, 80, 80), TracerWidth = 0.25, TracerDuration = 1,
        HitSoundEnabled = true, HitSoundId = "rbxassetid://4590662766", HitSoundVolume = 0.5,
        LastToolId = nil, LastAmmo = nil, LastAmmoChangeAt = 0, ReloadRetryAt = 0,
    }

    -- 工具函数
    local function getMyChar()
        local c = LocalPlayer.Character
        return c, c and c:FindFirstChild("HumanoidRootPart"), c and c:FindFirstChild("Head")
    end
    local function isAlive(p)
        local c = p and p.Character; if not c then return false end
        local h = c:FindFirstChildOfClass("Humanoid"); return h and h.Health > 0
    end
    local function isTeam(p)
        if not State.TeamCheck then return false end
        if p.Team and LocalPlayer.Team and p.Team == LocalPlayer.Team then return true end
        if p.TeamColor and LocalPlayer.TeamColor and p.TeamColor == LocalPlayer.TeamColor then return true end
        return false
    end
    local function getProp(p, key)
        local CP = ClientPlayers.GetByPlayerId(p.UserId)
        if CP and CP.GetPlayerProperty then
            local ok, v = pcall(CP.GetPlayerProperty, CP, key); return ok and v == true
        end
        return false
    end
    local function shouldIgnore(p)
        if State.IgnoreCrawl and getProp(p, "crawling") then return true end
        if State.IgnoreKnock and getProp(p, "knocked")  then return true end
        if State.IgnoreGrab  and getProp(p, "grabbed")  then return true end
        return false
    end
    local function isRagdoll()
        local c = LocalPlayer.Character; if not c then return true end
        local h = c:FindFirstChildOfClass("Humanoid"); if not h or h.Health <= 0 then return true end
        local st = h:GetState()
        return st == Enum.HumanoidStateType.Physics or st == Enum.HumanoidStateType.Ragdoll or st == Enum.HumanoidStateType.FallingDown
    end

    -- 追踪线 & 音效
    local TracerFolder = Workspace:FindFirstChild("__MoonTracers") or Instance.new("Folder", Workspace)
    TracerFolder.Name = "__MoonTracers"
    local function createTracer(fromPos, toPos, color, width, duration)
        if not State.TracerEnabled then return end
        local a0 = Instance.new("Attachment", TracerFolder); a0.WorldPosition = fromPos
        local a1 = Instance.new("Attachment", TracerFolder); a1.WorldPosition = toPos
        local beam = Instance.new("Beam", TracerFolder)
        beam.Attachment0, beam.Attachment1 = a0, a1
        beam.Color = ColorSequence.new(color or State.TracerColor)
        beam.Width0, beam.Width1 = width or State.TracerWidth, width or State.TracerWidth
        beam.LightEmission, beam.LightInfluence, beam.FaceCamera = 1, 0, true
        beam.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 0.8)})
        local life = duration or State.TracerDuration
        Debris:AddItem(beam, life); Debris:AddItem(a0, life); Debris:AddItem(a1, life)
    end
    local function playHitSound()
        if not State.HitSoundEnabled then return end
        pcall(function()
            local snd = Instance.new("Sound", SoundService)
            snd.SoundId, snd.Volume = State.HitSoundId, State.HitSoundVolume
            snd:Play(); Debris:AddItem(snd, 2)
        end)
    end

    -- 穿墙解算
    local RayParams = RaycastParams.new()
    RayParams.FilterType, RayParams.IgnoreWater = Enum.RaycastFilterType.Exclude, true
    local function Resolve(fromPos, toPos, spread, radius)
        local dir, dist = toPos - fromPos, (toPos - fromPos).Magnitude
        if dist < 0.1 then return fromPos, toPos, true end
        RayParams.FilterDescendantsInstances = { LocalPlayer.Character }
        local hit = Workspace:Raycast(fromPos, dir, RayParams)
        if not hit or (hit.Position - toPos).Magnitude <= radius then return fromPos, toPos, true end
        local unit = dir.Unit
        local up = unit:Cross(math.abs(unit.Y) < 0.9 and Vector3.new(0,1,0) or Vector3.new(1,0,0)).Unit
        local right = unit:Cross(up).Unit
        for _, off in ipairs({ right, -right, -up, up }) do
            local testPos = fromPos + off * spread
            local testHit = Workspace:Raycast(testPos, toPos - testPos, RayParams)
            if not testHit or (testHit.Position - toPos).Magnitude <= radius then return testPos, toPos, true end
        end
        return nil, nil, false
    end

    -- 找敌人 & 开火
    local function getClosestEnemy()
        local _, myHRP = getMyChar(); if not myHRP then return nil, nil end
        local best, bestDist, bestHead = nil, math.huge, nil
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and not isTeam(p) and isAlive(p) and not shouldIgnore(p) then
                local c = p.Character
                local hrp, head = c and c:FindFirstChild("HumanoidRootPart"), c and c:FindFirstChild("Head")
                if hrp and head then
                    local d = (hrp.Position - myHRP.Position).Magnitude
                    if d <= State.MaxDistance and d < bestDist then bestDist, best, bestHead = d, p, head end
                end
            end
        end
        return best, bestHead
    end

    local RELOAD_RETRY_INTERVAL, AMMO_STUCK_THRESHOLD = 0.6, 1.5
    local function fireAt(target, targetHead)
        if isRagdoll() then return end
        local now = tick(); if now - State.LastFire < State.FireRate then return end
        local _, myHRP, myHead = getMyChar(); if not myHRP or not myHead then return end
        local ok, tool = pcall(ClientTools.GetLocalEquippedTool)
        if not ok or not tool or not tool.toolState then return end
        local ts = tool.toolState
        if State.LastToolId ~= tool.toolId then
            State.LastToolId, State.ReloadRetryAt, State.LastAmmo, State.LastAmmoChangeAt = tool.toolId, 0, nil, now
        end
        local curAmmo = tonumber(ts.ammo)
        if curAmmo ~= State.LastAmmo then State.LastAmmo, State.LastAmmoChangeAt = curAmmo, now
        elseif now - State.LastAmmoChangeAt > AMMO_STUCK_THRESHOLD then
            State.LastAmmoChangeAt = now
            if now >= State.ReloadRetryAt then
                State.ReloadRetryAt = now + RELOAD_RETRY_INTERVAL
                pcall(fireServer, "reload", tool.toolId); pcall(fireServer, "chamber", tool.toolId)
            end
            return
        end
        if curAmmo == nil or ts.totalAmmo == nil then return end
        if curAmmo <= 0 then
            if now >= State.ReloadRetryAt then
                State.ReloadRetryAt = now + RELOAD_RETRY_INTERVAL
                if (tonumber(ts.totalAmmo) or 0) > 0 then pcall(fireServer, "reload", tool.toolId); pcall(fireServer, "chamber", tool.toolId) end
            end
            return
        end
        if ts.reloading == true then return end
        local resolvedOrigin, resolvedTarget, okR = Resolve(myHead.Position, targetHead.Position, State.WallSpread, targetHead.Size.Magnitude)
        if not okR then return end
        local bulletId = nuid()
        local shootCF = MathUtil.CompressCFrame(CFrame.new(resolvedOrigin, resolvedTarget))
        fireServer("shoot", tool.toolId, shootCF, { { bulletId, shootCF } })
        local dir = resolvedTarget - resolvedOrigin
        local unit = dir.Magnitude > 0.001 and dir.Unit or myHRP.CFrame.LookVector
        local muzzle = tool.projectile and tool.projectile.muzzleVelocity
        local speed = type(muzzle) == "number" and muzzle > 0 and muzzle / 0.28 or 1600
        fireServer("registerProjectileHits", bulletId, tool.toolId, {
            { massLimit = 5, hit = targetHead, position = resolvedTarget, normal = -unit, material = targetHead.Material or Enum.Material.Plastic,
              distance = dir.Magnitude, collisionPoint = resolvedTarget, direction = unit, speed = speed,
              source = { sourceType = "Bullet", sourceId = bulletId, sourceToolId = tool.toolId, sourcePlayerId = userId } },
        })
        playHitSound()
        createTracer(resolvedOrigin, resolvedTarget, State.TracerColor, State.TracerWidth, State.TracerDuration)
        State.LastFire = now
    end

    -- 主循环启动
    if not State.Running then
        State.Running = true
        State.LoopConn = RunService.Heartbeat:Connect(function()
            if State.Ragebot then
                local target, head = getClosestEnemy()
                if target and head then pcall(fireAt, target, head) end
            end
        end)
    end

    -- ═══════ 控件构建（挂载到你传入的 Tab 上）═══════
    local Left  = Tab:AddLeftGroupbox("战斗")
    local Right = Tab:AddRightGroupbox("参数")

    Left:AddToggle("Ragebot", { Text = "开启愤怒机器人", Default = false, Callback = function(v) State.Ragebot = v end })
    Left:AddToggle("Wallbang", { Text = "穿墙射击", Default = true, Callback = function(v) State.Wallbang = v end })
    Left:AddToggle("TeamCheck", { Text = "忽略队友", Default = true, Callback = function(v) State.TeamCheck = v end })
    Left:AddToggle("IgnoreStates", { Text = "忽略倒地 / 被击倒 / 被抓", Default = true, Callback = function(v) State.IgnoreCrawl, State.IgnoreKnock, State.IgnoreGrab = v, v, v end })

    Right:AddSlider("MaxDistance", { Text = "最大攻击距离", Default = 500, Min = 50, Max = 5000, Rounding = 0, Suffix = " 米", Callback = function(v) State.MaxDistance = v end })
    Right:AddSlider("FireRate", { Text = "射击间隔（秒）", Default = 0.05, Min = 0.02, Max = 0.5, Rounding = 2, Callback = function(v) State.FireRate = v end })
    Right:AddSlider("WallSpread", { Text = "穿墙偏移距离", Default = 30, Min = 5, Max = 100, Rounding = 0, Callback = function(v) State.WallSpread = v end })

    local SoundBox = Tab:AddLeftGroupbox("命中音效")
    SoundBox:AddToggle("HitSound", { Text = "命中音效", Default = true, Callback = function(v) State.HitSoundEnabled = v end })
    SoundBox:AddSlider("HitSoundVol", { Text = "音效音量", Default = 0.5, Min = 0, Max = 1, Rounding = 2, Callback = function(v) State.HitSoundVolume = v end })
    SoundBox:AddDropdown("HitSoundSelect", { Text = "音效选择", Values = { "叮叮叮（经典）", "Neverlose", "Gamesense", "Fatality", "Minecraft" }, Default = 1, Multi = false,
        Callback = function(v)
            local map = { [2] = "rbxassetid://6607204501", }
            State.HitSoundId = map[v] or map[2]
        end })

    local TracerBox = Tab:AddRightGroupbox("弹道追踪线")
    TracerBox:AddToggle("TracerEnabled", { Text = "显示弹道追踪线", Default = true, Callback = function(v) State.TracerEnabled = v end })
    TracerBox:AddSlider("TracerWidth", { Text = "追踪线宽度", Default = 0.25, Min = 0.05, Max = 1, Rounding = 2, Callback = function(v) State.TracerWidth = v end })
    TracerBox:AddSlider("TracerDuration", { Text = "追踪线持续时间", Default = 1, Min = 0.2, Max = 5, Rounding = 1, Suffix = " 秒", Callback = function(v) State.TracerDuration = v end })
    TracerBox:AddDropdown("TracerColor", { Text = "追踪线颜色", Values = { "红色",  }, Default = 1, Multi = false,
        Callback = function(v)
            local map = { [1] = Color3.fromRGB(255, 80, 80), }
            State.TracerColor = map[v] or map[1]
        end })
end

-- ═══════════ 调用它，挂载到你的 jqr 标签 ═══════════
SetupRagebot(Tabs.jqr)
--******-------
local jxGroup = Tabs.jx:AddLeftGroupbox("远程击杀与雷达")

jxGroup:AddButton({
    Text = "远程传送击杀",
    Tooltip = "加载远程传送击杀脚本",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/%E8%BF%9C%E7%A8%8B%E5%87%BB%E6%9D%80.lua"))()
    end,
})

jxGroup:AddButton({
    Text = "开启雷达扫描⚠️",
    Tooltip = "加载雷达扫描脚本",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/%E9%9B%B7%E8%BE%BE%E6%89%AB%E6%8F%8F.lua"))()
    end,
})

-- ==================== 远程传送玩家 ====================
local selectedPlayerName = "无"
local isLoopTeleport = false

local function getHRP(plr)
    if plr and plr.Character then
        return plr.Character:FindFirstChild("HumanoidRootPart")
    end
    return nil
end

local function getPlayerNames()
    local names = {"无"}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            table.insert(names, plr.Name)
        end
    end
    return names
end

local function teleportTargetToMe()
    if selectedPlayerName == "无" then return end
    local localHRP = getHRP(LocalPlayer)
    if not localHRP then return end
    local targetPlr = Players:FindFirstChild(selectedPlayerName)
    local targetHRP = getHRP(targetPlr)
    if not targetHRP then return end
    local frontPosition = localHRP.CFrame * CFrame.new(0, 0, -4)
    pcall(function()
        targetHRP.CFrame = frontPosition
    end)
end

local tpGroup = Tabs.jx:AddRightGroupbox("玩家传送")

local PlayerDropdown = tpGroup:AddDropdown("TP_Dropdown", {
    Text = "选择服务器玩家",
    Values = getPlayerNames(),
    Default = 1,
    Multi = false,
    Callback = function(option)
        selectedPlayerName = option
    end,
})

tpGroup:AddButton({
    Text = "刷新玩家列表",
    Func = function()
        pcall(function() PlayerDropdown:SetValues(getPlayerNames()) end)
        Library:Notify({Title = "刷新成功", Text = "玩家列表已更新", Duration = 3})
    end,
})

local searchKeyword = ""
tpGroup:AddInput("TP_Search", {
    Text = "搜索玩家",
    Default = "",
    Numeric = false,
    Finished = true,
    Placeholder = "输入名字...",
    Callback = function(text)
        searchKeyword = text
    end,
})

tpGroup:AddButton({
    Text = "🔍 搜索并选中",
    Func = function()
        pcall(function() PlayerDropdown:SetValues(getPlayerNames()) end)
        if searchKeyword == "" then
            Library:Notify({Title = "提示", Text = "请先输入玩家名字", Duration = 3})
            return
        end
        local lowerKeyword = string.lower(searchKeyword)
        local found = nil
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and string.find(string.lower(plr.Name), lowerKeyword, 1, true) then
                found = plr.Name
                break
            end
        end
        if found then
            selectedPlayerName = found
            Library:Notify({Title = "搜索成功", Text = "已选中: " .. found, Duration = 3})
        else
            Library:Notify({Title = "搜索失败", Text = "没找到包含「" .. searchKeyword .. "」的玩家", Duration = 3})
        end
    end,
})

tpGroup:AddButton({
    Text = "🚀 传送到我面前",
    Func = function()
        if selectedPlayerName == "无" then
            Library:Notify({Title = "提示", Text = "请先选择玩家", Duration = 3})
            return
        end
        teleportTargetToMe()
    end,
})

tpGroup:AddToggle("TP_Loop", {
    Text = "循环传送 (锁死前方)",
    Default = false,
    Callback = function(state)
        isLoopTeleport = state
    end,
})

RunService.RenderStepped:Connect(function()
    if isLoopTeleport and selectedPlayerName ~= "无" then
        teleportTargetToMe()
    end
end)

Players.PlayerRemoving:Connect(function(plr)
    if plr.Name == selectedPlayerName then
        selectedPlayerName = "无"
    end
    pcall(function()
        PlayerDropdown:SetValues(getPlayerNames())
    end)
end)
-- ==================== 光环设置页 ====================
local Network = game:GetService("ReplicatedStorage").Shared.Core.Network
local Event87   = Network:GetChildren()[87]
local Event200  = Network:GetChildren()[200]
local Event156  = Network:GetChildren()[156]
local Event39   = Network:GetChildren()[39]        

-- 配置
local AuraConfig = {
    E87_Enabled = false,
    E87_Interval = 0.1,

    E200_Enabled = false,
    E200_Interval = 0.1,

    Arrest_Enabled = false,
    Arrest_Interval = 0.5,

    E39_Enabled = false,        
    E39_Interval = 0.1,
}

-- 找最近敌人（无距离限制，跳过队友）
local function findNearestEnemy()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    local nearest, nearestDist = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            local tHrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hum and hum.Health > 0 and tHrp then
                local skip = false
                if p.Team and LocalPlayer.Team and p.Team == LocalPlayer.Team then
                    skip = true
                end
                if not skip then
                    local dist = (tHrp.Position - hrp.Position).Magnitude
                    if dist < nearestDist then
                        nearest = p
                        nearestDist = dist
                    end
                end
            end
        end
    end
    return nearest
end

-- [87] 循环
task.spawn(function()
    while true do
        if AuraConfig.E87_Enabled then
            local enemy = findNearestEnemy()
            if enemy then
                pcall(function()
                    Event87:FireServer(enemy.UserId)
                end)
            end
        end
        task.wait(AuraConfig.E87_Interval)
    end
end)

-- [200] 循环
task.spawn(function()
    while true do
        if AuraConfig.E200_Enabled then
            local enemy = findNearestEnemy()
            if enemy then
                pcall(function()
                    Event200:FireServer(enemy.UserId)
                end)
            end
        end
        task.wait(AuraConfig.E200_Interval)
    end
end)

-- [156] 逮捕光环
local lastArrest = 0
RunService.Heartbeat:Connect(function()
    if not AuraConfig.Arrest_Enabled then return end
    local now = tick()
    if now - lastArrest < AuraConfig.Arrest_Interval then return end

    local enemy = findNearestEnemy()
    if enemy then
        pcall(function()
            Event156:FireServer(enemy.UserId)
        end)
        lastArrest = now
    end
end)

-- [39] 光环
local lastAura39 = 0
RunService.Heartbeat:Connect(function()
    if not AuraConfig.E39_Enabled then return end
    local now = tick()
    if now - lastAura39 < AuraConfig.E39_Interval then return end

    local enemy = findNearestEnemy()
    if enemy then
        pcall(function()
            Event39:FireServer(enemy.UserId)
        end)
        lastAura39 = now
    end
end)
-- ==================== 光环设置 UI（Obsidian 风格） ====================
local ghLeft  = Tabs.gh:AddLeftGroupbox("救援事件")
local ghMid   = Tabs.gh:AddLeftGroupbox("踩踏事件")
local ghRight = Tabs.gh:AddRightGroupbox("逮捕光环")

-- [87]
ghLeft:AddToggle("Aura87_Toggle", {
    Text = "启用救援",
    Default = false,
    Callback = function(v) AuraConfig.E87_Enabled = v end,
})

ghLeft:AddSlider("Aura87_Interval", {
    Text = "救援间隔",
    Default = 0.1, Min = 0.05, Max = 2, Rounding = 2,
    Suffix = "s",
    Callback = function(v) AuraConfig.E87_Interval = v end,
})

-- [200]
ghMid:AddToggle("Aura200_Toggle", {
    Text = "启用踩踏",
    Default = false,
    Callback = function(v) AuraConfig.E200_Enabled = v end,
})

ghMid:AddSlider("Aura200_Interval", {
    Text = "踩踏间隔",
    Default = 0.1, Min = 0.05, Max = 2, Rounding = 2,
    Suffix = "s",
    Callback = function(v) AuraConfig.E200_Interval = v end,
})

-- 逮捕光环
ghRight:AddToggle("Arrest_Toggle", {
    Text = "启用逮捕光环",
    Default = false,
    Callback = function(v) AuraConfig.Arrest_Enabled = v end,
})

ghRight:AddSlider("Arrest_Interval", {
    Text = "逮捕间隔",
    Default = 0.5, Min = 0.1, Max = 3, Rounding = 1,
    Suffix = "s",
    Callback = function(v) AuraConfig.Arrest_Interval = v end,
})
-- [39] 光环控件
local ghRight2 = Tabs.gh:AddRightGroupbox("抓取光环")

ghRight2:AddToggle("Aura39_Toggle", {
    Text = "启用抓取光环",
    Default = false,
    Callback = function(v) AuraConfig.E39_Enabled = v end,
})

ghRight2:AddSlider("Aura39_Interval", {
    Text = "抓取光环间隔",
    Default = 0.1, Min = 0.05, Max = 2, Rounding = 2,
    Suffix = "s",
    Callback = function(v) AuraConfig.E39_Interval = v end,
})
-- ==================== 瞄准页 ====================
local AimConfig = {
    Enabled = false, BulletTrack = false, FOV = 200, Smoothness = 0.15,
    Prediction = 0.12, BulletSpeed = 1500, BulletDrop = 0, WallCheck = true,
    ShowFOV = false, ShowTracer = true, AimPart = "Head", TeamCheck = true, JumpPrediction = true,
}

local aimFOVCircle = Drawing.new("Circle")
aimFOVCircle.Visible = false
aimFOVCircle.Color = Color3.fromRGB(255, 50, 50)
aimFOVCircle.Thickness = 1.5
aimFOVCircle.Filled = false
aimFOVCircle.Transparency = 0.4
aimFOVCircle.NumSides = 64
aimFOVCircle.Radius = AimConfig.FOV
aimFOVCircle.Position = Camera.ViewportSize / 2

local aimTracer = Drawing.new("Line")
aimTracer.Visible = false
aimTracer.Color = Color3.fromRGB(255, 50, 50)
aimTracer.Thickness = 1.5
aimTracer.Transparency = 0.4
aimTracer.From = Camera.ViewportSize / 2
aimTracer.To = Camera.ViewportSize / 2

local aimTargetPart = nil
local mainConn = nil

local function findClosestPlayer()
    local center = Camera.ViewportSize / 2
    local best, bestDist = nil, AimConfig.FOV
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            local hrpX = player.Character:FindFirstChild("HumanoidRootPart")
            if humanoid and hrpX and humanoid.Health > 0 then
                if not (AimConfig.TeamCheck and player.Team and player.Team == LocalPlayer.Team) then
                    local part = player.Character:FindFirstChild(AimConfig.AimPart)
                        or player.Character:FindFirstChild("Head") or hrpX
                    if part then
                        local sp, vis = Camera:WorldToViewportPoint(part.Position)
                        if vis and sp.Z < 1000 then
                            local sd = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                            if sd < bestDist then best, bestDist = part, sd end
                        end
                    end
                end
            end
        end
    end
    return best
end

local function isWallHit(part)
    if not AimConfig.WallCheck then return false end
    local origin = Camera.CFrame.Position
    local rayP = RaycastParams.new()
    rayP.FilterType = Enum.RaycastFilterType.Exclude
    rayP.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
    local result = workspace:Raycast(origin, part.Position - origin, rayP)
    if result and not result.Instance:IsDescendantOf(part.Parent) then return true end
    return false
end

local function doCameraAim()
    if not aimTargetPart or not aimTargetPart.Parent then return end
    local humX = aimTargetPart.Parent:FindFirstChildOfClass("Humanoid")
    if not humX or humX.Health <= 0 then return end
    if isWallHit(aimTargetPart) then return end
    local dist = (aimTargetPart.Position - Camera.CFrame.Position).Magnitude
    local time = dist / math.max(AimConfig.BulletSpeed, 100)
    local vel = Vector3.zero
    local tHrp = aimTargetPart.Parent:FindFirstChild("HumanoidRootPart")
    if tHrp then vel = tHrp.AssemblyLinearVelocity end
    local predictPos = aimTargetPart.Position + vel * AimConfig.Prediction
    local dropOffset = Vector3.new(0, -AimConfig.BulletDrop * time * time, 0)
    local jumpOff = Vector3.zero
    if AimConfig.JumpPrediction and tHrp and tHrp.AssemblyLinearVelocity.Y > 10 then
        jumpOff = Vector3.new(0, tHrp.AssemblyLinearVelocity.Y * AimConfig.Prediction * 0.5, 0)
    end
    local targetPos = predictPos + dropOffset + jumpOff
    local targetCF = CFrame.new(Camera.CFrame.Position, targetPos)
    if AimConfig.Smoothness >= 1 then Camera.CFrame = targetCF
    else Camera.CFrame = Camera.CFrame:Lerp(targetCF, AimConfig.Smoothness) end
end

local botGroup = Tabs.bot:AddLeftGroupbox("自瞄")

botGroup:AddToggle("Aim_Enable", {
    Text = "🎯 自瞄总开关",
    Default = false,
    Tooltip = "暴力Camera自瞄，直接控制视角锁定目标",
    Callback = function(state)
        AimConfig.Enabled = state
        if state then
            if not mainConn then
                mainConn = RunService.RenderStepped:Connect(function()
                    if not AimConfig.Enabled then
                        aimTargetPart = nil
                        aimFOVCircle.Visible = false
                        aimTracer.Visible = false
                        return
                    end
                    aimFOVCircle.Position = Camera.ViewportSize / 2
                    aimFOVCircle.Radius = AimConfig.FOV
                    aimFOVCircle.Visible = AimConfig.ShowFOV
                    aimTargetPart = findClosestPlayer()
                    doCameraAim()
                    if aimTargetPart and aimTargetPart.Parent then
                        local sp, vis = Camera:WorldToViewportPoint(aimTargetPart.Position)
                        if vis then
                            aimTracer.Visible = AimConfig.ShowTracer
                            aimTracer.From = Camera.ViewportSize / 2
                            aimTracer.To = Vector2.new(sp.X, sp.Y)
                        else aimTracer.Visible = false end
                    else aimTracer.Visible = false end
                end)
            end
        else
            if mainConn then mainConn:Disconnect() mainConn = nil end
            aimTargetPart = nil
            aimFOVCircle.Visible = false
            aimTracer.Visible = false
        end
    end,
})

botGroup:AddSlider("Aim_FOV", {
    Text = "🎯 自瞄FOV范围",
    Default = 200, Min = 20, Max = 1000, Rounding = 0,
    Callback = function(v) AimConfig.FOV = v; aimFOVCircle.Radius = v end,
})

botGroup:AddSlider("Aim_Smooth", {
    Text = "🔘 平滑系数",
    Default = 0.15, Min = 0.01, Max = 1, Rounding = 2,
    Callback = function(v) AimConfig.Smoothness = v end,
})

botGroup:AddSlider("Aim_Predict", {
    Text = "⚡ 预判强度",
    Default = 0.12, Min = 0, Max = 1, Rounding = 2,
    Callback = function(v) AimConfig.Prediction = v end,
})

botGroup:AddSlider("Aim_BulletSpeed", {
    Text = "🔫 子弹速度",
    Default = 1500, Min = 100, Max = 5000, Rounding = 0,
    Callback = function(v) AimConfig.BulletSpeed = v end,
})

botGroup:AddSlider("Aim_BulletDrop", {
    Text = "📉 弹道下坠补偿",
    Default = 0, Min = 0, Max = 200, Rounding = 0,
    Callback = function(v) AimConfig.BulletDrop = v end,
})

botGroup:AddDropdown("Aim_Part", {
    Text = "🎯 瞄准部位",
    Values = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso"},
    Default = 1,
    Multi = false,
    Callback = function(option) AimConfig.AimPart = option end,
})

botGroup:AddToggle("Aim_Wall", {
    Text = "🧱 掩体判断",
    Default = true,
    Callback = function(state) AimConfig.WallCheck = state end,
})

botGroup:AddToggle("Aim_ShowFOV", {
    Text = "⭕ 显示FOV圆圈",
    Default = false,
    Callback = function(state) AimConfig.ShowFOV = state end,
})

botGroup:AddToggle("Aim_ShowTracer", {
    Text = "📏 显示自瞄射线",
    Default = true,
    Callback = function(state) AimConfig.ShowTracer = state end,
})

botGroup:AddToggle("Aim_Team", {
    Text = "👥 区分队友",
    Default = true,
    Callback = function(state) AimConfig.TeamCheck = state end,
})

botGroup:AddToggle("Aim_Jump", {
    Text = "🦘 跳跃预判",
    Default = true,
    Callback = function(state) AimConfig.JumpPrediction = state end,
})

-- ==================== 子弹追踪 ====================
local btHbSize = 8
local btHbConn = nil
local function btExpandPlayer(player)
    if player == LocalPlayer then return end
    if AimConfig.TeamCheck and player.Team and player.Team == LocalPlayer.Team then return end
    local char = player.Character; if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return end
    local hrpX = char:FindFirstChild("HumanoidRootPart"); if not hrpX then return end
    local size = math.clamp(btHbSize, 0, 100)
    pcall(function()
        hrpX.Size = Vector3.new(size, size, size)
        hrpX.Transparency = 0.85
        hrpX.Color = Color3.fromRGB(190, 190, 190)
        hrpX.Material = Enum.Material.Neon
        hrpX.CanCollide = false
    end)
end

local function btResetPlayer(player)
    local char = player.Character; if not char then return end
    local hrpX = char:FindFirstChild("HumanoidRootPart"); if not hrpX then return end
    pcall(function()
        hrpX.Size = Vector3.new(2, 2, 1); hrpX.Transparency = 0
        hrpX.Color = Color3.fromRGB(163,162,165); hrpX.Material = Enum.Material.Plastic
        hrpX.CanCollide = true
    end)
end

local btGroup = Tabs.bot:AddRightGroupbox("子弹追踪")

btGroup:AddToggle("BT_Enable", {
    Text = "💣 子弹追踪总开关",
    Default = false,
    Tooltip = "扩大敌人碰撞箱",
    Callback = function(state)
        AimConfig.BulletTrack = state
        if state then
            if not btHbConn then
                btHbConn = RunService.Heartbeat:Connect(function()
                    if AimConfig.BulletTrack then
                        for _, p in ipairs(Players:GetPlayers()) do btExpandPlayer(p) end
                    end
                end)
            end
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    player.CharacterAdded:Connect(function()
                        task.wait(1)
                        if AimConfig.BulletTrack then btExpandPlayer(player) end
                    end)
                end
            end
        else
            if btHbConn then btHbConn:Disconnect() btHbConn = nil end
            for _, p in ipairs(Players:GetPlayers()) do btResetPlayer(p) end
        end
    end,
})

btGroup:AddSlider("BT_Size", {
    Text = "📦 判定箱大小",
    Default = 8, Min = 0, Max = 100, Rounding = 0,
    Callback = function(value) btHbSize = value end,
})
-- ==================== zj 标签：子追静默瞄准（Obsidian 格式） ====================

local SilentAimSettings = {
    Enabled = false,
    TeamCheck = false,
    VisibleCheck = false,
    TargetPart = "HumanoidRootPart",
    FOVRadius = 130,
    FOVVisible = false,
    ShowSilentAimTarget = false,
    HitChance = 100,
    FixedFOV = true,
    TargetIndicatorRadius = 20,
    MaxDistance = 500,
    PriorityMode = "准星最近",
    Wallbang = false,
    ShowTracer = false,
    TracerFromBottom = true,
    TracerThickness = 1,
    TracerTransparency = 0.3,
}

local sa_currentTargetPart = nil
local sa_lastTargetCharacter = nil

-- 目标指示器（红色）
local sa_target_circle = Drawing.new("Circle")
sa_target_circle.Visible = false
sa_target_circle.Thickness = 2
sa_target_circle.Filled = false
sa_target_circle.Color = Color3.fromRGB(255, 0, 0)

-- 瞄准射线（红色）
local sa_tracer = Drawing.new("Line")
sa_tracer.Visible = false
sa_tracer.Thickness = 1
sa_tracer.Transparency = 0.3
sa_tracer.Color = Color3.fromRGB(255, 0, 0)
sa_tracer.ZIndex = 999

-- FOV 圈（蓝色）
local sa_FOVGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
sa_FOVGui.Name = "SA_FOVGui"
sa_FOVGui.ResetOnSpawn = false
sa_FOVGui.IgnoreGuiInset = true
sa_FOVGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sa_FOVGui.Enabled = false

local sa_FOVFrame = Instance.new("Frame", sa_FOVGui)
sa_FOVFrame.AnchorPoint = Vector2.new(0.5, 0.5)
sa_FOVFrame.Position = UDim2.fromScale(0.5, 0.5)
sa_FOVFrame.BackgroundTransparency = 1
sa_FOVFrame.Size = UDim2.fromOffset(260, 260)

local sa_FOVStroke = Instance.new("UIStroke", sa_FOVFrame)
sa_FOVStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
sa_FOVStroke.Thickness = 1
sa_FOVStroke.Transparency = 0.5
sa_FOVStroke.Color = Color3.fromRGB(54, 57, 241)

local sa_FOVCorner = Instance.new("UICorner", sa_FOVFrame)
sa_FOVCorner.CornerRadius = UDim.new(1, 0)

-- 工具函数
local function SA_getScreenPos(v)
    local p, on = Camera:WorldToViewportPoint(v)
    return Vector2.new(p.X, p.Y), on
end

local function SA_isVisible(part, origin)
    if not part then return false end
    local char = LocalPlayer.Character
    if not char then return false end
    local o = origin or Camera.CFrame.Position
    local dir = part.Position - o
    local rp = RaycastParams.new()
    rp.FilterType = Enum.RaycastFilterType.Exclude
    rp.FilterDescendantsInstances = {char, part.Parent}
    return not workspace:Raycast(o, dir.Unit * dir.Magnitude, rp)
end

local function SA_getClosestPlayer()
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil end
    local myRoot = myChar.HumanoidRootPart
    local aimPoint = SilentAimSettings.FixedFOV and (Camera.ViewportSize / 2) or UserInputService:GetMouseLocation()
    local list = {}

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and not (SilentAimSettings.TeamCheck and p.Team == LocalPlayer.Team) then
            local c = p.Character
            local h = c and c:FindFirstChildOfClass("Humanoid")
            if c and h and h.Health > 0 then
                local part = c:FindFirstChild(SilentAimSettings.TargetPart) or c:FindFirstChild("HumanoidRootPart")
                if part then
                    if not (SilentAimSettings.VisibleCheck and not SA_isVisible(part, myChar.Head.Position)) then
                        local dist = (myRoot.Position - part.Position).Magnitude
                        if dist <= SilentAimSettings.MaxDistance then
                            local sp, on = SA_getScreenPos(part.Position)
                            if on then
                                local fovDist = (aimPoint - sp).Magnitude
                                if fovDist <= SilentAimSettings.FOVRadius then
                                    table.insert(list, {char = c, fov = fovDist, dist = dist, health = h.Health})
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    if #list == 0 then return nil end
    table.sort(list, function(a, b)
        if SilentAimSettings.PriorityMode == "最低血量" then return a.health < b.health
        elseif SilentAimSettings.PriorityMode == "距离最近" then return a.dist < b.dist
        else return a.fov < b.fov end
    end)
    return list[1].char
end

-- ═══════════════════════════════════════════════════
-- Obsidian UI：全部挂在 Tabs.zj
-- ═══════════════════════════════════════════════════
local zjLeft   = Tabs.zj:AddLeftGroupbox("主设置")
local zjRight  = Tabs.zj:AddRightGroupbox("目标")
local zjFov    = Tabs.zj:AddLeftGroupbox("FOV 圈")
local zjInd    = Tabs.zj:AddRightGroupbox("目标指示器")
local zjTracer = Tabs.zj:AddRightGroupbox("瞄准射线")

-- 主设置
zjLeft:AddToggle("SA_Enabled", {
    Text = "启用静默瞄准",
    Default = false,
    Tooltip = "开启后子弹自动打向敌人",
}):OnChanged(function(v)
    SilentAimSettings.Enabled = v
end)

zjLeft:AddToggle("SA_TeamCheck", {
    Text = "队伍检查",
    Default = false,
}):OnChanged(function(v)
    SilentAimSettings.TeamCheck = v
end)

zjLeft:AddToggle("SA_VisibleCheck", {
    Text = "可见性检查",
    Default = false,
}):OnChanged(function(v)
    SilentAimSettings.VisibleCheck = v
end)

zjLeft:AddToggle("SA_Wallbang", {
    Text = "穿墙",
    Default = false,
}):OnChanged(function(v)
    SilentAimSettings.Wallbang = v
end)

zjLeft:AddSlider("SA_HitChance", {
    Text = "命中率",
    Default = 100, Min = 0, Max = 100, Rounding = 1,
    Suffix = "%",
}):OnChanged(function(v)
    SilentAimSettings.HitChance = v
end)

-- 目标
zjRight:AddDropdown("SA_TargetPart", {
    Text = "目标部位",
    Values = { "Head", "HumanoidRootPart" },
    Default = "HumanoidRootPart",
}):OnChanged(function(v)
    SilentAimSettings.TargetPart = v
end)

zjRight:AddDropdown("SA_Priority", {
    Text = "优先模式",
    Values = { "准星最近", "距离最近", "最低血量" },
    Default = "准星最近",
}):OnChanged(function(v)
    SilentAimSettings.PriorityMode = v
end)

zjRight:AddSlider("SA_MaxDist", {
    Text = "最大距离",
    Default = 500, Min = 10, Max = 2000, Rounding = 0,
    Suffix = " studs",
}):OnChanged(function(v)
    SilentAimSettings.MaxDistance = v
end)

-- FOV 圈
zjFov:AddToggle("SA_FOVVisible", {
    Text = "显示 FOV 圈",
    Default = false,
}):OnChanged(function(v)
    sa_FOVGui.Enabled = v
end)

zjFov:AddSlider("SA_FOVRadius", {
    Text = "FOV 圈半径",
    Default = 130, Min = 10, Max = 1000, Rounding = 0,
}):OnChanged(function(v)
    sa_FOVFrame.Size = UDim2.fromOffset(v * 2, v * 2)
    SilentAimSettings.FOVRadius = v
end)

zjFov:AddToggle("SA_FixedFOV", {
    Text = "固定 FOV（屏幕中心）",
    Default = true,
}):OnChanged(function(v)
    SilentAimSettings.FixedFOV = v
end)

-- 目标指示器
zjInd:AddToggle("SA_ShowTarget", {
    Text = "显示指示器",
    Default = false,
}):OnChanged(function(v)
    SilentAimSettings.ShowSilentAimTarget = v
end)

zjInd:AddSlider("SA_TargetRadius", {
    Text = "指示器大小",
    Default = 20, Min = 5, Max = 50, Rounding = 0,
}):OnChanged(function(v)
    SilentAimSettings.TargetIndicatorRadius = v
end)

-- 瞄准射线
zjTracer:AddToggle("SA_ShowTracer", {
    Text = "显示瞄准射线",
    Default = false,
}):OnChanged(function(v)
    SilentAimSettings.ShowTracer = v
end)

zjTracer:AddToggle("SA_TracerBottom", {
    Text = "从屏幕底部发射",
    Default = true,
}):OnChanged(function(v)
    SilentAimSettings.TracerFromBottom = v
end)

zjTracer:AddSlider("SA_TracerThick", {
    Text = "射线粗细",
    Default = 1, Min = 1, Max = 10, Rounding = 0,
}):OnChanged(function(v)
    SilentAimSettings.TracerThickness = v
    sa_tracer.Thickness = v
end)

zjTracer:AddSlider("SA_TracerAlpha", {
    Text = "射线透明度",
    Default = 0.3, Min = 0, Max = 1, Rounding = 2,
}):OnChanged(function(v)
    SilentAimSettings.TracerTransparency = v
    sa_tracer.Transparency = v
end)

-- ═══════════════════════════════════════════════════
-- 主循环
-- ═══════════════════════════════════════════════════
RunService.RenderStepped:Connect(function()
    sa_currentTargetPart = nil
    local target = nil

    if SilentAimSettings.Enabled then
        target = SA_getClosestPlayer()
    end

    sa_lastTargetCharacter = target

    if target then
        local h = target:FindFirstChildOfClass("Humanoid")
        if h and h.Health > 0 then
            sa_currentTargetPart = target:FindFirstChild(SilentAimSettings.TargetPart) or target:FindFirstChild("HumanoidRootPart")
        end
    end

    -- 目标指示器
    if sa_target_circle then
        sa_target_circle.Visible = false
        if sa_currentTargetPart and SilentAimSettings.ShowSilentAimTarget then
            local sp, on = SA_getScreenPos(sa_currentTargetPart.Position)
            if on then
                sa_target_circle.Visible = true
                sa_target_circle.Position = sp
                sa_target_circle.Radius = SilentAimSettings.TargetIndicatorRadius
            end
        end
    end

    -- 瞄准射线
    sa_tracer.Visible = false
    if sa_currentTargetPart and SilentAimSettings.ShowTracer and SilentAimSettings.Enabled then
        local sp, on = SA_getScreenPos(sa_currentTargetPart.Position)
        if on then
            local fromPos
            if SilentAimSettings.TracerFromBottom then
                fromPos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
            else
                fromPos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            end
            sa_tracer.From = fromPos
            sa_tracer.To = sp
            sa_tracer.Thickness = SilentAimSettings.TracerThickness
            sa_tracer.Transparency = SilentAimSettings.TracerTransparency
            sa_tracer.Visible = true
        end
    end

    -- FOV 圈位置
    if sa_FOVGui.Enabled then
        if SilentAimSettings.FixedFOV then
            sa_FOVFrame.Position = UDim2.fromScale(0.5, 0.5)
        else
            local m = UserInputService:GetMouseLocation()
            sa_FOVFrame.Position = UDim2.fromOffset(m.X, m.Y)
        end
    end
end)

-- Hook Raycast（含相机避障过滤）
local sa_oldNamecall
sa_oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local Method = getnamecallmethod()
    local Args = {...}
    local self = Args[1]
    if SilentAimSettings.Enabled and not checkcaller() and sa_currentTargetPart then
        if math.random() <= SilentAimSettings.HitChance / 100 then
            if Method == "Raycast" then
                if #Args >= 3 and typeof(Args[2]) == "Vector3" and typeof(Args[3]) == "Vector3" then
                    local origin = Args[2]
                    local direction = Args[3]

                    -- 相机避障过滤：direction 长度 < 100 放过
                    if direction.Magnitude < 100 then
                        return sa_oldNamecall(...)
                    end

                    Args[3] = (sa_currentTargetPart.Position - origin).Unit * 1000
                    return sa_oldNamecall(unpack(Args))
                end
            end
        end
    end
    return sa_oldNamecall(...)
end))

print("[静默瞄准] 已加载到 Tabs.zj（Obsidian 格式）")
-- ==================== ESP 页 ====================
ESP_Config = {
    EnableESP = false, ShowBox = true, ShowHealth = true, ShowName = true,
    ShowDistance = true, ShowTracer = false, ShowSkeleton = false, ShowWeapon = false,
    WallHack = false, TeamCheck = false, MaxDrawDistance = 350, BoxThickness = 1,
    TracerThickness = 1, SkeletonThickness = 2,
    EnemyColor = Color3.new(1, 0.3, 0.3), TeammateColor = Color3.new(0.3, 1, 0.3),
    NPCColor = Color3.new(1, 1, 0.2), BoxColor = Color3.new(1, 1, 1),
    TracerColor = Color3.new(1, 0, 0), SkeletonColor = Color3.new(0.2, 0.8, 1),
    HealthBarColor = Color3.new(0, 1, 0),
}

local ESPComponents = {}

local function createESP(player)
    local box = Drawing.new("Square")
    box.Visible = false
    box.Color = ESP_Config.BoxColor
    box.Thickness = ESP_Config.BoxThickness
    box.Filled = false

    local healthBar = Drawing.new("Square")
    healthBar.Visible = false
    healthBar.Filled = true

    local healthBarBackground = Drawing.new("Square")
    healthBarBackground.Visible = false
    healthBarBackground.Color = Color3.new(0, 0, 0)
    healthBarBackground.Transparency = 0.5
    healthBarBackground.Filled = true

    local healthBarBorder = Drawing.new("Square")
    healthBarBorder.Visible = false
    healthBarBorder.Color = Color3.new(1, 1, 1)
    healthBarBorder.Thickness = 1
    healthBarBorder.Filled = false

    local healthText = Drawing.new("Text")
    healthText.Visible = false
    healthText.Size = 14
    healthText.Font = Drawing.Fonts.Monospace
    healthText.Outline = true
    healthText.OutlineColor = Color3.new(0, 0, 0)

    local nameText = Drawing.new("Text")
    nameText.Visible = false
    nameText.Size = 16
    nameText.Font = Drawing.Fonts.Monospace
    nameText.Outline = true
    nameText.OutlineColor = Color3.new(0, 0, 0)

    local distanceText = Drawing.new("Text")
    distanceText.Visible = false
    distanceText.Color = Color3.new(1, 1, 0)
    distanceText.Size = 14
    distanceText.Font = Drawing.Fonts.Monospace
    distanceText.Outline = true
    distanceText.OutlineColor = Color3.new(0, 0, 0)

    local weaponText = Drawing.new("Text")
    weaponText.Visible = false
    weaponText.Color = Color3.new(1, 0.5, 0)
    weaponText.Size = 14
    weaponText.Font = Drawing.Fonts.Monospace
    weaponText.Outline = true
    weaponText.OutlineColor = Color3.new(0, 0, 0)

    local tracer = Drawing.new("Line")
    tracer.Visible = false
    tracer.Color = ESP_Config.TracerColor
    tracer.Thickness = ESP_Config.TracerThickness

    local skeletonLines = {}
    for i = 1, 15 do
        skeletonLines[i] = Drawing.new("Line")
        skeletonLines[i].Visible = false
        skeletonLines[i].Color = ESP_Config.SkeletonColor
        skeletonLines[i].Thickness = ESP_Config.SkeletonThickness
    end

    local skeletonPoints = {}
    skeletonPoints["Head"] = Drawing.new("Circle")
    skeletonPoints["Head"].Visible = false
    skeletonPoints["Head"].Color = Color3.new(1, 0.5, 0)
    skeletonPoints["Head"].Thickness = 2
    skeletonPoints["Head"].Filled = true
    skeletonPoints["Head"].Radius = 4

    local lastHealth, healthChangeTime, smoothHealth = 100, 0, 100

    ESPComponents[player] = {
        box = box, healthBar = healthBar, healthBarBackground = healthBarBackground,
        healthBarBorder = healthBarBorder, healthText = healthText, nameText = nameText,
        distanceText = distanceText, weaponText = weaponText, tracer = tracer,
        skeletonLines = skeletonLines, skeletonPoints = skeletonPoints,
    }

    local function hideAll()
        for _, obj in pairs({box, healthBar, healthBarBackground, healthBarBorder,
            healthText, nameText, distanceText, weaponText, tracer}) do
            obj.Visible = false
        end
        for _, line in pairs(skeletonLines) do line.Visible = false end
        for _, point in pairs(skeletonPoints) do point.Visible = false end
    end

    RunService.RenderStepped:Connect(function()
        if not ESP_Config.EnableESP then hideAll() return end
        if not player.Character
            or not player.Character:FindFirstChild("HumanoidRootPart")
            or not player.Character:FindFirstChild("Humanoid")
            or player == LocalPlayer then hideAll() return end
        if ESP_Config.TeamCheck and player.Team and player.Team == LocalPlayer.Team then hideAll() return end

        local character = player.Character
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChild("Humanoid")
        if not rootPart or not humanoid or humanoid.Health <= 0 then hideAll() return end

        local dist = (rootPart.Position - Camera.CFrame.Position).Magnitude
        if dist > ESP_Config.MaxDrawDistance then hideAll() return end

        local rootPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
        local headPos = Camera:WorldToViewportPoint(rootPart.Position + Vector3.new(0, 3, 0))
        local legPos = Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0))

        local color = ESP_Config.EnemyColor
        if ESP_Config.TeamCheck and player.Team and player.Team == LocalPlayer.Team then
            color = ESP_Config.TeammateColor
        end

        local weaponName = "无武器"
        for _, tool in ipairs(character:GetChildren()) do
            if tool:IsA("Tool") then weaponName = tool.Name break end
        end

        if ESP_Config.ShowBox and onScreen then
            box.Size = Vector2.new(1000 / rootPos.Z, headPos.Y - legPos.Y)
            box.Position = Vector2.new(rootPos.X - box.Size.X / 2, rootPos.Y - box.Size.Y / 2)
            box.Visible = true
            box.Color = ESP_Config.BoxColor
            box.Thickness = ESP_Config.BoxThickness
        else box.Visible = false end

        if ESP_Config.ShowHealth and onScreen then
            local barWidth, barHeight = 50, 5
            local barX = headPos.X - barWidth / 2
            local barY = headPos.Y - 20
            healthBarBackground.Size = Vector2.new(barWidth, barHeight)
            healthBarBackground.Position = Vector2.new(barX, barY)
            healthBarBackground.Visible = true
            healthBarBorder.Size = Vector2.new(barWidth, barHeight)
            healthBarBorder.Position = Vector2.new(barX, barY)
            healthBarBorder.Visible = true
            smoothHealth = smoothHealth + (humanoid.Health - smoothHealth) * 0.1
            local smoothHP = smoothHealth / humanoid.MaxHealth
            healthBar.Size = Vector2.new(barWidth * smoothHP, barHeight)
            healthBar.Position = Vector2.new(barX, barY)
            if smoothHP >= 0.8 then healthBar.Color = Color3.new(0, 1, 0)
            elseif smoothHP >= 0.5 then healthBar.Color = Color3.new(1, 1, 0)
            elseif smoothHP >= 0.2 then healthBar.Color = Color3.new(1, 0.5, 0)
            else healthBar.Color = Color3.new(1, 0, 0) end
            if humanoid.Health ~= lastHealth then healthChangeTime = tick(); lastHealth = humanoid.Health end
            if tick() - healthChangeTime < 0.5 then healthBar.Color = Color3.new(1, 0, 0) end
            healthBar.Visible = true
            healthText.Position = Vector2.new(barX + barWidth + 5, barY - 5)
            healthText.Text = math.floor(humanoid.Health) .. "/" .. math.floor(humanoid.MaxHealth)
            healthText.Color = color
            healthText.Visible = true
        else
            healthBar.Visible = false; healthBarBackground.Visible = false
            healthBarBorder.Visible = false; healthText.Visible = false
        end

        if ESP_Config.ShowName and onScreen then
            nameText.Position = Vector2.new(headPos.X, headPos.Y - 35)
            nameText.Text = player.Name
            nameText.Color = color
            nameText.Visible = true
            if ESP_Config.ShowDistance then
                distanceText.Position = Vector2.new(headPos.X, headPos.Y + 10)
                distanceText.Text = math.floor(dist) .. "m"
                distanceText.Visible = true
            else distanceText.Visible = false end
            if ESP_Config.ShowWeapon then
                weaponText.Position = Vector2.new(headPos.X, headPos.Y - 50)
                weaponText.Text = weaponName
                weaponText.Visible = true
            else weaponText.Visible = false end
        else
            nameText.Visible = false; distanceText.Visible = false; weaponText.Visible = false
        end

        if ESP_Config.ShowTracer then
            local head = character:FindFirstChild("Head")
            if head then
                local hPos, hOnScreen = Camera:WorldToViewportPoint(head.Position)
                if hOnScreen then
                    tracer.From = Vector2.new(Camera.ViewportSize.X / 2, 0)
                    tracer.To = Vector2.new(hPos.X, hPos.Y)
                    tracer.Visible = true
                    tracer.Thickness = ESP_Config.TracerThickness
                    if dist < 20 then tracer.Color = Color3.new(0, 1, 0)
                    elseif dist < 50 then tracer.Color = Color3.new(1, 1, 0)
                    else tracer.Color = ESP_Config.TracerColor end
                else tracer.Visible = false end
            else tracer.Visible = false end
        else tracer.Visible = false end

        if ESP_Config.ShowSkeleton and onScreen then
            local head = character:FindFirstChild("Head")
            local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
            local leftArm = character:FindFirstChild("Left Arm") or character:FindFirstChild("LeftUpperArm")
            local rightArm = character:FindFirstChild("Right Arm") or character:FindFirstChild("RightUpperArm")
            local leftLeg = character:FindFirstChild("Left Leg") or character:FindFirstChild("LeftUpperLeg")
            local rightLeg = character:FindFirstChild("Right Leg") or character:FindFirstChild("RightUpperLeg")
            if head and torso and leftArm and rightArm and leftLeg and rightLeg then
                local hP = Camera:WorldToViewportPoint(head.Position)
                local tP = Camera:WorldToViewportPoint(torso.Position)
                local laP = Camera:WorldToViewportPoint(leftArm.Position)
                local raP = Camera:WorldToViewportPoint(rightArm.Position)
                local llP = Camera:WorldToViewportPoint(leftLeg.Position)
                local rlP = Camera:WorldToViewportPoint(rightLeg.Position)
                skeletonPoints["Head"].Position = Vector2.new(hP.X, hP.Y)
                skeletonPoints["Head"].Visible = true
                local pairsArr = {{hP, tP}, {tP, laP}, {tP, raP}, {tP, llP}, {tP, rlP}}
                for i, p in ipairs(pairsArr) do
                    skeletonLines[i].From = Vector2.new(p[1].X, p[1].Y)
                    skeletonLines[i].To = Vector2.new(p[2].X, p[2].Y)
                    skeletonLines[i].Visible = true
                end
            else
                for _, line in pairs(skeletonLines) do line.Visible = false end
                for _, point in pairs(skeletonPoints) do point.Visible = false end
            end
        else
            for _, line in pairs(skeletonLines) do line.Visible = false end
            for _, point in pairs(skeletonPoints) do point.Visible = false end
        end
    end)
end

local function cleanupESP(player)
    if ESPComponents[player] then
        for _, component in pairs(ESPComponents[player]) do
            if typeof(component) == "table" then
                for _, drawing in pairs(component) do
                    if typeof(drawing) == "userdata" then pcall(function() drawing:Remove() end) end
                end
            else
                if typeof(component) == "userdata" then pcall(function() component:Remove() end) end
            end
        end
        ESPComponents[player] = nil
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then createESP(player) end
end
Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then createESP(player) end
end)
Players.PlayerRemoving:Connect(function(player) cleanupESP(player) end)

local espGroup = Tabs.ESP:AddLeftGroupbox("ESP 总控制")

espGroup:AddToggle("ESP_Master", {
    Text = "开启ESP总开关",
    Default = false,
    Tooltip = "全局启用透视",
    Callback = function(state)
        ESP_Config.EnableESP = state
        if not state then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and ESPComponents[player] then
                    for _, component in pairs(ESPComponents[player]) do
                        if typeof(component) == "table" then
                            for _, d in pairs(component) do
                                if typeof(d) == "userdata" then pcall(function() d.Visible = false end) end
                            end
                        else
                            if typeof(component) == "userdata" then pcall(function() component.Visible = false end) end
                        end
                    end
                end
            end
        end
    end,
})

local espDisplayGroup = Tabs.ESP:AddRightGroupbox("显示项目")

espDisplayGroup:AddToggle("ESP_Name", { Text = "显示头顶名称", Default = true,
    Callback = function(v) ESP_Config.ShowName = v end })
espDisplayGroup:AddToggle("ESP_Health", { Text = "显示血量", Default = true,
    Callback = function(v) ESP_Config.ShowHealth = v end })
espDisplayGroup:AddToggle("ESP_Distance", { Text = "显示距离", Default = true,
    Callback = function(v) ESP_Config.ShowDistance = v end })
espDisplayGroup:AddToggle("ESP_Box", { Text = "方框透视", Default = true,
    Callback = function(v) ESP_Config.ShowBox = v end })
espDisplayGroup:AddToggle("ESP_Tracer", { Text = "射线透视", Default = false,
    Callback = function(v) ESP_Config.ShowTracer = v end })
espDisplayGroup:AddToggle("ESP_Skeleton", { Text = "骨架透视", Default = false,
    Callback = function(v) ESP_Config.ShowSkeleton = v end })
espDisplayGroup:AddToggle("ESP_Weapon", { Text = "武器显示", Default = false,
    Callback = function(v) ESP_Config.ShowWeapon = v end })
espDisplayGroup:AddToggle("ESP_Wall", { Text = "穿墙ESP", Default = false,
    Callback = function(v) ESP_Config.WallHack = v end })
espDisplayGroup:AddToggle("ESP_Team", { Text = "区分队友颜色", Default = false,
    Callback = function(v) ESP_Config.TeamCheck = v end })

local espSetGroup = Tabs.ESP:AddRightGroupbox("ESP 参数")

espSetGroup:AddSlider("ESP_MaxDist", {
    Text = "ESP最大可视距离",
    Default = 350, Min = 50, Max = 1000, Rounding = 0,
    Callback = function(val) ESP_Config.MaxDrawDistance = val end,
})

espSetGroup:AddSlider("ESP_BoxThick", {
    Text = "方框线条粗细",
    Default = 1, Min = 1, Max = 5, Rounding = 0,
    Callback = function(v) ESP_Config.BoxThickness = v end,
})

espSetGroup:AddSlider("ESP_TracerThick", {
    Text = "射线线条粗细",
    Default = 1, Min = 1, Max = 10, Rounding = 0,
    Callback = function(v) ESP_Config.TracerThickness = v end,
})

-- ==================== ESP2 页 ====================
local P_FONT_SIZE = 16
local P_FONT_NAME = Drawing.Fonts.Monospace
local P_MAX_DISTANCE = 1500
local P_BOX_THICKNESS = 1
local P_BOX_SCALE = 2.2

local P_Enabled = false
local P_DrawBox, P_DrawDistance, P_DrawName, P_DrawTracer, P_DrawHealth = false, false, false, false, false

local P_Objects = {}
local P_Initialized = false
local P_RenderConn = nil

local function P_WorldToScreen(worldPos)
    local sp, onScreen = Camera:WorldToViewportPoint(worldPos)
    if not onScreen then return nil end
    return Vector2.new(sp.X, sp.Y)
end

local function P_GetCharData(player)
    local char = player.Character
    if not char then return nil end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
    local head = char:FindFirstChild("Head")
    if not humanoid or not root or not head then return nil end
    return char, humanoid, root, head
end

local function P_CreateObjects()
    local objs = {}
    objs.Box = Drawing.new("Square")
    objs.Box.Filled = false
    objs.Box.Transparency = 1
    objs.Name = Drawing.new("Text")
    objs.Name.Size = P_FONT_SIZE
    objs.Name.Center = true
    objs.Name.Outline = true
    objs.Name.Font = P_FONT_NAME
    objs.Distance = Drawing.new("Text")
    objs.Distance.Size = P_FONT_SIZE - 2
    objs.Distance.Center = true
    objs.Distance.Outline = true
    objs.Distance.Font = P_FONT_NAME
    objs.Health = Drawing.new("Text")
    objs.Health.Size = P_FONT_SIZE - 2
    objs.Health.Center = true
    objs.Health.Outline = true
    objs.Health.Font = P_FONT_NAME
    objs.Tracer = Drawing.new("Line")
    objs.Tracer.Thickness = 1
    objs.Tracer.Transparency = 0.5
    return objs
end

local function P_DestroyObjects(objs)
    if not objs then return end
    for _, obj in pairs(objs) do
        if obj and obj.Remove then pcall(function() obj:Remove() end) end
    end
end

local function P_UpdatePlayer(player, objs)
    if player == LocalPlayer then return end
    local char, humanoid, root, head = P_GetCharData(player)
    if not char or not humanoid or humanoid.Health <= 0 then
        for _, obj in pairs(objs) do obj.Visible = false end
        return
    end
    local distance = (Camera.CFrame.Position - root.Position).Magnitude
    if distance > P_MAX_DISTANCE then
        for _, obj in pairs(objs) do obj.Visible = false end
        return
    end
    local headScreen = P_WorldToScreen(head.Position + Vector3.new(0, 0.5, 0))
    local rootScreen = P_WorldToScreen(root.Position)
    if not headScreen or not rootScreen then
        for _, obj in pairs(objs) do obj.Visible = false end
        return
    end
    local height = math.abs(headScreen.Y - rootScreen.Y) * P_BOX_SCALE
    local width = height * 0.65
    height = math.max(height, 15)
    width = math.max(width, 10)
    local topLeft = Vector2.new(headScreen.X - width / 2, headScreen.Y - height * 0.2)
    local bottomRight = Vector2.new(headScreen.X + width / 2, topLeft.Y + height)

    if P_DrawBox then
        objs.Box.Visible = true
        objs.Box.Size = bottomRight - topLeft
        objs.Box.Position = topLeft
        objs.Box.Thickness = P_BOX_THICKNESS
        local hp = humanoid.Health / humanoid.MaxHealth
        if hp > 0.5 then objs.Box.Color = Color3.fromRGB(0, 255, 0)
        elseif hp > 0.25 then objs.Box.Color = Color3.fromRGB(255, 165, 0)
        else objs.Box.Color = Color3.fromRGB(255, 0, 0) end
    else objs.Box.Visible = false end

    if P_DrawName then
        objs.Name.Visible = true
        objs.Name.Text = player.Name
        objs.Name.Color = Color3.fromRGB(255, 255, 255)
        objs.Name.Position = Vector2.new(headScreen.X, topLeft.Y - P_FONT_SIZE - 2)
    else objs.Name.Visible = false end

    if P_DrawDistance then
        objs.Distance.Visible = true
        objs.Distance.Text = string.format("[%d m]", math.floor(distance))
        objs.Distance.Color = Color3.fromRGB(200, 200, 200)
        objs.Distance.Position = Vector2.new(headScreen.X, bottomRight.Y + 2)
    else objs.Distance.Visible = false end

    if P_DrawHealth then
        objs.Health.Visible = true
        objs.Health.Text = string.format("HP: %d/%d", math.floor(humanoid.Health), math.floor(humanoid.MaxHealth))
        objs.Health.Color = Color3.fromRGB(0, 255, 0)
        objs.Health.Position = Vector2.new(headScreen.X, bottomRight.Y + P_FONT_SIZE + 2)
    else objs.Health.Visible = false end

    if P_DrawTracer then
        objs.Tracer.Visible = true
        objs.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, 0)
        objs.Tracer.To = Vector2.new(headScreen.X, bottomRight.Y)
        objs.Tracer.Color = Color3.fromRGB(255, 255, 255)
    else objs.Tracer.Visible = false end
end

local function P_InitPlayer(player)
    if player == LocalPlayer then return end
    if P_Objects[player] then P_DestroyObjects(P_Objects[player]) end
    P_Objects[player] = P_CreateObjects()
end

local esp2Group = Tabs.ESPP:AddLeftGroupbox("ESP2 控制")

esp2Group:AddButton({
    Text = "🔧 初始化 ESP2 (必先点击)",
    Func = function()
        if P_Initialized then
            Library:Notify({Title = "提示", Text = "ESP2 已经初始化过了", Duration = 3})
            return
        end
        P_Initialized = true
        for _, player in ipairs(Players:GetPlayers()) do P_InitPlayer(player) end
        Players.PlayerAdded:Connect(P_InitPlayer)
        Players.PlayerRemoving:Connect(function(player)
            if P_Objects[player] then
                P_DestroyObjects(P_Objects[player])
                P_Objects[player] = nil
            end
        end)
        P_RenderConn = RunService.RenderStepped:Connect(function()
            if not P_Enabled then return end
            for player, objs in pairs(P_Objects) do
                if player.Parent then
                    pcall(P_UpdatePlayer, player, objs)
                else
                    P_DestroyObjects(objs)
                    P_Objects[player] = nil
                end
            end
        end)
        Library:Notify({Title = "成功", Text = "ESP2 初始化完成", Duration = 3})
    end,
})

esp2Group:AddToggle("ESP2_Master", {
    Text = "ESP2 总开关", Default = false,
    Callback = function(s)
        P_Enabled = s
        if not s then
            for _, objs in pairs(P_Objects) do
                for _, obj in pairs(objs) do obj.Visible = false end
            end
        end
    end,
})

esp2Group:AddToggle("ESP2_Box", { Text = "玩家方框", Default = false,
    Callback = function(s) P_DrawBox = s end })
esp2Group:AddToggle("ESP2_Name", { Text = "玩家名字", Default = false,
    Callback = function(s) P_DrawName = s end })
esp2Group:AddToggle("ESP2_Distance", { Text = "玩家距离", Default = false,
    Callback = function(s) P_DrawDistance = s end })
esp2Group:AddToggle("ESP2_Health", { Text = "生命值", Default = false,
    Callback = function(s) P_DrawHealth = s end })
esp2Group:AddToggle("ESP2_Tracer", { Text = "射线 (从屏幕顶部)", Default = false,
    Callback = function(s) P_DrawTracer = s end })

local esp2SetGroup = Tabs.ESPP:AddRightGroupbox("ESP2 参数")

esp2SetGroup:AddSlider("ESP2_MaxDist", {
    Text = "最大渲染距离",
    Default = 1500, Min = 500, Max = 5000, Rounding = 0,
    Callback = function(value) P_MAX_DISTANCE = value end,
})

esp2SetGroup:AddSlider("ESP2_BoxScale", {
    Text = "方框大小倍数",
    Default = 2.2, Min = 1.5, Max = 3.0, Rounding = 2,
    Callback = function(value) P_BOX_SCALE = value end,
})

esp2SetGroup:AddSlider("ESP2_BoxThick", {
    Text = "方框线条粗细",
    Default = 1, Min = 1, Max = 5, Rounding = 0,
    Callback = function(value) P_BOX_THICKNESS = value end,
})
-------pgesp----
-- ==================== 苹果端ESP（从「没有卡密的通缉」移入） ====================
local AppleESP_Enabled = false
local AppleESP_Color = Color3.fromRGB(255, 50, 50)
local AppleESP_MaxDist = 1000
local AppleESP_TeamCheck = true
local AppleESP_Data = {}
local AppleESP_Loop = nil

local function AppleESP_Create(player)
    if player == LocalPlayer then return end
    local hl = Instance.new("Highlight")
    hl.FillTransparency = 1
    hl.OutlineColor = AppleESP_Color
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Enabled = false
    local bb = Instance.new("BillboardGui")
    bb.Size = UDim2.fromOffset(120, 30)
    bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true
    bb.ResetOnSpawn = false
    bb.Enabled = false
    local name = Instance.new("TextLabel")
    name.Size = UDim2.new(1, 0, 0, 16)
    name.BackgroundTransparency = 1
    name.TextColor3 = Color3.new(1, 1, 1)
    name.TextSize = 14
    name.Font = Enum.Font.GothamBold
    name.TextStrokeTransparency = 0.3
    name.Text = player.Name
    name.Parent = bb
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0, 50, 0, 3)
    bg.Position = UDim2.new(0.5, -25, 0, 18)
    bg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    bg.BorderSizePixel = 0
    bg.Parent = bb
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(1, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 255, 80)
    fill.BorderSizePixel = 0
    fill.Parent = bg
    AppleESP_Data[player] = { hl = hl, bb = bb, fill = fill }
end

local function AppleESP_Setup(player)
    if AppleESP_Data[player] then
        AppleESP_Data[player].hl:Destroy()
        AppleESP_Data[player].bb:Destroy()
        AppleESP_Data[player] = nil
    end
    local char = player.Character
    if not char then return end
    AppleESP_Create(player)
    local e = AppleESP_Data[player]
    if not e then return end
    local head = char:WaitForChild("Head", 5)
    if head then
        e.hl.Adornee = char
        e.hl.Parent = char
        e.bb.Adornee = head
        e.bb.Parent = head
    end
end

local function AppleESP_Start()
    if AppleESP_Enabled then return end
    AppleESP_Enabled = true

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            if p.Character then AppleESP_Setup(p) end
            p.CharacterAdded:Connect(function()
                if AppleESP_Enabled then AppleESP_Setup(p) end
            end)
        end
    end

    Players.PlayerAdded:Connect(function(p)
        if p ~= LocalPlayer then
            p.CharacterAdded:Connect(function()
                if AppleESP_Enabled then AppleESP_Setup(p) end
            end)
            if p.Character and AppleESP_Enabled then AppleESP_Setup(p) end
        end
    end)

    Players.PlayerRemoving:Connect(function(p)
        if AppleESP_Data[p] then
            AppleESP_Data[p].hl:Destroy()
            AppleESP_Data[p].bb:Destroy()
            AppleESP_Data[p] = nil
        end
    end)

    AppleESP_Loop = RunService.RenderStepped:Connect(function()
        if not AppleESP_Enabled then return end
        local myChar = LocalPlayer.Character
        local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
        for player, e in pairs(AppleESP_Data) do
            local char = player.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local show = hum and hrp and hum.Health > 0
            if show and AppleESP_TeamCheck and player.Team and player.Team == LocalPlayer.Team then
                show = false
            end
            if show and myHRP and (myHRP.Position - hrp.Position).Magnitude > AppleESP_MaxDist then
                show = false
            end
            e.hl.Enabled = show
            e.bb.Enabled = show
            if show then
                local r = math.clamp(hum.Health / math.max(hum.MaxHealth, 1), 0, 1)
                e.fill.Size = UDim2.new(r, 0, 1, 0)
                e.fill.BackgroundColor3 = Color3.fromHSV(r * 0.33, 1, 1)
            end
        end
    end)
end

local function AppleESP_Stop()
    AppleESP_Enabled = false
    if AppleESP_Loop then
        AppleESP_Loop:Disconnect()
        AppleESP_Loop = nil
    end
    for p, e in pairs(AppleESP_Data) do
        e.hl:Destroy()
        e.bb:Destroy()
    end
    table.clear(AppleESP_Data)
end

local AppleESP_Group = Tabs.pg:AddLeftGroupbox("苹果端ESP")

AppleESP_Group:AddToggle("AppleESP_Toggle", {
    Text = "ESP内透",
    Default = false,
    Callback = function(state)
        if state then
            AppleESP_Start()
        else
            AppleESP_Stop()
        end
    end,
})

AppleESP_Group:AddSlider("AppleESP_MaxDist", {
    Text = "最大可视距离",
    Default = 1000,
    Min = 100,
    Max = 3000,
    Rounding = 0,
    Callback = function(v) AppleESP_MaxDist = v end,
})

-- ==================== ESP 物品页 ====================
local wbLeft = Tabs.wb:AddLeftGroupbox("变卖物")
local wbRight = Tabs.wb:AddRightGroupbox("枪械显示")

local function addItemESP(groupbox, toggleId, targetName, color, label)
    groupbox:AddToggle(toggleId, {
        Text = label,
        Default = false,
        Callback = function(state)
            if not state then return end
            for _, obj in ipairs(workspace:GetDescendants()) do
                if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
                    if not obj:FindFirstChild("ESP_Highlight") then
                        local h = Instance.new("Highlight")
                        h.Name = "ESP_Highlight"
                        h.FillColor = color
                        h.OutlineColor = color
                        h.FillTransparency = 0.2
                        h.OutlineTransparency = 0.05
                        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        h.Parent = obj

                        local attachPart
                        if obj:IsA("BasePart") then
                            attachPart = obj
                        elseif obj:IsA("Model") then
                            attachPart = obj.PrimaryPart
                            if not attachPart then
                                for _, d in ipairs(obj:GetDescendants()) do
                                    if d:IsA("BasePart") then attachPart = d; break end
                                end
                            end
                        end

                        if attachPart then
                            local billboard = Instance.new("BillboardGui")
                            billboard.Name = "ESP_Tag"
                            billboard.Size = UDim2.new(0, 200, 0, 40)
                            billboard.StudsOffset = Vector3.new(0, 3, 0)
                            billboard.AlwaysOnTop = true
                            billboard.MaxDistance = 0
                            billboard.Adornee = attachPart
                            billboard.Parent = attachPart

                            local nameLbl = Instance.new("TextLabel")
                            nameLbl.Size = UDim2.new(1, 0, 0.5, 0)
                            nameLbl.BackgroundTransparency = 1
                            nameLbl.Text = label
                            nameLbl.TextColor3 = color
                            nameLbl.TextScaled = true
                            nameLbl.Font = Enum.Font.GothamBold
                            nameLbl.TextStrokeTransparency = 0.3
                            nameLbl.Parent = billboard

                            local distLbl = Instance.new("TextLabel")
                            distLbl.Size = UDim2.new(1, 0, 0.5, 0)
                            distLbl.Position = UDim2.new(0, 0, 0.5, 0)
                            distLbl.BackgroundTransparency = 1
                            distLbl.Text = "--m"
                            distLbl.TextColor3 = Color3.new(1, 1, 1)
                            distLbl.TextScaled = true
                            distLbl.Font = Enum.Font.GothamBold
                            distLbl.TextStrokeTransparency = 0.3
                            distLbl.Parent = billboard

                            task.spawn(function()
                                while distLbl.Parent do
                                    local char = LocalPlayer.Character
                                    local root = char and char:FindFirstChild("HumanoidRootPart")
                                    if root and attachPart.Parent then
                                        local d = (root.Position - attachPart.Position).Magnitude
                                        distLbl.Text = string.format("%.1fm", d)
                                    end
                                    task.wait(0.2)
                                end
                            end)
                        end
                    end
                end
            end
        end,
    })
end

addItemESP(wbLeft, "Item_MoneyPrinter", "MoneyPrinter", Color3.new(0, 0.8, 0.2), " 印钞机检测")
addItemESP(wbLeft, "Item_GoldBar", "Gold Bar", Color3.new(1, 0.8, 0), " 金块")
addItemESP(wbLeft, "Item_Bitcoin", "Bitcoin", Color3.new(1, 0.6, 0), "₿ BTC")
addItemESP(wbLeft, "Item_Sapphire", "Sapphire", Color3.new(0.6, 0, 1), " 紫宝石")
addItemESP(wbLeft, "Item_SafeDoor", "SafeDoor", Color3.new(1, 0.7, 0), " 保险箱")
addItemESP(wbLeft, "Item_Ruby", "Ruby", Color3.new(1, 0, 0), " 红宝石")
addItemESP(wbLeft, "Item_RubyRing", "Ruby Ring", Color3.new(1, 0, 0), " 红宝石戒指")
addItemESP(wbLeft, "Item_GPU", "GPU", Color3.new(0, 0.8, 1), " GPU")
addItemESP(wbLeft, "Item_MilitaryChest", "MilitaryChest", Color3.new(0.3, 0.5, 0.2), "军需箱")
addItemESP(wbLeft, "Item_Amethyst", "Amethyst Ring", Color3.new(0.7, 0.2, 1), " 紫水晶")

addItemESP(wbRight, "Item_AK47", "AK-47", Color3.new(1, 0.2, 0), " AK47")
addItemESP(wbRight, "Item_AUG", "AUG A1", Color3.new(0.6, 0.2, 1), " AUG A1")
addItemESP(wbRight, "Item_AWM", "AWM", Color3.new(0.3, 0.3, 0.3), " AWM")
addItemESP(wbRight, "Item_M4A1", "M4A1", Color3.new(0, 0.5, 1), " M4A1")
addItemESP(wbRight, "Item_RPG", "RPG-7", Color3.new(1, 0.5, 0), " RPG")
addItemESP(wbRight, "Item_ARX160", "ARX-160", Color3.new(0.2, 0.5, 1), " ARX-160")

wbRight:AddToggle("Item_CargoCard", {
    Text = "货物卡", Default = false,
    Callback = function(state)
        if not state then return end
        local cc = workspace.Local and workspace.Local:FindFirstChild("Tools")
        cc = cc and cc:FindFirstChild("Cargo Card")
        if cc and not cc:FindFirstChild("ESP_Highlight") then
            local h = Instance.new("Highlight")
            h.Name = "ESP_Highlight"
            h.FillColor = Color3.new(0.2, 0.4, 1)
            h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            h.Parent = cc
        end
    end,
})
-- ==================== lc 标签：农场光环 (安全版) ====================

-- 1. 全局捕获，避免直接崩脚本
local function SafeFarmAura()
    local Players           = game:GetService("Players")
    local RunService        = game:GetService("RunService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local LocalPlayer       = Players.LocalPlayer

    -- 检查标签
    if not Tabs or not Tabs.lc then
        warn("[农场光环] Tabs.lc 不存在，请确认你创建标签的写法。当前 Tabs 内容:")
        if Tabs then
            for k, v in pairs(Tabs) do print("   ", k, v) end
        end
        return
    end

    -- 检查 Devv
    local DevvFolder = ReplicatedStorage:FindFirstChild("Devv") or ReplicatedStorage:FindFirstChild("devv")
    if not DevvFolder then
        warn("[农场光环] 不在 Wanted 游戏，或 Devv 模块缺失")
        return
    end

    local ok_req, DevvModule = pcall(require, DevvFolder)
    if not ok_req or not DevvModule or type(DevvModule.load) ~= "function" then
        warn("[农场光环] Devv 加载失败: " .. tostring(DevvModule))
        return
    end

    local load = DevvModule.load
    local Network = load("Network")
    local ClientPlayers = load("ClientPlayers")
    local fireServer = Network.FireServer
    local invokeServer = Network.InvokeServer

    local ok1, ClientGizmos = pcall(require, ReplicatedStorage.Client.Wanted.Modules.ClientGizmos)
    local ok2, ClientProps  = pcall(require, ReplicatedStorage.Client.Wanted.Modules.ClientProps)
    local ok3, ClientTools  = pcall(require, ReplicatedStorage.Client.Wanted.Modules.ClientTools)

    if not ok1 then warn("[农场光环] ClientGizmos 加载失败") return end
    if not ok2 then warn("[农场光环] ClientProps 加载失败") return end
    if not ok3 then warn("[农场光环] ClientTools 加载失败") return end

    print("[农场光环] 依赖模块全部加载成功")

    -- 2. 配置和状态
    local FarmConfig = {
        Enabled    = false,
        Range      = 10,
        Cash       = true,
        ATM        = true,
        Safe       = true,
        BreakGlass = true,
    }
    local FarmState = { Running = false, Conn = nil }

    -- 3. 工具函数
    local function getMyChar()
        local c = LocalPlayer.Character
        return c, c and c:FindFirstChild("HumanoidRootPart")
    end

    local function getGizmos(hrp)
        local list = {}
        local ok, source = pcall(debug.getupvalue, ClientGizmos.Get, 1)
        if not ok or type(source) ~= "table" then
            warn("[农场光环] 无法从 ClientGizmos.Get 获取数据")
            return list
        end
        for k, v in pairs(source) do
            if k and type(v) == "table" and v.position then
                v.objectId = v.objectId or k
                v.dist = hrp and (hrp.Position - v.position).Magnitude or math.huge
                table.insert(list, v)
            end
        end
        table.sort(list, function(a, b) return a.dist < b.dist end)
        return list
    end

    local function isCash(g)
        if type(g) ~= "table" then return false end
        if g.isCurrency == true then return true end
        local t = g.gizmoType
        return t == "Cash" or t == "CashPallet" or t == "MainCashPile"
    end

    local function getCashLeft(g)
        if type(g) ~= "table" then return nil end
        if type(g.cashLeft) == "number" then return g.cashLeft end
        if g.gizmoState and type(g.gizmoState.amount) == "number" then return g.gizmoState.amount end
        return nil
    end

    local function canInteract(g)
        if type(g) ~= "table" or not g.gizmoType then return false end
        local gs = g.gizmoState
        if gs and (gs.broken or gs.searched or gs.robbed or gs.used or gs.isDestroyed) then return false end
        if g.broken or g.searched or g.robbed or g.isCollected then return false end
        if isCash(g) then
            local left = getCashLeft(g)
            if left ~= nil and left <= 0 then return false end
            return g.objectId ~= nil
        end
        if g.gizmoType == "ATM" or g.gizmoType == "Register" then return g.position ~= nil end
        if g.gizmoType == "WorldSafe" then return g.objectId ~= nil end
        return false
    end

    local function interact(g)
        if type(g) ~= "table" then return false end
        local t = g.gizmoType
        if t == "ATM" or t == "Register" then
            local CP = ClientPlayers.Get()
            if CP and g.position then
                pcall(function() CP:Melee(g.position) end)
                return true
            end
            return false
        end
        if t == "WorldSafe" then
            if g.objectId then
                fireServer("gizmoInteraction", g.objectId, "OpenSafe")
                return true
            end
            return false
        end
        if isCash(g) then
            if not g.objectId then return false end
            local count = (t == "CashPallet" or t == "MainCashPile") and 10 or 1
            local ids = table.create(count, g.objectId)
            pcall(invokeServer, "collectCurrency", ids)
            return true
        end
        return false
    end

    local function tryBreakGlass(hrp)
        if not FarmConfig.BreakGlass then return end
        if type(ClientProps.worldPropsById) ~= "table" then return end
        local best, bestD = nil, 10
        for _, v in pairs(ClientProps.worldPropsById) do
            if type(v) == "table" and v.name == "JewelSpawn" and not v.isShattered then
                local p = (v.GetPosition and v:GetPosition()) or
                          (v.model and v.model.PrimaryPart and v.model.PrimaryPart.Position)
                if p then
                    local d = (hrp.Position - p).Magnitude
                    if d < bestD then bestD = d; best = v end
                end
            end
        end
        if not best or best.isShattered then return end

        local buzz = nil
        local ok, items = pcall(ClientTools.GetItems)
        if ok and type(items) == "table" then
            for _, cat in pairs(items) do
                if type(cat) == "table" then
                    for guid, data in pairs(cat) do
                        if data and (data.name == "Buzzsaw" or data.isBuzzSaw) then
                            buzz = { guid = guid, data = data }
                            break
                        end
                    end
                end
                if buzz then break end
            end
        end
        if not buzz then return end

        local CP = ClientPlayers.Get()
        if not CP then return end
        fireServer("equip", buzz.guid)
        pcall(function()
            setthreadidentity(2)
            CP:SetEquipped({ toolId = buzz.guid, toolState = true })
            setthreadidentity(8)
        end)
        local p = (best.GetPosition and best:GetPosition()) or
                  (best.model and best.model.PrimaryPart and best.model.PrimaryPart.Position)
        if p then pcall(function() CP:Melee(p) end) end
    end

    local function tickFarmAura()
        local char, hrp = getMyChar()
        if not hrp then return end
        tryBreakGlass(hrp)

        local gizmos = getGizmos(hrp)
        local cashList, otherList = {}, {}
        for _, g in ipairs(gizmos) do
            if g.dist < FarmConfig.Range and canInteract(g) then
                if isCash(g) and FarmConfig.Cash then
                    table.insert(cashList, g)
                elseif (g.gizmoType == "ATM" or g.gizmoType == "Register") and FarmConfig.ATM then
                    table.insert(otherList, g)
                elseif g.gizmoType == "WorldSafe" and FarmConfig.Safe then
                    table.insert(otherList, g)
                end
            end
        end
        for i = 1, #cashList do interact(cashList[i]) end
        table.sort(otherList, function(a, b) return a.dist < b.dist end)
        for i = 1, math.min(3, #otherList) do interact(otherList[i]) end
    end

    if not FarmState.Running then
        FarmState.Running = true
        FarmState.Conn = RunService.Heartbeat:Connect(function()
            if not FarmConfig.Enabled then return end
            pcall(tickFarmAura)
        end)
    end

    -- 4. lc 标签 UI
    local lcLeft  = Tabs.lc:AddLeftGroupbox("农场光环")
    local lcRight = Tabs.lc:AddRightGroupbox("参数设置")

    lcLeft:AddToggle("FarmAura_Enable", {
        Text = "开启农场光环",
        Default = false,
        Tooltip = "自动捡现金、开 ATM、开保险箱、破玻璃",
        Callback = function(v) FarmConfig.Enabled = v end,
    })

    lcLeft:AddDivider()
    lcLeft:AddToggle("FarmAura_Cash", { Text = "现金 / 钱堆", Default = true,
        Callback = function(v) FarmConfig.Cash = v end })
    lcLeft:AddToggle("FarmAura_ATM", { Text = "ATM / 收银机", Default = true,
        Callback = function(v) FarmConfig.ATM = v end })
    lcLeft:AddToggle("FarmAura_Safe", { Text = "世界保险箱", Default = true,
        Callback = function(v) FarmConfig.Safe = v end })
    lcLeft:AddToggle("FarmAura_BreakGlass", { Text = "破玻璃珠宝", Default = true,
        Tooltip = "自动切 Buzzsaw 打碎珠宝柜玻璃",
        Callback = function(v) FarmConfig.BreakGlass = v end })

    lcRight:AddSlider("FarmAura_Range", {
        Text = "触发距离",
        Default = 10, Min = 5, Max = 50, Rounding = 0,
        Suffix = " 格",
        Callback = function(v) FarmConfig.Range = v end,
    })
end

-- 用 pcall 包起来，出错也不会崩整个脚本
local ok, err = pcall(SafeFarmAura)
if not ok then
    warn("[农场光环] 初始化失败: " .. tostring(err))
    Library:Notify({ Title = "农场光环", Text = "加载失败: " .. tostring(err), Duration = 8 })
end
-- ==================== 删除页 ====================
local qqGroup = Tabs.qq:AddLeftGroupbox("删除环境物")

qqGroup:AddButton({
    Text = "删除炮台",
    Func = function()
        local l = workspace:FindFirstChild("Local")
        if l then
            local g = l:FindFirstChild("Gizmos")
            if g then
                local t = g:FindFirstChild("Turret")
                if t then t:Destroy(); print("已删除炮台") end
            end
        end
    end,
})

qqGroup:AddButton({
    Text = "删除红外线",
    Func = function()
        local p = workspace:FindFirstChild("Props")
        if p then
            if p:FindFirstChild("Laser") then p.Laser:Destroy() end
            if p:FindFirstChild("LaserAssembly") then p.LaserAssembly:Destroy() end
        end
    end,
})

qqGroup:AddButton({
    Text = "删除红色屏障",
    Func = function()
        local p = workspace:FindFirstChild("Props")
        if p and p:FindFirstChild("LaserForcefield") then p.LaserForcefield:Destroy() end
    end,
})

-- ==================== 娱乐功能 ====================
local rsaoGroup = Tabs.rsao:AddLeftGroupbox("娱乐功能")

local burningActive = false
rsaoGroup:AddToggle("Burning", {
    Text = "🔥 烈焰战士",
    Default = false,
    Callback = function(state)
        burningActive = state
        if burningActive then
            task.spawn(function()
                local Event = game:GetService("ReplicatedStorage").Shared.Core.Network:GetChildren()[75]
                while burningActive do
                    Event:FireServer("burning", true)
                    task.wait(0.2)
                end
            end)
        end
    end,
})

rsaoGroup:AddButton({
    Text = "刷印钞机",
    Func = function()
        LocalPlayer:Kick("给我重进吧，老弟")
    end,
})

rsaoGroup:AddButton({
    Text = "天黑1",
    Func = function()
        local Lighting = game:GetService("Lighting")
        task.spawn(function()
            while task.wait(0.3) do
                Lighting.ClockTime = 2
                Lighting.Brightness = 0.45
                Lighting.Ambient = Color3.new(0.18, 0.18, 0.25)
                Lighting.OutdoorAmbient = Color3.new(0.16, 0.16, 0.22)
                Lighting.GlobalShadows = true
                local skybox = Lighting:FindFirstChild("Realistic Skybox")
                if skybox then
                    skybox.TimeOfDay = 0.15
                    skybox.StarsVisible = true
                    skybox.MoonBrightness = 1.0
                    skybox.SunBrightness = 0
                end
            end
        end)
    end,
})

rsaoGroup:AddButton({
    Text = "天黑2",
    Func = function()
        local Lighting = game:GetService("Lighting")
        Lighting.ClockTime = 2
        Lighting.Brightness = 0.35
        Lighting.Ambient = Color3.new(0.12, 0.12, 0.18)
        Lighting.OutdoorAmbient = Color3.new(0.10, 0.10, 0.15)
        Lighting.GlobalShadows = true
        local skybox = Lighting:FindFirstChild("Realistic Skybox")
        if skybox then
            skybox.TimeOfDay = 0.15
            skybox.StarsVisible = true
            skybox.MoonBrightness = 1.0
            skybox.SunBrightness = 0
        end
    end,
})

-- ==================== 购买页 ====================
local gmGroup = Tabs.gm:AddLeftGroupbox("购买（需在建筑范围内）")

gmGroup:AddButton({
    Text = "奥菲当铺出售物品循环售卖",
    Func = function()
        local Event = game:GetService("ReplicatedStorage").Shared.Core.Network:GetChildren()[144]
        task.spawn(function()
            while task.wait(0.2) do
                pcall(function() Event:InvokeServer("Ofy") end)
            end
        end)
    end,
})

gmGroup:AddButton({
    Text = "C4➖250元",
    Func = function()
        local Event = game:GetService("ReplicatedStorage").Shared.Core.Network:GetChildren()[190]
        Event:InvokeServer({
            itemName = "C4", itemType = "Ammo", ammoToBuyIndex = 1,
            categoryName = "Explosives", shopName = "Guns"
        })
    end,
})

gmGroup:AddButton({
    Text = "循环补充弹药",
    Func = function()
        local Event = game:GetService("ReplicatedStorage").Shared.Core.Network:GetChildren()[190]
        task.spawn(function()
            while task.wait(0.2) do
                pcall(function() Event:InvokeServer({ refillAll = true }) end)
            end
        end)
    end,
})

-- ==================== UI 设置页 ====================
local MenuGroup = Tabs.UI:AddLeftGroupbox("菜单设置")

MenuGroup:AddToggle("KeybindMenuOpen", {
    Default = Library.KeybindFrame.Visible,
    Text = "打开快捷键面板",
    Callback = function(Value) Library.KeybindFrame.Visible = Value end,
})

MenuGroup:AddToggle("ShowCustomCursor", {
    Text = "自定义鼠标光标",
    Default = false,
    Callback = function(Value) Library.ShowCustomCursor = Value end,
})

MenuGroup:AddDropdown("NotificationSide", {
    Values = {"左侧", "右侧"},
    Default = "右侧",
    Text = "通知弹窗位置",
    Callback = function(Value)
        Library:SetNotifySide(Value == "左侧" and "Left" or "Right")
    end,
})

MenuGroup:AddDropdown("DPIDropdown", {
    Values = {"50%", "75%", "100%", "125%", "150%", "175%", "200%"},
    Default = "100%",
    Text = "界面缩放",
    Callback = function(Value)
        Value = Value:gsub("%%", "")
        Library:SetDPIScale(tonumber(Value))
    end,
})

MenuGroup:AddDivider()

MenuGroup:AddLabel("菜单切换快捷键")
    :AddKeyPicker("MenuKeybind", {
        Default = "RightShift",
        NoUI = true,
        Text = "显示/隐藏菜单按键"
    })

MenuGroup:AddButton("卸载脚本", function() Library:Unload() end)

Library.ToggleKeybind = Options.MenuKeybind

-- ==================== 主题 & 存档 ====================
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({"MenuKeybind"})
ThemeManager:SetFolder("WantedHub")
SaveManager:SetFolder("WantedHub/specific-game")
SaveManager:SetSubFolder("specific-place")

SaveManager:BuildConfigSection(Tabs.UI)
ThemeManager:ApplyToTab(Tabs.UI)
SaveManager:LoadAutoloadConfig()

-- ==================== 初始化 ====================
Library:Init()

-- ==================== 完成提示 ====================
Library:Notify({
    Title = "加载完成",
    Text = "通缉脚本Obsidian UI ",
    Duration = 5,
})

Window:SelectTab(1)