include( "shared.lua" )

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