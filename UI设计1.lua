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
Window:SetBackgroundImage("rbxassetid://74582090236479")
Window.BackgroundTransparency = 0.20
-- ==================== 创建所有标签页 ====================
local Tabs = {
    gg   = Window:AddTab("公告", "megaphone"),
    wj   = Window:AddTab("玩家", "users"),
    jx   = Window:AddTab("远程击杀+雷达", "crown"),
    bot  = Window:AddTab("瞄准", "target"),
    ESP  = Window:AddTab("ESP", "eye"),
    ESPP = Window:AddTab("ESP2", "eye"),
    pg   = Window:AddTab("苹果端ESP", "eye"),
    wb   = Window:AddTab("ESP物品", "box"),
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
ggLeft:AddLabel("• 新增苹果端ESP")
ggLeft:AddLabel("• 新增 ESP2")
ggLeft:AddLabel("• 新增灵魂/实体飞行")
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
ggRight:AddLabel("4. 出现卡顿可以")
ggRight:AddLabel("   关掉不必要的功能")

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
local isWarpFlying, flySpeed = false, 50
local hrp, hum
local ControlModule = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
local originalCanCollide = {}
local diedConn

local function clearFlyRes()
    pcall(function()
        for part, state in pairs(originalCanCollide) do
            if part and part.Parent then part.CanCollide = state end
        end
        table.clear(originalCanCollide)
        if diedConn then diedConn:Disconnect() end
        if hrp and hum then hum:ChangeState(Enum.HumanoidStateType.Running) end
    end)
end

local function microStepLoop()
    local targetPos = hrp.Position
    local lastTime = tick()
    while isWarpFlying do
        local now = tick(); local dt = now - lastTime; lastTime = now
        local mv = ControlModule:GetMoveVector()
        local cf = Camera.CFrame
        local moveDir = (cf.LookVector * -mv.Z) + (cf.RightVector * mv.X)
        local vertical = 0
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vertical = 1
        elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then vertical = -1 end
        targetPos += (moveDir + Vector3.new(0, vertical, 0)) * flySpeed * dt
        local currentPos = hrp.Position
        local remaining = targetPos - currentPos
        local distance = remaining.Magnitude
        if distance > 0 then
            local steps = math.ceil(distance / 10)
            local stepVec = remaining / steps
            for i = 1, steps do
                if not isWarpFlying then break end
                currentPos += stepVec
                hrp.CFrame = CFrame.new(currentPos) * hrp.CFrame.Rotation
                hrp.Velocity = Vector3.zero
            end
        end
        hum:ChangeState(Enum.HumanoidStateType.Climbing)
        task.wait(0.001)
    end
end

local function healthLockLoop()
    while isWarpFlying do
        if hum and hum.Health < hum.MaxHealth then hum.Health = hum.MaxHealth end
        RunService.Heartbeat:Wait()
    end
end

local function startWarpFly()
    if isWarpFlying then return end
    local char = LocalPlayer.Character
    if not char then return end
    hrp = char:FindFirstChild("HumanoidRootPart")
    hum = char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            originalCanCollide[part] = part.CanCollide
            part.CanCollide = false
        end
    end
    isWarpFlying = true
    hum:ChangeState(Enum.HumanoidStateType.Climbing)
    task.spawn(microStepLoop)
    task.spawn(healthLockLoop)
    diedConn = hum.Died:Connect(function()
        if hum and isWarpFlying then
            hum.Health = hum.MaxHealth
            hum:ChangeState(Enum.HumanoidStateType.Running)
        end
    end)
end

local function stopWarpFly()
    isWarpFlying = false
    clearFlyRes()
end

local flyGroup = Tabs.wj:AddLeftGroupbox("灵魂飞行")

flyGroup:AddToggle("Warp_Fly", {
    Text = "灵魂飞行",
    Default = false,
    Tooltip = "飞行思路来自AF作者秋辞",
    Callback = function(v)
        if v then startWarpFly() else stopWarpFly() end
    end,
})

flyGroup:AddSlider("Fly_Speed", {
    Text = "飞行速度",
    Default = 50,
    Min = 10,
    Max = 130,
    Rounding = 0,
    Callback = function(val) flySpeed = val end,
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

-- ==================== 远程击杀 + 雷达 ====================
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

addItemESP(wbLeft, "Item_MoneyPrinter", "MoneyPrinter", Color3.new(0, 0.8, 0.2), "💰 印钞机检测")
addItemESP(wbLeft, "Item_GoldBar", "Gold Bar", Color3.new(1, 0.8, 0), "🥇 金块")
addItemESP(wbLeft, "Item_Bitcoin", "Bitcoin", Color3.new(1, 0.6, 0), "₿ BTC")
addItemESP(wbLeft, "Item_Sapphire", "Sapphire", Color3.new(0.6, 0, 1), "💎 紫宝石")
addItemESP(wbLeft, "Item_SafeDoor", "SafeDoor", Color3.new(1, 0.7, 0), "🔐 保险箱")
addItemESP(wbLeft, "Item_Ruby", "Ruby", Color3.new(1, 0, 0), "🔴 红宝石")
addItemESP(wbLeft, "Item_RubyRing", "Ruby Ring", Color3.new(1, 0, 0), "💍 红宝石戒指")
addItemESP(wbLeft, "Item_GPU", "GPU", Color3.new(0, 0.8, 1), "🖥 GPU")
addItemESP(wbLeft, "Item_MilitaryChest", "MilitaryChest", Color3.new(0.3, 0.5, 0.2), "🎖 军需箱")
addItemESP(wbLeft, "Item_Amethyst", "Amethyst Ring", Color3.new(0.7, 0.2, 1), "💜 紫水晶")

addItemESP(wbRight, "Item_AK47", "AK-47", Color3.new(1, 0.2, 0), "🔫 AK47")
addItemESP(wbRight, "Item_AUG", "AUG A1", Color3.new(0.6, 0.2, 1), "🔫 AUG A1")
addItemESP(wbRight, "Item_AWM", "AWM", Color3.new(0.3, 0.3, 0.3), "🎯 AWM")
addItemESP(wbRight, "Item_M4A1", "M4A1", Color3.new(0, 0.5, 1), "🔫 M4A1")
addItemESP(wbRight, "Item_RPG", "RPG-7", Color3.new(1, 0.5, 0), "🚀 RPG")
addItemESP(wbRight, "Item_ARX160", "ARX-160", Color3.new(0.2, 0.5, 1), "🔫 ARX-160")

wbRight:AddToggle("Item_CargoCard", {
    Text = "💳 货物卡", Default = false,
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

-- ==================== 完全汉化插件动态按钮 ====================
task.spawn(function()
    local translations = {
        ["Toggle"] = "切换", ["Lock"] = "锁定", ["Search"] = "搜索",
        ["Save"] = "保存", ["Load"] = "加载", ["Delete"] = "删除",
        ["Refresh"] = "刷新", ["Copy"] = "复制", ["Clear"] = "清空",
        ["Reset"] = "重置", ["Unload"] = "卸载",
        ["Enabled"] = "已启用", ["Disabled"] = "已禁用",
        ["Theme"] = "主题", ["Theme Manager"] = "主题管理",
        ["Delete theme"] = "删除主题", ["Refresh list"] = "刷新列表",
        ["Set as default"] = "设为默认", ["Reset default"] = "重置默认",
        ["Current default theme: none"] = "当前默认主题: 无",
        ["Current default theme: "] = "当前默认主题: ",
        ["Theme JSON"] = "主题 JSON", ["Import theme"] = "导入主题",
        ["Export current theme"] = "导出当前主题",
        ["Accent Color"] = "强调色", ["Text Color"] = "文字颜色",
        ["Element Color"] = "元素颜色", ["Background"] = "背景",
        ["Font"] = "字体", ["Custom"] = "自定义",
        ["Config list"] = "配置列表", ["Load config"] = "加载配置",
        ["Overwrite config"] = "覆盖配置", ["Delete config"] = "删除配置",
        ["Set as autoload"] = "设为自动加载", ["Reset autoload"] = "重置自动加载",
        ["Current autoload config: none"] = "当前自动加载配置: 无",
        ["Current autoload config: "] = "当前自动加载配置: ",
        ["Enter Config Name"] = "输入配置名称", ["Config Name"] = "配置名称",
        ["Autoload"] = "自动加载",
    }
    while task.wait(0.1) do
        pcall(function()
            local containers = {
                game.Players.LocalPlayer:FindFirstChild("PlayerGui"),
                game:GetService("CoreGui")
            }
            for _, container in ipairs(containers) do
                if container then
                    for _, obj in ipairs(container:GetDescendants()) do
                        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
                            local txt = obj.Text
                            if translations[txt] then
                                obj.Text = translations[txt]
                            else
                                for eng, chn in pairs(translations) do
                                    if type(txt) == "string" and string.find(txt, eng, 1, true) then
                                        obj.Text = string.gsub(txt, eng, chn)
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- ==================== 完成提示 ====================
Library:Notify({
    Title = "加载完成",
    Text = "通缉脚本Obsidian UI ",
    Duration = 5,
})

Window:SelectTab(1)