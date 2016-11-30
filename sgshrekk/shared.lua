plugin.unique = "sgshrek"; -- The unique ID of the plugin - this should be lowercase characters only; no spaces or other punctuation.

plugin.name = "Shrek Commands"; -- The display name of the plugin.
plugin.author = "Matthew and Stridey"; -- Author of the plugin.
plugin.version = "1.1"; -- The plugin version.
plugin.description = "An assortment of custom commends added by Matthew and Stridey"; -- A small, quick description.
plugin.permissions = {"1337 L33T", "Explode", "Rocket", "EndRound", "MakeShrek"}; -- A table of permissions to register.



--Function to explode a person
function Explode( ply )
	local explosive = ents.Create( "env_explosion" )
	explosive:SetPos( ply:GetPos() )
	explosive:SetOwner( ply )
	explosive:Spawn()
	explosive:SetKeyValue( "iMagnitude", "1" )
	explosive:Fire( "Explode", 0, 0 )
	explosive:EmitSound( "ambient/explosions/explode_4.wav", 500, 500 )

	ply:StopParticles()
	ply:Kill()
end

--
--1337
--

local command = {}; -- Set up the command table.

command.help = "Dank Punishment for Blazers."; -- A small explanation of the command.
command.command = "1337"; -- The command's ID used in the chat.
command.arguments = {"<player>"}; -- A table of arguments that the command takes.
command.permissions = "1337 L33T"; -- The permission required to use the command. You can use a table to require at least one of many.

if SERVER then
	util.AddNetworkString( "1337Hax" )
end

-- Called when the command has been ran by a player.
function command:Execute(player, bSilent, arguments)
	-- Find a player by the critera specified.
	local target = util.FindPlayer(arguments[1], player);

	-- Do stuff if we found a target.
	if (IsValid(target)) then
		-- check for immunity levels
		if (serverguard.player:GetImmunity(target) > serverguard.player:GetImmunity(player)) then
			-- Notify the player that ran the command that they can't use it on that target.
			serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "This player has a higher immunity than you.");
			return;
		end;

		-- Do whatever you need to do after verifying that you can execute the command.
		net.Start("1337Hax")
		net.Send( target )

		-- If the bSilent argument is not true, then we notify the server that something happened.
		-- When notifying the server, make sure your command is silent when specified! (bSilent will equal true in this case)
		if (!bSilent) then
			-- Note that nil is specified for serverguard.Notify() - signifying to send the notify to all players.
			serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, player:Name(), SERVERGUARD.NOTIFY.WHITE, " has L33T H4X3D ", SERVERGUARD.NOTIFY.RED, target:Name(), SERVERGUARD.NOTIFY.WHITE, ".");
		end;
	end;
end;

-- Called when the command needs an entry in the context menu (right click menu).
function command:ContextMenu(player, menu, rankData)
	-- Add an option to the context menu.
	local option = menu:AddOption("1337 L33T", function()
		-- And do something when the player clicks on it.
		serverguard.command.Run("1337", false, player:UniqueID());
	end);
end;



-- Register the command through the plugin so it can be disabled when the plugin is.
plugin:AddCommand(command);

