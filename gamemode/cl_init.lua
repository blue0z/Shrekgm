include( "shared.lua" )
local circleSmooth = 24
local arcSmoothness = 2.2

function surface.PrecacheArc(cx,cy,radius,thickness,startang,endang,roughness)
	local triarc = {}
	-- local deg2rad = math.pi / 180

	-- Define step
	local roughness = math.max(roughness or 1, 1)
	local step = roughness

	-- Correct start/end ang
	local startang,endang = startang or 0, endang or 0

	if startang > endang then
		step = math.abs(step) * -1
	end

	-- Create the inner circle's points.
	local inner = {}
	local r = radius - thickness
	for deg=startang, endang, step do
		local rad = math.rad(deg)
		-- local rad = deg2rad * deg
		local ox, oy = cx+(math.cos(rad)*r), cy+(-math.sin(rad)*r)
		table.insert(inner, {
			x=ox,
			y=oy,
			u=(ox-cx)/radius + .5,
			v=(oy-cy)/radius + .5,
		})
	end


	-- Create the outer circle's points.
	local outer = {}
	for deg=startang, endang, step do
		local rad = math.rad(deg)
		-- local rad = deg2rad * deg
		local ox, oy = cx+(math.cos(rad)*radius), cy+(-math.sin(rad)*radius)
		table.insert(outer, {
			x=ox,
			y=oy,
			u=(ox-cx)/radius + .5,
			v=(oy-cy)/radius + .5,
		})
	end


	-- Triangulize the points.
	for tri=1,#inner*2 do -- twice as many triangles as there are degrees.
		local p1,p2,p3
		p1 = outer[math.floor(tri/2)+1]
		p3 = inner[math.floor((tri+1)/2)+1]
		if tri%2 == 0 then --if the number is even use outer.
			p2 = outer[math.floor((tri+1)/2)]
		else
			p2 = inner[math.floor((tri+1)/2)]
		end

		table.insert(triarc, {p1,p2,p3})
	end

	-- Return a table of triangles to draw.
	return triarc

end

function surface.DrawArc(arc)
	for k,v in ipairs(arc) do
		surface.DrawPoly(v)
	end
end

function draw.Arc(cx,cy,radius,thickness,startang,endang,roughness,color)
	surface.SetDrawColor(color)
	surface.DrawArc(surface.PrecacheArc(cx,cy,radius,thickness,startang,endang,roughness))
end

function DrawCircleProgress(x, y, size, passes, width, margin, cur, max, color)
	local sin,cos,rad = math.sin,math.cos,math.rad --it slightly increases the speed.

	surface.SetMaterial(Material("vgui/white.vtf"))
	surface.SetDrawColor( color )

	--for a = 0, math.Clamp( LocalPlayer():Health() / (100/passes), 0, passes - 1 ) do
	local b = math.Clamp( cur / (max/passes), 0, passes - 1 )


	lb = Lerp(FrameTime()*4, (lb or b), b)
	if cur == 1 and max == 1 then
		lb = b
	end
	for a = 0, lb do
			surface.DrawTexturedRectRotated( x + cos( rad( -a * 360/passes + 90 ) ) * (size - width/2 - margin), y - sin( rad( -a * 360/passes + 90) ) * (size - width/2 - margin), width, 7 + sin( rad(360/passes) ) * width * 2, -a * 360/passes + 90 )
	end
end

function draw.Circle( x, y, radius, seg )
	local cir = {}

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 ) -- This is need for non absolute segment counts
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

	surface.DrawPoly( cir )
end

function TeamMenu(  ) -- Starting the function.

// all the buttons I'm about to create are just a simple way to explain everything. I would make a table and make buttons that way but look through some more tutorials about loops till you do that.
local TeamMenu = vgui.Create( "DFrame" ) -- Creating the Vgui.
TeamMenu:SetPos( ScrW() +250, ScrH() / 2 -200 ) -- Setting the position of the menu.
TeamMenu:SetSize( 260, 210 ) -- Setting the size of the menu.
TeamMenu:SetTitle( "My test team selection menu" ) -- The menu title.
TeamMenu:ShowCloseButton( false ) -- Want us to see the close button? No.
TeamMenu:SetVisible( true ) -- Want it visible?
TeamMenu:SetDraggable( false ) -- Setting it draggable?
TeamMenu:MakePopup( ) -- And now we'll make it popup
function TeamMenu:Paint() -- This is the funny part. Let's paint it.
	draw.RoundedBox( 8, 0, 0, self:GetWide(), self:GetTall(), Color( 0,0,0,200 ) ) -- This paints, and round's the corners etc.
end -- Now we ONLY end the painting function.

-- This is a part which I had to add for the fun sake.

if !TeamMenu.Open then --  If the menu is closed, then
	TeamMenu:MoveTo(ScrW() / 2 - 250,  ScrH() / 2 - 200, 1.6, 0,1) -- When you open it, it will slide trough the screen, not teleport.
end -- Ending the if statement

