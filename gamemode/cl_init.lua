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

	draw.SimpleText("Shrek: "..Shrek, "DermaLarge", 5, 5, Color(255, 255, 255, 255))
	draw.SimpleText("If you get stuck/glitched or Shrek dies, run !unstuck.", "Trebuchet24", 5, ScrH()-28, Color(255, 255, 255, 255))
end )

local hide = {
	CHudHealth = true,
	CHudBattery = true,
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then return false end

	-- Don't return anything here, it may break other addons that rely on this hook.
end )