if CLIENT then

	surface.CreateFont( "cmicsans", {
			font = "Comic Sans",
			size = 34,
			weight = 500,
			antialias = true
		} )

	local endtime = 4*60+30

	net.Receive("1337Hax", function()

		local sicktxt = {
			"dank music m9",
			"L33T H4XS BR0",
			"I am blue",
			"420 blaze it",
			"shiet my haxxor scripts got hacked",
			"mummy get the camera",
			"ready for some disco",
			"swag"
			}

			local txt = ""
			local clr = Color(255,255,255,255)



		local frame = vgui.Create("DFrame")
		frame:SetSize(ScrW(),ScrH())
		frame:SetTitle(" ")
		frame:MakePopup()
		frame:Center()
		frame:SetDraggable( false )
		frame:ShowCloseButton(false)
		frame:SetMouseInputEnabled(false)
		frame:SetKeyboardInputEnabled(false)

		local function danktext()
			 txt = table.Random(sicktxt)
			 clr = Color(math.random(50,255),math.random(50,255),math.random(50,255),255)
			if IsValid(frame) then
				timer.Simple(5,function() danktext() end)
			end
		end
		timer.Simple(16,danktext)
		frame.Paint = function()

			//timer.Simple(14, function()

				surface.SetFont('cmicsans')
				surface.SetTextColor(clr)
				local size = surface.GetTextSize(txt)
				surface.SetTextPos(ScrW()/2-size/2+math.random(-3,3),ScrH()/2+math.random(-3,3))
				surface.DrawText(txt)
			//end)
		end


		local leettbl = {}

		table.insert(leettbl, {
			url = "http://cdn.funnyisms.com/7450a739-447a-4179-861f-64212c5e8b7f.gif",
			sizew = "200",
			sizeh = "200",
			width = 210,
			height = 210
		})

		table.insert(leettbl, {
			url = "http://cdn.funnyisms.com/7450a739-447a-4179-861f-64212c5e8b7f.gif",
			sizew = "200",
			sizeh = "200",
			width = 210,
			height = 210
		})

		table.insert(leettbl, {
			url = "http://cdn.funnyisms.com/7450a739-447a-4179-861f-64212c5e8b7f.gif",
			sizew = "200",
			sizeh = "200",
			width = 210,
			height = 210
		})

		table.insert(leettbl, {
			url = "http://cdn.funnyisms.com/7450a739-447a-4179-861f-64212c5e8b7f.gif",
			sizew = "200",
			sizeh = "200",
			width = 210,
			height = 210
		})

		table.insert(leettbl, {
			url = "http://files.gamebanana.com/img/ico/sprays/547b7a894bcc7.gif",
			sizew = "200",
			sizeh = "200",
			width = 210,
			height = 210
		})

		table.insert(leettbl, {
			url = "http://files.gamebanana.com/img/ico/sprays/547b7a894bcc7.gif",
			sizew = "200",
			sizeh = "200",
			width = 210,
			height = 210
		})

		table.insert(leettbl, {
			url = "http://vignette4.wikia.nocookie.net/mountaindew/images/2/20/CANDIDEW.png/revision/latest?cb=20120223231746",
			sizew = "200",
			sizeh = "89",
			width = 210,
			height = 210
		})

		table.insert(leettbl, {
			url = "http://hydra-media.cursecdn.com/lol-es.gamepedia.com/thumb/d/df/MLG_actual.png/800px-MLG_actual.png?version=e2f27f1d7cb5f5955c9eb3650336c508",
			sizew = "200",
			sizeh = "72",
			width = 210,
			height = 210
		})

		table.insert(leettbl, {
			url = "http://www.wearebaked.com/wp-content/uploads/2012/09/Clear-300x300.png",
			sizew = "200",
			sizeh = "200",
			width = 210,
			height = 210
		})

		table.insert(leettbl, {
			url = "http://www.wearebaked.com/wp-content/uploads/2012/09/Clear-300x300.png",
			sizew = "200",
			sizeh = "200",
			width = 210,
			height = 210
		})

		table.insert(leettbl, {
			url = "http://vignette1.wikia.nocookie.net/logopedia/images/8/89/New_Doritos_Logo.png",
			sizew = "190",
			sizeh = "265",
			width = 265,
			height = 265
		})

		table.insert(leettbl, {
			url = "http://vignette1.wikia.nocookie.net/logopedia/images/8/89/New_Doritos_Logo.png",
			sizew = "190",
			sizeh = "265",
			width = 265,
			height = 265
		})

		table.insert(leettbl, {
			url = "http://img3.wikia.nocookie.net/__cb20140811072057/rwbyfanon/images/7/78/Illuminati-Logo.png",
			sizew = "200",
			sizeh = "200",
			width = 210,
			height = 210
		})





		sound.PlayURL ( "https://www.gizmoandsmudge.co.uk/servers/resources/sound/blue.mp3", "", function( station )
			if ( IsValid( station ) ) then

				if(station:Is3D()) then
					timer.Create("musicfollow", 0.01, 0, function()
						station:SetPos( LocalPlayer():GetPos() )
						station:Set3DFadeDistance( 500, 5000 )
					end)
				end

				station:SetVolume(100)
				station:Play()
				g_station = station

				local md = 1

				timer.Simple(endtime, function()
					hook.Remove("willbluedade")
					timer.Destroy("musicfollow")
					frame:Remove()
					frame = nil
					md = 0
				end)


		timer.Simple(41, function()
			hook.Add("RenderScreenspaceEffects", "willbluedade", function()

				local pl = LocalPlayer();


				local tab = {}
				tab[ "$pp_colour_addr" ] = 0
				tab[ "$pp_colour_addg" ] = 0
				tab[ "$pp_colour_addb" ] = 0
				tab[ "$pp_colour_brightness" ] = 0
				tab[ "$pp_colour_contrast" ] = 1 + md*(math.random(0,0.3))
				tab[ "$pp_colour_colour" ] = 1
				tab[ "$pp_colour_mulr" ] = 0
				tab[ "$pp_colour_mulg" ] = 0
				tab[ "$pp_colour_mulb" ] = 0


					    tab[ "$pp_colour_addb" ] = md*math.random(0,1);
					    tab[ "$pp_colour_addg" ] = md*math.random(0,0.3);
					    tab[ "$pp_colour_addr" ] = md*math.random(0,0.3);

					    DrawColorModify(tab);


			end)
			timer.Create("leethackstime", 0.2, 0, function()

				local add = 80

					for k, v in pairs(leettbl) do


						/*if v.img and v.img:IsValid() then
							v.img:Remove()
							v.img = nil
						end*/


						if(v.panel and v.panel:IsValid()) then
							if(IsValid(frame)) then

							else
								v.panel:Remove()
								v.panel = nil
								//timer.Destroy("leethackstime")
							end

						else
							if(IsValid(frame)) then
							v.panel = vgui.Create("DFrame")

							v.panel:SetSize(v.width+add,v.height+add)
							v.panel:SetTitle(" ")
							v.panel:SetPos(math.random(0, ScrW()-v.panel:GetWide()), math.random(0, ScrH()-v.panel:GetTall()))
							v.panel:MakePopup()
							v.panel:SetDraggable( false )
							v.panel:ShowCloseButton(false)
							v.panel:SetMouseInputEnabled(false)
							v.panel:SetKeyboardInputEnabled(false)
							v.panel.Paint = function()
							end

						 	v.img = vgui.Create("HTML", v.panel)
							v.img:SetSize(v.width+add,v.height+add)
							v.img:SetPos(0, 0)
							v.img:SetHTML('<style>html{width:100%;height:100%;} img {position: absolute;top: 50%;left: 50%; -webkit-animation-name: spin;-webkit-animation-duration: 2000ms; -webkit-animation-iteration-count: infinite; -webkit-animation-timing-function: linear;} @-webkit-keyframes spin { from { -webkit-transform: rotate(0deg); } to { -webkit-transform: rotate(360deg); } } </style><img src="'.. v.url ..'" width="'.. v.sizew ..'" height="'.. v.sizeh ..'" style="margin-top:-'.. v.sizeh/2 ..'px;margin-left:-'.. v.sizew/2 ..'px">')
							end
						end
					end

			end)
		end)

	else

				LocalPlayer():ChatPrint( "Invalid URL!" )

			end
		end )


	end)
