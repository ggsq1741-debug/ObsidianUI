-- ==================== 全局屏蔽日志（兼容版） ====================
do
    local ok1 = pcall(function() print = function() end end)
    local ok2 = pcall(function() warn = function() end end)
    local ok3 = pcall(function() printidentity = function() end end)

    -- 如果直接赋值失败，尝试用 hookfunction
    if not ok1 and hookfunction then
        pcall(function() hookfunction(print, function() end) end)
    end
    if not ok2 and hookfunction then
        pcall(function() hookfunction(warn, function() end) end)
    end
    if not ok3 and hookfunction then
        pcall(function() hookfunction(printidentity, function() end) end)
    end
end
-- ================================================================
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

local TARGET_NAMES = {
    "Suponjibobu00",
    "YK666308",
    "某某某3",
}

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

print = function() end
warn = function() end
printidentity = function() end

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/main.lua"))()
WindUI:Notify({
    Title = "",
    Content = "有问题bug联系作者",
    Icon = "circle-user-round",
    Duration = 20,
})
WindUI:Notify({
    Title = "问题",
    Content = "跑步拉回的话请连续跳跃在奔跑",
    Icon = "circle-user-round",
    Duration = 10,
})
WindUI:Notify({
    Title = "纸飞机",
    Content = "@you25801",
    Icon = "circle-user-round",
    Duration = 120,
})
WindUI:Notify({
    Title = "更新",
    Content = "万圣节功能",
    Icon = "circle-user-round",
    Duration = 15,
})
local Popup = WindUI:Popup({
    Title = "hi你好👋",
    Content = "我们完整的优化了许多功能、音乐等其他",
    Buttons = {
        {
            Title = "Get Started",
            Callback = function()
                print("Getting started...")
            end
        }
    }
})
-- ==================== 自定义三角洲行动风格主题（精确覆盖所有文字） ====================
local techGreen = Color3.fromRGB(0, 255, 160)   -- 科技绿
local white = Color3.fromRGB(245, 248, 255)
local lightGray = Color3.fromRGB(175, 185, 200)

WindUI:AddTheme({
    Name = "DeltaForce",
    -- 【全局所有图标颜色！侧边标签图标、控件小图标全部变成绿色】
    Icon = Color3.fromHex("#22c55e"), 

    WindowTopbarTitle = techGreen,
    WindowTopbarAuthor = techGreen,
    TabTitle = techGreen,

    ElementTitle = white,
    ButtonText = white,
    PopupTitle = white,
    DialogTitle = white,

    ElementDesc = lightGray,
    PopupContent = lightGray,
    DialogContent = lightGray,

    PlaceholderText = techGreen,

    TooltipText = white,
    TooltipSecondaryText = white,
})
WindUI:SetTheme("DeltaForce")
-- 获取服务
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
-- 创建主窗口
local Window = WindUI:CreateWindow({
    Title = "港猫的通缉Wanted中国希望",
    Author = "作者港猫",
    Folder = "MyHub",
    Transparent = true,
    Theme = "DeltaForce",
    SideBarWidth = 130,
    HideSearchBar = false,
    ScrollBarEnabled = true,
    Background = "https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/33490c2c-02d8-4dc8-b24a-0e0478a45b8f.png",
    BackgroundImageTransparency = 0.4,
    User = { Enabled = true },
    ToggleKey = Enum.KeyCode.F,
})

print("窗口标题应为绿色，控件标题应为白色")
-- ==================== 标签页彩色图标辅助函数（兼容版） ====================
local function createTab(config)
    local success, tab = pcall(function()
        return Window:Tab({
            Title     = config.Title,
            Icon      = config.Icon,
            Desc      = config.Desc,
            IconColor = config.IconColor,
            IconShape = "Square", -- 强制图标变成正方形框
            Border    = true      -- 给图标加个边框
        })
    end)
    if success and tab then
        return tab
    end
    -- 降级处理（老版本如果不支持这些参数）
    return Window:Tab({
        Title = config.Title,
        Icon  = config.Icon,
        Desc  = config.Desc,
    })
end

local COLORS = {
    Players   = Color3.fromRGB(120, 180, 255),
    Spooky    = Color3.fromRGB(255, 140,  60),
    Key       = Color3.fromRGB(255, 210,  80),
    Crosshair = Color3.fromRGB(80,  220, 255),
    Music     = Color3.fromRGB(255, 120, 200),
    Swing     = Color3.fromRGB(200,  90, 255),
    CarKing   = Color3.fromRGB(255, 180,  40),
    Ragebot   = Color3.fromRGB(255,  70,  70),
    Farm      = Color3.fromRGB(60,  220, 120),
    RemoteK   = Color3.fromRGB(255,  90, 120),
    Aura      = Color3.fromRGB(170, 120, 255),
    AimAssist = Color3.fromRGB(90,  200, 255),
    Hitbox    = Color3.fromRGB(0,   230, 200),
    SilentAim = Color3.fromRGB(255, 120,  60),
    ESP1      = Color3.fromRGB(50,  255, 160),
    ESP2      = Color3.fromRGB(120, 255, 200),
    ESPItem   = Color3.fromRGB(200, 230,  80),
    Delete    = Color3.fromRGB(160, 160, 160),
    Fun       = Color3.fromRGB(255, 100, 180),
    Shop      = Color3.fromRGB(255, 200,  60),
    Control   = Color3.fromRGB(0,   255, 210), 
    Control   = Color3.fromRGB(255,   0, 0),
}

local Tabs = {
    wj    = createTab({ Title = "玩家",             Icon = "users",                    IconColor = COLORS.Players   }),
    jw    = createTab({ Title = "键位修改",         Icon = "keyboard",                 IconColor = COLORS.Control   }),
    lup    = createTab({ Title = "防录屏设置选项",         Icon = "rbxassetid://7733655834",                 IconColor = COLORS.Control   }),
    wsj   = createTab({ Title = "万圣节功能",        Icon = "rbxassetid://7734058599",   IconColor = COLORS.Spooky    }),
    key   = createTab({ Title = "万圣节刷钥匙",      Icon = "rbxassetid://7733965118",   IconColor = COLORS.Key       }),
    zx    = createTab({ Title = "准心设置",          Icon = "rbxassetid://7733666258",   IconColor = COLORS.Crosshair }),
    yy    = createTab({ Title = "音乐 Music",        Icon = "rbxassetid://7734020554",   IconColor = COLORS.Music     }),
    sf    = createTab({ Title = "甩飞",             Icon = "rbxassetid://7733799371",   IconColor = COLORS.Swing     }),
    fc    = createTab({ Title = "亚洲车王",          Icon = "rbxassetid://7733708835",   IconColor = COLORS.CarKing   }),
    jq    = createTab({ Title = "愤怒BOT",          Icon = "rbxassetid://7733916988",   IconColor = COLORS.Ragebot   }),
    lc    = createTab({ Title = "自动农场",          Icon = "rbxassetid://7733920117",   IconColor = COLORS.Farm      }),
    jx    = createTab({ Title = "远程击杀",          Icon = "crown",                     IconColor = COLORS.RemoteK   }),
    gh    = createTab({ Title = "光环",             Icon = "crown",                     IconColor = COLORS.Aura      }),
    fz    = createTab({ Title = "进阶辅助瞄准",       Icon = "crosshair",                 IconColor = COLORS.AimAssist }),
    bot   = createTab({ Title = "范围",             Icon = "target",                    IconColor = COLORS.Hitbox    }),
    zj    = createTab({ Title = "子弹追踪",          Icon = "target",                    IconColor = COLORS.SilentAim }),
    ESP   = createTab({ Title = "ESP",              Icon = "eye",                       IconColor = COLORS.ESP1      }),
    ESPP  = createTab({ Title = "ESP2",             Icon = "eye",                       IconColor = COLORS.ESP2      }),
    wb    = createTab({ Title = "ESP物品",          Icon = "box",                       IconColor = COLORS.ESPItem   }),
    qq    = createTab({ Title = "删除",             Icon = "trash-2",                   IconColor = COLORS.Delete    }),
    rsao  = createTab({ Title = "娱乐+大肥鱼小宠物",   Icon = "zap",                       IconColor = COLORS.Fun       }),
    gm    = createTab({ Title = "购买",             Icon = "shopping-cart",             IconColor = COLORS.Shop      }),
}
Window:SelectTab(1)

local function getCharacter()
    if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        return LocalPlayer.Character
    end
    return nil
end

local isInfiniteJumpEnabled = false
UserInputService.JumpRequest:Connect(function()
    if isInfiniteJumpEnabled then
        local character = getCharacter()
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)
------------===============----------
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local speedConn = nil
local currentSpeed = 1
-- 刷新角色&重连加速
local speedConn = nil
local currentSpeed = 1
-- 角色销毁/关闭功能自动断开连接
local function updateChar()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if speedConn then
        speedConn:Disconnect()
        speedConn = nil
    end
    if not hum or currentSpeed <= 1 then return end
    -- 降低更新频率，不用每帧
    speedConn = RunService.Heartbeat:Connect(function()
        if not LocalPlayer.Character then
            speedConn:Disconnect()
            speedConn = nil
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
Tabs.wj:Code({
    Title = "你好🟡",
    Code = "QQ售后1109337389"
})
Tabs.wj:Code({
    Title = "你好🟢",
    Code = "dc群https://discord.gg/rEAd5RdNe请加入dc"
})
Tabs.wj:Input({
    Title = "超级快跑",
    Placeholder = "输入1~200数字",
    Default = "1",
    Numeric = true,
    Callback = function(val)
        local num = tonumber(val)
        if not num then return end
        currentSpeed = math.clamp(num,1,200)
        updateChar()
    end
})
Tabs.wj:Slider({
    Title = "超级快跑",
    Desc = "",
    Value = {Min = 1, Max = 200, Default = 1},
    Step = 1,
    IsTextbox = true,
    Callback = function(val)
        currentSpeed = val
        updateChar()
    end
})
-- ==================== 玩家页：飞行（WindUI防检测版） ====================
local FlyingEnabled = false
local FlightSpeed = 150
local CurrentAO, CurrentLV, CurrentMoverAttachment, FlightConnection
local flyHumanoid = nil

-- ⭐ 核心防检测 Hook (拦截服务器读取你的速度)
local mt_fly = getrawmetatable(game)
local old_fly_index = mt_fly.__index
setreadonly(mt_fly, false)
mt_fly.__index = newcclosure(function(self, key)
    if FlyingEnabled and (key == "AssemblyLinearVelocity" or key == "Velocity") and self:IsA("BasePart") then
        return Vector3.new(0, 0, 0)
    end
    return old_fly_index(self, key)
end)
setreadonly(mt_fly, true)

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

    pcall(function() character.HumanoidRootPart:SetNetworkOwner(LocalPlayer) end)

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
end

-- ==================== WindUI 控件 ====================
Tabs.wj:Toggle({
    Title = "飞行模式",
    Desc = "",
    Default = false,
    Callback = function(v)
        if v then
            startFlying()
            WindUI:Notify({ Title = "飞行", Content = "已开启", Duration = 3 })
        else
            stopFlying()
            WindUI:Notify({ Title = "飞行", Content = "已关闭", Duration = 3 })
        end
    end
})

Tabs.wj:Slider({
    Title = "飞行速度",
    Desc = "",
    Value = {
        Min = 50,
        Max = 400,
        Default = 150
    },
    Step = 10,
    IsTextbox = true,
    Callback = function(val)
        FlightSpeed = val
    end
})
-- =================== 旋转模块（完全修复版） ===================

local SpinEnabled = false
local SpinSpeed = 5
local SpinConnection = nil

-- ⭐线程控制（核心修复）
local AnimationLockThread = nil
-- ================= 开始旋转 =================
local function StartSpin()

    if SpinConnection then return end

    local plr = game.Players.LocalPlayer

    SpinConnection = game:GetService("RunService").RenderStepped:Connect(function(dt)

        if not SpinEnabled then return end

        local char = plr.Character
        if not char then return end

        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(SpinSpeed) * dt * 60, 0)

    end)

    ApplyAnimationLock(plr.Character)
end

-- ================= 停止旋转 =================
local function StopSpin()

    SpinEnabled = false -- ⭐必须

    if SpinConnection then
        SpinConnection:Disconnect()
        SpinConnection = nil
    end

    RemoveAnimationLock(game.Players.LocalPlayer.Character)
end

-- ================= 重生修复 =================
game.Players.LocalPlayer.CharacterAdded:Connect(function(char)

    if SpinEnabled then

        task.wait(0.5)

        ApplyAnimationLock(char)

        if not SpinConnection then
            StartSpin()
        end
    end
end)

Tabs.wj:Toggle({
    Title = "人物自转",
    Default = false,
    Callback = function(v)

        SpinEnabled = v

        if v then
            StartSpin()
            AddFeature("自转")
        else
            StopSpin()
            RemoveFeature("自转")
        end

    end
})

-- ⭐ Input → Slider（稳定）
Tabs.wj:Slider({
    Title = "旋转速度",
    Value = {
        Min = 1,
        Max = 200,
        Default = SpinSpeed,
    },
    Increment = 5,
    Callback = function(v)
        SpinSpeed = v
    end
})
-- ============================================
-- WindUI - 其他玩家头部缩放（本地修改）
-- ============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- ========== 配置 ==========
local CONFIG = {
    defaultSize = 1,
    minSize = 1,
    maxSize = 5000,
    loadDelay = 0.15,
}

-- ========== 状态管理 ==========
local HeadScaler = {
    enabled = false,
    headSize = CONFIG.defaultSize,
    heartbeatConn = nil,
    playerAddedConn = nil,
    charBindings = {},
    _initialized = false,
}

-- ========== 核心功能 ==========

function HeadScaler:UpdateAllHeads()
    local size = Vector3.new(self.headSize, self.headSize, self.headSize)
    local localPlayer = Players.LocalPlayer
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player == localPlayer then continue end
        
        local character = player.Character
        if not character then continue end
        
        local head = character:FindFirstChild("Head")
        if not head then continue end
        
        pcall(function()
            head.Size = size
            head.CanCollide = false
        end)
    end
end

function HeadScaler:BindPlayer(player)
    if self.charBindings[player] then return end
    
    local conn = player.CharacterAdded:Connect(function()
        task.wait(CONFIG.loadDelay)
        self:UpdateAllHeads()
    end)
    
    self.charBindings[player] = conn
    
    -- 立即处理当前角色
    task.spawn(function()
        task.wait(CONFIG.loadDelay)
        self:UpdateAllHeads()
    end)
end

function HeadScaler:UnbindPlayer(player)
    local conn = self.charBindings[player]
    if conn then
        conn:Disconnect()
        self.charBindings[player] = nil
    end
end

function HeadScaler:ClearAll()
    -- 清理心跳
    if self.heartbeatConn then
        self.heartbeatConn:Disconnect()
        self.heartbeatConn = nil
    end
    
    -- 清理玩家加入事件
    if self.playerAddedConn then
        self.playerAddedConn:Disconnect()
        self.playerAddedConn = nil
    end
    
    -- 清理所有角色绑定
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
    
    -- 开启功能
    local localPlayer = Players.LocalPlayer
    
    -- 1. 心跳连接
    self.heartbeatConn = RunService.Heartbeat:Connect(function()
        self:UpdateAllHeads()
    end)
    
    -- 2. 绑定已有玩家
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            self:BindPlayer(player)
        end
    end
    
    -- 3. 监听新玩家
    self.playerAddedConn = Players.PlayerAdded:Connect(function(player)
        if player ~= localPlayer then
            self:BindPlayer(player)
        end
    end)
    
    -- 4. 立即执行
    self:UpdateAllHeads()
end

function HeadScaler:SetSize(newSize)
    local clamped = math.clamp(newSize, CONFIG.minSize, CONFIG.maxSize)
    self.headSize = clamped
    
    if self.enabled then
        self:UpdateAllHeads()
    end
end

-- ========== 初始化 ==========

function HeadScaler:Init()
    if self._initialized then return end
    self._initialized = true
    
    -- 玩家离开时自动清理
    Players.PlayerRemoving:Connect(function(player)
        self:UnbindPlayer(player)
    end)
    
    print("[HeadScaler] 初始化完成 ✅")
end

-- ========== WindUI 控件 ==========

-- 初始化
HeadScaler:Init()

-- 🎛️ 开关控件
Tabs.wj:Toggle({
    Title = "修改别人头部大小",
    Default = false,
    Callback = function(value)
        HeadScaler:SetEnabled(value)
    end
})

-- 📝 输入控件
Tabs.wj:Input({
    Title = "别人头部尺寸",
    Placeholder = "输入数字 1-5000",
    Default = tostring(CONFIG.defaultSize),
    Numeric = true,
    Callback = function(value)
        local num = tonumber(value)
        if num then
            HeadScaler:SetSize(num)
        end
    end
})

-- ========== 调试命令 ==========

-- 在控制台输入 HeadScalerStatus() 查看状态
_G.HeadScalerStatus = function()
    local count = 0
    for _ in pairs(HeadScaler.charBindings) do count = count + 1 end
    
    print(string.format(
        [[
📊 HeadScaler 状态
├─ 启用: %s
├─ 尺寸: %.2f
├─ 绑定玩家: %d
└─ 心跳: %s
        ]],
        HeadScaler.enabled and "✅ 是" or "❌ 否",
        HeadScaler.headSize,
        count,
        HeadScaler.heartbeatConn and "🟢 运行中" or "🔴 已停止"
    ))
end

print("💡 输入 HeadScalerStatus() 查看状态")
Tabs.wj:Button({
    Title = "取消坠落状态",
    Callback = function()
        local mt = getrawmetatable(game)
local old = mt.__index
setreadonly(mt, false)

mt.__index = newcclosure(function(self, key)
    if (key == "AssemblyLinearVelocity" or key == "Velocity") and self:IsA("BasePart") then
        return Vector3.new(0, 0, 0)
    end
    return old(self, key)
end)

setreadonly(mt, true)
    end
})
Tabs.wj:Toggle({
    Title = "无限跳",
    Desc = "",
    Value = false,
    Callback = function(state)
        isInfiniteJumpEnabled = state
    end
})
Tabs.wj:Toggle({
    Title = "穿墙",
    Desc = "",
    Value = false,
    Callback = function(enabled)
        local RunService = game:GetService("RunService")
        local LocalPlayer = game:GetService("Players").LocalPlayer
        if clipConn then
            clipConn:Disconnect()
            clipConn = nil
        end
        if enabled then
            clipConn = RunService.Stepped:Connect(function()
                local char = LocalPlayer.Character
                if not char then return end
                for _, part in ipairs(char:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end)
        else
            --关闭穿墙：恢复碰撞
            local char = LocalPlayer.Character
            if char then
                for _, part in ipairs(char:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
})
Tabs.wj:Button({
    Title = "踏空行走",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float'))()
    end
})
-- ==================== 键位修改（拖拽 + 缩放 + 一键重置） ====================
do
    local uis = game:GetService("UserInputService")
    local run = game:GetService("RunService")
    local lp = game:GetService("Players").LocalPlayer

    local active = false
    local dragging = false
    local draggingObj = nil
    local startPos = nil
    local touchStart = nil
    local latestPos = nil
    local highlight = nil

    -- ⭐ 选中 + 缩放状态
    local selectedObj = nil
    local selectedHL = nil
    local originalSizes = {}
    local objScales = {}
    local scaleVal = 1.0

    -- ⭐ 记录原始位置，用于一键重置
    local originalPositions = {}

    local function getTouchProfiles()
        local pg = lp:FindFirstChild("PlayerGui")
        if not pg then return nil end
        local screen = pg:FindFirstChild("InputButtonsScreen")
        if not screen then return nil end
        return screen:FindFirstChild("TouchProfiles")
    end

    -- ⭐ 清理所有高亮框（内存引用 + 残留 UIStroke 兜底）
    local function clearAllHighlights()
        if highlight then pcall(function() highlight:Destroy() end); highlight = nil end
        if selectedHL then pcall(function() selectedHL:Destroy() end); selectedHL = nil end

        local profiles = getTouchProfiles()
        if profiles then
            for _, v in ipairs(profiles:GetDescendants()) do
                if v:IsA("GuiObject") then
                    for _, c in ipairs(v:GetChildren()) do
                        if c:IsA("UIStroke") and (c.Name == "__DragHL" or c.Name == "__SelHL") then
                            pcall(function() c:Destroy() end)
                        end
                    end
                end
            end
        end
    end

    -- 暴力拆除父级限制，防止拖出去被弹回
    local function breakLayout(obj)
        pcall(function()
            local parent = obj.Parent
            if parent then
                for _, child in ipairs(parent:GetChildren()) do
                    if child:IsA("UIListLayout") or child:IsA("UIGridLayout") or child:IsA("UIPositionConstraint") then
                        child:Destroy()
                    end
                end
            end
            for _, child in ipairs(obj:GetChildren()) do
                if child:IsA("UIAspectRatioConstraint") or child:IsA("UIPositionConstraint") then
                    child:Destroy()
                end
            end
        end)
    end

    local function findButton(pos)
        local profiles = getTouchProfiles()
        if not profiles then return nil end
        for _, v in ipairs(profiles:GetDescendants()) do
            if v:IsA("GuiObject") and v.Visible then
                local ap, sz = v.AbsolutePosition, v.AbsoluteSize
                if sz.X >= 20 and sz.Y >= 20 and sz.X <= 250 and sz.Y <= 250 then
                    if pos.X >= ap.X and pos.X <= ap.X + sz.X and pos.Y >= ap.Y and pos.Y <= ap.Y + sz.Y then
                        return v
                    end
                end
            end
        end
        return nil
    end

    local function applyPos()
        if not dragging or not draggingObj or not draggingObj.Parent then return end
        if not latestPos or not touchStart or not startPos then return end
        local delta = latestPos - touchStart
        pcall(function()
            draggingObj.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end)
    end

    local function applyScale(obj, scale)
        if not obj or not obj.Parent then return end
        if not originalSizes[obj] then
            originalSizes[obj] = obj.Size
        end
        local o = originalSizes[obj]
        pcall(function()
            obj.Size = UDim2.new(
                o.X.Scale * scale, math.floor(o.X.Offset * scale + 0.5),
                o.Y.Scale * scale, math.floor(o.Y.Offset * scale + 0.5)
            )
        end)
    end

    local function selectObj(obj)
        if selectedHL then pcall(function() selectedHL:Destroy() end); selectedHL = nil end
        selectedObj = obj
        if not obj then return end
        if not originalSizes[obj] then originalSizes[obj] = obj.Size end
        if not objScales[obj] then objScales[obj] = 1.0 end
        selectedHL = Instance.new("UIStroke", obj)
        selectedHL.Name = "__SelHL"
        selectedHL.Color = Color3.fromRGB(255, 200, 0)
        selectedHL.Thickness = 3
        selectedHL.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    end

    local function beginDrag(pos)
        if not active or dragging then return end
        local obj = findButton(pos)
        if not obj then return end
        if not originalPositions[obj] then
            originalPositions[obj] = obj.Position
        end
        breakLayout(obj)
        dragging = true
        draggingObj = obj
        startPos = obj.Position
        touchStart = pos
        latestPos = pos
        if highlight then highlight:Destroy() end
        highlight = Instance.new("UIStroke", obj)
        highlight.Name = "__DragHL"
        highlight.Color = Color3.fromRGB(0, 255, 130)
        highlight.Thickness = 3
        highlight.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        selectObj(obj)
    end

    local function endDrag()
        if highlight then pcall(function() highlight:Destroy() end); highlight = nil end
        dragging = false
        draggingObj = nil
        startPos = nil
        touchStart = nil
        latestPos = nil
    end

    -- ==================== 输入事件 ====================
    uis.InputBegan:Connect(function(input, gameProcessed)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            beginDrag(input.Position)
        end
    end)

    uis.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
            latestPos = input.Position
            applyPos()
        end
    end)

    uis.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            if dragging then endDrag() end
        end
    end)

    run.RenderStepped:Connect(function()
        applyPos()
    end)

    -- ==================== WindUI 控件 ====================
    Tabs.jw:Section({ Title = "拖拽开关" })

    Tabs.jw:Toggle({
        Title = "开启无延迟拖拽",
        Desc = "",
        Default = false,
        Flag = "EnableDrag",
        Callback = function(v)
            active = v
            if v then
                -- ⭐ 开启时先清一次残留（防上次异常退出留下的框）
                clearAllHighlights()
                WindUI:Notify({ Title = "已开启", Content = "点击按钮选中后可拖动滑块缩放", Duration = 3 })
            else
                -- ⭐ 关闭时彻底清理：绿框、黄框、选中状态、拖拽状态
                endDrag()
                selectObj(nil)
                clearAllHighlights()
                WindUI:Notify({ Title = "已关闭", Content = "拖拽已停止，高亮已清除", Duration = 3 })
            end
        end,
    })

    -- ⭐ 缩放设置
    Tabs.jw:Section({ Title = "缩放选中按钮" })

    Tabs.jw:Slider({
        Title = "缩放倍率",
        Desc = "",
        Value = { Min = 0.3, Max = 3.0, Default = 1.0 },
        Step = 0.05,
        IsTextbox = true,
        Flag = "BtnScale",
        Callback = function(v)
            scaleVal = v
            if selectedObj and selectedObj.Parent then
                objScales[selectedObj] = v
                applyScale(selectedObj, v)
            end
        end,
    })

    Tabs.jw:Button({
        Title = "恢复选中按钮原始大小",
        Desc = "",
        Callback = function()
            if not selectedObj or not selectedObj.Parent then
                WindUI:Notify({ Title = "提示", Content = "请先点击一个按钮选中它", Duration = 2 })
                return
            end
            if originalSizes[selectedObj] then
                pcall(function() selectedObj.Size = originalSizes[selectedObj] end)
            end
            objScales[selectedObj] = 1.0
            WindUI:Notify({ Title = "已恢复", Content = "选中按钮已恢复原始大小", Duration = 2 })
        end,
    })

    Tabs.jw:Button({
        Title = "取消选中",
        Desc = "",
        Callback = function()
            selectObj(nil)
        end,
    })

    -- ⭐ 恢复设置
    Tabs.jw:Section({ Title = "恢复设置" })

    Tabs.jw:Button({
        Title = "一键重置所有按钮",
        Desc = "",
        Callback = function()
            local count = 0
            for obj, pos in pairs(originalPositions) do
                if obj and obj.Parent then
                    pcall(function() obj.Position = pos end)
                    count = count + 1
                end
            end
            for obj, sz in pairs(originalSizes) do
                if obj and obj.Parent then
                    pcall(function() obj.Size = sz end)
                end
            end
            table.clear(originalSizes)
            table.clear(objScales)
            scaleVal = 1.0
            endDrag()
            selectObj(nil)
            clearAllHighlights()

            WindUI:Notify({
                Title = "重置成功",
                Content = "已恢复 " .. count .. " 个按钮到初始状态",
                Duration = 3
            })
        end
    })
end


Tabs.lup:Button({
    Title = "删除忍者图标和脚本",
    Callback = function()
        local CoreGui = game:GetService("CoreGui")
local targetHash = "fdcc4aea07a75898254f573dbd0c67061fc06e508fdd69b5dbfde0ba64913d0c"
local deleted = false

for _, child in ipairs(CoreGui:GetChildren()) do
    if string.find(child.Name, targetHash, 1, true) then
        local ok, err = pcall(function()
            child:Destroy()
        end)
        
        if ok then
            print("✅ 成功删除核心文件夹: " .. targetHash)
            deleted = true
        else
            warn("❌ 尝试删除失败（可能被保护）: " .. tostring(err))
        end
    end
end

if not deleted then
    for _, v in ipairs(CoreGui:GetDescendants()) do
        if string.find(v.Name, targetHash, 1, true) then
            local ok = pcall(function() v:Destroy() end)
            if ok then
                print("✅ 深度遍历成功删除: " .. v.Name)
                deleted = true
            end
        end
    end
end

if not deleted then
    print("未找到该目标文件夹，它可能已经被游戏重新加载或已被清理。")
else
    print("清理完成！")
end
    end
})

local btHbSize = 8
local btHbConn = nil
local btCharConns = {} -- 记录玩家的重生事件

local function btExpandPlayer(player)
    if player == LocalPlayer then return end
    local char = player.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return end
    local hrpX = char:FindFirstChild("HumanoidRootPart")
    if not hrpX then return end
    
    local size = math.clamp(btHbSize, 1, 100)
    pcall(function()
        hrpX.Size = Vector3.new(size, size, size)
        
        -- ⭐ 核心修改：完全透明隐身，并关闭阴影
        hrpX.Transparency = 1 
        hrpX.CastShadow = false
        
        hrpX.Color = Color3.fromRGB(190, 190, 190)
        hrpX.Material = Enum.Material.SmoothPlastic -- 纯透明不需要发光，换普通材质
        hrpX.CanCollide = false
    end)
end

local function btResetPlayer(player)
    if player == LocalPlayer then return end 
    local char = player.Character
    if not char then return end
    local hrpX = char:FindFirstChild("HumanoidRootPart")
    if not hrpX then return end
    pcall(function()
        hrpX.Size = Vector3.new(2, 2, 1) 
        hrpX.Transparency = 1            
        hrpX.CastShadow = true -- 恢复阴影
        hrpX.Color = Color3.fromRGB(163, 162, 165)
        hrpX.Material = Enum.Material.Plastic
        hrpX.CanCollide = true
    end)
end

local function btBindPlayer(player)
    if player == LocalPlayer then return end
    if btCharConns[player] then
        btCharConns[player]:Disconnect()
        btCharConns[player] = nil
    end
    btCharConns[player] = player.CharacterAdded:Connect(function()
        task.wait(1)
        if btHbConn then
            btExpandPlayer(player)
        end
    end)
