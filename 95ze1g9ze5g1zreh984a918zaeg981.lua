local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

--- MAIN SCRIPT
local main_gui = Material.Load({
	Title = "Berry Fucker",
	Style = 3,
	SizeX = 500,
	SizeY = 350,
	Theme = "Dark",
	ColorOverrides = {
		MainFrame = Color3.fromRGB(1,1,1), -- background pages principales
        NavBar = Color3.fromRGB(255,255,255), -- police menu navigation
        NavBarAccent = Color3.fromRGB(0,0,0), -- couleur background menu navigation
        TitleBar = Color3.fromRGB(1,1,1) -- couleur barre du titre
	}
})

--- VARIABLES
_G.security = 0
_G.tool = "80sPhone"
_G.spamtoggle = false

--- FONCTIONS
function startswith(text, prefix)
    return text:find(prefix, 1, true) == 1
end

function droptool(tool)
    --add tool to inv
    game:GetService("ReplicatedStorage").Packages._Index["sleitnick_knit@1.4.4"].knit.Services.ToolService.RF.ToggleEquipTool:InvokeServer(tool)
    wait()
    --equip all tools
    for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") then
            v.Parent = game.Players.LocalPlayer.Character
        end
    end
    --drop all tools
    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") then
            v.Parent = game.Workspace
        end
    end
    wait()
    --delete tool from Backpack
    game:GetService("ReplicatedStorage").Packages._Index["sleitnick_knit@1.4.4"].knit.Services.ToolService.RF.ToggleEquipTool:InvokeServer(tool)
    wait(0.1)
    game:GetService("ReplicatedStorage").Packages._Index["sleitnick_knit@1.4.4"].knit.Services.ToolService.RF.ToggleEquipTool:InvokeServer(tool)
end

--- PAGES MENU
local car_tab = main_gui.New({
	Title = "Car mods"
}) 

local users_tab = main_gui.New({
	Title = "Users interactions"
})

local spamdrop_tab = main_gui.New({
	Title = "Spam tools"
})

local misc_tab = main_gui.New({
	Title = "Miscellaneous"
})

local credits_tab = main_gui.New({
	Title = "Credits"
})

--- SCRIPT Users interactions
local noclip_script = users_tab.Toggle({
	Text = "Noclip",
	Callback = function(Value)
        _G.toggle = Value
        while _G.toggle do
            if _G.toggle then
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    pcall(function()
                        if v:IsA("BasePart") then
                            v.CanCollide = false
                        end
                    end)
                end
            end
            game:GetService("RunService").Stepped:wait() 
        end
	end,
	Enabled = false
})

local rejoin_script = users_tab.Button({
	Text = "Rejoin server",
	Callback = function()
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId) 
	end
})

local walkspeed_script = users_tab.Slider({
	Text = "Slide to set speed",
	Callback = function(Value)
		game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end,
	Min = 1,
	Max = 1000,
	Def = 16
})

local teleport_script = users_tab.Dropdown({
	Text = "Teleports",
	Callback = function(Value)
            if Value == "Beach" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-115, 12, -364)
            elseif Value == "Neighborhood" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1663, 14, 126)
            elseif Value == "Rooftop" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1071, 470, 1046)
            elseif Value == "Spawn" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-12, 14, -234)
            elseif Value == "Boat" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-570, 10, -699)
            elseif Value == "Hospital" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-767, 34, 264)
            elseif Value == "School" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-32, 18, 661)
            elseif Value == "Sommet" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2405, 761, 784)
			elseif Value == "UnderMap" then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(615.089599609375, -45.189701080322266, 2703.698974609375)
            end         
	end,
    Options = {
		"Beach",
		"Neighborhood",
		"Rooftop",
        "Spawn",
        "Boat",
        "Hospital",
        "School",
        "Sommet",
		"UnderMap"
	},
	Menu = {
		Information = function(self)
			main_gui.Banner({
				Text = "Click to teleport to wanted place."
			})
		end
	}
})

--- SCRIPTS Miscellaneous

local rename_script = misc_tab.TextField({
	Text = "Set display name",
	Callback = function(Value)
        game:GetService("ReplicatedStorage").Packages._Index["sleitnick_knit@1.4.4"].knit.Services.CharacterService.RF.EditorCall:InvokeServer("ChangeInfo", Value, game.Players.LocalPlayer.Character.NameTag.Bio.Text)
	end
})

local newbio_script = misc_tab.TextField({
	Text = "Set display bio",
	Callback = function(Value)
        game:GetService("ReplicatedStorage").Packages._Index["sleitnick_knit@1.4.4"].knit.Services.CharacterService.RF.EditorCall:InvokeServer("ChangeInfo", game.Players.LocalPlayer.Character.NameTag.DisplayName.Text,Value)
	end
})

local resize_script = misc_tab.Dropdown({
	Text = "Change size",
	Callback = function(Value)
        game:GetService("ReplicatedStorage").Packages._Index["sleitnick_knit@1.4.4"].knit.Services.CharacterService.RF.EditorCall:InvokeServer("ChangeAge", Value)
	end,
	Options = {
		"Baby",
		"Toddler",
		"Child",
		"Adult"
	},
	Menu = {
		Information = function(self)
			main_gui.Banner({
				Text = "Click to change your size."
			})
		end
	}
})