end

















--
--Explode
--

local command = {};

command.help		= "Explodes a player.";
command.command 	= "explode";
command.arguments	= {"player"};
command.permissions	= "Explode";
command.immunity 	= SERVERGUARD.IMMUNITY.LESSOREQUAL;

-- Called when the command has been ran by a player.
function command:Execute(player, bSilent, arguments)
	-- Find a player by the critera specified.
	local target = util.FindPlayer(arguments[1], player);

	-- Do stuff if we found a target.
	if (IsValid(target)) then
		-- check for immunity levels
		if (serverguard.player:GetImmunity(target) > serverguard.player:GetImmunity(player)) then
			-- Notify the player that ran the command that they can't use it on that target.
			serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "This player has a higher immunity than you.");
			return;
		end;

		-- Do whatever you need to do after verifying that you can execute the command.
		Explode(target)

		-- If the bSilent argument is not true, then we notify the server that something happened.
		-- When notifying the server, make sure your command is silent when specified! (bSilent will equal true in this case)
		if (!bSilent) then
			-- Note that nil is specified for serverguard.Notify() - signifying to send the notify to all players.
			serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, player:Name(), SERVERGUARD.NOTIFY.WHITE, " has exploded ", SERVERGUARD.NOTIFY.RED, target:Name(), SERVERGUARD.NOTIFY.WHITE, ".");
		end;
	end;
end;