end

-- ⭐ 已把挂载点从 Tabs.bot 改为 Tabs.lup
Tabs.lup:Toggle({
    Title = "范围 ",
    Desc = "",
    Default = false,
    Callback = function(state)
        if state then
            -- 先清理旧连接
            if btHbConn then btHbConn:Disconnect() end
            for _, conn in pairs(btCharConns) do pcall(function() conn:Disconnect() end) end
            table.clear(btCharConns)

            -- 开启循环放大
            btHbConn = RunService.Heartbeat:Connect(function()
                for _, p in ipairs(Players:GetPlayers()) do
                    btExpandPlayer(p)
                end
            end)

            -- 绑定当前已有玩家
            for _, player in ipairs(Players:GetPlayers()) do
                btBindPlayer(player)
            end
            
            -- 监听新加入的玩家
            if not _G._BTPlayerAddedConn then
                _G._BTPlayerAddedConn = Players.PlayerAdded:Connect(function(p)
                    if btHbConn then
                        btBindPlayer(p)
                    end
                end)
            end
        else
            -- 关闭逻辑
            if btHbConn then
                btHbConn:Disconnect()
                btHbConn = nil
            end
            for _, conn in pairs(btCharConns) do pcall(function() conn:Disconnect() end) end
            table.clear(btCharConns)
            
            if _G._BTPlayerAddedConn then
                _G._BTPlayerAddedConn:Disconnect()
                _G._BTPlayerAddedConn = nil
            end

            -- 还原所有玩家模型
            for _, p in ipairs(Players:GetPlayers()) do
                btResetPlayer(p)
            end
        end
    end,
})

Tabs.lup:Slider({
    Title = "范围大小",
    Desc = "",
    Value = { Min = 0, Max = 100, Default = 8 },
    Step = 1,
    Callback = function(value)
        btHbSize = value
    end,
})
-- ==================== 万圣节：终极怪物光环 (WindUI 适配版 · 已移除 FOV 圈) ====================
do
    local WSJ_Players = game:GetService("Players")
    local WSJ_RunService = game:GetService("RunService")
    local WSJ_Workspace = game:GetService("Workspace")
    local WSJ_LocalPlayer = WSJ_Players.LocalPlayer
    local WSJ_Debris = game:GetService("Debris")
    local WSJ_SoundService = game:GetService("SoundService")
    local WSJ_ReplicatedStorage = game:GetService("ReplicatedStorage")

    local DevvFolder = WSJ_ReplicatedStorage:FindFirstChild("Devv") or WSJ_ReplicatedStorage:FindFirstChild("devv")
    if not DevvFolder then
        WindUI:Notify("未找到 Devv 模块，请进入游戏后使用", 5)
        return
    end

    local DevvModule  = require(DevvFolder)
    local Network     = DevvModule.load("Network")
    local ClientTools = require(WSJ_ReplicatedStorage.Client.Wanted.Modules.ClientTools)
    local MathUtil    = DevvModule.load("MathUtil")
    local nuid        = DevvModule.load("NUID")
    local fireServer  = Network.FireServer

    -- ==================== 状态配置 ====================
    local MobAuraConfig = {
        Enabled  = false,
        Range    = 300,
        Interval = 0.01,
        ShowTracer    = true,
        TracerColor   = Color3.fromRGB(255, 80, 80),
        TracerWidth   = 0.15,
        TracerLife    = 0.2,
        PlaySound     = true,
        SoundId       = "rbxassetid://6607204501",
        SoundVolume   = 0.4,
    }

    local MobChamsConfig = { 
        Enabled = false,
        TextSize = 10,
        EspColor = Color3.fromRGB(0, 255, 0),
    }

    -- ==================== 音效与射线 ====================
    local TracerFolder = WSJ_Workspace:FindFirstChild("__MobTracers") or Instance.new("Folder", WSJ_Workspace)
    TracerFolder.Name = "__MobTracers"

    local function createTracer(fromPos, toPos)
        if not MobAuraConfig.ShowTracer then return end
        pcall(function()
            local a0 = Instance.new("Attachment", TracerFolder); a0.WorldPosition = fromPos
            local a1 = Instance.new("Attachment", TracerFolder); a1.WorldPosition = toPos
            local beam = Instance.new("Beam", TracerFolder)
            beam.Attachment0, beam.Attachment1 = a0, a1
            beam.Color = ColorSequence.new(MobAuraConfig.TracerColor)
            beam.Width0, beam.Width1 = MobAuraConfig.TracerWidth, MobAuraConfig.TracerWidth
            beam.LightEmission, beam.LightInfluence, beam.FaceCamera = 1, 0, true
            beam.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 0.9)})
            WSJ_Debris:AddItem(beam, MobAuraConfig.TracerLife)
            WSJ_Debris:AddItem(a0, MobAuraConfig.TracerLife)
            WSJ_Debris:AddItem(a1, MobAuraConfig.TracerLife)
        end)
    end

    local function playHitSound()
        if not MobAuraConfig.PlaySound then return end
        pcall(function()
            local snd = Instance.new("Sound", WSJ_SoundService)
            snd.SoundId, snd.Volume = MobAuraConfig.SoundId, MobAuraConfig.SoundVolume
            snd:Play(); WSJ_Debris:AddItem(snd, 1)
        end)
    end

    -- ==================== ⭐ 内透 + 底层精准血量 ====================
    WSJ_RunService.RenderStepped:Connect(function()
        local mobsFolder = WSJ_Workspace:FindFirstChild("Mobs")
        if not mobsFolder then return end
        
        if not MobChamsConfig.Enabled then
            for _, mob in ipairs(mobsFolder:GetChildren()) do
                if mob:IsA("Model") then
                    local hl = mob:FindFirstChild("__MobHighlight")
                    if hl then hl:Destroy() end
                    local head = mob:FindFirstChild("Head") or mob:FindFirstChild("HumanoidRootPart")
                    if head then
                        local bb = head:FindFirstChild("__MobNameTag")
                        if bb then bb:Destroy() end
                    end
                end
            end
            return 
        end

        for _, mob in ipairs(mobsFolder:GetChildren()) do
            if mob:IsA("Model") then
                pcall(function()
                    local head = mob:FindFirstChild("Head") or mob:FindFirstChild("HumanoidRootPart")
                    local hum = mob:FindFirstChildOfClass("Humanoid")
                    
                    if head and hum then
                        local hl = mob:FindFirstChild("__MobHighlight")
                        if not hl then
                            hl = Instance.new("Highlight")
                            hl.Name = "__MobHighlight"
                            hl.FillTransparency = 0.3 
                            hl.OutlineTransparency = 0 
                            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            hl.Parent = mob
                        end
                        hl.FillColor = MobChamsConfig.EspColor
                        hl.OutlineColor = MobChamsConfig.EspColor

                        local bb = head:FindFirstChild("__MobNameTag")
                        if not bb then
                            bb = Instance.new("BillboardGui")
                            bb.Name = "__MobNameTag"
                            bb.Size = UDim2.new(0, 100, 0, 25)
                            bb.StudsOffset = Vector3.new(0, 1.5, 0) 
                            bb.AlwaysOnTop = true
                            bb.Parent = head

                            local textName = Instance.new("TextLabel")
                            textName.Name = "TagText"
                            textName.Size = UDim2.new(1, 0, 0.5, 0)
                            textName.BackgroundTransparency = 1
                            textName.Font = Enum.Font.GothamBold
                            textName.TextSize = MobChamsConfig.TextSize
                            textName.TextStrokeTransparency = 0.2
                            textName.TextColor3 = MobChamsConfig.EspColor
                            textName.Text = "港猫的小弟"
                            textName.Parent = bb

                            local textHealth = Instance.new("TextLabel")
                            textHealth.Name = "HealthText"
                            textHealth.Size = UDim2.new(1, 0, 0.5, 0)
                            textHealth.Position = UDim2.new(0, 0, 0.5, 0)
                            textHealth.BackgroundTransparency = 1
                            textHealth.Font = Enum.Font.GothamBold
                            textHealth.TextSize = MobChamsConfig.TextSize
                            textHealth.TextStrokeTransparency = 0.2
                            textHealth.TextColor3 = Color3.new(1, 1, 1)
                            textHealth.Parent = bb
                        end
                        
                        local realHealth = mob:GetAttribute("health")
                        local maxHealth = mob:GetAttribute("maxHealth")
                        if not realHealth then realHealth = hum.Health end
                        if not maxHealth then maxHealth = hum.MaxHealth end

                        local tagText = bb:FindFirstChild("TagText")
                        if tagText then 
                            tagText.TextColor3 = MobChamsConfig.EspColor 
                            tagText.TextSize = MobChamsConfig.TextSize
                        end
                        
                        local healthText = bb:FindFirstChild("HealthText")
                        if healthText then 
                            healthText.Text = string.format("HP: %d/%d", math.floor(realHealth), math.floor(maxHealth))
                            healthText.TextSize = MobChamsConfig.TextSize
                            if realHealth < maxHealth * 0.3 then
                                healthText.TextColor3 = Color3.fromRGB(255, 50, 50)
                            else
                                healthText.TextColor3 = Color3.new(1, 1, 1)
                            end
                        end
                    end
                end)
            end
        end
    end)

    -- ==================== 寻找怪物（纯距离最近，无 FOV 限制） ====================
    local function getClosestMob()
        local myChar = WSJ_LocalPlayer.Character
        if not myChar then return nil end
        local myHRP = myChar:FindFirstChild("HumanoidRootPart")
        if not myHRP then return nil end

        local closestMob = nil
        local minDist = math.huge
        local mobsFolder = WSJ_Workspace:FindFirstChild("Mobs")
        if not mobsFolder then return nil end

        for _, mob in ipairs(mobsFolder:GetChildren()) do
            local hum = mob:FindFirstChildOfClass("Humanoid")
            local hrp = mob:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 0 then
                local dist = (myHRP.Position - hrp.Position).Magnitude
                if dist <= MobAuraConfig.Range and dist < minDist then
                    minDist = dist
                    closestMob = hrp
                end
            end
        end
        return closestMob
    end

    -- ==================== 真实开枪 ====================
    local function fireAtMob(targetPart)
        local char = WSJ_LocalPlayer.Character
        local myHead = char and char:FindFirstChild("Head")
        if not myHead then return end

        local ok, tool = pcall(ClientTools.GetLocalEquippedTool)
        if not ok or not tool or not tool.toolId then return end
        local ts = tool.toolState

        if ts and ts.ammo and ts.ammo <= 0 then
            pcall(fireServer, "reload", tool.toolId)
            pcall(fireServer, "chamber", tool.toolId)
            return
        end

        local targetPos = targetPart.Position
        local originPos = myHead.Position
        local dir = targetPos - originPos
        local bulletId = nuid()
        local shootCF = MathUtil.CompressCFrame(CFrame.new(originPos, targetPos))
        
        pcall(function() fireServer("shoot", tool.toolId, shootCF, { { bulletId, shootCF } }) end)
        if ts and ts.ammo then ts.ammo = ts.ammo - 1 end

        createTracer(originPos, targetPos)
        playHitSound()

        local unit = dir.Magnitude > 0.001 and dir.Unit or myHead.CFrame.LookVector
        local args = {
            {
                massLimit = 5, hit = targetPart, position = targetPos, normal = -unit,
                material = targetPart.Material or Enum.Material.Plastic,
                distance = dir.Magnitude, collisionPoint = targetPos, direction = unit, speed = 1196.285, 
                source = { sourceType = "Bullet", sourceId = bulletId, sourceToolId = tool.toolId, sourcePlayerId = WSJ_LocalPlayer.UserId },
                hitName = "HumanoidRootPart", hitType = "mob", mobType = targetPart.Parent.Name
            }
        }
        pcall(function() fireServer("registerProjectileHits", bulletId, tool.toolId, args) end)
    end

    -- ==================== 主循环 ====================
    task.spawn(function()
        while true do
            if MobAuraConfig.Enabled then
                pcall(function()
                    local mobPart = getClosestMob()
                    if mobPart then fireAtMob(mobPart) end
                end)
                task.wait(MobAuraConfig.Interval)
            else
                task.wait(0.5)
            end
        end
    end)

    -- ==================== WindUI 控件 ====================
    Tabs.wsj:Section({ Title = "自动打怪" })

    Tabs.wsj:Toggle({
        Title = "启用怪物光环",
        Desc = "",
        Default = false,
        Callback = function(v)
            MobAuraConfig.Enabled = v
            WindUI:Notify(v and "怪物光环已开启" or "怪物光环已关闭", 2)
        end,
    })

    Tabs.wsj:Slider({
        Title = "最大攻击距离",
        Value = { Min = 50, Max = 2000, Default = 300 },
        Step = 10,
        Suffix = " studs",
        Callback = function(v) MobAuraConfig.Range = v end,
    })

    Tabs.wsj:Slider({
        Title = "极限射速",
        Value = { Min = 0.01, Max = 1, Default = 0.01 },
        Step = 0.01,
        Callback = function(v) MobAuraConfig.Interval = v end,
    })

    Tabs.wsj:Divider()

    Tabs.wsj:Toggle({
        Title = "显示弹道射线",
        Default = true,
        Callback = function(v) MobAuraConfig.ShowTracer = v end,
    })

    Tabs.wsj:Toggle({
        Title = "播放命中音效",
        Default = true,
        Callback = function(v) MobAuraConfig.PlaySound = v end,
    })

    Tabs.wsj:Dropdown({
        Title = "选择音效",
        Values = { "Neverlose", "Gamesense", "Fatality", "Minecraft", "经典叮叮叮" },
        Default = "Neverlose",
        Callback = function(v)
            local map = {
                ["Neverlose"] = "rbxassetid://6607204501",
                ["Gamesense"] = "rbxassetid://5633695679",
                ["Fatality"] = "rbxassetid://6607142036",
                ["Minecraft"] = "rbxassetid://7151570575",
                ["经典叮叮叮"] = "rbxassetid://4590662766",
            }
            MobAuraConfig.SoundId = map[v] or "rbxassetid://6607204501"
        end,
    })

    Tabs.wsj:Divider()
    Tabs.wsj:Section({ Title = "透视与视觉" })

    Tabs.wsj:Toggle({
        Title = "启用怪物内透",
        Desc = "底层精准血量，防崩溃",
        Default = false,
        Callback = function(v)
            MobChamsConfig.Enabled = v
            WindUI:Notify(v and "怪物内透已开启" or "怪物内透已关闭", 2)
        end,
    })

    Tabs.wsj:Slider({
        Title = "字体大小",
        Value = { Min = 8, Max = 18, Default = 10 },
        Step = 1,
        Callback = function(v) MobChamsConfig.TextSize = v end,
    })

    Tabs.wsj:Dropdown({
        Title = "透视颜色",
        Values = { "绿色", "红色", "蓝色", "紫色", "黄色", "白色" },
        Default = "绿色",
        Callback = function(v)
            local map = {
                ["绿色"] = Color3.fromRGB(0, 255, 0),
                ["红色"] = Color3.fromRGB(255, 50, 50),
                ["蓝色"] = Color3.fromRGB(50, 150, 255),
                ["紫色"] = Color3.fromRGB(180, 50, 255),
                ["黄色"] = Color3.fromRGB(255, 255, 50),
                ["白色"] = Color3.fromRGB(255, 255, 255),
            }
            MobChamsConfig.EspColor = map[v] or Color3.fromRGB(0, 255, 0)
        end,
    })
end
-- ==================== 万圣节刷钥匙（自动路径点 + 节点ESP · WindUI版） ====================
do
    local TweenService = game:GetService("TweenService")
    local LocalPlayer  = game:GetService("Players").LocalPlayer

    -- 预设路径点（按顺序，共 10 个）
    local SPOTS = {
        CFrame.new(1141.173095703125, 104.87025451660156, 1807.316162109375), 
        CFrame.new(-6994.158203125,  53.224830627441406, 3111.651611328125),   
        CFrame.new(-4890.5517578125, 20.991640090942383, 3725.601806640625),   
        CFrame.new(-4436.419921875,  559.4906005859375,  2352.015380859375),   
        CFrame.new(-6338.59765625,   397.233154296875,   -846.17724609375),    
        CFrame.new(-3472.481201171875, 345.2247619628906, 114.20946502685547), 
        CFrame.new(-135.06695556640625, 40.05835723876953, -1750.7685546875), 
        CFrame.new(-1114.73388671875, 181.20816040039062, 3286.400146484375),  
        CFrame.new(702.323486328125,  69.32481384277344,  2820.0419921875),    
        CFrame.new(-6718.154296875, 43.31953048706055, 728.074462890625) 
    }

    local Config = {
        Enabled     = false,
        Loop        = true,
        Speed       = 80,
        WaitAtPoint = 0,
    }

    local running = false
    local index   = 1

    -- ==================== 节点 ESP 标记系统 ====================
    local nodeESPEnabled = false
    local nodeMarkers = {}

    local function updateNodeESP()
        if nodeESPEnabled then
            if #nodeMarkers > 0 then return end -- 已经创建过了
            for i, cf in ipairs(SPOTS) do
                -- 1. 透明锚点 (用来挂载文字)
                local anchor = Instance.new("Part")
                anchor.Name = "NodeAnchor_" .. i
                anchor.Size = Vector3.new(1, 1, 1)
                anchor.Position = cf.Position
                anchor.Anchored = true
                anchor.CanCollide = false
                anchor.Transparency = 1
                anchor.Parent = workspace

                -- 2. 垂直光柱 (醒目)
                local beamPart = Instance.new("Part")
                beamPart.Name = "NodeBeam_" .. i
                beamPart.Size = Vector3.new(1, 200, 1) -- 高200的光柱
                beamPart.CFrame = cf * CFrame.new(0, 100, 0)
                beamPart.Anchored = true
                beamPart.CanCollide = false
                beamPart.Material = Enum.Material.Neon
                beamPart.Color = Color3.fromRGB(0, 255, 160)
                beamPart.Transparency = 0.6
                beamPart.Parent = workspace

                -- 3. 悬浮文字
                local billboard = Instance.new("BillboardGui")
                billboard.Name = "NodeTag_" .. i
                billboard.Size = UDim2.new(0, 100, 0, 50)
                billboard.StudsOffset = Vector3.new(0, 3, 0)
                billboard.AlwaysOnTop = true
                billboard.Adornee = anchor
                billboard.Parent = anchor

                local text = Instance.new("TextLabel")
                text.Size = UDim2.new(1, 0, 1, 0)
                text.BackgroundTransparency = 1
                text.Text = "节点 " .. i
                text.TextColor3 = Color3.fromRGB(0, 255, 160)
                text.TextStrokeTransparency = 0
                text.TextStrokeColor3 = Color3.new(0, 0, 0)
                text.Font = Enum.Font.GothamBold
                text.TextSize = 20
                text.Parent = billboard

                table.insert(nodeMarkers, anchor)
                table.insert(nodeMarkers, beamPart)
            end
        else
            -- 关闭时清理所有标记
            for _, obj in ipairs(nodeMarkers) do
                if obj and obj.Parent then
                    obj:Destroy()
                end
            end
            table.clear(nodeMarkers)
        end
    end
    -- ==========================================================

    local function getHRP()
        local c = LocalPlayer.Character
        return c and c:FindFirstChild("HumanoidRootPart")
    end

    local function tweenTo(hrp, targetCF)
        if not hrp or not hrp.Parent then return false end
        if not Config.Enabled then return false end

        local dist = (hrp.Position - targetCF.Position).Magnitude
        local dur  = math.max(dist / math.max(Config.Speed, 1), 0.1)

        local oldCanCollide = hrp.CanCollide
        hrp.CanCollide = false 

        local tw = TweenService:Create(
            hrp,
            TweenInfo.new(dur, Enum.EasingStyle.Linear),
            { CFrame = targetCF }
        )
        tw:Play()

        while tw.PlaybackState == Enum.PlaybackState.Playing do
            if not Config.Enabled then
                tw:Cancel()
                hrp.CanCollide = oldCanCollide
                return false
            end
            task.wait(0.05)
        end
        
        hrp.CanCollide = oldCanCollide
        return true
    end

    local function waitAtPoint(sec)
        if sec <= 0 then return true end
        local t0 = tick()
        while tick() - t0 < sec do
            if not Config.Enabled then return false end
            task.wait(0.05)
        end
        return true
    end

    local function startRun()
        if running then return end
        if #SPOTS == 0 then
            WindUI:Notify("路径点为空", 3)
            Config.Enabled = false
            return
        end
        running = true
        index = 1

        task.spawn(function()
            while Config.Enabled do
                local hrp = getHRP()
                if not hrp then
                    task.wait(0.5)
                    continue
                end

                local spot = SPOTS[index]
                if not spot then break end

                local ok = tweenTo(hrp, spot)
                if not ok then break end

                if not waitAtPoint(Config.WaitAtPoint) then break end
                if not Config.Enabled then break end

                index = index + 1
                if index > #SPOTS then
                    if Config.Loop then
                        index = 1
                    else
                        Config.Enabled = false
                        WindUI:Notify("路径点已全部跑完", 3)
                        break
                    end
                end

                task.wait(0.05)
            end
            running = false
        end)
    end

    local function stopRun()
        Config.Enabled = false
    end

    -- ==================== WindUI 控件（Tabs.key） ====================
    Tabs.key:Section({ Title = "自动刷钥匙" })

    -- 添加公告提示
    Tabs.key:Paragraph({
        Title = "公告",
        Desc = "开取消坠落状态和穿墙"
    })

    Tabs.key:Toggle({
        Title = "开启自动刷钥匙",
        Desc = "",
        Default = false,
        Callback = function(v)
            Config.Enabled = v
            if v then
                startRun()
                WindUI:Notify("自动刷钥匙已开启", 2)
            else
                stopRun()
                WindUI:Notify("自动刷钥匙已关闭", 2)
            end
        end,
    })

    Tabs.key:Toggle({
        Title = "循环跑图",
        Desc = "",
        Default = true,
        Callback = function(v) Config.Loop = v end,
    })

    Tabs.key:Divider()

    -- 节点透视开关
    Tabs.key:Toggle({
        Title = "显示节点位置标记",
        Desc = "",
        Default = false,
        Callback = function(v)
            nodeESPEnabled = v
            updateNodeESP()
        end,
    })

    Tabs.key:Section({ Title = "参数设置" })

    Tabs.key:Slider({
        Title = "移动速度",
        Desc = "",
        Value = { Min = 10, Max = 80, Default = 80 },
        Step = 5,
        Suffix = " studs/s",
        Callback = function(v) Config.Speed = v end,
    })

    Tabs.key:Slider({
        Title = "每个节点等待时间",
        Desc = "",
        Value = { Min = 0, Max = 10, Default = 0 },
        Step = 0.1,
        Suffix = " 秒",
        Callback = function(v) Config.WaitAtPoint = v end,
    })
end
-- ==================== 屏幕准星（挂载到 Tabs.zx） ====================
do
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")

    -- ==================== 配置 ====================
    local CFG = {
        Enabled       = true,
        Style         = "十字",
        Color         = Color3.fromRGB(0, 255, 160),
        Size          = 12,
        Thickness     = 2,
        Gap           = 4,
        Transparency  = 0,
        DotSize       = 2,
        FollowMouse   = false,
        Rotate        = false,
        RotateSpeed   = 60,
        Rotation      = 0,
        AutoColor     = true,
        ColorSpeed    = 0.3,
        ColorHue      = 0,
    }

    -- ==================== ScreenGui ====================
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CustomCrosshair"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.DisplayOrder = 9999

    local ok = pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
    if not ok or not ScreenGui.Parent then
        ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end

    -- 准星容器
    local Container = Instance.new("Frame")
    Container.Name = "Container"
    Container.AnchorPoint = Vector2.new(0.5, 0.5)
    Container.Position = UDim2.fromScale(0.5, 0.5)
    Container.Size = UDim2.fromOffset(100, 100)
    Container.BackgroundTransparency = 1
    Container.Parent = ScreenGui

    -- 线条容器
    local Lines = Instance.new("Frame")
    Lines.Name = "Lines"
    Lines.AnchorPoint = Vector2.new(0.5, 0.5)
    Lines.Position = UDim2.fromScale(0.5, 0.5)
    Lines.Size = UDim2.fromOffset(0, 0)
    Lines.BackgroundTransparency = 1
    Lines.Parent = Container

    local Elements = {}

    local function ClearElements()
        for _, el in ipairs(Elements) do
            if el and el.Parent then el:Destroy() end
        end
        table.clear(Elements)
    end

    local function CreateLine(width, height, offsetX, offsetY)
        local line = Instance.new("Frame")
        line.AnchorPoint = Vector2.new(0.5, 0.5)
        line.Position = UDim2.new(0.5, offsetX, 0.5, offsetY)
        line.Size = UDim2.fromOffset(width, height)
        line.BackgroundColor3 = CFG.Color
        line.BackgroundTransparency = CFG.Transparency
        line.BorderSizePixel = 0
        line.Parent = Lines
        table.insert(Elements, line)
        return line
    end

    local function CreateDot(size)
        local dot = Instance.new("Frame")
        dot.AnchorPoint = Vector2.new(0.5, 0.5)
        dot.Position = UDim2.fromScale(0.5, 0.5)
        dot.Size = UDim2.fromOffset(size, size)
        dot.BackgroundColor3 = CFG.Color
        dot.BackgroundTransparency = CFG.Transparency
        dot.BorderSizePixel = 0
        dot.Parent = Lines
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = dot
        table.insert(Elements, dot)
        return dot
    end

    local function CreateCircle(size, thickness)
        local circle = Instance.new("Frame")
        circle.AnchorPoint = Vector2.new(0.5, 0.5)
        circle.Position = UDim2.fromScale(0.5, 0.5)
        circle.Size = UDim2.fromOffset(size, size)
        circle.BackgroundTransparency = 1
        circle.Parent = Lines
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = circle
        local stroke = Instance.new("UIStroke")
        stroke.Color = CFG.Color
        stroke.Thickness = thickness
        stroke.Transparency = CFG.Transparency
        stroke.Parent = circle
        table.insert(Elements, circle)
        return circle
    end

    local function UpdateElementColors()
        for _, el in ipairs(Elements) do
            if el:IsA("Frame") then
                local stroke = el:FindFirstChildOfClass("UIStroke")
                if stroke then
                    stroke.Color = CFG.Color
                    stroke.Transparency = CFG.Transparency
                else
                    el.BackgroundColor3 = CFG.Color
                    el.BackgroundTransparency = CFG.Transparency
                end
            end
        end
    end

    local function DrawCrosshair()
        ClearElements()
        if not CFG.Enabled then return end

        local S = CFG.Size
        local T = CFG.Thickness
        local G = CFG.Gap
        local style = CFG.Style

        if style == "十字" then
            CreateLine(T, S, 0, -(G + S/2))
            CreateLine(T, S, 0, (G + S/2))
            CreateLine(S, T, -(G + S/2), 0)
            CreateLine(S, T, (G + S/2), 0)

        elseif style == "点" then
            CreateDot(CFG.DotSize * 2)

        elseif style == "圆" then
            CreateCircle(S * 2, T)

        elseif style == "十字+点" then
            CreateLine(T, S, 0, -(G + S/2))
            CreateLine(T, S, 0, (G + S/2))
            CreateLine(S, T, -(G + S/2), 0)
            CreateLine(S, T, (G + S/2), 0)
            CreateDot(CFG.DotSize * 2)

        elseif style == "圆+点" then
            CreateCircle(S * 2, T)
            CreateDot(CFG.DotSize * 2)

        elseif style == "X形" then
            local offsets = {
                {G + S/2, 0},
                {-(G + S/2), 0},
                {0, G + S/2},
                {0, -(G + S/2)},
            }
            for _, off in ipairs(offsets) do
                local line = CreateLine(T, S, off[1], off[2])
                line.Rotation = 45
            end

        elseif style == "括号" then
            local bracketSize = S
            CreateLine(bracketSize, T, 0, -(G + bracketSize))
            CreateLine(T, T * 3, -(bracketSize/2), -(G + bracketSize) + T * 1.5)
            CreateLine(T, T * 3, (bracketSize/2), -(G + bracketSize) + T * 1.5)
            CreateLine(bracketSize, T, 0, (G + bracketSize))
            CreateLine(T, T * 3, -(bracketSize/2), (G + bracketSize) - T * 1.5)
            CreateLine(T, T * 3, (bracketSize/2), (G + bracketSize) - T * 1.5)
            CreateLine(T, bracketSize, -(G + bracketSize), 0)
            CreateLine(T * 3, T, -(G + bracketSize) + T * 1.5, -(bracketSize/2))
            CreateLine(T * 3, T, -(G + bracketSize) + T * 1.5, (bracketSize/2))
            CreateLine(T, bracketSize, (G + bracketSize), 0)
            CreateLine(T * 3, T, (G + bracketSize) - T * 1.5, -(bracketSize/2))
            CreateLine(T * 3, T, (G + bracketSize) - T * 1.5, (bracketSize/2))
        end

        UpdateElementColors()
    end

    -- ==================== 主循环 ====================
    RunService.RenderStepped:Connect(function(dt)
        if CFG.FollowMouse then
            local mouse = UserInputService:GetMouseLocation()
            Container.Position = UDim2.fromOffset(mouse.X, mouse.Y)
        else
            Container.Position = UDim2.fromScale(0.5, 0.5)
        end

        if CFG.Rotate then
            CFG.Rotation = (CFG.Rotation + CFG.RotateSpeed * dt) % 360
            Container.Rotation = CFG.Rotation
        end

        if CFG.AutoColor then
            CFG.ColorHue = (CFG.ColorHue + CFG.ColorSpeed * dt) % 1
            CFG.Color = Color3.fromHSV(CFG.ColorHue, 1, 1)
            UpdateElementColors()
        end
    end)

    -- ==================== 万圣节：僵尸范围（NPC 批量标记 + 实体放大） ====================