local stoprain_script = misc_tab.Button({
	Text = "Stop rain",
	Callback = function()
        if #game:GetService("Workspace").Terrain:GetChildren() > 3 then
            game:GetService("Workspace").Camera["__RainEmitter"].RainTopDown.Texture = 0
            game:GetService("Workspace").Camera["__RainEmitter"].RainStraight.Texture = 0
            game:GetService("SoundService")["__RainSoundGroup"].Volume = 0
            local children = game:GetService("Workspace").Terrain:GetChildren() 
            for i = 1, #children do
                local child = children[i]
                if startswith(child.Name, "__") then
                    subchild = child:GetChildren()
                    subchild[1].Texture = 0
                end
            end
        else
            game:GetService("StarterGui"):SetCore("SendNotification",{Title='Error',Text="No rain detected", Duration=3})
        end
	end,
	Menu = {
		Information = function(self)
			main_gui.Banner({
				Text = "This will stop rain and its sounds."
			})
		end
	}
})

local invloader_script = misc_tab.Button({
	Text = "Load Invisible script",
	Callback = function()
        if _G.security == 0 then
		    loadstring(game:HttpGet("https://raw.githubusercontent.com/Kash-001/5194qsd41bq61qs98qb1b87qsg/main/GshgEsdg651sg4ZGQSF18EG.lua", true))()
            _G.security = 1
        else
            game:GetService("StarterGui"):SetCore("SendNotification",{Title='Error',Text="Script already started", Duration=3})
        end
	end
})

--- SPAM DROP SCRIPT
local spamtools_script = spamdrop_tab.Button({
	Text = "Click to show equiped tool name",
	Callback = function()
	    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if v:IsA("Tool") then
                game:GetService("StarterGui"):SetCore("SendNotification",{Title='Tool name',Text=v.Name, Duration=3})
            end
        end
	end
})

local setspamtool_script = spamdrop_tab.TextField({
	Text = "Enter tool name to spam, default is phone",
	Callback = function(Value)
	    if Value == "" then
            _G.tool = "80sPhone"
        else
            _G.tool = Value
        end
	end
})


local enablespam_script = spamdrop_tab.Toggle({
	Text = "Toolspam, keybind : 'R'",
	Callback = function(Value)
        _G.spamtoggle = Value
	end,
	Enabled = false
})

--- SCRIPTS car
local rainbow_car = car_tab.Toggle({
	Text = "Rainbow car",
	Callback = function(Value)
        _G.toggle = Value
		local remote = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_knit@1.4.4"].knit.Services.VehicleService.RE.VehicleRequest
        while _G.toggle do
            remote:FireServer("SetColor", Color3.new(255, 250.27, 0.17134))
    		wait(0.2)
    		remote:FireServer("SetColor", Color3.new(0.0363553, 1, 5.96046e-08))
			wait(0.2)
			remote:FireServer("SetColor", Color3.new(1, 0.092525, 5.96046e-08))
			wait(0.2)
			remote:FireServer("SetColor", Color3.new(1, 0, 0.749503))
			wait(0.2)
			remote:FireServer("SetColor", Color3.new(0.136625, 0.000607252, 1))
			wait(0.2)
			remote:FireServer("SetColor", Color3.new(0, 0.942523, 1))
        end
	end,
	Enabled = false
})

local hornspam_script = car_tab.Toggle({
	Text = "Car horn Spammer",
	Callback = function(Value)
        _G.toggle = Value
        while _G.toggle do
            game:GetService("ReplicatedStorage").Packages._Index["sleitnick_knit@1.4.4"].knit.Services.VehicleService.RE.VehicleRequest:FireServer("Horn", Value)
            wait()
        end
	end,
	Enabled = false
})

local headlightspam_script = car_tab.Toggle({
	Text = "Car headlight Spammer",
	Callback = function(Value)
        _G.toggle = Value
        while _G.toggle do
            game:GetService("ReplicatedStorage").Packages._Index["sleitnick_knit@1.4.4"].knit.Services.VehicleService.RE.VehicleRequest:FireServer("Headlights")
            wait()
        end
	end,
	Enabled = false
})

local changecarcolor_script = car_tab.ColorPicker({
	Text = "Car colour",
	Default = Color3.fromRGB(0,0,0),
	Callback = function(Value)
        game:GetService("ReplicatedStorage").Packages._Index["sleitnick_knit@1.4.4"].knit.Services.VehicleService.RE.VehicleRequest:FireServer("SetColor", Color3.new(Value.R * 255, Value.G * 255, Value.B * 255))
	end,
	Menu = {
		Information = function(self)
			main_gui.Banner({
				Text = "This changes the color of your car."
			})
		end
	}
})

--- SCRIPTS Credits
local credits_krx = credits_tab.Button({
	Text = "Scripting : [dc > kaisenn8#1209] || [tlg > Kash_005]"
})

local credits_lib = credits_tab.Button({
	Text = "UI Library : Kinlei (On Github)"
})

local credits_invscript = credits_tab.Button({
    Text = "Invisible Script : BitingTheDust (On Vermillion)"
})


--coroutine spam tool
game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(KeyPressed)
    if KeyPressed == "r" then
        if _G.spamtoggle == true then
            droptool(_G.tool)
        end
    end
end)

--coroutine chatspy Script
game:GetService("CoreGui").ExperienceChat.appLayout.chatWindow.scrollingView.bottomLockedScrollView.RCTScrollView.RCTScrollContentView.ChildAdded:Connect(function(child)
    if startswith(child.Text, '[') then
        print('SPY : ',string.gsub(child.Text,'<.+>',''))
    end
end)