-- Called when the command needs an entry in the context menu (right click menu).
function command:ContextMenu(player, menu, rankData)
	-- Add an option to the context menu.
	local option = menu:AddOption("Explode", function()
		-- And do something when the player clicks on it.
		serverguard.command.Run("explode", false, player:UniqueID());
	end);
end;



-- Register the command through the plugin so it can be disabled when the plugin is.
plugin:AddCommand(command);

--
--Rocket
--

local command = {};

command.help		= "Rockets a player.";
command.command 	= "rocket";
command.arguments	= {"player"};
command.permissions	= "Rocket";
command.immunity 	= SERVERGUARD.IMMUNITY.LESSOREQUAL;

-- Called when the command has been ran by a player.
function command:Execute(player, bSilent, arguments)
	-- Find a player by the critera specified.
	local target = util.FindPlayer(arguments[1], player);

	-- Do stuff if we found a target.
	if (IsValid(target)) then
		-- check for immunity levels
		if (serverguard.player:GetImmunity(target) > serverguard.player:GetImmunity(player)) then
			-- Notify the player that ran the command that they can't use it on that target.
			serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "This player has a higher immunity than you.");
			return;
		end;

		-- Do whatever you need to do after verifying that you can execute the command.
		target:SetMoveType( MOVETYPE_WALK )
		target:SetVelocity( Vector( 0, 0, 4000 ) )
		ParticleEffectAttach( "rockettrail", PATTACH_ABSORIGIN_FOLLOW, target, 0 )

		timer.Simple( 1, function()
			Explode(target)
		end)

		-- If the bSilent argument is not true, then we notify the server that something happened.
		-- When notifying the server, make sure your command is silent when specified! (bSilent will equal true in this case)
		if (!bSilent) then
			-- Note that nil is specified for serverguard.Notify() - signifying to send the notify to all players.
			serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, player:Name(), SERVERGUARD.NOTIFY.WHITE, " has rocketed ", SERVERGUARD.NOTIFY.RED, target:Name(), SERVERGUARD.NOTIFY.WHITE, ".");
		end;
	end;
end;

-- Called when the command needs an entry in the context menu (right click menu).
function command:ContextMenu(player, menu, rankData)
	-- Add an option to the context menu.
	local option = menu:AddOption("Rocket", function()
		-- And do something when the player clicks on it.
		serverguard.command.Run("rocket", false, player:UniqueID());
	end);
end;

-- Register the command through the plugin so it can be disabled when the plugin is.
plugin:AddCommand(command);

--
-- Force Shrek
--

local command = {};

command.help		= "Shreks a player.";
command.command 	= "shrek";
command.arguments	= {"player"};
command.permissions	= "MakeShrek";
command.immunity 	= SERVERGUARD.IMMUNITY.LESSOREQUAL;

-- Called when the command has been ran by a player.
function command:Execute(player, bSilent, arguments)
	-- Find a player by the critera specified.
	local target = util.FindPlayer(arguments[1], player);

	-- Do stuff if we found a target.
	if (IsValid(target)) then
		-- check for immunity levels
		if (serverguard.player:GetImmunity(target) > serverguard.player:GetImmunity(player)) then
			-- Notify the player that ran the command that they can't use it on that target.
			serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "This player has a higher immunity than you.");
			return;
		end;

		-- Do whatever you need to do after verifying that you can execute the command.
		target:SetTeam(1)
		target:Spawn()

		-- If the bSilent argument is not true, then we notify the server that something happened.
		-- When notifying the server, make sure your command is silent when specified! (bSilent will equal true in this case)
		if (!bSilent) then
			-- Note that nil is specified for serverguard.Notify() - signifying to send the notify to all players.
			serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, player:Name(), SERVERGUARD.NOTIFY.WHITE, " has rocketed ", SERVERGUARD.NOTIFY.RED, target:Name(), SERVERGUARD.NOTIFY.WHITE, ".");
		end;
	end;
end;

-- Called when the command needs an entry in the context menu (right click menu).
function command:ContextMenu(player, menu, rankData)
	-- Add an option to the context menu.
	local option = menu:AddOption("Make Shrek", function()
		-- And do something when the player clicks on it.
		serverguard.command.Run("shrek", false, player:UniqueID());
	end);
end;

-- Register the command through the plugin so it can be disabled when the plugin is.
plugin:AddCommand(command);