do
    local RunService = game:GetService("RunService")

    -- 状态
    local ZM_Enabled        = false
    local ZM_ScaleMultiplier = 2.0
    local ZM_HighlightColor  = Color3.fromRGB(255, 50, 50)
    local ZM_OrigData        = {}   -- [mob] = { Scale = number }
    local ZM_Conn            = nil

    -- 清理：删高亮 + 还原尺寸
    local function ZM_Cleanup()
        local mobsFolder = workspace:FindFirstChild("Mobs")
        if mobsFolder then
            for _, mob in ipairs(mobsFolder:GetChildren()) do
                if mob:IsA("Model") then
                    local hl = mob:FindFirstChild("NPC_Marker")
                    if hl then hl:Destroy() end
                    if ZM_OrigData[mob] then
                        pcall(function() mob:ScaleTo(ZM_OrigData[mob].Scale) end)
                    end
                end
            end
        end
        table.clear(ZM_OrigData)
    end

    -- 每帧处理
    local function ZM_Tick()
        local mobsFolder = workspace:FindFirstChild("Mobs")
        if not mobsFolder then return end

        for _, mob in ipairs(mobsFolder:GetChildren()) do
            if mob:IsA("Model") then
                local hum = mob:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    -- 1. 高亮标记
                    local hl = mob:FindFirstChild("NPC_Marker")
                    if not hl then
                        hl = Instance.new("Highlight")
                        hl.Name                = "NPC_Marker"
                        hl.DepthMode           = Enum.HighlightDepthMode.AlwaysOnTop
                        hl.FillTransparency    = 0.5
                        hl.OutlineTransparency = 0
                        hl.Parent              = mob
                    end
                    hl.FillColor    = ZM_HighlightColor
                    hl.OutlineColor = ZM_HighlightColor

                    -- 2. 记录原始尺寸
                    if not ZM_OrigData[mob] then
                        local origScale = 1
                        pcall(function() origScale = mob:GetScale() end)
                        ZM_OrigData[mob] = { Scale = origScale }
                    end

                    -- 3. 按倍数缩放
                    local targetScale  = ZM_OrigData[mob].Scale * ZM_ScaleMultiplier
                    local currentScale = 1
                    pcall(function() currentScale = mob:GetScale() end)

                    if math.abs(currentScale - targetScale) > 0.01 then
                        pcall(function()
                            mob:ScaleTo(targetScale)
                            -- 强制实体不透明 + 碰撞 + 免质量，防子弹穿透 / 变大后飞天
                            for _, part in ipairs(mob:GetDescendants()) do
                                if part:IsA("BasePart") then
                                    part.Transparency = 0
                                    part.CanCollide   = true
                                    part.Massless     = true
                                end
                            end
                        end)
                    end
                end
            end
        end
    end

    local function ZM_Start()
        if ZM_Conn then return end
        ZM_Conn = RunService.RenderStepped:Connect(ZM_Tick)
    end

    local function ZM_Stop()
        if ZM_Conn then
            ZM_Conn:Disconnect()
            ZM_Conn = nil
        end
        ZM_Cleanup()
    end

    -- ==================== UI 控件（挂 Tabs.wsj） ====================
    Tabs.wsj:Section({ Title = "僵尸范围" })

    Tabs.wsj:Toggle({
        Title   = "开启",
        Desc    = "",
        Default = false,
        Callback = function(v)
            ZM_Enabled = v
            if v then
                ZM_Start()
                WindUI:Notify({ Title = "僵尸范围", Content = "已开启", Icon = "check", Duration = 2 })
            else
                ZM_Stop()
                WindUI:Notify({ Title = "僵尸范围", Content = "已关闭并恢复原样", Icon = "x", Duration = 2 })
            end
        end,
    })

    Tabs.wsj:Slider({
        Title   = "实体放大倍数",
        Desc    = "",
        Value   = { Min = 1.0, Max = 5.0, Default = 2.0 },
        Step    = 0.5,
        Callback = function(v) ZM_ScaleMultiplier = v end,
    })

    Tabs.wsj:Dropdown({
        Title   = "高亮颜色",
        Desc    = "",
        Values  = { "红色", "绿色", "蓝色", "黄色", "紫色", "白色", "青色" },
        Default = "红色",
        Callback = function(v)
            local map = {
                ["红色"] = Color3.fromRGB(255, 50, 50),
                ["绿色"] = Color3.fromRGB(50, 255, 50),
                ["蓝色"] = Color3.fromRGB(50, 150, 255),
                ["黄色"] = Color3.fromRGB(255, 255, 50),
                ["紫色"] = Color3.fromRGB(180, 50, 255),
                ["白色"] = Color3.fromRGB(255, 255, 255),
                ["青色"] = Color3.fromRGB(50, 255, 255),
            }
            ZM_HighlightColor = map[v] or Color3.fromRGB(255, 50, 50)
        end,
    })
end
    -- ==================== WindUI 控件（挂 Tabs.zx） ====================
    Tabs.zx:Section({ Title = "准星控制" })

    Tabs.zx:Toggle({
        Title = "启用准星",
        Desc = "",
        Default = true,
        Callback = function(v)
            CFG.Enabled = v
            Container.Visible = v
            DrawCrosshair()
        end,
    })

    Tabs.zx:Dropdown({
        Title = "准星样式",
        Desc = "",
        Values = { "十字", "点", "圆", "十字+点", "圆+点", "X形", "括号" },
        Default = "十字",
        Callback = function(v)
            CFG.Style = v
            DrawCrosshair()
        end,
    })

    Tabs.zx:Toggle({
        Title = "跟随鼠标",
        Desc = "",
        Default = false,
        Callback = function(v) CFG.FollowMouse = v end,
    })

    Tabs.zx:Divider()

    Tabs.zx:Section({ Title = "旋转" })

    Tabs.zx:Toggle({
        Title = "启用旋转",
        Desc = "",
        Default = false,
        Callback = function(v)
            CFG.Rotate = v
            if not v then
                CFG.Rotation = 0
                Container.Rotation = 0
            end
        end,
    })

    Tabs.zx:Slider({
        Title = "旋转速度",
        Desc = "",
        Value = { Min = 5, Max = 360, Default = 60 },
        Step = 5,
        Callback = function(v) CFG.RotateSpeed = v end,
    })

    Tabs.zx:Divider()

    Tabs.zx:Section({ Title = "自动变色" })

    Tabs.zx:Toggle({
        Title = "启用自动变色",
        Desc = "",
        Default = true,
        Callback = function(v) CFG.AutoColor = v end,
    })

    Tabs.zx:Slider({
        Title = "变色速度",
        Desc = "",
        Value = { Min = 0.05, Max = 2, Default = 0.3 },
        Step = 0.05,
        Callback = function(v) CFG.ColorSpeed = v end,
    })

    Tabs.zx:Divider()

    Tabs.zx:Section({ Title = "外观调节" })

    Tabs.zx:Slider({
        Title = "准星大小",
        Value = { Min = 2, Max = 40, Default = 12 },
        Step = 1,
        Callback = function(v)
            CFG.Size = v
            DrawCrosshair()
        end,
    })

    Tabs.zx:Slider({
        Title = "线条厚度",
        Value = { Min = 1, Max = 8, Default = 2 },
        Step = 1,
        Callback = function(v)
            CFG.Thickness = v
            DrawCrosshair()
        end,
    })

    Tabs.zx:Slider({
        Title = "中心间隙",
        Value = { Min = 0, Max = 30, Default = 4 },
        Step = 1,
        Callback = function(v)
            CFG.Gap = v
            DrawCrosshair()
        end,
    })

    Tabs.zx:Slider({
        Title = "中心点大小",
        Value = { Min = 1, Max = 10, Default = 2 },
        Step = 1,
        Callback = function(v)
            CFG.DotSize = v
            DrawCrosshair()
        end,
    })

    Tabs.zx:Slider({
        Title = "透明度",
        Value = { Min = 0, Max = 1, Default = 0 },
        Step = 0.05,
        Callback = function(v)
            CFG.Transparency = v
            UpdateElementColors()
        end,
    })

    -- 首次绘制
    DrawCrosshair()

    WindUI:Notify({
        Title = "准星",
        Content = "已加载到准心设置标签",
        Icon = "crosshair",
        Duration = 3,
    })
end
 
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local Workspace        = game:GetService("Workspace")
local LocalPlayer      = Players.LocalPlayer
local Camera           = Workspace.CurrentCamera

-- ═══════════ 参数 ═══════════
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

-- ═══════════ 工具 ═══════════
local function GetChar(p)
    if not p or not p.Parent then return nil end
    local c = p.Character
    if not c or not c.Parent then return nil end
    return c
end
local function GetHRP(c) return c and c:FindFirstChild("HumanoidRootPart") end
local function GetHum(c) return c and c:FindFirstChildOfClass("Humanoid") end

-- ═══════════ 相机锁定 ═══════════
local camConn, camSubject
local function LockCam(subj)
    camSubject = subj
    Camera.CameraType = Enum.CameraType.Scriptable
    Camera.CameraSubject = subj
    if camConn then camConn:Disconnect() end
    camConn = RunService.RenderStepped:Connect(function()
        if not camSubject or not camSubject.Parent then return end
        local tp = camSubject.Position
        local cp = tp + CONFIG.CameraOffset
        Camera.CFrame = CFrame.new(cp, tp)
        Camera.Focus = CFrame.new(tp)
    end)
end
local function UnlockCam()
    if camConn then camConn:Disconnect() camConn = nil end
    camSubject = nil
    local c = LocalPlayer.Character
    if c then
        local h = c:FindFirstChildOfClass("Humanoid")
        if h then
            Camera.CameraSubject = h
            Camera.CameraType = Enum.CameraType.Custom
        end
    end
end

-- ═══════════ 自甩 ═══════════
local selfConn, selfStep
local function EnableSelf()
    if selfConn then return end
    selfConn = RunService.Heartbeat:Connect(function()
        local c = LocalPlayer.Character
        if not c then return end
        local hrp = GetHRP(c) local hum = GetHum(c)
        if not hrp or not hum then return end
        pcall(function()
            hum.PlatformStand = false
            hum.Sit = false
            hum.AutoRotate = true
            local s = hum:GetState()
            if s == Enum.HumanoidStateType.Physics
                or s == Enum.HumanoidStateType.FallingDown
                or s == Enum.HumanoidStateType.Ragdoll then
                hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
            hum:ChangeState(Enum.HumanoidStateType.Running)
            local vel = hrp.AssemblyLinearVelocity
            local sy = math.clamp(vel.Y, -40, 40)
            hrp.AssemblyAngularVelocity = Vector3.new(CONFIG.AngularForce, CONFIG.AngularForce, CONFIG.AngularForce)
            hrp.AssemblyLinearVelocity = Vector3.new(vel.X * CONFIG.VelocityMultiplier, sy, vel.Z * CONFIG.VelocityMultiplier)
            RunService.RenderStepped:Wait()
            if hrp and hrp.Parent then hrp.AssemblyAngularVelocity = Vector3.zero end
        end)
    end)
    selfStep = RunService.Stepped:Connect(function()
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
local function DisableSelf()
    if selfConn then selfConn:Disconnect() selfConn = nil end
    if selfStep then selfStep:Disconnect() selfStep = nil end
end

-- ═══════════ 给目标施力 ═══════════
local function ForceTarget(p)
    if not p then return end
    local c = GetChar(p)
    if not c then return end
    local hrp = GetHRP(c)
    if not hrp then return end
    pcall(function() hrp:SetNetworkOwner(LocalPlayer) end)
    pcall(function()
        hrp.AssemblyLinearVelocity = Vector3.new(CONFIG.TargetForce, CONFIG.TargetForce, CONFIG.TargetForce)
        hrp.AssemblyAngularVelocity = Vector3.new(CONFIG.TargetAngular, CONFIG.TargetAngular, CONFIG.TargetAngular)
    end)
    local h = GetHum(c)
    if h then
        pcall(function()
            h.PlatformStand = true
            h:ChangeState(Enum.HumanoidStateType.Physics)
        end)
    end
end

-- ═══════════ 状态变量 ═══════════
local selectedPlayer = nil
local isTeleportFlying = false
local LoopFly = { Running = false, Target = nil, Orig = nil, Conn = nil, Leave = nil }

-- ═══════════ 传送甩飞 ═══════════
local function TeleportFly(target, duration)
    if isTeleportFlying then return false end
    duration = duration or CONFIG.TeleportDuration
    if not target then return false end
    local tc = GetChar(target)
    if not tc then return false end
    local mc = GetChar(LocalPlayer)
    local mhrp = GetHRP(mc)
    if not mhrp then return false end

    isTeleportFlying = true
    local orig = mhrp.Position
    LockCam(mhrp)
    EnableSelf()

    local t0 = tick()
    local dir = 1
    local lastSwitch = tick()
    local detected = false

    while tick() - t0 < duration do
        local tc2 = GetChar(target)
        if not tc2 then break end
        local thrp = GetHRP(tc2)
        if thrp then
            if tick() - lastSwitch > CONFIG.SwingSpeed then
                dir = dir * -1
                lastSwitch = tick()
            end
            local mc2 = GetChar(LocalPlayer)
            local mhrp2 = GetHRP(mc2)
            if mhrp2 then
                for i = 1, CONFIG.TeleportPerTick do
                    local off = dir * CONFIG.SwingRange * (i / CONFIG.TeleportPerTick)
                    local pos = thrp.Position + thrp.CFrame.LookVector * off
                    pcall(function() mhrp2.CFrame = CFrame.new(pos) end)
                end
                ForceTarget(target)
            end
            if not detected and thrp.AssemblyLinearVelocity.Magnitude > 30 then
                detected = true
            end
        end
        task.wait(0.02)
    end

    local fc = GetChar(LocalPlayer)
    local fhrp = GetHRP(fc)
    if fhrp then
        pcall(function()
            fhrp.CFrame = CFrame.new(orig)
            fhrp.AssemblyAngularVelocity = Vector3.zero
            fhrp.AssemblyLinearVelocity = Vector3.zero
        end)
    end

    DisableSelf()
    UnlockCam()
    isTeleportFlying = false
    return detected
end

-- ═══════════ 循环甩飞 ═══════════
local function LoopStart(target)
    if LoopFly.Running then LoopFly.Stop() task.wait(0.2) end
    if not target then return false end
    local tc = GetChar(target)
    if not tc then return false end
    local mc = GetChar(LocalPlayer)
    local mhrp = GetHRP(mc)
    if not mhrp then return false end

    LoopFly.Running = true
    LoopFly.Target = target
    LoopFly.Orig = mhrp.Position
    LockCam(mhrp)
    EnableSelf()

    LoopFly.Conn = RunService.Heartbeat:Connect(function()
        if not LoopFly.Running then return end
        local tc2 = GetChar(LoopFly.Target)
        if not tc2 then LoopFly.Stop() return end
        local thrp = GetHRP(tc2)
        if not thrp then return end
        local dir = math.sin(tick() * CONFIG.SwingFreq)
        local off = dir * CONFIG.SwingRange
        local mc2 = GetChar(LocalPlayer)
        local mhrp2 = GetHRP(mc2)
        if mhrp2 then
            for i = 1, CONFIG.TeleportPerTick do
                local sub = off * (i / CONFIG.TeleportPerTick)
                local pos = thrp.Position + thrp.CFrame.LookVector * sub
                pcall(function() mhrp2.CFrame = CFrame.new(pos) end)
            end
            ForceTarget(LoopFly.Target)
        end
    end)

    LoopFly.Leave = Players.PlayerRemoving:Connect(function(p)
        if p == LoopFly.Target and LoopFly.Running then LoopFly.Stop() end
    end)

    return true
end

function LoopFly.Stop()
    if not LoopFly.Running then return end
    LoopFly.Running = false
    if LoopFly.Conn then LoopFly.Conn:Disconnect() LoopFly.Conn = nil end
    if LoopFly.Leave then LoopFly.Leave:Disconnect() LoopFly.Leave = nil end
    local mc = GetChar(LocalPlayer)
    local mhrp = GetHRP(mc)
    if mhrp and LoopFly.Orig then
        pcall(function()
            mhrp.CFrame = CFrame.new(LoopFly.Orig)
            mhrp.AssemblyAngularVelocity = Vector3.zero
            mhrp.AssemblyLinearVelocity = Vector3.zero
        end)
    end
    DisableSelf()
    UnlockCam()
    LoopFly.Target = nil
    LoopFly.Orig = nil
end

-- ═══════════ 玩家选择 ═══════════
local function getPlayerList()
    local t = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(t, p.Name)
        end
    end
    return t
end

local playerDropdown
playerDropdown = Tabs.sf:Dropdown({
    Title = "选择目标玩家",
    Desc = "选择要甩飞的玩家",
    Values = getPlayerList(),
    Value = nil,
    Callback = function(v)
        if v and v ~= "" then
            selectedPlayer = Players:FindFirstChild(v)
            WindUI:Notify({
                Title = "已选择",
                Content = v,
                Icon = "check",
                Duration = 2,
            })
            if LoopFly.Running then
                LoopFly.Stop()
                task.wait(0.2)
                LoopStart(selectedPlayer)
            end
        end
    end,
})

-- 刷新玩家列表按钮
Tabs.sf:Button({
    Title = "刷新玩家列表",
    Callback = function()
        if playerDropdown and playerDropdown.Refresh then
            playerDropdown:Refresh(getPlayerList())
        end
        WindUI:Notify({
            Title = "已刷新",
            Content = "共 " .. #getPlayerList() .. " 个玩家",
            Icon = "refresh-cw",
            Duration = 2,
        })
    end,
})

-- ═══════════ 传送甩飞 ═══════════
Tabs.sf:Button({
    Title = " 传送甩飞（一次）",
    Desc = "瞬移到目标身边来回摆动甩飞",
    Callback = function()
        if not selectedPlayer then
            WindUI:Notify({ Title = "未选择玩家", Icon = "alert-circle", Duration = 2 })
            return
        end
        if isTeleportFlying then
            WindUI:Notify({ Title = "正在执行中", Icon = "alert-circle", Duration = 2 })
            return
        end
        task.spawn(function()
            local ok = TeleportFly(selectedPlayer)
            WindUI:Notify({
                Title = ok and "甩飞成功" or "甩飞结束",
                Content = selectedPlayer.Name,
                Icon = ok and "check" or "x",
                Duration = 3,
            })
        end)
    end,
})

-- ═══════════ 循环甩飞 ═══════════
Tabs.sf:Toggle({
    Title = " 循环甩飞",
    Desc = "持续锁定目标来回摆动",
    Value = false,
    Callback = function(state)
        if state then
            if not selectedPlayer then
                WindUI:Notify({ Title = "未选择玩家", Icon = "alert-circle", Duration = 2 })
                return
            end
            LoopStart(selectedPlayer)
            WindUI:Notify({
                Title = "循环甩飞已开启",
                Content = selectedPlayer.Name,
                Icon = "check",
                Duration = 2,
            })
        else
            LoopFly.Stop()
            WindUI:Notify({ Title = "循环甩飞已关闭", Icon = "x", Duration = 2 })
        end
    end,
})

-- ═══════════ 参数标签页 ═══════════
Tabs.sf:Slider({
    Title = "摆动幅度（米）",
    Value = { Min = 2, Max = 20, Default = CONFIG.SwingRange },
    Step = 1,
    IsTextbox = true,
    Callback = function(v) CONFIG.SwingRange = v end,
})

Tabs.sf:Slider({
    Title = "摆动频率（Hz）",
    Value = { Min = 5, Max = 50, Default = CONFIG.SwingFreq },
    Step = 1,
    IsTextbox = true,
    Callback = function(v) CONFIG.SwingFreq = v end,
})

Tabs.sf:Slider({
    Title = "每次传送次数",
    Value = { Min = 1, Max = 20, Default = CONFIG.TeleportPerTick },
    Step = 1,
    IsTextbox = true,
    Callback = function(v) CONFIG.TeleportPerTick = v end,
})

Tabs.sf:Slider({
    Title = "目标施力",
    Value = { Min = 100, Max = 10000, Default = CONFIG.TargetForce },
    Step = 100,
    IsTextbox = true,
    Callback = function(v) CONFIG.TargetForce = v end,
})

Tabs.sf:Slider({
    Title = "传送甩飞时长（秒）",
    Value = { Min = 1, Max = 10, Default = CONFIG.TeleportDuration },
    Step = 1,
    IsTextbox = true,
    Callback = function(v) CONFIG.TeleportDuration = v end,
})

Tabs.sf:Button({
    Title = "重置为默认参数",
    Callback = function()
        CONFIG.SwingRange = 8
        CONFIG.SwingFreq = 20
        CONFIG.SwingSpeed = 0.03
        CONFIG.TeleportPerTick = 8
        CONFIG.AngularForce = 200000
        CONFIG.VelocityMultiplier = 3.0
        CONFIG.TargetForce = 2000
        CONFIG.TargetAngular = 500000
        CONFIG.TeleportDuration = 4
        WindUI:Notify({ Title = "已重置", Icon = "refresh-cw", Duration = 2 })
    end,
})

-- ═══════════ 快捷键 F ═══════════
game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.F then
        -- WindUI 自带 ToggleKey 支持
    end
end)

-- ═══════════ 角色重生 ═══════════
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    if LoopFly.Running then LoopFly.Stop() end
    UnlockCam()
end)

print("静默甩飞 WindUI 版已加载")
------====---
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local AimConfig = {
    Enabled = false,
    BulletTrack = false,
    FOV = 200,
    Smoothness = 0.15,
    Prediction = 0.12,
    BulletSpeed = 1500,
    BulletDrop = 0,
    WallCheck = true,
    ShowFOV = false,
    ShowTracer = true,
    AimPart = "Head",
    TeamCheck = true,
    JumpPrediction = true,
}
-- FOV圆圈绘图
local aimFOVCircle = Drawing.new("Circle")
aimFOVCircle.Visible = false
aimFOVCircle.Color = Color3.fromRGB(255, 50, 50)
aimFOVCircle.Thickness = 1.5
aimFOVCircle.Filled = false
aimFOVCircle.Transparency = 0.4
aimFOVCircle.NumSides = 64
aimFOVCircle.Radius = AimConfig.FOV
aimFOVCircle.Position = Camera.ViewportSize / 2
-- 瞄准射线
local aimTracer = Drawing.new("Line")
aimTracer.Visible = false
aimTracer.Color = Color3.fromRGB(255, 50, 50)
aimTracer.Thickness = 1.5
aimTracer.Transparency = 0.4
aimTracer.From = Camera.ViewportSize / 2
aimTracer.To = Camera.ViewportSize / 2
local aimTargetPart = nil
local mainConn = nil
-- 寻找准星FOV内最近敌人
local function findClosestPlayer()
    local mousePos = UserInputService:GetMouseLocation()
    local viewportSize = Camera.ViewportSize
    local center = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
    local best = nil
    local bestDist = AimConfig.FOV
    for i = 1, #Players:GetPlayers() do
        local player = Players:GetPlayers()[i]
        if player == LocalPlayer then
        elseif player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if not humanoid or not hrp or humanoid.Health <= 0 then
            elseif AimConfig.TeamCheck and player.Team and player.Team == LocalPlayer.Team then
            else
                local part = player.Character:FindFirstChild(AimConfig.AimPart)
                if not part then part = player.Character:FindFirstChild("Head") end
                if not part then part = hrp end
                if part then
                    local sp, vis = Camera:WorldToViewportPoint(part.Position)
                    if vis and sp.Z < 1000 then
                        local sd = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                        if sd < bestDist then
                            best = part
                            bestDist = sd
                        end
                    end
                end
            end
        end
    end
    return best
end
-- 墙体检测
local function isWallHit(part)
    if not AimConfig.WallCheck then return false end
    local origin = Camera.CFrame.Position
    local dir = (part.Position - origin)
    local rayP = RaycastParams.new()
    rayP.FilterType = Enum.RaycastFilterType.Exclude
    rayP.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
    local result = workspace:Raycast(origin, dir, rayP)
    if result and not result.Instance:IsDescendantOf(part.Parent) then
        return true
    end
    return false
end
-- 执行相机自瞄
local function doCameraAim()
    if not aimTargetPart or not aimTargetPart.Parent then return end
    local hum = aimTargetPart.Parent:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return end
    if isWallHit(aimTargetPart) then return end
    local dist = (aimTargetPart.Position - Camera.CFrame.Position).Magnitude
    local time = dist / math.max(AimConfig.BulletSpeed, 100)
    local vel = Vector3.zero
    local tHrp = aimTargetPart.Parent:FindFirstChild("HumanoidRootPart")
    if tHrp then
        vel = tHrp.AssemblyLinearVelocity
    end
    local predictPos = aimTargetPart.Position + vel * AimConfig.Prediction
    local dropOffset = Vector3.new(0, -AimConfig.BulletDrop * time * time, 0)
    local jumpOff = Vector3.zero
    if AimConfig.JumpPrediction and tHrp then
        if tHrp.AssemblyLinearVelocity.Y > 10 then
            jumpOff = Vector3.new(0, tHrp.AssemblyLinearVelocity.Y * AimConfig.Prediction * 0.5, 0)
        end
    end
    local targetPos = predictPos + dropOffset + jumpOff
    local targetCF = CFrame.new(Camera.CFrame.Position, targetPos)
    local s = AimConfig.Smoothness
    if s >= 1 then
        Camera.CFrame = targetCF
    else
        Camera.CFrame = Camera.CFrame:Lerp(targetCF, s)
    end
end
-----------
-- ==================== 亚洲车王：视角稳定 ====================
-- ==================== 亚洲车王：视角稳定 ====================
local CamStabState = {
    Enabled = false,
    Mode = "稳定跟随",
    Smoothness = 0.3,
    LastCFrame = nil,
    Connection = nil,
    SubjectConn = nil,
}

local function CamStab_getCam()
    return workspace.CurrentCamera
end

local function CamStab_restore()
    local cam = CamStab_getCam()
    if not cam then return end
    if CamStabState.SubjectConn then
        CamStabState.SubjectConn:Disconnect()
        CamStabState.SubjectConn = nil
    end
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then cam.CameraSubject = hum end
    end
    cam.CameraType = Enum.CameraType.Custom
end

local function CamStab_start()
    local cam = CamStab_getCam()
    if not cam then return end

    if CamStabState.Connection then CamStabState.Connection:Disconnect() CamStabState.Connection = nil end
    if CamStabState.SubjectConn then CamStabState.SubjectConn:Disconnect() CamStabState.SubjectConn = nil end

    -- 稳定跟随
    if CamStabState.Mode == "稳定跟随" then
        local function setSub()
            local char = LocalPlayer.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then cam.CameraSubject = hrp end
            end
        end
        setSub()
        CamStabState.SubjectConn = RunService.Heartbeat:Connect(function()
            if not CamStabState.Enabled then return end
            local char = LocalPlayer.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp and cam.CameraSubject ~= hrp then
                    cam.CameraSubject = hrp
                end
            end
        end)
    end

    -- 固定朝向
    if CamStabState.Mode == "固定朝向" then
        cam.CameraType = Enum.CameraType.Scriptable
        local lockedRot = cam.CFrame - cam.CFrame.Position
        CamStabState.Connection = RunService.RenderStepped:Connect(function()
            if not CamStabState.Enabled then return end
            local c = CamStab_getCam()
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

    -- 抗抖动
    if CamStabState.Mode == "抗抖动" then
        cam.CameraType = Enum.CameraType.Custom
        CamStabState.LastCFrame = nil
        CamStabState.Connection = RunService.RenderStepped:Connect(function()
            if not CamStabState.Enabled then return end
            local c = CamStab_getCam()
            if not c then return end
            local currentCF = c.CFrame
            if not CamStabState.LastCFrame then
                CamStabState.LastCFrame = currentCF
            else
                local smooth = math.clamp(CamStabState.Smoothness, 0, 0.95)
                local newCF = CamStabState.LastCFrame:Lerp(currentCF, 1 - smooth)
                c.CFrame = CFrame.new(newCF.Position) * (currentCF - currentCF.Position)
                CamStabState.LastCFrame = c.CFrame
            end
        end)
    end
end

local function CamStab_stop()
    if CamStabState.Connection then CamStabState.Connection:Disconnect() CamStabState.Connection = nil end
    if CamStabState.SubjectConn then CamStabState.SubjectConn:Disconnect() CamStabState.SubjectConn = nil end
    CamStab_restore()
    CamStabState.LastCFrame = nil
end

-- 角色重生
LocalPlayer.CharacterAdded:Connect(function()
    if CamStabState.Enabled then
        task.wait(1)
        CamStab_stop()
        CamStabState.Enabled = true
        CamStab_start()
    end
end)

-- ==================== UI（Tabs.fc） ====================
Tabs.fc:Toggle({
    Title = "启用视角稳定",
    Desc = "开启后视角不再晃动",
    Default = false,
    Callback = function(v)
        CamStabState.Enabled = v
        if v then
            CamStab_start()
        else
            CamStab_stop()
        end
    end,
})

Tabs.fc:Dropdown({
    Title = "防抖模式",
    Desc = "稳定跟随=走路不颠簸 | 固定朝向=转向不晃 | 抗抖动=过滤开枪震动",
    Values = { "稳定跟随", "固定朝向", "抗抖动" },
    Default = "稳定跟随",
    Callback = function(v)
        CamStabState.Mode = v
        if CamStabState.Enabled then
            CamStab_stop()
            CamStabState.Enabled = true
            CamStab_start()
        end
    end,
})

Tabs.fc:Slider({
    Title = "平滑程度",
    Desc = "",
    Value = { Min = 0, Max = 0.9, Default = 0.3 },
    Step = 0.05,
    Callback = function(v)
        CamStabState.Smoothness = v
    end,
})

Tabs.fc:Button({
    Title = "重新应用稳定",
    Desc = "",
    Callback = function()
        if not CamStabState.Enabled then return end
        CamStab_stop()
        CamStabState.Enabled = true
        CamStab_start()
    end,
})
Tabs.fc:Button({
    Title = "飞车脚本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/GUI.lua"))()
    end
})
-- ═══════════════════════════════════════════════════
-- Ragebot 独立模块 (兼容 WindUI 大脚本)
-- ═══════════════════════════════════════════════════

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local Workspace         = game:GetService("Workspace")
local Debris            = game:GetService("Debris")
local SoundService      = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local userId = LocalPlayer.UserId

