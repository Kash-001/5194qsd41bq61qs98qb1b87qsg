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

--- FONCTIONS
function startswith(text, prefix)
    return text:find(prefix, 1, true) == 1
end

--- PAGES MENU
local troll_tab = main_gui.New({
	Title = "troll scripts"
}) 

local users_tab = main_gui.New({
	Title = "Users interactions"
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
        "Sommet"
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
                    child:Destroy()
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

local changecarcolor_script = misc_tab.ColorPicker({
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

--- SCRIPTS troll
local hornspam_script = troll_tab.Toggle({
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

local headlightspam_script = troll_tab.Toggle({
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

--- SCRIPTS Credits
local credits_krx = credits_tab.Button({
	Text = "Scripting : Rapido#1209"
})

local credits_lib = credits_tab.Button({
	Text = "UI Library : https://github.com/Kinlei"
})
