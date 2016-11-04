AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )
include( "player.lua" )

resource.AddWorkshop( "314261589" ) -- Shrek Model
resource.AddWorkshop( "104910430" ) -- Rape Swep

function GM:PlayerInitialSpawn( ply )
	ply:SetTeam(2) --Set Team to Spectators
end

function GM:PlayerDeath( ply )
	ply:SetTeam(2) --Set Team to Spectators
end

function GM:PlayerSpawn( ply )
	if ply:Team() == 2 then
		ply:Spectate(5)
	end
end

function team0( ply ) -- Creating the function.
	ply:UnSpectate() -- As soon as the person joins the team, he get's Un-spectated
	ply:SetTeam( 0 ) -- We'll set him to team 0
	ply:Spawn() -- Let's spawn him.
	ply:SetModel("models/player/group01/male_07.mdl") -- Setting the Hider's PM

end -- End the function
concommand.Add("runner", team0) -- Adding a concommand (Console Command) for the team.


function team1( ply ) -- Creating the function.
	ply:UnSpectate() -- As soon as the person joins the team, he get's Un-spectated
	ply:SetTeam( 1 ) -- We'll set him to team 1
	ply:Spawn() -- Let's spawn him.
	ply:SetModel("models/player/pyroteknik/shrek.mdl") -- Setting Shrek's PM
	ply:SetPlayerColor( Color(57, 133, 27) )
	ply:Freeze (true)	-- Freeze the player
	timer.Simple( 2, function() ply:Freeze(false) end )	-- Unfreeze the player after 60 seconds
	ply:Give ("weapon_rape") -- Equip the player with a hider's gun

end -- End the function
concommand.Add("shrek", team1) -- Adding a concommand (Console Command) for the team.