-- ═══════════ 全局状态 ═══════════
local State = {
    Ragebot     = false,
    Wallbang    = true,
    IgnoreCrawl = true,
    IgnoreKnock = true,
    IgnoreGrab  = true,
    LastFire    = 0,
    FireRate    = 0.05,
    MaxDistance = 20000,
    WallSpread  = 30,
    Running     = false,
    LoopConn    = nil,
    TracerEnabled  = true,
    TracerColor    = Color3.fromRGB(255, 80, 80),
    TracerWidth    = 0.25,
    TracerDuration = 1,
    HitSoundEnabled = true,
    HitSoundId      = "rbxassetid://4590662766",
    HitSoundVolume  = 0.5,
    LastToolId       = nil,
    LastAmmo         = nil,
    LastAmmoChangeAt = 0,
    ReloadRetryAt    = 0,
}

-- ═══════════ 尝试加载 Wanted 模块 ═══════════
local WantedReady = false
local nuid, Network, MathUtil, ClientPlayers, fireServer, ClientTools

pcall(function()
    local DevvFolder = ReplicatedStorage:FindFirstChild("Devv") or ReplicatedStorage:FindFirstChild("devv")
    if not DevvFolder then return end
    local DevvModule = require(DevvFolder)
    if type(DevvModule.load) ~= "function" then return end
    local load = DevvModule.load
    nuid          = load("NUID")
    Network       = load("Network")
    MathUtil      = load("MathUtil")
    ClientPlayers = load("ClientPlayers")
    fireServer    = Network.FireServer
    ClientTools   = require(ReplicatedStorage.Client.Wanted.Modules.ClientTools)
    WantedReady   = true
end)

-- ═══════════ 工具函数 ═══════════
local function getMyChar()
    local c = LocalPlayer.Character
    return c, c and c:FindFirstChild("HumanoidRootPart"), c and c:FindFirstChild("Head")
end

local function isAlive(p)
    local c = p and p.Character
    if not c then return false end
    local h = c:FindFirstChildOfClass("Humanoid")
    return h and h.Health > 0
end

local function getProp(p, key)
    if not ClientPlayers then return false end
    local CP = ClientPlayers.GetByPlayerId(p.UserId)
    if CP and CP.GetPlayerProperty then
        local ok, v = pcall(CP.GetPlayerProperty, CP, key)
        return ok and v == true
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
    local c = LocalPlayer.Character
    if not c then return true end
    local h = c:FindFirstChildOfClass("Humanoid")
    if not h or h.Health <= 0 then return true end
    local st = h:GetState()
    return st == Enum.HumanoidStateType.Physics
        or st == Enum.HumanoidStateType.Ragdoll
        or st == Enum.HumanoidStateType.FallingDown
end

-- ═══════════ 追踪线 & 音效 ═══════════
local TracerFolder = Workspace:FindFirstChild("__MoonTracers")
if not TracerFolder then
    TracerFolder = Instance.new("Folder")
    TracerFolder.Name = "__MoonTracers"
    TracerFolder.Parent = Workspace
end

local function createTracer(fromPos, toPos, color, width, duration)
    if not State.TracerEnabled then return end
    pcall(function()
        local a0 = Instance.new("Attachment", TracerFolder); a0.WorldPosition = fromPos
        local a1 = Instance.new("Attachment", TracerFolder); a1.WorldPosition = toPos
        local beam = Instance.new("Beam", TracerFolder)
        beam.Attachment0, beam.Attachment1 = a0, a1
        beam.Color = ColorSequence.new(color or State.TracerColor)
        beam.Width0, beam.Width1 = width or State.TracerWidth, width or State.TracerWidth
        beam.LightEmission, beam.LightInfluence, beam.FaceCamera = 1, 0, true
        beam.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.1),
            NumberSequenceKeypoint.new(1, 0.8),
        })
        local life = duration or State.TracerDuration
        Debris:AddItem(beam, life); Debris:AddItem(a0, life); Debris:AddItem(a1, life)
    end)
end

local function playHitSound()
    if not State.HitSoundEnabled then return end
    pcall(function()
        local snd = Instance.new("Sound", SoundService)
        snd.SoundId, snd.Volume = State.HitSoundId, State.HitSoundVolume
        snd:Play(); Debris:AddItem(snd, 2)
    end)
end

-- ═══════════ 穿墙解算 ═══════════
local RayParams = RaycastParams.new()
RayParams.FilterType = Enum.RaycastFilterType.Exclude
RayParams.IgnoreWater = true

local function Resolve(fromPos, toPos, spread, radius)
    local dir = toPos - fromPos
    local dist = dir.Magnitude
    if dist < 0.1 then return fromPos, toPos, true end

    RayParams.FilterDescendantsInstances = { LocalPlayer.Character }
    local hit = Workspace:Raycast(fromPos, dir, RayParams)
    if not hit or (hit.Position - toPos).Magnitude <= radius then
        return fromPos, toPos, true
    end

    local unit = dir.Unit
    local up = unit:Cross(math.abs(unit.Y) < 0.9 and Vector3.new(0,1,0) or Vector3.new(1,0,0)).Unit
    local right = unit:Cross(up).Unit
    for _, off in ipairs({ right, -right, -up, up }) do
        local testPos = fromPos + off * spread
        local testHit = Workspace:Raycast(testPos, toPos - testPos, RayParams)
        if not testHit or (testHit.Position - toPos).Magnitude <= radius then
            return testPos, toPos, true
        end
    end
    return nil, nil, false
end

-- ═══════════ 找敌人（包含白名单过滤） ═══════════
local function getClosestEnemy()
    local _, myHRP = getMyChar()
    if not myHRP then return nil, nil end
    local best, bestDist, bestHead = nil, math.huge, nil
    for _, p in ipairs(Players:GetPlayers()) do
        -- ⭐ 核心修正：严格判断是否为 true
        local isWhiteListed = (_G.WL and _G.WL[p.Name] == true)
        
        if p ~= LocalPlayer and isAlive(p) and not shouldIgnore(p) and not isWhiteListed then
            local c = p.Character
            local hrp = c and c:FindFirstChild("HumanoidRootPart")
            local head = c and c:FindFirstChild("Head")
            if hrp and head then
                local d = (hrp.Position - myHRP.Position).Magnitude
                if d <= State.MaxDistance and d < bestDist then
                    bestDist, best, bestHead = d, p, head
                end
            end
        end
    end
    return best, bestHead
end

-- ═══════════ 开火 ═══════════
local RELOAD_RETRY_INTERVAL = 0.6
local AMMO_STUCK_THRESHOLD  = 1.5

local function fireAt(target, targetHead)
    if not WantedReady then return end
    if isRagdoll() then return end
    local now = tick()
    if now - State.LastFire < State.FireRate then return end

    local _, myHRP, myHead = getMyChar()
    if not myHRP or not myHead then return end

    local ok, tool = pcall(ClientTools.GetLocalEquippedTool)
    if not ok or not tool or not tool.toolState then return end
    local ts = tool.toolState

    if State.LastToolId ~= tool.toolId then
        State.LastToolId, State.ReloadRetryAt = tool.toolId, 0
        State.LastAmmo, State.LastAmmoChangeAt = nil, now
    end

    local curAmmo = tonumber(ts.ammo)
    if curAmmo ~= State.LastAmmo then
        State.LastAmmo, State.LastAmmoChangeAt = curAmmo, now
    elseif now - State.LastAmmoChangeAt > AMMO_STUCK_THRESHOLD then
        State.LastAmmoChangeAt = now
        if now >= State.ReloadRetryAt then
            State.ReloadRetryAt = now + RELOAD_RETRY_INTERVAL
            pcall(fireServer, "reload",  tool.toolId)
            pcall(fireServer, "chamber", tool.toolId)
        end
        return
    end

    if curAmmo == nil or ts.totalAmmo == nil then return end

    if curAmmo <= 0 then
        if now >= State.ReloadRetryAt then
            State.ReloadRetryAt = now + RELOAD_RETRY_INTERVAL
            if (tonumber(ts.totalAmmo) or 0) > 0 then
                pcall(fireServer, "reload",  tool.toolId)
                pcall(fireServer, "chamber", tool.toolId)
            end
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
        {
            massLimit = 5, hit = targetHead, position = resolvedTarget, normal = -unit,
            material = targetHead.Material or Enum.Material.Plastic,
            distance = dir.Magnitude, collisionPoint = resolvedTarget,
            direction = unit, speed = speed,
            source = { sourceType = "Bullet", sourceId = bulletId, sourceToolId = tool.toolId, sourcePlayerId = userId },
        },
    })

    playHitSound()
    createTracer(resolvedOrigin, resolvedTarget, State.TracerColor, State.TracerWidth, State.TracerDuration)
    State.LastFire = now
end

-- ═══════════ 主循环 ═══════════
if not State.Running then
    State.Running = true
    State.LoopConn = RunService.Heartbeat:Connect(function()
        if State.Ragebot and WantedReady then
            local target, head = getClosestEnemy()
            if target and head then pcall(fireAt, target, head) end
        end
    end)
end

-- ═══════════ 对外暴露接口，用来挂载 UI ═══════════
_G.RagebotState = State

function _G.BuildRagebotUI(Tab)
    if not Tab then return warn("[Ragebot] 传进来的 Tab 是空的！") end

    Tab:Toggle({
        Title = "开启愤怒机器人", Value = false,
        Callback = function(v) State.Ragebot = v end,
    })
    Tab:Toggle({
        Title = "穿墙射击", Value = true,
        Callback = function(v) State.Wallbang = v end,
    })
    
    Tab:Toggle({
        Title = "忽略倒地/被击倒/被抓", Value = true,
        Callback = function(v)
            State.IgnoreCrawl, State.IgnoreKnock, State.IgnoreGrab = v, v, v
        end,
    })
    Tab:Divider()
    Tab:Slider({
        Title = "最大攻击距离",
        Value = { Min = 50, Max = 10000, Default = 2000 }, Step = 50, Suffix = " 米",
        Callback = function(v) State.MaxDistance = v end,
    })
    Tab:Slider({
        Title = "射击间隔（秒）",
        Value = { Min = 0.02, Max = 0.5, Default = 0.05 }, Step = 0.01,
        Callback = function(v) State.FireRate = v end,
    })
    Tab:Slider({
        Title = "穿墙偏移距离",
        Value = { Min = 5, Max = 100, Default = 30 }, Step = 5,
        Callback = function(v) State.WallSpread = v end,
    })
    Tab:Divider()
    Tab:Toggle({
        Title = "命中音效", Value = true,
        Callback = function(v) State.HitSoundEnabled = v end,
    })
    Tab:Slider({
        Title = "音效音量",
        Value = { Min = 0, Max = 1, Default = 0.5 }, Step = 0.05,
        Callback = function(v) State.HitSoundVolume = v end,
    })
    Tab:Dropdown({
        Title = "音效选择",
        Values = { "叮叮叮（经典）", "Neverlose", "Gamesense", "Fatality", "Minecraft" }, Value = "叮叮叮（经典）",
        Callback = function(v)
            local map = {
                ["叮叮叮（经典）"] = "rbxassetid://4590662766",
                ["Neverlose"]     = "rbxassetid://6607204501",
                ["Gamesense"]     = "rbxassetid://5633695679",
                ["Fatality"]      = "rbxassetid://6607142036",
                ["Minecraft"]     = "rbxassetid://7151570575",
            }
            State.HitSoundId = map[v] or "rbxassetid://4590662766"
        end,
    })
    Tab:Divider()
    Tab:Toggle({
        Title = "显示弹道追踪线", Value = true,
        Callback = function(v) State.TracerEnabled = v end,
    })
    Tab:Slider({
        Title = "追踪线宽度",
        Value = { Min = 0.05, Max = 1, Default = 0.25 }, Step = 0.05,
        Callback = function(v) State.TracerWidth = v end,
    })
    Tab:Slider({
        Title = "追踪线持续时间",
        Value = { Min = 0.2, Max = 5, Default = 1 }, Step = 0.1, Suffix = " 秒",
        Callback = function(v) State.TracerDuration = v end,
    })
    Tab:Dropdown({
        Title = "追踪线颜色",
        Values = { "红色", "绿色", "蓝色", "白色", "黄色", "紫色", "青色", "橙色" }, Value = "红色",
        Callback = function(v)
            local map = {
                ["红色"] = Color3.fromRGB(255, 80, 80), ["绿色"] = Color3.fromRGB(80, 255, 80),
                ["蓝色"] = Color3.fromRGB(80, 150, 255), ["白色"] = Color3.fromRGB(255, 255, 255),
                ["黄色"] = Color3.fromRGB(255, 255, 80), ["紫色"] = Color3.fromRGB(180, 80, 255),
                ["青色"] = Color3.fromRGB(80, 255, 255), ["橙色"] = Color3.fromRGB(255, 150, 60),
            }
            State.TracerColor = map[v] or Color3.fromRGB(255, 80, 80)
        end,
    })

    -- ⭐ 白名单模块（自动管理生命周期）
    Tab:Divider()
    Tab:Section({ Title = "白名单" })
    
    _G.WL = _G.WL or {}
    local WL_Created = {}

    local function WL_AddFor(playerName)
        if WL_Created[playerName] then return end
        
        Tab:Toggle({
            Title = playerName,
            Desc = "",
            Value = false, -- 核心修复：必须用 Value = false，不能默认开启
            Callback = function(v)
                _G.WL = _G.WL or {}
                if v then
                    _G.WL[playerName] = true
                else
                    _G.WL[playerName] = nil
                end
            end,
        })
        WL_Created[playerName] = true
    end

    -- 初始化当前房间玩家
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            WL_AddFor(p.Name)
        end
    end

    -- 监听新玩家加入
    Players.PlayerAdded:Connect(function(p)
        if p ~= LocalPlayer then
            task.wait(0.5) 
            WL_AddFor(p.Name) 
        end
    end)

    -- 监听玩家退出：必须清理全局白名单数据，防止同名玩家再次进服被误判
    Players.PlayerRemoving:Connect(function(p)
        if _G.WL then
            _G.WL[p.Name] = nil 
        end
    end)

    print("[Ragebot] 控件与白名单已成功挂载！")
end