-- Button time.
local runner = vgui.Create( "DButton", TeamMenu ) --Creating the vgui of the button.
runner:SetPos( 5, 30 ) -- Setting the position.
runner:SetSize( 250, 30 ) -- Setting the size
runner:SetText( "Runners" ) -- Setting the text of the button

runner.Paint = function() -- The paint function
    surface.SetDrawColor( 0, 0, 150, 255 ) -- What color do You want to paint the button (R, B, G, A)
    surface.DrawRect( 0, 0, runner:GetWide(), runner:GetTall() ) -- Paint what cords
end -- Ending the painting

runner.DoClick = function() --Make the player join team 1
	RunConsoleCommand( "runner" )
	TeamMenu:Close() -- Close the DFrame (TeamMenu)
end -- Ending the button.

-- Now, this will be going on for 3 other buttons.
local shrek = vgui.Create( "DButton", TeamMenu )
shrek:SetPos( 5, 70 )
shrek:SetSize( 250, 30 )
shrek:SetText( "Shrek" )

shrek.Paint = function() -- The paint function
	surface.SetDrawColor( 0, 255, 0, 255 ) -- What color do You want to paint the button (R, B, G, A)
	surface.DrawRect( 0, 0, shrek:GetWide(), shrek:GetTall() ) -- Paint what cords (Used a function to figure that out)
end

shrek.DoClick = function() --Make the player join team 2
	RunConsoleCommand( "shrek" )
	TeamMenu:Close()
end

-- Here we are, the close button. The last button for this, because this is used instead of ShowCloseButton( false )
local close_button = vgui.Create( "DButton", TeamMenu )
close_button:SetPos( 5, 185 )
close_button:SetSize( 250, 20 )
close_button:SetText( "Close this menu" )

close_button.Paint = function()
    draw.RoundedBox( 8, 0, 0, close_button:GetWide(), close_button:GetTall(), Color( 0,0,0,225 ) )
    surface.DrawRect( 0, 0, close_button:GetWide(), close_button:GetTall() )
end

close_button.DoClick = function()
    TeamMenu:Close()
end

 end -- Now we'll end the whole function.
concommand.Add("TeamMenu", TeamMenu) -- Adding the Console Command. So whenever you enter your gamemode, simply type TeamMenu in console.

hook.Add( "HUDPaint", "HUDPaint_Timer", function()
	local TimeLeft = GetGlobalInt( "TimeLeft", 0 )
	local TimeTotal = GetGlobalInt( "TimeTotal", 0 )
	local RunnersRemain = GetGlobalInt( "RunnersRemain", 0 )
	local Shrek = GetGlobalString( "ShrekName", "no shirk" )
	local plyTeam = LocalPlayer():Team()
	local cin = (math.sin(CurTime()) + 1) / 2

	local time = TimeTotal - TimeLeft

	local minutes = math.floor(TimeLeft / 60)
	local sec = TimeLeft - (minutes * 60)
	local dots = ":"

	if sec < 10 then
		dots = ":0"
	end

	local actualtime = tonumber(minutes) .. dots .. tonumber(sec)

	surface.SetDrawColor( 0, 0, 0, 120 )
	draw.NoTexture()
	draw.Circle( ScrW()/2, 35, 30, circleSmooth )

	local procent = (TimeLeft/TimeTotal) * 360
	lerpedArc = Lerp(3 * FrameTime(), (lerpedArc or procent), procent)
	local clr = Color(255,255,255,255)
	if TimeLeft < 11 then
		clr = Color(100 + (cin * 255), cin * 40, cin * 40, 255)
	end

	draw.Arc(ScrW()/2, 35, 30, 5, lerpedArc + 90, 450, arcSmoothness, clr)


	draw.SimpleText(actualtime, "Trebuchet24", ScrW()/2, 23, clr, TEXT_ALIGN_CENTER)

	if RunnersRemain == 1 then
		rest = " Runner Remains"
	else
		rest = " Runners Remain"
	end
	draw.SimpleText(RunnersRemain..rest, "DermaLarge", ScrW()/2, 65, clr, TEXT_ALIGN_CENTER)

	TeamInfo = "You smell!"
	if plyTeam == 1 then
		TeamInfo = "You are SHREK!"
	elseif plyTeam == 2 then
		TeamInfo = "You are a SPECTATOR!"
	else
		TeamInfo = "You are a HIDER!"
	end


	draw.SimpleText(TeamInfo, "DermaLarge", 5, 5, Color(255, 255, 255, 255))

	draw.SimpleText("If you get stuck/glitched or Shrek dies, run !unstuck.", "Trebuchet24", 5, ScrH()-28, Color(255, 255, 255, 255))

	surface.SetFont( "Trebuchet24" )
	local message = "#1 Shrek Chase Server!"
	local width, height = surface.GetTextSize( message )

	draw.SimpleText(message, "Trebuchet24", ScrW()-width-5, ScrH()-28, Color(255, 255, 255, 255))
end )

local hide = {
	CHudHealth = true,
	CHudBattery = true,
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then return false end

	-- Don't return anything here, it may break other addons that rely on this hook.
end )

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





	sound.PlayURL ( "https://www.gizmoandsmudge.co.uk/music/blue.mp3", "", function( station )
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