print("[Ragebot] 功能模块已加载，等待挂载...")
-- ============================================
-- 农场光环 + 自动农场 + 自动远程打玻璃（WindUI 格式，挂在 Tabs.lc）
-- ============================================
do
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local TweenService      = game:GetService("TweenService")
    local LocalPlayer       = game:GetService("Players").LocalPlayer

    -- 加载 Wanted 模块
    local Network, ClientPlayers, ClientTools, ClientGizmos, ClientProps
    local fireServer, invokeServer

    local loadOK = pcall(function()
        local DevvFolder = ReplicatedStorage:FindFirstChild("Devv") or ReplicatedStorage:FindFirstChild("devv")
        if not DevvFolder then error("找不到 Devv 文件夹") end
        local DevvModule = require(DevvFolder)
        if type(DevvModule.load) ~= "function" then error("Devv.load 异常") end
        local load = DevvModule.load
        Network       = load("Network")
        ClientPlayers = load("ClientPlayers")
        ClientTools   = require(ReplicatedStorage.Client.Wanted.Modules.ClientTools)
        ClientGizmos  = require(ReplicatedStorage.Client.Wanted.Modules.ClientGizmos)
        ClientProps   = require(ReplicatedStorage.Client.Wanted.Modules.ClientProps)
        fireServer    = Network.FireServer
        invokeServer  = Network.InvokeServer
    end)

    local GIZMO_NAME_MAP = {
        ["GasStationSafe"] = "加油站保险箱",
        ["ATM"]            = "ATM 机",
        ["Register"]       = "收银机",
        ["Lootable"]       = "可搜刮物品",
        ["WorldItem"]      = "世界物品",
        ["WorldBag"]       = "世界背包",
        ["MainCashPile"]   = "主钱堆",
        ["CashPallet"]     = "现金托盘",
        ["Cash"]           = "现金",
        ["MilitaryChest"]  = "军事箱",
        ["PelicanCase"]    = "鹈鹕箱",
        ["WorldSafe"]      = "世界保险箱",
        ["PC Block"]       = "PC 机箱",
        ["WorldItemSpawn"] = "物品刷新点",
        ["Break Glass"]    = "打碎玻璃（电锯）",
    }

    local function getHRP() local c = LocalPlayer.Character; return c and c:FindFirstChild("HumanoidRootPart") end
    local function getHum() local c = LocalPlayer.Character; return c and c:FindFirstChildOfClass("Humanoid") end

    local function getGizmos(hrp)
        local list = {}
        if not ClientGizmos then return list end
        local ok2, source = pcall(debug.getupvalue, ClientGizmos.Get, 1)
        if not ok2 or type(source) ~= "table" then return list end
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
        if g.gizmoType == "WorldSafe" or g.gizmoType == "GasStationSafe" then return g.objectId ~= nil end
        if g.gizmoType == "PC Block" then return g.objectId ~= nil end
        if type(g.AttemptCollect) == "function" or type(g.Interact) == "function" then return true end
        return false
    end

    local function interact(g)
        if type(g) ~= "table" then return false end
        local t = g.gizmoType
        if t == "ATM" or t == "Register" then
            local CP = ClientPlayers and ClientPlayers.Get()
            if CP and g.position then
                pcall(function() CP:Melee(g.position) end)
                return true
            end
            return false
        end
        if t == "WorldSafe" or t == "GasStationSafe" then
            if g.objectId then
                fireServer("gizmoInteraction", g.objectId, "OpenSafe")
                return true
            end
            return false
        end
        if t == "PC Block" then
            if g.objectId then
                fireServer("gizmoInteraction", g.objectId, "Search")
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
        if type(g.AttemptCollect) == "function" then pcall(g.AttemptCollect, g); return true end
        if type(g.Interact) == "function" then pcall(g.Interact, g); return true end
        return false
    end

    local function findBuzzsaw()
        if not ClientTools then return nil end
        local ok2, items = pcall(ClientTools.GetItems)
        if not ok2 or type(items) ~= "table" then return nil end
        for _, category in pairs(items) do
            if type(category) == "table" then
                for guid, data in pairs(category) do
                    if data and (data.name == "Buzzsaw" or data.isBuzzSaw) then
                        return { guid = guid, data = data }
                    end
                end
            end
        end
        return nil
    end

    local function equipBuzzsaw()
        local saw = findBuzzsaw()
        if not saw then return false end
        fireServer("equip", saw.guid)
        local CP = ClientPlayers and ClientPlayers.Get()
        if CP then
            pcall(function()
                if setthreadidentity then setthreadidentity(2) end
                CP:SetEquipped({ toolId = saw.guid, toolState = true })
                if setthreadidentity then setthreadidentity(8) end
            end)
        end
        return true
    end

    local function breakGlass(hrp)
        if not ClientProps or type(ClientProps.worldPropsById) ~= "table" then return false end
        local best, bestD = nil, 12
        for _, prop in pairs(ClientProps.worldPropsById) do
            if type(prop) == "table" and prop.name == "JewelSpawn" and not prop.isShattered then
                local pos = (prop.GetPosition and prop:GetPosition())
                    or (prop.model and prop.model.PrimaryPart and prop.model.PrimaryPart.Position)
                if pos then
                    local d = (hrp.Position - pos).Magnitude
                    if d < bestD then bestD = d; best = prop end
                end
            end
        end
        if not best then return false end
        equipBuzzsaw()
        local CP = ClientPlayers and ClientPlayers.Get()
        if not CP then return false end
        local pos = (best.GetPosition and best:GetPosition())
            or (best.model and best.model.PrimaryPart and best.model.PrimaryPart.Position)
        if pos then
            pcall(function() CP:Melee(pos) end)
            return true
        end
        return false
    end

    local FarmConfig = {
        Enabled = false,
        Range   = 15,
        Options = {
            "GasStationSafe", "ATM", "Register", "Lootable", "WorldItem",
            "WorldBag", "MainCashPile", "CashPallet", "Cash", "MilitaryChest",
            "PelicanCase", "WorldSafe", "PC Block", "WorldItemSpawn", "Break Glass",
        },
    }

    local AutoFarmConfig = {
        Enabled = false,
        Options = {
            "GasStationSafe", "ATM", "Register", "Lootable", "WorldItem",
            "WorldBag", "MainCashPile", "CashPallet", "Cash", "MilitaryChest",
            "PelicanCase", "WorldSafe", "PC Block", "WorldItemSpawn",
        },
        SellPos = Vector3.new(-2826, 37, 1738),
        BagFullThreshold = 0.8,
    }

    local FARM_SPOTS = {
        CFrame.new(-616.021240234375, 42.37424087524414, -2855.274169921875),
        CFrame.new(-517.3259887695312, 65.89241027832031, -2836.2841796875),
        CFrame.new(-571.81005859375, 42.467185974121094, -2864.800048828125),
        CFrame.new(-386.13,   617.44, -1193.07),
        CFrame.new(-3139,     36,      1638),
        CFrame.new(212,       39.7,   -2917.9),
        CFrame.new(-1677.8,   181,     3336.4),
        CFrame.new(-490.5,    128,    -1677.2),
        CFrame.new(-940.7,    73.9,   -1541.6),
        CFrame.new(-484.2,    44.1,   -1956.6),
        CFrame.new(1873.72,   171.63,  -537.64),
        CFrame.new(-1394.89,  272.13,   3204.58),
        CFrame.new(-1389.94,  272.13,   3188.34),
        CFrame.new(-3185.39,  36.72,    1715.80),
    }

    local function matchesOption(g, options)
        for _, opt in ipairs(options) do
            if opt == g.gizmoType then return true end
            if opt == "Break Glass" and g.isJewelry then return true end
        end
        return false
    end

    local function tweenTo(hrp, duration, targetCF)
        if not hrp or not hrp.Parent then return end
        if not FarmConfig.Enabled and not AutoFarmConfig.Enabled then return end
        local tw = TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), { CFrame = targetCF })
        tw:Play()
        while tw.PlaybackState == Enum.PlaybackState.Playing do
            if not FarmConfig.Enabled and not AutoFarmConfig.Enabled then tw:Cancel() return end
            task.wait(0.05)
        end
    end

    local function tickFarmAura()
        local hrp = getHRP()
        if not hrp then return end
        local hasBuzz = findBuzzsaw() ~= nil
        for _, opt in ipairs(FarmConfig.Options) do
            if opt == "Break Glass" and hasBuzz then breakGlass(hrp) break end
        end
        if #FarmConfig.Options == 0 then return end
        local gizmos = getGizmos(hrp)
        local cashList, otherList = {}, {}
        for _, g in ipairs(gizmos) do
            if g.dist < FarmConfig.Range and canInteract(g) and matchesOption(g, FarmConfig.Options) then
                if isCash(g) then table.insert(cashList, g)
                else table.insert(otherList, g) end
            end
        end
        for i = 1, #cashList do interact(cashList[i]) end
        table.sort(otherList, function(a, b) return a.dist < b.dist end)
        for i = 1, math.min(3, #otherList) do interact(otherList[i]) end
    end

    task.spawn(function()
        while true do
            if FarmConfig.Enabled then pcall(tickFarmAura) end
            task.wait(0.03)
        end
    end)

    local function getBagFullPercent()
        local ok2, data = pcall(function()
            return require(ReplicatedStorage.Devv).load("ClientData").Get()
        end)
        if not ok2 or type(data) ~= "table" or type(data.bag) ~= "table" then return 0 end
        local totalWeight = 0
        if type(data.bag.contents) == "table" then
            local Objects = require(ReplicatedStorage.Shared.Wanted.Indicies.Objects)
            for _, itemName in pairs(data.bag.contents) do
                if type(itemName) == "string" then
                    local w = Objects.GetDataProperty(itemName, "weight")
                    if type(w) == "number" then totalWeight += w end
                end
            end
        end
        local UpgradeUtil = require(ReplicatedStorage.Shared.Wanted.Modules.UpgradeUtil)
        local cap = UpgradeUtil.GetBagCapacity()
        if type(cap) ~= "number" or cap <= 0 then
            cap = type(data.bag.capacity) == "number" and data.bag.capacity or 1
        end
        return totalWeight / cap
    end

    local function isBagFull(threshold)
        threshold = threshold or 0.8
        if LocalPlayer:GetAttribute("isBagFull") then return true end
        if not LocalPlayer:GetAttribute("hasLootBag") then return false end
        return getBagFullPercent() >= threshold
    end

    local function sellLoot()
        local hrp = getHRP()
        if not hrp then return false end
        tweenTo(hrp, 1, hrp.CFrame + Vector3.new(0, 150, 0))
        if not AutoFarmConfig.Enabled then return true end
        hrp = getHRP()
        if not hrp then return true end
        local dest = Vector3.new(AutoFarmConfig.SellPos.X, hrp.Position.Y, AutoFarmConfig.SellPos.Z)
        tweenTo(hrp, (hrp.Position - dest).Magnitude / 150, CFrame.new(dest))
        if not AutoFarmConfig.Enabled then return true end
        hrp = getHRP()
        if not hrp then return true end
        tweenTo(hrp, 3, CFrame.new(AutoFarmConfig.SellPos))
        if not AutoFarmConfig.Enabled then return true end
        pcall(invokeServer, "sellLoot", "Ofy")
        return true
    end

    local autoFarmRunning = false
    local function startAutoFarm()
        if autoFarmRunning then return end
        autoFarmRunning = true
        task.spawn(function()
            while AutoFarmConfig.Enabled do
                pcall(function()
                    local hrp = getHRP()
                    if not hrp or not getHum() then return end

                    if isBagFull(AutoFarmConfig.BagFullThreshold) then
                        sellLoot()
                        return
                    end

                    local spot = FARM_SPOTS[math.random(1, #FARM_SPOTS)]
                    local dist = (hrp.Position - spot.Position).Magnitude
                    tweenTo(hrp, math.max(dist / 100, 0.3), spot)
                    if not AutoFarmConfig.Enabled then return end

                    local hasBuzz = findBuzzsaw() ~= nil
                    local gizmos = getGizmos(getHRP())
                    local targets = {}
                    for _, g in ipairs(gizmos) do
                        if canInteract(g) and matchesOption(g, AutoFarmConfig.Options) then
                            table.insert(targets, g)
                        end
                    end
                    table.sort(targets, function(a, b) return a.dist < b.dist end)

                    for _, g in ipairs(targets) do
                        if not AutoFarmConfig.Enabled then return end
                        if isBagFull(AutoFarmConfig.BagFullThreshold) then sellLoot(); return end

                        hrp = getHRP()
                        if not hrp then return end
                        local targetCF = g.cframe and (g.cframe * CFrame.new(0, 1, -1)) or CFrame.new(g.position)
                        tweenTo(hrp, math.max((hrp.Position - targetCF.Position).Magnitude / 60, 0.05), targetCF)

                        if g.isJewelry and hasBuzz then
                            breakGlass(hrp)
                            task.wait(0.35)
                        end
                        interact(g)

                        local waitTime = (g.gizmoType == "ATM" or g.gizmoType == "Register") and 2.5 or 0.6
                        task.wait(waitTime)
                    end
                end)
                task.wait(0.1)
            end
            autoFarmRunning = false
        end)
    end

    local function stopAutoFarm()
        AutoFarmConfig.Enabled = false
    end

    -- ============================================
    -- WindUI 控件（挂 Tabs.lc）
    -- ============================================
    Tabs.lc:Section({ Title = "农场光环" })

    Tabs.lc:Toggle({
        Title = "开启农场光环",
        Desc = "",
        Default = false,
        Callback = function(v) FarmConfig.Enabled = v end,
    })

    Tabs.lc:Slider({
        Title = "触发距离",
        Value = { Min = 5, Max = 50, Default = 15 },
        Step = 1,
        Suffix = " 格",
        Callback = function(v) FarmConfig.Range = v end,
    })

    Tabs.lc:Section({ Title = "交互类型" })

    local optionListFarm = {
        "GasStationSafe", "ATM", "Register", "Lootable", "WorldItem",
        "WorldBag", "MainCashPile", "CashPallet", "Cash", "MilitaryChest",
        "PelicanCase", "WorldSafe", "PC Block", "WorldItemSpawn", "Break Glass",
    }
    for _, opt in ipairs(optionListFarm) do
        Tabs.lc:Toggle({
            Title = GIZMO_NAME_MAP[opt] or opt,
            Default = true,
            Callback = function(v)
                if v then
                    if not table.find(FarmConfig.Options, opt) then
                        table.insert(FarmConfig.Options, opt)
                    end
                else
                    for i = #FarmConfig.Options, 1, -1 do
                        if FarmConfig.Options[i] == opt then
                            table.remove(FarmConfig.Options, i)
                        end
                    end
                end
            end,
        })
    end

    Tabs.lc:Section({ Title = "自动农场" })

    Tabs.lc:Toggle({
        Title = "开启自动农场",
        Desc = "",
        Default = false,
        Callback = function(v)
            AutoFarmConfig.Enabled = v
            if v then startAutoFarm() else stopAutoFarm() end
        end,
    })

    Tabs.lc:Slider({
        Title = "背包出售值",
        Desc = "",
        Value = { Min = 0.5, Max = 1, Default = 0.8 },
        Step = 0.05,
        Callback = function(v) AutoFarmConfig.BagFullThreshold = v end,
    })
    
    Tabs.lc:Section({ Title = "自动远程打玻璃" })

    local AutoBreakJewel = {
        Enabled  = false,
        Interval = 1.0,
    }

    Tabs.lc:Toggle({
        Title    = "开启自动远程打玻璃",
        Desc     = "",
        Value    = false,
        Callback = function(v)
            AutoBreakJewel.Enabled = v
            if v then
                WindUI:Notify({ Title = "自动打玻璃", Content = "已开启", Duration = 3 })
            else
                WindUI:Notify({ Title = "自动打玻璃", Content = "已关闭", Duration = 3 })
            end
        end,
    })

    Tabs.lc:Slider({
        Title    = "打玻璃间隔",
        Desc     = "",
        Value    = { Min = 0.2, Max = 5, Default = 1.0 },
        Step     = 0.1,
        Callback = function(v) AutoBreakJewel.Interval = v end,
    })

    -- ⭐ 自动打玻璃执行循环
    task.spawn(function()
        local lastBreakTime = 0
        while true do
            if AutoBreakJewel.Enabled and ClientProps and type(ClientProps.worldPropsById) == "table" then
                pcall(function()
                    local now = tick()
                    if now - lastBreakTime >= 0.5 then -- 防请求过快
                        local myChar = LocalPlayer.Character
                        if myChar then
                            local myHRP = myChar:FindFirstChild("HumanoidRootPart")
                            if myHRP then
                                local bestGuid = nil
                                local bestDist = math.huge

                                for guid, prop in pairs(ClientProps.worldPropsById) do
                                    if type(prop) == "table" and prop.name == "JewelSpawn" and not prop.isShattered then
                                        local pos = (prop.GetPosition and prop:GetPosition())
                                            or (prop.model and prop.model.PrimaryPart and prop.model.PrimaryPart.Position)
                                        if pos then
                                            local d = (myHRP.Position - pos).Magnitude
                                            if d < bestDist then
                                                bestDist = d
                                                bestGuid = guid
                                            end
                                        end
                                    end
                                end

                                if bestGuid then
                                    lastBreakTime = now
                                    pcall(function()
                                        -- ⭐ 使用真实名字 "breakJewelCase" 打破
                                        fireServer("breakJewelCase", bestGuid)
                                    end)
                                    print("自动打玻璃" .. math.floor(bestDist) .. " 格")
                                end
                            end
                        end
                    end
                end)
            end
            task.wait(AutoBreakJewel.Interval)
        end
    end)
end
------远程击杀*-------
Tabs.jx:Button({
    Title = "远程传送击杀",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/%E8%BF%9C%E7%A8%8B%E5%87%BB%E6%9D%80.lua"))()
    end
})
--------
local selectedPlayerName = "无"     -- 当前选中的目标玩家名字
local isLoopTeleport = false        -- 是否开启循环传送

-- ==================== 核心逻辑 ====================
-- 获取玩家的 HumanoidRootPart
local function getHRP(plr)
    if plr and plr.Character then
        return plr.Character:FindFirstChild("HumanoidRootPart")
    end
    return nil
end

-- 获取服务器所有玩家名字（排除自己）
local function getPlayerNames()
    local names = {"无"}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            table.insert(names, plr.Name)
        end
    end
    return names
end

-- 执行传送：把目标玩家传到我的面前
local function teleportTargetToMe()
    if selectedPlayerName == "无" then return end

    local localHRP = getHRP(LocalPlayer)
    if not localHRP then return end

    local targetPlr = Players:FindFirstChild(selectedPlayerName)
    local targetHRP = getHRP(targetPlr)
    if not targetHRP then return end

    -- 计算本地玩家前方 4 格的位置
    local frontPosition = localHRP.CFrame * CFrame.new(0, 0, -4)
    
    -- 强行把目标玩家传送到面前（本地视角）
    pcall(function()
        targetHRP.CFrame = frontPosition
    end)
end

-- ==================== UI 控件 ====================

Tabs.jx:Dropdown({
    Title = "选择服务器玩家",
    Desc = "",
    Values = getPlayerNames(),
    Default = "无",
    Callback = function(option)
        selectedPlayerName = option
    end,
})

-- 2. 刷新玩家列表按钮
Tabs.jx:Button({
    Title = "刷新玩家列表",
    Desc = "",
    Callback = function()
        local newNames = getPlayerNames()
        PlayerDropdown:SetValues(newNames)
        WindUI:Notify({
            Title = "刷新成功",
            Content = "玩家列表已更新",
            Duration = 3,
            Icon = "check",
        })
    end,
})
-- 4. 循环传送开关
Tabs.jx:Toggle({
    Title = "循环传送",
    Desc = "",
    Default = false,
    Callback = function(state)
        isLoopTeleport = state
    end,
})

-- 循环传送逻辑
RunService.RenderStepped:Connect(function()
    if isLoopTeleport and selectedPlayerName ~= "无" then
        teleportTargetToMe()
    end
end)

-- ==================== 监听玩家离开，更新列表 ====================
Players.PlayerRemoving:Connect(function(plr)
    if plr.Name == selectedPlayerName then
        selectedPlayerName = "无"
    end
    pcall(function()
        PlayerDropdown:SetValues(getPlayerNames())
    end)
end)
Tabs.jx:Code({
    Title = "使用方法",
    Code = "先开启ESP查看周围玩家名字再点击你要吸过来的玩家名字并击杀"
})
Tabs.jx:Code({
    Title = "当然你也可以在安全区内击杀玩家",
    Code = "天天开心哦"
})
-- ============================================
-- 服务
-- ==================== 光环设置页（真实函数名，换服不换数字） ====================
local AuraPlayers           = game:GetService("Players")
local AuraReplicatedStorage = game:GetService("ReplicatedStorage")
local AuraLocalPlayer       = AuraPlayers.LocalPlayer

local AuraDevvFolder = AuraReplicatedStorage:FindFirstChild("Devv") or AuraReplicatedStorage:FindFirstChild("devv")
if not AuraDevvFolder then
    warn("❌ [光环] 请在《通缉》游戏内执行此脚本！")
else
    local AuraDevvModule = require(AuraDevvFolder)
    local AuraNetwork    = AuraDevvModule.load("Network")
    local AuraFireServer = AuraNetwork.FireServer

    -- ⭐ 抓包验证过的真实动作名
    local STOMP_ACTION  = "finish"   -- 踩踏
    local ARREST_ACTION = "arrest"   -- 逮捕
    local GRAB_ACTION   = "grab"     -- 抓取
    local REVIVE_ACTION = "revive"   -- 救援

    -- ==================== 配置 ====================
    local AuraConfig = {
        Stomp  = { Enabled = false, Interval = 0.5, Range = 50 },  
        Arrest = { Enabled = false, Interval = 0.5, Range = 50 },  
        Grab   = { Enabled = false, Interval = 0.5, Range = 50 },  
        Revive = { Enabled = false, Interval = 0.5, Range = 50 },  
    }

    -- ==================== 找最近的可操作目标 ====================
    -- skipTeam = true 时跳过队友；false 时对所有人生效
    local function getClosestAuraTarget(range, skipTeam)
        local myChar = AuraLocalPlayer.Character
        if not myChar then return nil end
        local myHRP = myChar:FindFirstChild("HumanoidRootPart")
        if not myHRP then return nil end

        local closest, minDist = nil, math.huge

        for _, plr in ipairs(AuraPlayers:GetPlayers()) do
            if plr ~= AuraLocalPlayer and plr.Character then
                local isTeammate = plr.Team and AuraLocalPlayer.Team and plr.Team == AuraLocalPlayer.Team
                if not (skipTeam and isTeammate) then
                    local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
                    if hrp and hum and hum.Health > 0 then
                        local isDowned = plr:GetAttribute("isDowned")
                            or plr:GetAttribute("knocked")
                            or plr:GetAttribute("crawling")
                        local dist = (hrp.Position - myHRP.Position).Magnitude
                        if dist <= range and dist < minDist and isDowned ~= false then
                            minDist = dist
                            closest = plr
                        end
                    end
                end
            end
        end
        return closest
    end

    -- ==================== 四个光环的循环 ====================
    -- 踩踏光环（跳过队友）
    task.spawn(function()
        while true do
            if AuraConfig.Stomp.Enabled then
                local target = getClosestAuraTarget(AuraConfig.Stomp.Range, true)
                if target then
                    pcall(function()
                        AuraFireServer(STOMP_ACTION, target.UserId)
                    end)
                end
            end
            task.wait(AuraConfig.Stomp.Interval)
        end
    end)

    -- 逮捕光环（不检查队友）
    task.spawn(function()
        while true do
            if AuraConfig.Arrest.Enabled then
                local target = getClosestAuraTarget(AuraConfig.Arrest.Range, false)
                if target then
                    pcall(function()
                        AuraFireServer(ARREST_ACTION, target.UserId)
                    end)
                end
            end
            task.wait(AuraConfig.Arrest.Interval)
        end
    end)

    -- 抓取光环（跳过队友）
    task.spawn(function()
        while true do
            if AuraConfig.Grab.Enabled then
                local target = getClosestAuraTarget(AuraConfig.Grab.Range, true)
                if target then
                    pcall(function()
                        AuraFireServer(GRAB_ACTION, target.UserId)
                    end)
                end
            end
            task.wait(AuraConfig.Grab.Interval)
        end
    end)

    -- 救援光环（不检查队友）
    task.spawn(function()
        while true do
            if AuraConfig.Revive.Enabled then
                local target = getClosestAuraTarget(AuraConfig.Revive.Range, false)
                if target then
                    pcall(function()
                        AuraFireServer(REVIVE_ACTION, target.UserId)
                    end)
                end
            end
            task.wait(AuraConfig.Revive.Interval)
        end
    end)

    -- ==================== WindUI：gh 标签页 ====================
    Tabs.gh:Section({ Title = "踩踏光环" })

    Tabs.gh:Toggle({
        Title = "启用踩踏",
        Default = false,
        Callback = function(v) AuraConfig.Stomp.Enabled = v end,
    })
    Tabs.gh:Slider({
        Title = "踩踏间隔",
        Value = { Min = 0.01, Max = 5, Default = 0.5 },
        Step = 0.01,
        Callback = function(v) AuraConfig.Stomp.Interval = v end,
    })

    Tabs.gh:Divider()

    Tabs.gh:Section({ Title = "逮捕光环" })

    Tabs.gh:Toggle({
        Title = "启用逮捕",
        Default = false,
        Callback = function(v) AuraConfig.Arrest.Enabled = v end,
    })
    Tabs.gh:Slider({
        Title = "逮捕间隔",
        Value = { Min = 0.01, Max = 5, Default = 0.5 },
        Step = 0.01,
        Callback = function(v) AuraConfig.Arrest.Interval = v end,
    })

    Tabs.gh:Divider()

    Tabs.gh:Section({ Title = "抓取光环" })

    Tabs.gh:Toggle({
        Title = "启用抓取光环",
        Default = false,
        Callback = function(v) AuraConfig.Grab.Enabled = v end,
    })
    Tabs.gh:Slider({
        Title = "抓取间隔",
        Value = { Min = 0.01, Max = 5, Default = 0.5 },
        Step = 0.01,
        Callback = function(v) AuraConfig.Grab.Interval = v end,
    })

    Tabs.gh:Divider()

    Tabs.gh:Section({ Title = "救援光环" })

    Tabs.gh:Toggle({
        Title = "启用救援",
        Default = false,
        Callback = function(v) AuraConfig.Revive.Enabled = v end,
    })
    Tabs.gh:Slider({
        Title = "救援间隔",
        Value = { Min = 0.01, Max = 5, Default = 0.5 },
        Step = 0.01,
        Callback = function(v) AuraConfig.Revive.Interval = v end,
    })    
end
-- ============================================
-- 辅助瞄准（完整版）挂到 fz
-- + 队伍阵营过滤 + 掩体检测 + FOV 圈
-- + 白名单（勾上 = 不瞄准）
-- ============================================
do
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local UserInputService  = game:GetService("UserInputService")
    local RunService        = game:GetService("RunService")
    local Players           = game:GetService("Players")
    local LocalPlayer       = Players.LocalPlayer
    local Camera            = workspace.CurrentCamera

    -- ============================================
    -- 加载 Wanted 内部模块（失败不崩）
    -- ============================================
    local ClientSettings, SettingsData, AimAssistModule

    local modulesOk = pcall(function()
        local DevvFolder = ReplicatedStorage:FindFirstChild("Devv") or ReplicatedStorage:FindFirstChild("devv")
        if not DevvFolder then error("Devv 不存在") end
        local DevvModule = require(DevvFolder)
        local load = DevvModule.load

        ClientSettings  = load("ClientSettings")
        SettingsData    = require(ReplicatedStorage.Shared.Wanted.Indicies.SettingsData)
        AimAssistModule = require(ReplicatedStorage.Client.Wanted.Objects.ClientTool.Components.Tools.Guns.AimAssist)
    end)

    if not modulesOk then
        WindUI:Notify({
            Title = "辅助瞄准",
            Content = "未检测到 Wanted 模块，请进游戏后再执行",
            Icon = "alert-circle",
            Duration = 5,
        })
    else

        local function getChar() return LocalPlayer.Character end
        local function getHRP()  local c = getChar(); return c and c:FindFirstChild("HumanoidRootPart") end

        local function getPlayerList()
            local list = {}
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then table.insert(list, p) end
            end
            return list
        end

        local function getCamp(plr)
            if not plr then return nil end
            local team = plr:GetAttribute("currentTeam")
            if type(team) == "string" then return team end
            if plr.Team then return plr.Team.Name end
            return nil
        end

        local function getMyCamp() return getCamp(LocalPlayer) end

        local function isTeammate(plr)
            if plr == LocalPlayer then return true end
            local myCamp = getMyCamp()
            local pCamp  = getCamp(plr)
            if myCamp == nil or pCamp == nil then
                return plr.Team ~= nil and plr.Team == LocalPlayer.Team
            end
            return myCamp == pCamp
        end


        local rayParams = RaycastParams.new()
        rayParams.FilterType = Enum.RaycastFilterType.Exclude
        rayParams.IgnoreWater = true

        local function checkWall(targetPart)
            if not targetPart or not targetPart.Parent then return true end
            local char = getChar()
            if not char then return true end

            local origin    = workspace.CurrentCamera.CFrame.Position
            local targetPos = targetPart.Position
            local dir       = targetPos - origin
            local dist      = dir.Magnitude
            if dist < 0.1 then return false end

            rayParams.FilterDescendantsInstances = { char, workspace.CurrentCamera }
            local result = workspace:Raycast(origin, dir, rayParams)
            if not result then return false end

            if result.Instance and result.Instance:IsDescendantOf(targetPart.Parent) then
                return false
            end
            if (result.Position - targetPos).Magnitude <= 0.6 then
                return false
            end
            return true
        end


        local AA = {
            Enabled = false, Part = "Body",
            SpeedX = 2.7, SpeedY = 1,
            PredictionX = 2.8, PredictionY = 2.6,
            IgnoreTeammate = true, CampFilter = "全部",
            WallCheck = true,

            -- FOV 圈（唯一范围限制）
            ShowFOV        = false,
            FOVRadius      = 250,
            FOVFixed       = true,
            FOVColor       = Color3.fromRGB(190, 120, 255),
            FOVThickness   = 1.5,
            FOVTransparency= 0.3,
            FOVSides       = 64,
        }
        local originalAimStep = AimAssistModule.Step

        local function setAssistSensitivity(v)
            pcall(function()
                local setting = SettingsData.settingDataByName and SettingsData.settingDataByName.assistSensitivity
                if type(setting) == "table" then setting.defaultValue = v end
                if type(ClientSettings.Set) == "function" then
                    ClientSettings.Set("assistSensitivity", v)
                end
            end)
        end

        local function getViewportCenter(cam)
            if UserInputService.TouchEnabled then
                return cam.ViewportSize.X * 0.5, cam.ViewportSize.Y * 0.5
            end
            local m = UserInputService:GetMouseLocation()
            return m.X, m.Y
        end

        -- 指定阵营时不再受"忽略队友"二次过滤
        -- ⭐ 白名单最高优先：勾上 = 直接跳过，不瞄
        local function isAllowedTarget(plr)
            if _G.WL and _G.WL[plr.Name] == true then return false end

            if AA.CampFilter ~= "全部" then
                local camp = getCamp(plr)
                if AA.CampFilter == "仅警察" and camp ~= "police"    then return false end
                if AA.CampFilter == "仅帮派" and camp ~= "syndicate" then return false end
                if AA.CampFilter == "仅平民" and camp ~= "civilian"  then return false end
                return true
            else
                if AA.IgnoreTeammate and isTeammate(plr) then return false end
                return true
            end
        end


        local fovCircle = Drawing.new("Circle")
        fovCircle.Visible       = false
        fovCircle.Filled        = false
        fovCircle.NumSides      = AA.FOVSides
        fovCircle.Radius        = AA.FOVRadius
        fovCircle.Thickness     = AA.FOVThickness
        fovCircle.Transparency  = AA.FOVTransparency
        fovCircle.Color         = AA.FOVColor
        fovCircle.Position      = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

        local function updateFOVCircle()
            if not fovCircle then return end
            fovCircle.Visible      = AA.ShowFOV and AA.Enabled
            fovCircle.Radius       = AA.FOVRadius
            fovCircle.Thickness    = AA.FOVThickness
            fovCircle.Transparency = AA.FOVTransparency
            fovCircle.Color        = AA.FOVColor
            fovCircle.NumSides     = AA.FOVSides

            if AA.ShowFOV and AA.Enabled then
                if AA.FOVFixed then
                    fovCircle.Position = Vector2.new(
                        Camera.ViewportSize.X / 2,
                        Camera.ViewportSize.Y / 2
                    )
                else
                    local m = UserInputService:GetMouseLocation()
                    fovCircle.Position = Vector2.new(m.X, m.Y)
                end
            end
        end

        RunService.RenderStepped:Connect(function()
            pcall(updateFOVCircle)
        end)


        local function aimStep(self, dt)
            local tool = self and self.tool
            local ts = tool and tool.toolState
            if not ts or (ts.ammo or 0) <= 0 then
                return originalAimStep(self, dt)
            end
            local char, hrp, cam = getChar(), getHRP(), workspace.CurrentCamera
            if not char or not hrp or not cam then
                return originalAimStep(self, dt)
            end

            local cFrame = cam.CFrame
            local vp = cam.ViewportSize
            local sx, sy = getViewportCenter(cam)
            local bestScore, bestYaw, bestPitch = math.huge, nil, nil

            for _, plr in ipairs(getPlayerList()) do
                if isAllowedTarget(plr) then
                    local pchar = plr.Character
                    local phum = pchar and pchar:FindFirstChildOfClass("Humanoid")
                    local phrp = pchar and pchar:FindFirstChild("HumanoidRootPart")
                    local phead = pchar and pchar:FindFirstChild("Head")
                    if pchar and phum and phum.Health > 0 and phrp then
                        local target
                        if AA.Part == "Head" then target = phead or phrp
                        else
                            local ut = pchar:FindFirstChild("UpperTorso") or pchar:FindFirstChild("Torso") or phrp
                            target = ut
                        end

                        local blocked = AA.WallCheck and checkWall(target) or false
                        if not blocked then
                            local predict = target.Position
                                + (target.AssemblyLinearVelocity or Vector3.zero) * (AA.PredictionX * 0.01)
                            local rel = cFrame:PointToObjectSpace(predict)
                            local mag = rel.Magnitude
                            if mag > 0.35 then
                                local inv = 1 / mag
                                local fwd = -rel.Z * inv
                                if fwd > 0.02 then
                                    local sp = cam:WorldToViewportPoint(predict)
                                    local dx = sp.X - sx
                                    local dy = sp.Y - sy
                                    local pixDist = math.sqrt(dx * dx + dy * dy)
                                    -- 唯一范围限制：FOV 圈像素距离
                                    if pixDist <= AA.FOVRadius then
                                        local score = pixDist * pixDist
                                        if score < bestScore then
                                            local yaw = math.atan2(rel.X * inv, fwd)
                                            local pitch = math.atan2(rel.Y * inv, fwd)
                                            bestYaw, bestPitch = math.deg(yaw), math.deg(pitch)
                                            bestScore = score
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end

            if bestYaw then
                local mod = 1
                if tool and tool.GetData then
                    local ok, data = pcall(tool.GetData, tool)
                    if ok and data and data.aimAssistMod then mod = data.aimAssistMod end
                end
                local spX = AA.SpeedX * mod * dt * 10
                local spY = AA.SpeedY * mod * dt * 10
                local curX = LocalPlayer:GetAttribute("xAngle") or 0
                local curY = LocalPlayer:GetAttribute("yAngle") or 0
                LocalPlayer:SetAttribute("xAngle", (curX - bestYaw * spX) % 360)
                LocalPlayer:SetAttribute("yAngle", math.clamp(curY + bestPitch * spY, -80, 80))
            end
        end

        Tabs.fz:Section({ Title = "辅助瞄准" })

        Tabs.fz:Toggle({
            Title = "启用辅助瞄准",
            Desc = "",
            Default = false,
            Callback = function(v)
                AA.Enabled = v
                if v then
                    AimAssistModule.Step = aimStep
                    WindUI:Notify({ Title = "辅助瞄准", Content = "已开启", Icon = "check", Duration = 2 })
                else
                    AimAssistModule.Step = originalAimStep
                    WindUI:Notify({ Title = "辅助瞄准", Content = "已关闭", Icon = "x", Duration = 2 })
                end
                updateFOVCircle()
            end,
        })

        Tabs.fz:Dropdown({
            Title = "瞄准部位",
            Values = {"Head", "Body"},
            Default = "Body",
            Callback = function(v) AA.Part = v end,
        })

        Tabs.fz:Slider({
            Title = "水平速度",
            Value = { Min = 0.1, Max = 5, Default = 2.7 },
            Step = 0.1,
            IsTextbox = true,
            Callback = function(v)
                AA.SpeedX = v
                setAssistSensitivity(v)
            end,
        })

        Tabs.fz:Slider({
            Title = "垂直速度",
            Value = { Min = 0.1, Max = 5, Default = 1 },
            Step = 0.1,
            IsTextbox = true,
            Callback = function(v) AA.SpeedY = v end,
        })

        Tabs.fz:Slider({
            Title = "水平预判",
            Value = { Min = 0, Max = 7, Default = 2.8 },
            Step = 0.01,
            IsTextbox = true,
            Callback = function(v) AA.PredictionX = v end,
        })

        Tabs.fz:Slider({
            Title = "垂直预判",
            Value = { Min = 0, Max = 7, Default = 2.6 },
            Step = 0.01,
            IsTextbox = true,
            Callback = function(v) AA.PredictionY = v end,
        })

        Tabs.fz:Section({ Title = "FOV 圈" })

        Tabs.fz:Toggle({
            Title = "显示 FOV 圈",
            Desc = "只有圈内目标会被吸附",
            Default = false,
            Callback = function(v)
                AA.ShowFOV = v
                updateFOVCircle()
            end,
        })

        Tabs.fz:Toggle({
            Title = "固定在屏幕中心",
            Desc = "关 = 跟随鼠标",
            Default = true,
            Callback = function(v)
                AA.FOVFixed = v
                updateFOVCircle()
            end,
        })

        Tabs.fz:Slider({
            Title = "FOV 圈半径",
            Value = { Min = 20, Max = 1000, Default = 250 },
            Step = 5,
            IsTextbox = true,
            Suffix = " px",
            Callback = function(v)
                AA.FOVRadius = v
                updateFOVCircle()
            end,
        })

        Tabs.fz:Slider({
            Title = "线条粗细",
            Value = { Min = 1, Max = 8, Default = 2 },
            Step = 1,
            IsTextbox = true,
            Callback = function(v)
                AA.FOVThickness = v
                updateFOVCircle()
            end,
        })

        Tabs.fz:Slider({
            Title = "透明度",
            Value = { Min = 0, Max = 1, Default = 0.3 },
            Step = 0.05,
            Callback = function(v)
                AA.FOVTransparency = v
                updateFOVCircle()
            end,
        })

        Tabs.fz:Dropdown({
            Title = "圈颜色",
            Values = { "紫色", "红色", "绿色", "蓝色", "白色", "黄色" },
            Default = "紫色",
            Callback = function(v)
                local map = {
                    ["紫色"] = Color3.fromRGB(190, 120, 255),
                    ["红色"] = Color3.fromRGB(255, 80, 80),
                    ["绿色"] = Color3.fromRGB(80, 255, 120),
                    ["蓝色"] = Color3.fromRGB(80, 160, 255),
                    ["白色"] = Color3.fromRGB(255, 255, 255),
                    ["黄色"] = Color3.fromRGB(255, 220, 80),
                }
                AA.FOVColor = map[v] or map["紫色"]
                updateFOVCircle()
            end,
        })

        Tabs.fz:Dropdown({
            Title = "圆的边数（越大越圆）",
            Values = { "32", "48", "64", "96", "128" },
            Default = "64",
            Callback = function(v)
                AA.FOVSides = tonumber(v) or 64
                updateFOVCircle()
            end,
        })

        Tabs.fz:Section({ Title = "队伍阵营过滤" })

        Tabs.fz:Toggle({
            Title = "忽略队友仅全部阵营时生效",
            Desc = "",
            Default = true,
            Callback = function(v) AA.IgnoreTeammate = v end,
        })

        Tabs.fz:Dropdown({
            Title = "只吸附指定阵营",
            Desc = "",
            Values = {"全部", "仅警察", "仅帮派", "仅平民"},
            Default = "全部",
            Callback = function(v) AA.CampFilter = v end,
        })

        Tabs.fz:Divider()

        Tabs.fz:Section({ Title = "掩体检测" })

        Tabs.fz:Toggle({
            Title = "启用掩体检测",
            Default = true,
            Callback = function(v)
                AA.WallCheck = v
                WindUI:Notify({
                    Title = "掩体检测",
                    Content = v and "已开启" or "已关闭",
                    Icon = v and "check" or "x",
                    Duration = 2,
                })
            end,
        })


        Tabs.fz:Divider()
        Tabs.fz:Section({ Title = "白名单" })

        _G.WL = _G.WL or {}
        local WL_Created = {}

        local function WL_AddFor(playerName)
            if WL_Created[playerName] then return end
            Tabs.fz:Toggle({
                Title    = playerName,
                Desc     = "",
                Default  = false,
                Callback = function(v)
                    _G.WL = _G.WL or {}
                    if v then
                        _G.WL[playerName] = true
                    else
                        _G.WL[playerName] = nil
                    end
                end,
            })
            WL_Created[playerName] = true
        end

        -- 初始化：当前房间里所有玩家
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                WL_AddFor(p.Name)
            end
        end

        -- 新玩家进服自动追加开关
        Players.PlayerAdded:Connect(function(p)
            if p ~= LocalPlayer then
                task.wait(0.3)
                WL_AddFor(p.Name)
            end
        end)

        -- 玩家离开：清掉全局标记，防止同名再来被误判
        Players.PlayerRemoving:Connect(function(p)
            if _G.WL then
                _G.WL[p.Name] = nil
            end
        end)

        -- 手动刷新
        Tabs.fz:Button({
            Title    = "刷新白名单列表",
            Callback = function()
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer then
                        WL_AddFor(p.Name)
                    end
                end
                WindUI:Notify({
                    Title    = "白名单",
                    Content  = "已刷新",
                    Icon     = "check",
                    Duration = 2,
                })
            end,
        })

    end
end  
-- ==================== 范围 (完美修复版) ====================
local btHbSize = 8
local btHbConn = nil
local btCharConns = {} -- 记录玩家的重生事件

local function btExpandPlayer(player)
    if player == LocalPlayer then return end
    local char = player.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return end
    local hrpX = char:FindFirstChild("HumanoidRootPart")
    if not hrpX then return end
    
    local size = math.clamp(btHbSize, 1, 100)
    pcall(function()
        hrpX.Size = Vector3.new(size, size, size)
        hrpX.Transparency = 0.85
        hrpX.Color = Color3.fromRGB(190, 190, 190)
        hrpX.Material = Enum.Material.Neon
        hrpX.CanCollide = false
    end)
end

local function btResetPlayer(player)
    if player == LocalPlayer then return end 
    local char = player.Character
    if not char then return end
    local hrpX = char:FindFirstChild("HumanoidRootPart")
    if not hrpX then return end
    pcall(function()
        hrpX.Size = Vector3.new(2, 2, 1) 
        hrpX.Transparency = 1            
        hrpX.Color = Color3.fromRGB(163, 162, 165)
        hrpX.Material = Enum.Material.Plastic
        hrpX.CanCollide = true
    end)
end

local function btBindPlayer(player)
    if player == LocalPlayer then return end
    if btCharConns[player] then
        btCharConns[player]:Disconnect()
        btCharConns[player] = nil
    end
    btCharConns[player] = player.CharacterAdded:Connect(function()
        task.wait(1)
        if btHbConn then
            btExpandPlayer(player)
        end
    end)
end

Tabs.bot:Toggle({
    Title = "范围",
    Desc = "",
    Default = false,
    Callback = function(state)
        if state then
            -- 先清理旧连接
            if btHbConn then btHbConn:Disconnect() end
            for _, conn in pairs(btCharConns) do pcall(function() conn:Disconnect() end) end
            table.clear(btCharConns)

            -- 开启循环放大
            btHbConn = RunService.Heartbeat:Connect(function()
                for _, p in ipairs(Players:GetPlayers()) do
                    btExpandPlayer(p)
                end
            end)

            -- 绑定当前已有玩家
            for _, player in ipairs(Players:GetPlayers()) do
                btBindPlayer(player)
            end
            
            -- 监听新加入的玩家
            if not _G._BTPlayerAddedConn then
                _G._BTPlayerAddedConn = Players.PlayerAdded:Connect(function(p)
                    if btHbConn then
                        btBindPlayer(p)
                    end
                end)
            end
        else
            -- 关闭逻辑
            if btHbConn then
                btHbConn:Disconnect()
                btHbConn = nil
            end
            for _, conn in pairs(btCharConns) do pcall(function() conn:Disconnect() end) end
            table.clear(btCharConns)
            
            if _G._BTPlayerAddedConn then
                _G._BTPlayerAddedConn:Disconnect()
                _G._BTPlayerAddedConn = nil
            end

            -- 还原所有玩家模型
            for _, p in ipairs(Players:GetPlayers()) do
                btResetPlayer(p)
            end
        end
    end,
})

Tabs.bot:Slider({
    Title = "范围",
    Desc = "",
    Value = { Min = 0, Max = 100, Default = 8 },
    Step = 1,
    Callback = function(value)
        btHbSize = value
    end,
})
-- ==================== zj 标签：子追静默瞄准（WindUI 格式） ====================

_G.WL = _G.WL or {}

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
sa_FOVStroke.Color = Color3.fromRGB(255, 0, 0)

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
        if p ~= LocalPlayer
           and not (_G.WL and _G.WL[p.Name])                                -- ⭐ 白名单过滤
           and not (SilentAimSettings.TeamCheck and p.Team == LocalPlayer.Team) then
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
-- WindUI 控件（全部挂在 Tabs.zj）
-- ═══════════════════════════════════════════════════

-- 主开关
Tabs.zj:Toggle({
    Title = "启用静默瞄准",
    Desc = "开启后子弹自动打向敌人",
    Default = false,
    Callback = function(v) SilentAimSettings.Enabled = v end,
})

Tabs.zj:Toggle({
    Title = "队伍检查",
    Desc = "忽略队友",
    Default = false,
    Callback = function(v) SilentAimSettings.TeamCheck = v end,
})

Tabs.zj:Toggle({
    Title = "可见性检查",
    Desc = "被墙挡住的不锁",
    Default = false,
    Callback = function(v) SilentAimSettings.VisibleCheck = v end,
})

Tabs.zj:Toggle({
    Title = "穿墙",
    Default = false,
    Callback = function(v) SilentAimSettings.Wallbang = v end,
})

Tabs.zj:Slider({
    Title = "命中率",
    Value = { Min = 0, Max = 100, Default = 100 },
    Step = 1,
    Callback = function(v) SilentAimSettings.HitChance = v end,
})

Tabs.zj:Divider()

-- 目标设置
Tabs.zj:Dropdown({
    Title = "目标部位",
    Values = { "Head", "HumanoidRootPart" },
    Default = "HumanoidRootPart",
    Callback = function(v) SilentAimSettings.TargetPart = v end,
})

Tabs.zj:Dropdown({
    Title = "优先模式",
    Values = { "准星最近", "距离最近", "最低血量" },
    Default = "准星最近",
    Callback = function(v) SilentAimSettings.PriorityMode = v end,
})

Tabs.zj:Slider({
    Title = "最大距离",
    Value = { Min = 10, Max = 2000, Default = 500 },
    Step = 10,
    Callback = function(v) SilentAimSettings.MaxDistance = v end,
})

Tabs.zj:Divider()

-- FOV 圈
Tabs.zj:Toggle({
    Title = "显示 FOV 圈",
    Default = false,
    Callback = function(v) sa_FOVGui.Enabled = v end,
})

Tabs.zj:Slider({
    Title = "FOV 圈半径",
    Value = { Min = 10, Max = 1000, Default = 130 },
    Step = 10,
    Callback = function(v)
        sa_FOVFrame.Size = UDim2.fromOffset(v * 2, v * 2)
        SilentAimSettings.FOVRadius = v
    end,
})

Tabs.zj:Toggle({
    Title = "固定 FOV（屏幕中心）",
    Default = true,
    Callback = function(v) SilentAimSettings.FixedFOV = v end,
})

Tabs.zj:Divider()

-- 目标指示器
Tabs.zj:Toggle({
    Title = "显示目标指示器",
    Desc = "被锁定的敌人头上显示红圈",
    Default = false,
    Callback = function(v) SilentAimSettings.ShowSilentAimTarget = v end,
})

Tabs.zj:Slider({
    Title = "指示器大小",
    Value = { Min = 5, Max = 50, Default = 20 },
    Step = 1,
    Callback = function(v) SilentAimSettings.TargetIndicatorRadius = v end,
})

Tabs.zj:Divider()

-- 瞄准射线
Tabs.zj:Toggle({
    Title = "显示瞄准射线",
    Default = false,
    Callback = function(v) SilentAimSettings.ShowTracer = v end,
})

Tabs.zj:Toggle({
    Title = "从屏幕底部发射",
    Desc = "关 = 从屏幕中心发射",
    Default = true,
    Callback = function(v) SilentAimSettings.TracerFromBottom = v end,
})

Tabs.zj:Slider({
    Title = "射线粗细",
    Value = { Min = 1, Max = 10, Default = 1 },
    Step = 1,
    Callback = function(v)
        SilentAimSettings.TracerThickness = v
        sa_tracer.Thickness = v
    end,
})

Tabs.zj:Slider({
    Title = "射线透明度",
    Value = { Min = 0, Max = 1, Default = 0.3 },
    Step = 0.05,
    Callback = function(v)
        SilentAimSettings.TracerTransparency = v
        sa_tracer.Transparency = v
    end,
})

Tabs.zj:Divider()

-- ⭐ 白名单（每个玩家一个开关）
Tabs.zj:Section({ Title = "白名单勾上=不攻击" })

local WL_Created = {}

local function WL_AddFor(playerName)
    if WL_Created[playerName] then return end
    Tabs.zj:Toggle({
        Title = playerName,
        Desc = "",
        Default = false,
        Callback = function(v)
            _G.WL = _G.WL or {}
            if v then
                _G.WL[playerName] = true
            else
                _G.WL[playerName] = nil
            end
        end,
    })
    WL_Created[playerName] = true
end

-- 当前所有玩家
for _, p in ipairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then
        WL_AddFor(p.Name)
    end
end

-- 新玩家进服自动加开关
Players.PlayerAdded:Connect(function(p)
    if p ~= LocalPlayer then
        task.wait(0.3)
        WL_AddFor(p.Name)
    end
end)

-- 刷新按钮
Tabs.zj:Button({
    Title = "刷新白名单列表",
    Callback = function()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                WL_AddFor(p.Name)
            end
        end
        WindUI:Notify({
            Title = "白名单",
            Content = "已刷新",
            Icon = "check",
            Duration = 2,
        })
    end,
})

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

print("[静默瞄准] 已加载到 Tabs.zj（WindUI 格式 + 白名单）")
-- ============================================================
-- 完整 ESP（挂载到 Tabs.ESP）
-- 方框 + 血条 + 射线 + 中文属性
-- ============================================================
do
    local Players     = game:GetService("Players")
    local RunService  = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    local Camera      = workspace.CurrentCamera

    -- ==================== 配置 ====================
    local CFG = {
        Enabled       = false,
        MaxDistance   = 2000,
        ShowBox       = false,
        ShowName      = false,
        ShowHealth    = false,
        BoxThickness  = 1,

        ShowTracer          = false,
        TracerOrigin        = "bottom",
        TracerThickness     = 1,
        TracerTransparency  = 0.35,

        W_ShowRank    = false,
        W_ShowWanted  = false,
        W_ShowCash    = false,
        W_ShowStates  = false,

        Color_Police    = Color3.fromRGB(80, 180, 255),
        Color_Syndicate = Color3.fromRGB(255, 80, 80),
        Color_Neutral   = Color3.fromRGB(200, 200, 200),
        Color_Wanted    = Color3.fromRGB(255, 60, 60),
    }

    -- ==================== 工具 ====================
    local function fmtMoney(n)
        if type(n) ~= "number" then return "?" end
        if n >= 1e6 then return string.format("%.2fM", n / 1e6) end
        if n >= 1e3 then return string.format("%.1fK", n / 1e3) end
        return tostring(math.floor(n))
    end

    local function getTeam(plr)
        if not plr then return "civilian", nil end
        local team = plr:GetAttribute("currentTeam")
        if team == "police"    then return "police",    plr:GetAttribute("policeRank") end
        if team == "syndicate" then return "syndicate", plr:GetAttribute("syndicateRank") end
        return "civilian", nil
    end

    local function getColor(plr)
        if not plr then return CFG.Color_Neutral end
        local wanted = plr:GetAttribute("wantedLevel") or 0
        if wanted > 0 then return CFG.Color_Wanted end
        local team = plr:GetAttribute("currentTeam")
        if team == "police"    then return CFG.Color_Police end
        if team == "syndicate" then return CFG.Color_Syndicate end
        return CFG.Color_Neutral
    end

    -- ==================== ScreenGui ====================
    local gui = Instance.new("ScreenGui")
    gui.Name = "FullESP_" .. tostring(math.random(1000, 9999))
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.DisplayOrder = 9998

    local ok = pcall(function() gui.Parent = game:GetService("CoreGui") end)
    if not ok or not gui.Parent then
        gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end

    -- ==================== ESP 组件 ====================
    local ESP = {}

    local function createESP()
        local o = {}

        -- 射线
        local tracer = Drawing.new("Line")
        tracer.Thickness = 1
        tracer.Transparency = 0.35
        tracer.Color = Color3.new(1, 1, 1)
        tracer.Visible = false
        o.tracer = tracer

        -- 方框
        local box = Instance.new("Frame")
        box.BackgroundTransparency = 1
        box.BorderSizePixel = 0
        box.ClipsDescendants = false
        box.Visible = false
        box.ZIndex = 2
        box.Parent = gui
        o.box = box

        local stroke = Instance.new("UIStroke")
        stroke.Thickness = CFG.BoxThickness
        stroke.Color = Color3.new(1, 1, 1)
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke.Parent = box
        o.stroke = stroke

        -- 血条
        local hpBack = Instance.new("Frame")
        hpBack.AnchorPoint = Vector2.new(1, 0)
        hpBack.Position = UDim2.new(0, -1, 0, 0)
        hpBack.Size = UDim2.new(0, 3, 1, 0)
        hpBack.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        hpBack.BackgroundTransparency = 0.15
        hpBack.BorderSizePixel = 0
        hpBack.Parent = box
        o.hpBack = hpBack

        local hpFill = Instance.new("Frame")
        hpFill.AnchorPoint = Vector2.new(0, 1)
        hpFill.Position = UDim2.new(0, 0, 1, 0)
        hpFill.Size = UDim2.new(1, 0, 1, 0)
        hpFill.BackgroundColor3 = Color3.fromRGB(80, 255, 80)
        hpFill.BorderSizePixel = 0
        hpFill.Parent = hpBack
        o.hpFill = hpFill

        -- 名字
        local name = Instance.new("TextLabel")
        name.AnchorPoint = Vector2.new(0.5, 1)
        name.Position = UDim2.new(0.5, 0, 0, -2)
        name.Size = UDim2.new(1, 20, 0, 14)
        name.BackgroundTransparency = 1
        name.Font = Enum.Font.GothamBold
        name.TextSize = 12
        name.TextColor3 = Color3.new(1, 1, 1)
        name.TextStrokeTransparency = 0
        name.TextStrokeColor3 = Color3.new(0, 0, 0)
        name.TextXAlignment = Enum.TextXAlignment.Center
        name.Parent = box
        o.name = name

        -- 3 行信息
        local line1 = Instance.new("TextLabel")
        line1.AnchorPoint = Vector2.new(0.5, 0)
        line1.Position = UDim2.new(0.5, 0, 1, 2)
        line1.Size = UDim2.new(2, 0, 0, 13)
        line1.BackgroundTransparency = 1
        line1.Font = Enum.Font.GothamBold
        line1.TextSize = 11
        line1.TextColor3 = Color3.fromRGB(255, 220, 100)
        line1.TextStrokeTransparency = 0
        line1.TextStrokeColor3 = Color3.new(0, 0, 0)
        line1.TextXAlignment = Enum.TextXAlignment.Center
        line1.Parent = box
        o.line1 = line1

        local line2 = Instance.new("TextLabel")
        line2.AnchorPoint = Vector2.new(0.5, 0)
        line2.Position = UDim2.new(0.5, 0, 1, 16)
        line2.Size = UDim2.new(2, 0, 0, 12)
        line2.BackgroundTransparency = 1
        line2.Font = Enum.Font.GothamMedium
        line2.TextSize = 10
        line2.TextColor3 = Color3.fromRGB(200, 200, 200)
        line2.TextStrokeTransparency = 0
        line2.TextStrokeColor3 = Color3.new(0, 0, 0)
        line2.TextXAlignment = Enum.TextXAlignment.Center
        line2.Parent = box
        o.line2 = line2

        local line3 = Instance.new("TextLabel")
        line3.AnchorPoint = Vector2.new(0.5, 0)
        line3.Position = UDim2.new(0.5, 0, 1, 28)
        line3.Size = UDim2.new(2, 0, 0, 12)
        line3.BackgroundTransparency = 1
        line3.Font = Enum.Font.GothamMedium
        line3.TextSize = 10
        line3.TextColor3 = Color3.fromRGB(150, 220, 255)
        line3.TextStrokeTransparency = 0
        line3.TextStrokeColor3 = Color3.new(0, 0, 0)
        line3.TextXAlignment = Enum.TextXAlignment.Center
        line3.Parent = box
        o.line3 = line3

        return o
    end

    local function destroyESP(o)
        if not o then return end
        if o.box and o.box.Parent then
            pcall(function() o.box:Destroy() end)
        end
        if o.tracer then
            pcall(function() o.tracer:Remove() end)
        end
    end

    local function hideESP(o)
        o.box.Visible = false
        if o.tracer then o.tracer.Visible = false end
    end

    -- ==================== 主循环 ====================
    RunService.RenderStepped:Connect(function()
        local list = {}
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                table.insert(list, { char = plr.Character, plr = plr })
            end
        end

        local seen = {}
        for _, item in ipairs(list) do seen[item.char] = true end
        for char, o in pairs(ESP) do
            if not seen[char] or not char.Parent then
                destroyESP(o)
                ESP[char] = nil
            end
        end

        if not CFG.Enabled then
            for _, o in pairs(ESP) do hideESP(o) end
            return
        end

        local myChar = LocalPlayer.Character
        local myHrp  = myChar and myChar:FindFirstChild("HumanoidRootPart")
        local viewport = Camera.ViewportSize

        for _, item in ipairs(list) do
            local char = item.char
            local plr  = item.plr

            if not ESP[char] then ESP[char] = createESP() end
            local o = ESP[char]

            local hum  = char:FindFirstChildOfClass("Humanoid")
            local hrp  = char:FindFirstChild("HumanoidRootPart")
            local head = char:FindFirstChild("Head")
            if not hum or not hrp or not head or hum.Health <= 0 then
                hideESP(o); continue
            end

            local dist = myHrp and (myHrp.Position - hrp.Position).Magnitude or 9999
            if dist > CFG.MaxDistance then hideESP(o); continue end

            local topPos, topOn = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
            local botPos, botOn = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 2.8, 0))
            if not topOn or not botOn then hideESP(o); continue end

            local height = math.abs(botPos.Y - topPos.Y)
            if height < 1 then hideESP(o); continue end   -- ✅ 原版是 <10，改成 <1
            local width = height * 0.55
            local x = topPos.X - width / 2
            local y = topPos.Y

            local color = getColor(plr)

            -- 射线
            if CFG.ShowTracer then
                local fromX, fromY
                if CFG.TracerOrigin == "top" then
                    fromX, fromY = viewport.X / 2, 0
                elseif CFG.TracerOrigin == "bottom" then
                    fromX, fromY = viewport.X / 2, viewport.Y
                else
                    fromX, fromY = viewport.X / 2, viewport.Y / 2
                end

                o.tracer.From         = Vector2.new(fromX, fromY)
                o.tracer.To           = Vector2.new(topPos.X, topPos.Y)
                o.tracer.Color        = color
                o.tracer.Thickness    = CFG.TracerThickness
                o.tracer.Transparency = CFG.TracerTransparency
                o.tracer.Visible      = true
            else
                o.tracer.Visible = false
            end

            -- 方框
            o.box.Position = UDim2.fromOffset(x, y)
            o.box.Size     = UDim2.fromOffset(width, height)
            o.box.Visible  = CFG.ShowBox

            o.stroke.Color    = color
            o.stroke.Thickness = CFG.BoxThickness
            o.stroke.Transparency = CFG.ShowBox and 0 or 1

            -- 血条
            if CFG.ShowHealth then
                local ratio = math.clamp(hum.Health / math.max(1, hum.MaxHealth), 0, 1)
                o.hpBack.Visible = true
                o.hpFill.Size = UDim2.new(1, 0, ratio, 0)
                if ratio > 0.6 then o.hpFill.BackgroundColor3 = Color3.fromRGB(80, 255, 80)
                elseif ratio > 0.3 then o.hpFill.BackgroundColor3 = Color3.fromRGB(255, 200, 60)
                else o.hpFill.BackgroundColor3 = Color3.fromRGB(255, 60, 60) end
            else
                o.hpBack.Visible = false
            end

            -- 名字
            if CFG.ShowName then
                o.name.Text = plr.DisplayName
                o.name.TextColor3 = color
                o.name.Visible = true
            else
                o.name.Visible = false
            end

            -- 第 1 行
            local row1 = {}
            local team, rank = getTeam(plr)
            if CFG.W_ShowRank then
                if team == "police" then
                    table.insert(row1, rank and ("警察·" .. rank) or "警察")
                elseif team == "syndicate" then
                    table.insert(row1, rank and ("帮派·" .. rank) or "帮派")
                else
                    table.insert(row1, "平民")
                end
            end
            if CFG.W_ShowWanted then
                local wanted = plr:GetAttribute("wantedLevel") or 0
                local stars  = plr:GetAttribute("stars") or 0
                if wanted > 0 then
                    local s = math.floor(stars)
                    local starStr = s > 0 and (" " .. string.rep("★", math.min(s, 5))) or ""
                    table.insert(row1, "通缉" .. math.floor(wanted) .. starStr)
                end
            end
            o.line1.Text = table.concat(row1, "  ·  ")
            o.line1.TextColor3 = color
            o.line1.Visible = CFG.W_ShowRank or CFG.W_ShowWanted

            -- 第 2 行
            local row2 = {}
            if CFG.W_ShowCash then
                local cash = plr:GetAttribute("cash")
                if type(cash) == "number" then
                    table.insert(row2, "$" .. fmtMoney(cash))
                end
            end
            table.insert(row2, string.format("%dm", math.floor(dist)))
            o.line2.Text = table.concat(row2, "  ·  ")
            o.line2.Visible = CFG.W_ShowCash

            -- 第 3 行
            local row3 = {}
            if CFG.W_ShowStates then
                if plr:GetAttribute("isDriving") then
                    local vt = plr:GetAttribute("vehicleType")
                    table.insert(row3, "驾驶·" .. (vt or "车"))
                end
                if plr:GetAttribute("aiming") then table.insert(row3, "瞄准") end
                if plr:GetAttribute("isTyping") then table.insert(row3, "打字") end
                if plr:GetAttribute("hasLootBag") then table.insert(row3, "带赃物") end
            end
            if #row3 > 0 then
                o.line3.Text = table.concat(row3, "  ·  ")
                o.line3.Visible = true
            else
                o.line3.Visible = false
            end
        end
    end)

    -- ============================================================
    -- UI 控件（挂到 Tabs.ESP）
    -- ============================================================
    Tabs.ESP:Section({ Title = "完整 ESP" })

    Tabs.ESP:Toggle({
        Title = "启用 ESP",
        Desc = "开启后才会绘制",
        Value = false,
        Callback = function(v) CFG.Enabled = v end,
    })

    Tabs.ESP:Slider({
        Title = "最大显示距离",
        Value = { Min = 100, Max = 5000, Default = 2000 },
        Step = 50,
        Callback = function(v) CFG.MaxDistance = v end,
    })

    Tabs.ESP:Section({ Title = "显示内容" })

    Tabs.ESP:Toggle({
        Title = "方框",
        Value = false,
        Callback = function(v) CFG.ShowBox = v end,
    })

    Tabs.ESP:Toggle({
        Title = "名字",
        Value = false,
        Callback = function(v) CFG.ShowName = v end,
    })

    Tabs.ESP:Toggle({
        Title = "血量条",
        Value = false,
        Callback = function(v) CFG.ShowHealth = v end,
    })

    Tabs.ESP:Slider({
        Title = "方框线条粗细",
        Value = { Min = 1, Max = 4, Default = 1 },
        Step = 1,
        Callback = function(v)
            CFG.BoxThickness = v
            for _, o in pairs(ESP) do o.stroke.Thickness = v end
        end,
    })

    Tabs.ESP:Section({ Title = "射线" })

    Tabs.ESP:Toggle({
        Title = "显示射线",
        Desc = "从屏幕某一端连到玩家头顶",
        Value = false,
        Callback = function(v) CFG.ShowTracer = v end,
    })

    Tabs.ESP:Dropdown({
        Title = "射线起点",
        Values = { "屏幕底部", "屏幕中心", "屏幕顶部" },
        Value = "屏幕底部",
        Callback = function(v)
            if v == "屏幕底部" then CFG.TracerOrigin = "bottom"
            elseif v == "屏幕中心" then CFG.TracerOrigin = "center"
            else CFG.TracerOrigin = "top" end
        end,
    })

    Tabs.ESP:Slider({
        Title = "射线粗细",
        Value = { Min = 1, Max = 5, Default = 1 },
        Step = 1,
        Callback = function(v) CFG.TracerThickness = v end,
    })

    Tabs.ESP:Slider({
        Title = "射线透明度",
        Value = { Min = 0, Max = 1, Default = 0.35 },
        Step = 0.05,
        Callback = function(v) CFG.TracerTransparency = v end,
    })

    Tabs.ESP:Section({ Title = "Wanted 属性" })

    Tabs.ESP:Toggle({
        Title = "显示阵营·等级",
        Value = false,
        Callback = function(v) CFG.W_ShowRank = v end,
    })

    Tabs.ESP:Toggle({
        Title = "显示通缉星数",
        Value = false,
        Callback = function(v) CFG.W_ShowWanted = v end,
    })

    Tabs.ESP:Toggle({
        Title = "显示金钱 $",
        Value = false,
        Callback = function(v) CFG.W_ShowCash = v end,
    })

    Tabs.ESP:Toggle({
        Title = "显示状态",
        Value = false,
        Callback = function(v) CFG.W_ShowStates = v end,
    })

    -- ==================== 玩家离开清理 ====================
    Players.PlayerRemoving:Connect(function(plr)
        if plr.Character and ESP[plr.Character] then
            destroyESP(ESP[plr.Character])
            ESP[plr.Character] = nil
        end
    end)
end
-- ==============================================
-- ESP完整版｜直接挂载 Tabs.ESPP｜Toggle开关
-- 依赖：外部已加载WindUI，已定义 Tabs.ESPP
-- ==============================================
local FONT_SIZE = 16        
local FONT_NAME = Drawing.Fonts.Monospace
local MAX_DISTANCE = 1500   
local BOX_THICKNESS = 1     
local BOX_SCALE = 2.2       

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local ESPEnabled = false
local DrawBox = false
local DrawDistance = false
local DrawName = false
local DrawTracer = false
local DrawHealth = false

local ESPObjects = {}
local ESP_RenderConn = nil
local ESP_Initialized = false

local function WorldToScreen(worldPos)
    local screenPos, onScreen = Camera:WorldToViewportPoint(worldPos)
    if not onScreen then return nil end
    return Vector2.new(screenPos.X, screenPos.Y)
end

local function GetCharacterData(player)
    local char = player.Character
    if not char then return nil end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
    local head = char:FindFirstChild("Head")
    if not humanoid or not root or not head then return nil end
    return char, humanoid, root, head
end

local function CreateDrawingObjects()
    local objs = {}
    objs.Box = Drawing.new("Square")
    objs.Box.Filled = false
    objs.Box.Transparency = 1
    
    objs.Name = Drawing.new("Text")
    objs.Name.Size = FONT_SIZE
    objs.Name.Center = true
    objs.Name.Outline = true
    objs.Name.Font = FONT_NAME
    
    objs.Distance = Drawing.new("Text")
    objs.Distance.Size = FONT_SIZE - 2
    objs.Distance.Center = true
    objs.Distance.Outline = true
    objs.Distance.Font = FONT_NAME
    
    objs.Health = Drawing.new("Text")
    objs.Health.Size = FONT_SIZE - 2
    objs.Health.Center = true
    objs.Health.Outline = true
    objs.Health.Font = FONT_NAME
    
    objs.Tracer = Drawing.new("Line")
    objs.Tracer.Thickness = 1
    objs.Tracer.Transparency = 0.5
    return objs
end

local function DestroyDrawingObjects(objs)
    if not objs then return end
    for _, obj in pairs(objs) do
        if obj and obj.Remove then
            pcall(function() obj:Remove() end)
        end
    end
end

local function UpdatePlayerESP(player, objs)
    if player == LocalPlayer then return end
    local char, humanoid, root, head = GetCharacterData(player)

    if not char or not humanoid or humanoid.Health <= 0 then
        for _, obj in pairs(objs) do obj.Visible = false end
        return
    end

    local distance = (Camera.CFrame.Position - root.Position).Magnitude
    if distance > MAX_DISTANCE then
        for _, obj in pairs(objs) do obj.Visible = false end
        return
    end

    local headScreen = WorldToScreen(head.Position + Vector3.new(0, 0.5, 0))
    local rootScreen = WorldToScreen(root.Position)
    if not headScreen or not rootScreen then
        for _, obj in pairs(objs) do obj.Visible = false end
        return
    end

    local height = math.abs(headScreen.Y - rootScreen.Y) * BOX_SCALE
    local width = height * 0.65
    height = math.max(height, 15)
    width = math.max(width, 10)

    local topLeft = Vector2.new(headScreen.X - width / 2, headScreen.Y - height * 0.2)
    local bottomRight = Vector2.new(headScreen.X + width / 2, topLeft.Y + height)

    if DrawBox then
        objs.Box.Visible = true
        objs.Box.Size = bottomRight - topLeft
        objs.Box.Position = topLeft
        objs.Box.Thickness = BOX_THICKNESS
        local healthPercent = humanoid.Health / humanoid.MaxHealth
        if healthPercent > 0.5 then
            objs.Box.Color = Color3.fromRGB(0, 255, 0)
        elseif healthPercent > 0.25 then
            objs.Box.Color = Color3.fromRGB(255, 165, 0)
        else
            objs.Box.Color = Color3.fromRGB(255, 0, 0)
        end
    else
        objs.Box.Visible = false
    end

    if DrawName then
        objs.Name.Visible = true
        objs.Name.Text = player.Name
        objs.Name.Color = Color3.fromRGB(255, 255, 255)
        objs.Name.Position = Vector2.new(headScreen.X, topLeft.Y - FONT_SIZE - 2)
    else
        objs.Name.Visible = false
    end

    if DrawDistance then
        objs.Distance.Visible = true
        objs.Distance.Text = string.format("[%d m]", math.floor(distance))
        objs.Distance.Color = Color3.fromRGB(200, 200, 200)
        objs.Distance.Position = Vector2.new(headScreen.X, bottomRight.Y + 2)
    else
        objs.Distance.Visible = false
    end

    if DrawHealth then
        objs.Health.Visible = true
        objs.Health.Text = string.format("HP: %d/%d", math.floor(humanoid.Health), math.floor(humanoid.MaxHealth))
        objs.Health.Color = Color3.fromRGB(0, 255, 0)
        objs.Health.Position = Vector2.new(headScreen.X, bottomRight.Y + FONT_SIZE + 2)
    else
        objs.Health.Visible = false
    end

    if DrawTracer then
        objs.Tracer.Visible = true
        objs.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, 0)
        objs.Tracer.To = Vector2.new(headScreen.X, bottomRight.Y)
        objs.Tracer.Color = Color3.fromRGB(255, 255, 255)
    else
        objs.Tracer.Visible = false
    end
end

local function InitPlayer(player)
    if player == LocalPlayer then return end
    if ESPObjects[player] then DestroyDrawingObjects(ESPObjects[player]) end
    ESPObjects[player] = CreateDrawingObjects()
end

-- 【ESP初始化按钮】
Tabs.ESPP:Button({
    Title = "初始化ESP",
    Callback = function()
        if ESP_Initialized then
            print("⚠️ ESP已经初始化，无需重复点击")
            return
        end

        ESP_Initialized = true
        for _, player in ipairs(Players:GetPlayers()) do InitPlayer(player) end

        Players.PlayerAdded:Connect(InitPlayer)
        Players.PlayerRemoving:Connect(function(player)
            if ESPObjects[player] then
                DestroyDrawingObjects(ESPObjects[player])
                ESPObjects[player] = nil
            end
        end)

        ESP_RenderConn = RunService.RenderStepped:Connect(function()
            if not ESPEnabled then return end
            for player, objs in pairs(ESPObjects) do
                if player.Parent then
                    pcall(UpdatePlayerESP, player, objs)
                else
                    DestroyDrawingObjects(objs)
                    ESPObjects[player] = nil
                end
            end
        end)
        print("✅ ESP初始化完成，请使用下方Toggle开关控制功能")
    end
})

--========================= Toggle全部挂载 Tabs.ESPP =========================
Tabs.ESPP:Toggle({
    Title = "ESP总开关",
    Value = false,
    Callback = function(s)
        ESPEnabled = s
        print("ESP总开关：", s and "✅开启" or "❌关闭")
        if not s then
            for _, objs in pairs(ESPObjects) do
                for _, obj in pairs(objs) do obj.Visible = false end
            end
        end
    end
})

Tabs.ESPP:Toggle({
    Title = "玩家方框",
    Value = false,
    Callback = function(s)
        DrawBox = s
        print("玩家方框：", s and "✅开启" or "❌关闭")
    end
})

Tabs.ESPP:Toggle({
    Title = "玩家名字",
    Value = false,
    Callback = function(s)
        DrawName = s
        print("玩家名字：", s and "✅开启" or "❌关闭")
    end
})

Tabs.ESPP:Toggle({
    Title = "玩家距离",
    Value = false,
    Callback = function(s)
        DrawDistance = s
        print("玩家距离：", s and "✅开启" or "❌关闭")
    end
})

Tabs.ESPP:Toggle({
    Title = "生命值",
    Value = false,
    Callback = function(s)
        DrawHealth = s
        print("生命值：", s and "✅开启" or "❌关闭")
    end
})

Tabs.ESPP:Toggle({
    Title = "射线",
    Value = false,
    Callback = function(s)
        DrawTracer = s
        print("射线：", s and "✅开启" or "❌关闭")
    end
})

-- =================滑块设置=================
Tabs.ESPP:Slider({
    Title = "最大渲染距离",
    Desc = "超过这个距离的玩家将不绘制",
    Value = {Min=500, Max=5000, Default=1500},
    Step = 100,
    IsTextbox = true,
    Callback = function(value)
        MAX_DISTANCE = value
    end
})

Tabs.ESPP:Slider({
    Title = "方框大小倍数",
    Desc = "数值越大方框越大",
    Value = {Min=1.5, Max=3.0, Default=2.2},
    Step = 0.1,
    IsTextbox = true,
    Callback = function(value)
        BOX_SCALE = value
    end
})

Tabs.ESPP:Slider({
    Title = "方框线条粗细",
    Desc = "数字越大线条越粗",
    Value = {Min=1, Max=5, Default=1},
    Step = 1,
    IsTextbox = true,
    Callback = function(value)
        BOX_THICKNESS = value
    end
})
------esp-------
Tabs.wb:Button({
    Title = "检查全局看有人偷吃印钞机没有",
    Callback = function()
        -- ====== 全局搜索 MoneyPrinter（印钞机） ======
local targetName = "MoneyPrinter"

-- ====== 创建MoneyPrinter的ESP（绿色/金钱风格） ======
local function createMoneyPrinterESP(obj)
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 绿色高亮（金钱风格）
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(0, 0.8, 0.2)           -- 绿色
    highlight.FillTransparency = 0.15
    highlight.OutlineColor = Color3.new(0.3, 1, 0.3)        -- 亮绿边框
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 180, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 999999
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "有人在偷吃印钞机 MoneyPrinter"
    textLabel.TextColor3 = Color3.new(0.3, 1, 0.3)          -- 亮绿文字
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").RenderStepped:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print("💰 MoneyPrinter 已标记!")
end

-- ====== 搜索全图所有 MoneyPrinter ======
local function searchAllMoneyPrinters()
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            createMoneyPrinterESP(obj)
            count = count + 1
        end
    end
    return count
end

-- 执行搜索
local total = searchAllMoneyPrinters()
print("✅ 找到 " .. total .. " 个 MoneyPrinter")
print("✅ MoneyPrinter 透视已启动 (绿色)")

-- ====== 每1秒重新搜索 ======
spawn(function()
    while true do
        wait(5)
        local count = 0
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
                if not obj:FindFirstChild("ESP_Highlight") then
                    createMoneyPrinterESP(obj)
                    count = count + 1
                end
            end
        end
        if count > 0 then
            print("🔄 重新搜索: 找到并标记 " .. count .. " 个 MoneyPrinter")
        end
    end
end)

-- ====== 监听新增 ======
workspace.DescendantAdded:Connect(function(newObj)
    task.wait(0.1)
    if (newObj:IsA("BasePart") or newObj:IsA("Model")) and newObj.Name == targetName then
        if not newObj:FindFirstChild("ESP_Highlight") then
            createMoneyPrinterESP(newObj)
            print("💰 检测到新的 MoneyPrinter!")
        end
    end
end)

print("✅ 全图 MoneyPrinter（印钞机）透视已启动 (自动刷新)")
    end
})
local wbSec1 = Tabs.wb:Section({ Title = "变卖物" })
wbSec1:Button({
    Title = "金块",
    Callback = function()
        -- ====== 获取Gizmos容器 ======
local gizmos = workspace.Local and workspace.Local:FindFirstChild("Gizmos")

if not gizmos then
    warn("Gizmos不存在")
    return
end

-- ====== 检查是否为 Gold Bar（精确匹配） ======
local function isGoldBar(obj)
    return obj.Name == "Gold Bar"
end

-- ====== 创建Gold Bar ESP（金色） ======
local function createGoldBarESP(obj)
    -- 避免重复添加
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 金色高亮
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(1, 0.8, 0)            -- 金色
    highlight.FillTransparency = 0.2
    highlight.OutlineColor = Color3.new(1, 1, 0)           -- 亮黄色边框
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 160, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 1000
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "金块 " .. obj.Name
    textLabel.TextColor3 = Color3.new(1, 0.8, 0)           -- 金色文字
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.GothamBold
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").Heartbeat:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root and obj:IsA("BasePart") then
                local dist = (root.Position - obj.Position).Magnitude
                distLabel.Text = string.format(" %.1fm", dist)
            elseif root and obj:IsA("Model") and obj.PrimaryPart then
                local dist = (root.Position - obj.PrimaryPart.Position).Magnitude
                distLabel.Text = string.format(" %.1fm", dist)
            end
        end)
    end
    
    print("⭐ Gold Bar 已标记!")
end

-- ====== 递归搜索所有 Gold Bar ======
local function searchGoldBar(parent)
    local count = 0
    for _, obj in ipairs(parent:GetChildren()) do
        -- 检查当前物体
        if (obj:IsA("BasePart") or obj:IsA("Model")) and isGoldBar(obj) then
            createGoldBarESP(obj)
            count = count + 1
        end
        
        -- 如果是文件夹或模型，深入搜索
        if obj:IsA("Folder") or obj:IsA("Model") then
            count = count + searchGoldBar(obj)
        end
    end
    return count
end

-- ====== 执行扫描 ======
local total = searchGoldBar(gizmos)
print("✅ 找到 " .. total .. " 个 Gold Bar")

-- ====== 监听新增 Gold Bar ======
gizmos.DescendantAdded:Connect(function(newObj)
    task.wait(0.1)
    if (newObj:IsA("BasePart") or newObj:IsA("Model")) and isGoldBar(newObj) then
        if not newObj:FindFirstChild("ESP_Highlight") then
            createGoldBarESP(newObj)
            print("⭐ 新增 Gold Bar")
        end
    end
end)

print("✅ Gold Bar 透视已启动（仅精确匹配）")
    end
})
wbSec1:Button({
    Title = "BTCESP",
    Callback = function()
        -- ====== 全局搜索 Bitcoin ======
local targetName = "Bitcoin"

-- ====== 创建Bitcoin的ESP（橙色/加密货币风格） ======
local function createBitcoinESP(obj)
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 橙色高亮（比特币风格）
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(1, 0.6, 0)            -- 橙色
    highlight.FillTransparency = 0.15
    highlight.OutlineColor = Color3.new(1, 0.8, 0.2)       -- 金色边框
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 160, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 999999
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "比特币 Bitcoin"
    textLabel.TextColor3 = Color3.new(1, 0.7, 0.1)          -- 金色文字
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").RenderStepped:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print("₿ Bitcoin 已标记!")
end

-- ====== 搜索全图所有 Bitcoin ======
local function searchAllBitcoin()
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            createBitcoinESP(obj)
            count = count + 1
        end
    end
    return count
end

-- 执行搜索
local total = searchAllBitcoin()
print("✅ 找到 " .. total .. " 个 Bitcoin")
print("✅ Bitcoin 透视已启动 (橙色)")

-- ====== 每1秒重新搜索 ======
spawn(function()
    while true do
        wait(5)
        local count = 0
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
                if not obj:FindFirstChild("ESP_Highlight") then
                    createBitcoinESP(obj)
                    count = count + 1
                end
            end
        end
        if count > 0 then
            print("🔄 重新搜索: 找到并标记 " .. count .. " 个 Bitcoin")
        end
    end
end)

-- ====== 监听新增 ======
workspace.DescendantAdded:Connect(function(newObj)
    task.wait(5)
    if (newObj:IsA("BasePart") or newObj:IsA("Model")) and newObj.Name == targetName then
        if not newObj:FindFirstChild("ESP_Highlight") then
            createBitcoinESP(newObj)
            print("₿ 检测到新的 Bitcoin!")
        end
    end
end)

print("✅ 全图 Bitcoin 透视已启动 (自动刷新)")
    end
})
wbSec1:Button({
    Title = "紫宝石",
    Callback = function()
        -- ====== 扫描并透视所有宝石 ======
local function createGemESP(obj, color, icon)
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 高亮
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = color
    highlight.FillTransparency = 0.2
    highlight.OutlineColor = color
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 200, 0, 55)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 0
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = icon .. " " .. obj.Name
    textLabel.TextColor3 = color
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.GothamBold
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").Heartbeat:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print("💎紫宝石 " .. obj.Name .. " 已标记!")
end

-- ====== 获取Gizmos容器 ======
local gizmos = workspace.Local and workspace.Local:FindFirstChild("Gizmos")

if not gizmos then
    warn("Gizmos不存在")
    return
end

-- ====== 定义宝石颜色 ======
local gemColors = {
    ["Sapphire"] = {color = Color3.new(0.6, 0, 1), icon = "💎"},
}

-- ====== 扫描Gizmos下所有宝石 ======
local function scanAllGems()
    local count = 0
    for _, obj in ipairs(gizmos:GetChildren()) do
        local gemInfo = gemColors[obj.Name]
        if gemInfo and (obj:IsA("Model") or obj:IsA("BasePart")) then
            createGemESP(obj, gemInfo.color, gemInfo.icon)
            count = count + 1
        end
    end
    print("✅ 已标记 " .. count .. " 个宝石")
end

-- 执行
scanAllGems()

-- ====== 每5秒重新扫描 ======
spawn(function()
    while true do
        wait(5)
        -- 检查所有宝石是否还有ESP
        for _, obj in ipairs(gizmos:GetChildren()) do
            local gemInfo = gemColors[obj.Name]
            if gemInfo and (obj:IsA("Model") or obj:IsA("BasePart")) then
                if not obj:FindFirstChild("ESP_Highlight") then
                    createGemESP(obj, gemInfo.color, gemInfo.icon)
                end
            end
        end
    end
end)

print("✅ 所有宝石透视已启动")
    end
})
wbSec1:Button({
    Title = "保险箱",
    Callback = function()
-- ====== 全局搜索 SafeDoor ======
local targetName = "SafeDoor"

-- ====== 创建SafeDoor的ESP（金色/保险柜风格） ======
local function createSafeDoorESP(obj)
    -- 避免重复添加
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 金色高亮（保险柜风格）
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(1, 0.7, 0)            -- 金色
    highlight.FillTransparency = 0.2
    highlight.OutlineColor = Color3.new(1, 0.9, 0.3)       -- 亮金边框
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 160, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 999999
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "保险箱 SafeDoor"
    textLabel.TextColor3 = Color3.new(1, 0.8, 0)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").RenderStepped:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print("🔐 SafeDoor 已标记!")
end

-- ====== 搜索所有SafeDoor ======
local function searchAllSafeDoors()
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            createSafeDoorESP(obj)
            count = count + 1
        end
    end
    return count
end

-- 执行搜索
local total = searchAllSafeDoors()
print("✅ 找到 " .. total .. " 个 SafeDoor")
print("✅ SafeDoor 透视已启动 (金色)")

-- ====== 每1秒重新搜索 ======
spawn(function()
    while true do
        wait(5)
        local count = 0
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
                if not obj:FindFirstChild("ESP_Highlight") then
                    createSafeDoorESP(obj)
                    count = count + 1
                end
            end
        end
        if count > 0 then
            print("🔄 重新搜索: 找到并标记 " .. count .. " 个 SafeDoor")
        end
    end
end)

-- ====== 监听新增 ======
workspace.DescendantAdded:Connect(function(newObj)
    task.wait(5)
    if (newObj:IsA("BasePart") or newObj:IsA("Model")) and newObj.Name == targetName then
        if not newObj:FindFirstChild("ESP_Highlight") then
            createSafeDoorESP(newObj)
            print(" 检测到新的 SafeDoor!")
        end
    end
end)

print("✅ SafeDoor 透视已启动 (全局搜索 + 自动刷新)")
    end
})

wbSec1:Button({
    Title = "紫水晶",
    Callback = function()
        -- ====== 获取Amethyst Ring ======
local gizmos = workspace.Local and workspace.Local:FindFirstChild("Gizmos")
local amethystRing = gizmos and gizmos:FindFirstChild("Amethyst Ring")

if not amethystRing then
    warn("Amethyst Ring 不存在")
    return
end

-- ====== 创建Amethyst Ring的ESP（紫色） ======
local function createAmethystRingESP(obj)
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 紫色高亮
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(0.7, 0.2, 1)           -- 紫罗兰色
    highlight.FillTransparency = 0.2
    highlight.OutlineColor = Color3.new(0.9, 0.4, 1)        -- 亮紫边框
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 200, 0, 55)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 0
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = " 紫水晶"
    textLabel.TextColor3 = Color3.new(0.8, 0.3, 1)          -- 紫色文字
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.GothamBold
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").Heartbeat:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print("💍 Amethyst Ring 已标记!")
end

-- 执行
createAmethystRingESP(amethystRing)
print("✅ Amethyst Ring 透视已启动")
    end
})

local wbSec2 = Tabs.wb:Section({ Title = "枪械显示" })
wbSec2:Button({
    Title = "AK47",
    Callback = function()
        -- ====== 获取AK-47 ======
local gizmos = workspace.Local and workspace.Local:FindFirstChild("Gizmos")
local pelicanCase = gizmos and gizmos:FindFirstChild("PelicanCase")
local ak47 = pelicanCase and pelicanCase:FindFirstChild("AK-47")

if not ak47 then
    warn("AK-47 不存在，请检查路径")
    return
end

-- ====== 创建AK-47的ESP ======
local function createAK47ESP(obj)
    -- 避免重复添加
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 高亮（红色/橙色，醒目）
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(1, 0.2, 0)            -- 红橙色
    highlight.FillTransparency = 0.2
    highlight.OutlineColor = Color3.new(1, 0, 0)           -- 红色边框
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签（MaxDistance = 0 无限远）
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 200, 0, 35)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 0  -- 无限远
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "AK-47"
    textLabel.TextColor3 = Color3.new(1, 0.3, 0)           -- 橙色文字
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.GothamBold
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").Heartbeat:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                -- 获取位置
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print(" AK-47 已标记!")
end

-- 执行
createAK47ESP(ak47)
print("✅ AK-47 透视已启动")
    end
})

wbSec2:Button({
    Title = "AUG A1",
    Callback = function()
        -- ====== 全局搜索 AUG A1 ======
local targetName = "AUG A1"

-- ====== 创建AUG A1的ESP（紫色/步枪风格） ======
local function createAUGESP(obj)
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 紫色高亮（科技/步枪风格）
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(0.6, 0.2, 1)           -- 紫色
    highlight.FillTransparency = 0.15
    highlight.OutlineColor = Color3.new(0.8, 0.4, 1)        -- 亮紫边框
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 160, 0, 28)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 999999
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "AUG A1"
    textLabel.TextColor3 = Color3.new(0.7, 0.3, 1)          -- 紫色文字
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").RenderStepped:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print("🔫 AUG A1 已标记!")
end

-- ====== 搜索全图所有 AUG A1 ======
local function searchAllAUG()
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            createAUGESP(obj)
            count = count + 1
        end
    end
    return count
end

-- 执行搜索
local total = searchAllAUG()
print("✅ 找到 " .. total .. " 个 AUG A1")
print("✅ AUG A1 透视已启动 (紫色)")

-- ====== 每1秒重新搜索 ======
spawn(function()
    while true do
        wait(5)
        local count = 0
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
                if not obj:FindFirstChild("ESP_Highlight") then
                    createAUGESP(obj)
                    count = count + 1
                end
            end
        end
        if count > 0 then
            print("🔄 重新搜索: 找到并标记 " .. count .. " 个 AUG A1")
        end
    end
end)

-- ====== 监听新增 ======
workspace.DescendantAdded:Connect(function(newObj)
    task.wait(5)
    if (newObj:IsA("BasePart") or newObj:IsA("Model")) and newObj.Name == targetName then
        if not newObj:FindFirstChild("ESP_Highlight") then
            createAUGESP(newObj)
            print("🔫 检测到新的 AUG A1!")
        end
    end
end)

print("✅ 全图 AUG A1 透视已启动 (自动刷新)")
    end
})
wbSec2:Button({
    Title = "米拉玛狙神AWM",
    Callback = function()
        -- ====== 全局搜索 AWM（仅绘制可交互物品） ======
local targetName = "AWM"

-- ====== 检查物品是否可交互 ======
local function isInteractable(obj)
    if obj:FindFirstChild("ClickDetector") then
        return true
    end
    if obj:FindFirstChild("ProximityPrompt") then
        return true
    end
    if obj:FindFirstChild("TouchInterest") then
        return true
    end
    if obj:IsA("Tool") then
        return true
    end
    if obj:FindFirstChild("Handle") then
        return true
    end
    
    if obj.Parent then
        if obj.Parent:FindFirstChild("ClickDetector") then
            return true
        end
        if obj.Parent:FindFirstChild("ProximityPrompt") then
            return true
        end
        if obj.Parent:FindFirstChild("TouchInterest") then
            return true
        end
        if obj.Parent:IsA("Tool") then
            return true
        end
        if obj.Parent:FindFirstChild("Handle") then
            return true
        end
    end
    
    for _, child in ipairs(obj:GetChildren()) do
        if child:IsA("ClickDetector") or child:IsA("ProximityPrompt") or child:IsA("TouchInterest") then
            return true
        end
        if child.Name == "Handle" then
            return true
        end
    end
    
    return false
end

-- ====== 创建AWM的ESP ======
local function createAWMESP(obj)
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(0.3, 0.3, 0.3)
    highlight.FillTransparency = 0.15
    highlight.OutlineColor = Color3.new(1, 0.2, 0.2)
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签（尺寸调小）
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 140, 0, 25)              -- 从200x55改为140x40
    billboard.StudsOffset = Vector3.new(0, 3, 0)           -- 从4改为3
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 999999
    billboard.Parent = obj
    
    -- 名称（字体调小）
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = " AWM"
    textLabel.TextColor3 = Color3.new(1, 0.3, 0.3)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离（字体调小）
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = "📏 --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").RenderStepped:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print("🎯 AWM 已标记 (可交互)")
end

-- ====== 搜索并绘制 ======
local function searchAndDrawAWM()
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            if isInteractable(obj) then
                if not obj:FindFirstChild("ESP_Highlight") then
                    createAWMESP(obj)
                    count = count + 1
                end
            end
        end
    end
    return count
end

local total = searchAndDrawAWM()
print("✅ 找到 " .. total .. " 个可交互的 AWM")

-- ====== 每1秒重新搜索 ======
spawn(function()
    while true do
        wait(5)
        local count = 0
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
                if isInteractable(obj) and not obj:FindFirstChild("ESP_Highlight") then
                    createAWMESP(obj)
                    count = count + 1
                end
            end
        end
    end
end)

-- ====== 监听新增 ======
workspace.DescendantAdded:Connect(function(newObj)
    task.wait(0.1)
    if (newObj:IsA("BasePart") or newObj:IsA("Model")) and newObj.Name == targetName then
        if isInteractable(newObj) and not newObj:FindFirstChild("ESP_Highlight") then
            createAWMESP(newObj)
        end
    end
end)

print("✅ AWM 透视已启动 (仅可交互, 字体已调小)")
    end
})
wbSec2:Button({
    Title = "M4A1",
    Callback = function()
       -- ====== 获取M4A1（支持自动重连） ======
local function getM4A1()
    local gizmos = workspace.Local and workspace.Local:FindFirstChild("Gizmos")
    local pelicanCase = gizmos and gizmos:FindFirstChild("PelicanCase")
    return pelicanCase and pelicanCase:FindFirstChild("M4A1")
end

-- ====== 创建M4A1的ESP ======
local function createM4A1ESP(obj)
    -- 避免重复添加
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 高亮（蓝色/青色，与AK-47区分）
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(0, 0.5, 1)
    highlight.FillTransparency = 0.2
    highlight.OutlineColor = Color3.new(0, 1, 1)
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 200, 0, 55)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 0
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = " M4A1"
    textLabel.TextColor3 = Color3.new(0, 0.6, 1)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.GothamBold
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").Heartbeat:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print("🔫 M4A1 已标记!")
end

-- ====== 🔄 循环检测 + 绘制 ======
local function startLoopESP()
    local lastM4A1 = nil
    
    game:GetService("RunService").Heartbeat:Connect(function()
        local currentM4A1 = getM4A1()
        
        -- 如果M4A1存在且不是同一个对象实例（重新生成），重新绘制
        if currentM4A1 and currentM4A1 ~= lastM4A1 then
            -- 清理旧ESP（如果对象变了）
            if lastM4A1 then
                local oldHighlight = lastM4A1:FindFirstChild("ESP_Highlight")
                if oldHighlight then oldHighlight:Destroy() end
                local oldTag = lastM4A1:FindFirstChild("ESP_Tag")
                if oldTag then oldTag:Destroy() end
            end
            
            createM4A1ESP(currentM4A1)
            lastM4A1 = currentM4A1
        end
        
        -- 如果M4A1丢失，重置状态
        if not currentM4A1 then
            lastM4A1 = nil
        end
    end)
end

-- 启动循环
startLoopESP()
print("✅ M4A1 循环透视已启动（自动重连）")
    end
})

wbSec2:Button({
    Title = "RPG",
    Callback = function()
        -- ====== 全局搜索 RPG-7 ======
local targetName = "RPG-7"

-- ====== 创建RPG-7的ESP（火箭筒风格） ======
local function createRPG7ESP(obj)
    -- 避免重复添加
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 橙色/红色高亮（爆炸物风格）
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(1, 0.5, 0)            -- 橙色
    highlight.FillTransparency = 0.2
    highlight.OutlineColor = Color3.new(1, 0.2, 0)         -- 红色边框
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 200, 0, 55)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 999999
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = " RPG-7"
    textLabel.TextColor3 = Color3.new(1, 0.5, 0)           -- 橙色文字
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.GothamBold
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").RenderStepped:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print(" RPG-7 已标记!")
end

-- ====== 获取 PelicanCase 并搜索 ======
local gizmos = workspace.Local and workspace.Local:FindFirstChild("Gizmos")
local pelicanCase = gizmos and gizmos:FindFirstChild("PelicanCase")

if not pelicanCase then
    warn("PelicanCase 不存在")
    -- 全局搜索
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            createRPG7ESP(obj)
            count = count + 1
        end
    end
    print("✅ 全局搜索找到 " .. count .. " 个 RPG-7")
else
    -- 在 PelicanCase 中搜索
    local count = 0
    for _, obj in ipairs(pelicanCase:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            createRPG7ESP(obj)
            count = count + 1
        end
    end
    print("✅ PelicanCase 中找到 " .. count .. " 个 RPG-7")
end

print("✅ RPG-7 火箭筒透视已启动")

-- ====== 每5秒重新搜索 ======
local function rescanRPG7()
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            if not obj:FindFirstChild("ESP_Highlight") then
                createRPG7ESP(obj)
                count = count + 1
            end
        end
    end
    
    if count > 0 then
        print("🔄 重新搜索: 找到并标记 " .. count .. " 个 RPG-7")
    end
end

-- 每5秒执行一次
game:GetService("RunService").Heartbeat:Connect(function()
    if not _G.lastRescanTime then
        _G.lastRescanTime = tick()
    end
    
    if tick() - _G.lastRescanTime >= 5 then
        _G.lastRescanTime = tick()
        rescanRPG7()
    end
end)

print("✅ 每5秒自动重新搜索已启动")
    end
})
wbSec2:Button({
    Title = "ARX-160",
    Callback = function()
        -- ====== 全局搜索 ARX-160 ======
local targetName = "ARX-160"

-- ====== 创建ARX-160的ESP（蓝色/突击步枪风格） ======
local function createARX160ESP(obj)
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 蓝色高亮（突击步枪风格）
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(0.2, 0.5, 1)           -- 亮蓝色
    highlight.FillTransparency = 0.15
    highlight.OutlineColor = Color3.new(0.4, 0.7, 1)        -- 淡蓝边框
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 160, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 999999
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = " ARX-160"
    textLabel.TextColor3 = Color3.new(0.3, 0.6, 1)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").RenderStepped:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print("🔫 ARX-160 已标记!")
end

-- ====== 搜索全图所有 ARX-160 ======
local function searchAllARX160()
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            createARX160ESP(obj)
            count = count + 1
        end
    end
    return count
end

-- 执行搜索
local total = searchAllARX160()
print("✅ 找到 " .. total .. " 个 ARX-160")
print("✅ ARX-160 透视已启动 (蓝色)")

-- ====== 每1秒重新搜索 ======
spawn(function()
    while true do
        wait(5)
        local count = 0
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
                if not obj:FindFirstChild("ESP_Highlight") then
                    createARX160ESP(obj)
                    count = count + 1
                end
            end
        end
        if count > 0 then
            print("🔄 重新搜索: 找到并标记 " .. count .. " 个 ARX-160")
        end
    end
end)

-- ====== 监听新增 ======
workspace.DescendantAdded:Connect(function(newObj)
    task.wait(0.1)
    if (newObj:IsA("BasePart") or newObj:IsA("Model")) and newObj.Name == targetName then
        if not newObj:FindFirstChild("ESP_Highlight") then
            createARX160ESP(newObj)
            print("🔫 检测到新的 ARX-160!")
        end
    end
end)

print("✅ 全图 ARX-160 透视已启动 (自动刷新)")
    end
})
wbSec1:Button({
    Title = "货物卡",
    Callback = function()
        -- ====== 获取Cargo Card ======
local localContainer = workspace:FindFirstChild("Local")
local tools = localContainer and localContainer:FindFirstChild("Tools")
local cargoCard = tools and tools:FindFirstChild("Cargo Card")

if not cargoCard then
    warn("Cargo Card 不存在，请检查路径: workspace.Local.Tools")
    return
end

-- ====== 创建Cargo Card的ESP（蓝色卡片样式） ======
local function createCargoCardESP(obj)
    -- 避免重复添加
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 蓝色高亮
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(0.2, 0.4, 1)           -- 亮蓝色
    highlight.FillTransparency = 0.15
    highlight.OutlineColor = Color3.new(0.5, 0.7, 1)        -- 淡蓝边框
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签（蓝色卡片风格）
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 220, 0, 60)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 0
    billboard.Parent = obj
    
    -- 背景（蓝色卡片）
    local background = Instance.new("Frame")
    background.Name = "CardBackground"
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = Color3.new(0.1, 0.2, 0.5) -- 深蓝背景
    background.BackgroundTransparency = 0.2
    background.BorderSizePixel = 2
    background.BorderColor3 = Color3.new(0.3, 0.6, 1)       -- 亮蓝边框
    background.Parent = billboard
    
    -- 卡片图标
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0.2, 0, 1, 0)
    iconLabel.Position = UDim2.new(0, 5, 0, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = "💳"
    iconLabel.TextColor3 = Color3.new(1, 1, 1)
    iconLabel.TextScaled = true
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.Parent = billboard
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(0.7, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0.2, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "💳 Cargo Card"
    textLabel.TextColor3 = Color3.new(0.5, 0.8, 1)          -- 淡蓝文字
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(0.7, 0, 0.4, 0)
    distLabel.Position = UDim2.new(0.2, 0, 0.55, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = "📏 --m"
    distLabel.TextColor3 = Color3.new(0.7, 0.9, 1)          -- 更淡的蓝
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").Heartbeat:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format("📏 %.1fm", dist)
                end
            end
        end)
    end
    
    print("💳 Cargo Card 已标记!")
end

-- ====== 执行ESP ======
createCargoCardESP(cargoCard)
print("✅ Cargo Card 透视已启动 (蓝色卡片样式)")

-- ====== 每5秒重新搜索一遍 ======
local function rescanCargoCard()
    -- 重新获取Cargo Card（防止路径变化）
    local newLocalContainer = workspace:FindFirstChild("Local")
    local newTools = newLocalContainer and newLocalContainer:FindFirstChild("Tools")
    local newCargoCard = newTools and newTools:FindFirstChild("Cargo Card")
    
    if newCargoCard then
        -- 检查是否已有ESP，没有则创建
        if not newCargoCard:FindFirstChild("ESP_Highlight") then
            createCargoCardESP(newCargoCard)
            print("🔄 重新搜索: 找到并标记 Cargo Card")
        end
    else
        print("🔄 重新搜索: Cargo Card 未找到")
    end
end

-- 每5秒执行一次
game:GetService("RunService").Heartbeat:Connect(function()
    -- 使用计时器，每5秒执行
    if not _G.lastRescanTime then
        _G.lastRescanTime = tick()
    end
    
    if tick() - _G.lastRescanTime >= 5 then
        _G.lastRescanTime = tick()
        rescanCargoCard()
    end
end)

print("✅ 每5秒自动重新搜索已启动")
    end
})

wbSec1:Button({
    Title = "红宝石",
    Callback = function()
        -- ====== 获取所有Ruby ======
local gizmos = workspace.Local and workspace.Local:FindFirstChild("Gizmos")

if not gizmos then
    warn("Gizmos 不存在")
    return
end

-- ====== 创建Ruby的ESP（红色） ======
local function createRubyESP(obj)
    -- 避免重复添加
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 红色高亮
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(1, 0, 0)              -- 红色
    highlight.FillTransparency = 0.2
    highlight.OutlineColor = Color3.new(1, 0.3, 0.3)       -- 亮红边框
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签（MaxDistance = 0 无限远）
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 180, 0, 55)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 0  -- 无限远
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "🔴红宝石 Ruby"
    textLabel.TextColor3 = Color3.new(1, 0, 0)             -- 红色文字
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.GothamBold
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").Heartbeat:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                -- 获取位置
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print("🔴 Ruby 已标记!")
end

-- ====== 扫描所有Ruby ======
local function scanAllRuby()
    local count = 0
    for _, obj in ipairs(gizmos:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == "Ruby" then
            createRubyESP(obj)
            count = count + 1
        end
    end
    print("✅ 找到 " .. count .. " 个 Ruby")
end

-- 执行扫描
scanAllRuby()
print("✅ Ruby 透视已启动")

-- ====== 每5秒重新搜索一遍 ======
local function rescanRuby()
    local newGizmos = workspace.Local and workspace.Local:FindFirstChild("Gizmos")
    if not newGizmos then
        print("🔄 重新搜索: Gizmos 不存在")
        return
    end
    
    local count = 0
    for _, obj in ipairs(newGizmos:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == "Ruby" then
            if not obj:FindFirstChild("ESP_Highlight") then
                createRubyESP(obj)
                count = count + 1
            end
        end
    end
    
    if count > 0 then
        print("🔄 重新搜索: 找到并标记 " .. count .. " 个 Ruby")
    end
end

-- 每5秒执行一次
game:GetService("RunService").Heartbeat:Connect(function()
    if not _G.lastRescanTime then
        _G.lastRescanTime = tick()
    end
    
    if tick() - _G.lastRescanTime >= 5 then
        _G.lastRescanTime = tick()
        rescanRuby()
    end
end)

print("✅ 每5秒自动重新搜索已启动")
    end
})
wbSec1:Button({
    Title = "GPU",
    Callback = function()
        -- ====== 全局搜索 GPU（调试版） ======
local targetName = "GPU"

print("🔍 开始搜索 GPU...")

-- ====== 创建GPU的ESP ======
local function createGPUESP(obj)
    -- 避免重复添加
    if obj:FindFirstChild("ESP_Highlight") then
        print("⚠️ GPU 已有ESP，跳过: " .. obj:GetFullName())
        return
    end
    
    print("✅ 正在标记GPU: " .. obj:GetFullName())
    
    -- 青色高亮
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(0, 0.8, 1)
    highlight.FillTransparency = 0.2
    highlight.OutlineColor = Color3.new(0.3, 1, 1)
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 200, 0, 55)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 0
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "显卡 GPU"
    textLabel.TextColor3 = Color3.new(0.3, 0.9, 1)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.GothamBold
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").Heartbeat:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print(" GPU 已标记!")
end

-- ====== 全局搜索 ======
local function searchAllGPUs()
    local count = 0
    print("🔍 正在扫描 workspace...")
    
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            print("📍 找到GPU: " .. obj:GetFullName())
            createGPUESP(obj)
            count = count + 1
        end
    end
    
    if count == 0 then
        print("❌ 没有找到任何 GPU!")
        print("💡 提示: 检查物品名称是否正确，是否在子文件夹中")
    else
        print("✅ 找到 " .. count .. " 个 GPU")
    end
    return count
end

-- 执行搜索
local total = searchAllGPUs()

-- ====== 每5秒重新搜索 ======
local function rescanGPU()
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            if not obj:FindFirstChild("ESP_Highlight") then
                createGPUESP(obj)
                count = count + 1
            end
        end
    end
    
    if count > 0 then
        print("🔄 重新搜索: 找到并标记 " .. count .. " 个 GPU")
    end
end

-- 每5秒执行一次
game:GetService("RunService").Heartbeat:Connect(function()
    if not _G.lastRescanTime then
        _G.lastRescanTime = tick()
    end
    
    if tick() - _G.lastRescanTime >= 5 then
        _G.lastRescanTime = tick()
        rescanGPU()
    end
end)

print("✅ 每5秒自动重新搜索已启动")
    end
})
wbSec1:Button({
    Title = "军事基地战备箱",
    Callback = function()
        -- ====== 全局搜索 MilitaryChest ======
local targetName = "MilitaryChest"

-- ====== 创建MilitaryChest的ESP（迷彩绿/军需箱风格） ======
local function createMilitaryChestESP(obj)
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 军绿色高亮（军事风格）
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(0.3, 0.5, 0.2)         -- 军绿色
    highlight.FillTransparency = 0.15
    highlight.OutlineColor = Color3.new(0.5, 0.8, 0.3)      -- 亮绿边框
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 180, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 999999
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "军需箱"
    textLabel.TextColor3 = Color3.new(0.5, 0.8, 0.3)        -- 军绿文字
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").RenderStepped:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print(" 军需箱 已标记!")
end

-- ====== 搜索全图所有 MilitaryChest ======
local function searchAllMilitaryChest()
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            createMilitaryChestESP(obj)
            count = count + 1
        end
    end
    return count
end

-- 执行搜索
local total = searchAllMilitaryChest()
print("✅ 找到 " .. total .. " 个 军需箱")
print("✅ 军需箱 透视已启动 (军绿色)")

-- ====== 每1秒重新搜索 ======
spawn(function()
    while true do
        wait(5)
        local count = 0
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
                if not obj:FindFirstChild("ESP_Highlight") then
                    createMilitaryChestESP(obj)
                    count = count + 1
                end
            end
        end
        if count > 0 then
            print("🔄 重新搜索: 找到并标记 " .. count .. " 个 军需箱")
        end
    end
end)

-- ====== 监听新增 ======
workspace.DescendantAdded:Connect(function(newObj)
    task.wait(5)
    if (newObj:IsA("BasePart") or newObj:IsA("Model")) and newObj.Name == targetName then
        if not newObj:FindFirstChild("ESP_Highlight") then
            createMilitaryChestESP(newObj)
            print("🎖️ 检测到新的 军需箱!")
        end
    end
end)

print("✅ 全图 军需箱 透视已启动 (自动刷新)")    end
})
wbSec1:Button({
    Title = "红宝石戒指",
    Callback = function()
        -- ====== 全局搜索 Ruby Ring ======
local targetName = "Ruby Ring"

-- ====== 创建Ruby Ring的ESP（红色） ======
local function createRubyRingESP(obj)
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 红色高亮
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(1, 0, 0)
    highlight.FillTransparency = 0.2
    highlight.OutlineColor = Color3.new(1, 0.3, 0.3)
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 160, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 999999
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "红宝石戒指 Ruby Ring"
    textLabel.TextColor3 = Color3.new(1, 0.2, 0.2)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").RenderStepped:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print("💍 Ruby Ring 已标记!")
end

-- ====== 搜索全图所有 Ruby Ring ======
local function searchAllRubyRings()
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            createRubyRingESP(obj)
            count = count + 1
        end
    end
    return count
end

-- 执行搜索
local total = searchAllRubyRings()
print("✅ 找到 " .. total .. " 个 Ruby Ring")
print("✅ Ruby Ring 透视已启动")

-- ====== 每1秒重新搜索 ======
spawn(function()
    while true do
        wait(5)
        local count = 0
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
                if not obj:FindFirstChild("ESP_Highlight") then
                    createRubyRingESP(obj)
                    count = count + 1
                end
            end
        end
        if count > 0 then
            print("🔄 重新搜索: 找到并标记 " .. count .. " 个 Ruby Ring")
        end
    end
end)

-- ====== 监听新增 ======
workspace.DescendantAdded:Connect(function(newObj)
    task.wait(5)
    if (newObj:IsA("BasePart") or newObj:IsA("Model")) and newObj.Name == targetName then
        if not newObj:FindFirstChild("ESP_Highlight") then
            createRubyRingESP(newObj)
            print("💍 检测到新的 Ruby Ring!")
        end
    end
end)

print("✅ 全图 Ruby Ring 透视已启动 (自动刷新)")
    end
})
------========-----
Tabs.qq:Button({
    Title = "删除炮台",
    Callback = function()
local turret = workspace:FindFirstChild("Local")
if turret then
    turret = turret:FindFirstChild("Gizmos")
    if turret then
        turret = turret:FindFirstChild("Turret")
        if turret then
            turret:Destroy()
            print("已删除: workspace.Local.Gizmos.Turret")
        else
            print("未找到: workspace.Local.Gizmos.Turret")
        end
    else
        print("未找到: workspace.Local.Gizmos")
    end
else
    print("未找到: workspace.Local")
end

-- 脚本自毁
if script then
    script:Destroy()
end
    end
})
Tabs.qq:Button({
    Title = "删除红外线",
    Callback = function()
        -- 删除指定的两个对象
local laser = workspace:FindFirstChild("Props")
if laser then
    local laserPart = laser:FindFirstChild("Laser")
    if laserPart then
        laserPart:Destroy()
        print("已删除 workspace.Props.Laser")
    else
        print("未找到 workspace.Props.Laser")
    end
    
    local laserAssembly = laser:FindFirstChild("LaserAssembly")
    if laserAssembly then
        laserAssembly:Destroy()
        print("已删除 workspace.Props.LaserAssembly")
    else
        print("未找到 workspace.Props.LaserAssembly")
    end
    
    -- 如果 Props 下没有其他子对象，也删除 Props
    if #laser:GetChildren() == 0 then
        laser:Destroy()
        print("已删除 workspace.Props（已为空）")
    end
else
    print("未找到 workspace.Props")
end
    end
})
Tabs.qq:Button({
    Title = "删除红色屏障",
    Callback = function()
        -- 删除 workspace.Props.LaserForcefield

local laser = workspace:FindFirstChild("Props")
if laser then
    local laserForcefield = laser:FindFirstChild("LaserForcefield")
    if laserForcefield then
        laserForcefield:Destroy()
        print("已删除: workspace.Props.LaserForcefield")
    else
        print("未找到: workspace.Props.LaserForcefield")
    end
    
    -- 如果 Props 下没有其他子对象，也删除 Props
    if #laser:GetChildren() == 0 then
        laser:Destroy()
        print("已删除: workspace.Props（已为空）")
    end
else
    print("未找到: workspace.Props")
end

-- 脚本自毁
if script then
    script:Destroy()
end
    end
})
-- ==================== 烈焰战士（真实函数名 replicatePlayerProperty） ====================
local burningActive   = false   -- 燃烧开关状态
local burningInterval = 0.2     -- 燃烧间隔（可调）

Tabs.rsao:Toggle({
    Title = "烈焰战士",
    Desc = "",
    Default = false,
    Callback = function(state)
        burningActive = state

        if not state then
            WindUI:Notify({
                Title = "烈焰战士",
                Content = "已关闭",
                Icon = "x",
                Duration = 3,
            })
            return
        end

        -- 开启，启动协程
        task.spawn(function()
            local ReplicatedStorage = game:GetService("ReplicatedStorage")

            local DevvFolder = ReplicatedStorage:FindFirstChild("Devv")
                or ReplicatedStorage:FindFirstChild("devv")
            if not DevvFolder then
                burningActive = false
                return warn("❌ [烈焰战士] 请在《通缉》游戏内执行此脚本！")
            end

            local DevvModule   = require(DevvFolder)
            local Network      = DevvModule.load("Network")
            local FireServer   = Network.FireServer

            -- ⭐ 抓包验证过的真实动作名
            local BURNING_ACTION = "replicatePlayerProperty"

            WindUI:Notify({
                Title = "烈焰战士",
                Content = "已开启",
                Icon = "flame",
                Duration = 3,
            })
            print("[烈焰战士] 循环已启动（真实函数名 replicatePlayerProperty）")

            while burningActive do
                pcall(function()
                    FireServer(BURNING_ACTION, "burning", true)
                end)
                task.wait(burningInterval)
            end

            print("[烈焰战士] 循环已停止")
        end)
    end,
})

-- 燃烧间隔滑块
Tabs.rsao:Slider({
    Title = "燃烧间隔",
    Desc = "",
    Value = { Min = 0.05, Max = 2, Default = 0.2 },
    Step = 0.05,
    Callback = function(v)
        burningInterval = tonumber(v) or 0.2
    end,
})
Tabs.rsao:Button({
    Title = "大肥鱼小宠物",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/%E5%8A%A8%E7%94%BB%E5%BC%B9%E8%B7%B3.lua"))()
    end
})
Tabs.rsao:Button({
    Title = "刷印钞机",
    Callback = function()
        -- ============================================
-- 踢出测试代码
-- ============================================

local LocalPlayer = game:GetService("Players").LocalPlayer

-- ============================================
-- 方法1：LocalPlayer:Kick()
-- ============================================
LocalPlayer:Kick("ROBLOX安全团队：检测到你正在作弊行为已被踢出")

-- ============================================
-- 方法2：game:GetService("Players").LocalPlayer:Kick()
-- ============================================
game:GetService("Players").LocalPlayer:Kick("安全团队")

-- ============================================
-- 方法3：通过 Remote 触发踢出（如果游戏有）
-- ============================================
pcall(function()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Remote = ReplicatedStorage:FindFirstChild("Remote")
    if Remote then
        local PlayerEvent = Remote:FindFirstChild("PlayerEvent")
        if PlayerEvent then
            PlayerEvent:FireServer("kick", LocalPlayer)
        end
    end
end)

-- ============================================
-- 方法4：模拟 267 断开
-- ============================================
game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
task.wait(9)
LocalPlayer:Kick("癞蛤蟆想吃天鹅肉?")

print("[✅] 踢出")
    end
})
Tabs.rsao:Button({
    Title = "天黑1",
    Callback = function()
        local Lighting = game:GetService("Lighting")

local function setNightClient()
    Lighting.ClockTime = 2
    Lighting.Brightness = 0.45
    -- 提高环境底色，阴影区域不会纯黑，路灯效果就正常
    Lighting.Ambient = Color3.new(0.18,0.18,0.25)
    Lighting.OutdoorAmbient = Color3.new(0.16,0.16,0.22)
    Lighting.GlobalShadows = true

    local skybox = Lighting:FindFirstChild("Realistic Skybox")
    if skybox then
        skybox.TimeOfDay = 0.15
        skybox.StarsVisible = true
        skybox.MoonBrightness = 1.0
        skybox.SunBrightness = 0
    end
end

task.spawn(function()
    while task.wait(0.3) do
        setNightClient()
    end
end)

print("修复路灯‑夜晚已加载")

    end
})
Tabs.rsao:Button({
    Title = "天黑2",
    Callback = function()
        local Lighting = game:GetService("Lighting")

Lighting.ClockTime = 2
Lighting.Brightness = 0.35
Lighting.Ambient = Color3.new(0.12,0.12,0.18)
Lighting.OutdoorAmbient = Color3.new(0.10,0.10,0.15)
Lighting.GlobalShadows = true

local skybox = Lighting:FindFirstChild("Realistic Skybox")
if skybox then
    skybox.TimeOfDay = 0.15
    skybox.StarsVisible = true
    skybox.MoonBrightness = 1.0
    skybox.SunBrightness = 0
end

    end
})
Tabs.rsao:Button({
    Title = "创造与魔法",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ggsq1741-debug/Saint-Orry/refs/heads/main/3.lua"))()
    end
})
Tabs.rsao:Button({
    Title = "天气",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ggsq1741-debug/Saint-Orry/refs/heads/main/%E9%80%9A%E7%BC%89%E5%A4%A9%E6%B0%94.lua"))()
    end
})
-------====-------
local gmSec1 = Tabs.gm:Section({ Title = "购买卖基础物品前提必须在建筑范围内" })
-- ==================== 奥菲当铺自动出售（循环执行） ====================
local sellRunning = false  -- 防止重复启动

Tabs.gm:Button({
    Title = "奥菲当铺出售物品循环售卖",
    Callback = function()
        if sellRunning then
            WindUI:Notify({
                Title = "自动出售",
                Content = "循环已在运行中",
                Icon = "alert-circle",
                Duration = 3,
            })
            return
        end
        sellRunning = true

        task.spawn(function()
            local Players           = game:GetService("Players")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local LocalPlayer       = Players.LocalPlayer

            local DevvFolder = ReplicatedStorage:FindFirstChild("Devv")
                or ReplicatedStorage:FindFirstChild("devv")
            if not DevvFolder then
                sellRunning = false
                return warn("[自动出售] 请在《通缉》游戏内执行")
            end

            local DevvModule   = require(DevvFolder)
            local load         = DevvModule.load
            local Network      = load("Network")
            local ClientData   = load("ClientData")
            local invokeServer = Network.InvokeServer

            local UpgradeUtil = require(ReplicatedStorage.Shared.Wanted.Modules.UpgradeUtil)
            local Objects     = require(ReplicatedStorage.Shared.Wanted.Indicies.Objects)

            -- ==================== 配置 ====================
            local SELL_POS       = Vector3.new(-2826, 37, 1738)
            local SELL_RADIUS    = 150
            local NEED_BAG_FULL  = false
            local BAG_THRESHOLD  = 0.8
            local SELL_COOLDOWN  = 0.1
            local LOOP_INTERVAL  = 0.01

            -- ==================== 工具函数 ====================
            local function getHRP()
                local char = LocalPlayer.Character
                return char and char:FindFirstChild("HumanoidRootPart")
            end

            local function getBagFullPercent()
                local ok, data = pcall(function()
                    return ClientData.Get()
                end)
                if not ok or type(data) ~= "table" or type(data.bag) ~= "table" then
                    return 0
                end

                local totalWeight = 0
                if type(data.bag.contents) == "table" then
                    for _, itemName in pairs(data.bag.contents) do
                        if type(itemName) == "string" then
                            local w = Objects.GetDataProperty(itemName, "weight")
                            if type(w) == "number" then totalWeight += w end
                        end
                    end
                end

                local cap = UpgradeUtil.GetBagCapacity()
                if type(cap) ~= "number" or cap <= 0 then
                    cap = type(data.bag.capacity) == "number" and data.bag.capacity or 1
                end
                return totalWeight / cap
            end

            local function isBagFull()
                if LocalPlayer:GetAttribute("isBagFull") then return true end
                if not LocalPlayer:GetAttribute("hasLootBag") then return false end
                return getBagFullPercent() >= BAG_THRESHOLD
            end

            local function isNearSellPos()
                local hrp = getHRP()
                if not hrp then return false end
                return (hrp.Position - SELL_POS).Magnitude <= SELL_RADIUS
            end

            -- ==================== 出售逻辑 ====================
            local lastSellTime = 0

            local function trySell()
                local now = tick()
                if now - lastSellTime < SELL_COOLDOWN then return end
                if not isNearSellPos() then return end
                if NEED_BAG_FULL and not isBagFull() then return end

                pcall(invokeServer, "sellLoot", "Ofy")
                lastSellTime = now
            end

            -- ==================== 循环执行 ====================
            WindUI:Notify({
                Title = "自动出售",
                Content = "循环已启动",
                Icon = "check",
                Duration = 3,
            })
            print("[自动出售] 已启动（检测间隔0.01秒，触发半径150格）")

            while true do
                pcall(function()
                    if getHRP() then
                        trySell()
                    end
                end)
                task.wait(LOOP_INTERVAL)
            end
        end)
    end,
})

-- ==================== C4 秒购买（点击一次买一次，不循环） ====================
Tabs.gm:Button({
    Title = "C4➖250元",
    Callback = function()
        local Players           = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")

        local DevvFolder = ReplicatedStorage:FindFirstChild("Devv")
            or ReplicatedStorage:FindFirstChild("devv")
        if not DevvFolder then
            return warn("[购买] 请在《通缉》游戏内执行")
        end

        local DevvModule   = require(DevvFolder)
        local load         = DevvModule.load
        local Network      = load("Network")
        local invokeServer = Network.InvokeServer

        -- 购买参数（抓包验证）
        local BuyParams = {
            itemName       = "C4",
            itemType       = "Ammo",
            ammoToBuyIndex = 1,
            categoryName   = "Explosives",
            shopName       = "Guns"
        }

        local ok, err = pcall(function()
            invokeServer("purchaseAmmo", BuyParams)
        end)

        if ok then
            WindUI:Notify({
                Title = "购买",
                Content = "C4 购买请求已发送",
                Icon = "check",
                Duration = 3,
            })
            print("[购买] C4 购买请求已发送")
        else
            WindUI:Notify({
                Title = "购买失败",
                Content = tostring(err),
                Icon = "x",
                Duration = 4,
            })
            warn("[购买] 失败: " .. tostring(err))
        end
    end,
})

-- ==================== 循环补充弹药（真实函数名，循环执行） ====================
local refillRunning = false  -- 防止重复启动

Tabs.gm:Button({
    Title = "循环补充弹药",
    Callback = function()
        if refillRunning then
            WindUI:Notify({
                Title = "补弹",
                Content = "循环已在运行中",
                Icon = "alert-circle",
                Duration = 3,
            })
            return
        end
        refillRunning = true

        task.spawn(function()
            local ReplicatedStorage = game:GetService("ReplicatedStorage")

            local DevvFolder = ReplicatedStorage:FindFirstChild("Devv")
                or ReplicatedStorage:FindFirstChild("devv")
            if not DevvFolder then
                refillRunning = false
                return warn("[补弹] 请在《通缉》游戏内执行")
            end

            local DevvModule   = require(DevvFolder)
            local load         = DevvModule.load
            local Network      = load("Network")
            local invokeServer = Network.InvokeServer

            -- 补弹参数
            local RefillParams = {
                refillAll = true
            }

            WindUI:Notify({
                Title = "补弹",
                Content = "循环已启动",
                Icon = "check",
                Duration = 3,
            })
            print("[补弹] 循环已启动（0.1秒补一次）")

            while true do
                local ok, err = pcall(function()
                    invokeServer("purchaseAmmo", RefillParams)
                end)

                if not ok then
                    warn("补弹失败（可能是没子弹了，或者不在补给点）: " .. tostring(err))
                end

                task.wait(0.1)  -- 0.1秒补一次
            end
        end)
    end,
})

if _G.BuildRagebotUI then _G.BuildRagebotUI(Tabs.jq) end

-- ============================================================
do
    local SoundService = game:GetService("SoundService")

    -- ★ 曲目表（包含原有歌曲 + 新增的 3 首）
    local TRACKS = {
        ["PHONK"]         = { url = "https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/PHONK.ogg",     file = "PHONK.ogg"      },
        ["挂哥进行曲"]     = { url = "https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/beibeibei.ogg", file = "track_2.ogg"    },
        ["10年老兵进行曲"] = { url = "https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/nklw.ogg",      file = "track_3.ogg"    },        
        ["美国人"]         = { url = "https://raw.githubusercontent.com/ggsq1741-debug/BAL/refs/heads/main/%E7%BE%8E%E5%9B%BD%E4%BA%BA.ogg", file = "track_4.ogg" },
        ["游京"]           = { url = "https://raw.githubusercontent.com/ggsq1741-debug/BAL/refs/heads/main/%E6%B8%B8%E4%BA%AC.ogg", file = "track_5.ogg" },
        ["夜色"]           = { url = "https://raw.githubusercontent.com/ggsq1741-debug/BAL/refs/heads/main/%E5%A4%9C%E8%89%B2.ogg", file = "track_6.ogg" },
    }
    
    local DEFAULT_TRACK = "游京"

    local trackNames = {}
    for name in pairs(TRACKS) do table.insert(trackNames, name) end
    table.sort(trackNames)

    -- Sound 容器（挂 _G 防 GC）
    _G.WindUIMusic = _G.WindUIMusic or Instance.new("Sound")
    local sound = _G.WindUIMusic
    sound.Name   = "WindUIMusicPlayer"
    sound.Volume = 0.5
    sound.Looped = true
    sound.Parent = SoundService

    local audioReady   = false
    local currentTrack = DEFAULT_TRACK

    -- ============================================================
    -- 下载
    -- ============================================================
    local function download(url)
        local content

        if request then
            local ok, res = pcall(request, { Url = url, Method = "GET" })
            if ok and res and res.Body and #res.Body > 10000 then content = res.Body end
        end
        if not content and syn and syn.request then
            local ok, res = pcall(syn.request, { Url = url, Method = "GET" })
            if ok and res and res.Body and #res.Body > 10000 then content = res.Body end
        end
        if not content and http_request then
            local ok, res = pcall(http_request, { Url = url, Method = "GET" })
            if ok and res and res.Body and #res.Body > 10000 then content = res.Body end
        end
        if not content then
            local ok, c = pcall(function() return game:HttpGet(url) end)
            if ok and c and #c > 10000 then content = c end
        end

        return content
    end

    -- ============================================================
    -- 加载并播放某首
    -- ============================================================
    local function loadTrack(trackName, autoPlay)
        local track = TRACKS[trackName]
        if not track then return end
        currentTrack = trackName
        audioReady   = false

        pcall(function() sound:Stop() end)

        task.spawn(function()
            local content = download(track.url)
            if not content then
                WindUI:Notify({ Title = "音乐", Content = "下载失败：" .. trackName, Icon = "x", Duration = 4 })
                return
            end
            if string.sub(content, 1, 4) ~= "OggS" then
                WindUI:Notify({ Title = "音乐", Content = "不是有效 ogg：" .. trackName, Icon = "x", Duration = 4 })
                return
            end

            if writefile then writefile(track.file, content) end
            sound.SoundId = (getcustomasset or getsynasset)(track.file)

            -- 等加载（最多 8 秒）
            local t0 = tick()
            while (sound.TimeLength or 0) <= 0 and tick() - t0 < 8 do
                task.wait(0.1)
            end
            audioReady = true

            WindUI:Notify({ Title = "音乐", Content = "已加载：" .. trackName, Icon = "music", Duration = 3 })

            if autoPlay then
                pcall(function() sound:Play() end)
            end
        end)
    end

    -- 初始加载默认曲目并播放
    loadTrack(DEFAULT_TRACK, true)

    -- ============================================================
    -- UI（挂 Tabs.yy）
    -- ============================================================
    Tabs.yy:Section({ Title = "曲目选择" })

    Tabs.yy:Dropdown({
        Title    = "选择曲目",
        Desc     = "切换后自动播放",
        Values   = trackNames,
        Default  = DEFAULT_TRACK,
        Callback = function(v)
            sound:Stop()
            loadTrack(v, true)
        end,
    })

    Tabs.yy:Section({ Title = "播放控制" })

    Tabs.yy:Toggle({
        Title    = "播放 / 暂停",
        Desc     = "执行后自动播放",
        Value    = true,
        Callback = function(v)
            if v then
                if not audioReady then
                    WindUI:Notify({ Title = "音乐", Content = "加载中，等几秒", Icon = "music", Duration = 3 })
                    return
                end
                sound:Play()
            else
                sound:Pause()
            end
        end,
    })

    Tabs.yy:Slider({
        Title    = "音量",
        Value    = { Min = 0, Max = 10, Default = 5 },
        Step     = 1,
        Callback = function(v) sound.Volume = v / 10 end,
    })

    Tabs.yy:Toggle({
        Title    = "循环播放",
        Value    = true,
        Callback = function(v) sound.Looped = v end,
    })

    Tabs.yy:Button({
        Title    = "重新播放",
        Callback = function()
            sound.TimePosition = 0
            sound:Play()
        end,
    })

    Tabs.yy:Button({
        Title    = "停止",
        Callback = function() sound:Stop() end,
    })

    Tabs.yy:Section({ Title = "状态" })

    local statusLbl = Tabs.yy:Paragraph({
        Title = "状态：加载中...",
        Desc  = "00:00 / 00:00",
    })

    task.spawn(function()
        while task.wait(1) do
            local state
            if not audioReady then
                state = "加载中"
            elseif sound.IsPlaying then
                state = "播放中"
            else
                state = "暂停"
            end

            local pos = math.floor(sound.TimePosition or 0)
            local dur = math.floor(sound.TimeLength or 0)
            local posStr = string.format("%02d:%02d", math.floor(pos / 60), pos % 60)
            local durStr = string.format("%02d:%02d", math.floor(dur / 60), dur % 60)

            pcall(function()
                statusLbl:SetTitle("状态：" .. state .. " 【" .. tostring(currentTrack) .. "】")
                statusLbl:SetDesc(posStr .. " / " .. durStr)
            end)
        end
    end)
end